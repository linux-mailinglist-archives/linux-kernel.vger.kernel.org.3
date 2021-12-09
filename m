Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B455346E100
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 03:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhLICrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 21:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbhLICq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 21:46:56 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BBDC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 18:43:23 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so5832354pja.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 18:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e4RogTU3o012IGRRPKLIzZntO019oLsseMs3+GcuKq8=;
        b=bi1/ZLZzUQzvYSQpSwyTPyY21MC5TzM2TikTnri9vYDIyyVN0L0XNFUKh9ZrO9aN/U
         Huabci8PP0snWQHcZ70cHbJ1yAeB7F4wTQvKH1yvKL6shDaPtK5621S6FP19ZsAhz7X3
         Lf90iFzh6SmfOQ/o7kFf02yqxmmzEYT1f+iykv6D5PUfPJ8E5/AwsqE9omdVuD3hkG3D
         iYCyVFZOxfp7RZic8+xeBhJ8bITEkJhD4kfnY+l0XZ36/DgX+qlhwQUdctJoEWLjA/DJ
         kkILJQejeLpY7wXj6oBnCB32gjOIFGqsbupUO1RumMtkioBbANrBMnOlWvQeUs7kbIew
         Yq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e4RogTU3o012IGRRPKLIzZntO019oLsseMs3+GcuKq8=;
        b=xVe8TqCKe6tZ1k5zWUBBPRjBatiRVWni63nnE7gksw6YhY21ZWbn/PCcMtxASCz7Lb
         9Gyk3EnCqVpETYhcEsXaCHDPoFoHTnws4X5D1ld4JtBPU1emMTNa+mjT+J7jaND1PAyo
         vCCLwtow5t0Qe/dZwBdEhj/09FK9Lu98lj98Eb0R4LZYx+ozI8E4vRQLX/WJ4QeD5KfH
         IYd7FYw+IPDgGJyw6BiXu9xu2A2EdbGNKn8jmbodhWoN1491y5EV+MKu4zVHuG0Dxb2X
         pqxD0Hvn/fiw8CvRyUfNFMBvvwcO5tiFnJx8SKrhnB5WBcPsLlVipbVE0p5JPKWraRbX
         50tw==
X-Gm-Message-State: AOAM532aUkbxHRp2zaDpQa0bpyOh708I1ECnjvvK6nNh2dGDqvRrXKxV
        hKs12pKeBrTRrT/7FCGORu4=
X-Google-Smtp-Source: ABdhPJwlLno624POKmi2rhWnEhLqXSFIkr6L7Vhx7K9odf2Hb1NF49sf8Ts4bbF7/hpWy5KS4c9EjA==
X-Received: by 2002:a17:90a:cf85:: with SMTP id i5mr12389995pju.101.1639017803424;
        Wed, 08 Dec 2021 18:43:23 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id w19sm3945887pjh.10.2021.12.08.18.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 18:43:23 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     rostedt@goodmis.org
Cc:     linmq006@gmail.com, linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: [PATCH v2] tracing: Fix possible memory leak in __create_synth_event
Date:   Thu,  9 Dec 2021 02:43:17 +0000
Message-Id: <20211209024317.11783-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211208154457.3a301cf8@gandalf.local.home>
References: <20211208154457.3a301cf8@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before goto err, call argv_free to handle argv in order to prevent
memory leak.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
Changes in v2:
use a cleaner way to handle cleanup operations
---
---
 kernel/trace/trace_events_synth.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 22db3ce95e74..c4a490ec7a38 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -1262,26 +1262,26 @@ static int __create_synth_event(const char *name, const char *raw_fields)
 			if (cmd_version > 1 && n_fields_this_loop >= 1) {
 				synth_err(SYNTH_ERR_INVALID_CMD, errpos(field_str));
 				ret = -EINVAL;
-				goto err;
+				goto err_free_arg;
 			}
 
 			fields[n_fields++] = field;
 			if (n_fields == SYNTH_FIELDS_MAX) {
 				synth_err(SYNTH_ERR_TOO_MANY_FIELDS, 0);
 				ret = -EINVAL;
-				goto err;
+				goto err_free_arg;
 			}
 
 			n_fields_this_loop++;
 		}
 
+		argv_free(argv);
 		if (consumed < argc) {
 			synth_err(SYNTH_ERR_INVALID_CMD, 0);
 			ret = -EINVAL;
 			goto err;
 		}
 
-		argv_free(argv);
 	}
 
 	if (n_fields == 0) {
@@ -1307,6 +1307,8 @@ static int __create_synth_event(const char *name, const char *raw_fields)
 	kfree(saved_fields);
 
 	return ret;
+ err_free_arg:
+	argv_free(argv);
  err:
 	for (i = 0; i < n_fields; i++)
 		free_synth_field(fields[i]);
-- 
2.17.1

