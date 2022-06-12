Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622C1547849
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 05:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbiFLC6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 22:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbiFLC56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 22:57:58 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CF9AE7E
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 19:57:56 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r71so2722534pgr.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 19:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sSf3C14fXRZieFCud/MSZcx3AAgYhpORc+Rvri3QSPk=;
        b=nBKvbXxfbQvosIyHd/QjddnnXa8XgLGzhw53c1wgST+zceCv7jRDvgJVoWMDNDX9Jp
         5mQzb1SVwWgMvM07ZbHMiic05mK0k+ozA3j01Y4UvT6y9d+iti5yLPmWfbVVN1+gDGOp
         pFO9UHcD/HqqvpKTZYNtk+PU6i6oNxSxGtLKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sSf3C14fXRZieFCud/MSZcx3AAgYhpORc+Rvri3QSPk=;
        b=R8e56qK4I7KEbsA0+0Tj+MJ5ai1XP43MutSQl/mqHeV+olfEB/MSNJj5ZeH3MQLJ82
         MDPmuvJfLJk6fwnX5uTVJl48RwuhNmrUE+nhabUZOkHR1W2GC5dhTUoPZncWJBJid3rG
         HcYfWIsDPR4F1aJMkVn7xblDc5pwaADrZdcnCsxe4Tf/7v2sMP5Wu9K58RTOihgcWcwm
         dLozmB+yTqCQGNsc4LVrTbLHjSVUOfyGmbEzHNvUAj6KeHRMP/IQypV9FDzCsNRVXij7
         PMv0Z2xKiCuFOJrpeZglp7wD3CgoKshvAfW32Ix0nCDP0KYD8/RYXHPGLH+OEtRrAXI+
         t4zQ==
X-Gm-Message-State: AOAM530TzoC+7atqfjL6z3VPnqDNFZL1WEvjpKs2rMuFJSj3j90MhTsK
        M+voJhlFX3vqBmWk3X+L/KU96A==
X-Google-Smtp-Source: ABdhPJwUOJz2aQFaeksW5WGesCTxVAu+KUnNGIRMpasqGWgun8qtmY1t7mkUWzBeN0JuYdPPEluplQ==
X-Received: by 2002:a63:474f:0:b0:3fd:6796:835f with SMTP id w15-20020a63474f000000b003fd6796835fmr35913016pgk.3.1655002676055;
        Sat, 11 Jun 2022 19:57:56 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:a53:f177:9f19:3ef9])
        by smtp.gmail.com with ESMTPSA id g17-20020a056a000b9100b0051b4e53c487sm2324811pfj.45.2022.06.11.19.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 19:57:55 -0700 (PDT)
Date:   Sun, 12 Jun 2022 11:57:51 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Subject: Re: [BUG] Threaded printk breaks early debugging
Message-ID: <YqVWL3gpfV9HJBLe@google.com>
References: <CAMdYzYpF4FNTBPZsEFeWRuEwSies36QM_As8osPWZSr2q-viEA@mail.gmail.com>
 <87y1y48spg.fsf@jogness.linutronix.de>
 <CAMdYzYr-Wo713Y4qjboTpoK6GcrYfKCfRJAEizwXw6-=dymVzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMdYzYr-Wo713Y4qjboTpoK6GcrYfKCfRJAEizwXw6-=dymVzg@mail.gmail.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/06/10 11:34), Peter Geis wrote:
> > On 2022-06-10, Peter Geis <pgwipeout@gmail.com> wrote:
> > > However I've run into an issue debugging early boot issues. Anything
> > > that causes the kernel threading system to die (for example here, a
> > > NPE) causes the boot console to halt before it outputs the error.
> >
> > A null pointer exception should trigger a panic, which will cause printk
> > to enter direct mode for the oops. It should be just as effective as
> > before introducing the printing kthreads.
> 
> This might be a side effect of the fact that this is on a low powered
> arm64 board. I noticed with threading enabled during large bursts the
> console drops an excessive amount of messages. It's especially
> apparent during the handover from earlycon to the normal console.

How many CPUs does it have?
