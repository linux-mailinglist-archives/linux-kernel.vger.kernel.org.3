Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC414E3B6D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 10:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbiCVJGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 05:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiCVJFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 05:05:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC7046668
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 02:04:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B075361658
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 09:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DE9C340EE;
        Tue, 22 Mar 2022 09:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647939860;
        bh=E7kgiCH6KC61WFNUuFqMt1ZzIW1CD6iDp319+kmnUr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hP85i/2dfhMiZlecOUXNTkuYtTJmi42dvZ5sBLxd9MhpNr5ebuTs3xxFqSSbOI2XQ
         kPePMBOZFm1lhjfBrITLl0XHuA++/irJ0HnV7qeJ9jiMGNJfnQTvUb1KJn1P6rbhlM
         q7eDksrHRhkef9lUjALnQ3C4R3686mcDOGgQVMIs=
Date:   Tue, 22 Mar 2022 09:48:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     David Kershner <david.kershner@unisys.com>,
        sparmaintainer@unisys.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: unisys: Properly test debugfs_create_dir()
 return values
Message-ID: <YjmNXFlt9+waf94q@kroah.com>
References: <20220322083858.16887-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322083858.16887-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 09:38:58AM +0100, Fabio M. De Francesco wrote:
> debugfs_create_dir() returns a pointers to a dentry objects. On failures
> it returns errors. Currently the values returned to visornic_probe()
> seem to be tested for being equal to NULL in case of failures.
> 
> Properly test with "if (IS_ERR())" and then assign the correct error 
> value to the "err" variable.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/unisys/visornic/visornic_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/unisys/visornic/visornic_main.c b/drivers/staging/unisys/visornic/visornic_main.c
> index 643432458105..58d03f3d3173 100644
> --- a/drivers/staging/unisys/visornic/visornic_main.c
> +++ b/drivers/staging/unisys/visornic/visornic_main.c
> @@ -1922,11 +1922,11 @@ static int visornic_probe(struct visor_device *dev)
>  	/* create debug/sysfs directories */
>  	devdata->eth_debugfs_dir = debugfs_create_dir(netdev->name,
>  						      visornic_debugfs_dir);
> -	if (!devdata->eth_debugfs_dir) {
> +	if (IS_ERR(devdata->eth_debugfs_dir)) {
>  		dev_err(&dev->device,
>  			"%s debugfs_create_dir %s failed\n",
>  			__func__, netdev->name);
> -		err = -ENOMEM;
> +		err = PTR_ERR(devdata->eth_debugfs_dir);
>  		goto cleanup_register_netdev;
>  	}

Also, why does this variable have to be saved off at all?  It should
only be used later when removing the directory, and we can just look it
up at that point in time, right?

Also, what happens if the network device name changes?

thanks,

greg k-h
