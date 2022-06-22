Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC71C554681
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355602AbiFVJAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355528AbiFVJA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:00:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2D355B8;
        Wed, 22 Jun 2022 02:00:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56E086194A;
        Wed, 22 Jun 2022 09:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00244C34114;
        Wed, 22 Jun 2022 09:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655888425;
        bh=+o6AzCltYmzNj6+UMQx53ncNraIROmp0UBLjznmFdx0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CGM8U3aLJJzCXJ3yTedeRPmHUYYa8QTAJGQhU1NuT54wJJI2EMlaPXXyvuJr6jAxB
         7jIV3J/o0WANOAYacXDzolim3SaDfQqTLU7iR+pw/xnYCFXAS0sPqFC2NuW5LOnXew
         PjelVdFIXWAxPMhiD/TwctH51T9nEBSrO8m3p27oMQh9ajl2ajvs8i1UipmbfPhj/y
         TSzfhctCotuKElR6KnR2NEgAL4CbHi+bMaY4yH2c6boss5G3hRu4ikmo/fEhChXpdu
         6nfRhRADLGGqjMbaRFpY4ZA3Q7FKmABZEF7xw4YwRaFZTN2PoKCj0QSC2mwZRLCphX
         diCmxDZq2MVRw==
Message-ID: <d3a5128e-7f1c-58e9-05fd-d467a552429f@kernel.org>
Date:   Wed, 22 Jun 2022 11:00:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] arm/mach-omap2: Fix refcount leak bug in omap_hwmod.c
Content-Language: en-US
To:     Liang He <windhl@126.com>, tony@atomide.com, linux@armlinux.org.uk
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220618014747.4055279-1-windhl@126.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220618014747.4055279-1-windhl@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2022 03:47, Liang He wrote:
> In _init(), of_find_node_by_name() will return a node pointer with
> refcount incremented. We should use of_node_put() in fail path or
> when it is not used anymore.
> 
> NOTE: As the ref will be passed from 'bus' to 'np' by the xx_lookup(),
> in normal exit path, we should call of_node_put() at the end use of 'np',
> not the end use of 'bus'.
> 
> Signed-off-by: Liang He <windhl@126.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Before applying the patch please check it carefully. Previous evidence
[1][2] suggests that not it was not even compiled.



[1] https://lore.kernel.org/all/202206221602.odN70SHs-lkp@intel.com/

[2]
https://lore.kernel.org/all/16f9a971.44e5.1817068ee3c.Coremail.windhl@126.com/


Best regards,
Krzysztof
