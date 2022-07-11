Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338ED56D2D5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 04:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiGKCCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 22:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiGKCCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 22:02:35 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8972C18382
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 19:02:32 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220711020230epoutp02ceb9a7229f7f9eed5846a57f84a29b7e~Ao-iJBijM2647126471epoutp02W
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 02:02:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220711020230epoutp02ceb9a7229f7f9eed5846a57f84a29b7e~Ao-iJBijM2647126471epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657504950;
        bh=OaVvEzoz+dUwkrKkOUVH6QN1SGIMfcwu3STE4rsyWTA=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=MXMlYKwXsgTIcRKSLECL9tDMjna5Kwz8UZ+VcjmiiuE1NaFyi5st8xeHSf7sTePUA
         0IG/T25Zr6Lianl7euRdf4Oir5PuLXCBaaELa3jdHxNhVTnQ8Q2tQqKZgbemrNkqEF
         +6VfcCltJpAIBMovnnl4napR3Dy5VdbY0zX1Q2/o=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220711020229epcas2p370731e68d2446812d3cca2936b04680d~Ao-hYX1t42145921459epcas2p31;
        Mon, 11 Jul 2022 02:02:29 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.97]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Lh6b90m20z4x9Q9; Mon, 11 Jul
        2022 02:02:29 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        8E.E3.09666.4B48BC26; Mon, 11 Jul 2022 11:02:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220711020228epcas2p2a39fa7b7dcccf8213743586e00b2275d~Ao-gHtsCb3107531075epcas2p2x;
        Mon, 11 Jul 2022 02:02:28 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220711020228epsmtrp2bd61d62048947af032046e93f3a517f8~Ao-gGrmpN2830728307epsmtrp2p;
        Mon, 11 Jul 2022 02:02:28 +0000 (GMT)
X-AuditID: b6c32a45-471ff700000025c2-0f-62cb84b4312f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CE.90.08802.4B48BC26; Mon, 11 Jul 2022 11:02:28 +0900 (KST)
Received: from KORCO011456 (unknown [10.229.18.123]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220711020228epsmtip211c507dcc9626e03849b42af62a68faf~Ao-f4FZVc0425604256epsmtip2P;
        Mon, 11 Jul 2022 02:02:28 +0000 (GMT)
From:   "Kiwoong Kim" <kwmad.kim@samsung.com>
To:     "'Bart Van Assche'" <bvanassche@acm.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <beanhuo@micron.com>, <adrian.hunter@intel.com>,
        <sc.suh@samsung.com>, <hy50.seo@samsung.com>,
        <sh425.lee@samsung.com>, <bhoon95.kim@samsung.com>
In-Reply-To: <1ad26d79-9f5c-9b53-6904-7d7fd53fac2f@acm.org>
Subject: RE: [RESEND PATCH v3] scsi: ufs: exclude UECxx from SFR dump list
Date:   Mon, 11 Jul 2022 11:02:28 +0900
Message-ID: <000001d894ca$45da51f0$d18ef5d0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE7NzaYSR5yQWCLH5OMCMWgQFvAMQDlQII7Am+PYo6umH9tAA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAJsWRmVeSWpSXmKPExsWy7bCmue7WltNJBk8PMFmcfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Xi69JnrBbTPvxktli9+AGLxaIb25gsLu+aw2bRfX0Hm8Xy4/+YLLru3mC0
        WPrvLYsDr8flK94ei/e8ZPKYsOgAo8f39R1sHh+f3mLx6NuyitHj8yY5j/YD3UwBHFHZNhmp
        iSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAJysplCXmlAKF
        AhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL89L18lJLrAwNDIxMgQoTsjOa9y9l
        LZjKWvHxr3cDYw9LFyMHh4SAicShXtYuRi4OIYEdjBJ966exQDifGCWa298wQzifGSUapzcA
        lXGCdTT172eDSOxilFi4cAGU85JR4si9u0wgVWwC2hLTHu4GGywi8JpJonXTeXaQBKeAtcTe
        /SvZQZYLC3hJfF+mDRJmEVCVmL1+FyNImFfAUuLIggiQMK+AoMTJmU9YQGxmoJHLFr5mhjhC
        QeLn02VgB4kIOEm8PbmdEaJGRGJ2ZxvY1RICJzgkZj/8xwLR4CLx98Z3JghbWOLV8S3sELaU
        xOd3e9kgYVEssWmfPERvA6PEkk+boXqNJWY9awe7jVlAU2L9Ln2IcmWJI7egTuOT6Dj8lx0i
        zCvR0SYE0ags8WvSZEYIW1Ji5s07UEs9JN7t+c08gVFxFpInZyF5chaSZ2Yh7F3AyLKKUSy1
        oDg3PbXYqMAQHtPJ+bmbGMFJWct1B+Pktx/0DjEycTAeYpTgYFYS4f1z9lSSEG9KYmVValF+
        fFFpTmrxIUZTYKhPZJYSTc4H5oW8knhDE0sDEzMzQ3MjUwNzJXFer5QNiUIC6YklqdmpqQWp
        RTB9TBycUg1MTdGHH0xw0zFT6zbe6n3t58GXT7tNRR48ZH87JcRe68vDR1fXJAb940n5cNPa
        0qz3/W6vtpuzTEWqf0cZZTrNK3lSf6jTQDRWcf3JaW80VuQwn/KVulxRU1a6QyPw+cPEepf/
        qYZdv6cUlz6f8myp3X1ByR86LE8Yu+4Hu9nfeSS5J0ququz5xYdXTA4bF55b81FxVWhvyd5d
        h1149TJqD7+YuXDC1JhVNgl/X2y1tg+0PpG3PnTpv6PBF10e689vuWOof1tgwW+2U0vzz8hN
        vaV39Un2zUVa4Qf470498fY5e8ii/GdyOplb9/mflLx4+1uH77/Vnnf2KrscdKqYwKCgtlv3
        0h512ePvU2Ll85RYijMSDbWYi4oTAXc4cVdTBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsWy7bCSvO6WltNJBpuOSlucfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Xi69JnrBbTPvxktli9+AGLxaIb25gsLu+aw2bRfX0Hm8Xy4/+YLLru3mC0
        WPrvLYsDr8flK94ei/e8ZPKYsOgAo8f39R1sHh+f3mLx6NuyitHj8yY5j/YD3UwBHFFcNimp
        OZllqUX6dglcGT/acgpms1ZcWdnI0sDYx9LFyMkhIWAi0dS/n62LkYtDSGAHo8S+t52MEAlJ
        iRM7n0PZwhL3W46wQhQ9Z5SYf3M5WIJNQFti2sPdYAkRgd9MEvvezWKGqDrGKDF3fhvYDk4B
        a4m9+1eydzFycAgLeEl8X6YNEmYRUJWYvX4XI0iYV8BS4siCCJAwr4CgxMmZT8A6mYHmP735
        FM5etvA1M8RBChI/ny5jBbFFBJwk3p7czghRIyIxu7ONeQKj0Cwko2YhGTULyahZSFoWMLKs
        YpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIjkYtrR2Me1Z90DvEyMTBeIhRgoNZSYT3
        z9lTSUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwhX08
        WXot3INZUEHsmboF43OZtKlyfZzTUndf2ilVyfpg6qHodxeSJ3ud9Pq7YJV+Brfd3/Mb+mb8
        j3ZXN0zlmCaZEPr21r7YYhWL3+03uBocba2iVm/jiXxXwn5PZP2J3YnK76Jypq7NWmht8eEk
        c5Pdbj4OdtObtffvFKZYf5M3ZL+dE6d3Xuu45E2/PS8UavrrBRhuXHtbamBmN1mIw7E+IFQq
        R91u9qqGLw5VLbzTZ3M0Sxu4t+QtF5z+/ZhDyZFDcmwe670PxFm959n4ve3RepXy9LAfq7bP
        aT2e/+GypjHXrjK/lq1ntc9O/r7Jcd+2S8Idt3MmzuCdpnfvoOUpWdadb47/bepy/3xJiaU4
        I9FQi7moOBEA1DL8ZTUDAAA=
X-CMS-MailID: 20220711020228epcas2p2a39fa7b7dcccf8213743586e00b2275d
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
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
> Bart.

This is needed because those SFRs are ROC (Read to Clear) type.
That means reading causes clearing contexts.
The SFRs are mainly read in interrupt context but the reading is also done =
in dump.

Besides, I think reading them in dump is not proper because reading them is=
 not just 'reading'

Thanks.
Kiwoong Kim

