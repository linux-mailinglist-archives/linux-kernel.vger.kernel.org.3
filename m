Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21321562349
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 21:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236926AbiF3TgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 15:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236925AbiF3Tfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 15:35:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8FE43AE9;
        Thu, 30 Jun 2022 12:35:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA608622B9;
        Thu, 30 Jun 2022 19:35:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCC5C341CA;
        Thu, 30 Jun 2022 19:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656617746;
        bh=bbakRj56jJp4BUYKvkapZrvIMgJUAVuoHeuRe/yqByA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M4660bwEifsjF9zzVycbVd4V2eKqZawU5YGB3ltnq6H2si1HvwX6JDs7lmGNZfdfM
         xhXoxZYgTmpLdk/AxgvQDyHoFgl8JRKOPpCK4o1FlqyJccxdcPMEvnvf8apaZ9QXDu
         9wHqBq2v2mst4rjAPQbUoW8uCwrc9fXtTJDObizKjfcPnOA1jrjj8KACnSmzpAbK27
         IEpymzJA+6AYZY7boM5gr5VqE/K2uu1VDJExD3DTYTydCL+nuAJ/NM8j5vaNE/BoML
         Hih9QwDlzpq4c/q9SQ9Zd30wLde6ejF9hMmZvcJ7aWUN9IRUc7VmAu1WdbSlovllpw
         QKgxhUdRSKBRg==
Date:   Thu, 30 Jun 2022 12:35:43 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: Regression for duplicate (?) console parameters on next-20220630
Message-ID: <Yr37D4P2Dmnbkb+M@dev-arch.thelio-3990X>
References: <8460ecf2a963c85793cf325e16725044@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8460ecf2a963c85793cf325e16725044@walle.cc>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 03:11:58PM +0200, Michael Walle wrote:
> Hi,
> 
> I'm not sure it these are the correct recipients, feel free to CC others.
> 
> Since next-20220630 (or maybe also since next-20220629) I'm getting the
> 
> [    3.707900] WARNING: CPU: 0 PID: 38 at fs/kernfs/dir.c:531
> kernfs_put.part.0+0x1a0/0x1d4
> [    3.716313] kernfs_put: console/active: released with incorrect
> active_ref 0
> 
> on both arm and arm64 boards. See for example:
> https://linux.kernelci.org/test/case/id/62bd840b330c4851eaa39c16/
> 
> I have the console set in the device tree as well as on the commandline.
> Up until recently that wasn't a problem and I guess that should be a valid
> configuration. That being said, the warn() will go away if I remove the
> console= parameter on the commandline.
> 
> I haven't had time to do a bisect yet. That will probably my next step;
> or maybe kernelci will already do that for me, Guillaume? Unless someone
> has some more insights/ideas.

I noticed this as well when booting ARCH=um defconfig.

I ended up doing a bisect against next-20220630 and I landed on the
driver-core merge (5732b42edfd18ee888e127fa13d425ed3ed1bef3). I did two
more bisects to figure out that there is some sort of contextual
contlict between commit 5831788afb17 ("Revert "printk: add kthread
console printers"") and commit b8f35fa1188b ("kernfs: Change
kernfs_notify_list to llist."), as it is only when those two changes are
present that this issue occurs. I am happy to provide more information
if necessary.

Cheers,
Nathan
