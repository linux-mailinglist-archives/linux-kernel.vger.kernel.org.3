Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4354AB8AE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245362AbiBGKZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355437AbiBGKSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 05:18:36 -0500
X-Greylist: delayed 440 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 02:18:33 PST
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88D5AC0401C0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 02:18:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE3846D;
        Mon,  7 Feb 2022 02:11:12 -0800 (PST)
Received: from bogus (unknown [10.57.41.150])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A3223F718;
        Mon,  7 Feb 2022 02:11:11 -0800 (PST)
Date:   Mon, 7 Feb 2022 10:10:24 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Wojciech Bartczak <wbartczak@marvell.com>
Cc:     cristian.marussi@arm.com, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org, sbalcerak@marvell.com
Subject: Re: Mixing SCMI and ACPI?
Message-ID: <20220207101024.rpcbbhtd6y6g7ykc@bogus>
References: <20220204142150.glsu6ujjtqpcktjp@bogus>
 <20220204181641.28176-1-wbartczak@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204181641.28176-1-wbartczak@marvell.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 10:16:41AM -0800, Wojciech Bartczak wrote:
>
> I should've explained it slightly better. Of course SCMI does great work
> when managing the clocks. However, what the intent here is the SCMI
> clocks register itself nicely into common clk framework.
> I don't intend to change the clock. SCP in my case is invariant source.
> Hence, no need for ASL methods. I just want to read given clock and have it
> registered in clk framework.
> Reason for that is simple, there's a good code in SCMI. I don't
> want to create own driver for that. I just have to be able to start SCMI
> when only source of hardware information is ACPI/UEFI.
>

I don't agree, more details below.

> This is still most specific thing I could have found on the internet.
> So, to clear up the clouds about my idea.
>
> I have platform with UEFI/ACPI only. I want my clocks to be registered.

Just to read clock rates ?

> So, I use SCMI. The framework needs bindings for proper registration.
> Instead using DT approach:
>
> firmware {
> 	scmi {
> 		compatible = "arm-scmi";
> 		/* ... */
>
> 		clks: protocol@14 {
> 			reg = <0x14>;
> 			#clock-cells = <1>;
> 		}
> 	}
> }
>
> I add ACPI match table to SCMI code and present it with matching ACPI
> tables. It might look like this:
>
> Scope (_SB) {
> 	Device (ARMSCMI) {
> 		Name (_HID, "ASCM0001")
> 		Name (_UID, 0)
>
> 		Method (_STA) {
> 			Return (0xF)
> 		}
>
> 		Device (CLKS) {
> 			Name (_ADR, 0x14)
> 			Name (_UID, 0)
>
> 			Method (_STA) {
> 				Return (0xF)
> 			}
> 		}
> 	}
> }
>

A *BIG FAT NACK* for this approach. SCMI is not intended to be used like
this on ACPI. Since ACPI has not support for clocks, you can't just do
something like above for clocks and rest of the SCMI support in the standard
ACPI methods. 

> Then SCMI registers the clocks protocol and does remaining magic.
>

Sure, but what is the issue if you don't have this SCMI clock support
in ACPI system ? Can you provide details as what is failing ?

--
Regards,
Sudeep
