Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6501450E518
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239404AbiDYQFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238782AbiDYQFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:05:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03BFE012;
        Mon, 25 Apr 2022 09:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=r0QZyBeWqKyz0fDvDlrnLceVxOw9MHH62RSkL/PsS1I=; b=OoLr8vxMmA/7L3nlKhi2UFrGQT
        +TlCzIlEj8nr9vMT2ahglxiYSGwINiNYkoDMQRsvGWwEc/ioFHp5abPKviS2kpu7Uvaf1IFszWPCP
        EEof+REfNx6wD3RBekhJ6PkT+/cefF1vByc9ZEa5T7FkPjarfWeuzTuCLnkQQutJ2O4GdPiM87kfh
        AFnZArBWoY2fU5yjcIOLl6LssIE5CE5y8ohjSQCb24N0N755IN8O46EiyrC6xv5dwz/AV6IN2Y0gl
        IeimM7a0lI4t11FzT9bhzwo48ckDCWq5SPIUucuIs7zmIykYhIb54Mpjb0RoWJjKmI0f1fvbRJiVd
        srFJP1Cw==;
Received: from [2601:1c0:6280:3f0:e65e:37ff:febd:ee53]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nj1AG-008ZeN-7w; Mon, 25 Apr 2022 16:02:17 +0000
Message-ID: <1d938867-05b9-fab5-1f48-a635d92420d3@infradead.org>
Date:   Mon, 25 Apr 2022 09:02:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 2/2] misc: Add a mechanism to detect stalls on guest
 vCPUs
Content-Language: en-US
To:     Sebastian Ene <sebastianene@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, will@kernel.org, qperret@google.com
References: <20220425134204.149042-1-sebastianene@google.com>
 <20220425134204.149042-3-sebastianene@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220425134204.149042-3-sebastianene@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/25/22 06:42, Sebastian Ene wrote:
> This driver creates per-cpu hrtimers which are required to do the
> periodic 'pet' operation. On a conventional watchdog-core driver, the
> userspace is responsible for delivering the 'pet' events by writing to
> the particular /dev/watchdogN node. In this case we require a strong
> thread affinity to be able to account for lost time on a per vCPU.
> 
> This part of the driver is the 'frontend' which is reponsible for
> delivering the periodic 'pet' events, configuring the virtual peripheral
> and listening for cpu hotplug events. The other part of the driver
> handles the peripheral emulation and this part accounts for lost time by
> looking at the /proc/{}/task/{}/stat entries and is located here:
> https://chromium-review.googlesource.com/c/chromiumos/platform/crosvm/+/3548817
> 
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> ---
>  drivers/misc/Kconfig  |  12 +++
>  drivers/misc/Makefile |   1 +
>  drivers/misc/vm-wdt.c | 207 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 220 insertions(+)
>  create mode 100644 drivers/misc/vm-wdt.c
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 2b9572a6d114..71c173e3f064 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -493,6 +493,18 @@ config OPEN_DICE
>  
>  	  If unsure, say N.
>  
> +config VM_WATCHDOG
> +	tristate "Virtual Machine Watchdog"
> +	select LOCKUP_DETECTOR
> +	help
> +	  Detect CPU locks on the virtual machine. This driver relies on the
> +	  hrtimers which are CPU-binded to do the 'pet' operation. When a vCPU
> +	  has to do a 'pet', it exists the guest through MMIO write and the

	                        exits ?
I dunno, but it's confusing.

> +	  backend driver takes into account the lost ticks for this particular
> +	  CPU.
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called vm-wdt.



-- 
~Randy
