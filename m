Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9709852744C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 23:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbiENVyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 17:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbiENVyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 17:54:20 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005732C665
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:54:18 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c11so11082076plg.13
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FykryA/PR0f3p83HjJunId+gp3pqJzOIiL8j+Agnd3A=;
        b=P0ytf3VHbbsXrhqae2Zd5Ll2MuTMZ+sX3YHcECJ6uHTAKjjZna4wFiZzv5hRwMvEBn
         MxFkALqYT4Cep0hR0dt+cnddTbsgr75zHgcZlKpFQ9CIHgn+CBZ3EJ9Igtchk6wXVYPF
         Y/kmkar9pi2d7USkoTKnPI5F2B7oJSyz12a68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FykryA/PR0f3p83HjJunId+gp3pqJzOIiL8j+Agnd3A=;
        b=qU880zRUqrDmA9nU4tYtYrUGkVoQ85pRb8yYdhFSchfeI7K4zIbzNf/H8C2UdwUqVX
         3VkhSUvybloCpAA4R6LuVDqYXVoiDWKqbOtz149OmFeRCGmhNy6xV2kpIlUz3pwQYZYi
         LprttxNzuGdwU+oByZZZxuY0Pam/Q4kkPmvPxbg5bYjdRCjcG2jlEaJ7f2dIIlIVE80m
         OQ2JqlBdfY/PyHW1NqIGiLRiXsUVaEYSsQYePZ+DOJZhvFeoPzidt+i6bvgcztdQSCJf
         WqyOnl1yQibZK867VRBmhop2qJOuW4huKLaQQr6vIqBvu45bg9urcp2YZGvglps9YJpH
         FqIw==
X-Gm-Message-State: AOAM530s6GPPffCImZ/nejKFQyVIkspJ1kdKNUZUaIguL52JjBBrg3sG
        cCuXmA1C6W4k5FYbKb5l5131qQ==
X-Google-Smtp-Source: ABdhPJzoC13YHvqAZkelFuizL5j4/KrYwDhjo/xw/hl3PuFmx/isLndYV81BpaWdnzBIXYZT4z2fTA==
X-Received: by 2002:a17:902:d507:b0:15e:afc4:85b5 with SMTP id b7-20020a170902d50700b0015eafc485b5mr10971844plg.52.1652565258544;
        Sat, 14 May 2022 14:54:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id fv7-20020a17090b0e8700b001cd4989fecfsm5694602pjb.27.2022.05.14.14.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:54:18 -0700 (PDT)
Date:   Sat, 14 May 2022 14:54:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH v2 12/21] treewide: Drop function_nocfi
Message-ID: <202205141454.9EBF450@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-13-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-13-samitolvanen@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 01:21:50PM -0700, Sami Tolvanen wrote:
> With -fsanitize=kcfi, we no longer need function_nocfi() as
> the compiler won't change function references to point to a
> jump table. Remove all implementations and uses of the macro.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
