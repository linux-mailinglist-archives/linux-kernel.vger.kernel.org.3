Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CE05A180E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 19:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242798AbiHYRjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 13:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbiHYRjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 13:39:07 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EEEB7ECE
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 10:39:06 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id p9-20020a17090a2d8900b001fb86ec43aaso5491573pjd.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 10:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=l8SKx3DLCsWjrbf+C34ViB+f4pSd672ASOgSDbuta5I=;
        b=iwHiefl9dhv02RxTx25tO/AMjPurmpEHjdSdPOHv5xQpmCLc5XMqVwv4Yd3lLkN8mp
         uS2HhJXQ+ab6br3YCR6jk8osL/2tK+d7uhh253rg4+FYiI5OH8XP4V+ZnE7WddesmUxe
         JUjFQhueO1XaRRmfTR33uxz7PZx+eUAFZaN3KYweZNUO4U0noC9/I5QylPI/U3oeD++v
         sYs7aNAi6J5PAKe6GmbgVKlQ1Pv7a+hhAM0rmUgkf9p9OGsMOQyz78slf2Ih5eXNhapP
         CZBlFNujhlfPNsoSfQRoQEafazs6zRLrirmhyqGCgst0jTFRP6IsI5ItFYiY0RPbF2ex
         /5sw==
X-Gm-Message-State: ACgBeo0FA6a8EghYz0cL4QSLCGUYNMOS0KAggF+GkWIwbjWM65w4uKXc
        Ld8ZDxC8rt49RfLCSbL4M9Q=
X-Google-Smtp-Source: AA6agR5nR121oTNNTKhzgdZ80H4bfY7KwXgkpayMKA5VMIIveNluhVXZstREFGcaHzRrFhSFnz+JhQ==
X-Received: by 2002:a17:90b:38ce:b0:1fb:7334:2554 with SMTP id nn14-20020a17090b38ce00b001fb73342554mr240007pjb.110.1661449145941;
        Thu, 25 Aug 2022 10:39:05 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:349c:3078:d005:5a7e? ([2620:15c:211:201:349c:3078:d005:5a7e])
        by smtp.gmail.com with ESMTPSA id b8-20020a17090a5a0800b001f56315f9efsm3829796pjd.32.2022.08.25.10.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 10:39:04 -0700 (PDT)
Message-ID: <7bc72b9d-79b0-5b8c-18c4-4a5c914efdc5@acm.org>
Date:   Thu, 25 Aug 2022 10:39:02 -0700
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
        Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@chromium.org>
References: <20220821000737.328590235@goodmis.org>
 <20220821000844.510643400@goodmis.org>
 <CAHk-=wjsxu782N0P+oMu35N7rJAOeh3buQFWJaZHZTNmVSB=3Q@mail.gmail.com>
 <5700ac75-f6a9-877e-4011-9b314f12b5ab@acm.org>
 <CAHk-=wjqkWEr0MRO5hWuBoTDgNUj4qQK8V_Y36et=61mdPztJw@mail.gmail.com>
 <02daa3d6-2847-d7e0-e23e-411076c6d4db@rasmusvillemoes.dk>
 <0163b361-14bf-7b4c-751a-14f1a004b1a9@acm.org>
 <CAHk-=wjMLb30d0WT_RyKBCX+JBkg3QQU6pCYkrV8f58Ya4Rgzw@mail.gmail.com>
 <b79c83af-e9fc-9fa0-dff7-f3a8a39887ff@acm.org>
 <CAHk-=wgV1F7_ErXkXT2wd+07LJd_3Vp-yVUKLROPiEgijeoTrQ@mail.gmail.com>
 <353e5bbd-cdd1-f818-6a2f-9a7c800f9879@acm.org>
 <CAHk-=whSZ20Hv4EyLDtUZGX4MsYmCLQ4+OOTbv1WEXfXDcxnWw@mail.gmail.com>
 <CAHk-=wjQGnVfb4jehFR0XyZikdQvCZouE96xR_nnf5kqaM5qqQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHk-=wjQGnVfb4jehFR0XyZikdQvCZouE96xR_nnf5kqaM5qqQ@mail.gmail.com>
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

On 8/24/22 17:40, Linus Torvalds wrote:
> Actually, thinking about it, that was simple enough.
> 
>    -#define is_signed_type(type)   (((type)(-1)) < (type)1)
>    +#define is_signed_type(type)   (((type)(-1)) < (__force type)1)
> 
> should work.
> 
> It looks a bit odd, because we only force one side.
> 
> But we only need to force one side, because the '-1' doesn't have any
> issues with bitwise types, the same way 0 doesn't.
> 
> So only '1' needs to be force-cast to avoid a warning about casting an
> integer to a bitwise type.
> 
> And since that -1 counts as an unrestricted value after a cast, now
> the ordered comparison doesn't warn either.
> 
> Now, admittedly I think sparse should also allow a forced cast of an
> unrestricted value to be unrestricted, so I think I should do this
> 
>   static int restricted_value(struct expression *v, struct symbol *type)
>   {
> -       if (v->type == EXPR_CAST)
> +       if (v->type == EXPR_CAST || v->type = EXPR_FORCE_CAST)
>                  v = v->cast_expression;
> 
> in sparse, but even without that the above "is_signed_type()" macro
> should make sparse happy (with that current tree of mine).
> 
> And since we don't now need to cast 0, gcc won't complain about that
> NULL pointer comparison.
> 
> Does that solve things for you?

Yes, thank you! No sparse warnings are triggered by the is_signed_type()
macro and the gcc warning about ordered comparison of a pointer with the
null pointer is gone.

The patch I came up with is available below. If nobody picks it up from
this email I will try to find an appropriate kernel maintainer to send
this kernel patch to.

Thanks,

Bart.


From: Bart Van Assche <bvanassche@acm.org>
Date: Tue, 23 Aug 2022 12:59:25 -0700
Subject: [PATCH] tracing: Define the is_signed_type() macro once

There are two definitions of the is_signed_type() macro: one in
<linux/overflow.h> and a second definition in <linux/trace_events.h>.

As suggested by Linus Torvalds, move the definition of the
is_signed_type() macro into the <linux/compiler.h> header file. Change
the definition of the is_signed_type() macro to make sure that it does
not trigger any sparse warnings with future versions of sparse for
bitwise types. See also:
https://lore.kernel.org/all/CAHk-=whjH6p+qzwUdx5SOVVHjS3WvzJQr6mDUwhEyTf6pJWzaQ@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wjQGnVfb4jehFR0XyZikdQvCZouE96xR_nnf5kqaM5qqQ@mail.gmail.com/

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
  include/linux/compiler.h     | 6 ++++++
  include/linux/overflow.h     | 1 -
  include/linux/trace_events.h | 2 --
  3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 01ce94b58b42..7713d7bcdaea 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -239,6 +239,12 @@ static inline void *offset_to_ptr(const int *off)
  /* &a[0] degrades to a pointer: a different type from an array */
  #define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))

+/*
+ * Whether 'type' is a signed type or an unsigned type. Supports scalar types,
+ * bool and also pointer types.
+ */
+#define is_signed_type(type) (((type)(-1)) < (__force type)1)
+
  /*
   * This is needed in functions which generate the stack canary, see
   * arch/x86/kernel/smpboot.c::start_secondary() for an example.
diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index f1221d11f8e5..0eb3b192f07a 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -30,7 +30,6 @@
   * https://mail-index.netbsd.org/tech-misc/2007/02/05/0000.html -
   * credit to Christian Biere.
   */
-#define is_signed_type(type)       (((type)(-1)) < (type)1)
  #define __type_half_max(type) ((type)1 << (8*sizeof(type) - 1 - is_signed_type(type)))
  #define type_max(T) ((T)((__type_half_max(T) - 1) + __type_half_max(T)))
  #define type_min(T) ((T)((T)-type_max(T)-(T)1))
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index b18759a673c6..8401dec93c15 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -814,8 +814,6 @@ extern int trace_add_event_call(struct trace_event_call *call);
  extern int trace_remove_event_call(struct trace_event_call *call);
  extern int trace_event_get_offsets(struct trace_event_call *call);

-#define is_signed_type(type)	(((type)(-1)) < (type)1)
-
  int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
  int trace_set_clr_event(const char *system, const char *event, int set);
  int trace_array_set_clr_event(struct trace_array *tr, const char *system,
