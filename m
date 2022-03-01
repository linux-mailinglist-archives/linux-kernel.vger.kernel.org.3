Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99ECC4C8189
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 04:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiCADNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 22:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiCADNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 22:13:38 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A534AE35;
        Mon, 28 Feb 2022 19:12:59 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id y11so12928839pfa.6;
        Mon, 28 Feb 2022 19:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C+Fr+9cjgt56xh1W2SgMV0xUpzfsHzCWfqwoWMmTeYg=;
        b=NKRJcRlboyPM9Ax76hZgX6izQ3odUHprwDlA+Wr8Cwo1bUpWk9Rhnovarqdda03Fg1
         Q67wpEy0WtwaNBjqWtGC7avlj87m2fYbj/Cqu/Ivc4fae4YZwecVFhJ9XQrM7ur+WQ3f
         kqnxJCyAZMdrG9FCvON1vooVlJJOzmSiQQBEOVRPJvJES2dXSzhjFXK9eTz7Oj1Cuik4
         oErNsXTgpSG6EiU4/QtakpzFNaqREwW7LV9Ojukwu3hxsMTpwBU/AP1v4dqRrq3nEdt+
         grXtcju4b1QQM2YTT3MEP8W8laa2CAXoqVHDeOHhZDtZ3Yv+ZRNzgYP4v9vlJNtO/rZn
         j37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C+Fr+9cjgt56xh1W2SgMV0xUpzfsHzCWfqwoWMmTeYg=;
        b=NB6GDjrt1yfF6Q7dVlnpHzOrC2Zx3OXmyfiJNrUfkJRn6whu1XoR2J2/oPStQNmE3l
         WOxo4DkU/MmNFYD/acBkX6vycSy1h0oc6UmP1PPBVX5EuU1h2+Nv6rvZ5sOhQgVQPUuA
         cUrSUhY5YrYivE4w+IWDO+QlGCqLo1pgog1A0VojeF+o04vv1NFPmdT5u3LMAUyJyh7c
         8oZlz7VkQPzx36aHHRwsWCAr8PJqoxaSCjGYA58rLax8//jahDHQqCzyOFW/rlTZKlEH
         qZInC0NgfeYFyzNHfUuXUou3Qvs56a9BGprPqwQNMjPB1dHxPXWDUf6/rhBfdmba4NZR
         jpgg==
X-Gm-Message-State: AOAM532Kg9Ko1OJOb6a7sHrrv6aoh4QlfqHdPtdX2jGemMnI9LpKtLc2
        KPS8nZJvfxly2+DF0V3rJh+4tcPRzQVsUSHSTOc=
X-Google-Smtp-Source: ABdhPJxPG6rwk1XNkJdP/b07ZQReenELR593w1kLXD5VWS3dWpNUxJWHV5ZGNcDXD+U28QfapzOprg==
X-Received: by 2002:a62:7846:0:b0:4c7:f23e:1fd7 with SMTP id t67-20020a627846000000b004c7f23e1fd7mr25093055pfc.67.1646104378460;
        Mon, 28 Feb 2022 19:12:58 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id s4-20020a056a00194400b004f0fbeb6006sm15113429pfk.88.2022.02.28.19.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 19:12:58 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Peter Griffin <peter.griffin@linaro.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v2] media: st-delta: Fix PM disable depth imbalance in delta_probe
Date:   Tue,  1 Mar 2022 03:12:53 +0000
Message-Id: <20220301031253.6142-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220105115515.12196-1-linmq006@gmail.com>
References: <20220105115515.12196-1-linmq006@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pm_runtime_enable will increase power disable depth.
If the probe fails, we should use pm_runtime_disable() to balance
pm_runtime_enable().

Fixes: f386509 ("[media] st-delta: STiH4xx multi-format video decoder v4l2 driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- remove unused label.
---
 drivers/media/platform/sti/delta/delta-v4l2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/sti/delta/delta-v4l2.c b/drivers/media/platform/sti/delta/delta-v4l2.c
index c887a31ebb54..36ce0775f3f9 100644
--- a/drivers/media/platform/sti/delta/delta-v4l2.c
+++ b/drivers/media/platform/sti/delta/delta-v4l2.c
@@ -1899,6 +1899,7 @@ static int delta_probe(struct platform_device *pdev)
 err_v4l2:
 	v4l2_device_unregister(&delta->v4l2_dev);
 err:
+	pm_runtime_disable(dev);
 	return ret;
 }
 
-- 
2.17.1

