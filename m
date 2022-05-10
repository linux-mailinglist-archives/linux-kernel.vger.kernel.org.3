Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60BA522087
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238406AbiEJQCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346588AbiEJPxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:53:21 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163EE56C1D;
        Tue, 10 May 2022 08:48:35 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id t16so13812425qtr.9;
        Tue, 10 May 2022 08:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JaQCzndoIKElsDsvqhkhCl2RygfACvXHBtQpId5Vc1c=;
        b=i71gtagyKGiWXzRNxnk9QZMeUToM3U4cmBzQ6dtU9BxKztB+WIf2q/eJVMGYw31RtO
         /lvkG7Xj2fzKeg7tfEjHvb8mDOvF4wCbpGVUcGgfmpgS+CTjQG0oIvzto6d7BgdQyNwo
         8CvMuz0CBBr7zWNnwCwhnlaD5nQ2YSeZ7DDJrrZOFzL/2yC7HgmATq1jPpK6Wc0zlkcI
         EgAocPHMnzFLYrWp4zGkL52i7DWwype3EbKydFGJ3N3wKMtRZ6bV8rDSy9nhdokf0VDB
         u4gJJXOFFKbA7fIncH6nCuLNFpvlvwAL7TP+HNqegef5vggAeAVZVtTqD0pHAwE+rKF1
         wjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JaQCzndoIKElsDsvqhkhCl2RygfACvXHBtQpId5Vc1c=;
        b=sez4mh09uZczc80EcUH823hn3jySeaka8EBU18ueCQqD8fPkZ9HwYsf5f9EqIDnoSS
         T82SImACg7pUEbUOWvPPSdWlBNYPzUr+Vigg8JVzZhgKhbLSOVX4s2DQYD+x8PUtiO0X
         G+5YnbUeAb/azpbQKKfmdf0sP7w71AuylIjl9fyhn7woRE2v5X/Q8zUM8yX3N7lNSAIw
         d0B8UDqwmNbDMink8MkmxwdFlhNPhTu9rkmsRiBjxnj/n9GF4QJ5zQpdOh+9xYXBBrBc
         /u8oLE0GyjWw0YnKOVYq2qabTxJscRWCl79h1/bjp4cUqevNwIxOJz50wSy/U1jzDmLE
         Zk/Q==
X-Gm-Message-State: AOAM530cXxFdRf+s7R1KxztvKVfmfFwPJIxawjol6X26SpjL1k22F28H
        hKlDjBvOWhcg7g19lQQp+58=
X-Google-Smtp-Source: ABdhPJxuPGmpsFsy5UzCltnN+iZxpIXNeP9GnzMmanpplRZXVgVBhEq1tu6pOlBma+K3eeXlFr3gAQ==
X-Received: by 2002:a05:622a:cc:b0:2f1:fc74:c7a6 with SMTP id p12-20020a05622a00cc00b002f1fc74c7a6mr20139605qtw.387.1652197715031;
        Tue, 10 May 2022 08:48:35 -0700 (PDT)
Received: from localhost ([98.242.65.84])
        by smtp.gmail.com with ESMTPSA id g25-20020a05620a109900b0069fc13ce1e3sm8619248qkk.20.2022.05.10.08.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:48:34 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matti Vaittinen <Matti.Vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH 21/22] cpufreq: use cpumask_weight_gt() in policy_is_shared()
Date:   Tue, 10 May 2022 08:47:49 -0700
Message-Id: <20220510154750.212913-22-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220510154750.212913-1-yury.norov@gmail.com>
References: <20220510154750.212913-1-yury.norov@gmail.com>
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

cpumask_weight_gt() is better than cpumask_weight() because it may
return earlier depending on condition.

CC: Rafael J. Wysocki <rafael@kernel.org>
CC: Viresh Kumar <viresh.kumar@linaro.org>
CC: linux-pm@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/cpufreq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index d5595d57f4e5..865cc9e23518 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -214,7 +214,7 @@ static inline bool policy_is_inactive(struct cpufreq_policy *policy)
 
 static inline bool policy_is_shared(struct cpufreq_policy *policy)
 {
-	return cpumask_weight(policy->cpus) > 1;
+	return cpumask_weight_gt(policy->cpus, 1);
 }
 
 #ifdef CONFIG_CPU_FREQ
-- 
2.32.0

