Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71175AD078
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236829AbiIEKqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236871AbiIEKpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:45:55 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47B64CA2F
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 03:45:45 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id k18so8763286lji.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 03:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=W69Vs2PjXxoraCQlPh4+6M3rHPAGmG+kvtSh7YS+E3s=;
        b=AW61JFaURA48E3KTej8UgN8KNvJ8qKsCJgMdzs4g0oBuq5ptu7gUT7gjfuYR3TWI8I
         AazrKWuwuKoRjRHXQLEa1mP2CpPTwITFAEzA6LRkIsHIC37/kfXpt74v53XFgfVfYIk9
         t770rnnXBaZb9S5jhpdkQ7fviNSGH7jA5aPjJfox1BNkHUp87U7npf2r78E75yRDu1CN
         nnjD0DozAuYclTnLWSuxBBzOj0xZkkGOEDutaUnTcvXbC5WoIWFNZqrJbe8PbijSSOLG
         lq8nYTrEhnYFWQGQ4cGh6YyqFN4pUrd+ZiNF+ACq9Gizz7gF3lQWPuQHzG1y5nAm+LbL
         3xyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=W69Vs2PjXxoraCQlPh4+6M3rHPAGmG+kvtSh7YS+E3s=;
        b=ja13UFUFU/XQ+fyKxbmL4bpEGkP3jm9Fv5kdd0DY4mQ4C1ww5WXt88B2fsLaZLEqSC
         QSTsHnOp/XH/FVHpzVw40ibvHfZij0TDWf3od2E6G8vTv7Cgg2+n4162KvQJfizub2RH
         XNksDYlRuppp0+rwlc1Vzy8AWQl2EIFbZOYk35buk6C7dONQnKkd/hX4Jvp86/O/RLDO
         V9YfyizmGGAQ4Qnt2vzeqr+R0ZKmQanTWhaDac+LxU8R9r0NwZBNG4Oq17X/EfHkbU0f
         uQI6KeW4Qu3N2Ce/3X7Hn9T8m1iiWX31XCl04PiS2jS2vSDoh1QElXLH52jbk1Z7kEp6
         y/dg==
X-Gm-Message-State: ACgBeo2Ewt3mzd4hUIjyXFc2aAGslZ1Kqx6c9JKZ3vpvW9EmbPi/ekj+
        gvQyuFFpm0d9IICgX2NG5V4cNg==
X-Google-Smtp-Source: AA6agR42rJJofkeLobN6evt9ulB6GLt81Xa4EA55FaN+PHfYGfuLzKu30TtHplssKHVBkLngiy3V6A==
X-Received: by 2002:a2e:92c4:0:b0:25d:9d30:5d61 with SMTP id k4-20020a2e92c4000000b0025d9d305d61mr15180344ljh.202.1662374744203;
        Mon, 05 Sep 2022 03:45:44 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id j13-20020ac2454d000000b0048d076373d0sm1149901lfm.98.2022.09.05.03.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 03:45:43 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>
Subject: [PATCH] checkpatch: move duplicate sign off to separate warning type
Date:   Mon,  5 Sep 2022 13:45:42 +0300
Message-Id: <20220905104542.2368950-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some maintainers prefer to allow duplicate signatures if that provides
additional details about the patch flow. E.g. if the original patch
author pulls the patch from the patchwork into the kernel branch, this
can result in duplicate SOB tags from him, however this reflects the
patch flow (one SOB for being the author, one SOB for pulling the patch,
adding (and maybe fixing) tags and pushing the patch further.

To facilitate easily handling this kind of warnings, separate duplicate
SOBs into the separate warning class ('DUPLICATE_SIGN_OFF').

Cc: Rob Clark <robdclark@gmail.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 79e759aac543..f95d4ac19901 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3115,7 +3115,7 @@ sub process {
 			$sig_nospace =~ s/\s//g;
 			$sig_nospace = lc($sig_nospace);
 			if (defined $signatures{$sig_nospace}) {
-				WARN("BAD_SIGN_OFF",
+				WARN("DUPLICATE_SIGN_OFF",
 				     "Duplicate signature\n" . $herecurr);
 			} else {
 				$signatures{$sig_nospace} = 1;
-- 
2.35.1

