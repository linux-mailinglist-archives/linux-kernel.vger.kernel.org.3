Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549F64C419E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 10:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239193AbiBYJks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 04:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbiBYJkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 04:40:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B8B2399C0;
        Fri, 25 Feb 2022 01:40:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BEBC60AD6;
        Fri, 25 Feb 2022 09:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9851DC340E7;
        Fri, 25 Feb 2022 09:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645782015;
        bh=qvVwmFV3QX2LvXMd+kHdlm423gP9v7Lockw/NAnMUtc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N8jUeEQdlZ30sSyJSPggzWARNCQ7bmgutQHoH6qxkT8EQpLFbsDXGx7sSVFn7pWBR
         4EljhD6pTZ1mcgsy+VCN/IZq+EffDMFmViSaPgUNfpCKaA0Pbh7M/Oi8Gmaz6Vq1yL
         GpMr0L+lo1BkKb/o7XKCSTguD7iPNSHXI/zLGpG8=
Date:   Fri, 25 Feb 2022 10:40:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] tty: serial: define UART_LCR_WLEN() macro
Message-ID: <Yhij+lZyMGDjevOD@kroah.com>
References: <20220224095517.30872-1-jslaby@suse.cz>
 <20220224095558.30929-1-jslaby@suse.cz>
 <YhdZjDO2mBgjSLep@kroah.com>
 <b8e3d88c-2340-2247-2e1a-37c089d9065a@suse.cz>
 <YhdqvS+LPYk7/4lL@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhdqvS+LPYk7/4lL@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 12:23:41PM +0100, Greg KH wrote:
> On Thu, Feb 24, 2022 at 11:42:20AM +0100, Jiri Slaby wrote:
> > On 24. 02. 22, 11:10, Greg KH wrote:
> > > On Thu, Feb 24, 2022 at 10:55:54AM +0100, Jiri Slaby wrote:
> > > > Define a generic UART_LCR_WLEN() macro with a size argument. It can be
> > > > used to encode byte size into an LCR value. Therefore we can use it to
> > > > simplify the drivers using tty_get_char_size() in the next patches.
> > > > 
> > > > Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> > > > ---
> > > >   include/uapi/linux/serial_reg.h | 1 +
> > > >   1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
> > > > index f51bc8f36813..c9d5ff6dd4c6 100644
> > > > --- a/include/uapi/linux/serial_reg.h
> > > > +++ b/include/uapi/linux/serial_reg.h
> > > > @@ -111,6 +111,7 @@
> > > >   #define UART_LCR_WLEN6		0x01 /* Wordlength: 6 bits */
> > > >   #define UART_LCR_WLEN7		0x02 /* Wordlength: 7 bits */
> > > >   #define UART_LCR_WLEN8		0x03 /* Wordlength: 8 bits */
> > > > +#define UART_LCR_WLEN(x)	((x) - 5)
> > > 
> > > I'm all for this, but why does it need to be in a uapi .h file?
> > 
> > I'd love to put it somewhere else. But I didn't find an appropriate place.
> > Should I put it simply to
> > include/linux/serial_core.h
> > or
> > include/linux/serial.h
> 
> This one would make sense.

I'll fix this up on my own, no need to resend this...

thanks

greg k-h
