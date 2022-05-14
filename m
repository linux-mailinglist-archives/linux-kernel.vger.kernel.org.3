Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE64527438
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 23:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbiENVmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 17:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiENVmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 17:42:33 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2528C18370
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:42:32 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id i1so11092263plg.7
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AFfYNEwGAYrl2b1S77DLqgyE3imbGmmk2zhtDuc4ynI=;
        b=kl+nhaCiLE0304bc2Ws7byy+Zt93NbD2+JC8TxTzCPciiAnAK0kjyD+9A7Pqt/OSpz
         cwhEIIPnypOidev2krXJk0uSWujLyzMsR070AKg0DyjxHXCPDqBOwqC8CwPiOrV8gksg
         php3DyRROqICsm53xVIbeWQxek7z5RoSPRTBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AFfYNEwGAYrl2b1S77DLqgyE3imbGmmk2zhtDuc4ynI=;
        b=b0N5oW5EKCTbKgsvXwxL3VLgWDlZ5IzLhdI3AvqYOLnizAuhJXkemMPkPTGqj8Kw6J
         1c1J3uYX6tl7WZMJMJDYUZiCL4CZ86h664iFJibDtMs/tA3mfGYkbN0y/qkNUlRGl2po
         m5LhqF2fbhcOro92DB34EgCJgY/Xv4sNrk06fXLWuXRwGs5WtVPbhRmjg9QHCO+0k6pj
         Dvi7PMORzIoi804GflaNOVZ5zCeENngnLHOr4vccfdu6o1eHpE5Q+JmPp6NojojRRdfO
         mqmiu9hWfUIVusTcklnYwUfz2eWli9rzeaS03MqVGut5k2FxDDaTAk8XS79yNLT7vKds
         cOPA==
X-Gm-Message-State: AOAM532YwOjmbickLp3kn6jMOYcQoBMogp9E0EeI9XTS1JUWWtK0mVmJ
        Rz/5yEg+yCD1OVm1LCfVQpSCZw==
X-Google-Smtp-Source: ABdhPJxop1xGmlluyC4skdT7bVdphvZ9BLwlNF0GxA/dVjB1BI12ZPD2SnJuyX+8EvOjL5/QmefH+g==
X-Received: by 2002:a17:90b:3b46:b0:1dc:b314:52e6 with SMTP id ot6-20020a17090b3b4600b001dcb31452e6mr11561361pjb.134.1652564551616;
        Sat, 14 May 2022 14:42:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m4-20020a056a00080400b0050dc76281c4sm4094903pfk.158.2022.05.14.14.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:42:31 -0700 (PDT)
Date:   Sat, 14 May 2022 14:42:30 -0700
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
Subject: Re: [RFC PATCH v2 01/21] efi/libstub: Filter out CC_FLAGS_CFI
Message-ID: <202205141441.C3B7CF6@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-2-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-2-samitolvanen@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 01:21:39PM -0700, Sami Tolvanen wrote:
> Explicitly filter out CC_FLAGS_CFI in preparation for the flags being
> removed from CC_FLAGS_LTO.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Is it worth merging all the "existing" CC_FLAGS_LTO/CFI splits into a
single patch? Either way:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
