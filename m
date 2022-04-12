Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161D44FEB1A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiDLX1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiDLX00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:26:26 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F4BD111D;
        Tue, 12 Apr 2022 15:12:39 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n8so279751plh.1;
        Tue, 12 Apr 2022 15:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3k9hJ+Jr3FLe4plE0QRojfka10o+BEOMUnL9QLr63to=;
        b=b8xW3Xp4tiUa99A17UvGdiws13S52S4Ph71zVASv0FurDMkVncFYoaQbU6bD/bZBjL
         2ltYlsc7ueFUx2aHnVe5j8uFZRxWF/M6qeSfoMhdUddNuBDvWczyLAdtqmpFJaMIRn+C
         3gli4kQ0eJgbAcqbiQMqF+mWwweTLI7RLlFoBVKHRY3J2el6BES58xEdBTviXqHW1LY7
         g/Wfus459x+a6QxlrcIu457ETAZpoSQyIH5ht6HjaRE95fQuOI9l1di7baN7dVzcPWjo
         HSwlacoI/Cp4HeY3PKufJESJgb0DTlhl5jlkA6PteFUyrzCGveKuH9wiBafrD7lfu7Dm
         d/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=3k9hJ+Jr3FLe4plE0QRojfka10o+BEOMUnL9QLr63to=;
        b=Kc/uNxhkVIus1NznT7OYUMD4WA2jiP6+gKRIQ4c7W8MiXec0Fg9EFyMrp01jI8yqtf
         5Y3Rpe06wH44JNUMrDIaRuVHAg+Viix0S9B+Oa1Op9O1fEi0atEVIXgrrgU2yreKzZCd
         vlRqGYpSqn0n2oIBDSTywtEndKAAUfOvH88Ms7svvb4z4rJ9XZhKa4ZDqbfx4H0IRi7m
         vfZm5oWKlYdJF3PrpGf9UE9RNAseLpb1HdZVus9GMCJo/AAijhNLNCnwmqjvjgRJyDe2
         JGXfwlR4qsqyYUNcWzbuwLtlj6fLsqIMdvJj+pzy1LufBy0OJaWjpoSjmLwQtpTERUr3
         GpqQ==
X-Gm-Message-State: AOAM531YLsIuFIGZgMX9l4NmJD15qrlhU0uzuDrYBsw6NkqW3XEDkEn4
        Wj46E3x/3uaXwBFoqhRD5XM=
X-Google-Smtp-Source: ABdhPJxAGq96zxVDa8TlnhlBWWqOaluWv4i1QWlDCPsTanYp9kd9IyPDkp8V90q/jKHT1oekaxOeBQ==
X-Received: by 2002:a17:90b:2685:b0:1cb:6521:dd78 with SMTP id pl5-20020a17090b268500b001cb6521dd78mr7448005pjb.194.1649801559276;
        Tue, 12 Apr 2022 15:12:39 -0700 (PDT)
Received: from google.com ([2620:15c:2c1:200:af7f:9aa3:e1d:b65d])
        by smtp.gmail.com with ESMTPSA id u17-20020a056a00159100b004faef351ebcsm38719862pfk.45.2022.04.12.15.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 15:12:38 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
Date:   Tue, 12 Apr 2022 15:12:35 -0700
From:   Namhyung Kim <namhyung@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        James Clark <james.clark@arm.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Li Huafei <lihuafei1@huawei.com>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        William Cohen <wcohen@redhat.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Lexi Shao <shaolexi@huawei.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Denis Nikitin <denik@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 0/4] Tidy up symbol end fixup
Message-ID: <YlX5U+Qelf/rBdau@google.com>
References: <20220412154817.2728324-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220412154817.2728324-1-irogers@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Tue, Apr 12, 2022 at 08:48:13AM -0700, Ian Rogers wrote:
> Fixing up more symbol ends as introduced in:
> https://lore.kernel.org/lkml/20220317135536.805-1-mpetlan@redhat.com/
> caused perf annotate to run into memory limits - every symbol holds
> all the disassembled code in the annotation, and so making symbols
> ends further away dramatically increased memory usage (40MB to
>  >1GB). Modify the symbol end logic so that special kernel cases aren't
> applied in the common case.
> 
> v2. Drops a merged patch. Fixes a build issue with libbfd enabled.

How about just like this?  We can get rid of arch functions as they
mostly do the same thing (kernel vs module boundary check).

Not tested. ;-)

Thanks,
Namhyung

--------------8<-------------

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index dea0fc495185..df41d7266d91 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -35,6 +35,7 @@
 #include "path.h"
 #include <linux/ctype.h>
 #include <linux/zalloc.h>
+#include <internal/lib.h>  // page_size
 
 #include <elf.h>
 #include <limits.h>
@@ -231,8 +226,16 @@ void symbols__fixup_end(struct rb_root_cached *symbols)
                prev = curr;
                curr = rb_entry(nd, struct symbol, rb_node);
 
-               if (prev->end == prev->start || prev->end != curr->start)
-                       arch__symbols__fixup_end(prev, curr);
+               if (prev->end == prev->start) {
+                       /* Last kernel symbol mapped to end of page */
+                       if (!strchr(prev->name, '[') != !strchr(curr->name, '['))
+                               prev->end = roundup(prev->end + 1, page_size);
+                       else
+                               prev->end = curr->start;
+
+                       pr_debug4("%s sym:%s end:%#" PRIx64 "\n",
+                                 __func__, prev->name, prev->end);
+               }
        }
 
        /* Last entry */
