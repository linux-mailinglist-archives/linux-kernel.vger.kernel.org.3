Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6372259309D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 16:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241569AbiHOOVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 10:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiHOOVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 10:21:50 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEA1DFFF
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 07:21:49 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id f65so6595056pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 07:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=6bzerbOi1tWbohdKcxG2J4gHSK0DtZlDBSqHyHqYooQ=;
        b=iPMTML2jz1BiYQfBqBGS3YYeXVtt15FuSdCGGuWOyT/67LoZPmxeP791Y7PUnYNPZx
         P9rktkoVrvEwWoi7SYGQqj4y7WAYmueSavo6TpCvt44JCduT2CUYGG1BamB2Cy9TcRYK
         jYt4r4S+D6hezp5gNLypnTmUsgvVgWCV5JPZQwMf8vFzEazCK8t6VjxBY6IIQCgyz/mp
         01bfP9ONQGws96dCiD671x/PjQjxWh2ECUH2LNrUlOPubyP25fEdPX1co+oO/nh/Orwi
         Kpsva5TdSnpKoKKHhS+rTCupCXf7Ok3j5dNyYfPH0M92XUXkYUruZkeuVfvOKmk0aAud
         wKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=6bzerbOi1tWbohdKcxG2J4gHSK0DtZlDBSqHyHqYooQ=;
        b=xFyubLq9fq1HRT0XWKYOfI6diwg+gdH7NnEAERnczbVsQK9f190SDQmb2pzQFMWNS/
         DPJsTWJVjtiHNIvrkidUkC/Lvx0mJJmnRDWxb/pVUUATAzfj90kXI8YEpmAjAH3H1J1t
         LkuhinTO6LEwLvkyWCalWJEtmeeWVfrrkTSXEVOj+NEhm2q8R00X0BlNzqqIDSNr5qFm
         VQQDy+koxcKocgpxVPpMo/gxOSsJxJUoo/Q2mTIsm8B4BAcfIaKpko44MS5wv+8MuqQp
         Ay+yaFXk/WaTUffLxJyunF5pNUw7g7n54jhlsOD6PxcNZ4A8UgQIZ0FpNO2I7S2IOofg
         tgIQ==
X-Gm-Message-State: ACgBeo1tgPGsW4F1didAOKhWKNtk1cxEeGXdHbtD47j0Gj2kglU18m+x
        ws+/I2/3tcGD6sg88Yv8hqc=
X-Google-Smtp-Source: AA6agR7as9QSeTB5It8kcha2Bqy9jWQeAS4DTTUZyLZaU5nUjL/x4kinYNA2UfSEltgzYNQpwjx3WA==
X-Received: by 2002:a63:d212:0:b0:41c:681b:e48a with SMTP id a18-20020a63d212000000b0041c681be48amr14006845pgg.79.1660573309521;
        Mon, 15 Aug 2022 07:21:49 -0700 (PDT)
Received: from localhost.localdomain ([182.160.5.243])
        by smtp.gmail.com with ESMTPSA id f18-20020a17090aa79200b001ef9659d711sm4517373pjq.48.2022.08.15.07.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 07:21:49 -0700 (PDT)
From:   Tuo Cao <91tuocao@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, 91tuocao@gmail.com
Subject: [PATCH] sched: core: remove access_ok() before copy_to_user()
Date:   Mon, 15 Aug 2022 22:21:37 +0800
Message-Id: <20220815142137.29982-1-91tuocao@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If usize > ksize, usize may be not valid and if(!access_ok()) will return
-EFAULT. But ksize may be valid, copy_to_user() should be executed.And
also, copy_to_user() will calls access_ok() to test whether a block of
memory is a valid user space address.

Signed-off-by: Tuo Cao <91tuocao@gmail.com>
---
 kernel/sched/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ee28253c9ac0..fe6a65a54626 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7975,9 +7975,6 @@ sched_attr_copy_to_user(struct sched_attr __user *uattr,
 {
 	unsigned int ksize = sizeof(*kattr);
 
-	if (!access_ok(uattr, usize))
-		return -EFAULT;
-
 	/*
 	 * sched_getattr() ABI forwards and backwards compatibility:
 	 *
-- 
2.17.1

