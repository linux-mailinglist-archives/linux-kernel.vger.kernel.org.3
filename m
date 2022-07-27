Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5F4583147
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 19:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242140AbiG0RyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 13:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242993AbiG0Rxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 13:53:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A969698204
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:58:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 608FDB821D8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 16:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864E8C433D6;
        Wed, 27 Jul 2022 16:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658941092;
        bh=ilVcgb+qn9Ak0Tbt2ws0tO3d/fETMN6Hy8UtFrfFk2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xgobuzazZCLtLbhApozobUvtqyg+OhVThqnZY45gHnQ2I9bDvMnT0Ld8D+g1W2Kle
         ok6VhW6/cy+5GwJjt5zyCBFEyf7Efx4jZn7XGjTT9C3m1UY7uE6thEkn4YRQEYPJ1N
         KRvxUwhvGEL+5VT2bjZZYikCEarZ+RBY225F46Ek=
Date:   Wed, 27 Jul 2022 18:40:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 1/1] drivers/base/cpu: Print kernel arch
Message-ID: <YuFqh6OrWEQsZV04@kroah.com>
References: <20220727161135.24531-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727161135.24531-1-pvorel@suse.cz>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 06:11:35PM +0200, Petr Vorel wrote:
> Print kernel architecture in /sys/devices/system/cpu/arch
> using UTS_MACHINE, i.e. member of struct uts_namespace.machine.
> 
> This helps people who debug kernel with initramfs with minimal
> environment (i.e. without coreutils or even busybox) or allow to open
> sysfs file instead of run uname -m in high level languages.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  drivers/base/cpu.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

You can't add a new sysfs file without a Documentation/ABI/ update as
well.  Please fix that up.


> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 4c98849577d4..7c8032e3ff10 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -3,6 +3,7 @@
>   * CPU subsystem support
>   */
>  
> +#include <generated/compile.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> @@ -232,6 +233,13 @@ static ssize_t print_cpus_kernel_max(struct device *dev,
>  }
>  static DEVICE_ATTR(kernel_max, 0444, print_cpus_kernel_max, NULL);
>  
> +static ssize_t print_cpus_arch(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", UTS_MACHINE);
> +}
> +static DEVICE_ATTR(arch, 0444, print_cpus_arch, NULL);

why just UTS_MACHINE?  Doesn't 'uname' show this already?  And I thought
this was in /proc/cpuinfo but odd, it isn't...

Also what about the other things in compile.h?

thanks,

greg k-h
