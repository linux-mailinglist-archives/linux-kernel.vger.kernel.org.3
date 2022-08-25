Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1561C5A052F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 02:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiHYAah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 20:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHYAae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 20:30:34 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F066980F7B
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 17:30:33 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b44so3847755edf.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 17:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=+SjRjQqveI6Ih3yl6rkyKutk7MRmiwEiXNEtef0zKLM=;
        b=DbMK7Pbu82/LgqHz1O9x+gKY4qbRsAjUrOvCnWnU0MBz0RO7SVRcEQpPecEoY1CYRT
         OMQKyf7TVaDWMasLejvje3K3FWLZ97Rc92PRuf0et1Esz1qoDkEXq8NyBIcaN/DO4SgU
         O4qJU5xBz4rvniBUnWNY6Tj7Fr1K6awq9xD3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+SjRjQqveI6Ih3yl6rkyKutk7MRmiwEiXNEtef0zKLM=;
        b=1Tg+s1V7NFjBBgGzQ8rhRCta6+I2N2UaGqsA+WulUIwsumsESfG5RXoUL1TQq7CFEZ
         5lhMis9GbEv/2sSkBS7auPavWca2PGtDV6DFxjIr2SI5fu8QulbI7AHStjeyZAUUrdCY
         9LM7YTRHcTE8rpgFJc51jwSv+fhn9xtH/aNJchLFUzakv0Ez/LkvKyyjwxavxp/AKbZ2
         em2+oKiwOnEM2QwQrjsXVjIMsm8xGkucJGeHAf8xh+5hV4OKEbRHIj8uqbJZTEfVaH7l
         X8R8R1PC/B5YENimNTahwNe2RGODnO4bg1bPTmekYP6QwGsEMaRwcFWWE4V3VjZ86c8g
         FxMA==
X-Gm-Message-State: ACgBeo19gGjNUgXmXP6s4sV30YnJNhwyPH1hqR+1EeYH+ClScGYjhPnM
        O8+FNSm/fv57QXkrZafKIYSSm4bTc5/3tL97
X-Google-Smtp-Source: AA6agR6Av1WBJYfp0r7hxz0JlYrvObOxHqTDA6ueLqTkVckN+Ga/50Sgt8cB3yjMnzYXp5tnGMhyVw==
X-Received: by 2002:aa7:cb06:0:b0:446:7668:2969 with SMTP id s6-20020aa7cb06000000b0044676682969mr1149712edt.206.1661387432240;
        Wed, 24 Aug 2022 17:30:32 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id f22-20020a170906139600b0072b1bc9b37fsm1736432ejc.22.2022.08.24.17.30.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 17:30:26 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id j26so9504406wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 17:30:24 -0700 (PDT)
X-Received: by 2002:a05:600c:4ece:b0:3a6:28:bc59 with SMTP id
 g14-20020a05600c4ece00b003a60028bc59mr6485388wmq.154.1661387424438; Wed, 24
 Aug 2022 17:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220821000737.328590235@goodmis.org> <20220821000844.510643400@goodmis.org>
 <CAHk-=wjsxu782N0P+oMu35N7rJAOeh3buQFWJaZHZTNmVSB=3Q@mail.gmail.com>
 <5700ac75-f6a9-877e-4011-9b314f12b5ab@acm.org> <CAHk-=wjqkWEr0MRO5hWuBoTDgNUj4qQK8V_Y36et=61mdPztJw@mail.gmail.com>
 <02daa3d6-2847-d7e0-e23e-411076c6d4db@rasmusvillemoes.dk> <0163b361-14bf-7b4c-751a-14f1a004b1a9@acm.org>
 <CAHk-=wjMLb30d0WT_RyKBCX+JBkg3QQU6pCYkrV8f58Ya4Rgzw@mail.gmail.com>
 <b79c83af-e9fc-9fa0-dff7-f3a8a39887ff@acm.org> <CAHk-=wgV1F7_ErXkXT2wd+07LJd_3Vp-yVUKLROPiEgijeoTrQ@mail.gmail.com>
 <353e5bbd-cdd1-f818-6a2f-9a7c800f9879@acm.org>
In-Reply-To: <353e5bbd-cdd1-f818-6a2f-9a7c800f9879@acm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Aug 2022 17:30:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=whSZ20Hv4EyLDtUZGX4MsYmCLQ4+OOTbv1WEXfXDcxnWw@mail.gmail.com>
Message-ID: <CAHk-=whSZ20Hv4EyLDtUZGX4MsYmCLQ4+OOTbv1WEXfXDcxnWw@mail.gmail.com>
Subject: Re: [for-linus][PATCH 01/10] tracing: Suppress sparse warnings
 triggered by is_signed_type()
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 4:28 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> Can you take a look at the following report from the kernel test robot:
> https://lore.kernel.org/all/202208250433.EVz5pZkB-lkp@intel.com/ ?
>
> Do I see correctly that gcc reports a new warning for the above
> definition of is_signed_type() with W=1? I'm not sure how to get rid of
> that new gcc warning without reintroducing a sparse warning.

Indeed. It looks like now gcc recognizes it as a NULL pointer, and
then special-cases that and warns for it.

Oh, how very annoying.

Let me think about this.

               Linus
