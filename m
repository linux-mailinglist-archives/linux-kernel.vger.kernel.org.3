Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D46527474
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 00:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbiENWDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 18:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiENWDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 18:03:49 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9F3193DE
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 15:03:48 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id x8so7273315pgr.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 15:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Cv5IfzzB62q+sLnNCDbD30QBd73u3J6+zboNpO/j4RY=;
        b=VETNqwy6PZmcQN3F3QHSWlt30W22U3LCrLRvKSeesIcM9qLdix4sdzIOt/G8doxqOb
         OcoqV/LPIMHwGJxM1kBkp24tJ8lnxNfHbqvA5/XfJrtBOFx283bTamig0x1zX3ftp4Ez
         dBx+vI7MyUSpc3Sh0MhnbfuW2COnE4U2FEV4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cv5IfzzB62q+sLnNCDbD30QBd73u3J6+zboNpO/j4RY=;
        b=EgRY8g+K2GFMBhDa29uo9u853mEK2msuA/c4b7Tn9JgUN9UHIoAkegXoSck0hCGBlC
         k0gSKJW4KuHVMdeU4p4pAL1nqkK+gwb/rDG430ORYm+A+XAbLL+Xc6+77Ym9uDUoJs1t
         bVXusC2GBnJdJ8NU65ZuT894CkbbPsoUAsWZvAwI9QKK+PLSVuymJxvZ+6sR7JRSvXMo
         ZIby3nu85xjstzX6kHp6TLqPl/zpEgs/QkHM2z6wfAM4ItpjOaQbBKjvF+gAWS8vYT1b
         VGusiGXjKcDF7UgGrsPzjStILVwO133jc8RUBFDcOgCEfs5yga+XgeKPMHoXzR7jLHe+
         L0Ig==
X-Gm-Message-State: AOAM5304py8H+gD3inTaAImm+PpDWsYhYusQBuTuPrHEbHqi1ICI9p/b
        O81vR0G5uauS6KKCJlF1/2hGwQ==
X-Google-Smtp-Source: ABdhPJw20gLVrovNCtH9oPgnmWWI4khPHrgIkrbw39eJj00oseNyUiPYd0WVdGDzgNKQyhd7WsWu9A==
X-Received: by 2002:a63:190f:0:b0:3db:972b:46bb with SMTP id z15-20020a63190f000000b003db972b46bbmr7963890pgl.554.1652565828255;
        Sat, 14 May 2022 15:03:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ip14-20020a17090b314e00b001d81a30c437sm3672870pjb.50.2022.05.14.15.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 15:03:48 -0700 (PDT)
Date:   Sat, 14 May 2022 15:03:47 -0700
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
Subject: Re: [RFC PATCH v2 21/21] init: Drop __nocfi from __init
Message-ID: <202205141503.3D87637B85@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-22-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-22-samitolvanen@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 01:21:59PM -0700, Sami Tolvanen wrote:
> It's no longer necessary to disable CFI checking for all __init
> functions. Drop the __nocfi attribute.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Maybe move this up after patch 11 (the arm64-wide __nocfi removal)?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
