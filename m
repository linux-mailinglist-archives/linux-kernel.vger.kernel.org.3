Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B752D4B633E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 07:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbiBOGDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 01:03:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiBOGDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 01:03:45 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2D2C4B65
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 22:03:34 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220215060329epoutp03603be276507613556a8232215e26441c~T4GP-CvjY1807218072epoutp03h
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:03:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220215060329epoutp03603be276507613556a8232215e26441c~T4GP-CvjY1807218072epoutp03h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644905009;
        bh=l/tuDcqbcvlzpI0UVW5GWhgjOGzEwtl1XwGEDLmHnl4=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=cWjLF6nfGaLWtXoYF+ZA0OVtilw+wporERqGTCJ3k0YiRk40KN9H8XwLMumedKRM7
         loDnF3TKIYa8W4WeOldYcdswX7gYy6eKmXFl+W4Nzlft64/Fa/+odjBBR99+l37nLY
         C250CPE412yacEItt7b4FdZYA4d8PPXTSKupp0u0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220215060327epcas2p4b0e57a32b82ce55ccefaede5742ce536~T4GOmAWo50347103471epcas2p48;
        Tue, 15 Feb 2022 06:03:27 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.101]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JyVrZ1Q2Gz4x9Q7; Tue, 15 Feb
        2022 06:03:26 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2B.39.35137.C614B026; Tue, 15 Feb 2022 15:00:12 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220215060325epcas2p4238dd2ab583ad0bbc301baa8ce68df9a~T4GMuFO6A0182101821epcas2p4O;
        Tue, 15 Feb 2022 06:03:25 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220215060325epsmtrp28a684999c0fc9f387facc6b2d6fd133d~T4GMs6xQr2769127691epsmtrp2C;
        Tue, 15 Feb 2022 06:03:25 +0000 (GMT)
X-AuditID: b6c32a46-da1ff70000018941-1e-620b416c35fb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        32.AE.08738.D224B026; Tue, 15 Feb 2022 15:03:25 +0900 (KST)
Received: from KORCO011456 (unknown [10.229.18.123]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220215060325epsmtip2ff17a5a5abc6360a754b12b54a32f3a1~T4GMdLYEc0332903329epsmtip2g;
        Tue, 15 Feb 2022 06:03:25 +0000 (GMT)
From:   "Kiwoong Kim" <kwmad.kim@samsung.com>
To:     "'Bart Van Assche'" <bvanassche@acm.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <beanhuo@micron.com>, <cang@codeaurora.org>,
        <adrian.hunter@intel.com>, <sc.suh@samsung.com>,
        <hy50.seo@samsung.com>, <sh425.lee@samsung.com>,
        <bhoon95.kim@samsung.com>, <vkumar.1997@samsung.com>
In-Reply-To: <62a5170b-48c0-a372-5392-08f5112d7a06@acm.org>
Subject: RE: [PATCH v1] scsi: ufs: remove clk_scaling_lock when clkscaling
 isn't supported.
Date:   Tue, 15 Feb 2022 15:03:25 +0900
Message-ID: <007e01d82231$be8be250$3ba3a6f0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQI4IgZMS69T+T+3eQm0GbWo6Fi0ygFitYZoAW3RkECrvZmasA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEJsWRmVeSWpSXmKPExsWy7bCmmW6OI3eSwZ1tVhYnn6xhs3gwbxub
        xcufV9ksDj7sZLH4uvQZq8W0Dz+ZLT6tX8ZqsXrxAxaLRTe2MVlc3jWHzaL7+g42i+XH/zFZ
        dN29wWix9N9bFos79z+yOPB7XL7i7XG5r5fJY/Gel0weExYdYPT4vr6DzePj01ssHn1bVjF6
        fN4k59F+oJspgDMq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnF
        J0DXLTMH6AMlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToF5gV5xYm5xaV66Xl5q
        iZWhgYGRKVBhQnbG7Hl9zAVT2SpW/jvD1MD4naWLkZNDQsBE4t2xFcxdjFwcQgI7GCUmXlwA
        5XxilFi95BY7hPOZUeLso6vsMC3zTj9jgUjsYpRYtWEXG4TzklFixq6dbCBVbALaEtMe7mYF
        SYgIzGeW+HJ+EStIglPAWuLa36WMILawQKzEje3XwRpYBFQlXmw7BLaCV8BSYvvZDYwQtqDE
        yZlPwK5lBhq6bOFrZogzFCR+Pl3GChEXkZjd2QYWFxFwkvj57gATyGIJgTscEqc6n7BBNLhI
        PJ3TywRhC0u8Or4F6h8pic/v9gLVcADZxRKb9slD9DYwSiz5tBkaTMYSs561M4LUMAtoSqzf
        pQ9Rrixx5BbUaXwSHYf/skOEeSU62oQgGpUlfk2azAhhS0rMvHkHqsRDonNR1gRGxVlIfpyF
        5MdZSP6ahbB2ASPLKkax1ILi3PTUYqMCI3hkJ+fnbmIEJ24ttx2MU95+0DvEyMTBeIhRgoNZ
        SYQ37ixnkhBvSmJlVWpRfnxRaU5q8SFGU2CoT2SWEk3OB+aOvJJ4QxNLAxMzM0NzI1MDcyVx
        Xq+UDYlCAumJJanZqakFqUUwfUwcnFINTDx9NU4ptbmv+iYKRNsbXCrU9ud69eZNt4xEV0qg
        xJuWbwmfrnbUH5ijnrs89mNT/Z02Hef931q4JXM/zrKP/P+jRfBdq8CKVLWFzJ/dNsYmrpuq
        ValyP+a53f2TjaGnYt/9VZ62d5/Cjdu60mtnH2FxOru2aMIvGdkvJxdJCshHJXb6HfiwWYNf
        +OtPhnmMz64b2z+ob02btyib5Uv4x5XPPL8uDZefO+dLdXNclfAxdY7U/ZOKYk706HjxOmgv
        s4v8tT9DTuWl6utvNx/IG7zlTPTsqdWKb4xj911/kPXHf077V67/SpkDPj762zDH+Pbt4DVW
        OtwnN6obiK91lNzzjvP5PRONzOriiFPLlViKMxINtZiLihMBerR7tGUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsWy7bCSvK6uE3eSwddLYhYnn6xhs3gwbxub
        xcufV9ksDj7sZLH4uvQZq8W0Dz+ZLT6tX8ZqsXrxAxaLRTe2MVlc3jWHzaL7+g42i+XH/zFZ
        dN29wWix9N9bFos79z+yOPB7XL7i7XG5r5fJY/Gel0weExYdYPT4vr6DzePj01ssHn1bVjF6
        fN4k59F+oJspgDOKyyYlNSezLLVI3y6BK+PeprssBdPZKvZMmcncwPiVpYuRk0NCwERi3uln
        QDYXh5DADkaJ3o4r7BAJSYkTO58zQtjCEvdbjrBCFD1nlNh58wUrSIJNQFti2sPdYAkRgY3M
        EmvbHjBCVB1jlGjcs4oNpIpTwFri2t+lYKOEBaIltk/4yQRiswioSrzYdghsHa+ApcT2sxsY
        IWxBiZMzn4Ddxwy0ofdhKyOMvWzha2aIkxQkfj5dxgoRF5GY3dkGFhcRcJL4+e4A0wRGoVlI
        Rs1CMmoWklGzkLQvYGRZxSiZWlCcm55bbFhglJdarlecmFtcmpeul5yfu4kRHLFaWjsY96z6
        oHeIkYmD8RCjBAezkghv3FnOJCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGan
        phakFsFkmTg4pRqYZAoFq3bL+UWfitjbOkd/5tFE3o0ca9xi43W7VBorAy6+Ni17c3bftJuV
        EZOXiume1GWZFFye93JTUcuzxLKathOXYnfJiaxJesE1e/OF1NOLBELfNU/6mzu5JcX36Kw5
        F3Kkr2cvLHLqM1hre/jQpbAI67tvha4rLF2/iq/n1f8X2Yl2TPWe2rMurHu8n4tvrchr3TMG
        1aXKS1dpTX88kfXvQ/vYOk0mt+0+arXeLxv3HHnRfyvY7uvft1tE7ZdXC7wWWq5/wti5SNSn
        Q7S8flP0ph+vfklbOZ4I+fkhNvHJOX2RZeaxHyu3P63mTl34W+ZbTkGC1JeHPAsyJ35104z8
        +Xbfk4mPklquC7w9qcRSnJFoqMVcVJwIAG+uwddHAwAA
X-CMS-MailID: 20220215060325epcas2p4238dd2ab583ad0bbc301baa8ce68df9a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220205074128epcas2p40901c37a7328e825d8697f8d3269edba
References: <CGME20220205074128epcas2p40901c37a7328e825d8697f8d3269edba@epcas2p4.samsung.com>
        <1644046760-83345-1-git-send-email-kwmad.kim@samsung.com>
        <62a5170b-48c0-a372-5392-08f5112d7a06@acm.org>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > -	down_read(&hba->clk_scaling_lock);
> > +	if (ufshcd_is_clkscaling_supported(hba))
> > +		down_read(&hba->clk_scaling_lock);
> >
> >   	lrbp =3D &hba->lrb=5Btag=5D;
> >   	WARN_ON(lrbp->cmd);
>=20
> I don't like this patch at all. This patch makes testing the UFS driver
> more complicated without having any clear benefit. Additionally, adding
> if-statements in front of locking makes static source code analysis harde=
r
> and is an anti-pattern. Please don't do this.
>=20
> Bart.=20

The benefit that I think is not blocking dev cmd during submitting a scsi c=
md.
Rather, I don't understand why this lock is required if a SoC doesn't suppo=
rt clk scaling.

The period of ringing doorbells has been already protected by spin lock.

Thanks.
Kiwoong Kim

