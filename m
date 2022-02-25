Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A1B4C43C1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 12:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240160AbiBYLja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 06:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239111AbiBYLj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 06:39:29 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC0779392;
        Fri, 25 Feb 2022 03:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645789137; x=1677325137;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=t7if2FYhN7GqDQjX0QAaX0PLfbz36m7PFHZKJqreYdw=;
  b=mBBIgpSuJTCcWpQ8D9M8pmeLmh5nOqHgB0wBhC3MQAiz7vtPX02R+Y/M
   qpzWouQZ/fVDBw2SJxTBPYbJe1Zk1DvE/NczBKCReJczhlLa3xvv6wxsy
   AM3k8CD0sTnJerwg0Qq8yfDjwoTfnPRlI46Q6x/x3maDrsQKorNyLCHJ7
   PvRM0WIJ5oPIDiMRr3D9rp5gUBS06hkHjkPC5J1UHa2Vx8CskF2wrLFAv
   ohR6Q91e6nXHr6F3z5aKrjOW8wIK/Jv1KHq+rwZL/E8Vd+n3PYmShxo4T
   ox9e6oFQlVpFAV6BlBBYzsGa3ngg5PHsaIXC2a20eunhkyYAA2oaTELy2
   g==;
X-IronPort-AV: E=Sophos;i="5.90,136,1643698800"; 
   d="scan'208";a="154404885"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Feb 2022 04:38:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 25 Feb 2022 04:38:54 -0700
Received: from [10.12.72.56] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 25 Feb 2022 04:38:52 -0700
Message-ID: <05ebd7e2-2c68-1837-1028-de6cb82d235e@microchip.com>
Date:   Fri, 25 Feb 2022 12:38:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v2 00/10] ARM: at91: add cpu idle and cpufreq opps for
 sama7g5
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <robh+dt@kernel.org>, <linux@armlinux.org.uk>, <sboyd@kernel.org>,
        <mturquette@baylibre.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220113144900.906370-1-claudiu.beznea@microchip.com>
Content-Language: en-US
Organization: microchip
In-Reply-To: <20220113144900.906370-1-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2022 at 15:48, Claudiu Beznea wrote:
> 
> Hi,
> 
> This series adds CPU idle support for SAMA7G5. Along with this the
> CPUFreq OPPs for SAMA7G5 and proper config has been added.
> 
> Thank you,
> Claudiu Beznea

For whole series:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Patches queued in at91 tree for 5.18 (via arm-soc):
- 1-5 in at91-soc
- 6-8 in at91-dt
- 9, 10 in at91-defconfig

Best regards,
    Nicolas

> Changes in v2:
> - collected tags
> - add "opp-suspend" to 600MHz OPP on patch "ARM: dts: at91: sama7g5: add opps"
> - add patches:
> 	ARM: dts: at91: fix low limit for CPU regulator
> 	ARM: dts: at91: sama7g5ek: set regulator voltages for standby state
> 
> Claudiu Beznea (10):
>    ARM: at91: ddr: remove CONFIG_SOC_SAMA7 dependency
>    ARM: at91: ddr: align macro definitions
>    ARM: at91: ddr: fix typo to align with datasheet naming
>    ARM: at91: PM: add cpu idle support for sama7g5
>    ARM: at91: Kconfig: select PM_OPP
>    ARM: dts: at91: fix low limit for CPU regulator
>    ARM: dts: at91: sama7g5ek: set regulator voltages for standby state
>    ARM: dts: at91: sama7g5: add opps
>    ARM: configs: at91: sama7: enable cpu idle
>    ARM: configs: at91: sama7: add config for cpufreq
> 
>   arch/arm/boot/dts/at91-sama7g5ek.dts |  7 ++++-
>   arch/arm/boot/dts/sama7g5.dtsi       | 38 ++++++++++++++++++++++++++++
>   arch/arm/configs/sama7_defconfig     |  9 ++++++-
>   arch/arm/mach-at91/Kconfig           |  1 +
>   arch/arm/mach-at91/pm.c              | 27 +++++++++++++++++++-
>   arch/arm/mach-at91/pm_suspend.S      |  4 +--
>   include/linux/clk/at91_pmc.h         |  4 +++
>   include/soc/at91/sama7-ddr.h         | 15 +++++------
>   8 files changed, 91 insertions(+), 14 deletions(-)
> 


-- 
Nicolas Ferre
