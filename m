Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3442C58276D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiG0NOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiG0NOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:14:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1506E2715B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:14:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4D07616E9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 13:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF86C433C1;
        Wed, 27 Jul 2022 13:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658927653;
        bh=UlOJehB2C1dNDPXUGdD1B54/kBcVsgQvnRt2OM153Xw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d0DYo5D7jLWdFMIOGTd0DjsNocVglW009ELjLZ4/GHv44QeELumQ+XWY+yuDwCw8y
         ERQ3yuNqnvbhzCfLAGyKFtr7sKH0rGeF6wnpN15kNuZgDAqfTVzJ/NySET9/p6+6Wc
         b1SpkEw7h2BYJwIhSgfjBznpXAf4hPzMgtocQs/U=
Date:   Wed, 27 Jul 2022 15:14:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiho Chu <jiho.chu@samsung.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        yelini.jeong@samsung.com, myungjoo.ham@samsung.com
Subject: Re: [PATCH 3/9] trinity: Add load/unload IDU files
Message-ID: <YuE6IrM/8slDjsdL@kroah.com>
References: <20220725065308.2457024-1-jiho.chu@samsung.com>
 <CGME20220725065309epcas1p20c847655e7332c818fc0fd2c50fb0e27@epcas1p2.samsung.com>
 <20220725065308.2457024-4-jiho.chu@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725065308.2457024-4-jiho.chu@samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 03:53:02PM +0900, Jiho Chu wrote:
> +static int triv2_idu_load_file(struct trinity_driver *drv, const char *dirpath,
> +			       const char *file_name,
> +			       struct trinity_resv_mem *sector)
> +{
> +	struct device *dev = drv_to_dev_ptr(drv);
> +	struct trinity_resv_mem mem;
> +	char filepath[NAME_MAX];
> +	struct kstat *stat;
> +	struct file *filp;
> +	loff_t pos = 0;
> +	size_t size;
> +	int ret;
> +
> +	dev = drv_to_dev_ptr(drv);
> +	stat = vmalloc(sizeof(*stat));
> +	if (stat == NULL)
> +		return -ENOMEM;
> +
> +	/* if dirpath is null, use the default path */
> +	if (dirpath)
> +		snprintf(filepath, NAME_MAX, "%s/%s", dirpath, file_name);
> +	else
> +		snprintf(filepath, NAME_MAX, TRIV2_IDU_DIRPATH_FMT "/%s",
> +			 utsname()->release, file_name);
> +
> +	filp = filp_open(filepath, O_RDONLY, 0400);

That is cute.  And totally not ok.

Please never do this, that is not how to properly load a firmware blob
in the kernel.  This is racy and broken and probably a huge security
hole.

Heck, I wrote an article about this very topic, way back in 2005, with
the title of, "Things you should never do in the kernel" and can be seen
here:
	https://www.linuxjournal.com/article/8110

This should not be news to anyone, again, never do this.

thanks,

greg k-h
