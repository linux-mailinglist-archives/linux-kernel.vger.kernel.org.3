Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DC153C8E8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 12:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243827AbiFCKrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 06:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243821AbiFCKq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 06:46:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FF2B23
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 03:46:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8DC9B822A7
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 10:46:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104EAC385A9;
        Fri,  3 Jun 2022 10:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654253208;
        bh=voHnSQh+GFjTLqxgNPgg9571kkxhzQOWO+BJ7WIvQqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=soRurgJtmWSDJDxsPU8LHO0UnksD8WT8X/EoSAKLcjuOov1+kl0kKLRjXeNsOZwdF
         Ed22pKtiXXOQ2wk1TJtBnBN5f5yots9R5ru3plyRRCQmOu/FJADnobBhTWJyfNrBkT
         Kr1/8HwtM4/qiqwS/2uZCh3847BApE1ColBaGtK4=
Date:   Fri, 3 Jun 2022 12:46:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Char/Misc driver updates 5.19-rc1
Message-ID: <YpnmlbveC6F1srSZ@kroah.com>
References: <YpnmYB8SN5dPweLV@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpnmYB8SN5dPweLV@kroah.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 12:45:52PM +0200, Greg KH wrote:
> The following changes since commit 672c0c5173427e6b3e2a9bbb7be51ceeec78093a:
> 
>   Linux 5.18-rc5 (2022-05-01 13:57:58 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.19-rc1
> 
> for you to fetch changes up to 90de6805267f8c79cd2b1a36805071e257c39b5c:
> 
>   habanalabs: use separate structure info for each error collect data (2022-05-22 21:01:21 +0200)
> 
> ----------------------------------------------------------------
> Char / Misc / Other smaller driver subsystem updates for 5.19-rc1
> 
> Here is the large set of char, misc, and other driver subsystem updates
> for 5.19-rc1.  The merge request for this has been delayed as I wanted
> to get lots of linux-next testing due to some late arrivals of changes
> for the habannalabs driver.
> 
> Highlights of this merge are:
> 	- habanalabs driver updates for new hardware types and fixes and
> 	  other updates
> 	- IIO driver tree merge which includes loads of new IIO drivers
> 	  and cleanups and additions
> 	- PHY driver tree merge with new drivers and small updates to
> 	  existing ones
> 	- interconnect driver tree merge with fixes and updates
> 	- soundwire driver tree merge with some small fixes
> 	- coresight driver tree merge with small fixes and updates
> 	- mhi bus driver tree merge with lots of updates and new device
> 	  support
> 	- firmware driver updates
> 	- fpga driver updates
> 	- lkdtm driver updates (with a merge conflict, more on that
> 	  below)
> 	- extcon driver tree merge with small updates
> 	- lots of other tiny driver updates and fixes and cleanups, full
> 	  details in the shortlog.
> 
> All of these have been in linux-next for almost 2 weeks with no reported
> problems.
> 
> Note, there are 3 merge conflicts when merging this with your tree:
> 	- MAINTAINERS, should be easy to resolve
> 	- drivers/slimbus/qcom-ctrl.c, should be straightforward
> 	  resolution
> 	- drivers/misc/lkdtm/stackleak.c, not an easy resolution.  This
> 	  has been noted in the linux-next tree for a while, and
> 	  resolved there, here's a link to the resolution that Stephen
> 	  came up with and that Kees says is correct:
> 	  	https://lore.kernel.org/r/20220509185344.3fe1a354@canb.auug.org.au
> 
> I will be glad to provide a merge point that contains these resolutions
> if that makes things any easier for you.

I have now done so, and that can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git torvalds_merge

If there are any other issues here, please let me know.

thanks,

greg k-h

