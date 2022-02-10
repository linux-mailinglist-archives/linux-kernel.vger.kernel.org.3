Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F604B1A66
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346330AbiBKA0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:26:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346261AbiBKA0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:26:52 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7915594
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:26:52 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id c12so5109451ilm.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1MJU8h6aqi1lREanFgpSWWzF65VdO9IwfkWhBgqaH3Y=;
        b=mvi1bzuGc+ZCDBoKyIvPuu57FjwX/ZNRRmbHLZvq28NxvswbVJpCtL+TPmWTVqyuNq
         zHOVncwF2tsmDVT250gY7kLq+jhckLGi7PlKEqS4kMkEFP1KTu7Z7xjiQlYjB2792Sy0
         y79LwuSrYF42p6Ksm7buY7+zkijxS7uB/hHR9ElJmFJeaWgz2GF8WWh/oKXQxLhRyRAL
         sBCNNuvExT46DRyy/8TIoNJF5PD3spUAqOHHh9NO3ZMs/icV5NIDHPE+azUqsowaetzV
         7cpHrDo+EZ7zUtQ5l6ZDe3klqtAXMvArBpa4JNsPnSEGr2ueqLcJfFXWmveEcH8M/UrG
         z/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1MJU8h6aqi1lREanFgpSWWzF65VdO9IwfkWhBgqaH3Y=;
        b=kjQ/uIH3jWFE9HMBpCZUS59BdbEMlgUUsSdOVC4SnK4i2ebN5bYPHvY3N8c9mMZk/o
         m5H/DVMDioKvyWiSPmL1IKnkN1BglyR9GXfIKu1o9j4xSG2g5mdK4CzTKrwULnC7svc5
         Kvez5gATQriISEdkQaZb52CQIeLKAmtTR3ioVt69WPe9bV5zomF5sktsU4ou302a224b
         apZuo24XMf9TfHzSqb48cbQ48w34hBCSYnBKq3hUBK/Uj7CDpUxssDVa6D8sEDQNwnRA
         Me5NCqoQP0o+qg8bTpzp6lVThao14c3+t+O5pdbyKS3cLE011/vNUIVWNhSYpnJoww+6
         3ljA==
X-Gm-Message-State: AOAM531eR9XqDCJP5E2j9gwx6P1eYV2tVUpZPbp7Ykj+uGT1oRv2leak
        sCPa9NVCkF8H9axy+Yzq+Ms=
X-Google-Smtp-Source: ABdhPJw4HRWGUzFWRINnqDSvHJhe4t426yscU51lkh9YSM6/oOmml5+22RpllautY9urs7QLFyNzJQ==
X-Received: by 2002:a92:ab01:: with SMTP id v1mr5297485ilh.149.1644539212078;
        Thu, 10 Feb 2022 16:26:52 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id y22sm12896727iow.2.2022.02.10.16.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 16:26:51 -0800 (PST)
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
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 43/49] soc/qman: replace cpumask_weight with cpumask_weight_lt
Date:   Thu, 10 Feb 2022 14:49:27 -0800
Message-Id: <20220210224933.379149-44-yury.norov@gmail.com>
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

qman_test_stash() calls cpumask_weight() to compare the weight of cpumask
with a given number. We can do it more efficiently with cpumask_weight_lt
because conditional cpumask_weight may stop traversing the cpumask earlier,
as soon as condition is (or can't be) met.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/soc/fsl/qbman/qman_test_stash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qbman/qman_test_stash.c b/drivers/soc/fsl/qbman/qman_test_stash.c
index b7e8e5ec884c..28b08568a349 100644
--- a/drivers/soc/fsl/qbman/qman_test_stash.c
+++ b/drivers/soc/fsl/qbman/qman_test_stash.c
@@ -561,7 +561,7 @@ int qman_test_stash(void)
 {
 	int err;
 
-	if (cpumask_weight(cpu_online_mask) < 2) {
+	if (cpumask_weight_lt(cpu_online_mask, 2)) {
 		pr_info("%s(): skip - only 1 CPU\n", __func__);
 		return 0;
 	}
-- 
2.32.0

