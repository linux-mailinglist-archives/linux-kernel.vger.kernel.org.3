Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAC350027C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239250AbiDMXWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239217AbiDMXWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:22:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E42CB326F2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649892008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=osWjVIWrfBrDOezJiYzosX0/AGt77HLN11DnBu9dxXM=;
        b=Qo7LHc/Oo/vb3MolYwnR9Z1eC8SPYAh6K1h0X4ocK+E8GYPQMusivWdDIKiFTIbDgPWO/h
        zs89m2oEZ45r6vDdKyUdPlt8aBHVREwwCdmJdHOELlD61phipfq1GU6RBW4Yvnh1AIGBK1
        VuwhqjxV03vlYcPu9mfw8cpH4zUrhJE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-523-n9XLawO1MTKk1a7m2TT0rg-1; Wed, 13 Apr 2022 19:20:07 -0400
X-MC-Unique: n9XLawO1MTKk1a7m2TT0rg-1
Received: by mail-qv1-f69.google.com with SMTP id m15-20020a0562141bcf00b00443ddcd8a0fso3003262qvc.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:20:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=osWjVIWrfBrDOezJiYzosX0/AGt77HLN11DnBu9dxXM=;
        b=SJHDfNXiETuS/jx+uSKv1sK0OFPa5hbsw+uKKhAnuSfVxCdG9zhWNMZ0l7EyX69Iky
         yIBygzl4GXxx0kN8QhaubSAFWdtG56gO4Jcu5WVwaMGDc1aKJcNdWnmpGQiLqIaYi9x1
         e/QU5NdQWKi3UxKgUQKgInSZGYGgnbPaewaOyg/qNlaUzq+2d44lOHde8zJRa/NK1750
         6R7lWnI7BvCso1eXsI7OsDgdP04dbh9i489JxGLJ9LxpfLPpIUhehp6sMZdECwi0j4u3
         jnXmJBhaAI5Gw7/fEUD8g1NuY7s0BzyKiBun6i2bA0o6QxMipTv6VF5OPqhx/2HpWDBC
         8ELA==
X-Gm-Message-State: AOAM531FEKV7sxk5IIepnSppbCy84hlNfqHUg98X2ErecPBptAhM0dte
        U8OXuzIIbk5GClDvKGIUgq+uXZ7cQ7QpVC0kNqvJq9a0yQz/IDQSArTVhRW4EuM0rZtzMZ8hSp7
        G1fhWGGlhMEex94TBEzlnvNZH
X-Received: by 2002:a37:a50:0:b0:69c:7129:12da with SMTP id 77-20020a370a50000000b0069c712912damr361663qkk.90.1649892006786;
        Wed, 13 Apr 2022 16:20:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvuV8WO9SUCdKFN4q16meRMbgMj70DgGoWRdHrkbeeTu6mzBPy9DekbViM5M8o/ql60amcUA==
X-Received: by 2002:a37:a50:0:b0:69c:7129:12da with SMTP id 77-20020a370a50000000b0069c712912damr361648qkk.90.1649892006488;
        Wed, 13 Apr 2022 16:20:06 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id b20-20020a05622a021400b002f08f5658a2sm193925qtx.68.2022.04.13.16.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 16:20:05 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 06/18] libsubcmd: Fix OPTION_GROUP sorting
Date:   Wed, 13 Apr 2022 16:19:41 -0700
Message-Id: <40da04924ddb81a5acc3f9376bdcb6d2a91d36fa.1649891421.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649891421.git.jpoimboe@redhat.com>
References: <cover.1649891421.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OPTION_GROUP option type is a way of grouping certain options
together in the printed usage text.  It happens to be completely broken,
thanks to the fact that the subcmd option sorting just sorts everything,
without regard for grouping.  Luckily, nobody uses this option anyway,
though that will change shortly.

Fix it by sorting each group individually.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/lib/subcmd/parse-options.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
index 39ebf6192016..9fa75943f2ed 100644
--- a/tools/lib/subcmd/parse-options.c
+++ b/tools/lib/subcmd/parse-options.c
@@ -806,9 +806,9 @@ static int option__cmp(const void *va, const void *vb)
 
 static struct option *options__order(const struct option *opts)
 {
-	int nr_opts = 0, len;
+	int nr_opts = 0, nr_group = 0, len;
 	const struct option *o = opts;
-	struct option *ordered;
+	struct option *opt, *ordered, *group;
 
 	for (o = opts; o->type != OPTION_END; o++)
 		++nr_opts;
@@ -819,7 +819,18 @@ static struct option *options__order(const struct option *opts)
 		goto out;
 	memcpy(ordered, opts, len);
 
-	qsort(ordered, nr_opts, sizeof(*o), option__cmp);
+	/* sort each option group individually */
+	for (opt = group = ordered; opt->type != OPTION_END; opt++) {
+		if (opt->type == OPTION_GROUP) {
+			qsort(group, nr_group, sizeof(*opt), option__cmp);
+			group = opt + 1;
+			nr_group = 0;
+			continue;
+		}
+		nr_group++;
+	}
+	qsort(group, nr_group, sizeof(*opt), option__cmp);
+
 out:
 	return ordered;
 }
-- 
2.34.1

