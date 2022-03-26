Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7B34E84AA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 00:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiCZXkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 19:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiCZXkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 19:40:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EF766233;
        Sat, 26 Mar 2022 16:38:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA8D360C4A;
        Sat, 26 Mar 2022 23:38:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BCAC340E8;
        Sat, 26 Mar 2022 23:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648337938;
        bh=hMPQDBssRxL8VPYoAMsSCFYEvXM/XCQLEGICdhvYns4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o9erOLoxGpL5CiIx5MnuQavqLzIE/Qfz9DnTx0WqY/i2MzY08u3Wlpuryxbgqpcf/
         GFTvqYFqgXyczhFw04tgwiPQzWMIYUN8yx77KXOHyfkV2C+gp/c1Yd62Y/FoGwGIaQ
         E4soRP+10BsnNXAENQUQtl+YrWqiWOgXZDLws8b1jlMyFYr4Jj3CGfn+I9yCMxAlpr
         8o9G0a7R7ZXC2LCkfx81S2yDiuU15QUm6dtmIyhZUVMnzRCjR4SWkHWreX0nzFj4JT
         NZcUAv0CSvNhbderZWrnHYLJOOr9C2vKbfRQtQjtOSetqLHubT88FNWFGYEC1N2kPK
         Nb/Ojo4mDD/MQ==
Date:   Sun, 27 Mar 2022 08:38:54 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v4 0/3] bootconfig: Support embedding a bootconfig in
 kernel for non initrd boot
Message-Id: <20220327083854.5f44f9a33a21c53a410ff6db@kernel.org>
In-Reply-To: <164833781316.2573528.8385063821185577976.stgit@devnote2>
References: <164833781316.2573528.8385063821185577976.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I forgot to add LTO people and Masahiro to this mail. Let me update the
cover mail and resubmit.

On Sun, 27 Mar 2022 08:36:53 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here are the 4th version of the patchset to enable kernel embedded bootconfig
> for non-initrd kernel boot environment. I've fixed Makefile to determine
> update by checking the contents of embedding bootconfig file. Thanks
> Masahiro!
> 
> You can embed a bootconfig file into the kernel as a default bootconfig,
> which will be used if there is no initrd or no bootconfig is attached to initrd. 
> 
> This needs 2 options: CONFIG_EMBED_BOOT_CONFIG=y and set the file
> path to CONFIG_EMBED_BOOT_CONFIG_FILE. Even if you embed the bootconfig file
> to the kernel, it will not be enabled unless you pass "bootconfig" kernel
> command line option at boot. Moreover, since this is just a "default"
> bootconfig, you can override it with a new bootconfig if you attach another
> bootconfig to the initrd (if possible).
> CONFIG_EMBED_BOOT_CONFIG_FILE can take both absolute and relative path, but
> to simplify and make it independent from the build environment, I recommend
> you to use an absolute path for that.
> 
> This is requested by Padmanabha at the below thread;
> 
>  https://lore.kernel.org/all/20220307184011.GA2570@pswork/T/#u
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (3):
>       bootconfig: Check the checksum before removing the bootconfig from initrd
>       bootconfig: Support embedding a bootconfig file in kernel
>       docs: bootconfig: Add how to embed the bootconfig into kernel
> 
> 
>  Documentation/admin-guide/bootconfig.rst |   30 ++++++++++++++++++++++++++---
>  include/linux/bootconfig.h               |   10 ++++++++++
>  init/Kconfig                             |   21 ++++++++++++++++++++
>  init/main.c                              |   31 +++++++++++++++---------------
>  lib/.gitignore                           |    1 +
>  lib/Makefile                             |   10 ++++++++++
>  lib/bootconfig.c                         |   23 ++++++++++++++++++++++
>  7 files changed, 108 insertions(+), 18 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
