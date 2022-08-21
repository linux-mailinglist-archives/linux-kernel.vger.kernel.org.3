Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF28659B433
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 16:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiHUOCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 10:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiHUOBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 10:01:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8AA24968;
        Sun, 21 Aug 2022 07:01:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E80260ED3;
        Sun, 21 Aug 2022 14:01:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A1AC433C1;
        Sun, 21 Aug 2022 14:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661090466;
        bh=0k2zh45ukdQfjSibWwXrqGwdFRWofhv4XHMJZjqOtp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c/6VFKEhJiCIvysZjWrhxXgpSXUVwFwFrosz10dp4vugPPHye5D6Te45gL1BkGzJ8
         MAPQiKLK0MjEZ9PtJMp+Hq5+OV3IP6KyumZxXVon8ALJS16rN2Iv2m0VFfueaD2fm8
         iaMDQOe7h5qz0yue3hSt1Bfs6T1i5RP7qd5V0GtU=
Date:   Sun, 21 Aug 2022 16:01:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vimal Kumar <vimal.kumar32@gmail.com>
Cc:     chinmoyghosh2001@gmail.com, Mintu Patel <mintupatel89@gmail.com>,
        Vishal Badole <badolevishal1116@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PM: runtime: Add support to disable wakeup sources
Message-ID: <YwI6n+PkFZZV/FW6@kroah.com>
References: <20220821134533.22901-1-vimal.kumar32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220821134533.22901-1-vimal.kumar32@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 21, 2022 at 07:15:32PM +0530, Vimal Kumar wrote:
> User could find many wakeup sources available in the bsp, which
> they won't be using. Currently users can only get the status and
> list of enabled wakeup sources, but users can't disable it runtime.
> It's very difficult to find the driver for each wakeup sources from
> where it's getting enabled and make the changes for disabling it.
> 
> This will help users to disable any wakeup sources at runtime,
> avoiding any code change and re-compilation. A new class attribute
> "disable_ws" will be added in the wakeup calss. If user want to disable
> any wakeup sources, user need to find the wakeup dev node associated
> with the particular wakeup source and write the devnode name to the
> class attribute "disable_ws".
> 
> Example:
> Need to disable the wakeup source '1c08000.qcom,pcie'. The dev node
> associated with this wakeup source is:
> cat /sys/class/wakeup3/name ==> "1c08000.qcom,pcie", then for disabling
> this wakeup source :
> 	echo wakeup3 > /sys/class/wakeup/disable_ws
> 
> Co-developed-by: Mintu Patel <mintupatel89@gmail.com>
> Signed-off-by: Mintu Patel <mintupatel89@gmail.com>
> Co-developed-by: Vishal Badole <badolevishal1116@gmail.com>
> Signed-off-by: Vishal Badole <badolevishal1116@gmail.com>
> Signed-off-by: Vimal Kumar <vimal.kumar32@gmail.com>

That's a lot of gmail accounts, no "company" accounts?  :)

> ---
>  drivers/base/power/wakeup_stats.c | 63 ++++++++++++++++++++++++++++++-

You need a Documentation/ABI/ entry for any new sysfs file so we can
properly review this and support it over time.

thanks,

greg k-h
