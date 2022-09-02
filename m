Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CB05AABED
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbiIBJ4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbiIBJ4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:56:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2642630;
        Fri,  2 Sep 2022 02:56:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 066AA61A18;
        Fri,  2 Sep 2022 09:56:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD872C433D6;
        Fri,  2 Sep 2022 09:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662112576;
        bh=lK6uUEPiahGzvtXOIT1ulXhRTu2SWh3dd06AnWyitao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ABMcsnHyBv9LgrXVUQrtNPCgT+nkgHFd/fVlWkKWEdFJBNngKsAY2gFAOxEvR7aw+
         20dJItIZcNUBiOoXmCbeHCS0/4WVnC6ZplP8Ju2XyPu5fLMiaLm32wVb34q/EzaIAT
         kqakFEllhXV7vepbdqZn0TzFKtFyevsnJhHxlrxI=
Date:   Fri, 2 Sep 2022 11:56:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] USB: serial: ftdi_sio: Convert to use dev_groups
Message-ID: <YxHTPb8aWhkqEr8t@kroah.com>
References: <20220902094423.4028673-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902094423.4028673-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 05:44:23PM +0800, Jiasheng Jiang wrote:
> The driver core supports the ability to handle the creation and removal
> of device-specific sysfs files in a race-free manner. Moreover, it can
> guarantee the success of creation. Therefore, it should be better to
> convert to use dev_groups.
> 
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog:
> 
> v2 -> v3:
> 
> 1. Add is_visible to filter the unneeded files.
> 
> v1 -> v2:
> 
> 1. Change the title.
> 2. Switch to use an attribute group.
> ---
>  drivers/usb/serial/ftdi_sio.c | 101 +++++++++++++++++-----------------
>  1 file changed, 51 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
> index d5a3986dfee7..479c3a5caaf8 100644
> --- a/drivers/usb/serial/ftdi_sio.c
> +++ b/drivers/usb/serial/ftdi_sio.c
> @@ -1107,11 +1107,40 @@ static u32 ftdi_232bm_baud_base_to_divisor(int baud, int base);
>  static u32 ftdi_232bm_baud_to_divisor(int baud);
>  static u32 ftdi_2232h_baud_base_to_divisor(int baud, int base);
>  static u32 ftdi_2232h_baud_to_divisor(int baud);
> +static umode_t ftdi_sio_attr_is_visible(struct kobject *kobj,
> +					 struct attribute *attr, int idx);
> +static ssize_t latency_timer_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *valbuf, size_t count);
> +static ssize_t event_char_store(struct device *dev,
> +	struct device_attribute *attr, const char *valbuf, size_t count);
> +static ssize_t latency_timer_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf);
> +

Please work with the code so that you do not have to pre-define these
functions.  It should be possible.  Worst case, you pre-define the
structure for the driver, that should be it.

And again, have you tested this change?

thanks,

greg k-h
