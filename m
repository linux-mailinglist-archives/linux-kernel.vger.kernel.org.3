Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0B94A9443
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 08:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347837AbiBDHEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 02:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236451AbiBDHEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 02:04:12 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C93C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 23:04:12 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d1so4356323plh.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 23:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ibSjNnxdc30yC9BHWE4nP6p0VYzWf5ch++/1eRuH2is=;
        b=JAYgzjJrW5Kxj0KHOoWaKKl1MvaGFaMpxa516tjBemJPtuPhmsfNEUzJmd9aYdxgDT
         lOBNxFc6K73dfhptBxg7M1DPEIACXewxlQwoVeSn9gK4oBsPIBfr7K6ov7ax5i51eRUP
         pvsLVa27e8V7mdDVvKiJC7ChgEZD+zR8DZf/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ibSjNnxdc30yC9BHWE4nP6p0VYzWf5ch++/1eRuH2is=;
        b=6W29V/3cNX6IgJh2xgXsL3MEYItpmYWcxgz7Dik6/rA0nungEMIVpMXPw3bzwFVPq/
         /omLpaFzWrwH/Jl1UDzQy4myp5gqrbABiz+8hhvLlc3+hqqWnUkidkFW5sgKlv5fkw08
         CY6U6h2WzxYtmGb1bG1pr6E6vV0au+pWd0zIIEiqOw5w/zdIImU51q7PPpthCzX0ZMuV
         wwSKEtdmwCb1afdEnX5k8Iju6bCOwHoD2FTSgkAqUhW62XszfVHdZUo/dNOZX0azxO01
         +XSiYd26vcURW1g+4mtO2TTnRVIeomfvP1ayr7ObXfik82UkkJj7F8eFaMMrlL39DgA4
         uRyg==
X-Gm-Message-State: AOAM5327IUCJnR/5Qkfcv6P8T3JMVrTuy6LM2T1D1js12DJClPpamZq4
        uAypSDW4xn4/3RXxlfH8zp2coA==
X-Google-Smtp-Source: ABdhPJy9lp1Jb+w6HluuyyA5m/DSYdh/Tce47Uqz+NDIkt/FxssfzlB14j52s+Vf5Ebv6QMu9hQ3pQ==
X-Received: by 2002:a17:902:e788:: with SMTP id cp8mr1656708plb.172.1643958252336;
        Thu, 03 Feb 2022 23:04:12 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:2b9:190e:d890:b53e])
        by smtp.gmail.com with ESMTPSA id kb18sm14172314pjb.30.2022.02.03.23.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 23:04:11 -0800 (PST)
Date:   Fri, 4 Feb 2022 16:04:07 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] printk: defer_console_output: do not assume interrupts
 disabled
Message-ID: <YfzP50vDiJiaRVCr@google.com>
References: <20220203112915.1350753-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203112915.1350753-1-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/02/03 12:35), John Ogness wrote:
> With commit 458df9fd4815 ("printk: remove separate printk_sched
> buffers and use printk buf instead") defer_console_output() was
> changed to no longer disable interrupts. However, it used the
> function __this_cpu_or(), which assumes interrupts disabled. That
> also should have been changed to this_cpu_or().
> 
> Although defer_console_output() is mostly used when interrupts are
> disabled, this is not always the case. One example is
> get_random_bytes(), which is often called with interrupts enabled.
> 
>   get_random_bytes()
>     warn_unseeded_randomness()
>       printk_deferred()
> 
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
