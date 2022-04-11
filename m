Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557804FBFEB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347528AbiDKPNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235305AbiDKPNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:13:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BE231504;
        Mon, 11 Apr 2022 08:10:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95DA5B81647;
        Mon, 11 Apr 2022 15:10:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6219DC385A4;
        Mon, 11 Apr 2022 15:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649689854;
        bh=nOaqHR4Auy32TpGFswmBBi1UTnrUqfpcMH6OkfYEumg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=lZqrr6xfHDecpR/inPcf4XloqyTpx9v1RY04vVT+LQuN8lEXEGabVJxrTIzQYSqyV
         eeKnMePXIo8OsZN1CNcjxoa8UBrPQaXvvWgyJ3SxjCc0x3WH7lQMPVOPsWjvke8Rj3
         jsnmiVk28wwaHcJXyJDZYz3Ql+O3Jsjn71fe4lRGZdvnFfB9UGoXl2779sX7OMs8ah
         VnpfdPzNGPFbDEP7frwX/3b/Uarn9g+FfwBqSObcf4jAqmb3twpCiZO+Zy6yRF1HQV
         hxjnm1+BvSeqWVLIZDuGc0dnbPj+jXJVi5Wz97kmt1saI1qhjKz81gUseIm/LlyMJm
         Ced+1Z+qVmb3g==
Date:   Mon, 11 Apr 2022 17:10:50 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     frank zago <frank@zago.net>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: Add support for Mega World controller force
 feedback
In-Reply-To: <20220209052807.138007-1-frank@zago.net>
Message-ID: <nycvar.YFH.7.76.2204111710040.30217@cbobk.fhfr.pm>
References: <20220209052807.138007-1-frank@zago.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Feb 2022, frank zago wrote:

> This patch adds support for one of the several Mega World USB game
> controller with integrated force feedback. It is a HID based
> memory-less game controller, with a weak motor on the left, and a
> strong one on the right.
> 
> Signed-off-by: frank zago <frank@zago.net>
> ---
>  drivers/hid/Kconfig         |  14 ++++
>  drivers/hid/Makefile        |   1 +
>  drivers/hid/hid-ids.h       |   3 +
>  drivers/hid/hid-megaworld.c | 136 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 154 insertions(+)
>  create mode 100644 drivers/hid/hid-megaworld.c
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index f5544157576c..2344830d3680 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -684,6 +684,20 @@ config HID_MAYFLASH
>  	Say Y here if you have HJZ Mayflash PS3 game controller adapters
>  	and want to enable force feedback support.
>  
> +config HID_MEGAWORLD
> +	tristate "Mega World based game controller support"
> +	depends on HID
> +	help
> +	  Say Y here if you have a Mega World based game controller.
> +
> +config MEGAWORLD_FF
> +	bool "Mega World based game controller force feedback support"
> +	depends on HID_MEGAWORLD
> +	select INPUT_FF_MEMLESS
> +	help
> +	  Say Y here if you have a Mega World based game controller and want
> +	  to have force feedback support for it.
> +

Hi Frank,

as the *only* functionality provided by the driver seems to be the force 
feedback, does it really make sense to decouple the two options?

Thanks,

-- 
Jiri Kosina
SUSE Labs

