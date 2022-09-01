Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8217E5A9C58
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbiIAP6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiIAP6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:58:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0D482FB1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 08:58:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BC8E61F2F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 15:58:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D60C433C1;
        Thu,  1 Sep 2022 15:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662047896;
        bh=j9IiE+cBGM6l+xNAPKSMRgz3GaWODjr55a3hhGAhTOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CjUBi8VVLZMQzzaILq62zqKIfDixy86GV7wrbEC5HRKz7L9m1Uoc7tcTD8g10b4ES
         4CDQ+5VwKku9L2cwMhRnP764cPDtZZfvZZHUPBDThZhCLkAfOzjiF6nTGJH86t6xdx
         hocDdyjmrglO/fb2uCgNnB/nL/zPkD6lfLRq6wN8=
Date:   Thu, 1 Sep 2022 17:58:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] debugfs: Only clobber mode/uid/gid on remount if
 asked
Message-ID: <YxDWlgulBijTzj3y@kroah.com>
References: <20220826174353.1.Icbd40fce59f55ad74b80e5d435ea233579348a78@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826174353.1.Icbd40fce59f55ad74b80e5d435ea233579348a78@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 05:44:16PM -0700, Brian Norris wrote:
> Users may have explicitly configured their debugfs permissions; we
> shouldn't overwrite those just because a second mount appeared.

What userspace mounts debugfs twice?

> Only clobber if the options were provided at mount time.
> 
>   # Don't change /sys/kernel/debug/ permissions.
>   mount -t debugfs none /mnt/foo
> 
>   # Change /sys/kernel/debug/ mode and uid, but not gid.
>   mount -t debugfs -o uid=bar,mode=0750 none /mnt/baz

So what happens today with this change?  Without it?

> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> I'm open to writing an LTP test case for this, if that seems like a good
> idea.

If it's really needed, again, why would debugfs be ever mounted more
than once?

thanks,

greg k-h
