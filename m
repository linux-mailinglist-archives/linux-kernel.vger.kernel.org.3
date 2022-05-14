Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D088B52744B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 23:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbiENVyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 17:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbiENVyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 17:54:04 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E832C133
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:54:03 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id p12so10793942pfn.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gDVhI2zku2qZKvaq49DPvnyS72Uf7FU9KhCkFrjajU8=;
        b=S1011jnyYAkqBEEDMxT9syvIhh2zSvV8Zkh+bBVbAiJUkWvxnx5G4QQmkCufpwGOcQ
         /VZM22i7sKGtdqrpwsp9Ytbo3kro9y+f2Y0MIR5yMMRIu0uPZUtRoPywyBZYtRbMJDcu
         uQQpImYc+cjK3PovHb0YXltkeyKprRSzXdKAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gDVhI2zku2qZKvaq49DPvnyS72Uf7FU9KhCkFrjajU8=;
        b=Tsn1FNIQ8NGIQeSQ2iHPfvPCwNYsWbyEpqrS6LvfT3MlrHpA2hd2hoTJh+7z4bk5ea
         6XhAlGIPd7KXUNIpsMapfx23Lqves2xheU07iGWpIm9f6xVT2raTUx/w1isaHHnjlgfd
         wEuw0KicZ6nSKTOhuCwOevWIXp1N2DY8tXJ1R5lPN2VdTjAhn2jzXiIPnirHY2Zxad9K
         i/fqyFoSwKAfUkso8VBqX4r7x6ZEfugEFUvGj6a272mVkStBvYUQle0W4goc1ynK8gA2
         BnEI0upoScNLxtm6eia71mg8n+yHJteAtuadzO+XnqlZESyGoPLkAKAMAVM+RnOi7JtM
         ew7A==
X-Gm-Message-State: AOAM533nSgeTcNaLI2d0RDA9kSFfVInv7SLSBmxIhNS0IYBDsRoLJhoc
        SAmjgewH+gPpR5W9/Avf5Opgbg==
X-Google-Smtp-Source: ABdhPJy8U7RbEud+2dU/6vQphGcmECzPHMeX+WfFdiNBbxRS9BySOYWWpcCZo0DnGxsttLazJB4nAg==
X-Received: by 2002:a63:f046:0:b0:3c6:a37b:1613 with SMTP id s6-20020a63f046000000b003c6a37b1613mr9503013pgj.168.1652565242585;
        Sat, 14 May 2022 14:54:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b7-20020a170903228700b0015e8d4eb1f8sm4186116plh.66.2022.05.14.14.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:54:02 -0700 (PDT)
Date:   Sat, 14 May 2022 14:54:01 -0700
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
Subject: Re: [RFC PATCH v2 11/21] arm64: Drop unneeded __nocfi attributes
Message-ID: <202205141453.44171359E3@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-12-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-12-samitolvanen@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 01:21:49PM -0700, Sami Tolvanen wrote:
> With -fsanitize=kcfi, CONFIG_CFI_CLANG no longer has issues
> with address space confusion in functions that switch to linear
> mapping. Now that the indirectly called assembly functions have
> type annotations, drop the __nocfi attributes.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

It looks like there are still other cases that continue to require
__nocfi, yes? It looks like after this series, it's still BPF?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
