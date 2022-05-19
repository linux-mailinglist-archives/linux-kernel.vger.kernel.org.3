Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61AA52C8CA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 02:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiESAmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 20:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbiESAl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 20:41:59 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F502B1B8
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 17:41:46 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220519004141epoutp0250756845cc65605c0d280f89539a9137~wWs1KH5Ih0183401834epoutp02b
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:41:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220519004141epoutp0250756845cc65605c0d280f89539a9137~wWs1KH5Ih0183401834epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652920901;
        bh=1/6+G1PwL9P9KchBj2p5sbz8lwiQyq4Yp2+xeM30yOs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=mFmEbI47tdVy/0JRSprUy0T3P9gotTXJlUcZ/5SVzsuxP7wNMO6NTwSRIhlc4dh7P
         9ki8AjxNSaxX4X1vQ2XHAMhWPRQME3tMm211yeyr+DrBuI4Ww3HrzL2czrJmS/Lhie
         0hqR5Po+AjqKq+syX3H3QZh+upqrydcTNcEYuQDQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220519004140epcas1p2fbd9fd8953e1f1b9c204e6f2cd8df1ec~wWs0U8JdL2792127921epcas1p2O;
        Thu, 19 May 2022 00:41:40 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.133]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4L3WJM1FdJz4x9QD; Thu, 19 May
        2022 00:41:39 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        85.DB.10354.34295826; Thu, 19 May 2022 09:41:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220519004138epcas1p1cb026c559dacbf3f8525910293b2de89~wWszBcPf32697226972epcas1p1t;
        Thu, 19 May 2022 00:41:38 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220519004138epsmtrp2b8212b74ac9262af585ebd354b2ff553~wWszAsLHN1245412454epsmtrp2D;
        Thu, 19 May 2022 00:41:38 +0000 (GMT)
X-AuditID: b6c32a38-4b5ff70000002872-22-62859243f91c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        81.F3.08924.24295826; Thu, 19 May 2022 09:41:38 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220519004138epsmtip2b5f07f510de34158f06eb580f1b77c23~wWsy10rEz1367213672epsmtip2I;
        Thu, 19 May 2022 00:41:38 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, cw00.choi@samsung.com,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
Subject: [PATCH] PM / devfreq: passive: Return non-error when not-supported
 event is required
Date:   Thu, 19 May 2022 10:07:53 +0900
Message-Id: <20220519010753.32228-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIKsWRmVeSWpSXmKPExsWy7bCmga7zpNYkg5M9bBYTb1xhsbj+5Tmr
        xdmmN+wWl3fNYbP43HuE0WLtkbvsFrcbV7BZnDl9idWBw2PTqk42jy1X21k8+rasYvT4vEku
        gCUq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6Awl
        hbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFpgV5xYm5xaV66Xl5qiZWhgYGRKVBh
        QnbG264nbAWfuCp+bH7K1sA4l7OLkZNDQsBEov3aU5YuRi4OIYEdjBL9t2+yQTifGCW+XbgC
        lfnMKPF95yImmJb/G++yQiR2MUr8u7aVHcL5wihx9dUkVpAqNgEtif0vbrCB2CICohKXd09g
        AbGZQZZceGgDYgsLxEvMPbGdEcRmEVCVWLl0MtAgDg5eASuJy2uh7pOXWL3hADPIfAmBTewS
        fZunQl3hInHvyw82CFtY4tXxLewQtpTE53d72SAamhklGl7cZoRwehgljj7rY4GoMpbYv3Qy
        E8g2ZgFNifW79CHCihI7f89lhDiUT+Ld1x5WkBIJAV6JjjYhiBJlicsP7kLdICmxuL0T6gYP
        iVeHnoG1CgnESjxvfMsygVF2FsKCBYyMqxjFUguKc9NTiw0LTODRlJyfu4kRnLa0LHYwzn37
        Qe8QIxMH4yFGCQ5mJRFextyWJCHelMTKqtSi/Pii0pzU4kOMpsAAm8gsJZqcD0yceSXxhiaW
        BiZmRsYmFoZmhkrivL1TTycKCaQnlqRmp6YWpBbB9DFxcEo1MAmf6UrVdK4Waj8TptKwU1W7
        0qvHR/yazKptgd8dt4WLLgmVWs2/YX3TmUyhM5sZ0149sLtXdXkxd6Rdtp/w5o33pjBF+FWd
        vXWU7/zVOQurumK4qyvcy58+ynC9EOb1JcryqsjU2phPieU5fNZ7DRlWLI2RX8q84CSHw9w4
        7ttSJ1YFf6n4XHDGsJ0jP+aniItn8ZnFk9LOlN6t6wj38A70tty+b6leUsYHo07FnuJLu9xD
        TyxwDV5itNfntNGNy/kf9Hsd81pmP+y5Oadw04/lPhWL819z/zKsXXczp2DGsbfeV87Z8x3W
        YVrtWJ1tp+slwfKXNTBWf0Po/gi3a796VKrqkn4+59YLXXFGiaU4I9FQi7moOBEAYDOCGOQD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHJMWRmVeSWpSXmKPExsWy7bCSvK7TpNYkg8656hYTb1xhsbj+5Tmr
        xdmmN+wWl3fNYbP43HuE0WLtkbvsFrcbV7BZnDl9idWBw2PTqk42jy1X21k8+rasYvT4vEku
        gCWKyyYlNSezLLVI3y6BK+Nt1xO2gk9cFT82P2VrYJzL2cXIySEhYCLxf+Nd1i5GLg4hgR2M
        Emd2HWWFSEhKTLt4lLmLkQPIFpY4fLgYouYTo8S954fBatgEtCT2v7jBBmKLCIhKXN49gQWk
        iFngAKPE6o+bGUESwgKxEq8mnWcCsVkEVCVWLp3MDjKUV8BK4vJaqCPkJVZvOMA8gZFnASPD
        KkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4CDS0trBuGfVB71DjEwcjIcYJTiYlUR4
        GXNbkoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgqkmr
        691y9mXloYJ3B2czNuh5fJ6b/Sy11i9o4nuJ97mJuv1lawTl3AI9/tVYW36epfE0xj3x6a0N
        OSazKv1XXd76wuVby/HC4Hrzq6aNQhqRIfwdnxcs+8yZff3iDp138XIGEaFv57Jlrruxx3jx
        O85360/pyxr5ckpZ/TS8p/B86fzz9+0dPu558y9u21pptkNftk/KiGg67Oz5QvSmMI+sC3t3
        x22TswXum/+faq3fVVR6TnPbYUaFN+/2/2qfEsPPPdVA7d5Xs5gpcyeXZ0wvL6m/ZVf5u35C
        7g6uUy/VryrOXcsiL9Z40i21rHuK7Fa/I7MqV0+3+3snw2rPNZuVanG/NpyYr7HAOVj3jRJL
        cUaioRZzUXEiADvNkLGRAgAA
X-CMS-MailID: 20220519004138epcas1p1cb026c559dacbf3f8525910293b2de89
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220519004138epcas1p1cb026c559dacbf3f8525910293b2de89
References: <CGME20220519004138epcas1p1cb026c559dacbf3f8525910293b2de89@epcas1p1.samsung.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each devfreq governor specifies the supported governor event
such as GOV_START and GOV_STOP. When not-supported event is required,
just return non-error. But, commit ce9a0d88d97a ("PM / devfreq: Add
cpu based scaling support to passive governor") returned the error
value. So that return non-error value when not-supported event is required.

Fixes: ce9a0d88d97a ("PM / devfreq: Add cpu based scaling support to passive governor")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
Dear Rafael,

This patch fixes the issue of the pull request[1].
I'd like you to apply it to linux-pm.git direclty.
[1] https://patchwork.kernel.org/project/linux-pm/patch/3acd6c32-6e78-dfc2-3e45-84f69a7d5f36@samsung.com/

Best Regards,
Chanwoo Choi

 drivers/devfreq/governor_passive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 7306e943a234..72c67979ebe1 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -402,7 +402,7 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
 {
 	struct devfreq_passive_data *p_data
 			= (struct devfreq_passive_data *)devfreq->data;
-	int ret = -EINVAL;
+	int ret = 0;
 
 	if (!p_data)
 		return -EINVAL;
-- 
2.17.1

