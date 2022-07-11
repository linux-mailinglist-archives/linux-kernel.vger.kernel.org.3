Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D6B56D2CD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 03:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiGKB7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 21:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGKB7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 21:59:46 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFBBD12B
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 18:59:44 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220711015938epoutp039180719f7c2442aa513e4f70b669db30~Ao9BiXViG1255012550epoutp03J
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:59:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220711015938epoutp039180719f7c2442aa513e4f70b669db30~Ao9BiXViG1255012550epoutp03J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657504778;
        bh=nxiNsz+0mBe/uYNCxHlMzmFqbcvJ62d8q0WEtKA8y6o=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=OxnOqimEg2xXI6okquToaLY0d1buQW+umOPa3vYVgE+mdA/aohE3khoqf2JLjV85t
         lvcvm0PetHKCseKg9i/6gGl+JO5cR1xmRx0jiXiQSVDyKzSDqefshI7LWKFDYErGSE
         /gRn7s0CvvTrkid9JLaIxN5IiQGTSnu0zbt13uPA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220711015937epcas2p44100bec8967cad907465208356a95036~Ao9A5KOCZ2692126921epcas2p40;
        Mon, 11 Jul 2022 01:59:37 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.102]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Lh6Wr68lYz4x9Pw; Mon, 11 Jul
        2022 01:59:36 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.AD.09650.8048BC26; Mon, 11 Jul 2022 10:59:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220711015936epcas2p36e0412841755100884dc05407eea0676~Ao8-w2Pri3218732187epcas2p3r;
        Mon, 11 Jul 2022 01:59:36 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220711015936epsmtrp246008e0351c4b273c4ca12317031c1b9~Ao8-v66hW2563325633epsmtrp2_;
        Mon, 11 Jul 2022 01:59:36 +0000 (GMT)
X-AuditID: b6c32a46-0a3ff700000025b2-df-62cb84086791
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        08.40.08802.8048BC26; Mon, 11 Jul 2022 10:59:36 +0900 (KST)
Received: from KORCO011456 (unknown [10.229.18.123]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220711015936epsmtip28485ffcc6cda617ff2af4deffff83c15~Ao8-e3_C80203002030epsmtip2D;
        Mon, 11 Jul 2022 01:59:36 +0000 (GMT)
From:   "Kiwoong Kim" <kwmad.kim@samsung.com>
To:     "'Bart Van Assche'" <bvanassche@acm.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <beanhuo@micron.com>, <cang@codeaurora.org>,
        <adrian.hunter@intel.com>, <sc.suh@samsung.com>,
        <hy50.seo@samsung.com>, <sh425.lee@samsung.com>,
        <bhoon95.kim@samsung.com>, <vkumar.1997@samsung.com>
In-Reply-To: <1ad26d79-9f5c-9b53-6904-7d7fd53fac2f@acm.org>
Subject: RE: [RESEND PATCH v3] scsi: ufs: exclude UECxx from SFR dump list
Date:   Mon, 11 Jul 2022 10:59:35 +0900
Message-ID: <000001d894c9$df3724a0$9da56de0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE7NzaYSR5yQWCLH5OMCMWgQFvAMQDlQII7Am+PYo6umH2NgA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPJsWRmVeSWpSXmKPExsWy7bCmhS5Hy+kkg5trdC1OPlnDZvFg3jY2
        i5c/r7JZHHzYyWLxdekzVotpH34yW3xav4zVYvXiBywWi25sY7K4vGsOm0X39R1sFsuP/2Oy
        6Lp7g9Fi6b+3LBZ37n9kceD3uHzF2+NyXy+Tx+I9L5k8Jiw6wOjxfX0Hm8fHp7dYPPq2rGL0
        +LxJzqP9QDdTAGdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKL
        T4CuW2YO0AdKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnALzAr3ixNzi0rx0vbzU
        EitDAwMjU6DChOyMjnOP2QtmsFZM2e3TwNjP0sXIySEhYCJxdd83pi5GLg4hgR2MErOXNbFC
        OJ8YJS72voZyPjNKnP2ymr2LkQOs5cdcUYj4LkaJhT82skM4LxklFh+6zA4yl01AW2Law91g
        3SIC85klvpxfxAqS4BSwlti7fyXYJGEBL4nvy7RBwiwCqhLnj/5kBQnzClhKzL8tAxLmFRCU
        ODnzCdipzEAjly18zQxxtoLEz6fLwCaKCDhJzL/8ih2iRkRidmcbM8haCYEHHBIPD+1hgmhw
        kehr3MoKYQtLvDq+hR3ClpL4/G4vG8RjxRKb9slD9DYwSiz5tBkaRsYSs561M4LUMAtoSqzf
        pQ9Rrixx5BbUaXwSHYf/QoOHV6KjTQiiUVni16TJjBC2pMTMm3eglnpIvNvzm3kCo+IsJE/O
        QvLkLCTPzELYu4CRZRWjWGpBcW56arFRgRE8ppPzczcxglO2ltsOxilvP+gdYmTiYDzEKMHB
        rCTC++fsqSQh3pTEyqrUovz4otKc1OJDjKbAUJ/ILCWanA/MGnkl8YYmlgYmZmaG5kamBuZK
        4rxeKRsShQTSE0tSs1NTC1KLYPqYODilGpjc2je2ZKl6rb1rvj9xe0e9SUZay5rI8hnfKzly
        Ps845v9qwSXpVAvZ+LO+d6fNfHYrKcX8ylz1hNtWGtdDFuxbuSQttK68lCmM4eyEdczeXmcu
        rKl8yRL29vHjoz9W+JxRmRzHGaYX0fJtWda/A/Y+rru0+MrZg14+s9ydKf7I/pjiF6efE1KO
        HMrt/au/xH4ix52tkw59Y1c/tJxj1w/N5AM2kc6r1zs6hSns6nn8/YDkxoUc3huS3I/05L6Y
        8YKDXVLhXf8/Q81Lc92X53jZzttSGVV+XFzuV0LHp8ZDXYFPeeP+reIXvLTSY1bbVLZ9NZ6i
        61fHiUbsZOT5efWKOdt8xQmPW8Oy5zcVxlopsRRnJBpqMRcVJwIAGBJC/mIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsWy7bCSvC5Hy+kkg7VX+SxOPlnDZvFg3jY2
        i5c/r7JZHHzYyWLxdekzVotpH34yW3xav4zVYvXiBywWi25sY7K4vGsOm0X39R1sFsuP/2Oy
        6Lp7g9Fi6b+3LBZ37n9kceD3uHzF2+NyXy+Tx+I9L5k8Jiw6wOjxfX0Hm8fHp7dYPPq2rGL0
        +LxJzqP9QDdTAGcUl01Kak5mWWqRvl0CV8bf1scsBfNYK9Z8mM3awDiRpYuRg0NCwETix1zR
        LkYuDiGBHYwSC69/Yuti5ASKS0qc2PmcEcIWlrjfcoQVoug5o0TX1h6wBJuAtsS0h7vBEiIC
        G5kl1rY9YISoOsYoMXd+GwtIFaeAtcTe/SvZQdYJC3hJfF+mDRJmEVCVOH/0JytImFfAUmL+
        bRmQMK+AoMTJmU/AOpmB5j+9+RTOXrbwNTPEQQoSP58uYwWxRQScJOZffsUOUSMiMbuzjXkC
        o9AsJKNmIRk1C8moWUhaFjCyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECI5VLa0d
        jHtWfdA7xMjEwXiIUYKDWUmE98/ZU0lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhP
        LEnNTk0tSC2CyTJxcEo1MG3tSjKzeK7jXMTO4xz8IfyB9DN7karlDp8kPoqbmNuKzlSWtpF7
        rSNrxs1tsq3ajuPGdh7FgswDG+YEiqpv7jRd+TszNUHp0wmVNoN1Pt82mXe86fzbe9iKteOB
        397Pi9jOLZrDoJb0wNjqT5xNyNZUKa31b4+2qmgrTij/uV1ZJurVhYLtDxwZrk4t3meuzfY4
        O/ewj23gldW/Pfa1HhA5kht0kGlVvsJu1b+tSakHPY3rz0xa7XlM5p/WznMpQixi5yTWnF34
        +MgWhq7dO/81nD8//Zs7W+mbZZuZPqQ4vrUKyTGzyk6affbU8rY3wvW8Z87f5Tzku47HsipI
        9vp8oRD9fMHu57yB5jO/KLEUZyQaajEXFScCABHgbPdEAwAA
X-CMS-MailID: 20220711015936epcas2p36e0412841755100884dc05407eea0676
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220315095716epcas2p2ec52c66863b71180a6c2c45856058683
References: <CGME20220315095716epcas2p2ec52c66863b71180a6c2c45856058683@epcas2p2.samsung.com>
        <1647338162-75639-1-git-send-email-kwmad.kim@samsung.com>
        <1ad26d79-9f5c-9b53-6904-7d7fd53fac2f@acm.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Is this behavior specific to the Exynos controller or is this behavior
> required by the UFSHCI specification? In the latter case, can you tell me
> where to find this requirement in the UFSHCI specification? I haven't
> found that requirement yet. Maybe this means that I overlooked something?
>=20
> Thanks,
>=20
> Bart.=20

This is needed because those SFRs are ROC (Read to Clear) type.
That means reading causes clearing contexts.
The SFRs are mainly read in interrupt context but the reading is also done =
in dump.

Besides, I think reading them in dump is not proper because reading them is=
 not just 'reading'

Thanks.
Kiwoong Kim

