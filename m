Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B765357FBBE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbiGYIv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbiGYIvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:51:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E06F140C0;
        Mon, 25 Jul 2022 01:51:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE32361214;
        Mon, 25 Jul 2022 08:51:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBC7C341CF;
        Mon, 25 Jul 2022 08:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658739108;
        bh=PmutZiEng6MMXh9O1CX9eVOw0OqozW+N1qFKVKcmT2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y/4+yLSYUP+6YC7fwPcXNVSD91v96gKZaF7dCwly9h8Yurotuv+7vY7RO/+k72jf0
         dHasYr2It6g7uB+xcqEYO0xJT/xq/D4vQMgZZFn3KGgZrVIEAk3oCh3qx5K9ahdp1o
         Zq+qeQR33fe3iz0O6FeuQurRd99Cqqpj+yZVCBhQ=
Date:   Mon, 25 Jul 2022 10:51:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexey Klimov <klimov.linux@gmail.com>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        linux@roeck-us.net, oneukum@suse.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, atishp@rivosinc.com,
        atishp@atishpatra.org, yury.norov@gmail.com, aklimov@redhat.com,
        atomlin@redhat.com
Subject: Re: [PATCH v5] watchdog: add driver for StreamLabs USB watchdog
 device
Message-ID: <Yt5Zn9cXDe9/F9RJ@kroah.com>
References: <20220725030605.1808710-1-klimov.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725030605.1808710-1-klimov.linux@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 04:06:05AM +0100, Alexey Klimov wrote:
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> +			__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +

Meta-comment about watchdog drivers, this is per-driver, not per-device,
which does not make sense for when these devices are on removable busses
where you can have multiple ones.

I don't suggest changing this (as it follows the current style of other
watchdog drivers), but perhaps a sysfs attribute for watchdog devices
can do the same thing in the future so you can do this on a per-device
basis.

Anyway, driver looks good to me, nice work!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
