Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D935A13AE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241764AbiHYOde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241762AbiHYOdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:33:31 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A07B9C52E;
        Thu, 25 Aug 2022 07:33:29 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 4ED8892009D; Thu, 25 Aug 2022 16:33:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 47FE792009C;
        Thu, 25 Aug 2022 15:33:28 +0100 (BST)
Date:   Thu, 25 Aug 2022 15:33:28 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] serial: dz: Replace DZ_XMIT_SIZE with
 UART_XMIT_SIZE
In-Reply-To: <89359013-85fe-76e1-a425-fabdfa3572f9@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2208251454480.26998@angie.orcam.me.uk>
References: <20220825091918.8398-1-ilpo.jarvinen@linux.intel.com> <alpine.DEB.2.21.2208251219120.26998@angie.orcam.me.uk> <89359013-85fe-76e1-a425-fabdfa3572f9@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2022, Ilpo Järvinen wrote:

> >  Also I'd rather:
> > 
> > #define DZ_WAKEUP_CHARS      UART_XMIT_SIZE
> > 
> > and there's no need to include <linux/serial_core.h> in dz.h as the driver 
> > itself already does that (and dz.h is an auxiliary private header).
> > 
> >  Thanks for your submission.
> 
> I have started to becomes more inclined into the direction of dropping 
> DZ_WAKEUP_CHARS entirely and use WAKEUP_CHARS like most of the drivers do
> after staring now at WAKEUP_CHARS & uart_write_wakeup() lines just now.
> 
> There is just a handful of exceptions, rest of the drivers all use 256 as 
> WAKEUP_CHARS. dz uses 1024 (4k/4) and rest of the exceptions use 
> uart_circ_empty() but I suspect they should also be just converted to 
> use WAKEUP_CHARS.

 It may have to do with the particularly low speed of the machines the 
driver/hardware is used with, one of the slowest Linux has ever supported 
(I think only the m68k port may serve slower machines) and certainly the 
slowest and earliest MIPS processors, down to R2000 clocked at 12MHz.

 Also bear in mind that the DZ11 interface is a serial line multiplexer 
rather than a classic single or multiple UART, handling up to 8 lines via 
shared Tx/Rx buffers (the original implementation was in the form of a 
rather large discrete board built of SSI chips).  In this particular 
integrated ASIC implementation 4 lines are handled and a character to be 
transmitted may have to wait for the other 3 lines to be handled first.  

 This may have contributed to the choice made by the original implementer 
here and any change will have to be thoroughly understood and evaluated.

 See <https://gunkies.org/wiki/DZ11_asynchronous_serial_line_interface> 
for an overview of the device, technical documentation, and a photo of a 
specimen dating back to mid 1970s.

  Maciej
