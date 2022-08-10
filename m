Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EC558EB3A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 13:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbiHJL2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 07:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiHJL2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:28:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9149C61132
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 04:28:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D494B81BAF
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 11:28:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0FDC433C1;
        Wed, 10 Aug 2022 11:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660130914;
        bh=7h6K7rpvx1SB5n4b7F01MubzWU7UyzF7WWT5dAEHmhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R/dnUrRo5CMsD/VmkeTW/UhVVKja+qWP7WIp6aMk+nDNCwsbhpe+CPWgSCLmuYLaU
         Jx7jwMNo+GPgcHynlKpbkUsTv5SWXiiSpcQt/HeAG21/lBj0oSN8Z8zxfzf6H56E63
         PiOQtUY6S30lcpAyyr432hkf+SJEJaKz0d/nBxWbBWfpeLLSTn4YPOKynJmg0nqqed
         qriakzLqseRzZQRtNQgfURPSdb+ylsJzE7j/3AUMDrkOKqqLn/JlvPeyeDfacQMw+p
         NK6vdHd9gmQR4pcTQ/MGkOPzHhOh+kug1/AxVB35HBtN7rh61UUmsMftyFhb6sO0Rc
         F4y69BudNZhKg==
Date:   Wed, 10 Aug 2022 12:28:29 +0100
From:   Lee Jones <lee@kernel.org>
To:     =?utf-8?Q?Micha=C5=82?= Oleszczyk <oleszczyk.m@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?Q?Micha=C5=82?= Oleszczyk <m.oleszczyk@grinn-global.com>
Subject: Re: [PATCH v2] mfd: core: Delete corresponding OF node entries from
 list on  MFD removal
Message-ID: <YvOWXTzT7uIhVMBI@google.com>
References: <20220809060336.31892-1-m.oleszczyk@grinn-global.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220809060336.31892-1-m.oleszczyk@grinn-global.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Aug 2022, Michał Oleszczyk wrote:

> From: Michal Oleszczyk <oleszczyk.m@gmail.com>
> 
> When we consider MFD which implements hotplug (e.g. USB hotplug
> driver based on product and vendor IDs) functionality it turns out
> that its sub-devices are correctly matched with corresponding device
> tree nodes only at the first time. When physical device reboots
> or is replugged (and MFD driver is disconnected and probed back
> again) all sub-devices fails in mfd_add_device() with error
> 'Failed to locate of_node'.
> 
> The reason of that behavior is that when any MFD sub-device is
> created for the first time (and matched with device tree node) it
> is added to the mfd_of_node_list. It looks like this list is never
> cleaned even if devices added there are intentionally removed from
> the system. So when MFD device is replugged and all sub-devices
> are matched with their device tree nodes again they fail as matched
> nodes already exist in mfd_of_node_list. In other words current
> implementation does not support MFD with hotplug feature.
> 
> This commit extends MFD core for hotplugging support by removing
> appropriate OF node entry from mfd_of_node_list when corresponding
> device is removed from the system. Thanks to that when device is
> added once again it can be matched with its device tree node
> successfully.
> 
> Signed-off-by: Michal Oleszczyk <oleszczyk.m@gmail.com>
> ---
> 
> Changes in v2: removing unused variable declaration.
> 
>  drivers/mfd/mfd-core.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
