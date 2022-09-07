Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9237A5AFD92
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiIGHbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiIGHa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:30:27 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17F46EF14;
        Wed,  7 Sep 2022 00:30:23 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id h1so8212792wmd.3;
        Wed, 07 Sep 2022 00:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=ySTqzK77epAEdUaxdr9SqQHp6loTM9BjTxqnQisnV4Y=;
        b=gtoLz2nrwbRfB9uwytDWgKXJ4VL4ukMunKy0Shm7qJek9eJFe42Sb/tvFghI4n+WH3
         QibK1n0nmPYH4qVc3s0wocnybNPg84Trnt/YJQBlkY95sE3oPZ0ciEtYNOa7N4ZTI+0R
         Jx9LjQU7Y/NIwxBWG0gT2qXmROxtMioeON/cR9bWwjiqK4nv6vzmy6uxzVaRaXAyOk7n
         wOBd9ZQy9vmpMh1i7udNGoF9adsnImHFLAu7q+7fnB4hsRMlcwzwsRuK1iqGqdQOaFXH
         peAVH6h5StBP/Nt0Zqxvo309L3BQUtkXad3jn/G2+ywQe9NpbJ+1QS5GZ+ergNy5c9es
         fRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ySTqzK77epAEdUaxdr9SqQHp6loTM9BjTxqnQisnV4Y=;
        b=Dk1jcwFTyMwjwv6vcUio0bugId3wFfx/zrmWciVpMGpozlRbs4kM1++qW0eWYI4Vq5
         GLfClFxiyD+KuF7lfLRC7JUrtFN5fy40lSrS8w1hiSCQt4MeBJEJ7YbNzE4xHIdwh6cD
         Bl7MblA9c8gijudP6l0bKPeLIMgq050hjpZDfo3btE/eMGTQkLwWfEXp1/LKtCTK5l90
         YOocoh+Ug6fwpPiQQiNTg0TxHLEVDw4PApykfSQ0ZQb8mhCGm7TxcvgbFDkJvUKzOCXM
         fyN7J7tP+l78yn0KGkYZv1l0BrF0UFQ/1GwYASAcF4M31HXuemleWpcM1qN9P03WlQR8
         xN/w==
X-Gm-Message-State: ACgBeo3xUosGNjmAGuDj3tkXO2BA/d4OsrhJASXD4i8A/1jgh/WgPPqL
        1wmYSDoxn/cydd2cwBHoDKI=
X-Google-Smtp-Source: AA6agR6QXSOqiTjyQTtNJzk4IEUWfEuAweEZzgWXQKuhdhlaNgxNa5neINPqd9VT6tcMQnmmG9NozQ==
X-Received: by 2002:a05:600c:512a:b0:3a8:42e4:dfe7 with SMTP id o42-20020a05600c512a00b003a842e4dfe7mr16191439wms.193.1662535821967;
        Wed, 07 Sep 2022 00:30:21 -0700 (PDT)
Received: from gmail.com (1F2EF41B.nat.pool.telekom.hu. [31.46.244.27])
        by smtp.gmail.com with ESMTPSA id z14-20020a5d4c8e000000b0021e4829d359sm16071633wrs.39.2022.09.07.00.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 00:30:20 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 7 Sep 2022 09:30:18 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 6/6] freezer,sched: Rewrite core freezer logic
Message-ID: <YxhIim6NhyQkxOqA@gmail.com>
References: <20220822111816.760285417@infradead.org>
 <20220822114649.055452969@infradead.org>
 <YxR5Yauhd90WN/AY@gmail.com>
 <YxctoffFFPXONESt@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxctoffFFPXONESt@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Sun, Sep 04, 2022 at 12:09:37PM +0200, Ingo Molnar wrote:
> 
> > BTW., we should probably mark/document all PF_ holes with a PF__RESERVED 
> > kind of scheme? Something simple, like:
> > 
> >    #define PF_NPROC_EXCEEDED	0x00001000	/* set_user() noticed that RLIMIT_NPROC was exceeded */
> >    #define PF_USED_MATH		0x00002000	/* If unset the fpu must be initialized before use */
> >  + #define PF__RESERVED_04000	0x00004000	/* Unused */
> >    #define PF_NOFREEZE		0x00008000	/* This thread should not be frozen */
> >  + #define PF__RESERVED_10000	0x00010000	/* Unused */
> >    #define PF_KSWAPD		0x00020000	/* I am kswapd */
> >    #define PF_MEMALLOC_NOFS	0x00040000	/* All allocation requests will inherit GFP_NOFS */
> >    #define PF_MEMALLOC_NOIO	0x00080000	/* All allocation requests will inherit GFP_NOIO */
> 
> 
> How's this then, it immediately shows how holey it is :-)
> 
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1722,7 +1722,9 @@ extern struct pid *cad_pid;
>  #define PF_MEMALLOC		0x00000800	/* Allocating memory */
>  #define PF_NPROC_EXCEEDED	0x00001000	/* set_user() noticed that RLIMIT_NPROC was exceeded */
>  #define PF_USED_MATH		0x00002000	/* If unset the fpu must be initialized before use */
> +#define PF__HOLE__00004000	0x00004000	/* A HOLE */
>  #define PF_NOFREEZE		0x00008000	/* This thread should not be frozen */
> +#define PF__HOLE__00010000	0x00010000	/* A HOLE */
>  #define PF_KSWAPD		0x00020000	/* I am kswapd */
>  #define PF_MEMALLOC_NOFS	0x00040000	/* All allocation requests will inherit GFP_NOFS */
>  #define PF_MEMALLOC_NOIO	0x00080000	/* All allocation requests will inherit GFP_NOIO */
> @@ -1730,9 +1732,14 @@ extern struct pid *cad_pid;
>  						 * I am cleaning dirty pages from some other bdi. */
>  #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
>  #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
> +#define PF__HOLE__00800000	0x00800000	/* A HOLE */
> +#define PF__HOLE__01000000	0x01000000	/* A HOLE */
> +#define PF__HOLE__02000000	0x02000000	/* A HOLE */
>  #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
>  #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
>  #define PF_MEMALLOC_PIN		0x10000000	/* Allocation context constrained to zones which allow long term pinning. */
> +#define PF__HOLE__20000000	0x20000000	/* A HOLE */
> +#define PF__HOLE__40000000	0x40000000	/* A HOLE */
>  #define PF_SUSPEND_TASK		0x80000000      /* This thread called freeze_processes() and should not be frozen */

LGTM - OTOH this looks quite a bit more cluttery than I imagined it in my 
head. :-/ So I'd leave out the comment part at minimum. With that:

Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
