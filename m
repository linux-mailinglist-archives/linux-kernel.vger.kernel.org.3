Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7004B1A5B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346309AbiBKAYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:24:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346239AbiBKAYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:24:39 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7462735;
        Thu, 10 Feb 2022 16:24:39 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id d188so9541410iof.7;
        Thu, 10 Feb 2022 16:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QAzv4ww8wIlL+as7782AHbg1vH8P76wooakjw6i+3Lc=;
        b=eXLLwoHPmmMGbzE7v0/eoXuOPxdUXwkX/S1PRH7+XaWXBdBlZ2LApOHE3iMbfl1Kr1
         4GwEpbo6DXk12uqn0CKDnMRhKWqc5E3xyz9NlalC6BgjOF5wKrnvMhCPW9SSAhlLLl6m
         SJ7sEazoSG1wTfj/t9S8PKfHMcLUmvpTj5Pc0aeefCRDO6tqtR1xpZoio2/j0k8YYyxX
         zEBfNvS1zpcUSSWrMuGVBIRyH8o5iTxni7dpOaIzvLu25KQaD405JzCGbLLWDXy3I+2R
         RrwzKsgeq5+sh8lMKFvhc8G58okPUNcmv6K7HmZ88pG7t1Y1PPc1VwW9SLPBecuQ6xwT
         /6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QAzv4ww8wIlL+as7782AHbg1vH8P76wooakjw6i+3Lc=;
        b=hTsQWyDyKSbu3ZwsEqV2Lzfe8WDWkNt0zcrOhzoUd/fBQGfNHGuJBM+0ezQFO1d8Vw
         JiJkQor5dpMBA28s2VCM6IETHnXcBobFa2WgdXi9SYoF52ZOi7CLmV1/R7xChSTSgIBk
         2vIW1WItHEmbEACEi7K6cMoCzdApArl0lABv0RwuQXlYiPbgaX4ptBXDaXCmzn9BN/iH
         b56qic+7F/HGQ9Q1uvGmbzmQ/k3Cc21qdMQQclMZD/HAGlfn65Lup4hlmJB2/UjssJYm
         srlWKE1ZeMliouUCh0LXo2Q551VVmkzL8kjChTXs4+xLscfuflTJv+xOgDWtSd7I12f4
         G0nQ==
X-Gm-Message-State: AOAM530PwIyTAlaANtjaQJSyBWmEiboBl4iYqctO07BibVncQK6WLvfl
        1VlMk/tXepdhJS0eAS7TQ94=
X-Google-Smtp-Source: ABdhPJzat5BMCPgkejoDjmOJcB5P48ExVxXh+fEyDvvDxqoIGAU7OXeWm93caqoE2/ZSItwt5e3CXA==
X-Received: by 2002:a6b:ed06:: with SMTP id n6mr5210030iog.88.1644539079119;
        Thu, 10 Feb 2022 16:24:39 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id b5sm6780043ilr.0.2022.02.10.16.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 16:24:38 -0800 (PST)
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
        linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 42/49] scsi: lpfc: replace cpumask_weight with cpumask_weight_gt
Date:   Thu, 10 Feb 2022 14:49:26 -0800
Message-Id: <20220210224933.379149-43-yury.norov@gmail.com>
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

lpfc_cpuhp_get_eq() calls cpumask_weight() to compare the weight of
cpumask with a given number. We can do it more efficiently with
cpumask_weight_gt because conditional cpumask_weight may stop
traversing the cpumask earlier, as soon as condition is (or can't be) met.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/scsi/lpfc/lpfc_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index f5c363f663f6..35688427cb7f 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -12642,7 +12642,7 @@ lpfc_cpuhp_get_eq(struct lpfc_hba *phba, unsigned int cpu,
 		 * gone offline yet, we need >1.
 		 */
 		cpumask_and(tmp, maskp, cpu_online_mask);
-		if (cpumask_weight(tmp) > 1)
+		if (cpumask_weight_gt(tmp, 1))
 			continue;
 
 		/* Now that we have an irq to shutdown, get the eq
-- 
2.32.0

