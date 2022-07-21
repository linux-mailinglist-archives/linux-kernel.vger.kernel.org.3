Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1EA57C38F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 06:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiGUEg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 00:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbiGUEgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 00:36:52 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79839201B3;
        Wed, 20 Jul 2022 21:36:50 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id l124so680028pfl.8;
        Wed, 20 Jul 2022 21:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Tm3AHOmJIo0LacOb7QWvPa4kYeHblOrKXCz3/M7PV0=;
        b=nHAvR4E2L/igqO9S7PJm4qOdZOfSW81xtL0MPTSjTU4Bv80e9a/91ZfjDvjjS4abpn
         hDluGNPX7zdoyvh0apqG+8XRD8jPOIV4eS7dbcheZVnSl7sd+u985webkG/1QQiJSVPb
         vk3hfBguQdKD8QD4Fg9eXXid+eiuW7aGllfD6gmDoOIOYAnxzyjBVr5rO5vid5Rd8rkx
         KtqfNZ182ySu63T+XXpHELf4d6p4x2RQvts0oQeISoUjf1H+rcon2gMFdmVNVtWt2Lb+
         u828qLVvH8tn/CrvD+XxND0FTm+xRS+z+FGR3/EcqhjcC+vBflJPLvxeWHfhVxsKt3uO
         ANpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=9Tm3AHOmJIo0LacOb7QWvPa4kYeHblOrKXCz3/M7PV0=;
        b=wivNz0CIhxapmAZ0EIQZTt56T954VZPJbO45nJ5weAAfyLi2VZZ9XJ2koKkF8xRklv
         HKXwpmxUxzhcTjEkDbrftQSRz9NgC9GSKNXYAp8v/y1h2E9FwvLVLuq4t9Qhy0b9g5Lv
         +OwxIkOD4hSi1SOu0z6/rVt17dwGG4R80YfGAufZt/TLP/LxH+xBI+amMKlqkHzrwf9K
         EqAXrveLyKD+9B0NdXUM8wXcI65jPEXC5mdFtcBwww5buTUWVt/bRb8ESW+dAz8yTbU+
         TX+5f9UpEIbga8y7RTk8wJ+XvayqjsOf5k2izuHyk/zOZwhgp03NdXbOpQJsbCm13pQa
         QfpA==
X-Gm-Message-State: AJIora9x2Fw70l3GFrTqGPk9IY1pnVY8EKelilS9Us/6RKvLwkW6jPkQ
        /m3BiOPGKRdxIy8ObuKloms=
X-Google-Smtp-Source: AGRyM1uxrGSa0yoBJ3pzloZKuuHoei85kxEJBRAbWJkYgMTBxm0GCErvon54rmwButMdBHswD8A5JQ==
X-Received: by 2002:a63:4c0d:0:b0:41a:77fe:2bc8 with SMTP id z13-20020a634c0d000000b0041a77fe2bc8mr3393322pga.82.1658378209878;
        Wed, 20 Jul 2022 21:36:49 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([2607:fb90:467:a1e4:c167:53fd:8047:7f62])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902a38b00b0016bea2a0a8dsm450824pla.91.2022.07.20.21.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 21:36:49 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 1/6] perf lock: Fix a copy-n-paste bug
Date:   Wed, 20 Jul 2022 21:36:39 -0700
Message-Id: <20220721043644.153718-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220721043644.153718-1-namhyung@kernel.org>
References: <20220721043644.153718-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should be lock_text_end instead of _start.

Fixes: 0d2997f750d1 ("perf lock: Look up callchain for the contended locks")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index c5ca34741561..0aae88fdf93a 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -892,7 +892,7 @@ static bool is_lock_function(u64 addr)
 		sym = machine__find_kernel_symbol_by_name(machine,
 							  "__lock_text_end",
 							  &kmap);
-		lock_text_start = kmap->unmap_ip(kmap, sym->start);
+		lock_text_end = kmap->unmap_ip(kmap, sym->start);
 	}
 
 	/* failed to get kernel symbols */
-- 
2.37.0.170.g444d1eabd0-goog

