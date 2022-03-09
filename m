Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79884D2B7F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbiCIJNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiCIJMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:12:53 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 083E516DAC1;
        Wed,  9 Mar 2022 01:11:54 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5E87280C1;
        Wed,  9 Mar 2022 09:10:30 +0000 (UTC)
Date:   Wed, 9 Mar 2022 11:11:52 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, jan.kiszka@siemens.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: k3-am65: disable optional
 peripherals by default
Message-ID: <YihvWFdr1cT7cyk5@atomide.com>
References: <20220203140240.973690-1-matthias.schiffer@ew.tq-group.com>
 <20220204143108.653qk2ihnlhsr5aa@prior>
 <YgDCLaBHA3DDQAUd@atomide.com>
 <5944ba0ce568eaf507917799b1dfd89a3d0ca492.camel@ew.tq-group.com>
 <YgEBml9HvFzSl289@atomide.com>
 <9923df6525212389b86cb635624bcfb5c27a8bc5.camel@ew.tq-group.com>
 <YgJZbdOlazrde7O/@atomide.com>
 <1356e93cd5b101c3d896e35250c66959ed631544.camel@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1356e93cd5b101c3d896e35250c66959ed631544.camel@ew.tq-group.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Matthias Schiffer <matthias.schiffer@ew.tq-group.com> [220228 10:29]:
> AFAICT, disabling non-operatational devices in the board DTS instead of
> the SoC DTSI is worse than the alternatives in every way:
> 
> - Verbose board DTS: You have to think about all the devices that exist
> in the SoC, not just the ones you want to use
> - Adding new nodes without `status = "disabled" to SoC DTSI can
> potentially cause issues on dependent boards
> - It doesn't solve the issues that not having `status = "disabled"` in
> the DTSI is supposed to solve

My preference is the least amount of tinkering in the dts files
naturally :) It really does not matter if the extra dts churn is to
enable or disable devices, it should not be needed at all.

To summarize, my main point really is the following:

There should not be any need to tag the SoC internal devices with anything
in the dts files. The device drivers should be able to just deal with the
situation. IMO devices should be tagged with disabled or reserved when
they are not accessible for example because of being used by secure mode
for example. If the the status needs to be set to anything, it really is
a symptom of incomplete handling somewhere.

Regards,

Tony
