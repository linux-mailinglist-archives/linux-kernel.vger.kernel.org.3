Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9354D9A75
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 12:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347956AbiCOLgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 07:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347948AbiCOLgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 07:36:16 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118404990D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 04:35:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 770CACE1A45
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 11:35:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D10AC340E8;
        Tue, 15 Mar 2022 11:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647344100;
        bh=oU0Tx1hZc0uYc0HnaSj5bjZgA03yAWjn/TYdjaZvFY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RdyZi7KzYexVMeOTKBd+/9RUG1IvfpqtlxI4mznkWh7RK6xe7cV3BZAE7BWAq551/
         59kq56eqMgWA7bnCGCzM+/HZI0n9c+8tDXbOn+Pham5zmbCyp75rG44Z4Q1e2Q8BUq
         K1O8Dai/8WuOwXfFotqhBPSKfQqYXadPQ206fbxE=
Date:   Tue, 15 Mar 2022 12:34:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, axboe@kernel.dk,
        mb@lightnvm.io, ckeepax@opensource.cirrus.com, arnd@arndb.d,
        mst@redhat.com, javier@javigon.com, mikelley@microsoft.com,
        jasowang@redhat.com, sunilmut@microsoft.com,
        bjorn.andersson@linaro.org, rvmanjumce@gmail.com
Subject: Re: [PATCH v2] uwb: nxp: sr1xx: UWB driver support for sr1xx series
 chip
Message-ID: <YjB54Dq4Up5mrTn+@kroah.com>
References: <20220315105205.2381997-1-manjunatha.venkatesh@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315105205.2381997-1-manjunatha.venkatesh@nxp.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 04:22:05PM +0530, Manjunatha Venkatesh wrote:
> Ultra Wide Band(UWB) is a fast, secure and low power radio protocol used
> to determine location with accuracy unmatched by any other wireless
> technology.
> Its a short-range wireless communication protocol. It uses radio waves to
> enable devices to talk to each other.
> 
> This is a new driver that supports the integrated UWB for
> Nxp SoCs, especially the sr1xx series and depends on the SPI module.
> 
> This driver works with Nxp UWB Subsystem(UWBS) which is FiRa Compliance.
> Corresponding UCI details available in Fira Consortuim website.
> 
> sr1xx is flash less UWBS  and it requires firmware download on every
> device boot.
> 
> Internally driver will handle two modes of operation.
> 1.HBCI mode (sr1xx BootROM Code Interface)
>   Firmware download uses HBCI ptotocol packet structure which is
>   Nxp proprietary,Firmware File(.bin) stored in user space context
>   and during device init sequence pick the firmware packet in chunk
>   and send it to the driver with write() api call.
>   Complete firmware download protocol logic implemented in user space,
>   Driver used here is kind of pipe to send data to SPI line.
>   Firmware acknowledge for every chunk packet sent and same thing
>   is monitored,in user space code(HAL layer).
>   If any error Firmware download sequence will fail and reset the device.
>   If firmware download packet sent successfully at the end device will
>   send device status notification and its indication of device entered
>   UCI mode.Here after any command/response/notification will follow
>   UCI packet structure.
> 
> 2.UCI mode (UWB Command interface)
>   Once Firmware download finishes sr1xx will switch to UCI mode packet
>   structure.Here this driver acts as pipe between user space and sr1xx.
>   Any response or notification received from sr1xx through SPI line
>   will convey to user space.User space(UCI lib) will take care of
>   UCI parsing logic.
> 
>   Its IRQ based driver and sr1xx specific irq handshake mechanism logic
>   implemented to avoid any race condition between write and read
>   during ranging sequence.
> 
>   UCI mode Write is same as HBCI mode sequence whatever command received
>   from user space will send to the sr1xx via SPI line.
>   In UCI mode read api called first and waiting on the IRQ line status
>   in order to avoid missing of interrupts after write sequence.
> 
>   This driver needs dts config update as per the sr1xx data sheet.
>   Corresponding document added in Documentation/devicetree/bindings/uwb
> 
> Signed-off-by: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> 
> Changes since v1:
> https://lkml.org/lkml/2022/3/7/1254

Always use lore.kernel.org links.  Also the changelog goes below the ---
line.  This does not describe what changed, you are just pointing to a
random place on the internet, which does not explain anything.

greg k-h
