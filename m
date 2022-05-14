Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE5A527467
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 23:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiENV6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 17:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbiENV6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 17:58:30 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CCA40E48
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:58:23 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id nk9-20020a17090b194900b001df2fcdc165so628792pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YHRIbwbYw+C29KUQZWgduS5aUkdozvIZ+erhj6VO6FY=;
        b=GKZwyVRiKzX72oR6iRkHNGBB4Yxe4zgbdG2bd1Amyx25B8PRAkSSWxH34c2Z8H4Nnm
         1vTmWCO/WBQS1TIQlB3jNMp8kDrLZ6n4ahAh5U+uttxpOOjQf2Tn//WLGsxXWkypgUs4
         tC2mjiqHKHosECDuo/Grwg0fKMiL1EvNVf1Io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YHRIbwbYw+C29KUQZWgduS5aUkdozvIZ+erhj6VO6FY=;
        b=bZRf38NiLXXQo3SwVMUJCakTT8JEKeut4qgzu4ZwIQ3RM1KHNhmzYIenxHUiI6IEm0
         C2aPaiAvrWLGqc1AqcdSHq8vByS9tfyQzIofBMQSRhZT5twqxbZBXof2kuwPMkoPNsxd
         B05AbwOuRS1FIzJMMnCCz3A+w+AJxD1HvS8+G0DZs+90AncvPviJvF7Qe8C/njO0NU4R
         SD34waqHMshWq+T/w/vv9NsfO4xO5D9TeGRvWtE0IUciJ3A35FLQofudNaDknMjxeFqb
         nWVGXDZ+nR8cZiVpfphrmjUAOTGI1eHKaL6SljWal0CE38iDdS2SoyXNxj8nNFFj31Sf
         CuhQ==
X-Gm-Message-State: AOAM533aq7ERSg629hfP8Uk9qBgt2RkIQCeem2Xi83Jv5zopaIKMVDFE
        T42OAzexncAwS042mnN0bIu9GA==
X-Google-Smtp-Source: ABdhPJwQi9fDcAabhWlIu7XmH1XILDhZjsGUll409I75HQ6fQoXg6nsR8lupRx6Pog8YHNzHVYWXow==
X-Received: by 2002:a17:90a:db51:b0:1dc:9d7e:1e11 with SMTP id u17-20020a17090adb5100b001dc9d7e1e11mr23330312pjx.129.1652565502681;
        Sat, 14 May 2022 14:58:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i1-20020a6561a1000000b003c14af5063fsm3889773pgv.87.2022.05.14.14.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:58:22 -0700 (PDT)
Date:   Sat, 14 May 2022 14:58:21 -0700
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
Subject: Re: [RFC PATCH v2 18/21] x86/purgatory: Disable CFI
Message-ID: <202205141458.1101A071@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-19-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-19-samitolvanen@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 01:21:56PM -0700, Sami Tolvanen wrote:
> Disable CONFIG_CFI_CLANG for the stand-alone purgatory.ro.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
