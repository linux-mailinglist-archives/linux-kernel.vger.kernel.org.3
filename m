Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE700527464
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 23:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiENV6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 17:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236066AbiENV4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 17:56:53 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DB831527
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:56:52 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id l14so118813pjk.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t9B0ELg8h6PY+Vl2TDucjtXSCma3zXaus6HyZVuhPIE=;
        b=W1eubUSb/5LGT0PX48eWAAjFP3e+45qNMMJH5elMun/Sun50qtQzJU6DnSdp6Eg/+a
         sZUGxqEPzvzsqRpYUlnPpUwqsnDjU3f8F0t6paJwsZDv37wZBcBScTKMeytTqcg+gQ85
         fq0u+JX10bVU5Nl4qNuwnXTR65D2Gmk7mjZv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t9B0ELg8h6PY+Vl2TDucjtXSCma3zXaus6HyZVuhPIE=;
        b=ixIHzZwrb6nGRDaGrssDKPbSjaxpDQozqzqjHUF5QhmS6gPJtCT+9Pvg15YSxLQaFg
         T6UpMjMpUPkvWwv2RBKXE7n/IAtxHALDFNisVI6poRMxVOYeDMIRGzlQtidx0G8WrAcB
         yud4EvaLg3FT8whrEg3n4iJKxTRMivvaXeys9Bb7Ndf75NU3KrGq8quSDarXCVWWxetT
         7Ycip/S1DXSgInegfQzm5LW2fa3duLsHt5u/KNEQ/PBy6lA/iWN/H0B2bG7IQ5TzKdXO
         Fl/X+2ySmbI4ne1yqjo4ErKrnYu7Nuf3/h6BT8F1NgdbRoxp6qM6M4/WbmUzqVq8VcyW
         EOLQ==
X-Gm-Message-State: AOAM5320yf6btzqThOD3wkPM+nMQcvARVQzlzIGjY/qzO5k3v6zK3LrR
        RNZEKcQkuVKk5pj/nBPr3XzAbg==
X-Google-Smtp-Source: ABdhPJxYql9CKgnQAH/6nysRco+nTc9rw86pT4JEKLv1mVouDl0G3T6mTm3JsTqv8m6tl1+a5OAhsw==
X-Received: by 2002:a17:90b:4f81:b0:1dc:69a0:432b with SMTP id qe1-20020a17090b4f8100b001dc69a0432bmr22733023pjb.203.1652565411533;
        Sat, 14 May 2022 14:56:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s16-20020a63f050000000b003c14af5060fsm3886055pgj.39.2022.05.14.14.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:56:51 -0700 (PDT)
Date:   Sat, 14 May 2022 14:56:50 -0700
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
Subject: Re: [RFC PATCH v2 15/21] objtool: Don't warn about __cfi_ preambles
 falling through
Message-ID: <202205141456.72950C77B@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-16-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-16-samitolvanen@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 01:21:53PM -0700, Sami Tolvanen wrote:
> The __cfi_ preambles contain valid instructions, which embed KCFI
> type information in the following format:
> 
>   __cfi_function:
>     int3
>     int3
>     mov <id>, %eax
>     int3
>     int3
>   function:
>     ...
> 
> While the preambles are STT_FUNC and contain valid instructions,
> they are not executed and always fall through. Skip the warning for
> them.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
