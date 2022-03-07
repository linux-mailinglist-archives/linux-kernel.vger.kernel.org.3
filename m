Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920C14D0667
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244775AbiCGSX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244777AbiCGSX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:23:56 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B743A1AD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 10:23:01 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220307182259epoutp03b6a79b2dfbb0a925251a68123c11fd20~aLFopCSjT2288822888epoutp038
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 18:22:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220307182259epoutp03b6a79b2dfbb0a925251a68123c11fd20~aLFopCSjT2288822888epoutp038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646677379;
        bh=7PBwRtMzjSc2mnYwqGnHHFKQFk5YfJ2stthrXqPdDMo=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=isrDtDDyNfAfj+Bcf0/F6vhyzexlqw7X1+4dCDTBpIizoTHj1CW8UxnGd369ypvOa
         /zdKnrU8TlT2ROwb4+cJAEhDlenVBtNN2pFqidn4ShQfHsFoHXld5FJQhBNxodWlTA
         gOX+TE4NWi64H+L16oxDv1El5SYsP59COazOOmTY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220307182258epcas5p235f1ba132068c8820d09cc8c3653570c~aLFn9Pnl90752707527epcas5p22;
        Mon,  7 Mar 2022 18:22:58 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KC6JZ0dvPz4x9Pp; Mon,  7 Mar
        2022 18:22:54 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F0.60.05590.D7D46226; Tue,  8 Mar 2022 03:22:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220307182252epcas5p4382147bb249de325f1c4701f639a39fa~aLFikmMyH3166031660epcas5p4s;
        Mon,  7 Mar 2022 18:22:52 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220307182252epsmtrp17b7f8083c3556e2a47c5b1426fe232b4~aLFijzJoH0546305463epsmtrp1c;
        Mon,  7 Mar 2022 18:22:52 +0000 (GMT)
X-AuditID: b6c32a4b-739ff700000015d6-ad-62264d7dd4ec
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.B6.03370.C7D46226; Tue,  8 Mar 2022 03:22:52 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220307182251epsmtip2c0e026a3bc0cac0bc8c4a5dda067d073~aLFhHkiGp3263732637epsmtip2U;
        Mon,  7 Mar 2022 18:22:51 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Miaoqian Lin'" <linmq006@gmail.com>,
        "'Sylwester Nawrocki'" <s.nawrocki@samsung.com>,
        "'Mauro Carvalho Chehab'" <mchehab@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        "'Kyungmin Park'" <kyungmin.park@samsung.com>,
        "'Younghwan Joo'" <yhwan.joo@samsung.com>,
        <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20220307075206.10737-1-linmq006@gmail.com>
Subject: RE: [PATCH] media: exynos4-is:  Fix PM disable depth imbalance in
 fimc_is_probe
Date:   Mon, 7 Mar 2022 23:52:50 +0530
Message-ID: <000301d83250$5bdc0cf0$139426d0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ1H2Syq5jcFJJjlSWbk5XboGLLWAILRwAvq2oHeWA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPJsWRmVeSWpSXmKPExsWy7bCmpm6dr1qSwZy7jBYb3/5gsjjb9Ibd
        4vnHRmaLTY+vsVpc3jWHzaJnw1ZWixnn9zFZLNv0h8ni8Jt2VovZJxazOnB5zGroZfPYOesu
        u8emVZ1sHpuX1Hv0bVnF6PF5k1wAW1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGl
        hbmSQl5ibqqtkotPgK5bZg7QZUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScApMC
        veLE3OLSvHS9vNQSK0MDAyNToMKE7Iy3F++zFTziq9h8dyVLA+N7ni5GTg4JAROJx7t+sXQx
        cnEICexmlPh34gEzhPOJUeJHz3eozGdGif0LlrDBtGw4vYYJIrGLUWLe/X1sEM5LRolTh3ey
        glSxCehK7FjcBpYQEdjJLHFh4hOwdk4BC4mLc+cwgdjCAlESr/8fZQaxWQRUJGYveQrWzCtg
        KXFn+0ImCFtQ4uTMJywgNrOAvMT2t3OYIc5QkPj5dBlYvYiAlcTVM7eZIGrEJV4ePcIOslhC
        YCWHRMfPQywQDS4Sy37cYYSwhSVeHd/CDmFLSbzsbwOyOYDsbImeXcYQ4RqJpfOOQbXaSxy4
        MocFpIRZQFNi/S59iFV8Er2/nzBBdPJKdLQJQVSrSjS/uwrVKS0xsbubFcL2kJj1/yQ0eLsZ
        JVrbprNNYFSYheTLWUi+nIXkm1kImxcwsqxilEwtKM5NTy02LTDOSy2Hx3hyfu4mRnDK1fLe
        wfjowQe9Q4xMHIyHGCU4mJVEeO+fV0kS4k1JrKxKLcqPLyrNSS0+xGgKDPqJzFKiyfnApJ9X
        Em9oYmlgYmZmZmJpbGaoJM57Kn1DopBAemJJanZqakFqEUwfEwenVAOT4ztVx+qrU1/Iuby5
        e23XNJEnTg1+jXx5ZZOaxE/7Mbp+1U974dC/yEKTRbx19q9lmvOX9WSsXrFbJXPPxAYO0Wbx
        tO9B79XtHy45c7rrV9TppKwXLb9F/9alnOpdZpZ8nuVQxGr5mR1VeaavI9IrOiNMdfMyK2vZ
        57oGHcuXYV1+Vt1jscuOS5eMy4y9nL0uT/pm2Xr4rolWxvrmGUoTDmd9U1wU2LtIderH54um
        fPDh/yGzpvvshQQFP6bNDB8kj27QXrKw7JPy5aStaxX3pe5iqip+cYP/pvLW3i+znUsX+4oe
        vrkiyO6F06EVVStkDjLXTLsQJraB7/L2XxN6tAqdI1jYNofeEFpsvk9SiaU4I9FQi7moOBEA
        4Og6kkIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LZdlhJXrfGVy3J4PM8M4uNb38wWZxtesNu
        8fxjI7PFpsfXWC0u75rDZtGzYSurxYzz+5gslm36w2Rx+E07q8XsE4tZHbg8ZjX0snnsnHWX
        3WPTqk42j81L6j36tqxi9Pi8SS6ALYrLJiU1J7MstUjfLoEr4+3F+2wFj/gqNt9dydLA+J6n
        i5GTQ0LARGLD6TVMILaQwA5GiT+vYyDi0hLXN05gh7CFJVb+ew5kcwHVPGeUaN82A6yBTUBX
        YsfiNjaQhIjAfmaJm9N/MEJUdTJKLD+5HqyKU8BC4uLcOUA2B4ewQITEux0SIGEWARWJ2Uue
        soLYvAKWEne2L2SCsAUlTs58wgJSziygJ9G2kREkzCwgL7H97RxmiIMUJH4+XQbWKiJgJXH1
        zG0miBpxiZdHj7BPYBSahWTSLIRJs5BMmoWkYwEjyypGydSC4tz03GLDAqO81HK94sTc4tK8
        dL3k/NxNjODI0tLawbhn1Qe9Q4xMHIyHGCU4mJVEeO+fV0kS4k1JrKxKLcqPLyrNSS0+xCjN
        waIkznuh62S8kEB6YklqdmpqQWoRTJaJg1OqgalA5JTNpJW5d8V/f3/l9DjZ9fTu10Y/rB9P
        EpuS9UDjvlOdTGN/SfaXdUuj7qt/0Fofeaxw3carry78PTnn8JRFJX4TQrsmb9zEc0pH4NXH
        LyulgnmbK1UvXBCaZfe8POZVd7Kahkq5jYrgGfU782/NyQr+lbcvxIHrJaOt+jmllQeu6pU9
        tzT69rwgUVJX9sjDYnvBI5+yL1a1NXUvij64LWHZqbkrj/08XnCoVsHvnt8X1pfHTcVcQ/0L
        OJ8Hm196LjZrf426/mOWYv6gWbOmzArM4L4nyLzl+Ks/Gv6iHIJlmeKXnmWzpPQsmpVwQ3F/
        uCbLtm9J36VWfJR4aZpd3bFU+NHiSW23w3IPuV5SYinOSDTUYi4qTgQA1XfYgRsDAAA=
X-CMS-MailID: 20220307182252epcas5p4382147bb249de325f1c4701f639a39fa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220307075251epcas5p333746646f6990bb305bbffdef6b173b3
References: <CGME20220307075251epcas5p333746646f6990bb305bbffdef6b173b3@epcas5p3.samsung.com>
        <20220307075206.10737-1-linmq006@gmail.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Miaoqian Lin [mailto:linmq006@gmail.com]
>Sent: Monday, March 7, 2022 1:22 PM
>To: Sylwester Nawrocki <s.nawrocki@samsung.com>; Mauro Carvalho
>Chehab <mchehab@kernel.org>; Krzysztof Kozlowski
><krzysztof.kozlowski@canonical.com>; Alim Akhtar
><alim.akhtar@samsung.com>; Kyungmin Park
><kyungmin.park@samsung.com>; Younghwan Joo
><yhwan.joo@samsung.com>; linux-media@vger.kernel.org; linux-arm-
>kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linux-
>kernel@vger.kernel.org
>Cc: linmq006@gmail.com
>Subject: [PATCH] media: exynos4-is: Fix PM disable depth imbalance in
>fimc_is_probe
>
>If probe fails then we need to call pm_runtime_disable() to balance out the
>previous pm_runtime_enable() call.
>
>Fixes: 9a761e436843 ("[media] exynos4-is: Add Exynos4x12 FIMC-IS driver")
>Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>---
Thanks for fixing this

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

> drivers/media/platform/exynos4-is/fimc-is.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/media/platform/exynos4-is/fimc-is.c
>b/drivers/media/platform/exynos4-is/fimc-is.c
>index e55e411038f4..81b290dace3a 100644
>--- a/drivers/media/platform/exynos4-is/fimc-is.c
>+++ b/drivers/media/platform/exynos4-is/fimc-is.c
>@@ -830,7 +830,7 @@ static int fimc_is_probe(struct platform_device *pdev)
>
> 	ret = pm_runtime_resume_and_get(dev);
> 	if (ret < 0)
>-		goto err_irq;
>+		goto err_pm_disable;
>
> 	vb2_dma_contig_set_max_seg_size(dev, DMA_BIT_MASK(32));
>
>@@ -864,6 +864,8 @@ static int fimc_is_probe(struct platform_device *pdev)
> 	pm_runtime_put_noidle(dev);
> 	if (!pm_runtime_enabled(dev))
> 		fimc_is_runtime_suspend(dev);
>+err_pm_disable:
>+	pm_runtime_disable(dev);
> err_irq:
> 	free_irq(is->irq, is);
> err_clk:
>--
>2.17.1


