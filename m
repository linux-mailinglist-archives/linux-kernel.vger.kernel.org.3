Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C7E482B56
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 14:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbiABNIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 08:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiABNIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 08:08:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F6BC061761;
        Sun,  2 Jan 2022 05:08:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42F95B80D65;
        Sun,  2 Jan 2022 13:08:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F28C36AEE;
        Sun,  2 Jan 2022 13:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641128911;
        bh=d8wVlK4N5UUP87/zUGPNwB99lAdpUwHDMgwI0siLGPE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KJCPAILY6bad6cOf2efNIjBQR3Rc2NI6zZhhEPRzw3fuVHslukGuXRWw2s7YuGa4x
         ZnfmV+LTm7XBziASBRSljiIVSwLRUhADT0W3rgVs8Tyu2jZpMdh4ywYI29I+yf9c53
         8iB4YsEJHMcxDQhB5kGBJZFs9QLb2GDIZ3U12dPEV7pnPfm0l8LZeFXo6XscQU83eN
         l8ik2/1+DpIp9vuPXp83aB+0OSFGcHCI74W774vlxbdUhN1TwZYIQAWt7/DiLhqKbu
         6wBuUHovd2bAE0SXioHn+gmfQ00ELYlJGs9t4YXOZYGBVV75OIt+Td05ci+W0/6r96
         nieE1JmM80MCA==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1n40b7-00FUYE-AT; Sun, 02 Jan 2022 13:08:29 +0000
MIME-Version: 1.0
Date:   Sun, 02 Jan 2022 13:08:28 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Leo Li <leoyang.li@nxp.com>,
        Biwen Li <biwen.li@nxp.com>, "Z.Q. Hou" <zhiqiang.hou@nxp.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 devicetree] Revert "arm64: dts: freescale: Fix
 'interrupt-map' parent address cells"
In-Reply-To: <20211231181350.qwfnrwvdfnfssdjt@skbuf>
References: <20211214135852.2934670-1-vladimir.oltean@nxp.com>
 <20211231181350.qwfnrwvdfnfssdjt@skbuf>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <c5b9cec617100b891b7fceaee8655ba8@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: vladimir.oltean@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, leoyang.li@nxp.com, biwen.li@nxp.com, zhiqiang.hou@nxp.com, kurt@linutronix.de, linux@rasmusvillemoes.dk
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-31 18:13, Vladimir Oltean wrote:
> Hello,
> 
> On Tue, Dec 14, 2021 at 03:58:52PM +0200, Vladimir Oltean wrote:
>> This reverts commit 869f0ec048dc8fd88c0b2003373bd985795179fb. That
>> updated the expected device tree binding format for the ls-extirq
>> driver, without also updating the parsing code (ls_extirq_parse_map)
>> to the new format.
>> 
>> The context is that the ls-extirq driver uses the standard
>> "interrupt-map" OF property in a non-standard way, as suggested by
>> Rob Herring during review:
>> https://lore.kernel.org/lkml/20190927161118.GA19333@bogus/
>> 
>> This has turned out to be problematic, as Marc Zyngier discovered
>> through commit 041284181226 ("of/irq: Allow matching of an 
>> interrupt-map
>> local to an interrupt controller"), later fixed through commit
>> de4adddcbcc2 ("of/irq: Add a quirk for controllers with their own
>> definition of interrupt-map"). Marc's position, expressed on multiple
>> opportunities, is that:
>> 
>> (a) [ making private use of the reserved "interrupt-map" name in a
>>     driver ] "is wrong, by the very letter of what an interrupt-map
>>     means. If the interrupt map points to an interrupt controller,
>>     that's the target for the interrupt."
>> https://lore.kernel.org/lkml/87k0g8jlmg.wl-maz@kernel.org/
>> 
>> (b) [ updating the driver's bindings to accept a non-reserved name for
>>     this property, as an alternative, is ] "is totally pointless. 
>> These
>>     machines have been in the wild for years, and existing DTs will be
>>     there *forever*."
>> https://lore.kernel.org/lkml/87ilvrk1r0.wl-maz@kernel.org/
>> 
>> Considering the above, the Linux kernel has quirks in place to deal 
>> with
>> the ls-extirq's non-standard use of the "interrupt-map". These quirks
>> may be needed in other operating systems that consume this device 
>> tree,
>> yet this is seen as the only viable solution.
>> 
>> Therefore, the premise of the patch being reverted here is invalid.
>> It doesn't matter whether the driver, in its non-standard use of the
>> property, complies to the standard format or not, since this property
>> isn't expected to be used for interrupt translation by the core.
>> 
>> This change restores LS1088A, LS2088A/LS2085A and LX2160A to their
>> previous bindings, which allows these systems to continue to use
>> external interrupt lines with the correct polarity.
>> 
>> Fixes: 869f0ec048dc ("arm64: dts: freescale: Fix 'interrupt-map' 
>> parent address cells")
>> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
>> ---
>> v1->v2: remove the other 9 patches that rename "interrupt-map" to
>>         "fsl,extirq-map", at Marc's suggestion.
> 
> Could this patch be considered for merging in v5.16? The problem is
> going to be quite a bit more severe and tricky to fix otherwise. 
> Thanks.

FWIW:

Acked-by: Marc Zyngier <maz@kernel.org>

Rob, Shawn, can you please queue this as an urgent fix for 5.16?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
