Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0804D11C9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245723AbiCHIMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344933AbiCHILs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:11:48 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B479B3EBAF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 00:10:51 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220308081049epoutp010ca70e6fbeb030d3f689bfe5e715e180~aWYbGQAMv0811108111epoutp01i
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:10:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220308081049epoutp010ca70e6fbeb030d3f689bfe5e715e180~aWYbGQAMv0811108111epoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646727049;
        bh=xEcSpHVDKjzosO1TE32lx3HNTcFA/JVAUI7y3N9XrlY=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=cGs1tOnWJ4I6R0xqUxyN8hbAbn42NrXOI1UR1GGt7gHMPf2c9eu2tqR4c2ZfeR6Yv
         simTroA/GaK2E/BdZSX8zEeMki5BL3VBeEVsfTnjnS1gUdiwUCxqwnK678foMGX+wl
         roz/CS1f3WANVkz0XRC/yF3hVPQ4sXoNHIEB0NFA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220308081048epcas2p3630f3a03dc05cbd339de172c2b0dd151~aWYavbbwM0585005850epcas2p3M;
        Tue,  8 Mar 2022 08:10:48 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.101]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KCSgk3c3Rz4x9QM; Tue,  8 Mar
        2022 08:10:42 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        42.76.33036.1BC07226; Tue,  8 Mar 2022 16:58:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220308081032epcas2p4268212cd3766c952ce91ea77d45e9fcd~aWYLq_b2X2303623036epcas2p4m;
        Tue,  8 Mar 2022 08:10:32 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220308081032epsmtrp1ad11845e74c425925be0d6866dcf0117~aWYLpzqTi2150621506epsmtrp1F;
        Tue,  8 Mar 2022 08:10:32 +0000 (GMT)
X-AuditID: b6c32a48-4fbff7000000810c-56-62270cb16c1f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DC.C5.29871.87F07226; Tue,  8 Mar 2022 17:10:32 +0900 (KST)
Received: from KORCO011456 (unknown [10.229.18.123]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220308081032epsmtip15ccb9e17d1e0c29d31c1f2659138c473~aWYLdD3bY2616726167epsmtip1V;
        Tue,  8 Mar 2022 08:10:32 +0000 (GMT)
From:   "Kiwoong Kim" <kwmad.kim@samsung.com>
To:     "'Adrian Hunter'" <adrian.hunter@intel.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <beanhuo@micron.com>, <cang@codeaurora.org>, <sc.suh@samsung.com>,
        <hy50.seo@samsung.com>, <sh425.lee@samsung.com>,
        <bhoon95.kim@samsung.com>, <vkumar.1997@samsung.com>
In-Reply-To: <52bbbd92-17d4-a5ea-150e-28cf56bb0a67@intel.com>
Subject: RE: [RESEND PATCH v1] scsi: ufs: exclude UECxx from SFR dump list
Date:   Tue, 8 Mar 2022 17:10:32 +0900
Message-ID: <017301d832c3$fb59d690$f20d83b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQGliURthW9IIEPdWyhSjpWWHipcLgIFdXJ5AgAX5xis+khE8A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBJsWRmVeSWpSXmKPExsWy7bCmqe5GHvUkg2ONmhYnn6xhs3gwbxub
        xcufV9ksDj7sZLH4uvQZq8Wn9ctYLVYvfsBisejGNiaLy7vmsFl0X9/BZrH8+D8mi667Nxgt
        lv57y2Jx5/5HFgc+j8t9vUwei/e8ZPKYsOgAo8f39R1sHh+f3mLx6NuyitHj8yY5j/YD3UwB
        HFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAhysp
        lCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL89L18lJLrAwNDIxMgQoT
        sjMmvPrCWvCSueLX3K+sDYyfmboYOTkkBEwk1l+4yt7FyMUhJLCDUWL65utMEM4nRol5W3sY
        QaqEBL4xSixY7Q7TMenqOjaIor2MEuc7DzJCOC8ZJQ6cmscOUsUmoC0x7eFuVpCEiEA7s8SV
        jWdZQRKcArYSf892g40VFvCSeLN6ITOIzSKgInF86WKwo3gFLCUWn+hihLAFJU7OfMICYjMD
        DV228DUzxBkKEj+fLmOFiItIzO5sA4pzAC1zkujpcgfZKyFwhUOi5d4vNoh6F4lv345DPS0s
        8er4FnYIW0riZX8bO0ivhECxxKZ98hC9DYwSSz5tZoGoMZaY9aydEaSGWUBTYv0ufYhyZYkj
        t6Au45PoOPwXagqvREebEESjssSvSZMZIWxJiZk370At9ZA4snI24wRGxVlIfpyF5MdZSP6a
        hbB3ASPLKkax1ILi3PTUYqMCE3hcJ+fnbmIEJ2ktjx2Ms99+0DvEyMTBeIhRgoNZSYT3/nmV
        JCHelMTKqtSi/Pii0pzU4kOMpsBQn8gsJZqcD8wTeSXxhiaWBiZmZobmRqYG5krivF4pGxKF
        BNITS1KzU1MLUotg+pg4OKUamFaaM6y85rK2R/xiJueUsAutnme9Dz6b/zwjzetVXMf9aYuT
        jeIaTwv8PdVQ7XB4g4D4HfZzFYev90hYeJ+d++1Oi6+l68a1BksyDc3OW50zV1gcbzxR/uj2
        by+kmH0/R6rdk+M4MHWTzTdjdx0rk5lSjnyLz6rEXvWZzRdUxq+0a6VJ+JLXjrnH9kuU3D+2
        tXrz6udpUaq6a+5Nyd/Cn5G+ZJJP6Z+4byfO+JbO2e1nt7rR3S9q59Tgmue3FspGTpTSXvl1
        hYeI2/cFu5f+fWVf9t246GHJXl8JXzvPRYuqJc44XsvbFR+Q7ynEO3XxeqM5WgFuTzSVnb6a
        xRwwj7eeV3QvQtm4q4XNmuFTtBJLcUaioRZzUXEiAKTQK31bBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSnG4Fv3qSwc9bshYnn6xhs3gwbxub
        xcufV9ksDj7sZLH4uvQZq8Wn9ctYLVYvfsBisejGNiaLy7vmsFl0X9/BZrH8+D8mi667Nxgt
        lv57y2Jx5/5HFgc+j8t9vUwei/e8ZPKYsOgAo8f39R1sHh+f3mLx6NuyitHj8yY5j/YD3UwB
        HFFcNimpOZllqUX6dglcGZM+fWIpeM5c8frHY/YGxo9MXYycHBICJhKTrq5j62Lk4hAS2M0o
        cfJsPytEQlLixM7njBC2sMT9liNgcSGB54wS86aYgNhsAtoS0x7uZgVpFhGYziyx9+5HRohJ
        JxkldtzuZwep4hSwlfh7thtskrCAl8Sb1QuZQWwWARWJ40sXg53BK2ApsfhEFyOELShxcuYT
        FhCbGWhD78NWRhh72cLXzBAXKUj8fLqMFSIuIjG7sw0ozgF0hZNET5f7BEahWUgmzUIyaRaS
        SbOQdC9gZFnFKJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7iREcm1qaOxi3r/qgd4iRiYPx
        EKMEB7OSCO/98ypJQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgsky
        cXBKNTDt+sx9IkCSJfPY4d4AA7bmKNe2KUe3BL5lXSg+0f3Yh5eptdOYGKMYKg8p79qkvqbf
        41Pbg+s2CfUuwT+Mrt6Lq576qHqR2vne+PwfEUw2Nk9u1P6968o8d0EeU/Glhz9mlhUp5z1N
        Tk1Xtd2dEZF5vO1z9/XJy+5dq41r8U65wVBWKX304KoXh9tvTZ6wZ2FY3S6h+ZkvlU7ofJy2
        a4lG88zWQ7oHNV51bsidvfDIzHONP/fzTr7okfku2PJQ6P1nkf/jrrG6Vmg8ZPzBn3Z8ab7K
        2sVP2kuueq1sz77j46z6taMh/Vy3RFCSmXcS58e3uVniH37nfgqczaCmIG3mXHfIPe9Xn9gx
        jq7JM3yVWIozEg21mIuKEwGf7pHWPAMAAA==
X-CMS-MailID: 20220308081032epcas2p4268212cd3766c952ce91ea77d45e9fcd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220307024436epcas2p1cb5b07d5149b37610819fa3d70af59ea
References: <CGME20220307024436epcas2p1cb5b07d5149b37610819fa3d70af59ea@epcas2p1.samsung.com>
        <1646621010-118886-1-git-send-email-kwmad.kim@samsung.com>
        <52bbbd92-17d4-a5ea-150e-28cf56bb0a67@intel.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > -	for (pos =3D 0; pos < len; pos +=3D 4)
> > +	for (pos =3D 0; pos < len; pos +=3D 4) =7B
> > +		if (pos >=3D REG_UIC_ERROR_CODE_PHY_ADAPTER_LAYER	&&
> > +		    pos <=3D REG_UIC_ERROR_CODE_DME)
>=20
> Doesn't that need to be 'pos + offset' not just 'pos'
>=20

For only ufshcd.c, offset is always zero, so 'offset' doesn't need to be re=
ferred to.
But now I think the function is currently public to external modules.

Okay, let me modify this.

Thanks.
Kiwoong Kim

