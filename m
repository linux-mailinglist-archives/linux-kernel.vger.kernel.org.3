Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFE25AA965
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbiIBIGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiIBIGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:06:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4648461708;
        Fri,  2 Sep 2022 01:06:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6B6E61EDD;
        Fri,  2 Sep 2022 08:06:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A259FC433C1;
        Fri,  2 Sep 2022 08:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662105975;
        bh=mbEUvK0cacfjub0C0SY/uJmoNeFaJv7RGSFQ2fv4XYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e/oqQUOfN5p7RcBk8BLtMhRxoInELOwnXXs0nCIQVGsrhyj20G83mlWYoqQ21PGFN
         t34tWcURSrlUgzF+0c3MCcmTpHNHJyhToT1aLg17ybjLCITVP8B5ueTDfibSbhYJOe
         GvS/JqIPZGAfVemm91WsmgzPRJKttX1Vo7H7y9Nk=
Date:   Fri, 2 Sep 2022 10:06:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: serial: ftdi_sio: Convert to use dev_groups
Message-ID: <YxG5dD/krDTazhsX@kroah.com>
References: <20220902075853.3931834-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902075853.3931834-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 03:58:53PM +0800, Jiasheng Jiang wrote:
> The driver core supports the ability to handle the creation and removal
> of device-specific sysfs files in a race-free manner. Moreover, it can
> guarantee the success of creation. Therefore, it should be better to
> move the definition of ftdi_sio_device to the end, remove
> create_sysfs_attrs and remove_sysfs_attrs, and convert to use dev_groups.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

This is not a "Fix:", sorry.

And did you test this change?

It does not work like the original submission did at all:

> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog:
> 
> v1 -> v2:
> 
> 1. Change the title.
> 2. Switch to use an attribute group.
> ---
>  drivers/usb/serial/ftdi_sio.c | 124 ++++++++++++----------------------
>  1 file changed, 42 insertions(+), 82 deletions(-)
> 
> diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
> index d5a3986dfee7..41d8bfb02322 100644
> --- a/drivers/usb/serial/ftdi_sio.c
> +++ b/drivers/usb/serial/ftdi_sio.c
> @@ -1108,41 +1108,6 @@ static u32 ftdi_232bm_baud_to_divisor(int baud);
>  static u32 ftdi_2232h_baud_base_to_divisor(int baud, int base);
>  static u32 ftdi_2232h_baud_to_divisor(int baud);
>  
> -static struct usb_serial_driver ftdi_sio_device = {
> -	.driver = {
> -		.owner =	THIS_MODULE,
> -		.name =		"ftdi_sio",
> -	},
> -	.description =		"FTDI USB Serial Device",
> -	.id_table =		id_table_combined,
> -	.num_ports =		1,
> -	.bulk_in_size =		512,
> -	.bulk_out_size =	256,
> -	.probe =		ftdi_sio_probe,
> -	.port_probe =		ftdi_sio_port_probe,
> -	.port_remove =		ftdi_sio_port_remove,
> -	.open =			ftdi_open,
> -	.dtr_rts =		ftdi_dtr_rts,
> -	.throttle =		usb_serial_generic_throttle,
> -	.unthrottle =		usb_serial_generic_unthrottle,
> -	.process_read_urb =	ftdi_process_read_urb,
> -	.prepare_write_buffer =	ftdi_prepare_write_buffer,
> -	.tiocmget =		ftdi_tiocmget,
> -	.tiocmset =		ftdi_tiocmset,
> -	.tiocmiwait =		usb_serial_generic_tiocmiwait,
> -	.get_icount =           usb_serial_generic_get_icount,
> -	.ioctl =		ftdi_ioctl,
> -	.get_serial =		get_serial_info,
> -	.set_serial =		set_serial_info,
> -	.set_termios =		ftdi_set_termios,
> -	.break_ctl =		ftdi_break_ctl,
> -	.tx_empty =		ftdi_tx_empty,
> -};
> -
> -static struct usb_serial_driver * const serial_drivers[] = {
> -	&ftdi_sio_device, NULL
> -};

No need to move this structure if you don't have to.

>  
>  #define WDR_TIMEOUT 5000 /* default urb timeout */
>  #define WDR_SHORT_TIMEOUT 1000	/* shorter urb timeout */
> @@ -1729,50 +1694,12 @@ static ssize_t event_char_store(struct device *dev,
>  }
>  static DEVICE_ATTR_WO(event_char);
>  
> -static int create_sysfs_attrs(struct usb_serial_port *port)
> -{
> -	struct ftdi_private *priv = usb_get_serial_port_data(port);
> -	int retval = 0;
> -
> -	/* XXX I've no idea if the original SIO supports the event_char
> -	 * sysfs parameter, so I'm playing it safe.  */
> -	if (priv->chip_type != SIO) {
> -		dev_dbg(&port->dev, "sysfs attributes for %s\n", ftdi_chip_name[priv->chip_type]);
> -		retval = device_create_file(&port->dev, &dev_attr_event_char);
> -		if ((!retval) &&
> -		    (priv->chip_type == FT232BM ||
> -		     priv->chip_type == FT2232C ||
> -		     priv->chip_type == FT232RL ||
> -		     priv->chip_type == FT2232H ||
> -		     priv->chip_type == FT4232H ||
> -		     priv->chip_type == FT232H ||
> -		     priv->chip_type == FTX)) {
> -			retval = device_create_file(&port->dev,
> -						    &dev_attr_latency_timer);

See how a specific file only gets added for a specific chip type?  Your
change adds that file for all chip types.

That's not going to work.  To solve this properly you need to set the
is_visible attribute in the attribute group and only create the needed
files based on the chip type.

thanks,

greg k-h
