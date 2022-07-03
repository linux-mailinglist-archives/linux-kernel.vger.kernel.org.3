Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC55564866
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 17:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbiGCPbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 11:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiGCPbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 11:31:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 960E0FC0
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 08:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656862292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Qa6HtSyzlXxSU2meEGcAC0xwahhFcZY+sO6NkJ6FN+0=;
        b=IxS90YhhjkJu4vCViNzjawo17h7NZu0k7ejTPb5/w5IJz/5PZAi60+UToOIoIOESPIpFgA
        0y6naQquFxsh0LZNpc/+wbpfIRoHgS3euS6tAAM5kT2yeQ4+OoyODMk9i1NHz66hFJ1h0n
        cXNYZho7O5jhFtzX/5ppcurHQxlxm/A=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-274-EmpbdS5vPOiZXHpf9gWVuA-1; Sun, 03 Jul 2022 11:31:31 -0400
X-MC-Unique: EmpbdS5vPOiZXHpf9gWVuA-1
Received: by mail-qt1-f197.google.com with SMTP id e8-20020ac84148000000b00319f55b2657so4850676qtm.15
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 08:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qa6HtSyzlXxSU2meEGcAC0xwahhFcZY+sO6NkJ6FN+0=;
        b=kcHRHIi6u4zE9QVOwFodojeUFkcQh/yR1i2+MG9ss/9gvtSXN8p/GBobBo1d9CV143
         ChwM9RK01zDRlgX2rEqJfvUfZZZJIn0otOPFFTAnUsr8Fv8/JSGyJwEayKC9tQNx5T7v
         2Du7m9E7q5IRFJF0T1ch5mJdmlioRc4pHFLE+GtGTQzaj6EpHUcRHg56syCDG16AqrJQ
         3dsRezcJjVTNT7c67dIayVzimxOm+2XAhW2Hi/cRLJbdGq1T5i0rUY4RrNCHCuNrJX3/
         NOs8vFsXIhgaCi7kW2/p9Zrh85DaD/Ud/VqRaLkZzV3AOtOMrEaw4AW7hHBiSAppNV5a
         00wg==
X-Gm-Message-State: AJIora+jwRMRGlCSg26nP4ywbjPXIMFCJgOhOOQhlWNlhCvvfIIi9btV
        JWTGykGEqNCHoMTYWBQ7F5qorx8KEb4VbRwft25Pw0Um3d3qMsbXDRqkE79xmn4D4jaP77fLjQ6
        yAUu8vGf07X8wUoa5wydqv/pT
X-Received: by 2002:a05:620a:4050:b0:6b1:f211:d1c2 with SMTP id i16-20020a05620a405000b006b1f211d1c2mr13295503qko.216.1656862291097;
        Sun, 03 Jul 2022 08:31:31 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tVNZVi2CoEIZyzTA5V+YEGUFOI4n8VwDbQAJV6OcxzK4nK5fDStcpp8Iqzh4zf3F4nHDsYvQ==
X-Received: by 2002:a05:620a:4050:b0:6b1:f211:d1c2 with SMTP id i16-20020a05620a405000b006b1f211d1c2mr13295483qko.216.1656862290826;
        Sun, 03 Jul 2022 08:31:30 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id de4-20020a05620a370400b006b253a6dd1fsm6322240qkb.125.2022.07.03.08.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 08:31:30 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        rafael.j.wysocki@intel.com, qperret@google.com,
        ionela.voinescu@arm.com
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] sched/topology: change sched_energy_mutex and sched_energy_update to static
Date:   Sun,  3 Jul 2022 11:31:22 -0400
Message-Id: <20220703153122.4069621-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse reports
kernel/sched/topology.c:210:1: warning: symbol 'sched_energy_mutex' was not declared. Should it be static?
kernel/sched/topology.c:211:6: warning: symbol 'sched_energy_update' was not declared. Should it be static?

When the commit listed in the fixes tag happened, the sched_energy_mutex
and sched_energy_update variable accesses were wrapped by a function and
the variables were and still are only accessed in the topology.c file.
So change their storage class specifiers to static.

Fixes: 31f6a8c0a471 ("sched/topology,schedutil: Wrap sched domains rebuild")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 kernel/sched/topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8739c2a5a54e..412e2ddcade6 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -207,8 +207,8 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 DEFINE_STATIC_KEY_FALSE(sched_energy_present);
 static unsigned int sysctl_sched_energy_aware = 1;
-DEFINE_MUTEX(sched_energy_mutex);
-bool sched_energy_update;
+static DEFINE_MUTEX(sched_energy_mutex);
+static bool sched_energy_update;
 
 void rebuild_sched_domains_energy(void)
 {
-- 
2.27.0

