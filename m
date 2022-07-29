Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78E3584DC0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 11:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235004AbiG2JC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 05:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiG2JCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 05:02:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D386B1EEEF;
        Fri, 29 Jul 2022 02:02:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D99661D3E;
        Fri, 29 Jul 2022 09:02:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7A3C433C1;
        Fri, 29 Jul 2022 09:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659085342;
        bh=1QoElUDidX1GYKTiNfimkmUJvoHtiH5T/3fdnEC8+Ro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eRUOTG+poS4/2XqCPUtITn7QvBAS1tpvurhzioxH9HsMEYu+3H21IpL+Lwn/3ld1J
         ePEXMUz3J5FcjtLRbHMEbtDXYcoTa6ZAvP7AzO07uKFAmn2MtPBTQKdfNUR+yTIVza
         Nm/f13T2RndjkzhHTZmvoccKwrPGTeCd0VwngedI=
Date:   Fri, 29 Jul 2022 11:02:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Rao, Appana Durga Kedareswara" <appanad@amd.com>
Cc:     Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, michal.simek@xilinx.com,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, git@amd.com, git@xilinx.com,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: Re: [PATCH v2 4/4] drivers: misc: Add Support for TMR Inject IP
Message-ID: <YuOiHGBaVOSGzD7V@kroah.com>
References: <20220720060016.1646317-1-appana.durga.kedareswara.rao@amd.com>
 <20220720060016.1646317-5-appana.durga.kedareswara.rao@amd.com>
 <YuKcBO5JatwRYQJ3@kroah.com>
 <f0ea25fe-782b-ed35-d977-3fe16724193c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0ea25fe-782b-ed35-d977-3fe16724193c@amd.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 01:43:47PM +0530, Rao, Appana Durga Kedareswara wrote:
> Hi Greg,
> 
> Thanks for the review.
> 
> On 28/07/22 7:54 pm, Greg KH wrote:
> > On Wed, Jul 20, 2022 at 11:30:16AM +0530, Appana Durga Kedareswara rao wrote:
> > > From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> > > 
> > > The Triple Modular Redundancy(TMR) provides functional fault injection by
> > > changing selected MicroBlaze instructions, which provides the possibility
> > > to verify that the TMR subsystem error detection and fault recovery logic
> > > is working properly, provided sysfs entries which allow the user to inject
> > > a fault.
> > 
> > We already have a fault-injection api, why are you not using that?
> > 
> 
> Inorder to inject the error using TMR inject IP, The API
> which injects the error should be executed from Processor LMB,
> below sysfs entry calls microblaze core API xmb_inject_err()
> which switches the processor to real mode and injects the error,
> Please find the code corresponds to xmb_inject_err() API here:
> https://www.spinics.net/lists/arm-kernel/msg991888.html

You did not answer the question.  Why are you not using the in-kernel
fault injection userspace api and why have you created your own?

Also, please use lore.kernel.org links when possible.

thanks,

greg k-h
