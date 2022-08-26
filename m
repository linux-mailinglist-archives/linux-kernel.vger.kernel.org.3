Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22A45A28B0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 15:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343758AbiHZNes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 09:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbiHZNeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 09:34:46 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE3821CD;
        Fri, 26 Aug 2022 06:34:44 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id C7F2392009C; Fri, 26 Aug 2022 15:34:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id C1B9D92009B;
        Fri, 26 Aug 2022 14:34:42 +0100 (BST)
Date:   Fri, 26 Aug 2022 14:34:42 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] serial: dz: xmit buffer is UART_XMIT_SIZE'd
In-Reply-To: <20220825131746.21257-2-ilpo.jarvinen@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2208261419080.26998@angie.orcam.me.uk>
References: <20220825131746.21257-1-ilpo.jarvinen@linux.intel.com> <20220825131746.21257-2-ilpo.jarvinen@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2022, Ilpo Järvinen wrote:

> In theory, the Tx code would be buggy if UART_XMIT_SIZE differs from
> 4096 (occurs when PAGE_SIZE > 4k), however, given the lack of issue
> reports such configuration likely doesn't occur with any real platform
> with dz HW. The inconsisted sizes would cause missing characters and
> never-ending bogus Tx when ->head reaches the region above 4k. The
> issue, if it would be real, would predate git days.

 This is misleading.  There are exactly 3 machine models (2 major ones and 
1 extra submodel) that we currently support which make use of this serial 
port hardware and driver, and they all have their R2000/R3000 MIPS CPU 
soldered onto their respective mainboards.  And the CPUs they use all have 
their page size hardwired to 4KiB, so it's not the lack of reports, but a 
firm assertion that this driver as it stands shall never be used with a 
different page size.

 There exists an option card using a DZ11-compatible chipset that can be 
used with systems we currently support with page sizes of up to 64KiB, but 
to the best of my knowledge only a number of prototype cards has been made 
and I have heard of exactly one person having such a card.  Therefore we 
do not support it and may never do, so it is not a concern for the driver 
as it stands and shall not be mentioned.

 Please just state then that the change is for design consistency with the 
serial core and redefine DZ_XMIT_SIZE in terms of UART_XMIT_SIZE as I 
suggested for v1.  I'll ack such a change.  Please drop 2/2 at this stage 
as it does not fix any bug and does not appear to add any value to this 
driver.

 Thanks,

  Maciej
