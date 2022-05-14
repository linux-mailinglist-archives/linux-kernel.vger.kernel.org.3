Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3646E527444
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 23:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbiENVuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 17:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235351AbiENVuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 17:50:08 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CED12D1B
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:50:06 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ev18so385564pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wUsCnBDPbKVJv+EaQK22IFJZJAmFRuI1WgmUtyrig2Y=;
        b=nA8vOrKYtkCzRykOxnyfADoil/vhGzEfF70wnCDaNvJJi5xuvhhAkbtAFjQwLeFpJS
         1jap5Med/qc57M9VzJiXmB/EA4QArrQBeeuX93F+CfTCQiapplPgFCGvqmsenet4C1Fo
         u8B84Aa7txzzssJbvS8cZtMj8GyAW5qEFMceU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wUsCnBDPbKVJv+EaQK22IFJZJAmFRuI1WgmUtyrig2Y=;
        b=PXb185RCeLvSJM8W5imLU7BnyG262gdXl1hcp1YxJTUKhIrP1IR3Cbc7jptMjLiiNw
         eQUGwQ4DfQ+fagjZYCHiuylGWq3qhPzQfJnE9KOl8JoK6IzCrFTZAzrI5+eWKLhrTV6h
         WmaPOcXYj1SEGPbownZpz268GUH9mJY8f+69wPv7mORXNy0Xkk0h1zOcTPONJvDX+0fo
         OnlPAd7CN/JNHDEctc2yAwBOHFog1VUfsDV3/eF8COAFAmG1LFk7z49KDL5Iz3ZrZvxw
         Wb3mA/TGf0IfytOELu48KOy6bgIfsdAuNpv6sjN2zvPDbhGmMz3rajUIwxCCjZe1hcNC
         2qHA==
X-Gm-Message-State: AOAM533o+UzqdiAl+OttSET6+A+w+3BwGQ+3heM34zHjonArUjNXG/yd
        HLDIxp25ftlYfGOIHlQYMahkKBHCV8tLcw==
X-Google-Smtp-Source: ABdhPJw2E4A+XrCLXCnm95DuJx6yjrgtSzMtn/EEPgJ80ptCzVUybF5Z7bgAS+rJxfbXjJ5+NcMoMw==
X-Received: by 2002:a17:90b:3d90:b0:1df:70c:c65f with SMTP id pq16-20020a17090b3d9000b001df070cc65fmr5818574pjb.238.1652565005959;
        Sat, 14 May 2022 14:50:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j2-20020a056a00234200b0050dc76281a3sm4037702pfj.125.2022.05.14.14.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:50:05 -0700 (PDT)
Date:   Sat, 14 May 2022 14:50:05 -0700
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
Subject: Re: [RFC PATCH v2 08/21] psci: Fix the function type for
 psci_initcall_t
Message-ID: <202205141449.87738FDF@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-9-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-9-samitolvanen@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 01:21:46PM -0700, Sami Tolvanen wrote:
> Functions called through a psci_initcall_t pointer all have
> non-const arguments. Fix the type definition to avoid tripping
> indirect call checks with CFI_CLANG.
> 
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

This could land separately from this series, too, yes?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
