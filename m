Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB3E4A82FD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 12:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350135AbiBCLOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 06:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiBCLOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 06:14:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B30C061714;
        Thu,  3 Feb 2022 03:14:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB9A1B8339D;
        Thu,  3 Feb 2022 11:14:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972EEC340E4;
        Thu,  3 Feb 2022 11:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643886853;
        bh=xxX4dF6cL1yEzfRoG5JgXgyt5SDxjS+u7/4N/BpW34M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ImqxT46rAnVZrt5hcN/zy2mlvNnko3+3zMKU27gPdgKtrPGhdX0rweY5FIWulSzr8
         1Sz80hxI4579YtYsbpSDl3H50NiAJCcljmJ1YmrT5ocgB135k3S5GyNGwKhy++yR7S
         Xh1OlybGBPf7Grq8JwelBa0IJBvre8wjz6uPf0XE=
Date:   Thu, 3 Feb 2022 12:14:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, pure.logic@nexus-software.ie,
        bjorn.andersson@linaro.org, robh@kernel.org,
        linux-kernel@vger.kernel.org, quic_tsoni@quicinc.com,
        quic_psodagud@quicinc.com, quic_satyap@quicinc.com,
        quic_pheragu@quicinc.com, quic_rjendra@quicinc.com,
        quic_sibis@quicinc.com, quic_saipraka@quicinc.com
Subject: Re: [PATCH V5 3/6] usb: common: eud: Add driver support for Embedded
 USB Debugger(EUD)
Message-ID: <Yfu5Aq7U6ZT1KzcJ@kroah.com>
References: <cover.1643880577.git.quic_schowdhu@quicinc.com>
 <8dab5fd0df59e057793ac0f2264be31f561b07c3.1643880577.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dab5fd0df59e057793ac0f2264be31f561b07c3.1643880577.git.quic_schowdhu@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 04:04:32PM +0530, Souradeep Chowdhury wrote:
> Add support for control peripheral of EUD (Embedded USB Debugger) to
> listen to events such as USB attach/detach, pet EUD to indicate software
> is functional.Reusing the platform device kobj, sysfs entry 'enable' is
> created to enable or disable EUD.
> 
> To enable the eud the following needs to be done
> echo 1 > /sys/bus/platform/.../enable
> 
> To disable eud, following is the command
> echo 0 > /sys/bus/platform/.../enable
> 
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> ---
>  Documentation/ABI/testing/sysfs-driver-eud |   9 ++
>  drivers/usb/common/Kconfig                 |  10 ++
>  drivers/usb/common/Makefile                |   1 +
>  drivers/usb/common/qcom_eud.c              | 251 +++++++++++++++++++++++++++++

This really should be drivers/usb/misc/ right?  No other code uses
anything from this driver which is what "common" is for.

thanks,

greg k-h
