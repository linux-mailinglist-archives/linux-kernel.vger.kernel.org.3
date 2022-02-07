Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C284ACD7F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344046AbiBHBGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237274AbiBHABK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 19:01:10 -0500
X-Greylist: delayed 1405 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 16:01:09 PST
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E75C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 16:01:08 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 217H4HOE018958;
        Mon, 7 Feb 2022 15:37:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pfpt0220; bh=2GtHM1eGlNpKVq9KM0Vi+3v3pnVheuIZbnPmvAsFOu8=;
 b=fMyxtERUTt+89o/sRVLzAKt3hXqZX4xbP9xtb0CLUVOAp2qx7voNVvDxE3c4eOz97EgK
 Vk2M2Qz4DPPYxqCTTRwaZbrfoe5EUeJkDWd3/H7v0B7AEQeQBm3jHT90n8UCQ6kU5CWl
 /a7FBvorPRDWda9aQzyU22t57Ig6iwPcqc/B30z1d2DI1li/m2aHvBKyh0WURfE0nttu
 qg+7JE7CfbAXJXWODnbF1UfY1x+Fovqer++zJ2bXA6PcFs6TMVF850XozvonpbQCV8xN
 jSo4asgU/JIrSGqGVYw5tTzsJVud8t4jsrFLXHQL97Oa60oY1bdCWyomoQ8zvDr3qiZH lQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3e3095unuf-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 15:37:34 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 7 Feb
 2022 15:37:33 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Feb 2022 15:37:33 -0800
Received: from proliant-dl360 (unknown [10.110.150.170])
        by maili.marvell.com (Postfix) with ESMTP id E5ADA3F7078;
        Mon,  7 Feb 2022 15:37:32 -0800 (PST)
Date:   Mon, 7 Feb 2022 15:37:32 -0800
From:   Wojciech Bartczak <wbartczak@marvell.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <sbalcerak@marvell.com>
Subject: Re: Mixing SCMI and ACPI?
Message-ID: <20220207233732.GA4824@proliant-dl360>
References: <20220204142150.glsu6ujjtqpcktjp@bogus>
 <20220204181641.28176-1-wbartczak@marvell.com>
 <20220207101024.rpcbbhtd6y6g7ykc@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220207101024.rpcbbhtd6y6g7ykc@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: MT4SyCfZZNZDlzTiGLYPNH1Cpr03qfS7
X-Proofpoint-GUID: MT4SyCfZZNZDlzTiGLYPNH1Cpr03qfS7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-07_07,2022-02-07_02,2021-12-02_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 10:10:24AM +0000, Sudeep Holla wrote:
> On Fri, Feb 04, 2022 at 10:16:41AM -0800, Wojciech Bartczak wrote:
> >
> > I should've explained it slightly better. Of course SCMI does great work
> > when managing the clocks. However, what the intent here is the SCMI
> > clocks register itself nicely into common clk framework.
> > I don't intend to change the clock. SCP in my case is invariant source.
> > Hence, no need for ASL methods. I just want to read given clock and have it
> > registered in clk framework.
> > Reason for that is simple, there's a good code in SCMI. I don't
> > want to create own driver for that. I just have to be able to start SCMI
> > when only source of hardware information is ACPI/UEFI.
> >
> 
> I don't agree, more details below.
> 
> > This is still most specific thing I could have found on the internet.
> > So, to clear up the clouds about my idea.
> >
> > I have platform with UEFI/ACPI only. I want my clocks to be registered.
> 
> Just to read clock rates ?
> 
> > So, I use SCMI. The framework needs bindings for proper registration.
> > Instead using DT approach:
> >
> > firmware {
> > 	scmi {
> > 		compatible = "arm-scmi";
> > 		/* ... */
> >
> > 		clks: protocol@14 {
> > 			reg = <0x14>;
> > 			#clock-cells = <1>;
> > 		}
> > 	}
> > }
> >
> > I add ACPI match table to SCMI code and present it with matching ACPI
> > tables. It might look like this:
> >
> > Scope (_SB) {
> > 	Device (ARMSCMI) {
> > 		Name (_HID, "ASCM0001")
> > 		Name (_UID, 0)
> >
> > 		Method (_STA) {
> > 			Return (0xF)
> > 		}
> >
> > 		Device (CLKS) {
> > 			Name (_ADR, 0x14)
> > 			Name (_UID, 0)
> >
> > 			Method (_STA) {
> > 				Return (0xF)
> > 			}
> > 		}
> > 	}
> > }
> >
> 
> A *BIG FAT NACK* for this approach. SCMI is not intended to be used like
> this on ACPI. Since ACPI has not support for clocks, you can't just do
> something like above for clocks and rest of the SCMI support in the standard
> ACPI methods. 
> 
> > Then SCMI registers the clocks protocol and does remaining magic.
> >
> 
> Sure, but what is the issue if you don't have this SCMI clock support
> in ACPI system ? Can you provide details as what is failing ?
> 
I have at least one driver that requires the clock information to do
fancy tuning and clocks division 'drivers/mmc/host/cavium*.[ch]'.
Without the clock info MMC driver is useless. Moreover clock is configurable,
so I can't stick with sane default. That said, this is no on the Kernel
to solve, but on me and the IP designer :). Btw. this is just example,
there are more gems in this crown.

I understand my approach is convoluted. I also don't agree with it
completely. The goal was to have SCMI to minimize porting effort for
some drivers (MMC). At least until full ACPI implementation.
Mostly the ones that use the common clk framework.
Additionally, maybe have some extras for the platform.
SCMI could provide clocks, drivers can read it as usually.
Nevertheless, more I think about it then more I see all the nasty side
effects of this approach. I completely agree with NACK here.

Over a weekend I did additional research. I have found this post

https://lore.kernel.org/lkml/CABe79T6zQ_7Ycws5b=xaQ3edpVn1QPQyWd9p24eqLGpYbdtt0A@mail.gmail.com/#t

(Thanks Google for keeping it on 10th page).

This sheds some light on the topic. I was able to put my hands on
"Server Base System Architecture" and "Arm Base Boot Requirements".
This gives me extra ideas how to proceed.

Thank you for your help here! I think I will drop the topic at this
moment.

Kind regards,
Wojciech.

> --
> Regards,
> Sudeep
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
