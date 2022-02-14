Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8644B421C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 07:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240887AbiBNGtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 01:49:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240879AbiBNGtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 01:49:20 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0542A56C32
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 22:49:14 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id t4-20020a17090a510400b001b8c4a6cd5dso14825548pjh.5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 22:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=39a4CXFCmIJYNv21+wNPeFjnxGc+FfpQgftB0FGFbwk=;
        b=oKIwdTHURiJ4DBz1rfSeWtcGhhADvPfjg1reCP7BI93ddsy1+hGXUvMPyC5M/uSddw
         7VQhZLh+l9H+I/pXbjQX9kAtx0a7OlfY/fReau8LTD8WTtm7y7rrpBJ2iRvg7FcqYn0I
         sW9MfGK91VxUvyd9ljPQoP/gVtyBMYqtvZSdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=39a4CXFCmIJYNv21+wNPeFjnxGc+FfpQgftB0FGFbwk=;
        b=mSkZma0fG1UtIhsfCN1iBGNeNLB28dCdVm4p70ZfVfQHwSJANdbrL0hGzRPEdyKAFM
         pt3WGHpSC1tDEyDXORqkeLPuTYd0PCpBnhwoF5fJ61SKXHtdGAGLddH+gz66dYp7YZaI
         JceN9ZYTNFWuOxY9F1fOe84kduZusdIWCrRq93JsdirF7EvVcoFvpG/c/+ShtlztsCw1
         SsvmPETwy6D4IuhaNC3F1K/Za/P2og5qw5SW3uSxcV3ecVUbB1msQJxylX9H0k3mYSuW
         MfsyGFa2V5HK/KirhmAuPTtyaWhCbpR6KCxvrgsklH8fLQJtu/EvFUpXpz0HWCf2LelQ
         hGCA==
X-Gm-Message-State: AOAM532nEwpRPDxlqEUm/Ytw81dpr1D8du7JzXa573d01Brim30kZ6WC
        YqZu1x9ZL+hJ1AZuE4f6xsfJnw==
X-Google-Smtp-Source: ABdhPJwYXe8r7mNllEWF2VHTQGfOacXIf51/GFO3X46kFKqi6pVsOr+iOMt0JvnkwNutLwYdb/Q3qA==
X-Received: by 2002:a17:902:8698:: with SMTP id g24mr12741100plo.110.1644821353574;
        Sun, 13 Feb 2022 22:49:13 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:3a3d:6c6e:58a7:8903])
        by smtp.gmail.com with ESMTPSA id nv13sm13231962pjb.17.2022.02.13.22.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 22:49:13 -0800 (PST)
Date:   Mon, 14 Feb 2022 15:49:08 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH printk v1 01/13] printk: rename cpulock functions
Message-ID: <Ygn7ZFnFL4QiQHRg@google.com>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-2-john.ogness@linutronix.de>
 <YgZaMkUU5Ve2GV9D@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgZaMkUU5Ve2GV9D@alley>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/02/11 13:44), Petr Mladek wrote:
> On Mon 2022-02-07 20:49:11, John Ogness wrote:
> > Since the printk cpulock is CPU-reentrant and since it is used
> > in all contexts, its usage must be carefully considered and
> > most likely will require programming locklessly. To avoid
> > mistaking the printk cpulock as a typical lock, rename it to
> > cpu_sync. The main functions then become:
> > 
> >     printk_cpu_sync_get_irqsave(flags);
> >     printk_cpu_sync_put_irqrestore(flags);
> 
> It is possible that I will understand the motivation later when
> reading the entire patchset. But my initial reaction is confusion ;-)
> 
> From mo POV, it is a lock. It tries to get exclusive access and
> has to wait until the current owner releases it.

printk has been using enter/exit naming for a while now (starting with
nmi enter/exit, then printk_safe enter/exit and soon direct enter/exit);
so may be we can follow suit here and use printk_cpu_sync_enter() and
printk_cpu_sync_exit()?


> After all the word "lock" is part of "deadlock".

That's a good one.
