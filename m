Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1074C2AD7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbiBXLYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234195AbiBXLYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:24:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33331A39CA;
        Thu, 24 Feb 2022 03:23:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5996FB82555;
        Thu, 24 Feb 2022 11:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0FCC340E9;
        Thu, 24 Feb 2022 11:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645701824;
        bh=PfnAcggG5LYjrhSuAQO1oKSGXquWacV/TfdmY6pLmzk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D6zEhiIvRb4C0tZPv/NtHRY4UyjYBUGEcYfgbK7m1i3F7kJhLzsAOV2fHMVt8ia0w
         X+Ir2uO/FrMjmfBIvyE4KVlhmmcE95+rmsRIaOFyklhxoRvFWZvbNobYmpZE+uW/26
         cs7EGrvom2dpU1/20BPvwP/uNFerJAzAiss/LqiM=
Date:   Thu, 24 Feb 2022 12:23:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] tty: serial: define UART_LCR_WLEN() macro
Message-ID: <YhdqvS+LPYk7/4lL@kroah.com>
References: <20220224095517.30872-1-jslaby@suse.cz>
 <20220224095558.30929-1-jslaby@suse.cz>
 <YhdZjDO2mBgjSLep@kroah.com>
 <b8e3d88c-2340-2247-2e1a-37c089d9065a@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8e3d88c-2340-2247-2e1a-37c089d9065a@suse.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 11:42:20AM +0100, Jiri Slaby wrote:
> On 24. 02. 22, 11:10, Greg KH wrote:
> > On Thu, Feb 24, 2022 at 10:55:54AM +0100, Jiri Slaby wrote:
> > > Define a generic UART_LCR_WLEN() macro with a size argument. It can be
> > > used to encode byte size into an LCR value. Therefore we can use it to
> > > simplify the drivers using tty_get_char_size() in the next patches.
> > > 
> > > Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> > > ---
> > >   include/uapi/linux/serial_reg.h | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
> > > index f51bc8f36813..c9d5ff6dd4c6 100644
> > > --- a/include/uapi/linux/serial_reg.h
> > > +++ b/include/uapi/linux/serial_reg.h
> > > @@ -111,6 +111,7 @@
> > >   #define UART_LCR_WLEN6		0x01 /* Wordlength: 6 bits */
> > >   #define UART_LCR_WLEN7		0x02 /* Wordlength: 7 bits */
> > >   #define UART_LCR_WLEN8		0x03 /* Wordlength: 8 bits */
> > > +#define UART_LCR_WLEN(x)	((x) - 5)
> > 
> > I'm all for this, but why does it need to be in a uapi .h file?
> 
> I'd love to put it somewhere else. But I didn't find an appropriate place.
> Should I put it simply to
> include/linux/serial_core.h
> or
> include/linux/serial.h

This one would make sense.

> ? Or create a new:
> include/linux/serial_reg.h
> to contain only this def?

Nah, no need to create a whole .h file for a single macro :)

thanks,

greg k-h
