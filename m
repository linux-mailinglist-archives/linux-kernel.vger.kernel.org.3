Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4214C5E40
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 19:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiB0SqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 13:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiB0SqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 13:46:08 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABDB4ECD6
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 10:45:23 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id q11so8895302pln.11
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 10:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hguOC+xPYO0eaAtZXq+RAjwSHPM/20IFHUGj359jpG8=;
        b=Vt+FMmf2Lvacdy2VablByMnnRD1mjjC9+gDyfFfDq1B8f1Y4ajQPMV0pNVAwM0HZ9+
         ta7G8l5pJ+K0fPQjp9rdTxZyZvDIpiK8a22ZNIYRBfHI4U0rZifX7Zi4ZWRI4jtYa0tl
         LPTe8NuUbL6oMV+pLKAfdbADATj8s48JOZxcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hguOC+xPYO0eaAtZXq+RAjwSHPM/20IFHUGj359jpG8=;
        b=CkoNrafSFpoREu5Q3edRzdWpBYFY2MA02qtjPGVMObCXGzf83FpJ11biLy2dDuE2BZ
         ySvvOvtqsHcoNEVhYLYFF+LNg3t+NdJXyRLpRPe8jMb6LYdHQ73vfZlqebG4iTuOSg/b
         L8JmTjXkBBXsbVzdl6+YpTs7VeMOj1hDiNZak9JmFiYd4cnz5DwAp+MDqVosgNnIqJHg
         u8rggE24P+bKUqgRXQ8phxRKWfsfnqmV0tOA53EtmLbA1tBeIncbxDCvzQaLnZK8/AYw
         EoBA6RFObfvHey9xltveSmIGupkubnWAdGfFlWVne7PKcROHkxeGlWvbTSFouRJ4FWGP
         gQkw==
X-Gm-Message-State: AOAM5313iGehVkIX4IyyaPGaw7vF70ah54bCmIX9wR5+Wn16gV/Mu302
        6bXdpKYyHsmKars5hAUtKPv3+A==
X-Google-Smtp-Source: ABdhPJwyo1rMccr+9zW0ZyrPf84LJWZt8qC3wyk+XmwEvTaVBmNHap92GcCcUQYiiBcW9n/4wUYQ/g==
X-Received: by 2002:a17:902:8203:b0:14f:c36f:70c with SMTP id x3-20020a170902820300b0014fc36f070cmr17209832pln.95.1645987522375;
        Sun, 27 Feb 2022 10:45:22 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bg3-20020a056a001f8300b004f40e8b3133sm694802pfb.188.2022.02.27.10.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 10:45:21 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     David Gow <davidgow@google.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Daniel Latypov <dlatypov@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-um@lists.infradead.org, linux-kbuild@vger.kernel.org,
        kunit-dev@googlegroups.com, llvm@lists.linux.dev, x86@kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v3 4/7] um: Remove unused timeval_to_ns() function
Date:   Sun, 27 Feb 2022 10:45:14 -0800
Message-Id: <20220227184517.504931-5-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220227184517.504931-1-keescook@chromium.org>
References: <20220227184517.504931-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1397; i=keescook@chromium.org; h=from:subject; bh=BBY0jyLtd6SE6A0Q+0QxoOVDMufJjpQntzXWcTVbBzQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiG8a7pgTujxq03iEogLI3HZhrantD7izHXSbMposM 3ezh8hWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYhvGuwAKCRCJcvTf3G3AJvdxD/ oCEV1wTwasGpPxS1HOVrQMyGEgZMjg1DXdqdV6HOBfnHhLIsIzbWuxSG7ROL9d+etvNu4CZ+boboMy F7ft4nDST1eKRd78RKyyQPuhjph5qsS/hk7PIadhAeAy+zBCdKfXIPzdA+NlthXEVCBTJU7MfuhaS8 WnW0AsKPv7iPGwFgFd3xCJ9Bl4aLW8KtaOhcKju3e1VCGJ/s4Yzf+P9PKpsgoHBBjRJWAxHvpISG9J yuRL+4TvhGpwioQUFq1FxLJy3blx9iD3vtnGBT+uaTxYXgjQZ8DF6m/lUsVwR43OdedREO3Gle3h2O ArZdZq0I1UZ7NysvfZOXcGFyrF1+OrxIIee/APsPXfOUeFkk12RJNnNCBBXcFdv/AtnX69OORj4hLW 4VBpLH01GaHhh9bO+Nzgzoiygx0ZURY6DOIbGd85lHROMECQedbCVjnSZWrDz9aA0L2IaOw0Neipba vifUqc5dwEZaZaQ/qpTOeLvmmTlgrFN7xOfi4oLNykNb65NlKZm9AOveVJrTprb2lcc4Q+ssTRhJ79 66chg4/PouI37iL0kA7CQLexQvpIc9aUVlvvZ5E4N7heEOMbxZ85wYGG5KSjWp5dGCbDQ6UDSbqyQD PtbBq8sZX7srMnaXmhH0C7ni5QOuy5hpeXo9lOudn2EfJOcEdpCfihoVDUtg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Gow <davidgow@google.com>

The timeval_to_ns() function doesn't appear to be used anywhere, as far
as I (or git grep) can tell, and clang throws up a warning about it:

../arch/um/os-Linux/time.c:21:25: warning: unused function 'timeval_to_ns' [-Wunused-function]
static inline long long timeval_to_ns(const struct timeval *tv)
                        ^
1 warning generated.

Signed-off-by: David Gow <davidgow@google.com>
Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Link: https://lore.kernel.org/lkml/78d6ac17-9492-7c41-d6dd-4c92dce8ce62@cambridgegreys.com
Signed-off-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20220224081233.1765788-1-davidgow@google.com
---
This is a resend of the above linked patch, just included in this series.
---
 arch/um/os-Linux/time.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
index 6c5041c5560b..4d5591d96d8c 100644
--- a/arch/um/os-Linux/time.c
+++ b/arch/um/os-Linux/time.c
@@ -18,12 +18,6 @@
 
 static timer_t event_high_res_timer = 0;
 
-static inline long long timeval_to_ns(const struct timeval *tv)
-{
-	return ((long long) tv->tv_sec * UM_NSEC_PER_SEC) +
-		tv->tv_usec * UM_NSEC_PER_USEC;
-}
-
 static inline long long timespec_to_ns(const struct timespec *ts)
 {
 	return ((long long) ts->tv_sec * UM_NSEC_PER_SEC) + ts->tv_nsec;
-- 
2.32.0

