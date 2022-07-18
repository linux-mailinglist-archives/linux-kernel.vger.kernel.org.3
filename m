Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDB75787A5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 18:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbiGRQnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 12:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiGRQnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 12:43:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78413FD07;
        Mon, 18 Jul 2022 09:43:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BD25614D5;
        Mon, 18 Jul 2022 16:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D518C341C0;
        Mon, 18 Jul 2022 16:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658162579;
        bh=mt3Hyx8w6+AK+UEpBf+TEowqs5ZfWsQtF+zhUIoosBg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BGxX9vsMm1Ecrtq84DecdKj2ORySdm25ksz6E2U2vy91SN+3jC3GDANNGLUVg5lnP
         e4nJPEkDUuQTG8z2+sVPseOya+28/8YR/gbw8DbnXG2hmDvdWy91geYgVEkBhtI/yA
         c0Pfbzj3uh17pMp1a67PBC0cDA01HCa68YgL6bfE0GjGq/O4DqoLQ8g6vxUeK/K3FM
         kuwyFcpLF59a1bpliKM7nfSvxckVg1f87cKrs0Gfw93tiXiMwUlVaQTOZCUNeMNjjF
         B8OTLAipPWoMzX3IPty7g+nuMX1AI8cd8lYthlhjNbvqoSPWfs0UuFMzssUCc3SesF
         ex2a8XW5rhW9g==
Date:   Mon, 18 Jul 2022 17:52:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lars@metafoo.de, cy_huang@richtek.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 0/3] Add Richtek RTQ6056 support
Message-ID: <20220718175253.1333a61a@jic23-huawei>
In-Reply-To: <1658123163-10039-1-git-send-email-u0084500@gmail.com>
References: <1658123163-10039-1-git-send-email-u0084500@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jul 2022 13:46:00 +0800
cy_huang <u0084500@gmail.com> wrote:

> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> This patch series is to enable Richtek RTQ6056 support.
> 
> The RTQ6056 is a high accuracy current-sense monitor with I2C interface, and
> the device provides full information for system by reading out the load current
> and power.

If sending a new version without there being any public replies to the previous version
please reply to that thread yourself to say you are resending and why.
Greatly reduces the chances of me picking up the wrong version!
> 
> Since v7
> - Use 'DEFINE_RUNTIME_DEV_PM_OPS' to replace the explicit declaration of pm_ops.
> 
> Since v6
> - Remove specific rtq6056 ABI document.
> - Update integration time description in general ABI document.
> - Remove the redundant blank line.
> - To prevent the race condition for attribute wrtie and shunt resistor write,
>   use 'iio_device_claim_direct_mode' API.
> - Refine the order for 'action_reset' and 'pm_runtime'.
> - Fix text typo in comment like as ohm to Ohm and timea to time.
> 
> Since v5
> - Fix kernel version text for ABI.
> 
> Since v4
> - Add '__aligned(8)' for timestamp member.
> - Declare timestamp from 'int64_t' to more unified 's64'.
> 
> Since v3
> - change the node name to be generic 'adc' in binding example.
> - Refine pm_runtime API calling order in 'read_channel' API.
> - Fix vshunt wrong scale for divider.
> - Refine the comment text.
> - Use 'devm_add_action_or_reset' to decrease the code usage in probe
>   function.
> - Use RUNTIME_PM_OPS to replace SET_RUNTIME_PM_OPS.
> - minor fix for the comma.
> - Use pm_ptr to replace the direct assigned pm_ops.
> 
> Since v2
> - Change the resistor property name to be generic 'shunt-resistor-micro-ohms'.
> - Rename file from 'rtq6056-adc' to 'rtq6056'.
> - Refine the ABI, if generic already defined it, remove it and check the channel
>   report unit.
> - Add copyright text.
> - include the correct header.
> - change the property parsing name.
> - To use iio_chan_spec address field.
> - Refine each channel separate and shared_by_all.
> - Use pm_runtime and pm_runtime_autosuspend.
> - Remove the shutdown callback. From the HW suggestion, it's not recommended to
>   use battery as the power supply.
> - Check all scale unit (voltage->mV, current->mA, power->milliWatt).
> - Use the read_avail to provide the interface for attribute value list.
> - Add comma for the last element in the const integer array.
> - Refine each ADC label text.
> - In read_label callback, replace snprintf to sysfs_emit.
> 
> ChiYuan Huang (3):
>   dt-bindings: iio: adc: Add rtq6056 adc support
>   iio: adc: Add rtq6056 support
>   Documentation: ABI: testing: rtq6056: Update ABI docs
> 
>  Documentation/ABI/testing/sysfs-bus-iio            |  10 +
>  .../bindings/iio/adc/richtek,rtq6056.yaml          |  56 ++
>  drivers/iio/adc/Kconfig                            |  15 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/rtq6056.c                          | 663 +++++++++++++++++++++
>  5 files changed, 745 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
>  create mode 100644 drivers/iio/adc/rtq6056.c
> 

