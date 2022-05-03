Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D29518FE0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 23:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242708AbiECVTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 17:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiECVTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 17:19:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B2E018B38
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 14:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651612538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hnpvJKgmoLJ/4lWc6W+Hpzli45NnXrtfH2Tdb08YbUM=;
        b=KCNp6bH+q+GZBDc1w+xEQcb+uZ0BY4Lxg9blCKrh5m3HNiBTx8lkIwPtjjpmw/dZoaKU5n
        jnE0THqbnjoBEpunYE2h077AiFlNf7IFbSfS4MiDAdpPvsKT3KdOCGTUc5P7qzbwGG0TwX
        NePZ4v7sYa7h5gXxzqJZLz3jgV5W9as=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-161-MFalHZjpM5SrpUf_h2dYYg-1; Tue, 03 May 2022 17:15:14 -0400
X-MC-Unique: MFalHZjpM5SrpUf_h2dYYg-1
Received: by mail-qt1-f197.google.com with SMTP id s10-20020a05622a018a00b002f381134e2bso14493388qtw.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 14:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hnpvJKgmoLJ/4lWc6W+Hpzli45NnXrtfH2Tdb08YbUM=;
        b=BpO5fdRx8KRHWa2q2QHiXLFQ2nybDh1gCESmRUcSIqRg8hKn+vfcK+TqaW5okkb+Tj
         ivIQlrFUkwSqraivP+/rO851cSswSxbKYoTUp3AtTE/zz3BqaybtvS5Wuk8q4KlvGXxK
         pOUZ5rT9CnQWpKeemVPqIQpuOEaED8dCwIxuat1h1ENlkiDDeveHMx3fl9Q1yEOo71kr
         VwQoF3AeW0E4DIc9i46dPRq3yTAn1dtt+RoS1GkXp68A4uJfYQJxrDXHBsSpCJ5cb4QG
         CE+gGP3ZjDgP8JA5hO5r69tAOM9pzrFxhjuj2krqkbajYKqP1/OmsqJoDnkzPAIwcSAT
         +K9A==
X-Gm-Message-State: AOAM530B11RR+nn2HRB9eohiJfC/A+OD3VbubtzmUlArG9/CwfCyZqiK
        pcuK4fkFPBS/Nd9W1z9WhpqpCd2CB62TvXJw4PDvPlboshWkTHEaiPfC3rl3AJI7/30Zva5ulBV
        8d0QHGHmQSUOsHNyyqklM2bZi
X-Received: by 2002:a0c:e906:0:b0:456:540b:4e87 with SMTP id a6-20020a0ce906000000b00456540b4e87mr15154073qvo.47.1651612513434;
        Tue, 03 May 2022 14:15:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznEwDYiZt3M3L+feVN9IyY0T4XviUZYth7+RwC963l0L4/IWhivGjPRDQ9vKbQc1IsLd6gKQ==
X-Received: by 2002:a0c:e906:0:b0:456:540b:4e87 with SMTP id a6-20020a0ce906000000b00456540b4e87mr15154058qvo.47.1651612513167;
        Tue, 03 May 2022 14:15:13 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::a])
        by smtp.gmail.com with ESMTPSA id u3-20020a05620a120300b0069fc13ce227sm6390459qkj.88.2022.05.03.14.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 14:15:12 -0700 (PDT)
Date:   Tue, 3 May 2022 14:15:10 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: Fix SLS checks
Message-ID: <20220503211510.ytdv5l4l2zwjdwg7@treble>
References: <Ym0UWja2L40QbgEc@hirez.programming.kicks-ass.net>
 <20220502181547.fzz2yre2p4akph4s@treble>
 <YnA8Yw19AQV28w54@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YnA8Yw19AQV28w54@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 10:17:39PM +0200, Peter Zijlstra wrote:
> > +++ b/tools/objtool/check.c
> > @@ -3842,9 +3842,6 @@ static int validate_sls(struct objtool_file *file)
> >  	for_each_insn(file, insn) {
> >  		next_insn = next_insn_same_sec(file, insn);
> >  
> > -		if (insn->retpoline_safe)
> > -			continue;
> > -
> >  		switch (insn->type) {
> >  		case INSN_RETURN:
> >  			if (!next_insn || next_insn->type != INSN_TRAP) {
> 
> Yes, agreed. But perhaps with something like this on top?

Yup, I missed those...  Looks good.  Just one comment:

> +++ b/arch/x86/kernel/alternative.c
> @@ -452,6 +452,17 @@ static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
>  		return ret;
>  	i += ret;
>  
> +#ifdef CONFIG_SLS
> +	/*
> +	 * Ideally this would be unconditional, except in case of
> +	 * RETPOLINE_LFENCE we don't have sufficient space. Additionally,
> +	 * -mharden-sls=all should be extended to emit INT3 after
> +	 * direct jumps too, which will then cover that case.
> +	 */

I don't quite follow this 2nd sentence and how it's related here, since
this function doesn't actually deal with direct jumps.

Speaking of, I guess we'll eventually need to hack this SLS mess into
jump labels :-/

> +	if (i < insn->length)
> +		bytes[i++] = INT3_INSN_OPCODE;
> +#endif

-- 
Josh

