Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103FD5482EB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 11:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiFMJFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiFMJFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:05:15 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C260E09E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:05:14 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id mh16-20020a17090b4ad000b001e8313301f1so7607926pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yf4uQqjq18xkrHLkb2+6jzY6i4Q3FrV7ACwW2a8VXng=;
        b=iasKB4UXWbJ6k2SuGWn4kaXn0zU/zbIo8v2p1gYX2ZjzCd/raAgen5kmiTSxBWsUqS
         7AKW/qJtnBVVDMagZpUJMb7crZ5tKlOD8s78G8wkgm8JouXYFrnN3DrDhYH2J37E3mIy
         JYuDz9ldgWFEaP3mtRZvcUjzoQvgeAyt1Upvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yf4uQqjq18xkrHLkb2+6jzY6i4Q3FrV7ACwW2a8VXng=;
        b=SUpzfzJYXoAO4zau2Dqf1eT+LNMGDfYxuiP/hKvjRO1vXH3BazUVfbQW+MHk2P3h04
         8JOb8rc/57+9/6ax82neR9UhB/XBgnyz1GNdCPCZdWmwjxyXrmgypc9PmCHfI54YRkNH
         /N5sFwZNIJfPSr7jFYhnBwrCI68dpm9eRDjw7JcKHrV+71dTfN53fwqjVLJdjGRQFIh6
         mUxdq3tvadylqVqk4Lr79ufXMu80nbthHLCXqc0hS57hjkXYb/pgLlm6I/fXkRQqyfZ4
         upPTrmgzY37GE6N/uyeoEDpY5FNjFv3FWXrn7FweiQZKX16i1W0iURq3zqBJUiXy/tpo
         ZjeQ==
X-Gm-Message-State: AOAM532mOMl3OMZpc4u//PNxp9zG9+AZUKStolFewEr/9N/ofuXe3fH6
        fsGPZP7mglRFcMA6BIdWCaZx6w==
X-Google-Smtp-Source: ABdhPJxRKgV21sj5bmCx6fBT63Z0QdrSXxDIH9avQ4LVICaS71VFsPjZfmkmIMO6dd7S6ikcA5hlXA==
X-Received: by 2002:a17:902:9307:b0:166:41a8:abc0 with SMTP id bc7-20020a170902930700b0016641a8abc0mr54929457plb.135.1655111113782;
        Mon, 13 Jun 2022 02:05:13 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:de22:3777:8b31:5148])
        by smtp.gmail.com with ESMTPSA id b10-20020a170902650a00b001675991fb7fsm4526874plk.55.2022.06.13.02.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 02:05:12 -0700 (PDT)
Date:   Mon, 13 Jun 2022 18:05:08 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Subject: Re: [BUG] Threaded printk breaks early debugging
Message-ID: <Yqb9xOBiY/262lhk@google.com>
References: <CAMdYzYpF4FNTBPZsEFeWRuEwSies36QM_As8osPWZSr2q-viEA@mail.gmail.com>
 <87y1y48spg.fsf@jogness.linutronix.de>
 <YqVZ4CyWTiDgngkA@google.com>
 <8735g9mqo0.fsf@jogness.linutronix.de>
 <Yqazr060OLp2Rpbk@google.com>
 <87wndlge43.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wndlge43.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/06/13 10:36), John Ogness wrote:
> >> IMHO, no. Especially in that situation, we do not want printk causing
> >> that atomic section to become even longer. If the machine has entered
> >> normal operation, we want printk out of the way.
> >
> > At the same time printk throttles itself in such cases: new messages are
> > not added at much higher pace that they are printed at. So we lower the
> > chances of missing messages.
> 
> That is true if there is only 1 printk caller.

Well, which is the case when num_online_cpus() == 1?

> For SMP systems with printing handovers, it might not help at all.
> I firmly believe that sprinkling randomness into printk (i.e. system)
> latencies is not the answer. We need to keep printk lockless and out
> of the system's way unless there is a real emergency happening.

Yeah sure.

> This particular thread is not about missed messages due to printk not
> "throttling the system", but rather the kernel buffers not getting
> flushed in an emergency. This, of course, needs to be properly handled.

True, but Peter mentioned

  "I noticed with threading enabled during large bursts the console
   drops an excessive amount of messages. It's especially apparent
   during the handover from earlycon to the normal console."
