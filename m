Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB104C9789
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 22:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238508AbiCAVHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 16:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236791AbiCAVHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 16:07:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2CF85965;
        Tue,  1 Mar 2022 13:06:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7689360FA8;
        Tue,  1 Mar 2022 21:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6658BC340EF;
        Tue,  1 Mar 2022 21:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646168782;
        bh=LUH6Agnh4EUwm1WPKWlvIKHHlNsF7Xd6XjQCsPhHrhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ebjrozWnpXJYbhUq6pS5tgtAdOyzvGpvvtFgBn11LUQER2RwtyZGmPGWEcrgFxo91
         BUhjMNUPJVa4r04dAzAXFcqC7ybum5Qj8XuXzOBIRUXeQmy2KmdIpxJ/VQzZbf1qJM
         AHugB0VuyM8LIcyZkK0Q7Vkzkfro/uSCUn0VGGSE=
Date:   Tue, 1 Mar 2022 22:06:20 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH V3] tty: serial: meson: Fix the compile link error
 reported by kernel test robot
Message-ID: <Yh6KzOU4xsSB0lRf@kroah.com>
References: <20220228135530.6918-1-yu.tu@amlogic.com>
 <29b34655-f820-39c9-4363-878481cd3f63@baylibre.com>
 <Yh087tJhakKHs88e@kroah.com>
 <8747c5c6-a129-3a26-8ebb-9e21a18236ec@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8747c5c6-a129-3a26-8ebb-9e21a18236ec@baylibre.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 08:23:26AM +0100, Neil Armstrong wrote:
> Hi Greg,
> 
> Le 28/02/2022 à 22:21, Greg Kroah-Hartman a écrit :
> > On Mon, Feb 28, 2022 at 03:13:48PM +0100, Neil Armstrong wrote:
> > > Hi,
> > > 
> > > On 28/02/2022 14:55, Yu Tu wrote:
> > > > Describes the calculation of the UART baud rate clock using a clock
> > > > frame. Forgot to add in Kconfig kernel test Robot compilation error
> > > > due to COMMON_CLK dependency.
> > > > 
> > > > Fixes: ("tty: serial:meson: Describes the calculation of the UART baud rate clock using a clock frame“)
> > > 
> > > As I already replied on V2 of this patch, you're invited to apply these fixes directly
> > > on the next version of your "Use CCF to describe the UART baud rate clock" patchset
> > > and not as a separate patch.
> > 
> > No, this is broken in linux-next now as the path listed here is in my
> > tree right now.
> 
> Oh, I wasn't aware you took this patchset.
> 
> > 
> > I need a fix for it, or I can revert the original.
> 
> Please revert the whole patchset, it's not ready yet, neither fully reviewed ands buggy
> on old SoCs.

Yes, will go do so now, thanks for letting me know and sorry about all
of this.

greg k-h
