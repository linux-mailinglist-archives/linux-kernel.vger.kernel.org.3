Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F33473791
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243649AbhLMWd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243677AbhLMWdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:33:50 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3EFC061D72
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 14:33:42 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id p18so12175010plf.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 14:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I3eqcTIWiC+KHyQNr9D4gbvRaeijCgA+zD3SwshilTo=;
        b=bSotBO1SifpAEcn65dx6taJwcyVfz70TuvaLmRPzGaoK9y1HTyzmxWlb/dtNfrgYEQ
         8epiPZSD71JVyY8D/Nwlrsil5OLe5OWwJmyUOOCx+9P0CSr7rJHBN/vWbZq9dbLt/pXb
         8iiXLz+CqQlt+qI4AGu7Dtxt9SHIHEV7m8T9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I3eqcTIWiC+KHyQNr9D4gbvRaeijCgA+zD3SwshilTo=;
        b=yJwo1ZuEvg+YhMcMWgtEVek2bRl3ruROnXn4Isg7gAbKy4ryx4o/w1v+F22zH1sbBH
         /Q6w4RiwE796obZhwO3w1cHq5sESi+yOkM4z2Pe+X3yGT5vBOxesvb3B2cHLdZYeCarh
         2v6sSHmkoNX/g2Crxxr0+kk2+ntSGhYXswgFnncMCsJ9mvEGcMCfN8dffKJc2nMnSZIR
         ZLABwi6/BG9UOicMgyY4XN++HC0tk//i1x0+daAq5Z8i8Rwy6wvqVqVBNRAMjv0ATpuV
         Vy4ugFoJcCMyNxLCoAo93x9JRKHgbPYKOp+hEm56QGHyCqmLF4M8oIt2PrdvfvhyA5XB
         I2SA==
X-Gm-Message-State: AOAM532DtcrSZjUpaNQ5VkFKOpttpPMQct7NzN/9MBvKXjmtMqp9cYsj
        8avui90aDgq9+cJVlN/dGauSkw==
X-Google-Smtp-Source: ABdhPJydJaUt968ItHIsV+C+S8DmxMrxQt/Lk2QzQLpgJNl2hHaYMZ8aIZwavexDYTU8q4oLhCgpOw==
X-Received: by 2002:a17:90b:e83:: with SMTP id fv3mr1153098pjb.115.1639434821738;
        Mon, 13 Dec 2021 14:33:41 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q17sm14966913pfu.117.2021.12.13.14.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 14:33:40 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Raju Rangoju <rajur@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/17] iw_cxgb4: Use memset_startat() for cpl_t5_pass_accept_rpl
Date:   Mon, 13 Dec 2021 14:33:26 -0800
Message-Id: <20211213223331.135412-13-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211213223331.135412-1-keescook@chromium.org>
References: <20211213223331.135412-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2404; h=from:subject; bh=NRZzV2Wm+qN1hLpw7oPDOvO2yOStk7XcopUutjYf66w=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBht8o5I5L7op6wxBNo8ZoE2HZhjRGQ3UxHlr8nNIus yAqJvR6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYbfKOQAKCRCJcvTf3G3AJp1zD/ 9jAFtNeIQm4EewUKA78ifdR6IkV6fNLr41dqbxD0xSgeQS7WokCTQXDEw8OfoPXzLUR0Jdi66DbXNg KG+CiCejrRqs6r08bnPj02LGJEyYzQ7ZwUShJC7B1rJ4Tn7NIVLWlKK29Wbi+eocXdHhSFKezYG3SQ 6Ltml+Nij5zu1T9ZZk09JiJg8zP3JekDyjIq7BGuZWAhddAU/l/C4eLIFQcFaF7huoImo3aXgVVVyI H19k9KJR9zQPTsr8wrHwCVVmlaQISb3Wy8DXFFBwFHz6K7L4mse4I3HxL64l/wJzZbpqVfJ4OXiyyU eIk2EekyUx8315bGoYkRryWNwIlFmiwOJsx9ZGX4HDKGqCGbrOFfAVUzn3rvJEjiBVCoqXxoU47qFq DW6AMqHa4Z2J5I+fsEdrarF+6Rs9MWFeOlPvt0KMsLCCDAgqiKiwK+RYNpR23zuSxXCUi5LjZbIySf OLs7o0i5LHW5129oVTW+uQELXJbUBN/EW9FJEd9GmR6USXdaFAK5+nbAJVZBuC33NIKnkwN09UcGMr LYIkrtghJWNmsCfcZXFJH/ZnAkh07XbcEjVILyAt2qfoTTD4zTJbBGjMdUumewIKLCurQoVF4LvpDL IJu5l+8Fr4zZRE80JbW+hvIlyij8sNL/K7c+cvFvR39dgMXtliIXLXRzui3g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Use memset_startat() so memset() doesn't get confused about writing
beyond the destination member that is intended to be the starting point
of zeroing through the end of the struct. Additionally, since everything
appears to perform a roundup (including allocation), just change the
size of the struct itself and add a build-time check to validate the
expected size.

Cc: Potnuri Bharat Teja <bharat@chelsio.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Raju Rangoju <rajur@chelsio.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-rdma@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/infiniband/hw/cxgb4/cm.c            | 5 +++--
 drivers/net/ethernet/chelsio/cxgb4/t4_msg.h | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index 913f39ee4416..c16017f6e8db 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -2471,7 +2471,8 @@ static int accept_cr(struct c4iw_ep *ep, struct sk_buff *skb,
 	skb_get(skb);
 	rpl = cplhdr(skb);
 	if (!is_t4(adapter_type)) {
-		skb_trim(skb, roundup(sizeof(*rpl5), 16));
+		BUILD_BUG_ON(sizeof(*rpl5) != roundup(sizeof(*rpl5), 16));
+		skb_trim(skb, sizeof(*rpl5));
 		rpl5 = (void *)rpl;
 		INIT_TP_WR(rpl5, ep->hwtid);
 	} else {
@@ -2487,7 +2488,7 @@ static int accept_cr(struct c4iw_ep *ep, struct sk_buff *skb,
 		opt2 |= CONG_CNTRL_V(CONG_ALG_TAHOE);
 		opt2 |= T5_ISS_F;
 		rpl5 = (void *)rpl;
-		memset(&rpl5->iss, 0, roundup(sizeof(*rpl5)-sizeof(*rpl), 16));
+		memset_after(rpl5, 0, iss);
 		if (peer2peer)
 			isn += 4;
 		rpl5->iss = cpu_to_be32(isn);
diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_msg.h b/drivers/net/ethernet/chelsio/cxgb4/t4_msg.h
index fed5f93bf620..26433a62d7f0 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_msg.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_msg.h
@@ -497,7 +497,7 @@ struct cpl_t5_pass_accept_rpl {
 	__be32 opt2;
 	__be64 opt0;
 	__be32 iss;
-	__be32 rsvd;
+	__be32 rsvd[3];
 };
 
 struct cpl_act_open_req {
-- 
2.30.2

