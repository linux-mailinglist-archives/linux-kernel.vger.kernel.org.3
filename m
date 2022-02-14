Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45EC4B4169
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 06:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240474AbiBNFf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 00:35:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240468AbiBNFfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 00:35:52 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF2D4EA03
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 21:35:45 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id c5-20020a17090a1d0500b001b904a7046dso16275652pjd.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 21:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A5uw8NuusHMWu2H9EsRKlsl0yAY1+xIB1tX9+ZmKg0o=;
        b=H4ZcRTgffCU+V4nQE4I4n7TVS0tSq/wk3kt++4+87wfzkfF1TvBLmBiyw6eWy8+XgX
         g8tYW/w2e1v09MDmPRE9Mkoqs8OGkJVPkocnMh0CML90NrSBrMcKeuS4j3I4QbEt2JME
         1maqVLAoFU0PtH61Sc3fFIFdpgbICz/OqEUf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A5uw8NuusHMWu2H9EsRKlsl0yAY1+xIB1tX9+ZmKg0o=;
        b=Nt9SRFNQZ5J5RRfHlhCkQqPMl0A8vUVJ7xD0fb0B17+dIiB3Cos36En8JccO4sweHT
         kn0Bv0GwH7soYah2IUZfHUtrgBI6iVhZh5p7go2jewLHyGvKG1izCt8X84F5jaCnuzu/
         tj0YKFNLWSMZpR5TFOHrYAwzYk1CRzyQVQeUurgV68N0vdre+DC94ZIjzUpil8RXJem1
         J/InKr/FZZoynKFOPt6OcGrcjOz+E8bIOWE3fMN1AL7aCZClbVfg885bv67z20Zq9GPo
         TTLCcbbyR60QA8v9pwIo2WMykOmUDZmNgF+HXyqkM7eQMyTJUjPTVp6yV0c8ua0k1wtE
         6LFw==
X-Gm-Message-State: AOAM5319qRwCS/hfYL6QHs2+8jZ3rj/C1ExHAeepJI7gYaYedqNaCfyA
        i9Xl/CtJITHaRqROUaRWhxhIug==
X-Google-Smtp-Source: ABdhPJzL1kDqBiuPtpJEQddPujq+hwLdkk966Sc5BJyG+rxNIoO+0BiwpS0uaObb/NNhBolchSalPg==
X-Received: by 2002:a17:90a:72c2:: with SMTP id l2mr12819195pjk.14.1644816945414;
        Sun, 13 Feb 2022 21:35:45 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:3a3d:6c6e:58a7:8903])
        by smtp.gmail.com with ESMTPSA id hk3sm7442376pjb.12.2022.02.13.21.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 21:35:45 -0800 (PST)
Date:   Mon, 14 Feb 2022 14:35:41 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v3] printk: use atomic updates for klogd work
Message-ID: <YgnqLe9pWsbhV4kF@google.com>
References: <20220203112915.1350753-1-john.ogness@linutronix.de>
 <YfzP50vDiJiaRVCr@google.com>
 <87bkzj3t77.fsf@jogness.linutronix.de>
 <YgUzm5POctivsjUg@alley>
 <87leyhd4wc.fsf@jogness.linutronix.de>
 <87iltld4ue.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87iltld4ue.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/02/11 12:29), John Ogness wrote:
> The per-cpu @printk_pending variable can be updated from
> sleepable contexts, such as:
> 
>   get_random_bytes()
>     warn_unseeded_randomness()
>       printk_deferred()
>         defer_console_output()
> 
> and can be updated from interrupt contexts, such as:
> 
>   handle_irq_event_percpu()
>     __irq_wake_thread()
>       wake_up_process()
>         try_to_wake_up()
>           select_task_rq()
>             select_fallback_rq()
>               printk_deferred()
>                 defer_console_output()
> 
> and can be updated from NMI contexts, such as:
> 
>   vprintk()
>     if (in_nmi()) defer_console_output()
> 
> Therefore the atomic variant of the updating functions must be used.
> 
> Replace __this_cpu_xchg() with this_cpu_xchg().
> Replace __this_cpu_or() with this_cpu_or().
> 
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

FWIW
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
