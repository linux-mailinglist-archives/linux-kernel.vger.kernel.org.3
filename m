Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677B655386D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 19:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352723AbiFURCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 13:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352619AbiFURCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 13:02:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F592AC54;
        Tue, 21 Jun 2022 10:02:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD0696156D;
        Tue, 21 Jun 2022 17:02:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D0BC341C6;
        Tue, 21 Jun 2022 17:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655830950;
        bh=QE4+UA3NK3Ve7E8Z63ZBPqjWhAiabpLThO1TMvB6X1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C4wysRmnrhaJBpYRdB5ywNmA1LZUAFQu4HsN4tNnA+3BCaPtBq0mM1GQoTFp/2mkf
         7YCXsp8XCi+kJkadJHvHyOe75ch+BZzRHgFtwHtZZTN8H5nQWkGhlbAIVkGnVMDp5Y
         m8QmInDKtt+9ZoCa87w+GaaPRACOohkfhMLz+gw8=
Date:   Tue, 21 Jun 2022 19:02:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Conor.Dooley@microchip.com
Cc:     b-liu@ti.com, Daire.McNamara@microchip.com,
        Valentina.FernandezAlanis@microchip.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-riscv@lists.infradead.org, ben.dooks@codethink.co.uk,
        heinrich.schuchardt@canonical.com, Nicolas.Ferre@microchip.com,
        Cristian.Birsan@microchip.com
Subject: Re: [PATCH v2 0/2] Add support for PolarFire SoC's musb controller
Message-ID: <YrH5onHHaiafU5Om@kroah.com>
References: <20220613114642.1615292-1-conor.dooley@microchip.com>
 <YrHXZYe4e4vlCHh3@kroah.com>
 <6c9001fa-5315-c9f4-b7b9-05248635750d@microchip.com>
 <YrHmnND30o1Rjmcp@kroah.com>
 <eb87a311-0a06-8a96-d8cc-ea0bd08efeeb@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb87a311-0a06-8a96-d8cc-ea0bd08efeeb@microchip.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 03:48:03PM +0000, Conor.Dooley@microchip.com wrote:
> 
> 
> On 21/06/2022 16:41, Greg KH wrote:
> > On Tue, Jun 21, 2022 at 03:16:49PM +0000, Conor.Dooley@microchip.com wrote:
> >>
> >>
> >> On 21/06/2022 15:36, Greg Kroah-Hartman wrote:
> >>> On Mon, Jun 13, 2022 at 12:46:41PM +0100, Conor Dooley wrote:
> >>>> Hey Bin, Greg,
> >>>> Short series here adding support for USB on Microchip PolarFire SoC FPGAs.
> >>>> The kconfig dependency for INVENTRA_DMA has become a bit of a mouthful,
> >>>> is there a better way of dealing with that?
> >>>> Thanks,
> >>>> Conor.
> >>>>
> >>>> Changes since v1:
> >>>> - Drop unneeded resource copying as per Rob's changes to the other drivers
> >>>> - Drop the dts patch
> >>>>
> >>>> Conor Dooley (2):
> >>>>   usb: musb: Add support for PolarFire SoC's musb controller
> >>>>   MAINTAINERS: add musb to PolarFire SoC entry
> >>>>
> >>>>  MAINTAINERS               |   1 +
> >>>>  drivers/usb/musb/Kconfig  |  13 +-
> >>>>  drivers/usb/musb/Makefile |   1 +
> >>>>  drivers/usb/musb/mpfs.c   | 265 ++++++++++++++++++++++++++++++++++++++
> >>>>  4 files changed, 279 insertions(+), 1 deletion(-)
> >>>>  create mode 100644 drivers/usb/musb/mpfs.c
> >>>>
> >>>>
> >>>> base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
> >>>> -- 
> >>>> 2.36.1
> >>>>
> >>>
> >>> Any chance you can get your company to fix up their email settings:
> >>>
> >>> Grabbing thread from lore.kernel.org/all/20220613114642.1615292-1-conor.dooley%40microchip.com/t.mbox.gz
> >>> Analyzing 4 messages in the thread
> >>> Checking attestation on all messages, may take a moment...
> >>> ---
> >>>   ✗ [PATCH v2 1/2] usb: musb: Add support for PolarFire SoC's musb controller
> >>>   ✗ [PATCH v2 2/2] MAINTAINERS: add musb to PolarFire SoC entry
> >>>   ---
> >>>   ✗ BADSIG: DKIM/microchip.com
> >>> ---
> >>> Total patches: 2
> >>>
> >>> If I didn't know better, I would think you were spoofing the address...
> >>
> >> Great, thanks. I was honestly hoping you would make this complaint.
> >> I brought it up with our IT before & nothing has happened yet.
> > 
> > It's amazing that your company emails are even making it to many systems
> > these days with that broken.
> 
> Well DKIM is actually enabled for the domain - just it is simple/simple
> which I would imagine passes in direct emails?

I do not know what is wrong, only that our checking of the email shows
something went wrong.  I will let the email admins figure out what is
going on as that is their domain, not mine.

thanks,

greg k-h
