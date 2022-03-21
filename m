Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289364E2708
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347640AbiCUM5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347637AbiCUM5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:57:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56FDF3F9B;
        Mon, 21 Mar 2022 05:56:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 443C46116D;
        Mon, 21 Mar 2022 12:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8857DC340E8;
        Mon, 21 Mar 2022 12:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647867367;
        bh=UVhMNYZt0v0YxEbud2ZYFEHu/6nOoe53r2esS6kiD0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hqbc7UBUyBD77c/D5TtQyEQy4GGpnKP5jWUzGKYAYN6gsntYzczG867BTxgnNKk8Y
         ZOqbfqTsZ2Q9W4+1fVCZPeMp/GgbJ4YhERECrS9rGOVk5HW94B2voaOczK3CWExzxq
         o+/h+VPbI4VfnlcTZteOIGj4Y+Oijtv5us9olN3inJGQl8vErA20Z+nVXEaDZ0PhJa
         YxZF0JhwX4Xwvp7wv3qgEItIptTfBg+MFfMcHyDVXhdPoyBuwnrliYgy0pNgw1E8xj
         19mltPvrk826KtvdbnG2k6/IcHrp2MBzkDsNJxv8+ed1imw7/2MzohnOZhyPM9cq7t
         wspzZkYvxYhTw==
Received: by pali.im (Postfix)
        id 85FF5A5B; Mon, 21 Mar 2022 13:56:04 +0100 (CET)
Date:   Mon, 21 Mar 2022 13:56:04 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Robert Marko <robert.marko@sartura.hr>,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        marek.behun@nic.cz
Subject: Re: [PATCH 1/2] arm64: dts: uDPU: update partition table
Message-ID: <20220321125604.gjqxxv7jxlons4b4@pali>
References: <20220321121728.414839-1-robert.marko@sartura.hr>
 <Yjhyg5cNe5KZ6SOp@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yjhyg5cNe5KZ6SOp@lunn.ch>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 March 2022 13:41:39 Andrew Lunn wrote:
> On Mon, Mar 21, 2022 at 01:17:27PM +0100, Robert Marko wrote:
> > Partition currently called "uboot" does not only contain U-boot, but
> > rather it contains TF-A, U-boot and U-boot environment.
> > 
> > So, to avoid accidentally deleting the U-boot environment which is
> > located at 0x180000 split the partition.
> > 
> > "uboot" is not the correct name as you can't boot these boards with U-boot
> > only, TF-A must be present as well, so rename the "uboot" partition to
> > "firmware".
> 
> Are there any ABI issues here? If these names are being used
> somewhere, you are potentially breaking the boot. At minimum, i would
> like to see something in the commit message which indicates you have
> considered this and why you don't expect it to be a problem.

Hello! Similar change/fix was done also for Turris Mox DTS file:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a9d9bfcadfb43b856dbcf9419de75f7420d5a225

Difference between uDPU and Mox is that uDPU has concatenated
CM3 firmware (called secure firmware) and A53 firmware (TF-A + u-boot)
into one binary, Mox has these two parts separated. So uDPU partition
should be called just firmware.

Same partition name "firmware" is used also on another A3720 device
Espressobin. But here partition names are filled/injected into DTB at
runtime by bootloader.

So I think this change for uDPU looks reasonable. Partition name
"u-boot" is used for flashing u-boot binary and renaming it could really
fix automated scripts to stop flashing into SPI NOR something which
makes device unbootable.
