Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6608D4779DE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239880AbhLPRCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239871AbhLPRCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:02:09 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85019C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 09:02:09 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a9so45361922wrr.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 09:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=It+bnMz4rm/amgvVUJO9nMItDC+LaTW6epjyib1HqJ0=;
        b=ZA3e2GoUMaTgCNcQ3kQBY2Kg13CKzCEqVq7uu+SpcchRUVLm5V5klv/hPZ9pXBjFTK
         Td6bSnQAG2N25TCNvDV6Un0Xg/ngcMC44kbCfeawuAQ4iAigufTyTYNHBCdh8L+AuGR8
         VvnJsClabWwD2+ct+NPtjTBavXhTRmK3c6+tQnoe2V91n4xaJSbD45MW/Jayee2YGNKn
         +Cat7e8pCKb3h0Nk6/MSR3W5SSFFhzNjyIzxPSiVO6Djyyc//DPRlH4CLzYn8m3o5b1E
         fZ0a41QEv2wwgf2DsLQ/12vGHN+I1SaBcCAG2hRsNWpB99E5tuREg1B2uYDOmVOJWbc4
         WXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=It+bnMz4rm/amgvVUJO9nMItDC+LaTW6epjyib1HqJ0=;
        b=QkjT3EZ8W9//ed0C3rsBhJ3MAp8TDYh61TZAmOB98+8lS8FVA+Yu4vvpxSl+Cs9KNN
         79jH3fidCC0/8lPTndiFs//IN3p9UuEknWDnUtr+arP+UhCIX9++M4PJy+qBqTyE8fDn
         QrBnhaCjId7J/ohDr5bKAlQjPi1dHS+Wpo8TG/qLfHWxA6vcipG9JJ9xV4wlZJ/I/Bnc
         Jp7Nt3uuqX0MRI7emQrCrWsg7NZHAMQDMhhw3xM29OI8x/P4SlFgQpBBtLQ6bpX5RoOO
         FuRO4v5shIsvyNpC4O2MQmUq7XhFu00sHuFhgkRJlaHUJ17hENsWTNsmoBO0YahU9VsJ
         KK4g==
X-Gm-Message-State: AOAM531sLJSktC+KxRr6gN92dt/G1HwjoA85Unh8ANfNYWDnvPh6Ytjy
        gj/vyHhXVQQSzm81/tj36u5thA==
X-Google-Smtp-Source: ABdhPJzeTqEpCjeJ6NjiNp8/yLg56LBXLaaC1dSL4XvqoejFF9ms2a/DcHv6jj9bhPjxEzanzbG/Eg==
X-Received: by 2002:adf:aad6:: with SMTP id i22mr4081857wrc.40.1639674128086;
        Thu, 16 Dec 2021 09:02:08 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id q206sm1320350wme.8.2021.12.16.09.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 09:02:07 -0800 (PST)
Date:   Thu, 16 Dec 2021 17:01:58 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH] mfd: dln2: Switch to kvfree_rcu() API
Message-ID: <YbtxBvfGR97C8r8U@google.com>
References: <20211215111845.2514-1-urezki@gmail.com>
 <20211215111845.2514-5-urezki@gmail.com>
 <YbpFfsTvB96g4+yU@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YbpFfsTvB96g4+yU@pc638.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021, Uladzislau Rezki wrote:

> On Wed, Dec 15, 2021 at 12:18:41PM +0100, Uladzislau Rezki (Sony) wrote:
> > Instead of invoking a synchronize_rcu() to free a pointer
> > after a grace period we can directly make use of new API
> > that does the same but in more efficient way.
> > 
> > TO: Lee Jones <lee.jones@linaro.org>
> > TO: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  drivers/mfd/dln2.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
> > index 852129ea0766..365e3e77cac4 100644
> > --- a/drivers/mfd/dln2.c
> > +++ b/drivers/mfd/dln2.c
> > @@ -179,10 +179,8 @@ void dln2_unregister_event_cb(struct platform_device *pdev, u16 id)
> >  
> >  	spin_unlock_irqrestore(&dln2->event_cb_lock, flags);
> >  
> > -	if (found) {
> > -		synchronize_rcu();
> > -		kfree(i);
> > -	}
> > +	if (found)
> > +		kvfree_rcu(i);
> >  }
> >  EXPORT_SYMBOL(dln2_unregister_event_cb);
> >  
> + Lee Jones <lee.jones@linaro.org>                                                                                                                                                     
> + Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

I can't do anything with this.

Send it properly please.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
