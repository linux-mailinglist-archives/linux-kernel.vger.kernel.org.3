Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E35527793
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 14:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236808AbiEOMoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 08:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236783AbiEOMnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 08:43:41 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D693B1262F
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 05:42:46 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso11860364pjg.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 05:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GLuZhVjtGK5TbXwgi8Odrp2p8Tu7QkWjhdCCk7ovaas=;
        b=fHtUivnJoBf3l4Gf5biNPi9eZWy15SghJR1BJwRCBbwC7wMdjWc/qEjslDCqaSNuTu
         h52U9exkwSZj6vYxkXcLULEg4OFBLPXo89w/bT2QGVDandmJsW0Yy2M8qro0mjRC0ia5
         FdwD52GptLNwKXd/ssnRQy5zjgdlOb87+AeGdq04w+DWssKGTs8D/rcPVdY2Ygz/RyfZ
         BiX/N1hvuDm64MZ9kVjwYOWb4gjHA0FK70BOPAkFdW+9WDSNigqjlBowPo6dAHXgiTMj
         TaOYMNDu52zdlH5+DjwOHW1hECQSAhWnxB3Q6WdHXaTr2g/+kOS35KwTvxaZkr8OV924
         /kfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GLuZhVjtGK5TbXwgi8Odrp2p8Tu7QkWjhdCCk7ovaas=;
        b=h5uV2dU+mas0+ovarxJ2D836PaiQReRD499a4ztF7wkF5cKtOgSxmP5qzcz3c7GL+m
         8BJ3fD1cY+K23Acr6UU28sOXi5VUYBo3anF/XfYvnZ/ux+CRnfyGJoTnEjVbJ9KMnn4D
         yL6jMjfrKEm6hrznVkZ1qGAMp/zWusDlXWb4PKuyyMZtuI+ul3O+Hg2KFxRLN4Qo6O6m
         bYfHoarh7GT8/W6BqsU8ViRYvHUPN5I+gnCJSrcfseUeGNbwEF7Sl1hPaF3p5nIGlMPF
         O9xZYfCFVZ+HsIcDHJRcsvdOrGW3/iSVFqhTZ0C7p5R/TcCmEMJ3IC/3J0jtDkMbYk9I
         JQZA==
X-Gm-Message-State: AOAM531Bn3liTwvTNQKFydJwjG7wbeLYGmeRfTs6BD0+IDe5iMbqOypH
        b2YFcd+NKzmsi2bJg14qXmCc5ylx2HzvQQ==
X-Google-Smtp-Source: ABdhPJyfDRaC1XGZwXsUE0diCH1PbRApttn1a39/4+JR6GneKpJfCrvz3Sa/Jrpxp8+gb+crg+a9jQ==
X-Received: by 2002:a17:90b:4b4b:b0:1dc:8724:3f75 with SMTP id mi11-20020a17090b4b4b00b001dc87243f75mr25340838pjb.178.1652618565106;
        Sun, 15 May 2022 05:42:45 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id t12-20020a17090a950c00b001dbe7ccdd4dsm6551557pjo.10.2022.05.15.05.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 05:42:44 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Subject: [PATCH 11/13] openrisc/delay: Add include to fix symbol not declared warning
Date:   Sun, 15 May 2022 21:41:56 +0900
Message-Id: <20220515124158.3167452-12-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220515124158.3167452-1-shorne@gmail.com>
References: <20220515124158.3167452-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add asm/timex.h include for read_current_timer prototype.

Sparse reporting the following warning:

    arch/openrisc/lib/delay.c:23:5: warning: symbol 'read_current_timer' was not declared. Should it be static?

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/lib/delay.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/openrisc/lib/delay.c b/arch/openrisc/lib/delay.c
index 036ae57180ef..5e89e4131304 100644
--- a/arch/openrisc/lib/delay.c
+++ b/arch/openrisc/lib/delay.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/init.h>
+#include <linux/timex.h>
 #include <asm/param.h>
 #include <asm/delay.h>
 #include <asm/timex.h>
-- 
2.31.1

