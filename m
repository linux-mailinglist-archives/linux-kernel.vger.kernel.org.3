Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089BB52F1AE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 19:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352210AbiETRbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 13:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237137AbiETRbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 13:31:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5934C60BA0
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 10:31:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 157C4B82A71
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 17:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11AC8C385A9;
        Fri, 20 May 2022 17:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653067906;
        bh=lEuAPpH49ZAL8xvh6aePU+pfbu+JAGfsbB+0Xp3O5LU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vH5U9BVcMfslOBDGllyc1uR5srxpm61snyd8KD79TxwamdnxAQY6dYFSJYd6CLTUM
         msvqdro9xGZRcMh6YgQnjDjvixVbkSFfOGK2WkXBkSfYcl0StygIyFeB+6YCF0rNwp
         xDsc8txBnndbkSOr4nTSH8f5jKmSF3TsdFeMkGFuvhv7QNOO6PE1qYFzPnndV06Rq2
         0yc3Qh9DCs3rVFVPUSE9qXGz+qgTlftdEG9UQEz4NVqS+kQsCpNqEj3NTuvTuv/2Nr
         i1oL5opLZ3un9oZNbRN8zo5KAacrarjAKPr2J5MTQ7DIeQgujpntkouuNmsKyZxyjV
         IsSaggEuq8ivw==
Date:   Fri, 20 May 2022 10:31:44 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Richard Weinberger <richard@nod.at>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Jeff Dike <jdike@addtoit.com>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eduard-Gabriel Munteanu <maxdamage@aladin.ro>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        regressions <regressions@lists.linux.dev>
Subject: Re: [PATCH 1/1] um: fix error return code in winch_tramp()
Message-ID: <YofQgDo38fAnPZEy@dev-arch.thelio-3990X>
References: <20210508032239.2177-1-thunder.leizhen@huawei.com>
 <Yjt31seiNv18HYrf@dev-arch.thelio-3990X>
 <1b03d888-cea3-3e6f-087f-daeb5642a975@leemhuis.info>
 <1087614384.239493.1649583213699.JavaMail.zimbra@nod.at>
 <YlRp9KR1mp3/4Txo@thelio-3990X>
 <1287561645.244713.1649702724736.JavaMail.zimbra@nod.at>
 <e9597cbc-cabb-facf-deb6-662d40cf16a3@leemhuis.info>
 <Yoe5/HwL9DXhaw7Z@dev-arch.thelio-3990X>
 <32824a71109fe3387d582abbf56601fb08bdc9ef.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32824a71109fe3387d582abbf56601fb08bdc9ef.camel@sipsolutions.net>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 07:18:28PM +0200, Johannes Berg wrote:
> On Fri, 2022-05-20 at 08:55 -0700, Nathan Chancellor wrote:
> > On Fri, May 20, 2022 at 08:08:01AM +0200, Thorsten Leemhuis wrote:
> > > On 11.04.22 20:45, Richard Weinberger wrote:
> > > > ----- Ursprüngliche Mail -----
> > > > > Von: "Nathan Chancellor" <nathan@kernel.org>
> > > > > I attempted to print out the error code but it seems like there is no
> > > > > output in the console after "reboot: System halted". If I add an
> > > > > unconditional print right before the call to os_set_fd_block(), I see it
> > > > > during start up but I do not see it during shutdown. Is there some way
> > > > > to see that console output during shutdown?
> > > > 
> > > > I think in this case the easiest way is attaching gdb with a breakpoint.
> > > 
> > > I noticed this in my list of open regressions. It seems there wasn't any
> > > progress to get this regression fixed (please let me know in case I
> > > missed something), but I guess nobody considered it urgent which is
> > > likely not that much of a problem in this case.
> > 
> > Yes, sorry, I tried to get gdb to reveal something but I couldn't get it
> > to work then I had to move onto other work. We have worked around this
> > for the time being but it would still be nice to figure out what is
> > going on here; I am just not sure when I am going to have time to
> > participate in that process.
> > 
> 
> This fixes it for me, can you check it?

Yes, that works for me as well, thanks for looking into it!

Tested-by: Nathan Chancellor <nathan@kernel.org>

> diff --git a/arch/um/drivers/chan_user.c b/arch/um/drivers/chan_user.c
> index 6040817c036f..25727ed648b7 100644
> --- a/arch/um/drivers/chan_user.c
> +++ b/arch/um/drivers/chan_user.c
> @@ -220,7 +220,7 @@ static int winch_tramp(int fd, struct tty_port *port, int *fd_out,
>  		       unsigned long *stack_out)
>  {
>  	struct winch_data data;
> -	int fds[2], n, err;
> +	int fds[2], n, err, pid;
>  	char c;
>  
>  	err = os_pipe(fds, 1, 1);
> @@ -238,8 +238,9 @@ static int winch_tramp(int fd, struct tty_port *port, int *fd_out,
>  	 * problem with /dev/net/tun, which if held open by this
>  	 * thread, prevents the TUN/TAP device from being reused.
>  	 */
> -	err = run_helper_thread(winch_thread, &data, CLONE_FILES, stack_out);
> -	if (err < 0) {
> +	pid = run_helper_thread(winch_thread, &data, CLONE_FILES, stack_out);
> +	if (pid < 0) {
> +		err = pid;
>  		printk(UM_KERN_ERR "fork of winch_thread failed - errno = %d\n",
>  		       -err);
>  		goto out_close;
> @@ -263,7 +264,7 @@ static int winch_tramp(int fd, struct tty_port *port, int *fd_out,
>  		goto out_close;
>  	}
>  
> -	return err;
> +	return pid;
>  
>   out_close:
>  	close(fds[1]);
> 
> 
> Kind of obvious, really. :)
> 
> johannes
