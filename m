Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E37D4E2E9D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351516AbiCUQ7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348165AbiCUQ7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:59:40 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444D73BF89
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:58:14 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id k124-20020a1ca182000000b0038c9cf6e2a6so2642615wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XUH9WW10O8cDNlW6XWZHeYweS24CM22UwaJeFld/Gew=;
        b=AIAMLnn9JL9cbEph7aE6F7EAkIdQuoJnrSd1XK7IfaokJWBkyiJuTHEG2xJqjXABRF
         DfVJMYjKYth04hY+REgO247uCeJPFJotbqvL4x542Dzk+bgkZw1LF82BxIf3DUzks1g8
         aqP3KX8gVsT1Qjjq8hoSepjjNyena6RRm7ZD95Nd/yTFa0nPu74ER7BdzpwvOrkFsv+2
         lON1jO/96OqlDwfeSpES0X7Svof79236Ef4IcBOu2Pmj8vTW8UoZIh4PkAaiwkUczdTn
         7bP7SnlAi24XglfKv2zZvVI99YeDMd5vG8PcusyrqL+vjxrhgvOpwPtiY3OfNRrdYu4W
         eREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XUH9WW10O8cDNlW6XWZHeYweS24CM22UwaJeFld/Gew=;
        b=raQLJj9RWvZz0kaA1SMfZjGKLSxuOBsadt804DVjnGftjmicnBtT325lm8fHN+lleI
         M8aE/dzc8462y1HfXosQ2YR11qUkrunOtYWwF1+nInYzwP2zRmAbqVXSPr0etIn4ZCPE
         /84BkPXaPKTJrgdOUxUjT3QBNMmlkaE9NPmzRtWyfYRqN60QFGxCvCDC/T9INs63o5AG
         Lzp9hgoMMtvK2pLLRXuWqVJIBrOOgeAY7eGJZrRDQcOa5jy0LOc+wlhcHxxn+uc3pj2l
         l3NNaPECfDr4dkzNqQYHMB0j+oOfg0B6lU+Cvx0r+fvWaj6nVqiyX7W2NirxtQFqxMR1
         MflQ==
X-Gm-Message-State: AOAM531nKzIeE/7XEumNQYcnP7+bKFy+rXrS68siWwqjaEQfKD3aujyb
        gl2ELgoaIsRAhyj8IbiTkLYzzDL60s1y/g==
X-Google-Smtp-Source: ABdhPJwgI/lNEfCCsczpCw39SX//lh6xwO+7TI0RNrg77Mxku+B/7LkKfPrAokDRCbpTz7Sym1U5Tg==
X-Received: by 2002:a05:600c:2188:b0:38c:9a21:9c95 with SMTP id e8-20020a05600c218800b0038c9a219c95mr17410wme.87.1647881892727;
        Mon, 21 Mar 2022 09:58:12 -0700 (PDT)
Received: from google.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id az19-20020a05600c601300b0038cadf3aa69sm37767wmb.36.2022.03.21.09.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 09:58:11 -0700 (PDT)
Date:   Mon, 21 Mar 2022 17:58:08 +0100
From:   "Steinar H. Gunderson" <sesse@google.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf intel-pt: Synthesize cycle events
Message-ID: <YjiuoEUL6jH32cBi@google.com>
References: <YjBnet2813sEGjZY@google.com>
 <c50bb87d-9fee-c4f9-a350-8729e503e43a@intel.com>
 <YjDUO6bbyfGw/u0C@google.com>
 <52903e58-e74c-5ea0-36b4-277ea3610af4@intel.com>
 <YjGdoGy4Z2UUG9S9@google.com>
 <ef780335-7dc6-3a23-54a8-b6fc9c8a2ed3@intel.com>
 <YjHfGrZovk3N/H0f@google.com>
 <371faf0d-f794-4a2e-0a1c-9d454d7c8b12@intel.com>
 <YjhUjotmo+kYvoNP@google.com>
 <ffa56520-09b5-9c5d-7733-6767d2f8e350@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ffa56520-09b5-9c5d-7733-6767d2f8e350@intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 03:09:08PM +0200, Adrian Hunter wrote:
> Yes, it can cross calls and returns.  'returns' due to "Return Compression"
> which can be switched off at record time with config term noretcomp, but
> that may cause more overflows / trace data loss.
> 
> To get accurate times for a single function there is Intel PT
> address filtering.
> 
> Otherwise LBRs can have cycle times.

Many interesting points, I'll be sure to look into them.

Meanwhile, should I send a new patch with your latest changes?
It's more your patch than mine now, it seems, but I think we're
converging on something useful.

>> By the way, I noticed that synthesized call stacks do not respect
>> --inline; is that on purpose? The patch seems simple enough (just
>> a call to add_inlines), although it exposes extreme slowness in libbfd
>> when run over large binaries, which I'll have to look into.
>> (10+ ms for each address-to-symbol lookup is rather expensive when you
>> have 4M samples to churn through!)
> No, not on purpose.

The patch appears to be trivial:

--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -44,6 +44,7 @@
 #include <linux/zalloc.h>

 static void __machine__remove_thread(struct machine *machine, struct thread *th, bool lock);
+static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms, u64 ip);

 static struct dso *machine__kernel_dso(struct machine *machine)
 {
@@ -2217,6 +2218,10 @@ static int add_callchain_ip(struct thread *thread,
 	ms.maps = al.maps;
 	ms.map = al.map;
 	ms.sym = al.sym;
+
+	if (append_inlines(cursor, &ms, ip) == 0)
+		return 0;
+
        srcline = callchain_srcline(&ms, al.addr);
        return callchain_cursor_append(cursor, ip, &ms,
                                       branch, flags, nr_loop_iter,

but I'm seeing problems with “failing to process sample” when I go from
10us to 1us, so I'll have to look into that.

I've sent some libbfd patches try to help the slowness:

  https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=30cbd32aec30b4bc13427bbd87c4c63c739d4578
  https://sourceware.org/pipermail/binutils/2022-March/120131.html
  https://sourceware.org/pipermail/binutils/2022-March/120133.html

/* Steinar */
