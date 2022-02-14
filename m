Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFFC4B4207
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 07:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240826AbiBNGgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 01:36:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbiBNGgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 01:36:39 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5115856758
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 22:36:32 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id l9so8176714plg.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 22:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CY3JR5iOh2irBTOXbxpwsD7lfgO3p8DSjOCQzRQrEtA=;
        b=QyHbFMUE7QUwiaO0xzD8og1KfuEHRQ3knGjoc4di93Ox20+7EcxSWDaB8OtL+zj9t3
         tCsiPZhlzaxOSWIW7WgmXDQrXPRlazJHtofCWIwAGXfQGraczybPgZv2N0y4P/GP0vLg
         /qkGwoOZFTX9K360P6ew+M7iZsnZHf1pQhkbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CY3JR5iOh2irBTOXbxpwsD7lfgO3p8DSjOCQzRQrEtA=;
        b=jl48qM0ON38h2jtFD1VVKktZRn6ldn4bIKxMSxzg/8tZvJbwQOPH+eOuBPRpgZ/rQp
         gCjN0sqd6JGBbiwGNGM8R8QbWbLpypiPPU0jpdClmHjTX4SkHfc9N1vVruLG4qacjy3D
         uGQYgkTKFjCa+x411+BWvp2Mp10vC7kk1ZEMPMQ5+mruSxanp7NEF4Kt+mHwVBNDB6TU
         ORDbTSXwVL1RyS5lwZDY268qxg2ldBevFmMemywEqgwBeQMOlEqQ+ytGXJzXUZ7VyHSV
         7Cdhk9SGW1j3s8NpTZwTC2zN9VHjxl0GmY/0PVni53yKoXSy4teTS5i8TIIcmBdPtPaK
         Hy6w==
X-Gm-Message-State: AOAM5307RakXpmmAoJfl+Ymggj/lc+8JoxHpzse9jGuPGS44Xv4k/LNk
        3UCG0WcorB8iyRgeCE/1je8ZJ7h0agHSPQ==
X-Google-Smtp-Source: ABdhPJxLK0i7d9eqbOlIi7f+CBT6H+nd5dTVqXqdeusRpAGL/VwZ6FVB6hMubx0rVof3YcisL7dVWA==
X-Received: by 2002:a17:90a:7061:: with SMTP id f88mr1393345pjk.222.1644820591820;
        Sun, 13 Feb 2022 22:36:31 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:3a3d:6c6e:58a7:8903])
        by smtp.gmail.com with ESMTPSA id h21sm34896633pfv.135.2022.02.13.22.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 22:36:31 -0800 (PST)
Date:   Mon, 14 Feb 2022 15:36:27 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v1 02/13] printk: cpu sync always disable
 interrupts
Message-ID: <Ygn4aw7NObuVf2Lu@google.com>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-3-john.ogness@linutronix.de>
 <YgZdjl0C4tPaZJkH@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgZdjl0C4tPaZJkH@alley>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/02/11 13:58), Petr Mladek wrote:
> On Mon 2022-02-07 20:49:12, John Ogness wrote:
> > The CPU sync functions are a NOP for !CONFIG_SMP. But for
> > !CONFIG_SMP they still need to disable interrupts in order to
> > preserve context within the CPU sync sections.
> > 
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> 
> Good catch!
> 
> It is interesting that the original code did not disable interrupts
> around __dump_stack() on non-SMP, see the commit 766c268bc6d39b8124
> ("lib/dump_stack: move cpu lock to printk.c"). But it was rather
> a bug. The patch makes perfect sense.
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
