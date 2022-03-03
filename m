Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075664CBBCB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 11:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbiCCKzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 05:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiCCKzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 05:55:50 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E6F17B8B0
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 02:55:05 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id c16-20020a17090aa61000b001befad2bfaaso4030465pjq.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 02:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LOKDfXoc6DRu5i9y+/Gf8kTJRx+p19+Ylc8lcfLwnek=;
        b=cVE++4BoMvVudo7EGPc5i3dFHXP7zNpjcrdtHvrbZWt0DNzBZYNvwOMgyQhQNJwd3o
         fB57nT9lREKW4SB3g9smgLkrfB2GuxgZLmjk/FeCZbygezVf9rsc/tFhAiPiJ7W/bYyS
         fvpbfxGEvYAMqIUqgExlsP2icWfnzPy8VB3QvUfG3k6GGi5ajFe+F734GV1Jitogc+N6
         0tPS/4b72GWD360ifMqA0M/gUaRHblpNT6mjUTzGxFLMjcZxlVGTzGkKKBItDAOI2Jx3
         /wt2E0FV2+GJsvwyggxQq0r1u9UlhA+5wEoKh5FlLJzVL09+MF1UgvOnlESZ1hjWxhO/
         18Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LOKDfXoc6DRu5i9y+/Gf8kTJRx+p19+Ylc8lcfLwnek=;
        b=c8nnRwELhS9lW3x3gxol9b52xwoPoFOkpa0hg8MtGIXXhfZjxWAfmISVT9HruEMnnm
         2glkDgueKnBaWwF1waw49aWr9Wu4NL8mvcDSp/mwXjl1QAwbE7RTWQOUm2rDQBQjbGYc
         RXa9yPVJwMgrV7PbEHXBXvtc3bRgcbyfZCdb0bfIBTJ1uCKPM/BpwteDPS3vBHAohiee
         lvOHenSZtkld2IPG/7kpb6V2dULbXI6pn3aObMNq/J/DdXOhbucfcYdNXYrHLrHIyiy7
         0ILi90bX6c4C2UllHD2vCJqAHt2SI7yIymgCyoB9rFTNid8M0tqXhc38S/2qpijTw2pm
         DYkg==
X-Gm-Message-State: AOAM533Dh98Pj/yoBCbyRkugpB78HEiH/wRvC4bn3WA6oi6EhVwCDAXB
        yKTIUVgRflrPasAPHnOMh5+C0w==
X-Google-Smtp-Source: ABdhPJzz+Kh8yVj4+bCZG+773p6bSMnm7TzRtIX9kd0CUL1HhG3Y4eABhrLpJt7JYu2fCh5pYqZN1A==
X-Received: by 2002:a17:902:9a4c:b0:14d:b0c0:1f7a with SMTP id x12-20020a1709029a4c00b0014db0c01f7amr34838722plv.57.1646304904642;
        Thu, 03 Mar 2022 02:55:04 -0800 (PST)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id w5-20020a056a0014c500b004f3a5535431sm2352484pfu.4.2022.03.03.02.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 02:55:04 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     jpoimboe@redhat.com, jikos@kernel.org, mbenes@suse.cz,
        pmladek@suse.com, joe.lawrence@redhat.com
Cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2] livepatch: Don't block removal of patches that are safe to unload
Date:   Thu,  3 Mar 2022 18:54:46 +0800
Message-Id: <20220303105446.7152-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

module_put() is currently never called for a patch with forced flag, to block
the removal of that patch module that might still be in use after a forced
transition.

But klp_force_transition() will set all patches on the list to be forced, since
commit d67a53720966 ("livepatch: Remove ordering (stacking) of the livepatches")
has removed stack ordering of the livepatches, it will cause all other patches can't
be unloaded after disabled even if they have completed the KLP_UNPATCHED transition.

In fact, we don't need to set a patch to forced if it's a KLP_PATCHED forced
transition. It can still be unloaded safely as long as it has passed through
the consistency model in KLP_UNPATCHED transition.

But the exception is when force transition of an atomic replace patch, we
have to set all previous patches to forced, or they will be removed at
the end of klp_try_complete_transition().

This patch only set the klp_transition_patch to be forced in KLP_UNPATCHED
case, and keep the old behavior when in atomic replace case.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
v2: interact nicely with the atomic replace feature noted by Miroslav.
---
 kernel/livepatch/transition.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 5683ac0d2566..34ffb8c014ed 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -641,6 +641,10 @@ void klp_force_transition(void)
 	for_each_possible_cpu(cpu)
 		klp_update_patch_state(idle_task(cpu));
 
-	klp_for_each_patch(patch)
-		patch->forced = true;
+	if (klp_target_state == KLP_UNPATCHED)
+		klp_transition_patch->forced = true;
+	else if (klp_transition_patch->replace) {
+		klp_for_each_patch(patch)
+			patch->forced = true;
+	}
 }
-- 
2.20.1

