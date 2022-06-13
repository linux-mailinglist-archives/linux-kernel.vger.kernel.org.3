Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763A1547E3B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 05:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbiFMDtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 23:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbiFMDtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 23:49:11 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4074318377
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 20:49:09 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso4804874pjk.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 20:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=36dPqle/rlmpKapipF+KE1d4JPgoWr3C6RG6AlhQkWA=;
        b=Ugkkbu10YeDB3fFkCXZ732hz1icH485fPCKzAPb6Hfdy9IcTXnhDHiCTgWBulae2sI
         HCTEP9hdisGZk9fh5/56WCLuBfYD0VKVqsRLRXvFXo+v05O1bUIShZDIJR2hd1dZmmIM
         FXNZ5iOZ7IlBKe9WI5ZamyPsEBFlkXuIRi6U0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=36dPqle/rlmpKapipF+KE1d4JPgoWr3C6RG6AlhQkWA=;
        b=Qji6PgU76OJN/XNBTPQhnmpkA2yJhoVXqb1U6tpDgp1rznze+CcQq15vdhVw4cbQJy
         buJDFsnjWZQOgog8GA3ACead6ucBs58zd8XzEBYY71bDdexx1nZrB/vgvT0KN+Ip8yjn
         vgxQ4bcudAnkDH8sUGp7KSoFN8fD4WAJjxGzpwQfHGsTK8rWdFFNiw37n+hjQ5BwXJIr
         zd/m38rMbfZKQNFI6fyIpBFu1xrSFuOvf5HCCUj5ANcksLL2/t8ihISr9SlkehJXAtVe
         FgNNjiLjebxXlsJRCd1PIxOUzR8EgfFsF9LlKywum23yQZytyeRuZLpRIqByM3hFYcSM
         +v/w==
X-Gm-Message-State: AOAM5329q+WVohtuuIgL+x3vOanSkdiG+nYIoi9obC/SAd/9k3aMyCMH
        +UlE6kFJEVHx0PgbjkZhhIDQ1w==
X-Google-Smtp-Source: ABdhPJzp4MllA13fAg38/cBxUsQG0hCqm8mssIZuQ/i/A4EmGw1NniOS8zrFvEDb+JlT9qh2I9h7Vg==
X-Received: by 2002:a17:90b:1c8f:b0:1b8:c6dc:ca61 with SMTP id oo15-20020a17090b1c8f00b001b8c6dcca61mr13258788pjb.13.1655092148795;
        Sun, 12 Jun 2022 20:49:08 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:de22:3777:8b31:5148])
        by smtp.gmail.com with ESMTPSA id m26-20020a63941a000000b003fc5b1db26fsm4150680pge.52.2022.06.12.20.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 20:49:08 -0700 (PDT)
Date:   Mon, 13 Jun 2022 12:49:03 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Subject: Re: [BUG] Threaded printk breaks early debugging
Message-ID: <Yqazr060OLp2Rpbk@google.com>
References: <CAMdYzYpF4FNTBPZsEFeWRuEwSies36QM_As8osPWZSr2q-viEA@mail.gmail.com>
 <87y1y48spg.fsf@jogness.linutronix.de>
 <YqVZ4CyWTiDgngkA@google.com>
 <8735g9mqo0.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735g9mqo0.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/06/13 01:08), John Ogness wrote:
> On 2022-06-12, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> > Should a situation when we have only one online CPU be enough of a
> > reason to do direct printing? Otherwise we might not have CPUs to
> > wakeup khtread on, e.g. when CPU that printk is in atomic section for
> > too long.
> 
> IMHO, no. Especially in that situation, we do not want printk causing
> that atomic section to become even longer. If the machine has entered
> normal operation, we want printk out of the way.

At the same time printk throttles itself in such cases: new messages are
not added at much higher pace that they are printed at. So we lower the
chances of missing messages.
