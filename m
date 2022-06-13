Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B90549B99
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241655AbiFMSfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245179AbiFMSej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:34:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5CAD84
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 08:44:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41229614F9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 15:44:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9142BC3411C;
        Mon, 13 Jun 2022 15:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655135088;
        bh=y53efzXikHFm/H91hlXuqUbgkorGqWK8cDWFahm+awA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=vAG886PEu0K2LJBZOY10ZX6Zry38qoxAEMO2BeOohNJob32HoJtseFMZLZTpBVk/n
         qjFPHhxFQtV4qRn3A+bW5SkuLsS02zpcBs4fMfqJepdVO9imeuOOUkg5O24vdzh45j
         H5h2gBGEHmxRdClzEr11CLwvkZZRAdbRAUrnP9o9qQAeogwhy8DnTKCkXsLzarviun
         7WrCtY/kiW/GiAS1+ZgiHyut4xgo6w3Oz447rIv3IGutO0iHNVUSlDfaMOc1Gs1tUg
         LYNwsxJ8vFU5zox+ryBzglQA55paI+9wT5NUIJMYnXa5/7IVEGjdNSpVaIYm4/c24F
         luM3hbPNRmAnw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 341905C0510; Mon, 13 Jun 2022 08:44:48 -0700 (PDT)
Date:   Mon, 13 Jun 2022 08:44:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, frederic@kernel.org,
        pmladek@suse.com, Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [BUG] 8e274732115f ("printk: extend console_lock for per-console
 locking")
Message-ID: <20220613154448.GE1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220610205038.GA3050413@paulmck-ThinkPad-P17-Gen-1>
 <87v8t5l39z.fsf@jogness.linutronix.de>
 <20220613042937.GZ1790663@paulmck-ThinkPad-P17-Gen-1>
 <87tu8pgcj0.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tu8pgcj0.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 11:10:19AM +0206, John Ogness wrote:
> On 2022-06-12, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >> As I suspected, the final printk's cannot direct print because the
> >> kthread was printing. Using the below patch did seem to address your
> >> problem. But this is probably not the way forward.
> >
> > When I apply it, I still lose output, perhaps due to different timing?
> > Doing the pr_flush(1000, true) just before the call to kernel_power_off()
> > has been working quite well thus far, though.
> 
> Your pr_flush() is appropriate for your RCU tests, but this is a problem
> in general that needs to be addressed. I suppose we should start a new
> thread for that. ;-)
> 
> During development we experimented with the idea of kthreads pausing
> themselves whenever direct printing is activated. It was racey because
> there are situations when direct printing is only temporarily active and
> it was hard to coordinate who prints when direct printing becomes
> inactive again. So we dropped that idea. However, in this situation the
> system will not be disabling direct printing.
> 
> @Paul, can you try the below change instead? Until this has been
> officially solved, you probably want to keep your pr_flush()
> solution. (After all, that is exactly what pr_flush() is for.) But it
> would be helpful if you could run this last test for us.
> 
> @Petr, I like the idea of the kthreads getting out of the way rather
> than trying to direct print themselves (for this situation). It still
> isn't optimal because that final pr_emerg("Power down\n") might come
> before the kthread has finished its current line. But in that case the
> kthread may not have much a chance to finish the printing anyway.
> 
> John Ogness
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index ea3dd55709e7..45c6c2b0b104 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3729,7 +3729,9 @@ static bool printer_should_wake(struct console *con, u64 seq)
>  		return true;
>  
>  	if (con->blocked ||
> -	    console_kthreads_atomically_blocked()) {
> +	    console_kthreads_atomically_blocked() ||
> +	    system_state > SYSTEM_RUNNING ||
> +	    oops_in_progress) {
>  		return false;
>  	}

And this one works for me, thank you!!!

On to Petr's patch...

							Thanx, Paul
