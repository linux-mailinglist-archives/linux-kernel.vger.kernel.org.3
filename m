Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DB5598A8E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 19:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344914AbiHRRez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 13:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242760AbiHRRet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:34:49 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DB8B8A52
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 10:34:48 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gk3so4513956ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 10:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8C8Dlbh6hGdjbOzzw+aOgiCLWngIvwE1cGPWagEPaog=;
        b=SoX+TY0L/rFLydx6islcW0cPp3zArfZX1L5teZW57X9csGqiO6VZGcHCnZmjqss5ZB
         8LVaZlv0G2jdvgvLG035gdYCm0vbOdZxpv+GQLfINDFBiaPtRfu44FxFUD+kYM8eXwih
         eR8dFlewXiXk3bVOa9S/0ZqHWvRKs+n5rwSHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8C8Dlbh6hGdjbOzzw+aOgiCLWngIvwE1cGPWagEPaog=;
        b=mvqFUa2Z9AYuAX3WUZoQIaHY0excphtn1bQqaJHUA4/K/bs1yHxixTgv/NcP4kKmSO
         H63zZ/yokNDiPyjeTo4qwQ+wDhF0BMe3ixQA6mD+75EeouYMzDuvLXUwfc7YNfgMG61D
         DUIu/bnABFynYpeOPWfg+aCmaA3CXIgyzzrubbEwmpGk82RWjb9hPiFc8TEHvUjuLW8q
         Upki99njXbx3tR2lCjRWc3GD1aYMV0Iwfp6NEZuXf9BhwaAkAO2LT0beEj7Hzq6qxT6v
         mRkmZX/mPVGH/TFzi8kSmCeSYd+N7Ug1D2JDoTptp3vw5Ye2/R9XZObpfbSjeB5wz6KB
         M+7g==
X-Gm-Message-State: ACgBeo1qKRhs4PFI9CtjKeODziXUkRXwjNtMzVR/O3XUh3/+rPfiFQi8
        cn+ovmR82iywFlF4pBxIIFDwTn4uExtH1MaE
X-Google-Smtp-Source: AA6agR4l11/YDBAzONYL3RdN5+IbSj5kxC5JdG+AJMqFaB+MoQMH6nDs2Zlu3+OC0RcCjI4zfujf7Q==
X-Received: by 2002:a17:906:cc4d:b0:730:b5fd:8986 with SMTP id mm13-20020a170906cc4d00b00730b5fd8986mr2442643ejb.428.1660844086770;
        Thu, 18 Aug 2022 10:34:46 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id a2-20020a1709066d4200b00730df07629fsm1125889ejt.174.2022.08.18.10.34.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 10:34:45 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id s23so1170253wmj.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 10:34:44 -0700 (PDT)
X-Received: by 2002:a05:600c:4ece:b0:3a6:28:bc59 with SMTP id
 g14-20020a05600c4ece00b003a60028bc59mr5714170wmq.154.1660844084283; Thu, 18
 Aug 2022 10:34:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220817162703.728679-1-bigeasy@linutronix.de> <20220817162703.728679-2-bigeasy@linutronix.de>
In-Reply-To: <20220817162703.728679-2-bigeasy@linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 18 Aug 2022 10:34:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgCRJx74T0NyRrpWi6XRwy50y8Wzap5XK_3-hN8dbuxTw@mail.gmail.com>
Message-ID: <CAHk-=wgCRJx74T0NyRrpWi6XRwy50y8Wzap5XK_3-hN8dbuxTw@mail.gmail.com>
Subject: Re: [PATCH 1/9] slub: Make PREEMPT_RT support less convoluted
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
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

On Wed, Aug 17, 2022 at 9:27 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> The slub code already has a few helpers depending on PREEMPT_RT. Add a few
> more and get rid of the CONFIG_PREEMPT_RT conditionals all over the place.
>
> No functional change.

Looks like a fine cleanup, but I'd prefer that

  #define use_lockless_fast_path()       {(true)/(false)}

to look much less like it's some function call. The first read-through
it looked like some very dynamic thing to me.

Just doing

   #define USE_LOCKLESS_FAST_PATH       ..

would make it much more visually obvious that it's not some kind of
complex run-time decision.

               Linus
