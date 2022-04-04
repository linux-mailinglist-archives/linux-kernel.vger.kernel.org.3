Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6764F1ED3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380931AbiDDWHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379042AbiDDQXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:23:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819A2BC0B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:21:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46B8AB8182F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 16:21:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8ECC2BBE4;
        Mon,  4 Apr 2022 16:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649089307;
        bh=12OqAgUFqo0o0nuRsjoOTKREg/x8VwVcYoOLde88fz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LwWB/0q9+NvxDslstiuPLQ3SRqHNZAv1ybSR1/YtRUtS4E6SdC5geH9/JV3SkXo29
         RE1fmiDc8vAP9AyVDSP+VWhhAzyRhkGHOnIlWCoy0AGFZCUrhjMkTWOjm6gdbPvrUY
         tw8MdE3Jfprd/JMoRgO1sq6EE9vSewPWXlbQsm8Y=
Date:   Mon, 4 Apr 2022 18:21:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Oded Gabbay <ogabbay@kernel.org>, Jiri Slaby <jslaby@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.18-rc1
Message-ID: <YksbF4BIy3ZoEZCB@kroah.com>
References: <CAHk-=wg6FWL1xjVyHx7DdjD2dHZETA5_=FqqW17Z19X-WTfWSg@mail.gmail.com>
 <20220404022239.GA1186352@roeck-us.net>
 <CAHk-=wimc7V9mi=P+6p2nnctPYtSM55OSPVERUeJor7fkD_EVg@mail.gmail.com>
 <aba387bd-9799-e0b5-40e3-1bcb552ac74c@roeck-us.net>
 <CAHk-=witgMUS8To6wijxdbQ+QEH0gcHSYV6Y=yzOdb=Q4h9PJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=witgMUS8To6wijxdbQ+QEH0gcHSYV6Y=yzOdb=Q4h9PJA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 08:32:16AM -0700, Linus Torvalds wrote:
> On Sun, Apr 3, 2022 at 9:23 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Oops. Sorry, I thought it was big endian. No idea why. I'll update
> > subject and description and resend.
> 
> I see your updated patch, but for some reason 'b4' is unhappy about it, with
> 
>   $ b4 am 20220404134338.3276991-1-linux@roeck-us.net
> 
> causing
> 
>   ✗ [PATCH v3] staging: r8188eu: Fix PPPoE tag insertion on little
> endian systems
>   ---
>   ✗ BADSIG: DKIM/roeck-us.net
> 
> your DKIM looks fine on the messages I see, but now that I look at it
> on the mailing list, I notice that your DKIM really is very wrong, and
> has a lot of headers that a DKIM signature should *not* have.
> 
> Your DKIM signature includes header names that are very much for list
> management, so by definition DKIM will fail for any email you send
> through a mailing list. Headers like
> "Resent-From:Resent-Sender:Resent-To:Resent-Cc
> :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe" etc.
> 
> The DKIM setup should protect the meaningful headers that matter to
> the sender, not things that the mail system will validly add when it
> passes through.
> 
> So the DKIM header list should be things like
> ":To:From:Cc:Message-Id:Date:Subject:"
> 
> Not things like "Sender" or mailing list things.
> 
> Anyway, I was going to just commit it directly, but with the DKIM
> verification failing, I was a bit less eager to. And then I noticed
> that you used "be16_to_cpu()" - which is technically correct - which
> doesn't match the other code in that file.

I've taken this in my tree now and will get it to you for -rc2 if you
don't want to take it.  And yes, I see the dkim issue as well, I haven't
started complaining about to people yet as lots of people have problem
email setups.  Should we start pushing back?

thanks,

greg k-h
