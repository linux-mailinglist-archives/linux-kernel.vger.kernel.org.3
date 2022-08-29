Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6138C5A548E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 21:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiH2TaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 15:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiH2TaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:30:04 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C55B491
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 12:30:02 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j9-20020a17090a3e0900b001fd9568b117so5966682pjc.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 12:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=oa2sUMnuAiCBR/aSHTo44J5ZbK5iRMO7fq7mvPz7L6c=;
        b=RXXrIGik23Q5wbkodKbTfmCxJTWWFu3fBpG3lBPxBZ3SIK35hNbtNYjV1zOgKGDcSF
         k2tbmzNx6qhFMrGgtXAj01SBXBwnCVuzVzVNN0hwnJRAkN4M+8Q7kviuz4YYnkYYe3hi
         Is5tYMlhs5q1+I8QUiQKqelf0ZdKN9cEwlqOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=oa2sUMnuAiCBR/aSHTo44J5ZbK5iRMO7fq7mvPz7L6c=;
        b=6VAU+HUdPDaLMB4sRtGpqnXgQSaGSCXbsWWGUs0n+yCAq41H/GTckJK2NKfxkzlJID
         EI44bK0TOndVjdSMkkssLBYfP/Jm6TBPvkw47v1aIM9Xas+c8x8+KmHMAVXtRSGcMt+J
         tb8aUMUaUkmJyDCo6RUoRZZh9ofmausD6Xud6vE5D/QG2+nhLYCiy9vImTodmMyQ1Hwe
         lOxGUhKQV3axuc1dgKFzn1A5up4zbNMVItnt8tJROYQcv2sruyNI4T2LoT/+cEDAAp/0
         vl9lkKr3pUJxq+32OuByfr0PjmGhtKLe2dMkcXonNEIJ7vTkdN+huSn6IELa8vNm7S/V
         9/3w==
X-Gm-Message-State: ACgBeo3dLJppgTSyraDVZ81viz1eDsib/+pQL9YGZ8P3fsISYykN7501
        E9DCVi35hJ3MNXKQmv3t+pc9gg==
X-Google-Smtp-Source: AA6agR7rEWbkWGj+UvH4yoJayaSPb2L/jopnuBErEgocxm4OTesByP4v+djzVepNefCHe+zuMv9qNA==
X-Received: by 2002:a17:90b:4b0c:b0:1f4:ffac:699a with SMTP id lx12-20020a17090b4b0c00b001f4ffac699amr19704898pjb.145.1661801402006;
        Mon, 29 Aug 2022 12:30:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g11-20020a17090a290b00b001fb23c28e9asm7104515pjd.2.2022.08.29.12.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 12:30:01 -0700 (PDT)
Date:   Mon, 29 Aug 2022 12:30:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Isabella Basso <isabbasso@riseup.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sander Vanheule <sander@svanheule.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH 1/2] testing/selftests: Add tests for the
 is_signed_type() macro
Message-ID: <202208291229.31D538EA@keescook>
References: <20220826162116.1050972-1-bvanassche@acm.org>
 <20220826162116.1050972-2-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826162116.1050972-2-bvanassche@acm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 09:21:15AM -0700, Bart Van Assche wrote:
> Although not documented, is_signed_type() must support the 'bool' and
> pointer types next to scalar and enumeration types. Add a selftest that
> verifies that this macro handles all supported types correctly.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Isabella Basso <isabbasso@riseup.net>
> Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Sander Vanheule <sander@svanheule.net>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
