Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F30B5636FB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 17:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiGAPeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 11:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiGAPeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 11:34:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196242180E;
        Fri,  1 Jul 2022 08:34:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB70EB83095;
        Fri,  1 Jul 2022 15:34:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C7BC3411E;
        Fri,  1 Jul 2022 15:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656689652;
        bh=CI4g7mpBhd83x+K5yI20gm0estbqkbyjJjCXm+Yhu0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SPls6VoqkTe+RubK8D8fXPO4NUYKPt5wX3G/tlfPGXjf7XuSbbG0POKLgZC0D12+7
         qxqdFk7UVV0mtlJ0lgX7a6YkTUm/xFVUxLV4nKXtgKQT1zTGGBy1FcmwtmH53fwuE9
         fyasv9Z9IAbVw7gTk5VBIUT/5c26+VnDVZZ0oLfmhXu/r+nQjU02YwBVdsmP2SJPJb
         +KDMPtSSnNCLg8abbskoEQ16enu38jgM/pdIczLYuwtC9tq1oiWApdaCR+K1IrNQNH
         oB6NDaNvvVyJWldDZFhQoqThW/UxBR+dCbhWWnRE6Jq19ngUa3HHxV1+2Pt/4hH5rH
         3v0ToJAifcDsA==
Date:   Fri, 1 Jul 2022 08:34:10 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        m.szyprowski@samsung.com, michael@walle.cc, robh@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        guillaume.tucker@collabora.com, pmladek@suse.com
Subject: Re: [PATCH] kernfs: Avoid re-adding kernfs_node into
 kernfs_notify_list.
Message-ID: <Yr8T8nJC+HyPj8F7@dev-arch.thelio-3990X>
References: <20220701145047.2206900-1-imran.f.khan@oracle.com>
 <Yr8OSxotW2VEUyKQ@dev-arch.thelio-3990X>
 <2c4bdc7a-b49f-c2ea-28d0-4ec838c3b26c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c4bdc7a-b49f-c2ea-28d0-4ec838c3b26c@oracle.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 02, 2022 at 01:18:09AM +1000, Imran Khan wrote:
> Hello Nathan,
> 
> On 2/7/22 1:10 am, Nathan Chancellor wrote:
> > On Sat, Jul 02, 2022 at 12:50:47AM +1000, Imran Khan wrote:
> >> Kick fsnotify only if an event is not already scheduled for target
> >> kernfs node. commit b8f35fa1188b ("kernfs: Change kernfs_notify_list to
> >> llist.") changed kernfs_notify_list to a llist.
> >> Prior to this list was a singly linked list, protected by
> >> kernfs_notify_lock. Whenever a kernfs_node was added to the list
> >> its ->attr.notify_next was set to head of the list and upon removal
> >> ->attr.notify_next was reset to NULL. Addition to kernfs_notify_list
> >> would only happen if kernfs_node was not already in the list i.e.
> >> if ->attr.notify_next was NULL. commit b8f35fa1188b ("kernfs: Change
> >> kernfs_notify_list to llist.") removed this checking and this was wrong
> >> as it resulted in multiple additions for same kernfs_node.
> >>
> >> So far this bug only got reflected with some console related setting.
> >> Nathan found this issue when console was specified both in DT and in
> >> kernel command line and Marek found this issue when earlycon was enabled.
> >>
> >> This patch avoids adding an already added kernfs_node into notify list.
> >>
> >> Reported-by: Nathan Chancellor <nathan@kernel.org>
> >> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > 
> > This should also include:
> > 
> > Reported-by: Michael Walle <michael@walle.cc>
> > 
> >> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >> Fixes: b8f35fa1188b ("kernfs: Change kernfs_notify_list to llist.")
> >> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
> > 
> > For the ARCH=um case that I noticed:
> > 
> > Tested-by: Nathan Chancellor <nathan@kernel.org>
> > 
> 
> I am really sorry about missing these tags. I was not sure if you have tested
> the patch I sent this morning.

No worries, we all forget tags :) I hadn't tested your patch until this
point so there was no reason for you to add that tag, this was the first
time I provided it so there is no problem there. Thanks for the quick
fix!

Cheers,
Nathan
