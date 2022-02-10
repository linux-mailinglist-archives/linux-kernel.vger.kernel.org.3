Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8814B1A51
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346300AbiBKAUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:20:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346272AbiBKAUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:20:13 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8EFC7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:20:13 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id c188so9527067iof.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hLEL9851jabrdDhcxhGMVE1OmCduEAH/N0L9wmwcIjg=;
        b=Ddx6yjYcPE8CmX5hCgpAe3NuBPN+UEnDWxaj/S4nyidlsNp29Qi4nO6yKxahYSYWze
         60wBTMk/1n3Bf0Dn3Qa+ISIEaGAIbwgzWu13tuLljBfaY2PsnoHzOrV4sBzxPCb9gaGE
         obvUhv9/uBtVaE78ha7HcUXUC1VXhfiFzo2TuxG/D3nExuOMPflFJuzfwDMEkVz4obqJ
         U4tJPN3VkTmPOMPDDmKLp4mU6KISHK1gSlamntZK/Ny7CNDDZI5eMEHdTAG8rnsFssRc
         k94GWNgNxamMatkGjEVqYabjh/Rr7UGcEqRtK2QKFls+yc5KuvRZaVEOKnKvt6NXX9jZ
         3Thw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hLEL9851jabrdDhcxhGMVE1OmCduEAH/N0L9wmwcIjg=;
        b=cXJpWoIZBbcONy8B2Eczqxruovs5zoYUw3lJeExo0OcrCZ02rqfSjEDKH0tcRfyxMY
         zsFDMnBJzl+w1TkBC4p93GrzjK0FefD5mktb8l2ZH7T/LEn28VF7amGVHC6IAk011nak
         zU8PB9OGXaA6HlLFlWhSbna5K67Qi+In3K9Z6qLv8PiaJpGJJzuAyLY/9XuQb3ZtOoZ1
         NSY2l4hk3nX02gSjGH57hwpGc9ZvXlRAeTqToQm2F7kNPZ3O+DI/a5zuU1+GFmrlcymR
         DaZL1t/Bg5Uxk70Kfo8R5+U2jsdfv6p7F05Ezcu3hAQARNiIhx6LGtGp8LF7zL7EV34n
         60mQ==
X-Gm-Message-State: AOAM5338q/Xbd5i/sHjvVa8pmQkIkyE5UJPBSBHBSd68m4+2Fus0hOXN
        gr2jQc7pYF0B7OhRcm19KmA=
X-Google-Smtp-Source: ABdhPJw7qdPMYUQVvRvWAT1whw8GJ3WVabvUcKINgiQx0zHMbH9lOyy7aRlH2DJYa0qShCIMVimymQ==
X-Received: by 2002:a6b:7316:: with SMTP id e22mr5135069ioh.125.1644538812801;
        Thu, 10 Feb 2022 16:20:12 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id d12sm11665467ilv.42.2022.02.10.16.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 16:20:12 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 40/49] firmware: pcsi: replace cpumask_weight with cpumask_weight_eq
Date:   Thu, 10 Feb 2022 14:49:24 -0800
Message-Id: <20220210224933.379149-41-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220210224933.379149-1-yury.norov@gmail.com>
References: <20220210224933.379149-1-yury.norov@gmail.com>
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

down_and_up_cpus() calls cpumask_weight() to compare the weight of
cpumask with a given number. We can do it more efficiently with
cpumask_weight_{eq, ...} because conditional cpumask_weight may stop
traversing the cpumask earlier, as soon as condition is (or can't be) met.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/firmware/psci/psci_checker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci_checker.c b/drivers/firmware/psci/psci_checker.c
index 116eb465cdb4..90c9473832a9 100644
--- a/drivers/firmware/psci/psci_checker.c
+++ b/drivers/firmware/psci/psci_checker.c
@@ -90,7 +90,7 @@ static unsigned int down_and_up_cpus(const struct cpumask *cpus,
 		 * cpu_down() checks the number of online CPUs before the TOS
 		 * resident CPU.
 		 */
-		if (cpumask_weight(offlined_cpus) + 1 == nb_available_cpus) {
+		if (cpumask_weight_eq(offlined_cpus, nb_available_cpus - 1)) {
 			if (ret != -EBUSY) {
 				pr_err("Unexpected return code %d while trying "
 				       "to power down last online CPU %d\n",
-- 
2.32.0

