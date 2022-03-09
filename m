Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579774D3D90
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 00:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238879AbiCIXbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 18:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238870AbiCIXbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 18:31:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA282117C98
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 15:30:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 922B761CE2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 23:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B21C340EE;
        Wed,  9 Mar 2022 23:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646868601;
        bh=HRZre433HPB4VoPyEcnIsBwwBfmflRQBMcNjT1al0f4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rM7Dczat29WwsOWxoL8bmQ8FHPO1f8WMCgrRU9NUsxagOwoXi87afRjQ/gl3usl+L
         tfhNO7XkyhRuVN8mnJdn3rNKn763jV4bRTtL14LX5Cx4h5guRWiikICQzuP2ksbToo
         I21ocOUIAH27jOTaWzZpcugmWOJdA+6iQ7U5iZWs=
Date:   Thu, 10 Mar 2022 00:29:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Won Chung <wonchung@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] driver core: Add sysfs support for physical location
 of a device
Message-ID: <Yik4dH/oApemmgzm@kroah.com>
References: <20220309230607.2005304-1-wonchung@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309230607.2005304-1-wonchung@google.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 11:06:07PM +0000, Won Chung wrote:
> When ACPI table includes _PLD fields for a device, create a new
> directory (physical_location) in sysfs to share _PLD fields.
> 
> Currently without PLD information, when there are multiple of same
> devices, it is hard to distinguish which device corresponds to which
> physical device at which location. For example, when there are two Type
> C connectors, it is hard to find out which connector corresponds to the
> Type C port on the left panel versus the Type C port on the right panel.
> With PLD information provided, we can determine which specific device at
> which location is doing what.
> 
> _PLD output includes much more fields, but only generic fields are added
> and exposed to sysfs, so that non-ACPI devices can also support it in
> the future. The minimal generic fields needed for locating a device are
> the following.
> - panel
> - vertical_position
> - horizontal_position
> - dock
> - lid
> 
> Signed-off-by: Won Chung <wonchung@google.com>
> ---
> 
> Changes from v3
> - Move dev_add_physical_location() and dev_attr_physical_location_group
>   to driver/base/physical_location.h.
> - Use pointer and reorder physical_location in struct device to pack its
>   bytes. (checked using pahole)

You forgot to test your code and see what happens when you remove a
device :(

