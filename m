Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF9C586C07
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 15:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbiHANcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 09:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiHANcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:32:17 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262ED3DBF5;
        Mon,  1 Aug 2022 06:32:16 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id f22so2741034edc.7;
        Mon, 01 Aug 2022 06:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZxYrCxuzFrawIOausSiSl14ADX47XgPrIEvhY9YR8N0=;
        b=FG40CLQaCqWW5WmzTFFQSiRNqPlRfCjRKug0ubumNYq7OCe2hzZ6dcawenMB3OH75x
         g+YgcH8BZajKnjbfx7vEKh42aZsK01e+lUq7FUDZdUCAV0vDrfCggkhK79DJjk0N7UPt
         CKPDp24FH9GgQ78TpOUPvHcK52VWswx5Wp5368LiBPBn/VaghUjpZCLkjY/w4sKsf6Bg
         3xVRw4NnoPia1JPPkdr3NcN/RzpHMWRJxeNya71bE5XjASABarYpeM/AgU069YUaSJW9
         +6Eb0VqjCl74TEGIzufXEpXGvEPotWAp3lnZC1w6o5b1NiC4k9yVZjBMnIleBfaaXQo6
         DKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ZxYrCxuzFrawIOausSiSl14ADX47XgPrIEvhY9YR8N0=;
        b=dAKdDcPL/hRXS02ywuQPBd6Hjpz4MgdbzMmML7fWx5hTB7vEGWytCkWzzEkUjQcj1P
         BTdAmlDUzR7fVa0RS+HK0o+XPRXsA6yhDLeZxxblTOFgQZNe35QUxs2FFgTGgcyVtg8y
         +auu+xbYf0oDtakYYLmnPs+inPbS/y5HH/Dz/SHMo7tvGWZ85TSpyYHAsUldCDdtfsxi
         zEyZumhslsbq/t+QHGVqoYqy/aKS0WAFUfh/e8UOxLHm4r6B/oO7udqzK24D388DXdNt
         3U9Vu7aFDfcgu5vTrJiG5ynTfWQuy+/1cdAJyB33Iix3vtxoSwiHBpQjte5oddXf/dnn
         y85Q==
X-Gm-Message-State: AJIora+h1+eZYxkFtw8QLFVC5PZ4rUujNyGvNrzRFEJJ8MnYnEVBxSGJ
        446NFcTpr8FKZW+kjXa0rY8=
X-Google-Smtp-Source: AGRyM1uoV5kr9uYFLy6H0i7TZWPOAEwEtFNpJ2kSfifyEQfER6jE35YeezQSQJn7eR0cvzR5blWSDg==
X-Received: by 2002:a05:6402:1e88:b0:43c:e8d4:bf27 with SMTP id f8-20020a0564021e8800b0043ce8d4bf27mr15855237edf.401.1659360734629;
        Mon, 01 Aug 2022 06:32:14 -0700 (PDT)
Received: from gmail.com (84-236-113-167.pool.digikabel.hu. [84.236.113.167])
        by smtp.gmail.com with ESMTPSA id w7-20020aa7d287000000b0043bc19efc15sm6756395edq.28.2022.08.01.06.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 06:32:14 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 1 Aug 2022 15:32:12 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Peter Oskolkov <posk@posk.io>
Subject: Re: [PATCH 2/2] rseq: Kill process when unknown flags are
 encountered in ABI structures
Message-ID: <YufV3PmAOfo1Gt7g@gmail.com>
References: <20220622194617.1155957-1-mathieu.desnoyers@efficios.com>
 <20220622194617.1155957-2-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622194617.1155957-2-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> rseq_abi()->flags and rseq_abi()->rseq_cs->flags 29 upper bits are
> currently unused.
> 
> The current behavior when those bits are set is to ignore them. This is
> not an ideal behavior, because when future features will start using
> those flags, if user-space fails to correctly validate that the kernel
> indeed supports those flags (e.g. with a new sys_rseq flags bit) before
> using them, it may incorrectly assume that the kernel will handle those
> flags way when in fact those will be silently ignored on older kernels.
> 
> Validating that unused flags bits are cleared will allow a smoother
> transition when those flags will start to be used by allowing
> applications to fail early, and obviously, when they attempt to use the
> new flags on an older kernel that does not support them.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  kernel/rseq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index 81d7dc80787b..bda8175f8f99 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -176,7 +176,7 @@ static int rseq_need_restart(struct task_struct *t, u32 cs_flags)
>  	u32 flags, event_mask;
>  	int ret;
>  
> -	if (WARN_ON_ONCE(cs_flags & RSEQ_CS_NO_RESTART_FLAGS))
> +	if (WARN_ON_ONCE(cs_flags & RSEQ_CS_NO_RESTART_FLAGS) || cs_flags)
>  		return -EINVAL;
>  
>  	/* Get thread flags. */
> @@ -184,7 +184,7 @@ static int rseq_need_restart(struct task_struct *t, u32 cs_flags)
>  	if (ret)
>  		return ret;
>  
> -	if (WARN_ON_ONCE(flags & RSEQ_CS_NO_RESTART_FLAGS))
> +	if (WARN_ON_ONCE(flags & RSEQ_CS_NO_RESTART_FLAGS) || flags)
>  		return -EINVAL;

Just to make it clear: no existing libraries/tooling out there have learned 
to rely on the old ABI that ignored unset flags, right? Only then is this 
patch ABI-safe.

Thanks,

	Ingo
