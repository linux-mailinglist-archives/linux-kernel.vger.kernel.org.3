Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2BF4E464D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiCVSzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiCVSzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:55:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F9E252A6;
        Tue, 22 Mar 2022 11:53:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4394DB81D65;
        Tue, 22 Mar 2022 18:53:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78BCC340F0;
        Tue, 22 Mar 2022 18:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647975222;
        bh=cg20VRsy1Bj5cHdiezrhsFCOFh8R0/IVZ5CjlnEki3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gREk82tQD4tS0gwZMQ9JVKAQwy/azbwYDGyMctU7CS4MjL5XxriEbjFvlqD+qRzO9
         3SrPCRV8/YWbWcno8ryGoFsSIiGdRpFhuRBNHH0TtguwC59Crf4246F4NxQbvxZ+bs
         A1yEgt3ZsyB/h1uErHzA6D+6eioF4I8g0Ldym8D9eI8TZ3hX/Xhl1NekSWLp/IEemz
         XLK4bmCHHus7ld3IhQS92DblWP52445K71F9/SuJJJmTRTpwVehkgkGZdHA711kplM
         VWlx7JhffIXbGEnoZNh25f7k67S3Dl7fUiczpoxoAv1y3M5wqG+v8ZY3DTxexJnsy/
         Jr1a+CfURBZZw==
Received: by pali.im (Postfix)
        id 3792F843; Tue, 22 Mar 2022 19:53:40 +0100 (CET)
Date:   Tue, 22 Mar 2022 19:53:40 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] serial: Fix support for UPF_SPD_* flags
Message-ID: <20220322185340.eccktabcryfanxnj@pali>
References: <20220321163055.4058-1-pali@kernel.org>
 <CAHp75VddDG-ZJpbAb5ZhKaMpP0L+CMEx2pcYy3FOMiaxNydCWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VddDG-ZJpbAb5ZhKaMpP0L+CMEx2pcYy3FOMiaxNydCWA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 March 2022 16:29:08 Andy Shevchenko wrote:
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

Johan pointed in above mentioned patch that it would break
ASYNC_SPD_FLAGS. So I have looked at how are ASYNC_SPD_FLAGS implemented
to ensure that they would work correctly...

> I would rather expect to have this removed completely.

Well, if somebody is going to remove it, I have no objections. But I
understood that ASYNC_SPD_FLAGS should be still supported...
