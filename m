Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7555F49749B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239709AbiAWSmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbiAWSlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:41:23 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD83C061779;
        Sun, 23 Jan 2022 10:41:19 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id s61-20020a17090a69c300b001b4d0427ea2so18255143pjj.4;
        Sun, 23 Jan 2022 10:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=O51JzqdRjTovyIC/ZyJHG8/DGtHil0Z7ck+jIlH6LkU=;
        b=fovWQNvb9HXl8jjaVsgHvHD91mAc6xXgJWZPlPm+IeVNkXKL7OujCls6E2KxGZPzWQ
         gMsjVWabAvOW7f2zUVm9nUmszPVm/LvNkenop4bl2wfbaHf92C4EhKaz8UJALNOa2CSQ
         2QeC7jmZf712NfO55cbwanvP9qsc5s1UqgI31E6/XJO9s71Hom9rlzmGjTnZw7loP1BS
         JwcBfchxhi1vztDBwThbFwphp/l4Y6a7XbkVLFh1iNYq3Euk/Gwrtjs6P+FcPk5XTLIA
         wZFGa4mwlZEd6x7LY382e1B4eEWLbifGhQ4BklMMgjDQg/F5t/xaO1CreRGvIFwd34Tj
         JuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O51JzqdRjTovyIC/ZyJHG8/DGtHil0Z7ck+jIlH6LkU=;
        b=k23vRDOW4cW36P2H47L+4+qJ4s9wW09wr9vFi7bBnzQxp2MSf96+/pK17Qtk5RXEjb
         XHGlSZ6Gj76wNGgSnZzj+d2hoBwOgGzcprSB4CQuQwWPG0X7ErvTVJ6QCtQIfyl+sgo7
         8EgKus13qqkeEYL6gwPoeXJpsg6gG0uS/LpwapwT9bTBtxCdDd7V2Bsvl+KSfkrPot0f
         rYJzmcYbOOx+cpeIRfpkiLZ95pVoY7V+g5TuGGp1F1/S+9PKJ0uZRgKTbvYkM0CP1G/s
         3FDnQVK05TycR1SaB8tq1+UOe1okBuo9ZaimrLFrmMIhjp9Rsni6a/QVpOiJbKj45Mxv
         nUAw==
X-Gm-Message-State: AOAM533nnMK+3G1UFrrtZGBroVg+oSvS2oOsrzsqhmkkpCsEtkfDbMVj
        0FxlaF/6AHg8VLiUmzU3lR8=
X-Google-Smtp-Source: ABdhPJx/Of5AQmP5l2CQIGIsuYMrAUDSiAD5BOfqc34X7jNjuGlU1nMl8OEpFrItLTK8Od/kqfWHJQ==
X-Received: by 2002:a17:90b:3b48:: with SMTP id ot8mr9777673pjb.95.1642963279324;
        Sun, 23 Jan 2022 10:41:19 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id f9sm9846505pgf.94.2022.01.23.10.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:41:19 -0800 (PST)
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
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org
Subject: [PATCH 29/54] drivers/iio: replace bitmap_weight() with bitmap_weight_{eq,gt} where appropriate
Date:   Sun, 23 Jan 2022 10:39:00 -0800
Message-Id: <20220123183925.1052919-30-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/iio calls bitmap_weight() to compare the weight of bitmap with
a given number. We can do it more efficiently with bitmap_weight_{eq, gt}
because conditional bitmap_weight may stop traversing the bitmap earlier,
as soon as condition is met.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/iio/dummy/iio_simple_dummy_buffer.c | 4 ++--
 drivers/iio/industrialio-trigger.c          | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c b/drivers/iio/dummy/iio_simple_dummy_buffer.c
index d81c2b2dad82..670997301e47 100644
--- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
+++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
@@ -71,8 +71,8 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 		int i, j;
 
 		for (i = 0, j = 0;
-		     i < bitmap_weight(indio_dev->active_scan_mask,
-				       indio_dev->masklength);
+		     bitmap_weight_gt(indio_dev->active_scan_mask,
+				       indio_dev->masklength, i);
 		     i++, j++) {
 			j = find_next_bit(indio_dev->active_scan_mask,
 					  indio_dev->masklength, j);
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index f504ed351b3e..98c54022fecf 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -331,7 +331,7 @@ int iio_trigger_detach_poll_func(struct iio_trigger *trig,
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(pf->indio_dev);
 	bool no_other_users =
-		bitmap_weight(trig->pool, CONFIG_IIO_CONSUMERS_PER_TRIGGER) == 1;
+		bitmap_weight_eq(trig->pool, CONFIG_IIO_CONSUMERS_PER_TRIGGER, 1);
 	int ret = 0;
 
 	if (trig->ops && trig->ops->set_trigger_state && no_other_users) {
-- 
2.30.2

