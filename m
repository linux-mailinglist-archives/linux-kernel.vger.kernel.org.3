Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2105B487418
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 09:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345828AbiAGI0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 03:26:22 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:42172 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbiAGI0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 03:26:19 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220107082616epoutp01ce630f6fc2b618490cb43dc36d5b56e2~H74yH-4S40400404004epoutp01V
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 08:26:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220107082616epoutp01ce630f6fc2b618490cb43dc36d5b56e2~H74yH-4S40400404004epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1641543976;
        bh=Gaae7NQR49Jk8QJ2+a4rwm0K57KPAG+svI6ZkZ+tdMQ=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=omNgfZ4b/PESZihbgsVbJHtCBJsznZYtPervxIDfGkHn86ZbZl25sns58Rpp5piAB
         e5JoDSgmrSvOe81Op6HiMZ/AbuOErTDMN9gECSPMoCTz0TGVgxN+gRu2w2hObIsXNQ
         tG4Dgu53E2fehpO1eKSuObeshqqpUN/HEbm1SA60=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220107082615epcas5p34f9f91a935c663ba1509d209b68d449c~H74xtntMG2999929999epcas5p3l;
        Fri,  7 Jan 2022 08:26:15 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JVbsH2XXzz4x9Py; Fri,  7 Jan
        2022 08:26:11 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        59.75.06423.329F7D16; Fri,  7 Jan 2022 17:26:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220107082610epcas5p318be1fe8bb11a4c095c900eef3609c89~H74tNpswj2999929999epcas5p3d;
        Fri,  7 Jan 2022 08:26:10 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220107082610epsmtrp27a07c42ad45b7bd9a40b80aadb8e5749~H74tG7A5F1937519375epsmtrp2a;
        Fri,  7 Jan 2022 08:26:10 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-8c-61d7f9233737
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.A1.08738.229F7D16; Fri,  7 Jan 2022 17:26:10 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220107082608epsmtip2c40f13e323809ceab5c728ac990d9e51~H74rHDF_03118431184epsmtip2G;
        Fri,  7 Jan 2022 08:26:08 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'SEO HOYOUNG'" <hy50.seo@samsung.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kwmad.kim@samsung.com>, <avri.altman@wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <beanhuo@micron.com>, <asutoshd@codeaurora.org>,
        <cang@codeaurora.org>, <bvanassche@acm.org>,
        <grant.jung@samsung.com>, <junwoo80.lee@samsung.com>,
        <bhoon95.kim@samsung.com>
In-Reply-To: <20220106194804.23892-1-hy50.seo@samsung.com>
Subject: RE: [PATCH v1] scsi: ufs: modify Tactive time setting conditions
Date:   Fri, 7 Jan 2022 13:56:07 +0530
Message-ID: <02b301d803a0$39a31770$ace94650$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLBB52XwS5PS16occ+sFAPt+NoGoQEXvjyLqnxylZA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFJsWRmVeSWpSXmKPExsWy7bCmuq7yz+uJBmdOC1rsbTvBbvHy51U2
        i4MPO1ksvi59xmox7cNPZotP65exWvz6u57dYvXiBywWi25sY7LY9beZyeLmlqMsFpd3zWGz
        6L6+g81i+fF/TA58HpeveHtc7utl8piw6ACjx/f1HWweH5/eYvHo27KK0ePzJjmP9gPdTAEc
        Udk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUB3KymU
        JeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOy
        M5b9/M1cMIGv4vRztgbGOTxdjJwcEgImEku2PWbsYuTiEBLYzSixev9ZJpCEkMAnRompr1kg
        Ep8ZJe5cPMUG03HyzWFWiMQuRomGc9ehql4ySkx+f4oFpIpNQFdix+I2NpCEiEArs8SuGU/B
        EpwCVhLLvv1iBbGFBTwlpt24BhTn4GARUJFouGcCEuYVsJRYd2k3I4QtKHFy5hOwVmYBbYll
        C18zQ1yhIPHz6TKwMSJAI9fMncIGUSMu8fLoEXaQvRICVzgkFpzazw7R4CIx89Y+qGZhiVfH
        t0DFpSQ+v9vLBnKDhEC2RM8uY4hwjcTSecdYIGx7iQNX5oCdySygKbF+lz7EKj6J3t9PmCA6
        eSU62oQgqlUlmt9dheqUlpjY3c0KYXtIzN6yHBrSvYwS864fYZrAqDALyZezkHw5C8k3sxA2
        L2BkWcUomVpQnJueWmxaYJiXWg6P7uT83E2M4ESt5bmD8e6DD3qHGJk4GA8xSnAwK4nwTt17
        LVGINyWxsiq1KD++qDQntfgQoykw5CcyS4km5wNzRV5JvKGJpYGJmZmZiaWxmaGSOO/p9A2J
        QgLpiSWp2ampBalFMH1MHJxSDUyum/S3x76447wz7kN5r0PhFxkpnttV//LvM/9ds+Sw8E4F
        E7si8Y2yUt3ajnNtD3sceTlpw6oZnrtitjm3rTz7pP6OZfmM+DW/C56UW02fJmuzJE/2x4XK
        vReFWJrmif3buLyKqVHqzL9bm3+6G2TfLszqbfHJeMEYW/RV4OSyzQte3bqnpbT0Jd8eb0a3
        M++fKCtNmb9qi913n+prO/4kfH8QMnmDx7VNDM155fYbvF7WJ5YE3Ip6/LBf+ojs3ohIJvE8
        1n+LpvMGZL97uUXb2uiIq7Rz29yo1P1/5t82vyTFp/X7aliTnx3PftazcVfX1Kv8eSswTadk
        9fNWXkmv/iOzX2zz+75C/P6/ivN+SizFGYmGWsxFxYkAuUsmyF0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSvK7Sz+uJBp17FSz2tp1gt3j58yqb
        xcGHnSwWX5c+Y7WY9uEns8Wn9ctYLX79Xc9usXrxAxaLRTe2MVns+tvMZHFzy1EWi8u75rBZ
        dF/fwWax/Pg/Jgc+j8tXvD0u9/UyeUxYdIDR4/v6DjaPj09vsXj0bVnF6PF5k5xH+4FupgCO
        KC6blNSczLLUIn27BK6MrrV7GQuu81Z83rybpYHxIXcXIyeHhICJxMk3h1m7GLk4hAR2MEp0
        f+1ng0hIS1zfOIEdwhaWWPnvOTtE0XNGic2n3zOBJNgEdCV2LG5jA0mICExlltj4/i9UVTej
        xK3uSYwgVZwCVhLLvv1iBbGFBTwlpt24xtLFyMHBIqAi0XDPBCTMK2Apse7SbkYIW1Di5Mwn
        LCA2s4C2xNObT+HsZQtfM0NcpCDx8+kysJEiQOPXzJ3CBlEjLvHy6BH2CYxCs5CMmoVk1Cwk
        o2YhaVnAyLKKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4NrW0djDuWfVB7xAjEwfj
        IUYJDmYlEd6pe68lCvGmJFZWpRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbL
        xMEp1cA08+O0w+ZPUs4dO+X19/+BV1Ojfp781BGpnWqhd3e9VHJwvcP0GVcTmb9vdA+xb/Fw
        4lhvumfHafkH+/68vLEyK+Zo4nMT94QLDpMduCeedDZepMHgtKxB9tf6BrFI9rmlT1Ks3k+M
        Fa1lPm1dJ2V5b4FQpm7MuaDNVuLsfyzv9IkJ31+fcP47T2bGYddl/R4sv7sOT3vg+Dpt8Wo3
        l41vzydurlggxR9y057n9l+bawVpOa2NVusOh92q+7nsbUKblfoR08vL1FgmK8irB/ct/OI9
        5dqfddO1/23lfrzy6Bwnn4NyWdqZXJrJr2ebme8pvrhJ+mHX/KfXcjwLIkObL850nnSTe4OM
        05OrWnevKLEUZyQaajEXFScCAMKop2w8AwAA
X-CMS-MailID: 20220107082610epcas5p318be1fe8bb11a4c095c900eef3609c89
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220107080332epcas2p216d8123df110623b4287ebf6879f745f
References: <CGME20220107080332epcas2p216d8123df110623b4287ebf6879f745f@epcas2p2.samsung.com>
        <20220106194804.23892-1-hy50.seo@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: SEO HOYOUNG =5Bmailto:hy50.seo=40samsung.com=5D
>Sent: Friday, January 7, 2022 1:18 AM
>To: linux-scsi=40vger.kernel.org; linux-kernel=40vger.kernel.org;
>kwmad.kim=40samsung.com; alim.akhtar=40samsung.com;
>avri.altman=40wdc.com; jejb=40linux.ibm.com; martin.petersen=40oracle.com;
>beanhuo=40micron.com; asutoshd=40codeaurora.org; cang=40codeaurora.org;
>bvanassche=40acm.org; grant.jung=40samsung.com;
>junwoo80.lee=40samsung.com; bhoon95.kim=40samsung.com
>Cc: SEO HOYOUNG <hy50.seo=40samsung.com>
>Subject: =5BPATCH v1=5D scsi: ufs: modify Tactive time setting conditions
>
>The Tactive time determine the waiting time before burst at hibern8 exit a=
nd
>is determined by H/W at linkup state However, in the case of samsung
>devices, guided host's Tactive time +100us for stability.
>If the HCI's Tactive time is equal or greater than the device, +100us shou=
ld be
>set.
>
>Change-Id: Ie9b502c69264d3e5931ee8b515388094441fa065

Please remove this and advisable to run checkpatch before posting.

>Signed-off-by: SEO HOYOUNG <hy50.seo=40samsung.com>
>---
> drivers/scsi/ufs/ufshcd.c =7C 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c index
>1049e41abd5b..460d2b440d2e 100644
>--- a/drivers/scsi/ufs/ufshcd.c
>+++ b/drivers/scsi/ufs/ufshcd.c
>=40=40 -7815,7 +7815,7 =40=40 static int
>ufshcd_quirk_tune_host_pa_tactivate(struct ufs_hba *hba)
> 	peer_pa_tactivate_us =3D peer_pa_tactivate *
> 			     gran_to_us_table=5Bpeer_granularity - 1=5D;
>
>-	if (pa_tactivate_us > peer_pa_tactivate_us) =7B
>+	if (pa_tactivate_us >=3D peer_pa_tactivate_us) =7B
> 		u32 new_peer_pa_tactivate;
>
> 		new_peer_pa_tactivate =3D pa_tactivate_us /
>--
>2.26.0


