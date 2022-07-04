Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3E6565314
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbiGDLLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbiGDLLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:11:32 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64640FD38
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 04:11:31 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220704111127epoutp03dd7e1ee59d61f0bb3151e7444f92f142~_m91UZdhA0493904939epoutp03p
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 11:11:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220704111127epoutp03dd7e1ee59d61f0bb3151e7444f92f142~_m91UZdhA0493904939epoutp03p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656933087;
        bh=MBaAC2e5dlkyADh466Zv2yQuBKVoqkAN1PvG3nn8Frk=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=vFJ75TblL8TpAIJpkdyFh0W6lTZV/MLV+hu4HG9thT200ibngCF2zdzsSw9/mx/y+
         1D57wFABnYeK7mM53YS6tQLPF+MRhS3K6sx9TRfODitth+pR4GM3w7kee3k1f6vhOg
         UBMqoWDG0t5wSEsWFqGNJE1J8hYFciJ9oAzdIaB8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220704111126epcas1p472f71b1331a135732f96ec8f4be2f8f9~_m90HZReB2981729817epcas1p43;
        Mon,  4 Jul 2022 11:11:26 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.242]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Lc35p0wKMz4x9Q4; Mon,  4 Jul
        2022 11:11:26 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A8.8E.09633.DDAC2C26; Mon,  4 Jul 2022 20:11:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20220704111125epcas1p3259f5321de81735c86cc9b22615456d9~_m9zBQvAs0610606106epcas1p3Z;
        Mon,  4 Jul 2022 11:11:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220704111125epsmtrp2d27b89c3d7ec5659f0c8174ce11ec1aa~_m9zAQnCB1500915009epsmtrp2M;
        Mon,  4 Jul 2022 11:11:25 +0000 (GMT)
X-AuditID: b6c32a36-05fff700000025a1-ef-62c2cadd031d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.68.08905.DDAC2C26; Mon,  4 Jul 2022 20:11:25 +0900 (KST)
Received: from sh043lee03 (unknown [10.253.101.72]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220704111125epsmtip194f49f14b662c6ec4eef9764e711b44a~_m9yxo1Od0212102121epsmtip1W;
        Mon,  4 Jul 2022 11:11:25 +0000 (GMT)
From:   "Seunghui Lee" <sh043.lee@samsung.com>
To:     <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <bvanassche@acm.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Cc:     <grant.jung@samsung.com>, <jt77.jang@samsung.com>,
        <dh0421.hwang@samsung.com>, <junwoo80.lee@samsung.com>,
        <jangsub.yi@samsung.com>, <cw9316.lee@samsung.com>,
        <sh8267.baek@samsung.com>, <wkon.kim@samsung.com>,
        <seunghwan.hyun@samsung.com>
In-Reply-To: <20220630044804.6080-1-sh043.lee@samsung.com>
Subject: RE: [PATCH] scsi: ufs: no sw reset after last linkstartup fail
Date:   Mon, 4 Jul 2022 20:11:25 +0900
Message-ID: <000001d88f96$ccd299d0$6677cd70$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI5aYjeE/9Eh4/d2WnB5RXwuc7qWwHvC5v0rJzc7OA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUwbdRj2d9deD5K6W8fYz6q1HDNuU6At0F1xLMwxbAJ/kEg0WZx40LMg
        /Vqv1SnJgmOWbwJbBlLHcBt2pEbZEBlrnAE2hQ42ycrXME5kENcJ2BUZg2XMtleV/57neZ83
        7/P+PnBUNICJ8UKDhTEbaB2JRfK6rmyXxd2+1pcnu1MKqKlTXRjlXRnFqAbfCkp9ds3Gp34Y
        cwuo1cftAqr8u+MIdWaiC6G6/xgSUK7HpQjlcZ3EqKrxbow617+GUDfcfj41NjTAp769+YCX
        Rqg9I5nqujM9QH1/dpKnru10AvVih0Rd1lOFZGP7i3YVMLSGMUsZQ75RU2jQppKZb+TuzU1W
        yuRxchW1k5QaaD2TSqZnZcdlFOoCuUnpB7TOGpCyaZYlE3bvMhutFkZaYGQtqSRj0uhMSlM8
        S+tZq0Ebb2AsKXKZTJEcML5bVNDrcwtMt0SHqqdKBSXg6oZKgOOQSII/LW+pBJG4iOgGsP6r
        o3yO+AEsn7aFyQMA7VM1ARIR6rh+9QLKFS4D+LDzBMKRuwCeP7qEBl0Y8Qqc8z8JdUQRPQD2
        /qoMmlBiFcATnpOCYCGCSIGNow9DeBPxOmz8tAUEMY/YCo/fG0CDAYWECnbUbQ7KQmIjdDfN
        8IIYJV6GjtN/olwiKVyZdYRnpcD7Lg/gPFHw8wpbKCkkZnDoKJkScA3psKFsCXB4E7zX3xnW
        xXBx4TLGYRba1tbCAw7B3tq/wzgR+hcXQTAbSmyH7a4ETo6Blx41h+c+DReWqvnc+QphuU3E
        WWKhd9qBcPgZ2Fo2idYB0r5uM/u6zezrNrD/P+wLwHOCaMbE6rUMKzcp/rvsfKO+A4Se9A5l
        Nzg274vvAwgO+gDEUTJK6DzWmycSauiPPmbMxlyzVcewfSA5cNT1qHhzvjHwJwyWXHmSSpak
        VCRRiapEJblF6GwYpEWElrYwRQxjYsz/9iF4hLgEeW/+tYv+5tSf98XE9rxVMexr09sm/Yc7
        57x1tXfaVm9ljH/jf+p0pvqg+tXhl45sXMMnnr/03NCPzpFOyV1pVuJvzRZva47ERdY3qlqq
        BjRLzgqP4v0jZ7VFf7W87RWLs6O3HV7cmSDZL0iaSHW8kFVf9OhZpHf4yxmM3p3TLx6OMa+k
        lVj2DPqHVrbW/rItRa8ddfjcVyKLqXJfE65/s2YKtH44HX/KLXJZ85h9DknD+eXC4j2/Kyrf
        MehqNnx/YHj2wsEX1ZJzIPl2bPuyfa8tbrC/yzm+cPZra7E9Y3okp0zK499sm75+YL4soa8J
        GxtLi6z0PIlezVF+Mncj/WI1yWMLaPkO1MzS/wCpvwAWWwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsWy7bCSnO7dU4eSDG6v5Ld4MG8bm8XLn1fZ
        LKZ9+MlsMeNUG6vFvmsn2S1+/V3PbtGxdTKTxaIb25gsdjw/w26x628zk8XlXXPYLLqv72Cz
        WH78H5PFuZOfWC2unTnBarH50jcWBwGPy1e8PSYsOsDo8fHpLRaPvi2rGD0+b5LzaD/QzRTA
        FsVlk5Kak1mWWqRvl8CVcfuMT8EqoYp3346yNDD283cxcnJICJhInD2ykbmLkYtDSGA3o8Sd
        jfNZIBKSEosfPWTrYuQAsoUlDh8uhqh5xihxteURWA2bgI7Em0//WUESIgInGCUm//jLAuIw
        CzQxSbzre8oG0dLNKPH99mJGkBZOASuJ6Vd/sIPYwgLuEtNb54PFWQRUJCa/OsEMso5XwFJi
        0wRRkDCvgKDEyZlPwLYxC2hLPL35FM5etvA1M8SlChI/ny5jBbFFgMZ/3HWZEaJGRGJ2Zxvz
        BEbhWUhGzUIyahaSUbOQtCxgZFnFKJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7iREcsVqa
        Oxi3r/qgd4iRiYPxEKMEB7OSCO+qSQeThHhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZLySQ
        nliSmp2aWpBaBJNl4uCUamCa9Hmn4D0G+32HAto2v8/b0PvCzaPSeZ+snMVJQwtZXY21Jx5e
        e5w2Rf+zQFzJZKPyKdoXgiZGbq/kmXhpsdT13LMvEve1bXF5tlfdoL8gucng04tri3V2uxjn
        /Tp9WCqH9Xz+2fcHXfiYTzLsvZYho7TgQqanZVNYTOkMf/nFz6QcCg42yahYb+rNX2igYdSZ
        rOUhPYOxS9Ft07sl2vKzivbLcr2PcrOc+a6o4EHYfK2QAwf2Mcrfbn9hz+IiYuxhOVmsZK2E
        +K2HE3k/XPijkPpRPDHmzM32jdMWXTyTffTuZu6wBYy/lZY/ePs5NvoLX4f4rIYFUyeGNZyq
        KHSf3ZvK4rap+VzqXtm7GVpKLMUZiYZazEXFiQCgGR60RwMAAA==
X-CMS-MailID: 20220704111125epcas1p3259f5321de81735c86cc9b22615456d9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220630041602epcas1p3f3427b4ceac68f8325d3f89bc8635603
References: <CGME20220630041602epcas1p3f3427b4ceac68f8325d3f89bc8635603@epcas1p3.samsung.com>
        <20220630044804.6080-1-sh043.lee@samsung.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we know, the ufs host controller is disabled and enabled in the ufshcd_h=
ba_enable(). So, host controller registers are clear after sw reset.

Once the host fails to link startup 3 times, all host's controller can be c=
lear due to executing last ufshcd_hba_enable()(s/w reset).
That's why we need to skip last sw reset to get valid host register values.

Before
(ufshcd_dme_link_startup() -> ufshcd_hba_enable() -> retries--) * 3 times.

After
(ufshcd_dme_link_startup() -> if retries is 0, break. ->  ufshcd_hba_enable=
() -> retries--) * 3 times.
In this case, ufshcd_print_host_state(), ufshcd_print_pwr_info(), ufshcd_pr=
int_evt_hist() are valid.

> -----Original Message-----
> From: Seunghui Lee <sh043.lee=40samsung.com>
> Sent: Thursday, June 30, 2022 1:48 PM
> To: alim.akhtar=40samsung.com; avri.altman=40wdc.com; bvanassche=40acm.or=
g;
> jejb=40linux.ibm.com; martin.petersen=40oracle.com; linux-scsi=40vger.ker=
nel.org;
> linux-kernel=40vger.kernel.org
> Cc: grant.jung=40samsung.com; jt77.jang=40samsung.com;
> dh0421.hwang=40samsung.com; junwoo80.lee=40samsung.com; jangsub.yi=40sams=
ung.com;
> cw9316.lee=40samsung.com; sh8267.baek=40samsung.com; wkon.kim=40samsung.c=
om;
> Seunghui Lee <sh043.lee=40samsung.com>
> Subject: =5BPATCH=5D scsi: ufs: no sw reset after last linkstartup fail
>=20
> Host driver resets the host(ufshcd_hba_enable) after last linkstartup
> command failed. All of the member or host dump after linkstartup fail are
> reset value because of sw reset.
>=20
> Signed-off-by: Junwoo Lee <junwoo80.lee=40samsung.com>
> Signed-off-by: Seunghui Lee <sh043.lee=40samsung.com>
> ---
>  drivers/ufs/core/ufshcd.c =7C 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c index
> 7c1d7bb9c579..2cdc14675443 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> =40=40 -4753,7 +4753,7 =40=40 static int ufshcd_link_startup(struct ufs_h=
ba *hba)
>  		 * but we can't be sure if the link is up until link startup
>  		 * succeeds. So reset the local Uni-Pro and try again.
>  		 */
> -		if (ret && ufshcd_hba_enable(hba)) =7B
> +		if (ret && retries && ufshcd_hba_enable(hba)) =7B
>  			ufshcd_update_evt_hist(hba,
>  					       UFS_EVT_LINK_STARTUP_FAIL,
>  					       (u32)ret);
> --
> 2.29.0


