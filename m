Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC90503446
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiDPE24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 00:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiDPE2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 00:28:50 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C069C10E067
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 21:26:20 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c12so8473776plr.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 21:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KBVMtZkCYV32p1etltthkvwAoUXM8dM83npMiYgUh/w=;
        b=cqy6eRhcdih66RqCTWjHb297/2SFSexwmd2okcLZgVZEEqaOnpUDO5AKVY+cUAxawo
         /oBVREYAyWGQolkfrsbFcRIYUxyTUEb0prVYzMBn0B5n/rB8mctUu+xTUwv5Co9Sw5oE
         0zt4AV0+V8oWrFQ0cRSabQKe1dhgmS4poAH32TnZyn+wAki9bN9BJP70HcpMk4nKMyJu
         m9Rpi2gEe5Whqp2xziQEIzZFUaF6V+k4Q77O7z8/RGP2NhVgURHVcHxcMEjDdKOfuZf6
         xCQDF5SR9PeCD7TfzyaCekaj6jR8x91kr1Y6iVx/CqXtW6fM85i0Yf8HWVkbZGxJZq6Y
         KS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KBVMtZkCYV32p1etltthkvwAoUXM8dM83npMiYgUh/w=;
        b=0+jE2M10cO1H/8j/j+67wl9zbOTkNer8Rjbu00Dfmf02TLGmxBc89abQMe8c1/tsT5
         IOf0oFlIJamztKem3yi2wip6T1Kd7gO628TtAtmxHBThhq1vSixhRL6nLQslk8Wu72KY
         92+ZZxFpSHCQEsEeDZ6ivyBx9HPCvT+oqQ41FY69gp3gV3kQyw2P3Sbyw5/fbpMcacJB
         lZt+aDq2zVEP9bzKr/6qJkHSgSQ58sR1ti5mctGJmSYaQcXaC04lz0cFD+vpx8WPsru0
         7hEMF+FkCgTxGan4/5O0Qoj65fKWHyrY99L/b0ozNH9banx3umnPo7N20kUSazGq4Twf
         EZzA==
X-Gm-Message-State: AOAM5335d19974ltT+PJAxs9kN9mWR/Ff6nVii7xvXWDatZRjlf8jO+d
        4L4DQ7XdBO+s2ikyyG7UMZ0=
X-Google-Smtp-Source: ABdhPJx6ECAXsP/4flRg5/N6HdnBc7pZXMLqvV2IlWZ5mKExN4qZbQJr0vfEWvAd14AtSTBKrecCig==
X-Received: by 2002:a17:90b:1b47:b0:1d0:fdb2:6fb with SMTP id nv7-20020a17090b1b4700b001d0fdb206fbmr2166841pjb.186.1650083180228;
        Fri, 15 Apr 2022 21:26:20 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:9b6:6aad:72f6:6e16])
        by smtp.gmail.com with ESMTPSA id d8-20020aa78688000000b00505793566f7sm4258513pfo.211.2022.04.15.21.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 21:26:19 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 2/6] xtensa: clean up declarations in coprocessor.h
Date:   Fri, 15 Apr 2022 21:25:55 -0700
Message-Id: <20220416042559.2035015-3-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220416042559.2035015-1-jcmvbkbc@gmail.com>
References: <20220416042559.2035015-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop 'extern' from all function declarations. Add argument names in
declarations.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/coprocessor.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/xtensa/include/asm/coprocessor.h b/arch/xtensa/include/asm/coprocessor.h
index 0fbe2a740b8d..a360efced7e7 100644
--- a/arch/xtensa/include/asm/coprocessor.h
+++ b/arch/xtensa/include/asm/coprocessor.h
@@ -143,10 +143,9 @@ typedef struct { XCHAL_CP7_SA_LIST(2) } xtregs_cp7_t
 	__attribute__ ((aligned (XCHAL_CP7_SA_ALIGN)));
 
 extern struct thread_info* coprocessor_owner[XCHAL_CP_MAX];
-extern void coprocessor_flush(struct thread_info*, int);
-
-extern void coprocessor_release_all(struct thread_info*);
-extern void coprocessor_flush_all(struct thread_info*);
+void coprocessor_flush(struct thread_info *ti, int cp_index);
+void coprocessor_release_all(struct thread_info *ti);
+void coprocessor_flush_all(struct thread_info *ti);
 
 #endif	/* XTENSA_HAVE_COPROCESSORS */
 
-- 
2.30.2

