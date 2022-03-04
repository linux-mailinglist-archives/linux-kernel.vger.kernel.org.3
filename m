Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACEB4CDC61
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241206AbiCDS2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241708AbiCDS1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:27:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6FBB1D3061
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 10:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646418425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ke0tL+cnsXFsFYst2o63sX0jhckvILk3Fcmf7+4VOw0=;
        b=QvGrTOz3pgn86MEY9ImhDPi34yQV0QYQbmN9uf7Lw/91wWPwp+i/fEblhBN6zcTp3eWtZu
        bSXU3cxEiJ5fNj0DocvVkCDWojWJezmceMghRQqMCW9rD8cOWJzZ8jEXLpTOKm7P4oLBLi
        8EqNUSD/KsEO4k0qjp3rSuWg2CM37GI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-f0l6havZN1GITMRcSiLMAg-1; Fri, 04 Mar 2022 13:27:04 -0500
X-MC-Unique: f0l6havZN1GITMRcSiLMAg-1
Received: by mail-qv1-f69.google.com with SMTP id z7-20020ad44147000000b004354c61c2a1so2240224qvp.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 10:27:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ke0tL+cnsXFsFYst2o63sX0jhckvILk3Fcmf7+4VOw0=;
        b=HQRhzAExX4HQTguP6+0cfgtSm7ZzkoVO9FKNSjqfW8pxQe3imgpwvdvJGA5SNnXpZ9
         3agvqYsQpiIL2OykSwng470Jvy+cl6FS2qZVJISCusdcIJ+nrGHx9JZRccDKGZtAfmqM
         0UnDGsAh0nLnY3F9vTXIiYFXlKpiX7/7UzJJTgafPm1Qtx306ZJWN1pW2x4dArRA38FT
         +kjjgFhk9u5fPNUB28WP6wQBz95komB6qXYGf4TymF3ugqmKxCOVdV8v3NG74dTx8c6p
         0rf4BUgiJLAUjEP+2XXK4kMBhxJj0Y13b1tSd2BwVCKBonQ0dmM5WG0rZgkTnq0x51cB
         LXyw==
X-Gm-Message-State: AOAM530/FicKSDUuyhTOSaqcoX3kWDqJ4XosxogecpDqyxyFb1s8K/nm
        Y5NxSZzaR3uxSgsY0ceAs+E5MLJgAaHIA9ovjIdVJXRgbo+KwLF0+apslpK0oVFSWFliWoo35jD
        hYI7X4jYsoZqlxep1MBujDeK4
X-Received: by 2002:a0c:d845:0:b0:42c:33e4:e491 with SMTP id i5-20020a0cd845000000b0042c33e4e491mr28898013qvj.100.1646418424125;
        Fri, 04 Mar 2022 10:27:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwIze88pTtD00h9ELlbGFT6k8ut+j6h9zUqfA0II+nt+50ALxozG87waOMRxDIkTRY+OnYkVA==
X-Received: by 2002:a0c:d845:0:b0:42c:33e4:e491 with SMTP id i5-20020a0cd845000000b0042c33e4e491mr28897986qvj.100.1646418423819;
        Fri, 04 Mar 2022 10:27:03 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id w145-20020a376297000000b00648c6da33d9sm2782136qkb.63.2022.03.04.10.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 10:27:03 -0800 (PST)
Date:   Fri, 4 Mar 2022 10:27:00 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v3 37/39] objtool: Optionally WARN about unused
 ANNOTATE_NOENDBR
Message-ID: <20220304182700.zhqrd6w6m7xxtglm@treble>
References: <20220303112321.422525803@infradead.org>
 <20220303112827.210703687@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220303112827.210703687@infradead.org>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 12:23:58PM +0100, Peter Zijlstra wrote:
>  bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
>       lto, vmlinux, mcount, noinstr, backup, sls, dryrun,
> -     ibt;
> +     ibt, ibt_warn;
>  
>  static const char * const check_usage[] = {
>  	"objtool check [<options>] file.o",
> @@ -49,6 +49,7 @@ const struct option check_options[] = {
>  	OPT_BOOLEAN('S', "sls", &sls, "validate straight-line-speculation"),
>  	OPT_BOOLEAN(0, "dry-run", &dryrun, "don't write the modifications"),
>  	OPT_BOOLEAN(0, "ibt", &ibt, "validate ENDBR placement"),
> +	OPT_BOOLEAN(0, "ibt-warn", &ibt_warn, "warn about unused ANNOTATE_ENDBR"),

"ibt-warn" doesn't really describe it.  Most options warn.

"ibt-unused-annotation"?

>  	OPT_END(),
>  };
>  
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -1814,6 +1814,19 @@ static void set_func_state(struct cfi_st
>  	state->stack_size = initial_func_cfi.cfa.offset;
>  }
>  
> +static bool insn_is_endbr(struct instruction *insn)
> +{
> +	if (insn->type == INSN_ENDBR)
> +		return true;
> +
> +	if (insn->noendbr) {
> +		insn->noendbr_hit = 1;
> +		return true;
> +	}
> +
> +	return false;
> +}

Ew...

> @@ -3695,6 +3707,31 @@ static int validate_ibt(struct objtool_f
>  		}
>  	}
>  
> +	if (ibt_warn) {
> +		struct symbol *hypercall_page = find_symbol_by_name(file->elf, "hypercall_page");
> +		struct instruction *insn;
> +
> +		for_each_insn(file, insn) {
> +			if (!insn->noendbr || insn->noendbr_hit)
> +				continue;
> +
> +			if (hypercall_page) {
> +				/*
> +				 * The Xen hypercall page contains many
> +				 * hypercalls (and unused slots) that are never
> +				 * indirectly called. Still every slot has an
> +				 * annotation. Suppress complaints.
> +				 */
> +				if (insn->sec == hypercall_page->sec &&
> +				    insn->offset >= hypercall_page->offset &&
> +				    insn->offset <  hypercall_page->offset + hypercall_page->len)
> +					continue;
> +			}
> +
> +			WARN_FUNC("unused ANNOTATE_NOENDBR", insn->sec, insn->offset);
> +		}
> +	}

Ewww... :-/

I can see how this option was useful for development.  But I'm never
going to use it.  Are you?  I'd much rather just drop it.

-- 
Josh

