Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CC24615DC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349008AbhK2NMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377212AbhK2NKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:10:16 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F04C08EC1E;
        Mon, 29 Nov 2021 03:52:37 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id c32so43893854lfv.4;
        Mon, 29 Nov 2021 03:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iWUEeMgXKbO77AD47foBEfa7mbQmssJKLzk8yjSOYSY=;
        b=U2tIEVQPLPCeMdCu1GCSmBGmgd4b3cE0YUaVA7Ptat003bULsFRIKB0ShMWsNVLpnC
         gIiNSuaR89vPD5NvBHVAJptiz6fEnTOzANkyKGw87fayadLAwoS9823DcSjh7ICj4+z3
         8BMKd+pKMrfT65KNK+2vA4wn0Ab/36kY6JZj8X/gHMh+mTKic7nzZ9Q5pTe+scSSAMrR
         oGXpQFc+Y/9JY1X3lRTxbgKArCnrSUBW7q8iJYRRAFJ8bg8FkN1DAbSGthXoerdFc3rX
         j1XUuuRyr6MK1Wp6xTbZoTqp3eksfHnUZLI3T8PZzPTIBG4u+ANjjJp1zdOJ3alnPslD
         h0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iWUEeMgXKbO77AD47foBEfa7mbQmssJKLzk8yjSOYSY=;
        b=ZBThu7CLDzFfPuN7ETnY8FtM5ltudcijItKPlWngvXGjrOQLUwPV1Hs1fCXExv9Rf4
         aEZusDYORvy2eU3mlXH3/ymL4iNA8WfVi885roqPbS7wqb98A2ySlJ/L+x+CCIYF/P49
         URcuWwyF1aNtYper2m7Q/+VMIhuplzMIVkyGD3UwRLDPsg672byPxNzk692hAIMjsOby
         CJ7kaVTzas7tuyvqBS13NwoChhIIte+BDDKc54lQPeqIZ39geeOA0KMigZOwx2krYFa8
         Q4aMHZ2JRHj8gUmvZJv2t4GLs2Ra3KUfbZcDTHDPrn+PcRytFg5NCI8S7gLRStBT7ukB
         /7jw==
X-Gm-Message-State: AOAM530LfOvRcBw+Pq3I10IaVBmeQpqm0E15pB/8Po5eKspfRndrEzVi
        B0P01pTa476jaGunFgZZe4TyPtnkCNI=
X-Google-Smtp-Source: ABdhPJyV4a2kK7Hf+W0BvWJCYp3tm9l5nhuE3mizXVMpliBSqh/r6CyMfNuIh0FZ0TT44eUwwVCrkw==
X-Received: by 2002:a05:6512:3a91:: with SMTP id q17mr46080008lfu.425.1638186755724;
        Mon, 29 Nov 2021 03:52:35 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id o15sm1323059lfd.164.2021.11.29.03.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 03:52:35 -0800 (PST)
Subject: Re: [PATCH v4 08/25] kernel: Add combined power-off+restart handler
 call chain API
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee.jones@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, alankao@andestech.com,
        "K . C . Kuen-Chern Lin" <kclin@andestech.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20211126180101.27818-1-digetx@gmail.com>
 <20211126180101.27818-9-digetx@gmail.com> <YaLQqks8cB0vWp6Q@qmqm.qmqm.pl>
 <9213569e-0f40-0df1-4710-8dab564e12d6@gmail.com>
 <YaPx0kY7poGpwCL9@qmqm.qmqm.pl>
 <1fa2d9d5-f5f6-77f5-adf6-827921acce49@gmail.com>
 <YaQgiLw03lPyvuhr@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <33d1dfa7-e90e-d174-7375-836c15e7f818@gmail.com>
Date:   Mon, 29 Nov 2021 14:52:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YaQgiLw03lPyvuhr@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

29.11.2021 03:36, Michał Mirosław пишет:
> On Mon, Nov 29, 2021 at 12:53:51AM +0300, Dmitry Osipenko wrote:
>> 29.11.2021 00:17, Michał Mirosław пишет:
>>>> I'm having trouble with parsing this comment. Could you please try to
>>>> rephrase it? I don't see how you could check whether power-off handler
>>>> is available if you'll mix all handlers together.
>>> If notify_call_chain() would be fixed to return NOTIFY_OK if any call
>>> returned NOTIFY_OK, then this would be a clear way to gather the
>>> answer if any of the handlers will attempt the final action (reboot or
>>> power off).
>> Could you please show a code snippet that implements your suggestion?
> 
> A rough idea is this:
> 
>  static int notifier_call_chain(struct notifier_block **nl,
>  			       unsigned long val, void *v,
>  			       int nr_to_call, int *nr_calls)
>  {
> -	int ret = NOTIFY_DONE;
> +	int ret, result = NOTIFY_DONE;
>  	struct notifier_block *nb, *next_nb;
>  
>  	nb = rcu_dereference_raw(*nl);
>  
>  	while (nb && nr_to_call) {
> ...
>  		ret = nb->notifier_call(nb, val, v);
> +
> +		/* Assuming NOTIFY_STOP-carrying return is always greater than non-stopping one. */
> +		if (result < ret)
> +			result = ret;
> ... 
>  	}
> -	return ret;
> +	return result;
>  }
> 
> Then:
> 
> bool prepare_reboot()
> {
> 	int ret = xx_notifier_call_chain(&shutdown_notifier, PREPARE_REBOOT, ...);
> 	return ret == NOTIFY_OK;
> }
> 
> And the return value would signify whether the reboot will be attempted
> when calling the chain for the REBOOT action. (Analogously for powering off.)

If you started to execute call chain, then you began the power-off /
restart sequence, this is a point of no return. Sorry, I still don't
understand what you're trying to achieve.

The approach of having separate call chains is simple and intuitive, I
don't see reasons to change it.
