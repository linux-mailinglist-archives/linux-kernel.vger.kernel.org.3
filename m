Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6765B0353
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiIGLoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiIGLoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:44:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448D880EB9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 04:44:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB2F2B81C52
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 11:44:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB2FC433B5;
        Wed,  7 Sep 2022 11:44:03 +0000 (UTC)
Date:   Wed, 7 Sep 2022 07:44:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tracefs: Only clobber mode/uid/gid on remount if
 asked
Message-ID: <20220907074443.3376c766@gandalf.local.home>
In-Reply-To: <20220826174353.2.Iab6e5ea57963d6deca5311b27fb7226790d44406@changeid>
References: <20220826174353.1.Icbd40fce59f55ad74b80e5d435ea233579348a78@changeid>
        <20220826174353.2.Iab6e5ea57963d6deca5311b27fb7226790d44406@changeid>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2022 17:44:17 -0700
Brian Norris <briannorris@chromium.org> wrote:

> Users may have explicitly configured their tracefs permissions; we
> shouldn't overwrite those just because a second mount appeared.
> 
> Only clobber if the options were provided at mount time.
> 
> Note: the previous behavior was especially surprising in the presence of
> automounted /sys/kernel/debug/tracing/.
> 
>   # Don't change /sys/kernel/tracing/ permissions on automount.
>   umount /sys/kernel/debug/tracing/
>   stat /sys/kernel/debug/tracing/.
> 
>   # Don't change /sys/kernel/tracing/ permissions.
>   mount -t tracefs none /mnt/foo
> 
>   # Change /sys/kernel/tracing/ mode and uid, but not gid.
>   mount -t tracefs -o uid=bar,mode=0750 none /mnt/baz
> 

The above text doesn't make sense. Is the comments what you are doing or
what the system is doing? If it is what the system is doing, please show
the output of the stat command and how it is doing something unexpected.

Can you show the example of what is wrong, and what you expected to happen.
The above is just a bunch of commands, but does not display anything that
is incorrect.

> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> I'm open to writing an LTP test case for this, if that seems like a good
> idea.

Yes, please add a test :-)

-- Steve

> 
>  fs/tracefs/inode.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
> 
>
