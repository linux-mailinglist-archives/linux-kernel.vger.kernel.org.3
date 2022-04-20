Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B54508349
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376689AbiDTIYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376663AbiDTIYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:24:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9247C13F05;
        Wed, 20 Apr 2022 01:21:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58359B81CB4;
        Wed, 20 Apr 2022 08:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14EAC385A1;
        Wed, 20 Apr 2022 08:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650442881;
        bh=u8SZ/a+B7UJguE8WBusnwHUdTmjx9uZdPU3aWgqI+Ss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NFy2wCBYmcXIdYstgzEqEKvJ3ppygRUCT6qJdKv4A+wZ7MKPFzBALai/DyMKCQ/OW
         VnYpxacJEKEeFwyNGsoQijwtd5iRL9pg6ekH/VhMBTDnLoMUgAfWgEi4yKlbsumhTV
         E1nIWiIeKNdH1Z4EupA9NzeNvyIS5CC2eWXjwyXN9gdtj2VN0aUrrITP9XOAQFE62H
         ufxshvDB9p0JzsLhbtihWNYvJEsqNNRa+JFwJa3kD7Ikt4Orf5k1EXunTzhtCIFmgt
         U+KnlFrwu56SEHXH8r5dyYB6K9GN+zO8+2lSxr9kYmyb0KlqXJowMusYApMwKcufoQ
         jBvZug+PoNq0A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nh5aM-0006no-7R; Wed, 20 Apr 2022 10:21:14 +0200
Date:   Wed, 20 Apr 2022 10:21:14 +0200
From:   Johan Hovold <johan@kernel.org>
To:     cgel.zte@gmail.com
Cc:     robh@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] tty: serdev: using pm_runtime_resume_and_get instead of
 pm_runtime_get_sync
Message-ID: <Yl/CenHPSSXZVWbJ@hovoldconsulting.com>
References: <20220418110635.2559391-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418110635.2559391-1-chi.minghao@zte.com.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 11:06:35AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get is more appropriate
> for simplifing code
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/tty/serdev/core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index 0180e1e4e75d..e550ad3e7f2b 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -156,11 +156,9 @@ int serdev_device_open(struct serdev_device *serdev)
>  	if (ret)
>  		return ret;
>  
> -	ret = pm_runtime_get_sync(&ctrl->dev);
> -	if (ret < 0) {
> -		pm_runtime_put_noidle(&ctrl->dev);
> +	ret = pm_runtime_resume_and_get(&ctrl->dev);
> +	if (ret < 0)
>  		goto err_close;
> -	}

As the author of this piece of the code, I prefer using the traditional
API consistently rather than mixing in the new helper that uses a
different naming scheme.

No need to change this.

>  
>  	return 0;

Johan
