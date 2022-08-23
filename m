Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBBB59E523
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 16:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239100AbiHWOdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 10:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238336AbiHWOc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 10:32:58 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C726C2B147D;
        Tue, 23 Aug 2022 04:48:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 83E9ECE1B60;
        Tue, 23 Aug 2022 11:24:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63552C433C1;
        Tue, 23 Aug 2022 11:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661253867;
        bh=LY8UHKhDFtoFhMwpiR4sGrOl/BmJ2ROozJYZ/PjEh14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z2YneyHpk4O25CNnCARr35QqpRPdVy9umZQ4cep7Rk8y0ekikF5jWNQiQ9ZBUaH8e
         v8RHr+R+wpn8JpYnhiDEXDkF1FNnDmKGMvQh5Q8CeW8htHIcdDUGZfib6pOCF5yXtA
         4VV92vMOwkFzRNVxKWxWyC2+OY6FRZc++triTVj8=
Date:   Tue, 23 Aug 2022 13:24:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        UNGLinuxDriver@microchip.com, arnd@arndb.de,
        dragan.cvetic@xilinx.com, derek.kiernan@xilinx.com
Subject: Re: [PATCH RFC char-misc-next 1/5] misc: microchip: pci1xxxx: load
 auxiliary bus driver for the PIO function in the multi-function endpoint of
 pci1xxxx device.
Message-ID: <YwS46X73H+J0yVJr@kroah.com>
References: <20220804163219.921640-1-kumaravel.thiagarajan@microchip.com>
 <20220804163219.921640-2-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804163219.921640-2-kumaravel.thiagarajan@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 10:02:15PM +0530, Kumaravel Thiagarajan wrote:
> +// SPDX-License-Identifier: GPL-2.0+

I have to ask, do you really mean "or any later version" like you are
saying here?

> +// Copyright (C) 2022 Microchip Technology Inc.
> +
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/spinlock.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/idr.h>
> +#include "mchp_pci1xxxx_gp.h"
> +
> +struct aux_bus_device {
> +	struct auxiliary_device_wrapper *aux_device_wrapper[2];
> +};
> +
> +DEFINE_IDA(gp_client_ida);

Shouldn't this be static?

thanks,

greg k-h
