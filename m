Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5BD5AA72F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 07:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbiIBFXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 01:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIBFXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 01:23:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CECB6572;
        Thu,  1 Sep 2022 22:23:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D14861F9F;
        Fri,  2 Sep 2022 05:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00352C433C1;
        Fri,  2 Sep 2022 05:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662096223;
        bh=8yhTPNvCBiiFAJCE/Dd99GdjEBwc8xBIZFT5TWES16A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sU0exxpddjNpOKX1T4I3ZgkYm/ehBGdQZpV3Uo6eimwS8+9GUds+orFMHOJZ6Nimk
         R8bubQ3gCVyl4a2bTOKpj+WelfJBvUaprMZK5+xx7PeFW+XYspbO5GKDoJn/ZPZdNX
         PLzsNdaWmcUE+dl87L7M566irmkJfZhs8rIB0klg=
Date:   Fri, 2 Sep 2022 07:23:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] tty: serial: introduce transmit helper generators
Message-ID: <YxGTXK452NwcQEGC@kroah.com>
References: <20220901110657.3305-1-jslaby@suse.cz>
 <20220901110657.3305-2-jslaby@suse.cz>
 <YxCkqmz32qMAZAPh@kroah.com>
 <e122fe60-484b-fd50-d166-4a21e08d4775@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e122fe60-484b-fd50-d166-4a21e08d4775@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 07:16:58AM +0200, Jiri Slaby wrote:
> On 01. 09. 22, 14:25, Greg KH wrote:
> > Much nicer, but:
> > 
> > > +#define __DEFINE_UART_PORT_TX_HELPER(name, port, ch, tx_ready, put_char,  \
> > > +		tx_done, for_test, for_post, ...)			  \
> > 
> > Do you really need "port" and "ch" as part of this macro?  You always
> > set that to the same thing in your patches, so is it really needed?
> 
> Not really, just to make obvious that those are the names that can be used
> in tx_ready, put_char... I can remove it, if you prefer, of course.

I'd recommend just removing it as it's a hard macro to read as-is.  That
would make it a bit more simple as then you are just passing in the name
and the callback functions, which makes a bit more sense to me.

thanks,

greg k-h
