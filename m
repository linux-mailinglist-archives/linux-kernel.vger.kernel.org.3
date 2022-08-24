Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5500C59F016
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 02:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbiHXAJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 20:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiHXAJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 20:09:17 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC54554678
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 17:09:15 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id x14-20020a17090a8a8e00b001fb61a71d99so3635857pjn.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 17:09:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=N8z/G91/SbtVlc37TcfygB6X/h5Jzj+Q20SD9rHN/eM=;
        b=nR4DwypWavBq1kA84tNznStdKyAj7ULAVa2ys7jRomjK64GP17Hjs77O6VZjcToS9H
         Di0ayYEXAXFLi3P4fwcJYzkp2pcX9rcPsXR9b1CMWzU1dwKe+0UTbR27FaVsGUNu+Pp1
         eiANOPSIKkW42wLgBAo4i0a4KRkrY3WFlao9tN5G82hzzlCkydXeWDf4u0RJxX7Glvtk
         +LYaqBT2h4jZLShoHlhtfTAToMcViM7RWFbMLPYAsZhrvCiUcJcbc9NzuPM9oiZL3srK
         r9SG5InuAzfajJhR9mwhCAJubRFW0h9duLqx5XiOD0K7LSareny3FmO9m86SAi3HsXOB
         kjgw==
X-Gm-Message-State: ACgBeo24g17o5lHlOAWUOVEH3g7akeMmQltB8bKy6c5Ee/8kO3375Doj
        4mOjSMitp1iqsfgbi7b8z5Y=
X-Google-Smtp-Source: AA6agR7PYtcFO7smnhWXvdkzMBKVuALHkgGyenNnkWvDy/mdiif9A+aQv9WapXdPCOJddzE+nqDMhQ==
X-Received: by 2002:a17:90a:c789:b0:1fa:6bc0:77f6 with SMTP id gn9-20020a17090ac78900b001fa6bc077f6mr5714383pjb.1.1661299755208;
        Tue, 23 Aug 2022 17:09:15 -0700 (PDT)
Received: from ?IPV6:2620:0:1000:2514:88b5:5b05:a7c4:f02b? ([2620:0:1000:2514:88b5:5b05:a7c4:f02b])
        by smtp.gmail.com with ESMTPSA id m6-20020a1709026bc600b0016c9e5f290esm9115754plt.10.2022.08.23.17.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 17:09:14 -0700 (PDT)
Message-ID: <b79c83af-e9fc-9fa0-dff7-f3a8a39887ff@acm.org>
Date:   Tue, 23 Aug 2022 17:09:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [for-linus][PATCH 01/10] tracing: Suppress sparse warnings
 triggered by is_signed_type()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20220821000737.328590235@goodmis.org>
 <20220821000844.510643400@goodmis.org>
 <CAHk-=wjsxu782N0P+oMu35N7rJAOeh3buQFWJaZHZTNmVSB=3Q@mail.gmail.com>
 <5700ac75-f6a9-877e-4011-9b314f12b5ab@acm.org>
 <CAHk-=wjqkWEr0MRO5hWuBoTDgNUj4qQK8V_Y36et=61mdPztJw@mail.gmail.com>
 <02daa3d6-2847-d7e0-e23e-411076c6d4db@rasmusvillemoes.dk>
 <0163b361-14bf-7b4c-751a-14f1a004b1a9@acm.org>
 <CAHk-=wjMLb30d0WT_RyKBCX+JBkg3QQU6pCYkrV8f58Ya4Rgzw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHk-=wjMLb30d0WT_RyKBCX+JBkg3QQU6pCYkrV8f58Ya4Rgzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/22 16:18, Linus Torvalds wrote:
> On Tue, Aug 23, 2022 at 3:05 PM Bart Van Assche <bvanassche@acm.org> wrote:
>>
>> Thank you Rasmus for having shared this information. Since sparse will
>> have to be modified anyway, how about extending it such that the bitwise
>> attribute can be removed from a type, e.g. via a new no_bitwise
>> attribute?
> 
> I think it's actually easier to just make sparse happy.
> 
> Can you try the sparse version at
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/sparse.git
> 
> which I just set up temporarily with some patches of mine. It also
> makes that '__cond_acquires' thing work that refcount_dec_and_lock()
> uses.
> 
> It does require that kernel change to make
> 
>    #define is_signed_type(type)   (((type)(-1)) <= (type)0)
> 
> in both places, since only "no bits set" and "all bits set" are
> special values for bitwise types.
> 
> Those patches of mine are fairly hacky, and I think Luc would probably
> do it differently, but apart from the very last one, they aren't
> actively disgusting.

Hi Linus,

I'm probably doing something wrong but even with sparse commit 658ee8e0f631
("unrestricted values are unrestricted even after a cast") I see warnings
being triggered by users of the is_signed_type() macro, warnings that
disappear if I change the definition of the is_signed_type() macro into 0:

$ make C=2 fs/f2fs/ </dev/null |& grep blk_opf_t
./include/trace/events/f2fs.h:1027:1: warning: restricted blk_opf_t degrades to integer
./include/trace/events/f2fs.h:1027:1: warning: restricted blk_opf_t degrades to integer
./include/trace/events/f2fs.h:1027:1: warning: restricted blk_opf_t degrades to integer
./include/trace/events/f2fs.h:1027:1: warning: restricted blk_opf_t degrades to integer
./include/trace/events/f2fs.h:1086:1: warning: restricted blk_opf_t degrades to integer
./include/trace/events/f2fs.h:1086:1: warning: restricted blk_opf_t degrades to integer
./include/trace/events/f2fs.h:1086:1: warning: restricted blk_opf_t degrades to integer
./include/trace/events/f2fs.h:1086:1: warning: restricted blk_opf_t degrades to integer

This is the kernel patch that I applied:

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index f1221d11f8e5..10c55f97e02b 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -30,7 +30,7 @@
   * https://mail-index.netbsd.org/tech-misc/2007/02/05/0000.html -
   * credit to Christian Biere.
   */
-#define is_signed_type(type)       (((type)(-1)) < (type)1)
+#define is_signed_type(type)       (((__force type)(-1)) <= (__force type)0)
  #define __type_half_max(type) ((type)1 << (8*sizeof(type) - 1 - is_signed_type(type)))
  #define type_max(T) ((T)((__type_half_max(T) - 1) + __type_half_max(T)))
  #define type_min(T) ((T)((T)-type_max(T)-(T)1))
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index b18759a673c6..c74cfa657025 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -9,6 +9,7 @@
  #include <linux/hardirq.h>
  #include <linux/perf_event.h>
  #include <linux/tracepoint.h>
+#include <linux/overflow.h>

  struct trace_array;
  struct array_buffer;
@@ -814,8 +815,6 @@ extern int trace_add_event_call(struct trace_event_call *call);
  extern int trace_remove_event_call(struct trace_event_call *call);
  extern int trace_event_get_offsets(struct trace_event_call *call);

-#define is_signed_type(type)   (((type)(-1)) < (type)1)
-
  int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
  int trace_set_clr_event(const char *system, const char *event, int set);
  int trace_array_set_clr_event(struct trace_array *tr, const char *system,

Thanks,

Bart.
