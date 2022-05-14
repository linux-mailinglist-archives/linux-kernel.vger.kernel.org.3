Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD24B527445
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 23:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbiENVux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 17:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235365AbiENVur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 17:50:47 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF1D13CD6
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:50:46 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y41so10713356pfw.12
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/+6DXPA/etQO+MROO0HlzYfznWa6yuzqrt1lFu+IZCU=;
        b=X46GUAIQhLZgbIbW3ALwg7mUAi9aD9nKapR3TAoFkfjTlqeeHuVMk1gIo1XQ0yhsdL
         N0hnyu4RWWhHM3wtF0iEMRxtXOU5NkFees7jAbHlv51A9j241elTXlQkZcd3ZBf54JuI
         QmQxGgU2qsxD6sDjGZsdeqw6FNs+bdOxLbp9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/+6DXPA/etQO+MROO0HlzYfznWa6yuzqrt1lFu+IZCU=;
        b=lr3WVAwb8wEj45a5OnZA2MwPOKZ7t6g+zdbY4797BuTpchYr48HCKzkilfBfUtXSVS
         mWXaYU690H1y5br3czk1c8U6cdx5JqKJUAvO1Izz9JpSwcotYbQnYuyFhNkYJ3pipjry
         gYyJLzrmvCJhR+nQRzjnWwvxGZ3tw5707xSV7PvEQ8xmNs66HhpPuPZ4OBjijpPpE93d
         uNcUR8JbVZSmyaspddGJt2PpXhRqvG6j1q+rsWqMoH4GxlcuoKTOoo/AMrmFGFx8ek1z
         uEahmEFuJlOMmQukYDKk/vStRDYQbeZkX9ds6qA/Y5W0W2Rj1Vjvf8Sr7xqxHLWTp0hY
         hbcg==
X-Gm-Message-State: AOAM533TsxvKDlKXfh5LVjkYFXdICVMlOr6YZbph+3Xv8ldNn9I/TFWi
        3ZIvuCRORjMiNtc+rYBsHIUrwA==
X-Google-Smtp-Source: ABdhPJyKT2rYy5VGyrBn24YvTCGmr7LDXKmlZ9vWWFE2j7T4CYJuXCvTnF4P3WJsCwUHfcUj11JmLg==
X-Received: by 2002:a05:6a00:1709:b0:505:fa47:b611 with SMTP id h9-20020a056a00170900b00505fa47b611mr6064948pfc.65.1652565045739;
        Sat, 14 May 2022 14:50:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j13-20020a170902c3cd00b0015ea95948ebsm4116861plj.134.2022.05.14.14.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:50:45 -0700 (PDT)
Date:   Sat, 14 May 2022 14:50:44 -0700
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
Subject: Re: [RFC PATCH v2 09/21] arm64: Add types to indirect called
 assembly functions
Message-ID: <202205141450.C5287B6@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-10-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-10-samitolvanen@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 01:21:47PM -0700, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, assembly functions indirectly called from C
> code must be annotated with type identifiers to pass CFI checking. Use
> SYM_TYPED_FUNC_START for indirectly called functions.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Sort of related to my question about SYM_TYPED_FUNC_START itself, how
were these cases identified?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
