Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB591527465
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 23:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiENV6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 17:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbiENV6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 17:58:11 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42F340E62
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:58:08 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id j6so10712367pfe.13
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F4n+C6M9Aw1zMVfcPORGXMMVLEr2xX50zcVOAMomtNI=;
        b=ORcydA/uFIOR4odJFAV1XxY+PcGt2zebDpivlroBUEMd4PMs7KqLIIwFyrSrx1hQve
         IphjhRek3rFH0b0wKiFSafB46D14B6zsDaIUkgdWyUVQ4HxGNE+LGPeFItDUMmv7WDWQ
         l82UrDZKj39Vo1sdMxdDyg2ceu7AxyeuoD9GA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F4n+C6M9Aw1zMVfcPORGXMMVLEr2xX50zcVOAMomtNI=;
        b=NJnlUK6uRwGwaUKx22CpIRW9MkrIkoq088vVyI7vdlRmq01tsQeAeffFVBOPIfwYO1
         lQAwtAQkJu3yZFsOPAJ0oapWcvthZQqsvBcM8MAFnnOgmIIIjQjCM+Prt5FQuP4KV4TK
         yaOb3NlMVSH3jMYJsUxnOQR8mHknOEyhaP7jiQ9OTXW5NlB59L9UX33XCTF0+882FEf/
         7eXosI9KdubGYXB4C7P/WAVhoToMTG1lLoRcvue2jyRIfjdfxrnNh9hS4xFy6n8x1jOE
         vJDYT2KmTZ1qpDdMrN4riKPiF6JLzJxu1Pe+UAN0b7ioUQaJ5FX473GAbXQl0yhWf3r4
         Lb6A==
X-Gm-Message-State: AOAM531VDBMn1miuGqzrMpNYIKp/pMwmAmxqQG7a0UwBVmoOcp16P4ZS
        9VhgZM6XfvILNAqcno1AhzjFeQ==
X-Google-Smtp-Source: ABdhPJwOtndnmF6wotSc9dg7+c73fyG5+SBhQYVy5w8DsKeAwdpvOT6FhYjPgzOsGs5Q1NOcr1h40Q==
X-Received: by 2002:a63:190f:0:b0:3db:972b:46bb with SMTP id z15-20020a63190f000000b003db972b46bbmr7949134pgl.554.1652565488145;
        Sat, 14 May 2022 14:58:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o14-20020a655bce000000b003db8dd388afsm3840321pgr.10.2022.05.14.14.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:58:07 -0700 (PDT)
Date:   Sat, 14 May 2022 14:58:07 -0700
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
Subject: Re: [RFC PATCH v2 17/21] x86: Add types to indirectly called
 assembly functions
Message-ID: <202205141458.80233E7ED@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-18-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-18-samitolvanen@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 01:21:55PM -0700, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, assembly functions indirectly called from C code
> must be annotated with type identifiers to pass CFI checking.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
