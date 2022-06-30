Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438A7561B48
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 15:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbiF3N1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 09:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbiF3N1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 09:27:01 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268753335C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:27:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 80FFBCE2E4A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 13:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9850C34115;
        Thu, 30 Jun 2022 13:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656595616;
        bh=jGLn1l/cF7ULBOgAuxMF/AGaZcfBL4dBzerw4EwZxrw=;
        h=Date:From:To:Cc:Subject:From;
        b=Wdhe+sn1o48KkYNIHJ0PkccG1UzQ5mRey3o0/3uYJSNqU+rb9Gdncz6p3X9kVSodH
         O2HrM14W4jhS5umoYPatYCZi+rO+CHYTADsj9DZX9IhUrdjowF9QpCbKFQPSRuh1P2
         B72WZyU/Mgur6V2aFphuilvpY4cXVDuPV34GHE6pS9+PscLjIs8P/K3tBZHH82LqlS
         REliTRMUSG9z+oD6TAAtYpB4wUIoKgAZWt+CVeih8fphrxIt6DNJ51lcqYUlGcksoM
         xEgyuuZzQkSLsrIpTOVKc4Yz8WCr3elm09NPm1Rz5VinVN6y4GFwFBicgqoi7177Mb
         QV3exodMm38Jg==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1o6uC6-004LW1-HV;
        Thu, 30 Jun 2022 14:26:54 +0100
MIME-Version: 1.0
Date:   Thu, 30 Jun 2022 14:26:54 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Michal Simek <michal.simek@amd.com>
Cc:     Jamie Iles <jamie@jamieiles.com>, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] irqchip/xilinx: add explicit dependency on OF_ADDRESS
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <692370a0f844052b3727e4f16b960a00@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: michal.simek@amd.com, jamie@jamieiles.com, linux-kernel@vger.kernel.org, lkp@intel.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-30 13:33, Michal Simek wrote:
> On 6/30/22 13:10, Jamie Iles wrote:
>> Commit b84dc7f0e364 ("irqchip/xilinx: Remove microblaze+zynq
>> dependency") relaxed the dependencies on the Xilinx interrupt 
>> controller
>> to be OF only, but some OF architectures (s390 for example) do not
>> support OF_ADDRESS and so a build of the driver will result in 
>> undefined
>> references to of_iomap/iounmap and friends.
>> 
> 
> Can you please add here fixed tag?
> 
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
>> ---
>>   drivers/irqchip/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>> index 1f23a6be7d88..bbb11cb8b0f7 100644
>> --- a/drivers/irqchip/Kconfig
>> +++ b/drivers/irqchip/Kconfig
>> @@ -298,7 +298,7 @@ config XTENSA_MX
>>     config XILINX_INTC
>>   	bool "Xilinx Interrupt Controller IP"
>> -	depends on OF
>> +	depends on OF_ADDRESS
>>   	select IRQ_DOMAIN
>>   	help
>>   	  Support for the Xilinx Interrupt Controller IP core.
> 
> When above added feel free to add my
> Acked-by: Michal Simek <michal.simek@amd.com>

No need to respin, I'll add the tag myself.

         M.
-- 
Jazz is not dead. It just smells funny...
