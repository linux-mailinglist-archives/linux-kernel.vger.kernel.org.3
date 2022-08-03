Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEBE588E59
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 16:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbiHCOQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 10:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbiHCOQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 10:16:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CF7A627A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 07:16:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DBD211FB;
        Wed,  3 Aug 2022 07:16:18 -0700 (PDT)
Received: from [10.57.12.36] (unknown [10.57.12.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D6933F70D;
        Wed,  3 Aug 2022 07:16:16 -0700 (PDT)
Message-ID: <846c663a-5999-977b-8a69-89c8ca522cea@arm.com>
Date:   Wed, 3 Aug 2022 15:16:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 0/2] add support for CDX bus MSI domain
Content-Language: en-GB
To:     Nipun Gupta <nipun.gupta@amd.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, maz@kernel.org, tglx@linutronix.de
Cc:     okaya@kernel.org, harpreet.anand@amd.com, michal.simek@amd.com,
        nikhil.agarwal@amd.com
References: <20220803122655.100254-1-nipun.gupta@amd.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220803122655.100254-1-nipun.gupta@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-03 13:26, Nipun Gupta wrote:
> Devices in FPGA can be added/modified dynamically on run-time.
> These devices are exposed on system bus to embedded CPUs.
> 
> CDX is an upcoming bus, that caters to the requirement for
> dynamically discovered FPGA devices. These devices are added
> as platform devices where fwnode is created using 'software
> nodes' in Linux framework.
> 
> This RFC targets to solves 2 issues when adding devices
> dynamically using platform_device_register API.
> 
> 1. It creates a MSI domain for CDX bus devices, which can
>     discover device ID used by GIC ITS without depending
>     on of_node.
> 2. Since these devices are not present in device tree, it
>     creates a sysfs entry to expose the compatible string.

Isn't this pretty much what CONFIG_OF_DYNAMIC is for? From the look of 
these patches this thing is still completely tied to devicetree, so why 
reinvent that wheel?

Robin.

> Nipun Gupta (2):
>    irqchip: cdx-bus: add cdx-MSI domain with gic-its domain as parent
>    driver core: add compatible string in sysfs for platform devices
> 
>   drivers/base/platform.c                  |  15 +++
>   drivers/irqchip/Makefile                 |   1 +
>   drivers/irqchip/irq-gic-v3-its-cdx-msi.c | 114 +++++++++++++++++++++++
>   include/linux/cdx/cdx.h                  |  15 +++
>   4 files changed, 145 insertions(+)
>   create mode 100644 drivers/irqchip/irq-gic-v3-its-cdx-msi.c
>   create mode 100644 include/linux/cdx/cdx.h
> 
