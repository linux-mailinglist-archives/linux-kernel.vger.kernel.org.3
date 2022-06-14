Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5A454AEA9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 12:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237989AbiFNKof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 06:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbiFNKod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 06:44:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3620E48301;
        Tue, 14 Jun 2022 03:44:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96D2B611A8;
        Tue, 14 Jun 2022 10:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41C2C3411B;
        Tue, 14 Jun 2022 10:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655203472;
        bh=pQRvKHdBppsmBdcym8HpEMBrKDl2rLZF2PgFG3FbIng=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SzX6O8XtQIBVsIIU6OHFE0BOROLYfBR+IU3fqOKXocy1SZIr2+rtSAXEaiDEVtlLn
         xArm1qKd5CQ4tpCpiKRhvqMAE8GZCgDBMrw8wIhMyT8gEaSSiIGVd0oojdNHjgpeOu
         XKRf4yA84dEgP80/qxJBA07hlv+ov74/1i/4psBWPj/kfwxzFHzXoGAXjDaU1Dqi99
         fwS1VFe28wBMLPSSEnTmqb9b1ZI1r3JZBKwXcPkT3fGJ80mDYnbi5mwivFmN1cjUNW
         UfqQGI/t+sceNKIH8LWWBL5yXeQDo+nYyulfaSF1t4N7nz/eitEYOsZ59mxfX6E/10
         xpwlIRpmPQyXg==
Date:   Tue, 14 Jun 2022 11:53:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: proximity: sx_common: Allow IIO core to
 take care of firmware node
Message-ID: <20220614115343.057f1e8f@jic23-huawei>
In-Reply-To: <CAHp75VdLMCBhhM4P_asTf7r+OhBHmgJVCg7MADkOYRTf1JvRaA@mail.gmail.com>
References: <20220530174326.1381-1-andriy.shevchenko@linux.intel.com>
        <20220603180618.4b643391@jic23-huawei>
        <CAPUE2usmrREACn+bjRfMyNvF1aeozJq+tHCQY6XT7KMXvp94Bg@mail.gmail.com>
        <CAHp75VdLMCBhhM4P_asTf7r+OhBHmgJVCg7MADkOYRTf1JvRaA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jun 2022 11:27:21 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Jun 13, 2022 at 11:31 PM Gwendal Grignou <gwendal@chromium.org> wrote:
> >
> > The reason we have the code ACPI_COMPANION_SET and dev.of_node set (by
> > commit 74a53a959028e ("iio:proximity:sx_common: Fix device property
> > parsing on DT systems") from Stephen is we are getting device propery
> > in ->get_default_reg(), which is called in sx_common_init_device(),
> > before devm_iio_device_register().
> >
> > We have the same code path in other driver, like adc/stm32-adc.c,
> > where indio_dev->dev.of_node is set manually to be able to set the
> > resolution based on device tree properties.  
> 
> Ah, thanks for this insight! I will rework the patch accordingly (yes,
> there is something to clean up even in this case).
> 
> > On Fri, Jun 3, 2022 at 9:57 AM Jonathan Cameron <jic23@kernel.org> wrote:  
> > > On Mon, 30 May 2022 20:43:26 +0300
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > >  
> > > > IIO core correctly will take care of firmware node if it's not set in
> > > > the driver. Drop ACPI and OF specifics from the driver and allow IIO
> > > > core to handle this.
> > > >
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> > > Looks fine to me.  As such I'll apply it now, but Gwendal, you've
> > > been active with this driver recently so if you have time to sanity check
> > > that would be great.  Once I've caught up with new stuff I plan to check
> > > where we are with your various series on this driver.  
> 
Dropped patch

