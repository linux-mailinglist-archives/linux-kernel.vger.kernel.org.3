Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E138553B460
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 09:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiFBHdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 03:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbiFBHdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 03:33:33 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C6839693
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 00:33:32 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id nn3-20020a17090b38c300b001e0e091cf03so5377530pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 00:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4N/Lk36lipkDU53ZRR8qjoGWWF84HiYcC9KOS2IHfpg=;
        b=itcTzhwLpgRWAt9zNZ7rNinHgPkCSdA7ks0tL3dTyqu5mr2DLmcRbF8lEE3FZcVECd
         RGP9PSM+Df+7Yjwxgw1ffhtuKQMDNI6H14RNOtR2hheNAgSErkXilXt8E+7kXPmqM5Gt
         zQ65rXYAovZ0YLZ9aHQoQmAU+i3M9I6GzQ+atPLpmUBONaWRrQqGVYPar+HRmpOahmmB
         vFyR8l9ghzHavgWjQcZUa0tz0DAUtFSBTjLjEgLm1AbTQe4qnnsCL0kP3Lt4hSZ9fYoy
         JBttA3yQIsSUyD1+gzN4F1X5TznOmWqRCVJx490eK2e1VWAQef84Vgn0JeazjSyhZPJr
         5ADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4N/Lk36lipkDU53ZRR8qjoGWWF84HiYcC9KOS2IHfpg=;
        b=t3Um7nOuVXx2sRibkvx0EtDJTHuGO0Tq5hxi9fpDiL2BKAxvzsePrxxC7+utj9Q7HW
         8xryRQwodxpXoz8kjS7005c7wvBiQiBl/qwT9kIDY4c7biOZ1EcuTkqavkHhY8/w56KF
         UH9SuXwVe7gEDJzlvvqgLOWx8KZgnW3nF7yoOvCUJlMFqowsGfTcOc7EMXtzophSv26S
         eKIAnEZjpZInVMyEq5j7l+Xy+tsxLvE/SYSfGGXoIScKdQr8oDmigA+d12mKBkF4sxqD
         s6GfVtRoPI/eJJWHuhXFy1Xv0LFuermT2sBokmOVn28hH+tINR6fAxKJJm5ugGJefc2d
         tMmw==
X-Gm-Message-State: AOAM5331rlDl1qYBi2NhFlAt3r5kZAH5TPLUgkrIVXkBLKnQv6BP7sBr
        5gsiusVphkDt1if8f9p8Yo4=
X-Google-Smtp-Source: ABdhPJzNA24iWwHFOfO3wHyXbdNXv/ddDLjHuWpLYxfaQIzm4IbD7QcTPHBaYy4v1ucufsY6xK1tkw==
X-Received: by 2002:a17:903:11d0:b0:156:6c35:9588 with SMTP id q16-20020a17090311d000b001566c359588mr3478886plh.50.1654155212422;
        Thu, 02 Jun 2022 00:33:32 -0700 (PDT)
Received: from localhost.localdomain ([47.242.114.172])
        by smtp.gmail.com with ESMTPSA id s5-20020a17090302c500b00163506d51e7sm2788381plk.125.2022.06.02.00.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 00:33:31 -0700 (PDT)
From:   Chuang <nashuiliang@gmail.com>
Cc:     Chuang Wang <nashuiliang@gmail.com>,
        Jingren Zhou <zhoujingren@didiglobal.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kprobes: Rollback kprobe flags on failed arm_kprobe
Date:   Thu,  2 Jun 2022 15:32:59 +0800
Message-Id: <20220602073259.25669-1-nashuiliang@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuang Wang <nashuiliang@gmail.com>

In aggrprobe scenes, if arm_kprobe() returns an error(e.g. livepatch and
kprobe are using the same function X), kprobe flags, while has been
modified to ~KPROBE_FLAG_DISABLED, is not rollled back.

Then, __disable_kprobe() will be failed in __unregister_kprobe_top(),
the kprobe list will be not removed from aggrprobe, memory leaks or
illegal pointers will be caused.

WARN disarm_kprobe:
 Failed to disarm kprobe-ftrace at 00000000c729fdbc (-2)
 RIP: 0010:disarm_kprobe+0xcc/0x110
 Call Trace:
  __disable_kprobe+0x78/0x90
  __unregister_kprobe_top+0x13/0x1b0
  ? _cond_resched+0x15/0x30
  unregister_kprobes+0x32/0x80
  unregister_kprobe+0x1a/0x20

Illegal Pointers:
 BUG: unable to handle kernel paging request at 0000000000656369
 RIP: 0010:__get_valid_kprobe+0x69/0x90
 Call Trace:
  register_kprobe+0x30/0x60
  __register_trace_kprobe.part.7+0x8b/0xc0
  create_local_trace_kprobe+0xd2/0x130
  perf_kprobe_init+0x83/0xd0

Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
Signed-off-by: Jingren Zhou <zhoujingren@didiglobal.com>
---
 kernel/kprobes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index f214f8c088ed..96c75e23113c 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2422,8 +2422,10 @@ int enable_kprobe(struct kprobe *kp)
 	if (!kprobes_all_disarmed && kprobe_disabled(p)) {
 		p->flags &= ~KPROBE_FLAG_DISABLED;
 		ret = arm_kprobe(p);
-		if (ret)
+		if (ret) {
 			p->flags |= KPROBE_FLAG_DISABLED;
+			kp->flags |= KPROBE_FLAG_DISABLED;
+		}
 	}
 out:
 	mutex_unlock(&kprobe_mutex);
-- 
2.34.1

