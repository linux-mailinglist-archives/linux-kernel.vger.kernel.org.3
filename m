Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A19857B48E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 12:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239337AbiGTKaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 06:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbiGTKaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 06:30:10 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FCC1105
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 03:30:09 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id g4so16041560pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 03:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZxW8kn6VVBRo5Uc2b72nSYpwFmORwfNOni/4ua8JCsY=;
        b=BMXf+Mn/8zj/5LTJNdVq/S4TPSqgI1IaFeSH6OeRbDncbh9VoSjAtn229c64YRy/pf
         uInBPTRek5Oh/dgcRZ6GeuvjP1sTGA+TuPwhapjlzVTUos+xk8Vt3RhXw37dZR5DAZg3
         C7Q04yIzSvEejKT0QVivIFIoJ3SmKK172S6RuGEph9jR2lxaw5k7htO4yv3U5BXC59WE
         4PcICIhkxj+7cXcmvkapUWx+CXNeAl1q1N1oTkwbpveOV8Wbo2L5lcmPaB4Ut2oTWxbE
         Au8l17EeUiX2uljAUdVkLU32duDZu3uE5RaOPIRwQS4pXMvXn6NlosmubeuxijODopAu
         jBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZxW8kn6VVBRo5Uc2b72nSYpwFmORwfNOni/4ua8JCsY=;
        b=Lhl4CnSyFiZR0HrotxEvf6mxt95XPC/2RTJOQEKSFY30VT44SKI70Xvo9Fq2goiR8K
         we4K3c7tU4JjcucMukWYN+Y0SC0vAEEg0lOST95P1DixsTwyXe9W32ciL76vswkM5Vyj
         pC3BLsVMwFng+sIDLHFx5FBC7Jc1zmtA0OH12R+EWGKuSkTolXEFC3ONLAv2kguCSPLb
         KibikD6z7y/gQ20CDiXvD1IHpgz/wgnOSEagY68iHrHZcDvGM52V1HE6V5zJ9V6ezq6v
         y5ltEaQEaG37kwws8854E6NEshOjY7NAY6gt+JqI6SJQl6DHVP1QmPtF4GYKdtvhDuB/
         rP0w==
X-Gm-Message-State: AJIora8BnyDyvrs58nFYiOV1NIk/gapM8DyJmyiIPIx/tZM5WX4BUQSH
        208NjKvosl1fKCkbJCMZJDTnx3n7SCkkBhCUeSc=
X-Google-Smtp-Source: AGRyM1tu57ZT+9N/RajS0DgPXWCDe97NpuAeDRRdWb+6hitZ9jXYXqV1wYq2j2e36ySii4w8t4dFKA==
X-Received: by 2002:a05:6a00:21c8:b0:4fd:f89f:ec0e with SMTP id t8-20020a056a0021c800b004fdf89fec0emr38673114pfj.83.1658313009237;
        Wed, 20 Jul 2022 03:30:09 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.9])
        by smtp.gmail.com with ESMTPSA id m11-20020a170902db0b00b0016c4147e48asm13667220plx.219.2022.07.20.03.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 03:30:08 -0700 (PDT)
From:   zengjx95@gmail.com
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Zeng Jingxiang <linuszeng@tencent.com>
Subject: [PATCH] kernel/sched/cputime: Fix unused value in cputime_adjust()
Date:   Wed, 20 Jul 2022 18:29:56 +0800
Message-Id: <20220720102956.1141634-1-zengjx95@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zeng Jingxiang <linuszeng@tencent.com>

Coverity warns uf an unused value:

assigned_value: Assign the value of the variable rtime to utime here,
but that stored value is overwritten before it can be used.
568	if (stime == 0) {
569		utime = rtime;
570		goto update;
571	}

value_overwrite: Overwriting previous write to utime with
the value of expression rtime - stime.
592	utime = rtime - stime;

Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
---
 kernel/sched/cputime.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 78a233d43757..531df8b29e6d 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -565,10 +565,8 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
 	 * Once a task gets some ticks, the monotonicity code at 'update:'
 	 * will ensure things converge to the observed ratio.
 	 */
-	if (stime == 0) {
-		utime = rtime;
+	if (stime == 0)
 		goto update;
-	}
 
 	if (utime == 0) {
 		stime = rtime;
-- 
2.27.0

