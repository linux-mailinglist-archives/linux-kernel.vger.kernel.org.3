Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D6753D631
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 11:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbiFDJGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 05:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbiFDJG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 05:06:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2722CCB9
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 02:06:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEC6F60EBC
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 09:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E1EC385B8;
        Sat,  4 Jun 2022 09:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654333587;
        bh=8HV9poep+uKNH26GhqboetN+76cbS80qNZOzMrAcotM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sqs/xZaJKsYWfpmSqUr6xpX33E9tRq+bOu5PK6SyRZ1RVyE4eqeJ/X7aZnv9n/QRG
         AoUIuz6Sd37QoplZMjcqgknjdzZstp/Vgp+y7ThbcvBdFVOcGDGG4TM3T4xlwDwkV8
         03bTcDL1K0neaQDLaAZM6NlQbMZDyOwziFuXsvZE=
Date:   Sat, 4 Jun 2022 11:07:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [GIT PULL] Driver core changes for 5.19-rc1
Message-ID: <Ypsgtyyd0LsgIHGp@kroah.com>
References: <YpnwZ/Q5yTKRDBOD@kroah.com>
 <CAHk-=wjxbyfaqvS9+p9SsN34B4D=jXGdrUtCwFY+QurVKhDFyA@mail.gmail.com>
 <87leud0whu.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87leud0whu.wl-tiwai@suse.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 04, 2022 at 08:32:29AM +0200, Takashi Iwai wrote:
> On Sat, 04 Jun 2022 00:23:18 +0200,
> Linus Torvalds wrote:
> > 
> > Augh.
> > 
> > This was very badly done, and I'm not talking about the deferred probe
> > timeout things that caused problems for people.
> > 
> > On Fri, Jun 3, 2022 at 4:28 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > >         - firmware_loader reorganization and additions including the
> > >           ability to have XZ compressed firmware images and the ability
> > >           for userspace to initiate the firmware load when it needs to,
> > >           instead of being always initiated by the kernel.
> > 
> > This is actively misleading.
> > 
> > We *always* supported XZ compressed firmware images, and it was
> > enabled by CONFIG_FW_LOADER_COMPRESS,
> > 
> > What's new is the option to use ZSTD compression.
> > 
> > However, the Kconfig file addition for this was done as badly as the
> > above explanation was, and the FW_LOADER_COMPRESS_XZ option was added
> > with a help message and a default value that both are complete
> > garbage.
> > 
> > So when you do "make oldconfig", you would be expected to say 'N', and
> > in the process you lose the existing XZ compression.
> > 
> > Only when the resulting kernel doesn't boot, and you spent half an
> > hour trying to bisect things, and you start looking closer, do you
> > notice that "ooh, the config changed in bad ways".
> > 
> > Yeah, I'm a bit grumpy. This was *really* annoying.
> > 
> > The commit that does this breakage is literally called "firmware: Add
> > the support for ZSTD-compressed firmware files", and only when looking
> > closer do you notice that IT REMOVES SUPPORT FOR XZ COMPRESSION BY
> > DEFAULT.
> > 
> > Because even when keeping the FW_LOADER_COMPRESS option enabled, the
> > XZ compression is just gone, gone, gone, unless you realize that it
> > was implicitly enabled before, and now needs that default disable of
> > FW_LOADER_COMPRESS_XZ to be enabled.
> > 
> > I've said this before, and I'll say it here again (and I bet I'll have
> > to say it in the future too): the kernel config is probably the most
> > annoying part of building a kernel for anybody.
> > 
> > And it damn well does NOT HELP when people then actively break things,
> > and ask actively bad and misleading questions. In this case, for
> > example, it's not just that the XZ option is now misleading by
> > default, it's also that the whole thing has been set up so that you
> > can say "enable compressed images", but then HAVE NO ACTUAL
> > COMPRESSION METHOD!
> > 
> > Grr. This was *REALLY* badly done.
> 
> Mea culpa, I hesitated to add "default y", but it should have been
> added at least for the case with the config takeover case.  Now I see
> that you've already added "default y" to
> CONFIG_FW_LOADER_COMPRESS_XZ.  Thanks for taking care of this!

Sorry about that, I missed it too as I just selected that option to
ensure it built and worked properly on my systems :(

greg k-h
