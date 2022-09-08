Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551265B1216
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 03:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiIHBZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 21:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiIHBZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 21:25:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26C5A2859
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 18:25:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6781C61AFE
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:25:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263FBC433D6;
        Thu,  8 Sep 2022 01:25:02 +0000 (UTC)
Date:   Wed, 7 Sep 2022 21:25:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tracefs: Only clobber mode/uid/gid on remount if
 asked
Message-ID: <20220907212542.513afad2@gandalf.local.home>
In-Reply-To: <YxkEfzVusTXj9JST@google.com>
References: <20220826174353.1.Icbd40fce59f55ad74b80e5d435ea233579348a78@changeid>
        <20220826174353.2.Iab6e5ea57963d6deca5311b27fb7226790d44406@changeid>
        <20220907074443.3376c766@gandalf.local.home>
        <YxkEfzVusTXj9JST@google.com>
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

On Wed, 7 Sep 2022 13:52:15 -0700
Brian Norris <briannorris@chromium.org> wrote:

> Existing behavior:
> 
>   ## Pre-existing status: tracefs is 0755.
>   # stat -c '%A' /sys/kernel/tracing/
>   drwxr-xr-x
> 
>   ## (Re)trigger the automount.
>   # umount /sys/kernel/debug/tracing
>   # stat -c '%A' /sys/kernel/debug/tracing/.
>   drwx------
> 
>   ## Unexpected: the automount changed mode for other mount instances.
>   # stat -c '%A' /sys/kernel/tracing/
>   drwx------
> 
> New behavior:
> 
>   ## Pre-existing status: tracefs is 0755.
>   # stat -c '%A' /sys/kernel/tracing/
>   drwxr-xr-x
> 
>   ## (Re)trigger the automount.
>   # umount /sys/kernel/debug/tracing
>   # stat -c '%A' /sys/kernel/debug/tracing/.
>   drwxr-xr-x
> 
>   ## Expected: the automount does not change other mount instances.
>   # stat -c '%A' /sys/kernel/tracing/
>   drwxr-xr-x

Thanks!

Here's the new change log:

-- Steve

From: Brian Norris <briannorris@chromium.org>
Subject: [PATCH] tracefs: Only clobber mode/uid/gid on remount if asked

Users may have explicitly configured their tracefs permissions; we
shouldn't overwrite those just because a second mount appeared.

Only clobber if the options were provided at mount time.

Note: the previous behavior was especially surprising in the presence of
automounted /sys/kernel/debug/tracing/.

Existing behavior:

  ## Pre-existing status: tracefs is 0755.
  # stat -c '%A' /sys/kernel/tracing/
  drwxr-xr-x

  ## (Re)trigger the automount.
  # umount /sys/kernel/debug/tracing
  # stat -c '%A' /sys/kernel/debug/tracing/.
  drwx------

  ## Unexpected: the automount changed mode for other mount instances.
  # stat -c '%A' /sys/kernel/tracing/
  drwx------

New behavior (after this change):

  ## Pre-existing status: tracefs is 0755.
  # stat -c '%A' /sys/kernel/tracing/
  drwxr-xr-x

  ## (Re)trigger the automount.
  # umount /sys/kernel/debug/tracing
  # stat -c '%A' /sys/kernel/debug/tracing/.
  drwxr-xr-x

  ## Expected: the automount does not change other mount instances.
  # stat -c '%A' /sys/kernel/tracing/
  drwxr-xr-x


Signed-off-by: Brian Norris <briannorris@chromium.org>
