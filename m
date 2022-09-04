Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8815AC461
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 15:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiIDNLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 09:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiIDNLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 09:11:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB5733E21;
        Sun,  4 Sep 2022 06:11:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5509260F80;
        Sun,  4 Sep 2022 13:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D83AC433C1;
        Sun,  4 Sep 2022 13:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662297062;
        bh=SZnkkbwyEqa8lifFAwJPPRnDoRtwMPM1gQIj/+dydlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NpFM5mJOAKsZgDy+G67HEtjMHBWr5r2EtJVYbtu5csJdNm58PuFxLP69RUqtYuplQ
         6Arb9IR/xvp0a7W1Z3OV3qAMk2QuHFfB+tAfF6oexfzQQYF6bWZWsXkCzrQkAlzP81
         kEVu6JKfYBiYUpCHlHZXWzdkTNq7IShyOnL+fm5w=
Date:   Sun, 4 Sep 2022 15:10:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     tuo cao <91tuocao@gmail.com>
Cc:     alcooperx@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND] serial: 8250_bcm7271: move spin_lock_irqsave to
 spin_lock in interrupt handler
Message-ID: <YxSj4wExrNxUxlEU@kroah.com>
References: <20220822141110.17199-1-91tuocao@gmail.com>
 <YwORy3QMbRUSlBZE@kroah.com>
 <CAEVeK2AiYFK9eopn1Uzp+osA-j22e1KbfUohJ+hRVmLNsq0gpQ@mail.gmail.com>
 <Yw316/3zuIXvm/Ty@kroah.com>
 <CAEVeK2DfcvguQ__GroRY+erU+-4=ZKvPBf1V2poRxUF77G60OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEVeK2DfcvguQ__GroRY+erU+-4=ZKvPBf1V2poRxUF77G60OQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2022 at 04:48:13PM +0800, tuo cao wrote:
> Greg KH <gregkh@linuxfoundation.org> 于2022年8月30日周二 19:35写道：
> >
> > On Sat, Aug 27, 2022 at 05:42:19PM +0800, tuo cao wrote:
> > > No, whether it's spin_lock_irqsave() or spin_lock(), the security is
> > > the same. Since this commit:e58aa3d2d0cc01ad8d6f7f640a0670433f794922,
> > > interrupt nesting is disabled, which means interrupts has disabled in
> > > the interrupt handlers. So, it is unnecessary to call
> > > spin_lock_irqsave in a interrupt handler. And it takes less time
> > > obviously to use spin_lock()，so I think this change is needed.
> >
> > I have no context at all here, please never top-post :(
> >
> Sorry for causing you trouble. It should be OK this time.
> 
> > And have you measured the time difference?  Is it a real thing?
> >
> Yes, sir. I have measured it, it is a read thing. The test code and
> log have been put on Github, please check:
> https://github.com/tuocao1991/api_test

Did you test it for this code change?

And remember, those calls are being made inside of an IRQ handler, did
you measure that time difference?

And that link does not show much, sorry, you are doing no real work at
all, and again, not operating in an irq handler.

Can you see a measurable difference with your patch applied and without
it?  If so, great, provide that informatin in the changelog text.  If
not, be very careful about changing code in stuff like this.

thanks,

greg k-h
