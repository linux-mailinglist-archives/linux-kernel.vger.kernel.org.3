Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438F3575124
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238854AbiGNOzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiGNOzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:55:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF1D2BB2B;
        Thu, 14 Jul 2022 07:55:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 471A3B826C0;
        Thu, 14 Jul 2022 14:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36310C3411C;
        Thu, 14 Jul 2022 14:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657810497;
        bh=nZAl/M9yCCjXCxofy9D8zOlauT5qfrQNarNo+cTtzGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=07sPYhnSnpZo6EAb/64UVfYDTjvqGLlXqViVTZBCM2gCnJ94OKqEMX7Q0Gugc2x+W
         liJtqJedq+KKCnZT/NMUQ7gzXoh2HprkZvQFBngXaTf5XR+w5j9NA9CSi+FIr8aeMA
         Xr2ffmhwMK7nO+pQXAnFnsTVe9ItUJxZXQoz484s=
Date:   Thu, 14 Jul 2022 16:54:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Ene <sebastianene@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, will@kernel.org, vdonnefort@google.com,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v12 0/2] Detect stalls on guest vCPUS
Message-ID: <YtAuPh7NCbGX8jFB@kroah.com>
References: <20220711081720.2870509-1-sebastianene@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711081720.2870509-1-sebastianene@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 08:17:18AM +0000, Sebastian Ene wrote:
> Minor change from v11 which cleans up the Kconfig option selection.
> 
> This adds a mechanism to detect stalls on the guest vCPUS by creating a
> per CPU hrtimer which periodically 'pets' the host backend driver.
> On a conventional watchdog-core driver, the userspace is responsible for
> delivering the 'pet' events by writing to the particular /dev/watchdogN node.
> In this case we require a strong thread affinity to be able to
> account for lost time on a per vCPU basis.
> 
> This device driver acts as a soft lockup detector by relying on the host
> backend driver to measure the elapesed time between subsequent 'pet' events.
> If the elapsed time doesn't match an expected value, the backend driver
> decides that the guest vCPU is locked and resets the guest. The host
> backend driver takes into account the time that the guest is not
> running. The communication with the backend driver is done through MMIO
> and the register layout of the virtual watchdog is described as part of
> the backend driver changes.
> 
> The host backend driver is implemented as part of:
> https://chromium-review.googlesource.com/c/chromiumos/platform/crosvm/+/3548817
> 
> Changelog v12:
>  - don't select LOCKUP_DETECTOR from Kconfig when VCPU_STALL_DETECTOR is
>    compiled in as suggested by Greg
>  - add the review-by tag received from Guenter

Thanks for sticking with this, now applied to my tree!

greg k-h
