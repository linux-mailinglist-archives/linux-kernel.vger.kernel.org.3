Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A455566493
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiGEHtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiGEHts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:49:48 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06410F77
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:49:46 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220705074944epoutp03d934e6effe5fa8422ad978c4df107cd8~_32-DRPG22033420334epoutp03d
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 07:49:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220705074944epoutp03d934e6effe5fa8422ad978c4df107cd8~_32-DRPG22033420334epoutp03d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657007384;
        bh=Zc8z8WojBpem9QJvUYEZqP6L/sthawOhMKRyZx6xmfs=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=KIVc2W+xlDmFR0whhplvtX2AmoN7jkhEe9HuXmheGapwNsHKpIxLaQfZVLncrTf7I
         YkNgpiBTZX5xXUN8B5DjeA3BMuQFB9NuEA31/uMat87YRy8Qj+R182urmxnF9XzQIH
         tl1Pk9pKCNfYT4+b/h39OIEYfLwF5cWH3Dhhf+fY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220705074943epcas1p4048b7e713ff08778345a3be788414c50~_32_imbyL2197821978epcas1p41;
        Tue,  5 Jul 2022 07:49:43 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.240]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LcZZb0zS0z4x9Ps; Tue,  5 Jul
        2022 07:49:43 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        A8.00.09678.71DE3C26; Tue,  5 Jul 2022 16:49:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220705074942epcas1p4462bb93f0d06fdf141e768af429e13f3~_32900KK00781007810epcas1p48;
        Tue,  5 Jul 2022 07:49:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220705074942epsmtrp2e17ac2f20d071a4af660dd6d3640f2ed~_329z12u13270032700epsmtrp2I;
        Tue,  5 Jul 2022 07:49:42 +0000 (GMT)
X-AuditID: b6c32a39-e67ff700000025ce-ce-62c3ed177392
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.42.08905.61DE3C26; Tue,  5 Jul 2022 16:49:42 +0900 (KST)
Received: from sh043lee03 (unknown [10.253.101.72]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220705074942epsmtip1c14c1bf0e774cbb5cbf6c2f4c05a454a~_329gAJIL2634226342epsmtip1C;
        Tue,  5 Jul 2022 07:49:42 +0000 (GMT)
From:   "Seunghui Lee" <sh043.lee@samsung.com>
To:     "'Avri Altman'" <Avri.Altman@wdc.com>, <alim.akhtar@samsung.com>,
        <bvanassche@acm.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Cc:     <grant.jung@samsung.com>, <jt77.jang@samsung.com>,
        <dh0421.hwang@samsung.com>, <junwoo80.lee@samsung.com>,
        <jangsub.yi@samsung.com>, <cw9316.lee@samsung.com>,
        <sh8267.baek@samsung.com>, <wkon.kim@samsung.com>,
        <seunghwan.hyun@samsung.com>
In-Reply-To: <DM6PR04MB6575621775F19168CC21F7DBFC819@DM6PR04MB6575.namprd04.prod.outlook.com>
Subject: RE: [PATCH] scsi: ufs: no sw reset after last linkstartup fail
Date:   Tue, 5 Jul 2022 16:49:42 +0900
Message-ID: <000001d89043$c966b670$5c342350$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI5aYjeE/9Eh4/d2WnB5RXwuc7qWwHvC5v0Ael9KP8CAriV96x+2f2g
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNJsWRmVeSWpSXmKPExsWy7bCmga7428NJBn3nWSwezNvGZvHy51U2
        i2kffjJbzDjVxmqx79pJdotff9ezW3RsncxksejGNiaLHc/PsFvs+tvMZHF51xw2i+7rO9gs
        lh//x2Rx7uQnVotrZ06wWmy+9I3FQcDj8hVvjwmLDjB6fHx6i8Wjb8sqRo/Pm+Q82g90MwWw
        RWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gDdraRQ
        lphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCvQK07MLS7NS9fLSy2xMjQwMDIFKkzI
        zphzezNbwR3ZijXnLrM2MC4Q72Lk5JAQMJFYvPs7SxcjF4eQwA5GiV1dO5ghnE+MEr3HTjFB
        ON8YJaZtWskI09I66Q1UYi+jROvaD2wQzgtGiZmz3rOBVLEJ6Ei8+fSfFSQhInCBUaLn5iMw
        h1ngF6PE1Mtz2EGqOAViJd7NmQBmCwu4S0xvnQ+2g0VAReLhkhXMIDavgKXE3jeX2CFsQYmT
        M5+wgNjMAtoSyxa+Zoa4SUHi59NlrCC2iICbxOv5F5ggakQkZne2gX0kIfCEQ+LY/X6oJ1wk
        On61sUPYwhKvjm+BsqUkPr/bywZhF0u0/fsHtaBC4mDfFyjbWOLT589AcziAFmhKrN+lDxFW
        lNj5ey4jxF4+iXdfe1hBSiQEeCU62oQgSpQlXj5axgRhS0osab/FPIFRaRaSz2Yh+WwWkg9m
        ISxbwMiyilEstaA4Nz212LDAFB7fyfm5mxjBqVrLcgfj9Lcf9A4xMnEwHmKU4GBWEuFdNelg
        khBvSmJlVWpRfnxRaU5q8SFGU2BYT2SWEk3OB2aLvJJ4QxNLAxMzIxMLY0tjMyVx3lXTTicK
        CaQnlqRmp6YWpBbB9DFxcEo1MNlPtquS4eh6JrQvN3lz5Bo/tW93TDfFV8/3fH/v5e7mOvVD
        67icCg7MnHVuh3j8ApuSBd3fJ37+sCKizW+Z9J05L6/v3rjBXF1UfJbX2mObLRZl+ydPruV5
        Nmlf390D+5f+2F6W3ZK25Dnn7nO51+5cbeTTSOLXMYt/W5h/vMAuT1j5tvXc3N0yTay+L88b
        tGmdFnlRrdySxi/0vndn0H3JoqvnrTdcYr9pUJldvTGiYhXbBX8hja1HTl5u/n3ZRy78ncPZ
        wzzJUf/OKz2LYPx9MOIZi8fyE8FCsTJfFhr3z+NeVz397yoj4WbeVC0X3y/aiXOWvVPNW8Yr
        d2j5zAc8VsnRkSrbVk/pObpNfrISS3FGoqEWc1FxIgDjazkQXgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsWy7bCSnK7Y28NJBlN3yVs8mLeNzeLlz6ts
        FtM+/GS2mHGqjdVi37WT7Ba//q5nt+jYOpnJYtGNbUwWO56fYbfY9beZyeLyrjlsFt3Xd7BZ
        LD/+j8ni3MlPrBbXzpxgtdh86RuLg4DH5SveHhMWHWD0+Pj0FotH35ZVjB6fN8l5tB/oZgpg
        i+KySUnNySxLLdK3S+DKuDf5DVtBg2zF8TObWBsYD4h1MXJySAiYSLROesMEYgsJ7GaUuHjZ
        HyIuKbH40UO2LkYOIFtY4vDh4i5GLqCSZ4wSbZ+/MoPUsAnoSLz59J8VJCEicINR4uDxM8wg
        DrNAE5PEu76nbBBTu5gkTiwNALE5BWIl3s2ZwA5iCwu4S0xvnc8IYrMIqEg8XLICbCqvgKXE
        3jeX2CFsQYmTM5+wgNjMAtoST28+hbOXLXzNDHGpgsTPp8tYQWwRATeJ1/MvMEHUiEjM7mxj
        nsAoPAvJqFlIRs1CMmoWkpYFjCyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGCI1ZL
        cwfj9lUf9A4xMnEwHmKU4GBWEuFdNelgkhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE
        0hNLUrNTUwtSi2CyTBycUg1M6eycuz5NsLj0NV6J/96UvTy7shbfLG7ybw3JvW77yEniSd6u
        eF4pZsvlnW8fWNze9f3lbTvGAw4TdPr/R21RS/+oWV+RbZLT1FiW7Gvr6HpK7PJ+vQtKkbmn
        HupPSZY5daZO1bHpQN3lhYouE76zne19ffVp5+KUT1xlm01LnD5eMFW/FrhiwzHPjgml1cFB
        02/x1svVOscc3rGy+7eAn8tWzxfv2k+pb/P8YPfoOJf93u0HH3jOmbS0lTew/X4CW8WWxXz9
        P07PNdtYeSRLdXGtuvvpmgfzrxcsWbBYci739Og39dMO7xDdvJq7zr2H4ZJc9i+OE8bhzcKx
        ZY8Dd2W2HM4/suSC0q4LEjqaSizFGYmGWsxFxYkA9mc0JUcDAAA=
X-CMS-MailID: 20220705074942epcas1p4462bb93f0d06fdf141e768af429e13f3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220630041602epcas1p3f3427b4ceac68f8325d3f89bc8635603
References: <CGME20220630041602epcas1p3f3427b4ceac68f8325d3f89bc8635603@epcas1p3.samsung.com>
        <20220630044804.6080-1-sh043.lee@samsung.com>
        <000001d88f96$ccd299d0$6677cd70$@samsung.com>
        <DM6PR04MB6575621775F19168CC21F7DBFC819@DM6PR04MB6575.namprd04.prod.outlook.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Avri Altman <Avri.Altman=40wdc.com>
> Sent: Tuesday, July 5, 2022 3:51 PM
> To: Seunghui Lee <sh043.lee=40samsung.com>; alim.akhtar=40samsung.com;
> bvanassche=40acm.org; jejb=40linux.ibm.com; martin.petersen=40oracle.com;=
 linux-
> scsi=40vger.kernel.org; linux-kernel=40vger.kernel.org
> Cc: grant.jung=40samsung.com; jt77.jang=40samsung.com;
> dh0421.hwang=40samsung.com; junwoo80.lee=40samsung.com; jangsub.yi=40sams=
ung.com;
> cw9316.lee=40samsung.com; sh8267.baek=40samsung.com; wkon.kim=40samsung.c=
om;
> seunghwan.hyun=40samsung.com
> Subject: RE: =5BPATCH=5D scsi: ufs: no sw reset after last linkstartup fa=
il
>=20
>=20
> > As we know, the ufs host controller is disabled and enabled in the
> > ufshcd_hba_enable(). So, host controller registers are clear after sw
> reset.
> >
> > Once the host fails to link startup 3 times, all host's controller can
> > be clear due to executing last ufshcd_hba_enable()(s/w reset).
> > That's why we need to skip last sw reset to get valid host register
> values.
> >
> > Before
> > (ufshcd_dme_link_startup() -> ufshcd_hba_enable() -> retries--) * 3
> times.
> >
> > After
> > (ufshcd_dme_link_startup() -> if retries is 0, break. ->
> > ufshcd_hba_enable()
> > -> retries--) * 3 times.
> > In this case, ufshcd_print_host_state(), ufshcd_print_pwr_info(),
> > ufshcd_print_evt_hist() are valid.
> If you find it necessary to elaborate the commit log, why not do just tha=
t?
> Also maybe make the title more indicative of what you want to achieve:
> =22skip last hci reset to get valid register values=22 or something.
>=20
> Thanks,
> Avri

Thank you for your comment.
I'll modify the commit log and update it again.

>=20
>=20
> >
> > > -----Original Message-----
> > > From: Seunghui Lee <sh043.lee=40samsung.com>
> > > Sent: Thursday, June 30, 2022 1:48 PM
> > > To: alim.akhtar=40samsung.com; avri.altman=40wdc.com;
> > bvanassche=40acm.org;
> > > jejb=40linux.ibm.com; martin.petersen=40oracle.com; linux-
> > scsi=40vger.kernel.org;
> > > linux-kernel=40vger.kernel.org
> > > Cc: grant.jung=40samsung.com; jt77.jang=40samsung.com;
> > > dh0421.hwang=40samsung.com; junwoo80.lee=40samsung.com;
> > jangsub.yi=40samsung.com;
> > > cw9316.lee=40samsung.com; sh8267.baek=40samsung.com;
> > wkon.kim=40samsung.com;
> > > Seunghui Lee <sh043.lee=40samsung.com>
> > > Subject: =5BPATCH=5D scsi: ufs: no sw reset after last linkstartup fa=
il
> > >
> > > Host driver resets the host(ufshcd_hba_enable) after last
> > > linkstartup command failed. All of the member or host dump after
> > > linkstartup fail are reset value because of sw reset.
> > >
> > > Signed-off-by: Junwoo Lee <junwoo80.lee=40samsung.com>
> > > Signed-off-by: Seunghui Lee <sh043.lee=40samsung.com>
> > > ---
> > >  drivers/ufs/core/ufshcd.c =7C 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> > > index
> > > 7c1d7bb9c579..2cdc14675443 100644
> > > --- a/drivers/ufs/core/ufshcd.c
> > > +++ b/drivers/ufs/core/ufshcd.c
> > > =40=40 -4753,7 +4753,7 =40=40 static int ufshcd_link_startup(struct u=
fs_hba
> > *hba)
> > >                * but we can't be sure if the link is up until link st=
artup
> > >                * succeeds. So reset the local Uni-Pro and try again.
> > >                */
> > > -             if (ret && ufshcd_hba_enable(hba)) =7B
> > > +             if (ret && retries && ufshcd_hba_enable(hba)) =7B
> > >                       ufshcd_update_evt_hist(hba,
> > >                                              UFS_EVT_LINK_STARTUP_FAI=
L,
> > >                                              (u32)ret);
> > > --
> > > 2.29.0
> >


