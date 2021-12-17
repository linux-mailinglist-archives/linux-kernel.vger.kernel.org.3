Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090C247854B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 07:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbhLQGyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 01:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhLQGyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 01:54:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71039C061574;
        Thu, 16 Dec 2021 22:54:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CC3CB8273C;
        Fri, 17 Dec 2021 06:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21F1C36AE1;
        Fri, 17 Dec 2021 06:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639724087;
        bh=p6kCMyX2FcZyDvW47gsSNm7t4OPV1fFHJBSG/seWwr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=drPa5bYYNpFNIxGEMsxDQQUhoLFAPAVLUiKQatw3BI9YvsHAQzs9voZ5U1VGT3gZ9
         tm+erfngXaT6V52612rJBL2O0iHJ9u7j0kKWi5IeXmQh5keWES0rqHGRM6SeyKlqRE
         WDCloKmFnHmXGEfifYGhexNJ27dyFr2qCFEZFKU4=
Date:   Fri, 17 Dec 2021 07:54:39 +0100
From:   gregkh <gregkh@linuxfoundation.org>
To:     Tony Huang =?utf-8?B?6buD5oe35Y6a?= <tony.huang@sunplus.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wells Lu =?utf-8?B?5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        =?utf-8?B?6buD5oe35Y6a?= <tonyhuang.sunplus@gmail.com>
Subject: Re: [PATCH v4 2/2] misc: Add iop driver for Sunplus SP7021
Message-ID: <Ybw0Lw1bTV5sGKVc@kroah.com>
References: <cover.1639557112.git.tonyhuang.sunplus@gmail.com>
 <c3a3b64c38807b2f344c3df500eb4c60b885eadf.1639557112.git.tonyhuang.sunplus@gmail.com>
 <CAK8P3a0CnCK-Dfodp-jTzZApM_1NpdY7DV2fRqnO=gaju5xGwg@mail.gmail.com>
 <CAHpW4oQmtd-gG1HYZT-Dk=QAvXKsKebzcOaVtrEeoujwoL9zSg@mail.gmail.com>
 <316c16afbff74160b07bd74444f3b8e1@sphcmbx02.sunplus.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <316c16afbff74160b07bd74444f3b8e1@sphcmbx02.sunplus.com.tw>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 02:44:43AM +0000, Tony Huang 黃懷厚 wrote:
> Dear Arnd:
> 
> On Thu, Dec 16, 2021 at 2:38 AM Tony Huang <tonyhuang.sunplus@gmail.com<mailto:tonyhuang.sunplus@gmail.com>> wrote:
> >>
> >> IOP (IO Processor) embedded inside SP7021 which is used as
> >> Processor for I/O control, RTC wake-up and cooperation with
> >> CPU & PMC in power management purpose.
> >> The IOP core is DQ8051, so also named IOP8051,
> >> it supports dedicated JTAG debug pins which share with SP7021.
> >> In standby mode operation, the power spec reach 400uA.
> >>
> >> Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com<mailto:tonyhuang.sunplus@gmail.com>>
> >> ---
> >> Changes in v4:
> >>  - Addressed comments from Arnd Bergmann.
> 
> >I don't think you did: I asked you specifically to add code to interact with
> >the existing in-kernel interfaces to use the functionality provided by the
> >device. Pick any (at least two) subsystems and add support, but leave
> >out any custom user space interfaces (miscdevice, debugfs, sysfs, ...)
> >for the moment.
> 
> 1. IOP can run sp_iop_platform_driver_shudown() through the poweroff command and the kernel. Perform system power-off actions.
> 2. Wake up the system by relying on the 8051 internal RTC wake-up mechanism and external GPIO input signals to wake up.
> 3.So you ask me to control IOP(8051) through file_operations, not through DEVICE_ATTR

Your DEVICE_ATTR() calls did not do anything normal, they did not print
out or accept data through sysfs at all.  That is not ok.

thanks,

greg k-h
