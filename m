Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3184C546A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 08:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiBZHfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 02:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiBZHe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 02:34:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F981A1C68
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 23:34:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3ABF3B80E98
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 07:34:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580D6C340E8;
        Sat, 26 Feb 2022 07:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645860862;
        bh=x+wo1L1aJUAYn5fcXXPZlYgwba8gwdBSorr68YAdNBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ktn/rCvPBw3Vwpx79F2m7jQc9Vo4cfZ7RL/38/WMmp1TvwUjQHtJxyaBQ5k6vrB/9
         qfjMUARC9pgOAsJUg++jMH0ZfKBv/G7zFL+Vab3iKSrIqMmXzDxyAhZukRMJNFeABn
         MdCGulA9YNsXmFpj9m/wtyejo99U2Eb9tMbFecdU=
Date:   Sat, 26 Feb 2022 08:34:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yusuf Khan <yusisamerican@gmail.com>
Cc:     linux-kernel@vger.kernel.org, jasowang@redhat.com,
        mikelley@microsoft.com, mst@redhat.com, javier@javigon.com,
        arnd@arndb.de, will@kernel.org, axboe@kernel.dk,
        bjorn.andersson@linaro.org
Subject: Re: [PATCH v2] drivers: ddcci: upstream DDCCI driver
Message-ID: <YhnX+Shp7nRkbvSG@kroah.com>
References: <20220226040429.1035368-1-yusisamerican@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220226040429.1035368-1-yusisamerican@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 08:04:29PM -0800, Yusuf Khan wrote:
> This patch upstreams the DDCCI driver by Christoph Grenz into
> the kernel. The original gitlab page is loacted at https://gitlab
> .com/ddcci-driver-linux/ddcci-driver-linux/-/tree/master.
> 
> Signed-off-by: Yusuf Khan <yusisamerican@gmail.com>
> ---
>  drivers/Kconfig                 |    2 +
>  drivers/Makefile                |    1 +
>  drivers/ddcci/Kconfig           |    5 +
>  drivers/ddcci/Makefile          |    3 +
>  drivers/ddcci/ddcci-backlight.c |  411 +++++++
>  drivers/ddcci/ddcci.c           | 1887 +++++++++++++++++++++++++++++++
>  include/linux/ddcci.h           |  164 +++

Also, you create a lot of sysfs files here, yet document none of them in
Documentation/ABI/ which will make tools like scripts/get_abi.pl
unhappy.  Please fix that in your next submission.

thanks,

greg k-h
