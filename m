Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D78551736E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386050AbiEBQEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241345AbiEBQEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:04:13 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A165F93;
        Mon,  2 May 2022 09:00:44 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id kq17so28609143ejb.4;
        Mon, 02 May 2022 09:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=busCb+Om5lGBi8mOWmr9OZyYy/vhvqsiFL5/BXL6zqA=;
        b=ghk5NXhphzM2gG989XZFhRAZZGZycbT6Xm1juiPzyiJ9UWfO8/jJt8Y905OOl6IeCV
         StRbo7WnSDtUgPaLnm48Gq7edKbikw4gDhZOtb33pF+vhKu9POC5LHE1FhZLxWGehz+L
         I5cGaZRIegguH5Enu7D/TXvhLfkMrb7WiHEh9a58D0laKm9jnp5LskhUbH4Nrh3XthN0
         MzWJaCk6Nz4X6UOp5hZSCibk7EROY0K6aauOALrXk1CHbzgR5+BCuJQWGw5r7MJfcshI
         Dq5eNcmau6KflTW8SWsYMcQNqaqBcEooEeRaNLwkG+rTo7NNbANgLC0zwAwBVKj5tHtX
         tTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=busCb+Om5lGBi8mOWmr9OZyYy/vhvqsiFL5/BXL6zqA=;
        b=ERbALm5eqCky8ZJ1Y8L4xG+SHrNSXL9u41gtowRv6phNeY7j/IqO09UvB9CKkIOCKF
         uZrFjxGqYbbgEbDypS9549GH9DvFk5yvAddmUFPP6qcsuORB+Dn08qe8UnFImPMV1ygi
         V+dJgc4SXkZpAf6DW/0AVlh3iCeSgqaweiUhIVuLMgb/35Jr5WaiKqSYR5scJSXkmeGD
         qFCzgbaumfxPb3Y7GUSl+VT9WCMxZKPqkcxjko8bfF2reEMCoP4LFKo2egxuGO5uMHSf
         V9Zz8wNnCVJERfJ0S9WdFPdmX8f2FZyXa+LOaMYSXHsdUgz3EYSX6NM4XElDvXSoNeTx
         3dAg==
X-Gm-Message-State: AOAM531ZWcUAIS9/qXa4/lndY0Mnm3uuPNlKvAvYIP/q0z+PHVF7RM8j
        NRlotN0VyZN+qnSKLLuaunjn65ywYxCX4g==
X-Google-Smtp-Source: ABdhPJznP7hHNSMc6KAkJzb55uU2vdD7o+qcKVDmADHxYa4PbgS0HNkxS0e9NHIHM/Y7m2OIX9eouQ==
X-Received: by 2002:a17:907:3e25:b0:6f4:2c9a:709d with SMTP id hp37-20020a1709073e2500b006f42c9a709dmr8293319ejc.175.1651507242418;
        Mon, 02 May 2022 09:00:42 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-135-067.77.1.pool.telefonica.de. [77.1.135.67])
        by smtp.gmail.com with ESMTPSA id h18-20020a1709070b1200b006f3ef214dd3sm3689996ejl.57.2022.05.02.09.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 09:00:42 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Serge Hallyn <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] capability: use new capable_or functionality
Date:   Mon,  2 May 2022 18:00:23 +0200
Message-Id: <20220502160030.131168-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220217145003.78982-2-cgzones@googlemail.com>
References: <20220217145003.78982-2-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Use the new added capable_or function in appropriate cases, where a task
is required to have any of two capabilities.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 include/linux/capability.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index a16d1edea9b3..1f26d6bae4f3 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -261,12 +261,12 @@ extern bool file_ns_capable(const struct file *file, struct user_namespace *ns,
 extern bool ptracer_capable(struct task_struct *tsk, struct user_namespace *ns);
 static inline bool perfmon_capable(void)
 {
-	return capable(CAP_PERFMON) || capable(CAP_SYS_ADMIN);
+	return capable_or(CAP_PERFMON, CAP_SYS_ADMIN);
 }
 
 static inline bool bpf_capable(void)
 {
-	return capable(CAP_BPF) || capable(CAP_SYS_ADMIN);
+	return capable_or(CAP_BPF, CAP_SYS_ADMIN);
 }
 
 static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
-- 
2.36.0

