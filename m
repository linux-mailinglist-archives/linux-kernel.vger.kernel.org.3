Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0355D549C7C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345853AbiFMS7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346453AbiFMS6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:58:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF74345041;
        Mon, 13 Jun 2022 09:10:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4827B61517;
        Mon, 13 Jun 2022 16:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11614C34114;
        Mon, 13 Jun 2022 16:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655136645;
        bh=vDGoVyz7P2imouhGRqKcXTMbxxpUemh4hqy3lJLfAus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ib6hfQBqRr57ddK363WydGfoo7U25V23nCdwpOGrxXpCFAKVarA1lUuHhtoad7Vfw
         UGjftOcUsSs8wpTImEfj6ZAEfef0zddkF5GUJbNeVLJ/iJuiSFoH1Jmiv92Tq6MDq7
         sYXvY+EUZM8szo2wmhJyODYo+gMFwPtq8x1WEL/Qlrw02D0EMJ1aO7Iq4VBVyP4fX6
         9sM+xoK4oMrZirvXc0k6RrRuafW3ToEvPnXeTDjuU8wAKUCNabXph/SccJosxaB4oK
         mj5UGRxuLoznh9ZSbgVoBlod7K2djNvhwGzQxhpH58slofsKsMoUHrStQHb3zmQh2e
         hHcxfOagf9R3w==
Date:   Mon, 13 Jun 2022 09:10:43 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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
Subject: Re: [RFC PATCH v3 15/20] objtool: Disable CFI warnings
Message-ID: <20220613161043.4wiqservfyxeme4f@treble>
References: <20220610233513.1798771-1-samitolvanen@google.com>
 <20220610233513.1798771-16-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220610233513.1798771-16-samitolvanen@google.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 04:35:08PM -0700, Sami Tolvanen wrote:
> The __cfi_ preambles contain int3 padding and a mov instruction that
> embeds the KCFI type identifier in the following format:
> 
>   ; type preamble
>   __cfi_function:
>     int3
>     int3
>     mov <id>, %eax
>     int3
>     int3
>   function:
>     ...
> 
> While the preamble symbols are STT_FUNC and contain valid
> instructions, they are never executed and always fall through. Skip
> the warning for them.
> 
> .kcfi_traps sections point to CFI traps in text sections. Also skip
> the warning about them referencing !ENDBR instructions.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh
