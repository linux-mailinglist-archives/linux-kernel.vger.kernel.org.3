Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D44C5ABAEB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 00:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiIBWpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 18:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiIBWpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 18:45:00 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1EE1902B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 15:44:38 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id z3-20020a17090abd8300b001fd803e34f1so6819274pjr.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 15:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=mIxY46m1QzJn3vOoV8Aurpr840TvHU3zLfjo/cbWqFk=;
        b=cYqFKD+l3LBaVj0Nglfk20jgUIjQ5VC+53Os9QTM/lf2Nb/TXPza+rYNtkGp0/fVFU
         B1TpRyVVK3e6ROFqWRySUfIATFBvaSxbSyCQgfXx4V2eANsSh1Gn4Z04EA83JT+HkNkG
         /ApMRwFeSuG0Yf+IZ6tm/VIIHcZKbAsYRJfZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=mIxY46m1QzJn3vOoV8Aurpr840TvHU3zLfjo/cbWqFk=;
        b=0mCdCLYBTj8CBtLfg/y+oKR+U3TBKcq9uyMpKgwX68PTaiXP7Y/rCRE6E0e2Dw4SkT
         52qjGfDTSt5Qnxa2jR9j71uvxYX5dOjiKlOjqgJLlvD8I+DljqfMIcv0rCa1anslb9VH
         MD48G6vcIIkqNlVq8EDIvF63Vnfokv3vlyW6w1VXuN7odgMNjCLAC4wKtJsAG6JwQ7zN
         BEYds1jlrbP4m9FMRYVGlVAAVLqs4hIRjASx+rSU/bsyaoUdzVi1WUar90bkCcU+6XUF
         qKM7P1jaV7DChkXdFwW2uk1OCU3oa/9kGW7A3I3W0db220Flh7waD4y75i0PiAiJaR9W
         E8ww==
X-Gm-Message-State: ACgBeo29iauJgYnYxoIAPCmYG4NBoF8av+kR5q22flyLY5waICOGk1Yn
        PbBs2kBflpwxEwgO8VcviJjPOw==
X-Google-Smtp-Source: AA6agR51nDiWxMdGZbsqX9QWjVEepoUFgYZiN4SZlJrqmTRnzNhGn8v/2CvIxf3CKgcYDwLWprczKA==
X-Received: by 2002:a17:90b:212:b0:1fd:e61b:866a with SMTP id fy18-20020a17090b021200b001fde61b866amr7000390pjb.141.1662158675307;
        Fri, 02 Sep 2022 15:44:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k12-20020aa79d0c000000b00537d7cc774bsm2323553pfp.139.2022.09.02.15.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 15:44:34 -0700 (PDT)
Date:   Fri, 2 Sep 2022 15:44:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        David Gow <davidgow@google.com>,
        Yury Norov <yury.norov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sander Vanheule <sander@svanheule.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Eric Dumazet <edumazet@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eric Biggers <ebiggers@google.com>,
        Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v2 3/3] fortify: Use SIZE_MAX instead of (size_t)-1
Message-ID: <202209021544.AEF73D202@keescook>
References: <20220902204351.2521805-1-keescook@chromium.org>
 <20220902204351.2521805-4-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902204351.2521805-4-keescook@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 01:43:51PM -0700, Kees Cook wrote:
> Clean up uses of "(size_t)-1" in favor of SIZE_MAX.
> 
> Cc: linux-hardening@vger.kernel.org
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/fortify-string.h | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)

*brown paper bag*

This needs:

#include <linux/limits.h>

I will fix it locally...

-- 
Kees Cook
