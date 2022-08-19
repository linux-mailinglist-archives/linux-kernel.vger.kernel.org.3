Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB87A5995B6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346975AbiHSHGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 03:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346473AbiHSHGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:06:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E67E1A90
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 00:06:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2D3B616D5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:06:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD52C433C1;
        Fri, 19 Aug 2022 07:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660892766;
        bh=jd5XDpEr7gN3ZEX9dYcgt70nURmY0NwjZAl7lj32mOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x36ChRHP5LwOjv9cFBYjhT5n6YZbo4Qj+vWav8O43qI+KBU7eIlAnWsSwvlRO6zys
         96PkQQzUlH+1uR1JBZyEpVMVmVfuDMjFrqTq9q9ryBgMPEUHhaiofXHhZtVbLBif4F
         uQY+IGACdUdVwnwbPC+Nr94vF3Famll9rX4xoa0E=
Date:   Fri, 19 Aug 2022 09:06:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abhishek Shah <abhishek.shah@columbia.edu>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        changlianzhi@uniontech.com, dmitry.torokhov@gmail.com,
        johan@kernel.org, Gabriel Ryan <gabe@cs.columbia.edu>
Subject: Re: data-race in do_compute_shiftstate / vt_get_shift_state
Message-ID: <Yv82W6FRCbYuRAdB@kroah.com>
References: <CAEHB24_uZNoJ9+B-XVdMcW0z1EGwpx5XL4rdEUtNqofsmYSWVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEHB24_uZNoJ9+B-XVdMcW0z1EGwpx5XL4rdEUtNqofsmYSWVw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 08:25:00PM -0400, Abhishek Shah wrote:
> Hi all,
> 
> We found a data race involving the *shift_state * variable. Although we see
> that the race involves a function which has a comment about being racy
> <https://elixir.bootlin.com/linux/v5.18-rc5/source/drivers/tty/vt/vt.c#L3174>,
> we are unsure of its security implications as the remaining switch cases
> have a console_lock() call but this one
> <https://elixir.bootlin.com/linux/v5.18-rc5/source/drivers/tty/vt/vt.c#L3224>
> does not. Please let us know what you think.

Can you propose a patch that solves the problem for you in your testing
that we can review?

thanks,

greg k-h
