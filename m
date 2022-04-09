Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C28E4FA6C0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 12:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241354AbiDIKWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 06:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbiDIKWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 06:22:35 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6C6C4D
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 03:20:27 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id s17so6372617ljp.8
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 03:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n4Zl1IUxP7WaOSfw1jsy76q0LhMby1ouy62pDNc0Q4s=;
        b=NZfatcEit4I13GXA6crtJcqIr4+6S29r33mb2AKAvMrGcFGrKfAU6TKdufyWL1/cXW
         elC6jxN1EyMUCAofIOZa89HoflwTu69a4c0Tuf9IfYO1OWbjiSn+06Zvn87Cy/rVRGIa
         5eK5cF2VlZN2KX9R+ImdpNsOWTsvrqiYD0Yf90QZkVcx+5LLXh+alU4PAGRsc2wadPlb
         1GnHYpzZ+DKQAhIca/zkS6i5E+f/RM4Quw6s2JI8hnNdypgwVsCd8WNsLKzjyVMc0cEJ
         849a7Gp/pzOS2v+pnMBESbSNq0g6BVMDFtfhz7nV+SR0rHn+P4E9o4Ea77Q73nb/mQn6
         HzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n4Zl1IUxP7WaOSfw1jsy76q0LhMby1ouy62pDNc0Q4s=;
        b=r+9DYgulO6IhJEkwYVJNqDfwbLxjGwUThKuts2Nq8lbkxkjpPqfiuQQYeM/vyAGcGE
         Pymx5/tkOG+KdF60Yipw/TmVi/qR/LbIKEUZK4sK2sPqCzpmkGD7yWuJt8AhS/qTjjFW
         J6PQj4c2UNdp8I7U0sCe31kTkRsQBq6ZusyAUIQi94AbZN+SecFs9sATGX1W7s9mVfAo
         MOwr6/4wbBGkoMOZwB+K0e4gKuaG9IG8qzPpyShZJGtPeAmXLFkfXVkndQKe8mHVKUid
         8advHcP73Zlx9fDMJ3qnuufre81zu7tbgrvV0UKrJOJEVAyblEOi3yxhatb5gRnomRMs
         2Tng==
X-Gm-Message-State: AOAM531Km35E+W9JqvCcY3+4YV0SCY3RIo8Q42BLL0RE6ExlchcfAh4k
        fhIi1DAdfZgcRweJE0SMZEI=
X-Google-Smtp-Source: ABdhPJznNYKp3fWw3ZrGe44GgmwcvXordVC1DLcpKpi67HvhXE6u5Cd+zk1zr/AfsLGcf3jM3L2e/w==
X-Received: by 2002:a2e:a596:0:b0:249:7ecf:606c with SMTP id m22-20020a2ea596000000b002497ecf606cmr14480320ljp.114.1649499625292;
        Sat, 09 Apr 2022 03:20:25 -0700 (PDT)
Received: from morzel-asus.lan (static-91-225-135-18.devs.futuro.pl. [91.225.135.18])
        by smtp.gmail.com with ESMTPSA id h8-20020ac24da8000000b0046b8a03301bsm363680lfe.137.2022.04.09.03.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 03:20:24 -0700 (PDT)
From:   Michal Orzel <michalorzel.eng@gmail.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     Michal Orzel <michalorzel.eng@gmail.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] ipc/sem: Remove redundant assignments
Date:   Sat,  9 Apr 2022 12:19:31 +0200
Message-Id: <20220409101933.207157-1-michalorzel.eng@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Get rid of redundant assignments which end up in values not being
read either because they are overwritten or the function ends.

Reported by clang-tidy [deadcode.DeadStores]

Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>
---
 ipc/sem.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/ipc/sem.c b/ipc/sem.c
index 0dbdb98fdf2d..38ef91a63edd 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -766,7 +766,6 @@ static int perform_atomic_semop(struct sem_array *sma, struct sem_queue *q)
 	for (sop = sops; sop < sops + nsops; sop++) {
 		curr = &sma->sems[sop->sem_num];
 		sem_op = sop->sem_op;
-		result = curr->semval;
 
 		if (sop->sem_flg & SEM_UNDO) {
 			int undo = un->semadj[sop->sem_num] - sem_op;
@@ -1430,7 +1429,6 @@ static int semctl_main(struct ipc_namespace *ns, int semid, int semnum,
 	if (err)
 		goto out_rcu_wakeup;
 
-	err = -EACCES;
 	switch (cmd) {
 	case GETALL:
 	{
-- 
2.25.1

