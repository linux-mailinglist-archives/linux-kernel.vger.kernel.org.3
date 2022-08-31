Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8EE5A778A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiHaHbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiHaHbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:31:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE508BCCF1;
        Wed, 31 Aug 2022 00:31:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 372A0618A0;
        Wed, 31 Aug 2022 07:31:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219D4C433D6;
        Wed, 31 Aug 2022 07:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661931094;
        bh=d4EgKFrsrHLU78IeWOJ+tNK9WnATpRtGTtybgl+XJiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lU28n71dtK15K68q+FEAnkh9VY4bzqIFgXscMfNqa2QbgAbbQsF9fsNdOjqdzOGXQ
         KA65M7gFLZEZ5w0tl9vlSCtgo+rtH9n0s2li3w01XiB77bjCteytBg9y7UkZANxSV1
         6jDAr0Vmt+/Y4yqOWZJPp+nHW3/9BD9bv0fztmc4=
Date:   Wed, 31 Aug 2022 09:31:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     jflf_kernel@gmx.com
Cc:     Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: add quirks for Lenovo OneLink+ Dock
Message-ID: <Yw8OU8hYZuuBgrnj@kroah.com>
References: <20220824160946.10128-1-jflf_kernel@gmx.com>
 <31aeee3c-f4f1-16a8-272b-96da5d4a565e@suse.com>
 <d1a5f149-50a1-49fc-9a6d-eceffa23311b@gmx.com>
 <4b92eee0-b020-9211-2039-18ac3ac72a7b@suse.com>
 <edd97137-74a1-ee0b-d475-7c5b36197155@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edd97137-74a1-ee0b-d475-7c5b36197155@gmx.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 09:50:03PM +0200, jflf_kernel@gmx.com wrote:
> 
> On 30/08/2022 16.47, Oliver Neukum wrote:
> 
> > 1) force a reset after a resume and call reset_resume() instead of resume()
> > 2) block autosuspend if remote wakeup is required
> >
> > I suspect you are actually using the second effect. Have you
> > tested with "usbcore.autosuspend=-1" on the kernel command line.
> 
> After further testing, your suspicion is correct.
> 
> TL;DR: the two VL812 hubs don't behave well when suspended.
> 
> I'd like to prepare a better patch for that issue. What's the recommended strategy? The current patch works, even if only as a side effect and when there's a wakeup source downstream. It's currently in Greg KH's usb-linus branch, and will land in linux-next at some point. I'm tempted to let it be and undo it later in the better patch. Is that acceptable? Or should I ask Greg KH to pull it?

I can revert it if you want me to, just let me know.

thanks,

greg k-h
