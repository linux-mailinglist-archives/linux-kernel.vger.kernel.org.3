Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B764D011D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243152AbiCGOY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243141AbiCGOY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:24:56 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FA86E8F3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 06:24:00 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t11so23580553wrm.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 06:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mIIVvuK2N/32KeIEXgX7T/cu6Rp6fCq2WJv1t+elJk0=;
        b=F2EkS1OkeFcBz8FzJ1PYrn6nmbbnh/LcjsYdslyLyKZouoZOngfzPhavOHdNWb7ntF
         lMAgQWVFgb49+9jjYedUUgGDvRPwtCEPF3NcY6CddSac5a65ceBDeKdeRDx6SbE2t+BC
         gHnLBtUa4KBEJzs26sxJjjlCII0LOpkjS2+HXgBAsIvNNBZ/RvzRs2LyEfle51GLFuEQ
         +QIzEPukRNOi04Ew6pYfB6zcXlT4hEx0ppXmoFcwMVBY69ad7YNJxhFEuu72csDcx1eH
         xY6WwAFodItq4zPMUqlzV8XDP17LIDgSqj9umFJOElv28rbY7NuoxbVuvoU8Q/yICaoX
         ndSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mIIVvuK2N/32KeIEXgX7T/cu6Rp6fCq2WJv1t+elJk0=;
        b=O+Yy99mphQFsHqMqynU6mfqQu6HcYqts5BBaVP8IQY7SbGp4HhaUaepZX5Q5kpQoAz
         C+R7QOVEgYn4W78aiwOvU3ZeigMqO9gFnYkE5WebgWIbOtUeQLQc+DWQ/Jn7wHBIy35/
         Bcxqtbr9OJFIRzjnwSdT9od1lbQtoLB3CUyg2PYTmtY/qf21VCh4ABpsQktvIPU7BnCG
         N3YwG+0mBbmb95J5tL4yi1K9xEEszKDde0RyCCeWMBRWMIhdT5HZpDTQmmCuIeswz682
         vTF2II7PkKMmmdxuNcITNUIRe3Tr4Na4eF1jLszB9Ixs0jjV2MRWQ9cOa/DaORy8Kj3a
         b9ug==
X-Gm-Message-State: AOAM531emlZmbzhiVIIDuRS5EEvtX+c3ARfuUzH1vF7AhoU6RbT8+ubA
        gaLoSekgriOiAi7hjwi8vpMrIw==
X-Google-Smtp-Source: ABdhPJzQI4QjqhdFPG0fJBteqt1+29zzxkApr9e/9w3GgGEmpxrbvRqsxvfQsyX3DLpyuuTW1sis/A==
X-Received: by 2002:adf:ea0f:0:b0:1f0:61f6:c3df with SMTP id q15-20020adfea0f000000b001f061f6c3dfmr8407228wrm.543.1646663038946;
        Mon, 07 Mar 2022 06:23:58 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id p3-20020a05600c358300b003897e440047sm10853608wmq.28.2022.03.07.06.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 06:23:58 -0800 (PST)
Date:   Mon, 7 Mar 2022 14:23:56 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-serial@vger.kernel.org, hasegawa-hitomi@fujitsu.com,
        dianders@chromium.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, jason.wessel@windriver.com,
        linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        arnd@arndb.de, peterz@infradead.org
Subject: Re: [RFT v4] tty/sysrq: Make sysrq handler NMI aware
Message-ID: <20220307142356.ksx7k5xalqlsxnqk@maple.lan>
References: <20220307110328.2557655-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307110328.2557655-1-sumit.garg@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 04:33:28PM +0530, Sumit Garg wrote:
> Allow a magic sysrq to be triggered from an NMI context. This is done
> via marking some sysrq actions as NMI safe. Safe actions will be allowed
> to run from NMI context whilst that cannot run from an NMI will be queued
> as irq_work for later processing.
>
> <snip>
>
> @@ -566,12 +573,46 @@ static void __sysrq_put_key_op(int key, const struct sysrq_key_op *op_p)
>  		sysrq_key_table[i] = op_p;
>  }
>  
> +static atomic_t sysrq_key = ATOMIC_INIT(-1);
> +
> +static void sysrq_do_irq_work(struct irq_work *work)
> +{
> +	const struct sysrq_key_op *op_p;
> +	int orig_suppress_printk;
> +	int key = atomic_read(&sysrq_key);
> +
> +	orig_suppress_printk = suppress_printk;
> +	suppress_printk = 0;
> +
> +	rcu_sysrq_start();
> +	rcu_read_lock();
> +
> +	op_p = __sysrq_get_key_op(key);
> +	if (op_p)
> +		op_p->handler(key);
> +
> +	rcu_read_unlock();
> +	rcu_sysrq_end();
> +
> +	suppress_printk = orig_suppress_printk;
> +	atomic_set(&sysrq_key, -1);
> +}
> +
> +static DEFINE_IRQ_WORK(sysrq_irq_work, sysrq_do_irq_work);
> +
>  void __handle_sysrq(int key, bool check_mask)
>  {
>  	const struct sysrq_key_op *op_p;
>  	int orig_log_level;
>  	int orig_suppress_printk;
>  	int i;
> +	bool irq_work = false;
> +
> +	/* Skip sysrq handling if one already in progress */
> +	if (atomic_cmpxchg(&sysrq_key, -1, key) != -1) {
> +		pr_warn("Skip sysrq key: %i as one already in progress\n", key);
> +		return;
> +	}

Doesn't this logic needlessly jam sysrq handling if the irq_work cannot
be undertaken?

A console user could unwittingly attempt an !nmi_safe SysRq action on
a damaged system that cannot service interrupts. Logic that prevents
things like backtrace, ftrace dump, kgdb or reboot is actively harmful
to that user's capability to figure out why their original sysrq doesn't
work.

I think the logic to prohibht multiple deferred sysrqs should only
be present on code paths where we are actually going to defer the sysrq.


Daniel.
