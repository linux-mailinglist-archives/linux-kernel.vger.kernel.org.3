Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6BDF4974C6
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbiAWSn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240206AbiAWSmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:42:39 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955F0C0613DE
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:42:38 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id q63so9477391pja.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=eurCTfqQPWvOuAgaV33nc0wGgUHFJYL01lWf+T5k2PY=;
        b=FFMT2f8tr34dAdw6qtWLyYPfB4JxqS9+3IX2kpUT3TpR8TAPWwSftQobhiNpybwI9a
         EiyLHk4tFUU5q5iqJ+glN5C5lddCZMB0OD2kYc2syyqq54rQ17CHadonX5bGub/FIJTp
         IECKqMlX01o+0SdqQs2yGwrqdHoTitmFEo34i5Bh8cDa9724NVJqUdgwSFIcJ5BNZ8gj
         ChoRMM6wgOtyJzqG3JoUYUh8u+GT6RSw6PrBcgAsCInNy/UuWQtvvW8mAikxyZ0Pe1ua
         ptvxnd66XB0Od3rvoUFylEiHd66+ccWXgvquEi+7+ZkI4gQpMOnPcTy+jSZMeCttgU15
         NVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eurCTfqQPWvOuAgaV33nc0wGgUHFJYL01lWf+T5k2PY=;
        b=BFinx2CpKC7i/iOGrSN+3YzITcuSQzG00iII/tnX/MR2bYNq06xlYsaDx8RqDVmgra
         XprB5bu0JEpoBG5pLi9+RtruLz2VjY9AFZPk8Z+X0jn4j5JG3aPA+Eb7U8OPrhSuGXkE
         ak5kIa8CkAHdCpSJl59SDiB3Dt16RaPzto71YWfO1weeolicU0zYtxkkDR5j6bGtCfrS
         keP4DnQ5L0Narx5M8Be49INS4CdV0xa/rptSFaJo4gNGb6FtbxwGztBeBWNL6Ovr0PGs
         xH3Njw8JaSvWa40Bz5ChE0trTCWzdb3dN5wtKQp15nT11Rq38/jOl6BLafUj8UvHjoY1
         2mMw==
X-Gm-Message-State: AOAM530D/V573RFhd6To9l3XTsM5y1DHKHCjl+Ru++6MnUyYZE7QA2SC
        FfU5dxws0sbiyYDAFDqWI/o=
X-Google-Smtp-Source: ABdhPJzf3y0mSqzIQNCHu5M8urUCU9T6nbBKxdNMprAK5Xer13Pwyl+y6AEUQai5c7RvsuvJOXpPNQ==
X-Received: by 2002:a17:902:8305:b0:14a:bd99:203b with SMTP id bd5-20020a170902830500b0014abd99203bmr11479566plb.74.1642963358028;
        Sun, 23 Jan 2022 10:42:38 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id z15sm9867945pgf.66.2022.01.23.10.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:42:37 -0800 (PST)
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
        linux-kernel@vger.kernel.org
Subject: [PATCH 54/54] MAINTAINERS: add cpumask and nodemask files to BITMAP_API
Date:   Sun, 23 Jan 2022 10:39:25 -0800
Message-Id: <20220123183925.1052919-55-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpumask and nodemask APIs are thin wrappers around basic bitmap API, and
corresponding files are not formally maintained. This patch adds them to
BITMAP_API section, so that bitmap folks would have closer look at it.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 27730a5a6345..7a3798de61c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3412,10 +3412,14 @@ R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 R:	Rasmus Villemoes <linux@rasmusvillemoes.dk>
 S:	Maintained
 F:	include/linux/bitmap.h
+F:	include/linux/cpumask.h
 F:	include/linux/find.h
+F:	include/linux/nodemask.h
 F:	lib/bitmap.c
+F:	lib/cpumask.c
 F:	lib/find_bit.c
 F:	lib/find_bit_benchmark.c
+F:	lib/nodemask.c
 F:	lib/test_bitmap.c
 F:	tools/include/linux/bitmap.h
 F:	tools/include/linux/find.h
-- 
2.30.2

