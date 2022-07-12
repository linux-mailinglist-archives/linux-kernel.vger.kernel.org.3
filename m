Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE1C5712F6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 09:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbiGLHTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 03:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbiGLHTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:19:51 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85370DF97
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:19:48 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220712071943epoutp03bd9b9a5ced5f48b1e3fd7fa467133557~BA9x69gKh0170801708epoutp03Q
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:19:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220712071943epoutp03bd9b9a5ced5f48b1e3fd7fa467133557~BA9x69gKh0170801708epoutp03Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657610383;
        bh=EHjvu6y7/2YojqWSmEKVMsufu+19zzgWWK0dq1IW5LE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ja3CjxJ9JpsKbrfqaHyasOYntapJahQW4LTPX4UEn/YrPmFwV+RvigONK2rL/OeUC
         Dwjb5OW++BugoharaxywisJfjooWuygeqyPOfSVhfEZmdoxa3Cwfy52o6lFQLxCOLZ
         ZBl2Ug0nA4oCVcZVXNZyAYApeY4dyI39W9fG9BIE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220712071942epcas2p12cb4281c50858e5106d589095a5d116b~BA9xh3cgF1152111521epcas2p1k;
        Tue, 12 Jul 2022 07:19:42 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.100]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LhsZk299rz4x9QL; Tue, 12 Jul
        2022 07:19:42 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F0.6F.09650.E802DC26; Tue, 12 Jul 2022 16:19:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220712071941epcas2p2faa87d8efe182e9c28a924ea3de15209~BA9wbs-n_2622626226epcas2p2Z;
        Tue, 12 Jul 2022 07:19:41 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220712071941epsmtrp158a6dd6acde05b08d9b4fe0e63491588~BA9wapZ6I1405214052epsmtrp1-;
        Tue, 12 Jul 2022 07:19:41 +0000 (GMT)
X-AuditID: b6c32a46-8bff9a80000025b2-84-62cd208e6ce9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D2.E4.08802.D802DC26; Tue, 12 Jul 2022 16:19:41 +0900 (KST)
Received: from perf.dsn.sec.samsung.com (unknown [10.229.95.91]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220712071941epsmtip226883a377075c6cd507195e56d0c0a26~BA9wMwcuA1227712277epsmtip2F;
        Tue, 12 Jul 2022 07:19:41 +0000 (GMT)
From:   Youngmin Nam <youngmin.nam@samsung.com>
To:     arnd@arndb.de, jstultz@google.com, tglx@linutronix.de
Cc:     sboyd@kernel.org, linux-kernel@vger.kernel.org,
        youngmin.nam@samsung.com, chanho61.park@samsung.com,
        hajun.sung@samsung.com, hosung0.kim@samsung.com,
        d7271.choe@samsung.com
Subject: [PATCH] time: remove useless "const" keyword in
 ns_to_kernel_old_timeval() and ns_to_timespec64()
Date:   Tue, 12 Jul 2022 16:47:05 +0900
Message-Id: <20220712074705.420399-1-youngmin.nam@samsung.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmmW6fwtkkg73/uC3+TjrGbnF5v7bF
        tb0T2S2a9l9itvh6/RG7xZ8TG9ksLu+aw2bx79pGFovNm6YyWyw+8Indgcvj969JjB4LNpV6
        bFrVyebx7tw5do++LasYPT5vkgtgi8q2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0
        MFdSyEvMTbVVcvEJ0HXLzAE6TEmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6g
        V5yYW1yal66Xl1piZWhgYGQKVJiQnbFx0R3Wgoe8FbNvvmdvYLzC3cXIwSEhYCLR3hnUxcjF
        ISSwg1Fi27UFbBDOJ0aJWTuOMUM4nxklNk58BuRwgnX8Wd7HApHYxSgxqWkyK4TzlVHi6NFd
        TCBVbAK6EttO/GME2SEiYClxq98HpIZZYAujROukE2CThAVyJJq3HWMFsVkEVCXOvj4E1ssr
        YCfxaN95Noj75CX+vBKACAtKnJz5hAXEZgYKN2+dDXadhMBHdonnF16xQ1znInG97QzUpcIS
        r45vgYpLSbzsb4OyiyWenF3KCNHcwCixe/FrFoiEscSsZ+1gRzMLaEqs36UPcYOyxJFbUHv5
        JDoO/2WHCPNKdLQJQTSqSfyasoERwpYBGrgC6gIPiW0NN9hAbCGBWIm5/Q/ZJzDKz0LyzSwk
        38xC2LuAkXkVo1hqQXFuemqxUYERPE6T83M3MYKTppbbDsYpbz/oHWJk4mA8xCjBwawkwvvn
        7KkkId6UxMqq1KL8+KLSnNTiQ4ymwOCdyCwlmpwPTNt5JfGGJpYGJmZmhuZGpgbmSuK8Xikb
        EoUE0hNLUrNTUwtSi2D6mDg4pRqYdI2msq8VL+UreiPrJHB/v8JKLlVd+8tLzk/+Wjo5YkHy
        p8c7gi1+nJteLqwn1CvzN1Nz3dG9eVo+X3t/zniga716b8mR/keW0yO+Pzr1Xn9/k42yzFJp
        r3d9Omc3zd3UZfj1yImv0k82mB09Utp421vNebLsvteHkuYnfszfVrtPeMXiHTG9Wyfu2Hto
        beymSXeYjiVXKxuvm+1u+/bg3E3ip2cfz00/cdDrZtktloV9Oy7G7mqa8fJ04u6XzI03VxTt
        7zSY/oLXiH/7v78pe/IW/AqRy7x3+qnn8SnfjnxKaAtLb72QJ/5D9qvprgTeWDOr2AvpC1sP
        XN672fpt3uG61v+XIxTXBv3R37xMP1pRiaU4I9FQi7moOBEAvDcAHSMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrILMWRmVeSWpSXmKPExsWy7bCSvG6vwtkkg5mfVCz+TjrGbnF5v7bF
        tb0T2S2a9l9itvh6/RG7xZ8TG9ksLu+aw2bx79pGFovNm6YyWyw+8Indgcvj969JjB4LNpV6
        bFrVyebx7tw5do++LasYPT5vkgtgi+KySUnNySxLLdK3S+DK2LjoDmvBQ96K2TffszcwXuHu
        YuTkkBAwkfizvI+li5GLQ0hgB6PEr0NL2CESMhK3V15mhbCFJe63HGGFKPrMKHHv1AewIjYB
        XYltJ/4xgtgiArYSH5bNYwcpYhbYwyjxbe48sG5hgSyJOysOghWxCKhKnH19iAnE5hWwk3i0
        7zxbFyMH0AZ5iT+vBCDCghInZz5hAbGZgcLNW2czT2Dkm4UkNQtJagEj0ypGydSC4tz03GLD
        AqO81HK94sTc4tK8dL3k/NxNjOBQ1tLawbhn1Qe9Q4xMHIyHGCU4mJVEeP+cPZUkxJuSWFmV
        WpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA1M3+8TYn7WBZ8XPzzoR
        mWLSsStmvov+JJNOnqy7N+/EPz12dMtkqfMiR5KPvO9Nu7nj2cGNBvaGoeFXTqx0Npl6O3Pp
        yv1TGoKl//xZdv1X6dkFG140PQ8y4LqsEZGaGnrO7VDfpX9yiWlGImXphWd3TZe6YrtoSaX8
        dGnJj2ffS5w5rOVw08Fxcffu+oh8u+Mz+t/EbZlxwbvESXnSxVkOfB3zTH6vDBHI/28wQ/61
        q/JzdtvpsRwVGe1q/Eka65oWqRe84f/+rf/ipvIJdbxN3Evddbdz1Ipf8c8NO3Uj+vnDMzZ8
        KvulHI5GX83+cmzhvbmTWDea+iVe//mxWK4ix4aF41Lb57KquQKRceVKLMUZiYZazEXFiQBR
        kd6L1AIAAA==
X-CMS-MailID: 20220712071941epcas2p2faa87d8efe182e9c28a924ea3de15209
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220712071941epcas2p2faa87d8efe182e9c28a924ea3de15209
References: <CGME20220712071941epcas2p2faa87d8efe182e9c28a924ea3de15209@epcas2p2.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As mentioned below,
https://lore.kernel.org/lkml/CAK8P3a3nknJgEDESGdJH91jMj6R_xydFqWASd8r5BbesdvMBgA@mail.gmail.com/

The "const" keyword is useless, so we drop it from the function definition and declaration.

Change-Id: If35bba78aa7757476e22be42afc719c27fb0f527
Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
---
 include/linux/time64.h | 2 +-
 kernel/time/time.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/time64.h b/include/linux/time64.h
index 81b9686a2079..ee021da0966e 100644
--- a/include/linux/time64.h
+++ b/include/linux/time64.h
@@ -142,7 +142,7 @@ static inline s64 timespec64_to_ns(const struct timespec64 *ts)
  *
  * Returns the timespec64 representation of the nsec parameter.
  */
-extern struct timespec64 ns_to_timespec64(const s64 nsec);
+extern struct timespec64 ns_to_timespec64(s64 nsec);
 
 /**
  * timespec64_add_ns - Adds nanoseconds to a timespec64
diff --git a/kernel/time/time.c b/kernel/time/time.c
index 29923b20e0e4..526257b3727c 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -449,7 +449,7 @@ time64_t mktime64(const unsigned int year0, const unsigned int mon0,
 }
 EXPORT_SYMBOL(mktime64);
 
-struct __kernel_old_timeval ns_to_kernel_old_timeval(const s64 nsec)
+struct __kernel_old_timeval ns_to_kernel_old_timeval(s64 nsec)
 {
 	struct timespec64 ts = ns_to_timespec64(nsec);
 	struct __kernel_old_timeval tv;
@@ -503,7 +503,7 @@ EXPORT_SYMBOL(set_normalized_timespec64);
  *
  * Returns the timespec64 representation of the nsec parameter.
  */
-struct timespec64 ns_to_timespec64(const s64 nsec)
+struct timespec64 ns_to_timespec64(s64 nsec)
 {
 	struct timespec64 ts = { 0, 0 };
 	s32 rem;
-- 
2.34.0

