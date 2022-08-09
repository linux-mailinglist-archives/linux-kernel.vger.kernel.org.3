Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C58658E1C3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 23:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiHIV2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 17:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiHIV2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 17:28:13 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CBE606AC
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 14:28:12 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id h28so11913555pfq.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 14:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=JY9D8MD/ihrJJozLZGniZMqDUbj7IISkdDkiVGgSVlA=;
        b=ZIuHud84ZtXedCzT7Pr+igolJJ5oQC93UOqQ51ntuXWbhbr1e91OANRUalKrZPYtpc
         f1Ne3tCGqNyPWTQckJdLtCqJraU/AmN3zLYSJIfLFzL3UVMHrTZmP+9yAhK+/oRy7CtA
         vpsmqhPLXbrCoQ8TfIA/+ttwE0d6C0+EYQysA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=JY9D8MD/ihrJJozLZGniZMqDUbj7IISkdDkiVGgSVlA=;
        b=B1+KmxhUh+KQY1aOMVXcFojkFDAuLI8m1sZYybWsdwd8WfJHGigsi8N4R34KAFx+yR
         60WGLq4MeSRv/ei+/DNQ4tgVF/gnI4nsgpH/8zI6R6Kk2rS+MnTqaFRfzwPsBPwsSgDH
         7qOAkaBDpMQ7fn0MyP3YDBIJGg/SAejWbdwlO9xwus/mfDDaLNhV5Z8B7qh4t4aH/xQe
         0STPS/QHqbn3c2ZxSBlLy78FsrEb6W710uW8XQ1ib9I04Z17Rh/sE/x3zsxhUA+TZFwP
         /YXEiEQXBjkNN00htxN+WedTOeRcHDxRz3Bn+wf9Hj2QFsn6OKnUeoRpO90bnhP2YDHZ
         k0Gg==
X-Gm-Message-State: ACgBeo3+sNwjZquooZ6uzTxxDmQhewnCARi9lQxPsBfrNPPm0FBOIljl
        AITkbV52QfICadyxBZ6hQvGiyw==
X-Google-Smtp-Source: AA6agR5VYybnqM34uLEivFOpfRmCmRQjvS+GViCfNSaPuw3/IoUzIEHGJARl+EBPf4u2ccJlCi8oLQ==
X-Received: by 2002:a05:6a00:804:b0:52f:43f9:b634 with SMTP id m4-20020a056a00080400b0052f43f9b634mr11293054pfk.62.1660080491539;
        Tue, 09 Aug 2022 14:28:11 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:22ee:daf1:c9a1:a49])
        by smtp.gmail.com with ESMTPSA id t4-20020a63eb04000000b003db7de758besm8447923pgh.5.2022.08.09.14.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 14:28:10 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: core: Fix missing error return from regulator_bulk_get()
Date:   Tue,  9 Aug 2022 14:27:45 -0700
Message-Id: <20220809142738.1.I91625242f137c707bb345c51c80c5ecee02eeff3@changeid>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 6eabfc018e8d ("regulator: core: Allow specifying an initial
load w/ the bulk API") I changed the error handling but had a subtle
that caused us to always return no error even if there was an
error. Fix it.

Fixes: 6eabfc018e8d ("regulator: core: Allow specifying an initial load w/ the bulk API")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/regulator/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 7150b1d0159e..d8373cb04f90 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4784,10 +4784,10 @@ int regulator_bulk_get(struct device *dev, int num_consumers,
 		consumers[i].consumer = regulator_get(dev,
 						      consumers[i].supply);
 		if (IS_ERR(consumers[i].consumer)) {
-			consumers[i].consumer = NULL;
 			ret = dev_err_probe(dev, PTR_ERR(consumers[i].consumer),
 					    "Failed to get supply '%s'",
 					    consumers[i].supply);
+			consumers[i].consumer = NULL;
 			goto err;
 		}
 
-- 
2.37.1.559.g78731f0fdb-goog

