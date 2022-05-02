Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EF051737D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386077AbiEBQEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386043AbiEBQEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:04:15 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2120765C9;
        Mon,  2 May 2022 09:00:45 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id be20so17106487edb.12;
        Mon, 02 May 2022 09:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wjQ73BAIILYC1+0nV8Fv2/VrUlnVSQ20HYOpjrtsozU=;
        b=izxMgHnVTjQtxi0cBdAf4GgktfRRrjeZe8qcLyyLH3iVfCcwdIo3a6yBCjzsi+r1bH
         hBJdynCUXrXhFPEvpxR2d5ii9mJwY5p9brcE0im2wr1CoHzA43MZhQ0mOEMLjIegHj5d
         mEl30VS4kaiCG/OB7K0WuAPCVRGRBq6cF30vWIycS65QaU9ygXDnvgNKppvj7mTryhXD
         tkg0AkigY3BSPgt/ELPyzBiQLZgqSkO+h8YyPixbbwuObJK7GFPTTUSesfrh1nvCaCAd
         soM7KQxotfSQYkn16Xajf1t1kRsdfuzUfOfLNYC0qPyi60wgFtNlnML/uZWqRw6Nit7d
         OGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wjQ73BAIILYC1+0nV8Fv2/VrUlnVSQ20HYOpjrtsozU=;
        b=vkBrvQfwQ4CTedxHJDnV4k6r2wzAeXZXLOGcxa5473AqOj+VCOE7DylJk8XzyVZFTA
         yhNrZu3n5AXNE4oiTozTIWKVYosRqLzzgIeY9fBVY6ciXVzEVrbINNvFkRFuTN757AMF
         VQnh8aDwgC6ykV8nPBnDg8XH/8PlrsCo4HOwkc+6I7tHtkOJDOSjo1x7k7YY3m8bn6tp
         1PyxovywPUTcysms9WK+oJ9gifuVV00+ERzIA7zOAk5tcoVn/tXcTlqVk35hOLe5Xg0g
         f3PoNamO/zZdhkv06aRqNfu6oxqTxo7lViIuJ2B5AhabP+Qr1yZcCXx9t6729kPVVRAP
         7rDQ==
X-Gm-Message-State: AOAM532FQLa+YqV+quTqEtN8gU3sbotZ94/5K1ms+K7yMsYw9+QXNRXW
        KnfyqJoJTXuC4ZagNWDc2OYXH5U8+doPbg==
X-Google-Smtp-Source: ABdhPJxhzpAFlYxaUPbP6TMOumSjwFz73fdn5NFv1d4yiY6VDqRjLxfDkTlnA+d+pM3kpEgA9XNnSg==
X-Received: by 2002:a05:6402:1c1e:b0:416:5b93:eacf with SMTP id ck30-20020a0564021c1e00b004165b93eacfmr14093940edb.302.1651507243611;
        Mon, 02 May 2022 09:00:43 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-135-067.77.1.pool.telefonica.de. [77.1.135.67])
        by smtp.gmail.com with ESMTPSA id h18-20020a1709070b1200b006f3ef214dd3sm3689996ejl.57.2022.05.02.09.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 09:00:43 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Serge Hallyn <serge@hallyn.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Alistair Delva <adelva@google.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 3/8] block: use new capable_or functionality
Date:   Mon,  2 May 2022 18:00:24 +0200
Message-Id: <20220502160030.131168-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220502160030.131168-1-cgzones@googlemail.com>
References: <20220217145003.78982-2-cgzones@googlemail.com>
 <20220502160030.131168-1-cgzones@googlemail.com>
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

Reorder CAP_SYS_ADMIN last.

Fixes: 94c4b4fd25e6 ("block: Check ADMIN before NICE for IOPRIO_CLASS_RT")

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 block/ioprio.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/block/ioprio.c b/block/ioprio.c
index 2fe068fcaad5..52d5da286323 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -37,14 +37,7 @@ int ioprio_check_cap(int ioprio)
 
 	switch (class) {
 		case IOPRIO_CLASS_RT:
-			/*
-			 * Originally this only checked for CAP_SYS_ADMIN,
-			 * which was implicitly allowed for pid 0 by security
-			 * modules such as SELinux. Make sure we check
-			 * CAP_SYS_ADMIN first to avoid a denial/avc for
-			 * possibly missing CAP_SYS_NICE permission.
-			 */
-			if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_NICE))
+			if (!capable_or(CAP_SYS_NICE, CAP_SYS_ADMIN))
 				return -EPERM;
 			fallthrough;
 			/* rt has prio field too */
-- 
2.36.0

