Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2942057D57A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiGUVD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGUVDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:03:50 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07154904F2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:03:49 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j11-20020a05690212cb00b006454988d225so2157920ybu.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=MypyzVZSccI/RyC46qp75Pb6XbMOH7vgHkqe/QUNPpo=;
        b=KGtiU3I1Yc2pPQ93b0InIC/VuuUUJbgRueIy0lePqllWiicPtHn7WKGz0btmVyk0nL
         aiESAnSPgMdxVpNrNxbm8kN8yCAVFNVcjTpucSpHAYSE/4g3cr+7PvvOcDS1S/WmdJX8
         1bAqIFb2pMUyuw6gH0P1UUR/bm+CYAqThTW+X12OC8EDQmew8lKXHz7R0gD25EtoIkQ4
         VUvy5J9eTKnl+OkrVTcPVKnTp4mJQs4yS7PHVCUCOqpffTDGby2D0gsUmTEr2m/Xa5Po
         7vSYyhpqZm4I52h3zF/v83BM8hHyPkWdvLqXeTCg1iWszKpT9akPaMxriel8j+qa6vNa
         3/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=MypyzVZSccI/RyC46qp75Pb6XbMOH7vgHkqe/QUNPpo=;
        b=wVtmYyB3ZyRAKealovTyGB7YM+1vUZUM+49ThQwaEItI4olphNOIU0m4QWItn88PV4
         ujOaaPfTwRhhVop2/hOyHSVy57B/ecCtDuGXTL7jvIGqewGIJkJnJLS56NJR4x6C35+X
         kvqPD9P50xPPWP0rwtPGIsNGHacN6//aFjya1QKmqcrAZ2+Q/n9sVOjmltiCN1vJvXg+
         pbXiE/m0HShSRlRDjRZYsukJwZ4i7KRZcPGzNsLNWE3rz70To9OvI23U71nD93NEIHc6
         N7cSNjToiRcr93LnnKyi9rwQln2fIpSV5KXJ3bUUH8kCeIQ5bBElP1Y+yfRK4Iif2HM9
         Mrig==
X-Gm-Message-State: AJIora/1JGFQPT44SLtX5oZP/9ECQn62PaY3oeJn5BC49U631zYNKvSy
        yOUu5Fo83LQXPyHQomcl6wDhAoRgJ3z/GYVMpA==
X-Google-Smtp-Source: AGRyM1sxwUS7zWxfuhFmDg/oyvsoaf1Wwexumse7I9VvtS1d218Qh2nHKoK4HZcdCT8xWr/B9mnpWLyMLY0auVLITw==
X-Received: from justinstitt.mtv.corp.google.com ([2620:15c:211:202:21e:d672:5a6a:420e])
 (user=justinstitt job=sendgmr) by 2002:a25:bd42:0:b0:670:be21:78a5 with SMTP
 id p2-20020a25bd42000000b00670be2178a5mr460245ybm.478.1658437428335; Thu, 21
 Jul 2022 14:03:48 -0700 (PDT)
Date:   Thu, 21 Jul 2022 14:03:31 -0700
Message-Id: <20220721210331.4012015-1-justinstitt@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH] drivers: iommu: fix clang -wformat warning
From:   Justin Stitt <justinstitt@google.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with Clang we encounter the following warning:
| drivers/iommu/msm_iommu.c:603:6: error: format specifies type 'unsigned
| short' but the argument has type 'int' [-Werror,-Wformat] sid);

`sid` is an int, use the proper format specifier `%x`.

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Reported-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Reported by Nathan here:
https://lore.kernel.org/all/YtmrCJjQrSbv8Aj1@dev-arch.thelio-3990X/

 drivers/iommu/msm_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 428919a474c1..6a24aa804ea3 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -599,7 +599,7 @@ static int insert_iommu_master(struct device *dev,
 
 	for (sid = 0; sid < master->num_mids; sid++)
 		if (master->mids[sid] == spec->args[0]) {
-			dev_warn(dev, "Stream ID 0x%hx repeated; ignoring\n",
+			dev_warn(dev, "Stream ID 0x%x repeated; ignoring\n",
 				 sid);
 			return 0;
 		}
-- 
2.37.1.359.gd136c6c3e2-goog

