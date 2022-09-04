Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E288D5AC3CC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 12:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbiIDKJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 06:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbiIDKJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 06:09:44 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5A513F4E;
        Sun,  4 Sep 2022 03:09:42 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t14so472811wrx.8;
        Sun, 04 Sep 2022 03:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=O3iIl1Mah8kQtl3WghuXwmguMd4Xu3bPcYKCjyUtt4c=;
        b=aI3AGoqier4Ibi2qlq8ENNTmbh71D0vu39dKS16YHZERYD1YCsB//U3lRf+UsIGaNA
         3Vm4UrXrVwIvapd8+a6iVGGTG+6Hvjpd0ko3PopQYkWl7vUj8mdWNdcq0Yn1GU4Oppqb
         +hrWT2wzdm40yE+Z/KQJ/5Nu+m5WDV8jDlI+UHfOnClb+gehATqWjqyNK9jlKNzjkgGN
         mz64BrddlL7G3HVggeVGfThJiJYgUXiVmUF9lqBlZ3Ah5TYfJZ3cQG3TNa1Ef0CsNE0Q
         /5kwQcXpsoJuSOqIwtxRCZltfh1VWbv/cUzSTQdOcKXpKVBSL7veS0aiwZ1uknac23M5
         EWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=O3iIl1Mah8kQtl3WghuXwmguMd4Xu3bPcYKCjyUtt4c=;
        b=UxeVQODwekLBdKfkBIZxzaeJ9LM38rE7ziPb85B8UQnnds6EduwAMqOwAtCI0EOLLV
         4II/jxkX6Y+zg9LcKz0OOVUSvd1wPwjB531AmYXTRGmhWtXQb/ZqM9UEOjjYQfC8rMtc
         xGEnRVO48Zuez3NJrJEz/qFYTFHO4yepoxBkubxol1TYEA/6yGisv/lGduN1UGIg4KHQ
         hP1IeDTzNu/t4SJ9mwfgep5M6G9Me66sGPFMp1XZCAhcIGfzz/o8Iv2ZGDfRyoEnsb/5
         oUR2C1bBK5hG74sDxRElqAb7kRnJlaezjOrbn1NDwnso9Lyoe9MIodPfWSIVZJ26Cd4W
         i2RQ==
X-Gm-Message-State: ACgBeo3GFyV6JTC2xQZtI7OgBGoNG1JMo+0+3h7k80sk6FHmoO0fPYjr
        KbjqS9n/WzqMZvEJxX5SN5w=
X-Google-Smtp-Source: AA6agR5IgE879p9Hge1JcwyMTv0t11Mi3wjtLdqCclf5CjC6eJ4bp2ztUi6Q7940Oh280WxgYfjLtA==
X-Received: by 2002:a05:6000:1a87:b0:222:2c85:2f5b with SMTP id f7-20020a0560001a8700b002222c852f5bmr22353236wry.654.1662286180290;
        Sun, 04 Sep 2022 03:09:40 -0700 (PDT)
Received: from gmail.com (1F2EF751.nat.pool.telekom.hu. [31.46.247.81])
        by smtp.gmail.com with ESMTPSA id k23-20020a05600c1c9700b003a531c7aa66sm7910968wms.1.2022.09.04.03.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 03:09:39 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 4 Sep 2022 12:09:37 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 6/6] freezer,sched: Rewrite core freezer logic
Message-ID: <YxR5Yauhd90WN/AY@gmail.com>
References: <20220822111816.760285417@infradead.org>
 <20220822114649.055452969@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822114649.055452969@infradead.org>
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

> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -81,25 +81,32 @@ struct task_group;
>   */
>  
>  /* Used in tsk->state: */
> -#define TASK_RUNNING			0x0000
> -#define TASK_INTERRUPTIBLE		0x0001
> -#define TASK_UNINTERRUPTIBLE		0x0002
> -#define __TASK_STOPPED			0x0004
> -#define __TASK_TRACED			0x0008
> +#define TASK_RUNNING			0x000000
> +#define TASK_INTERRUPTIBLE		0x000001
> +#define TASK_UNINTERRUPTIBLE		0x000002
> +#define __TASK_STOPPED			0x000004
> +#define __TASK_TRACED			0x000008
>  /* Used in tsk->exit_state: */
> -#define EXIT_DEAD			0x0010
> -#define EXIT_ZOMBIE			0x0020
> +#define EXIT_DEAD			0x000010
> +#define EXIT_ZOMBIE			0x000020
>  #define EXIT_TRACE			(EXIT_ZOMBIE | EXIT_DEAD)
>  /* Used in tsk->state again: */
> -#define TASK_PARKED			0x0040
> -#define TASK_DEAD			0x0080
> -#define TASK_WAKEKILL			0x0100
> -#define TASK_WAKING			0x0200
> -#define TASK_NOLOAD			0x0400
> -#define TASK_NEW			0x0800
> -/* RT specific auxilliary flag to mark RT lock waiters */
> -#define TASK_RTLOCK_WAIT		0x1000
> -#define TASK_STATE_MAX			0x2000
> +#define TASK_PARKED			0x000040
> +#define TASK_DEAD			0x000080
> +#define TASK_WAKEKILL			0x000100
> +#define TASK_WAKING			0x000200
> +#define TASK_NOLOAD			0x000400
> +#define TASK_NEW			0x000800
> +#define TASK_FREEZABLE			0x001000
> +#define __TASK_FREEZABLE_UNSAFE	       (0x002000 * IS_ENABLED(CONFIG_LOCKDEP))
> +#define TASK_FROZEN			0x004000
> +#define TASK_RTLOCK_WAIT		0x008000
> +#define TASK_STATE_MAX			0x010000

Patch ordering suggestion: would be really nice to first do the width 
adjustment as a preparatory patch, then the real changes. The mixing 
obscures what the patch is doing here, that we leave all bits before 
TASK_NEW unchanged, add in TASK_FREEZABLE, __TASK_FREEZABLE_UNSAFE & 
TASK_FROZEN to before TASK_RTLOCK_WAIT.

Btw., wouldn't it be better to just add the new bits right before 
TASK_STATE_MAX, and leave the existing ones unchanged? I don't think the 
order of TASK_RTLOCK_WAIT is relevant, right?

>  /* Convenience macros for the sake of set_current_state: */
>  #define TASK_KILLABLE			(TASK_WAKEKILL | TASK_UNINTERRUPTIBLE)
> @@ -1714,7 +1721,6 @@ extern struct pid *cad_pid;
>  #define PF_NPROC_EXCEEDED	0x00001000	/* set_user() noticed that RLIMIT_NPROC was exceeded */
>  #define PF_USED_MATH		0x00002000	/* If unset the fpu must be initialized before use */
>  #define PF_NOFREEZE		0x00008000	/* This thread should not be frozen */
> -#define PF_FROZEN		0x00010000	/* Frozen for system suspend */
>  #define PF_KSWAPD		0x00020000	/* I am kswapd */
>  #define PF_MEMALLOC_NOFS	0x00040000	/* All allocation requests will inherit GFP_NOFS */
>  #define PF_MEMALLOC_NOIO	0x00080000	/* All allocation requests will inherit GFP_NOIO */

yay.

BTW., we should probably mark/document all PF_ holes with a PF__RESERVED 
kind of scheme? Something simple, like:

   #define PF_NPROC_EXCEEDED	0x00001000	/* set_user() noticed that RLIMIT_NPROC was exceeded */
   #define PF_USED_MATH		0x00002000	/* If unset the fpu must be initialized before use */
 + #define PF__RESERVED_04000	0x00004000	/* Unused */
   #define PF_NOFREEZE		0x00008000	/* This thread should not be frozen */
 + #define PF__RESERVED_10000	0x00010000	/* Unused */
   #define PF_KSWAPD		0x00020000	/* I am kswapd */
   #define PF_MEMALLOC_NOFS	0x00040000	/* All allocation requests will inherit GFP_NOFS */
   #define PF_MEMALLOC_NOIO	0x00080000	/* All allocation requests will inherit GFP_NOIO */

?

Thanks,

	Ingo
