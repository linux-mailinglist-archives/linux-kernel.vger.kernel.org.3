Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA76750831A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376616AbiDTIGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354761AbiDTIGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:06:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085B83C4BE
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:03:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86E5161940
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1BEC385A1;
        Wed, 20 Apr 2022 08:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650441795;
        bh=eJ22co4YXPeheBisTZeaKDQNgzTMwiJ682WlMNgjrMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CPp1bswq1MXlGs4vMlwy3hdFk1zvYmIo1+vFiHBBmS9BvjLp/lhNp4gg077eVvpo5
         8KKz1e1r9miGzQNuN7dP72FD/Hg/9c2nkEYNecQ4HSV9f4HAjPiWy6NTQjiVEJ5jPt
         ea/f1SwhesdMFsppkIghiUGGUGSc2yK1uOvNt5sMWBPRk8vDGmNt91whyV6Zp6406C
         3LRTmSnq4nPaJ3xJi9vryCqOeXFYjtvg3eQn23VUT14Pc9C4MKhjhBll2X2DoTVM1d
         hLjLbdrPc0oAO68n0s1Pj3/FsnQlWFrkf542C3wDbLFGv50WOfyV67lPmFt6NC5Q2F
         122uag/+SO4XA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nh5Iq-0006dz-D3; Wed, 20 Apr 2022 10:03:08 +0200
Date:   Wed, 20 Apr 2022 10:03:08 +0200
From:   Johan Hovold <johan@kernel.org>
To:     cgel.zte@gmail.com
Cc:     linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] gnss: Use pm_runtime_resume_and_get instead of
 pm_runtime_get_sync
Message-ID: <Yl++PMZWWwZkbVUg@hovoldconsulting.com>
References: <20220419110642.2574612-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419110642.2574612-1-chi.minghao@zte.com.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 11:06:42AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
> pm_runtime_put_noidle. This change is just to simplify the code, no
> actual functional changes.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/gnss/serial.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gnss/serial.c b/drivers/gnss/serial.c
> index 5d8e9bfb24d0..afa7a08d718e 100644
> --- a/drivers/gnss/serial.c
> +++ b/drivers/gnss/serial.c
> @@ -32,11 +32,9 @@ static int gnss_serial_open(struct gnss_device *gdev)
>  	serdev_device_set_baudrate(serdev, gserial->speed);
>  	serdev_device_set_flow_control(serdev, false);
>  
> -	ret = pm_runtime_get_sync(&serdev->dev);
> -	if (ret < 0) {
> -		pm_runtime_put_noidle(&serdev->dev);
> +	ret = pm_runtime_resume_and_get(&serdev->dev);
> +	if (ret < 0)
>  		goto err_close;
> -	}
>  
>  	return 0;

Same comments apply here:

	https://lore.kernel.org/lkml/Yl+948unOoDFdLe2@hovoldconsulting.com/T/#t

Johan
