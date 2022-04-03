Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAAF4F08E8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 13:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356799AbiDCLHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 07:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238847AbiDCLHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 07:07:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE3D33A13
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 04:05:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA246B80CC6
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 11:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64351C340F0;
        Sun,  3 Apr 2022 11:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648983946;
        bh=tNVwT/q3PJXvzpsVpXOF5IQfYuQeNb4rj36DibYNmlk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DbFkpC0c1ShrEEJpJMHS7tg9b//XrfGBo5CNZrB77oNn/QMboH7avLl4xFP56zZhq
         30oUpVqRNcX93FPWXTzeoZ1YhFP04nDppjvXEHCCF9owUe8PpuRs7I/ZqkhcVQqUIe
         P5bgLLPL3U22wHX7ZYsmhCUkYFt7/kCID0vpFJos=
Date:   Sun, 3 Apr 2022 13:05:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bruno <codeagain@codeagain.dev>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: vme: Adjusted VME_USER in Kconfig
Message-ID: <Ykl/iBR+pDaaLImA@kroah.com>
References: <20220401050045.3686663-1-codeagain@codeagain.dev>
 <YkaW0ThT8Ah3z0wW@kroah.com>
 <YkaXRpIElW1BwKGb@kroah.com>
 <37e5203d1efd310ea82cf91c18c6a07eea743ac7.camel@codeagain.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37e5203d1efd310ea82cf91c18c6a07eea743ac7.camel@codeagain.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You sent this twice?

Anyway...

On Fri, Apr 01, 2022 at 03:21:50PM -0300, Bruno wrote:
> With my tests in my, I have found two other things that I think are
> remarkable to mention. First one is a missing `depends on` line for
> `VME_BRIDGE` in drivers/staging/vme/devices/Kconfig, not visible
> because they were in the same tree, but now unveiled. I'm fixing it,
> do you think it's best to add it in the same patch?

Make that a second patch, and resend it as part of a patch series since
your first patch here is gone from my queue.

> Finally, not directly related with the patch, yet remarkable, I
> happened to notice something. When probing the vme_user module
> (compiled with CONFIG_VME_USER=m), I naturally get the following
> messages on my log and command output for `modprobe vme_user`:
> | [177666.590400] vme_user: module is from the staging directory, the
> quality is unknown, you have been warned.

That is expected.

> While this is completely expected, the message about the code from
> staging directory does not appear when compiled with
> CONFIG_VME_USER=y, as shows a `grep -i vme` on the console log:

That is because you built the driver into the tree, so there is nothing
to cause the taint code to run as there is no module loader involved.

It's expected and works the same for all staging drivers.  Try it
yourself with a different one to verify this.

> | [0.000000] Linux version 5.17.0lsa-t-vme_user=y-13483-gfeb94431c35c-
> dirty (bruno@AN5Bruno) (gcc (GCC) 11.2.0, GNU ld (GNU Binutils) 2.38)
> #7 SMP PREEMPT_DYNAMIC Fri Apr 1 14:33:16 -03 2022
> | [1.974450] vme_user: VME User Space Access Driver
> | [ 1.975405] vme_user: No cards, skipping registration
> 
> Do you think it would be interesting for a future patch to provide
> some output when drivers from the staging tree are present in the
> running kernel image?

If you can figure out how to do so, that would be interesting to see.

thanks,

greg k-h
