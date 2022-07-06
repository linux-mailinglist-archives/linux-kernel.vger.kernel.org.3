Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC6B568E67
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 17:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbiGFPy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 11:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbiGFPyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 11:54:10 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DD8C7B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 08:54:02 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r14so16893004wrg.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 08:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YsmbA7pbfVVxtCyP75LYleN73l2vnI6otlvz1z0zZeY=;
        b=GPCeOC8koQUZiomJs5lDS+GJha2vrjljjNaIlHncUy0sx/0Su39G9sAft4iW5/x6hR
         +lN9KSyacUkEL/xvb45f9EeO4rKXpIeYW4AkYB1BELQtsPDdfIaQmHatTfZZTH1aU7am
         BCh8/Sa2Lb7UIgswSHvQJp1I+5ZQ6Hh2KV93481v4MzBmdgsppr/5AfJDVbIgmcNTdLG
         JGIH+0e4klMayUU2tsLpl+XBjGhl4DCOj6+PlP7v/2UhWrJONlVclJnly+s5thxQBo5E
         tc2qNT/Uk7PB9QIPOiTAPKIgB04GZS3N0H18VseM6vT3RVn0H1Q1bsElJu7LI6z7sS5O
         qLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YsmbA7pbfVVxtCyP75LYleN73l2vnI6otlvz1z0zZeY=;
        b=va0brONeaZ0sOK+XwaTHRuWdL/r64oUHFLMoXdTW6K9WvAxyPLYWDQRi2ActiEcc07
         GXcoPmW4W4ha1Fi9klZrinViyPt7nOHHMEpctDmK3i4d5ty5d+ybsMVWvT6og5UuSyM/
         i68KqT8FiqScOjJQ19K+fXxqNjLw/9v02yc1hHLk77ld9JhyKlQ51PuS9HXPIttwL3m9
         ZuHq5blx3eKKVfnrQU2ph/oB1BApBdIAVKoqynBGWMZ0RJDtSUnELLk1Ds4w66x+iE/q
         tcOxoxkXkTm16Snu+lSm44XhDtm0C64+qq0kzSOBq31qrLIXZ3tJCCOMPFF3rXImopUk
         5Rog==
X-Gm-Message-State: AJIora89frtb53kqsFoeYtjXuCKXta8DVd9gnHtSAG0174o3U3AzO5Lt
        8aC7pESJMkLRC+7Vjgm9iPTqxw==
X-Google-Smtp-Source: AGRyM1s2OWTvbDmVKuCzd38bJ/J3patbtRXHtzGErxwQIacPhicFHRswI9XIzynZ18h5raFiWJ8miw==
X-Received: by 2002:a5d:591c:0:b0:21d:7147:a180 with SMTP id v28-20020a5d591c000000b0021d7147a180mr9812053wrd.582.1657122841273;
        Wed, 06 Jul 2022 08:54:01 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id a11-20020a056000100b00b0021b8c554196sm2276788wrx.29.2022.07.06.08.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 08:54:00 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Subject: [RFC v2] driver core: Fix repeated device_is_dependent check for same link
Date:   Wed,  6 Jul 2022 18:53:47 +0300
Message-Id: <20220706155347.778762-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of a cyclic dependency, if the supplier is not yet available,
the parent of the supplier is checked for dependency. But if there are
more than one suppliers with the same parent, the first check returns
true while the next ones skip that specific link entirely because of
having DL_FLAG_MANAGED and DL_FLAG_SYNC_STATE_ONLY set, which is what
the relaxing of the link does. But if we check for the target being
a consumer before the check for those flags, we can check as many
times as needed the same link and it will always return true, This is
safe to do, since the relaxing of the link will be done only once
because those flags will be set and it will bail early.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/base/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 753e7cca0f40..2c3b860dfe80 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -297,13 +297,13 @@ int device_is_dependent(struct device *dev, void *target)
 		return ret;

 	list_for_each_entry(link, &dev->links.consumers, s_node) {
+		if (link->consumer == target)
+			return 1;
+
 		if ((link->flags & ~DL_FLAG_INFERRED) ==
 		    (DL_FLAG_SYNC_STATE_ONLY | DL_FLAG_MANAGED))
 			continue;

-		if (link->consumer == target)
-			return 1;
-
 		ret = device_is_dependent(link->consumer, target);
 		if (ret)
 			break;
--
2.34.3

