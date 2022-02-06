Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D261C4AB02C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 16:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbiBFPWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 10:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiBFPWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 10:22:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4DFC06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 07:22:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55AE2B80D9C;
        Sun,  6 Feb 2022 15:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C363C340E9;
        Sun,  6 Feb 2022 15:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644160934;
        bh=wXuc6uYL8StWn8Q2SvulywtKXizMFCW15RsnBx52rnM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cemy5rsPAWmpmYQqipBFvrkHKoTj3Qg+HMnp8uvCtP/6XGPnK+qMXn8S55xAOIt5+
         ZapxpvrUYnYKRV5g+8N6btRkkBQhdiDq1cEJg7AknLQKH1VUe0xXCRAxhHLNwC0mXX
         BbHffeTCeyavAKVP2PShn41CyTVKCTO0q8GgC9e2K/55bfaj90bNBynm8PsP9ycxKi
         bLLsRlxyXNATM659MUCPVN7mRXfKAqeM3ianEh6TJn/Qay94nQOyInnsQW8jur2YgW
         yCmI8PNw2ip9OqzQmI9LXyXWNB33aOlrfGfbxkjbxZLe41TiJ8p/NuECOv32rILhAj
         aXFBErDR4l2NA==
Date:   Sun, 6 Feb 2022 15:28:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/3] iio: imu: inv_mpu6050: Drop wrong use of
 ACPI_PTR()
Message-ID: <20220206152836.01261b4e@jic23-huawei>
In-Reply-To: <Yf7FrU3z7jgyv04f@smile.fi.intel.com>
References: <20220203155920.18586-1-andriy.shevchenko@linux.intel.com>
        <20220205164535.763feeea@jic23-huawei>
        <Yf7FrU3z7jgyv04f@smile.fi.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Feb 2022 20:45:01 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sat, Feb 05, 2022 at 04:45:35PM +0000, Jonathan Cameron wrote:
> > On Thu,  3 Feb 2022 17:59:18 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >   
> > > ACPI_PTR() is more harmful than helpful. For example, in this case
> > > if CONFIG_ACPI=n, the ID table left unused which is not what we want.
> > > 
> > > Instead of adding ifdeffery or attribute here and there, drop ACPI_PTR().
> > > 
> > > Fixes: 3b3870646642 ("iio: imu: inv_mpu6050: Mark acpi match table as maybe unused")
> > > Fixes: fd64df16f40e ("iio: imu: inv_mpu6050: Add SPI support for MPU6000")
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> > 
> > Hi Andy,
> > 
> > Whilst I fully support tidying this up, what is 'fixing' as such?
> > Will get rid of an unused warning for the spi case but that sort
> > of things doesn't always get fixes tags.  
> 
> True, however I can find a handful examples when this kind of patches were backported.
> 
> > They tend to result
> > in backports and I wouldn't think it was worth backporting this
> > unless I'm missing something...  
> 
> It's not critical, so can you drop the tags when applying, if you think that's
> okay?
> 
Sure.  I've dropped the Fixes tags and applied the series.

Thanks,

Jonathan


