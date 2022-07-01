Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB2E562C17
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 08:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbiGAG5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 02:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGAG5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 02:57:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCBD599FE;
        Thu, 30 Jun 2022 23:57:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2862DB82E3B;
        Fri,  1 Jul 2022 06:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43215C3411E;
        Fri,  1 Jul 2022 06:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656658633;
        bh=2BimP7+fL1GUW8UT2q+nV98iiK84sXxO3qo4dUxkW1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SXri5mU5myjlSKs2E4HsxLTYeXr35taERzStvKpdWzGc/qm0uBTbY98C6SxnYEiXq
         cjeuZeZtb8kvcrClMjhsTtJChVvDe9kVb8lGR7D4of42huJK5MXBUWwoVfCaZ9npM8
         5R5t8sxmBhja3EdkmQRY9scHCa4K5zn1A5izczxY=
Date:   Fri, 1 Jul 2022 08:57:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-pm@vger.kernel.org, Richard Gong <richard.gong@amd.com>,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/10] HID: usbhid: Set USB mice as s2idle wakeup
 resources
Message-ID: <Yr6ax+aEuNaB98BR@kroah.com>
References: <20220701023328.2783-1-mario.limonciello@amd.com>
 <20220701023328.2783-10-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701023328.2783-10-mario.limonciello@amd.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 09:33:28PM -0500, Mario Limonciello wrote:
> The USB HID transport layer doesn't configure mice for wakeup by default.
> Thus users can not wake system from s2idle via USB mouse. However, users
> can wake the same system from Modern Standby on Windows with the same USB
> mouse.
> 
> Microsoft documentation indicates that all USB mice and touchpads should
> be waking the system from Modern Standby.
> 
> Many people who have used Windows on a PC that supports Modern Standby
> have an expectation that s2idle wakeup sources should behave the same in
> Linux. For example if your PC is configured "dual-boot" and is used docked
> it's very common to wakeup by using a USB mouse connected to your dock in
> Windows. Switching to Linux this is not enabled by default and you'll
> need to manually turn it on or use a different wakeup source than you did
> for Windows.
> 
> Changes for wakeups have been made in other subsystems such as the PS/2
> keyboard driver which align how wakeup sources in Linux and Modern Standby
> in Windows behave. To align expectations from users on USB mice, make this
> behavior the same when the system is configured both by the OEM and the
> user to use s2idle in Linux.
> 
> This means that at a minimum supported mice will be able to wakeup by
> clicking a button. If the USB mouse is powered over the s2idle cycle (such
> as a wireless mouse with a battery) it's also possible that moving it
> may wake up the system.  This is HW dependent behavior.
> 
> If the user sets the system to use S3 instead of s2idle, or the OEM ships
> the system defaulting to S3, this behavior will not be turned on by
> default.
> 
> Users who have a modern laptop that supports s2idle and use s2idle but
> prefer the previous Linux kernel behavior can turn this off via a udev
> rule.
> 
> Link: https://docs.microsoft.com/en-us/windows-hardware/design/device-experiences/modern-standby-wake-sources#input-devices-1
> Link: https://lore.kernel.org/linux-usb/20220404214557.3329796-1-richard.gong@amd.com/
> Suggested-by: Richard Gong <richard.gong@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> More people keep coming to us confused that they couldn't wake a Linux system
> up from sleep using a mouse, so this patch is being revived.
> 
> Microsoft documentation doesn't indicate any allowlist for this behavior, and
> they actually prescribe it for all USB mice and touchpads.

Note, this is very different than older versions of Windows.  Any idea
when this behavior and prescription changed?

Also, how are you going to handle the differences between "internal" and
"external" USB mice and touchpads?  The microsoft link above only
references external USB and Bluetooth devices, not internal ones.

> 
> changes from v2->v3:
>  * Use `pm_suspend_preferred_s2idle`
>  * Drop now unnecessary acpi.h header inclusion
>  * Update commit message
>  * Adjust comments from v2 per thread
> 
> changes from v1->v2:
>  * Resubmit by Mario
>  * Update commit message
>  * Only activate on systems configured by user and OEM for using s2idle
> ---
>  drivers/hid/usbhid/hid-core.c | 37 ++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)

Where are patches 1-9 of this series?

confused,

greg k-h
