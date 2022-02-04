Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654674A92EB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 05:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356901AbiBDEEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 23:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239888AbiBDEEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 23:04:46 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE060C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 20:04:46 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id o16-20020a17090aac1000b001b62f629953so11918694pjq.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 20:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a30AE2ccnooj3fYFfCGRu5l0JT7O8tshPeAAC/h/K1k=;
        b=EIDYdwznE/cDGjbRD4nXZMyON1nhraeYHmVC09w2x2bfPEk090GGbcp/mEJN5V8f0f
         X7EwC/b6wXBDQZ2aGVTGTtIf9OrGpTkEsC43WuWtUlLzURlRos0cCtO/hphY0hahb2J1
         OM9Q4wZvpH0d/v1EWjlCgZjNytAqNhgLHi1LQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a30AE2ccnooj3fYFfCGRu5l0JT7O8tshPeAAC/h/K1k=;
        b=ALbY9IZqkq9VVNkdUN4MtCQR1S5QVoXSoJahrXkq9/voDAkWR2SM343WzQ45ODn76z
         ktMkd6P/7HL3YmIKWqZnPY+1o1o/rMEyAekXBLVAIdQdqSYdWqV3P02o2iZtzzu0lwuo
         hwq0sn8P1q8lzPNSVf47HT4x0FHPNP8uRvNjOFld1sYHnZwv56llxW9mh9rshnCabjD4
         x3C9xyAI+Z0fnyVxefaoDgu+dA2uq07A6/Mp+0oSlF0ug7lZuW17x2qnnaUfdpPsZwzz
         zA+pnuGxNfZztD4Xcgikawvyjx4aQppxo9mj20Ozg6Q8dUoXuQMry6r/TmssVNZMq0f8
         KJow==
X-Gm-Message-State: AOAM530g7ZNJXNZJypb3LJO7/SAx0D8wLxLQwDs6V+nSiWXEvYzBrsjF
        J/N8VFWE3o/aJh4AW9sS7A94vUh9tb1LvA==
X-Google-Smtp-Source: ABdhPJxoFpP9vNUrf6dOLdXRLO7uxnvxhJRRC1ZwW+x7uHLWGkTjoX6Fv8yS8kmul6mUot3MesAyxQ==
X-Received: by 2002:a17:90b:1b0b:: with SMTP id nu11mr1061121pjb.112.1643947486389;
        Thu, 03 Feb 2022 20:04:46 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:2b9:190e:d890:b53e])
        by smtp.gmail.com with ESMTPSA id d12sm412445pgk.29.2022.02.03.20.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 20:04:45 -0800 (PST)
Date:   Fri, 4 Feb 2022 13:04:41 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v3 4/4] printk: Drop console_sem during panic
Message-ID: <Yfyl2TSdFmn7HqmV@google.com>
References: <20220201185802.98345-1-stephen.s.brennan@oracle.com>
 <20220201185802.98345-5-stephen.s.brennan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201185802.98345-5-stephen.s.brennan@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/02/01 10:58), Stephen Brennan wrote:
> +/*
> + * Return true when this CPU should unlock console_sem without pushing all
> + * messages to the console. This reduces the chance that the console is
> + * locked when the panic CPU tries to use it.
> + */
> +static bool abandon_console_lock_in_panic(void)
> +{
> +	if (!panic_in_progress())
> +		return false;
> +
> +	/*
> +	 * We can use raw_smp_processor_id() here because it is impossible for
> +	 * the task to be migrated to the panic_cpu, or away from it. If
> +	 * panic_cpu has already been set, and we're not currently executing on
> +	 * that CPU, then we never will be.
> +	 */
> +	return atomic_read(&panic_cpu) != raw_smp_processor_id();
> +}
> +
>  /*
>   * Can we actually use the console at this time on this cpu?
>   *
> @@ -2746,6 +2765,10 @@ void console_unlock(void)
>  		if (handover)
>  			return;
>  
> +		/* Allow panic_cpu to take over the consoles safely */
> +		if (abandon_console_lock_in_panic())
> +			break;

Sorry, why not just `return` like in handover case?

> +
>  		if (do_cond_resched)
>  			cond_resched();
>  	}
> @@ -2763,7 +2786,7 @@ void console_unlock(void)
>  	 * flush, no worries.
>  	 */
>  	retry = prb_read_valid(prb, next_seq, NULL);
> -	if (retry && console_trylock())
> +	if (retry && !abandon_console_lock_in_panic() && console_trylock())
>  		goto again;
>  }
>  EXPORT_SYMBOL(console_unlock);
