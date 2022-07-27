Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383AB5827A1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbiG0NZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbiG0NZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:25:23 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9812FAE78
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:25:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 043FCCE219F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 13:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7F7C433D6;
        Wed, 27 Jul 2022 13:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658928319;
        bh=/2rotFYdfY/ec+jauYH6arvwpgfHHTF23YN5wkahDZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dx8kZcSzWA0zU1+8BV8WNlSpXSXZjd6fZMfb85LnVL7iRWMiN+KGmqOpnFTkJ5ltE
         X/056Dd9glRr2gRTDtznYZwjl5GEoK1ZURWaY4nApcioBJlDvriOeqio6tRn+dLA6y
         gysplP8WEl8YRGj3RmD1POBA5J4lb8jzJHOjATC0=
Date:   Wed, 27 Jul 2022 15:25:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiho Chu <jiho.chu@samsung.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        yelini.jeong@samsung.com, myungjoo.ham@samsung.com
Subject: Re: [PATCH 5/9] trinity: Add sysfs debugfs module
Message-ID: <YuE8vEaA19iPGcfy@kroah.com>
References: <20220725065308.2457024-1-jiho.chu@samsung.com>
 <CGME20220725065309epcas1p413498a418cbf58570f8009ae7fd91015@epcas1p4.samsung.com>
 <20220725065308.2457024-6-jiho.chu@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725065308.2457024-6-jiho.chu@samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 03:53:04PM +0900, Jiho Chu wrote:
> This patch includes debugfs and sysfs interfaces.

debugfs and sysfs are two totally different things, with different rules
and requirements.  Split this up into at least 2 different patches and
don't mush them all together.

Would you want to try to review 2000+ lines of this type of thing that
does two totally different things at the same time?

Also, you forgot the sysfs Documentation/ABI/ entries, which are
required as you know.

And finally, you should never do this:

> +int trinity_sysfs_init(struct trinity_driver *drv)
> +{
> +	struct device *dev = drv_to_dev_ptr(drv);
> +	int err;
> +
> +	err = sysfs_create_groups(&dev->kobj, trinity_attrs_groups);


You just raced with userspace and lost.  Use the default groups pointer
for your driver and all will be fine.  Makes for much smaller code that
works properly.

thanks,

greg k-h
