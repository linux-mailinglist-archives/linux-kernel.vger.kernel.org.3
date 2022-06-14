Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A4A54B1A1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244834AbiFNMjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiFNMiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:38:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D6E49F96;
        Tue, 14 Jun 2022 05:35:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E15BB8186C;
        Tue, 14 Jun 2022 12:34:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C6FC3411E;
        Tue, 14 Jun 2022 12:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655210086;
        bh=RxBJ6JD8Wf8ojeDpP8PuOnhZqWUwzlveE7eOehiepUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tccE29lgTynPfIHS7yqWNwxaJZYOzV0VVqp/4uXMujX03Ple5ePWeqyTHOJ5ZhAYj
         XMwyzSmBg7Uv+qO+GNLZXusyJPAnxyTaj4FtGrMt5xKAiPeMNutq+Fm368HCJM177K
         p3TqHFeMnXWnxHyCSaVqHfoZitET90MUOQLzYppk=
Date:   Tue, 14 Jun 2022 14:34:43 +0200
From:   'Greg KH' <gregkh@linuxfoundation.org>
To:     "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "eugenis@google.com" <eugenis@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "pcc@google.com" <pcc@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "marcos@orca.pet" <marcos@orca.pet>,
        "marcan@marcan.st" <marcan@marcan.st>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "ast@kernel.org" <ast@kernel.org>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v5 0/6] Add hardware prefetch control driver for A64FX
 and x86
Message-ID: <YqiAY689pOJbHKUd@kroah.com>
References: <20220607120530.2447112-1-tarumizu.kohei@fujitsu.com>
 <YqNCDrqcp9t8HlUJ@kroah.com>
 <OSBPR01MB203749DA00C7BEE5741AFEB980AA9@OSBPR01MB2037.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB203749DA00C7BEE5741AFEB980AA9@OSBPR01MB2037.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 11:55:39AM +0000, tarumizu.kohei@fujitsu.com wrote:
> Thanks for the comment.
> 
> > Why does userspace want to even do this?
> 
> This is because the optimal settings may differ from application to
> application.

That's not ok.  Linux is a "general purpose" operating system and needs
to work well for all applications.  Doing application-specific-tuning
based on the specific hardware like this is a nightmare for users, and
will be for you as you will now have to support this specific model to
work correctly on all future kernel releases for the next 20+ years.
Are you willing to do that?

> Examples of performance improvements for applications with simple
> memory access characteristics are described in [merit] section.
> However, some applications have complex characteristics, so it is
> difficult to predict if an application will improve without actually
> trying it out.

Then perhaps it isn't anything that they should try out :)

Shouldn't the kernel know how the application works (based on the
resources it asks for) and tune itself based on that automatically?

If not, how is a user supposed to know how to do this?

> This is not necessary for all applications. However, I want to provide
> as a minimal interface that can be used by those who want to improve
> their application even a little.
> 
> > How will they do this?
> 
> I assume to be used to tune a specific core and execute an application
> on that core. The execution example is as follows.
> 
> 1) The user tunes the parameters of a specific core before executing
>    the program.
> 
> ```
> # echo 1024 > /sys/devices/system/cpu/cpu12/cache/index0/prefetch_control/stream_detect_prefetcher_dist
> # echo 1024 > /sys/devices/system/cpu/cpu12/cache/index2/prefetch_control/stream_detect_prefetcher_dist
> # echo 1024 > /sys/devices/system/cpu/cpu13/cache/index0/prefetch_control/stream_detect_prefetcher_dist
> # echo 1024 > /sys/devices/system/cpu/cpu13/cache/index2/prefetch_control/stream_detect_prefetcher_dist
> ```

What is "1024" here?  Where is any of this documented?  And why these
specific sysfs files and not others?

> 2) Execute the program bound to the target core.
> 
> ```
> # taskset -c 12-13 a.out
> ```
> 
> If the interface is exposed, the user can develop a library to execute
> 1) and 2) operation instead.

If you have no such user today, nor a library, how do you know any of
this works well?  And again, how will you support this going forward?
Or is this specific api only going to be for one specific piece of
hardware and never any future ones?

> > What programs will do this?
> 
> It is assumed to be used by programs that execute many continuous
> memory access. It may be useful for other applications, but I can't
> explain them in detail right away.

So you haven't tested this on any real applications?  We need real users
before being able to add new apis.  Otherwise we can just remove the
apis :)

> > And why isn't just automatic and why does this hardware require manual
> > intervention to work properly?
> 
> It is difficult for the hardware to determine the optimal parameters
> in advance. Therefore, I think that the register is provided to change
> the behavior of the hardware.

Kernel programming for a general purpose operating system is hard, but
it is possible :)

good luck!

greg k-h
