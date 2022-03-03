Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30A84CBBC3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 11:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbiCCKye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 05:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiCCKyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 05:54:32 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FACD177D30
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 02:53:46 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 280DC1F37B;
        Thu,  3 Mar 2022 10:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646304825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1fQZTMimSCOOyhM5uu37na2oMa/18fIoZEJlOGor0Dc=;
        b=EaKUBwIE5rN3e4I89XWfER9PCH/kgIfZQt84/C0mUoEgtv4Ym6oyWm0LheMy+QAu8x5ZcI
        cDrL9l4vPPL9XtOt5VEQr9ltXfvTpi0ezJL0bgQdCTxd/ABdv+709AdcHPCNef4TnJT4kN
        k5Sh47pDMYCZ72IdwnhdbkuU2vY5v2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646304825;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1fQZTMimSCOOyhM5uu37na2oMa/18fIoZEJlOGor0Dc=;
        b=Vs2yjuRjKTHacQLzsw8JqSHimyds3/eAM5T/sroVknPLrIZNZoHlIA/uVL/YWrMLwvBrsN
        dpkleBcO8r9iHPAg==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C3235A3B81;
        Thu,  3 Mar 2022 10:53:44 +0000 (UTC)
Date:   Thu, 3 Mar 2022 11:53:44 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com,
        rostedt@goodmis.org, mhiramat@kernel.org,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 33/39] objtool: Add IBT/ENDBR decoding
In-Reply-To: <20220224151323.959862564@infradead.org>
Message-ID: <alpine.LSU.2.21.2203031138040.704@pobox.suse.cz>
References: <20220224145138.952963315@infradead.org> <20220224151323.959862564@infradead.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 24 Feb 2022, Peter Zijlstra wrote:

> Decode ENDBR instructions and WARN about NOTRACK prefixes.

I guess it has been already mentioned somewhere, but could you explain 
NOTRACK prefix here, please? If I understand it right, it disables IBT for 
the indirect branch instruction meaning that its target does not have to 
start with ENDBR? 

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  tools/objtool/arch/x86/decode.c      |   34 +++++++++++++++++++++++++++++-----
>  tools/objtool/include/objtool/arch.h |    1 +
>  2 files changed, 30 insertions(+), 5 deletions(-)
> 
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -103,6 +103,18 @@ unsigned long arch_jump_destination(stru
>  #define rm_is_mem(reg)	(mod_is_mem() && !is_RIP() && rm_is(reg))
>  #define rm_is_reg(reg)	(mod_is_reg() && modrm_rm == (reg))
>  
> +static bool has_notrack_prefix(struct insn *insn)
> +{
> +	int i;
> +
> +	for (i = 0; i < insn->prefixes.nbytes; i++) {
> +		if (insn->prefixes.bytes[i] == 0x3e)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +

...

> @@ -636,20 +656,24 @@ int arch_decode_instruction(struct objto
>  		break;
>  
>  	case 0xff:
> -		if (modrm_reg == 2 || modrm_reg == 3)
> +		if (modrm_reg == 2 || modrm_reg == 3) {
>  
>  			*type = INSN_CALL_DYNAMIC;
> +			if (has_notrack_prefix(&insn))
> +				WARN("notrack prefix found at %s:0x%lx", sec->name, offset);
>  
> -		else if (modrm_reg == 4)
> +		} else if (modrm_reg == 4) {
>  
>  			*type = INSN_JUMP_DYNAMIC;
> +			if (has_notrack_prefix(&insn))
> +				WARN("notrack prefix found at %s:0x%lx", sec->name, offset);

And we want to warn about it here so that we can have it all in the kernel 
control?

Miroslav
