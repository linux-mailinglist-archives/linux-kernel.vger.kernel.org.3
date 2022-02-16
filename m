Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFC54B809A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 07:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiBPG0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 01:26:42 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiBPG0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 01:26:41 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658881DA0D9;
        Tue, 15 Feb 2022 22:26:20 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id y9so1584858pjf.1;
        Tue, 15 Feb 2022 22:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dBNXgCdgCYaUbBErPqT71h5+5QqoItuAWvehu3xJcaw=;
        b=LSeae50hst2QZlr14S+ETUone/JD5gLfA68GnptsxgIutLesAhfCxK81SVXKYTWy9e
         I1Knah+bE7toxoWwtlRValeGLk4fV0CfxlFMIcRM9wMriZn0l8ugQVFLTJxaHr/rwKKi
         lFF4W+igSt0HJXM6fQKQSSecTWRJU5ftmBj4XDzTReXJINYUQxIjMjWvgct6QlpHi19q
         PXDJelr6TPMJaFsxKcTvBuh0PQ0Z63nXhdb2KVRUeo40zupZ2dejLRdPxglWUdBWsNws
         2nA5uWGrP8wFcMpSAH8p/KVH1sk/KJsmI+KkXRzb8bUiD1Tj6eXNFeK7hi+PROuwDb9l
         frFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dBNXgCdgCYaUbBErPqT71h5+5QqoItuAWvehu3xJcaw=;
        b=00q5IqqkYWvIWL9J7Vq9PPLY6/NEkrQ6pGYxhHQ8zPJZ2UbjfRSxTlPJBd+2xLx5/G
         yS4ECyEV0JZHz3g3tk9b0cwrXadikIVDPmbFTW9N5sEk2Ly9CNyPKC22W7OWBPHIvXDc
         wMW6M5EC5n01u04YUvSQ743eSPDV3RQsaYx1rBeLqtycYsD+itMNyBd0ORxXOW2Hpg/9
         2zhKzjfxsPxbNaW9bHDu09xHjZJz3XtdcIksTBrnL/j7FneI1/hb2aazoIwDPgjA8z9m
         +wVT//5ZRxsQMhRMIc1TwmNEhhyqAZvkFo2lA/q2zM+Famw/cN21PPgxA8trt2qiXunM
         KXNQ==
X-Gm-Message-State: AOAM532kBBdNhPjzLQmL7Mye72qwWB0CAllTKJW6pxd+d3fZNKfldfos
        8jsSyksLAh8JJpN5hSyCEMw=
X-Google-Smtp-Source: ABdhPJzvIyQ1ZKKBf53vZodnhgWF6ft6bdVdQOoopcsO/RIGfL50H98k8yCPMcS1jDNq0Q22m1+QUQ==
X-Received: by 2002:a17:90a:d987:b0:1b8:f46d:1b83 with SMTP id d7-20020a17090ad98700b001b8f46d1b83mr69279pjv.221.1644992779671;
        Tue, 15 Feb 2022 22:26:19 -0800 (PST)
Received: from ubuntu-server.local ([2600:1700:3ec7:421f:fd1e:ea7b:d4f8:959b])
        by smtp.googlemail.com with ESMTPSA id q16sm43487079pfu.194.2022.02.15.22.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 22:26:19 -0800 (PST)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-kernel@vger.kernel.org
Cc:     Tong Zhang <ztong0001@gmail.com>
Subject: [PATCH] ACPICA: proactively check null ptr to avoid API misuse
Date:   Tue, 15 Feb 2022 22:26:15 -0800
Message-Id: <20220216062615.779778-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some cases that user use acpi_ns_walk_namespace() without
checking acpi_disable flag. When acpi=off is provided in boot cmdline,
acpi_gbl_root_node is NULL and calling acpi_ns_walk_namespace() will
crash kernel. In order to avoid such misuse, we proactively check null ptr
and return an error when we know ACPI is disabled.

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/acpi/acpica/nswalk.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/acpica/nswalk.c b/drivers/acpi/acpica/nswalk.c
index 915c2433463d..9ae45db16d86 100644
--- a/drivers/acpi/acpica/nswalk.c
+++ b/drivers/acpi/acpica/nswalk.c
@@ -171,6 +171,13 @@ acpi_ns_walk_namespace(acpi_object_type type,
 		start_node = acpi_gbl_root_node;
 	}
 
+	/* acpi_gbl_root_node is NULL when acpi=off is provided.
+	 * We proactively check nulliness here and return an error if user call
+	 * this function without checking acpi_disabled
+	 */
+	if (start_node == NULL)
+		return_ACPI_STATUS(AE_ERROR);
+
 	/* Null child means "get first node" */
 
 	parent_node = start_node;
-- 
2.25.1

