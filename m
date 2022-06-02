Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA76653B4EB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 10:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbiFBIYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 04:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbiFBIY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 04:24:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BE219F97;
        Thu,  2 Jun 2022 01:24:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B95260C4A;
        Thu,  2 Jun 2022 08:24:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F76C385A5;
        Thu,  2 Jun 2022 08:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654158265;
        bh=tsQ3Og3uhZXhfkAyuEhVXuXrJoJoDkuM+SBHb/RXZTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hY4yMdwhUoQeGyPZzVTf14VArdJA5iC2DWl9cXmYYir8NJe+nFyxwJ7qi74+oRu5/
         YzMtzvukj1OnFIUtMPJv88if8MdHkFlU9HFOOQ48vHNEQMvMftDwKGicT/OjPlVCe1
         RroDzy1hLs9Hug7KGUg/wK6YXab4IJ0PztA+cUv4=
Date:   Thu, 2 Jun 2022 10:24:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, axboe@kernel.dk,
        robh+dt@kernel.org, mb@lightnvm.io, ckeepax@opensource.cirrus.com,
        arnd@arndb.d, mst@redhat.com, javier@javigon.com,
        mikelley@microsoft.com, jasowang@redhat.com,
        sunilmut@microsoft.com, bjorn.andersson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        ashish.deshpande@nxp.com, rvmanjumce@gmail.com
Subject: Re: [PATCH v4 3/3] misc: uwb: nxp: sr1xx: UWB driver support for
 sr1xx series chip
Message-ID: <Yphztp/+Vw9Yco/L@kroah.com>
References: <20220527184351.3829543-1-manjunatha.venkatesh@nxp.com>
 <20220527184351.3829543-4-manjunatha.venkatesh@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527184351.3829543-4-manjunatha.venkatesh@nxp.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 12:13:51AM +0530, Manjunatha Venkatesh wrote:
> Ultra-wideband (UWB) is a short-range wireless communication protocol.
> 
> NXP has SR1XX family of UWB Subsystems (UWBS) devices. SR1XX SOCs
> are FiRa Compliant. SR1XX SOCs are flash less devices and they need
> Firmware Download on every device boot. More details on the SR1XX Family
> can be found at https://www.nxp.com/products/:UWB-TRIMENSION
> 
> The sr1xx driver work the SR1XX Family of UWBS, and uses UWB Controller
> Interface (UCI).  The corresponding details are available in the FiRa
> Consortium Website (https://www.firaconsortium.org/).
> 
> Internally driver will handle two modes of operation.
> 1.HBCI mode (sr1xx BootROM Code Interface)
> Firmware download uses HBCI ptotocol packet structure which is
> Nxp proprietary,Firmware File(.bin) stored in user space context
> and during device init sequence pick the firmware packet in chunk
> and send it to the driver with write() api call.
> 
> After the firmware download sequence at the end UWBS will
> send device status notification and its indication of device entered
> UCI mode.
> Here after any command/response/notification will follow
> UCI packet structure.
> 
> 2.UCI mode (UWB Command interface)
> Once Firmware download finishes sr1xx will switch to UCI mode.
> Then driver exchange command/response/notification as per the FIRA UCI
> standard format between user space and sr1xx device.
> Any response or notification received from sr1xx through SPI line
> will convey to user space.
> 
> Its Interrupt based driver and IO Handshake needed with SR1XX Family of
> SOCs.
> This driver needs dts config update as per the sr1xx data sheet.
> Corresponding document available in Documentation/devicetree/bindings/uwb
> 
> Message-ID: <20220504171337.3416983-1-manjunatha.venkatesh@nxp.com>
> Signed-off-by: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> ---
> Changes since v3:
>   - Commit Message Description updated
>   - Renamed file from sr1xx.c to nxp-sr1xx.c
>   - Removed unwanted header files
>   - Removed sr1xx.h file since its not required for single source file

For some reason you seem to have ignored many of my review requests of
your previous submission.  Because of that, I'll just drop this series
and wait for a version that addresses those issues as they are still
present here, making this submission impossible to accept.

thanks,

greg k-h
