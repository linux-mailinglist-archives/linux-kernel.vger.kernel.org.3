Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7013352CC77
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiESHEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiESHEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:04:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F876275
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:04:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0699361AEC
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 07:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911EEC34100;
        Thu, 19 May 2022 07:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652943879;
        bh=Vs92SomJTwmxqLbZCSx0G5mbJs8qlFgyVn/DAB8d1nc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UmizLoVRvN+mTKwAZ8G24D9WBSEGXBdqRj62afY6VtuDYFW0e6UmxfACDvmuI0pPf
         hNL1ZpH8Y3GqPRApSIbG4s3bipZME8aEf3m8hike+ZM02P3cOgaMDTXMtbaW/RtRKB
         qc3Qy26wRnLtCrgdgsIED8mTkMWcPWXFoIspnlG4=
Date:   Thu, 19 May 2022 09:04:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        kernel-team@fb.com
Subject: Re: [RFC PATCH] printk: console: Allow each console to have its own
 loglevel
Message-ID: <YoXsAkUgzIjJR90W@kroah.com>
References: <YoUBh5BSsURDO71Z@chrisdown.name>
 <YoUR6RlzkCNG7BU0@kroah.com>
 <YoVM+KbdyJm8RSSr@chrisdown.name>
 <YoVO23+fvsNPnpKh@kroah.com>
 <YoVWpZKHD7aec0CJ@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoVWpZKHD7aec0CJ@chrisdown.name>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 09:27:17PM +0100, Chris Down wrote:
> Greg Kroah-Hartman writes:
> > > If you're talking about properly freeing the memory, I suppose it should
> > > happen by doing something like the following in unregister_console():
> > > 
> > >     if (!console_drivers)
> > >         /* free the class object under console lock */
> > > 
> > > ...right? Let me know if I'm misunderstanding you.
> > 
> > You can't do that as the driver core should now be managing the
> > lifespace of that object.  You can't "know" when the object's memory is
> > to be freed EXCEPT in the release function.
> > 
> > So free it there please.
> > 
> > Or do not tie the lifepan of the console class device object to the
> > console object, and keep it separate.  I don't remember exactly how you
> > tied them together here, sorry.
> 
> [...]
> 
> > > > Do you ever free the class?
> > > 
> > > Currently no. What do you think about the above proposal to do it once the
> > > console driver list is exhausted?
> > 
> > If the code can never be unloaded, no, don't worry about it.
> 
> So just so I understand, there's no problem here if we're not going to free
> the class object, correct? These two stanzas in your reply refer to the same
> thing, right?

The two stanzas in my reply do NOT refer to the same thing.

The first one is for the device that is assigned to the class.  That
must be freed and properly reference counted and handled as that is a
dynamic object that can come and go as people add and remove consoles.

The second is the 'struct class' itself.  You can register that and be
done with it if your code can never be unloaded as it can not be a
module.

Hope that explains the confusion better.

thanks,

greg k-h
