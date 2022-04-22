Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FC650BA13
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448473AbiDVObO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379955AbiDVObL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:31:11 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6251F5BD1F;
        Fri, 22 Apr 2022 07:28:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A64F1CE2ADF;
        Fri, 22 Apr 2022 14:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D131C385A8;
        Fri, 22 Apr 2022 14:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650637689;
        bh=9uMz4H+bO5n8agDgpMHCaPvaOtDr0Sv9Q8n3QusL5FI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qR/JXTzc5joPwWhEQXuC3kCpRIJ/3TRBAn/sabum32P4tl6KbtSBoxG45aQGAj5fh
         ycrd/mAuAfboYJpX0pwjnqGaEG3b57/QHecGi5L1TecMBR3QjbvLIualaXhFL8QSuT
         MhtaGf8wFYPvZCtn95oGtERNhp/fkoF5afLScHGo=
Date:   Fri, 22 Apr 2022 16:28:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] serial: Fix support for UPF_SPD_* flags
Message-ID: <YmK7drS0XgnTQcaf@kroah.com>
References: <20220321163055.4058-1-pali@kernel.org>
 <CAHp75VddDG-ZJpbAb5ZhKaMpP0L+CMEx2pcYy3FOMiaxNydCWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VddDG-ZJpbAb5ZhKaMpP0L+CMEx2pcYy3FOMiaxNydCWA@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 04:29:08PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 21, 2022 at 11:07 PM Pali Rohár <pali@kernel.org> wrote:
> >
> > Support for UPF_SPD_* flags is currently broken in more drivers for two
> > reasons. First one is that uart_update_timeout() function does not
> 
> the uart_update_timeout()
> 
> > calculate timeout for UPF_SPD_CUST flag correctly. Second reason is that
> > userspace termios structre is modified by most drivers after each
> 
> structure
> 
> ...
> 
> > (error handling was ommited for simplification)
> 
> omitted
> 
> > After calling set_active_spd_cust_baud() function SPD custom divisor
> > should be active and therefore is_spd_cust_active() should return true.
> >
> > But it is not active (cfgetospeed does not return B38400) and this patch
> > series should fix it. I have tested it with 8250 driver.
> 
> drivers
> 
> > Originally Johan Hovold reported that there may be issue with these
> > ASYNC_SPD_FLAGS in email:
> > https://lore.kernel.org/linux-serial/20211007133146.28949-1-johan@kernel.org/
> >
> >
> > Johan, Greg, could you please test these patches if there is not any
> > regression?
> 
> I'm wondering why we are still supporting this ugly hack?
> Doesn't BOTHER work for you?

Yes, I too do not want to add more support for these old flags.  If they
have not been working, let's not add support for them as obviously no
one is using them.  Let's try to remove them if at all possible.

thanks,

greg k-h
