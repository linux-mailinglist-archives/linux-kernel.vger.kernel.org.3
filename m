Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDE6512E07
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343904AbiD1ISb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239728AbiD1ISY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:18:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE561C124;
        Thu, 28 Apr 2022 01:15:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CE5961F74;
        Thu, 28 Apr 2022 08:15:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD738C385A0;
        Thu, 28 Apr 2022 08:15:04 +0000 (UTC)
Message-ID: <3270dd49-0d68-5b60-d766-940b39aa463e@xs4all.nl>
Date:   Thu, 28 Apr 2022 10:15:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 4/4] staging: media: zoran: replace dprintk with new
 debugging macros
Content-Language: en-US
To:     Ian Cowan <ian@linux.cowan.aero>,
        Corentin Labbe <clabbe@baylibre.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mjpeg-users@lists.sourceforge.net, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220425144110.133316-1-ian@linux.cowan.aero>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220425144110.133316-1-ian@linux.cowan.aero>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On 25/04/2022 16:41, Ian Cowan wrote:
> This replaces all of the dprintk() macro calls to the zrdev_dbg(),
> zrdev_info(), or zrdev_err() calls as appropriate. This allows for the
> removal of the dprintk() macro from each file it is defined in, along
> with removal of the module params that track the debugging level.
> 
> In the case that a debugging level was used in a comparison, this has
> been replaced with checking the console level debugging and making a
> decision from there. If the console debugging level is at least the
> KERN_ debugging level equivalent, then the comparison will evaluate as
> true.
> 
> There are a few instances where pr_debug() must be used over the
> zrdev_dbg(). These occur in the module cleanup functions because there
> should be no devices defined once we get to those modules, so we have no
> devices to pass to zrdev_dbg().

When I compiled this patch series with smatch I got these warnings:

zoran/videocodec.c:45 videocodec_attach() warn: variable dereferenced before check 'master' (see line 40)
zoran/videocodec.c:115 videocodec_detach() warn: variable dereferenced before check 'codec' (see line 111)
zoran/videocodec.c:168 videocodec_register() warn: variable dereferenced before check 'codec' (see line 166)
zoran/videocodec.c:200 videocodec_unregister() warn: variable dereferenced before check 'codec' (see line 198)

And I also got this warning when checking the kerneldoc:

zoran/zoran.h:307: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Can you fix this and post a v3?

Thanks!

	Hans

> 
> Signed-off-by: Ian Cowan <ian@linux.cowan.aero>
> ---
>  drivers/staging/media/zoran/videocodec.c |  55 ++++------
>  drivers/staging/media/zoran/zr36016.c    |  60 +++++------
>  drivers/staging/media/zoran/zr36050.c    | 131 +++++++++++------------
>  drivers/staging/media/zoran/zr36060.c    |  74 ++++++-------
>  4 files changed, 143 insertions(+), 177 deletions(-)
> 
> diff --git a/drivers/staging/media/zoran/videocodec.c b/drivers/staging/media/zoran/videocodec.c
> index cabb291d302c..64ca3efbd3f5 100644
> --- a/drivers/staging/media/zoran/videocodec.c
> +++ b/drivers/staging/media/zoran/videocodec.c
> @@ -16,16 +16,6 @@
>  
>  #include "videocodec.h"
>  
> -static int videocodec_debug;
> -module_param(videocodec_debug, int, 0);
> -MODULE_PARM_DESC(videocodec_debug, "Debug level (0-4)");
> -
> -#define dprintk(num, format, args...) \
> -	do { \
> -		if (videocodec_debug >= num) \
> -			printk(format, ##args); \
> -	} while (0)
> -
>  struct attached_list {
>  	struct videocodec *codec;
>  	struct attached_list *next;
> @@ -69,7 +59,7 @@ struct videocodec *videocodec_attach(struct videocodec_master *master)
>  		// attach only if the slave has at least the flags
>  		// expected by the master
>  		if ((master->flags & h->codec->flags) == master->flags) {
> -			dprintk(4, "%s: try '%s'\n", __func__, h->codec->name);
> +			zrdev_dbg(zr, "%s: try '%s'\n", __func__, h->codec->name);
>  
>  			codec = kmemdup(h->codec, sizeof(struct videocodec), GFP_KERNEL);
>  			if (!codec)
> @@ -80,7 +70,7 @@ struct videocodec *videocodec_attach(struct videocodec_master *master)
>  			codec->master_data = master;
>  			res = codec->setup(codec);
>  			if (res == 0) {
> -				dprintk(3, "%s: '%s'\n", __func__, codec->name);
> +				zrdev_dbg(zr, "%s: '%s'\n", __func__, codec->name);
>  				ptr = kzalloc(sizeof(*ptr), GFP_KERNEL);
>  				if (!ptr)
>  					goto out_kfree;
> @@ -89,12 +79,13 @@ struct videocodec *videocodec_attach(struct videocodec_master *master)
>  				a = h->list;
>  				if (!a) {
>  					h->list = ptr;
> -					dprintk(4, "videocodec: first element\n");
> +					zrdev_dbg(zr, "videocodec: first element\n");
>  				} else {
>  					while (a->next)
>  						a = a->next;	// find end
>  					a->next = ptr;
> -					dprintk(4, "videocodec: in after '%s'\n", h->codec->name);
> +					zrdev_dbg(zr, "videocodec: in after '%s'\n",
> +						  h->codec->name);
>  				}
>  
>  				h->attached += 1;
> @@ -126,8 +117,8 @@ int videocodec_detach(struct videocodec *codec)
>  		return -EINVAL;
>  	}
>  
> -	dprintk(2, "%s: '%s', type: %x, flags %lx, magic %lx\n", __func__,
> -		codec->name, codec->type, codec->flags, codec->magic);
> +	zrdev_dbg(zr, "%s: '%s', type: %x, flags %lx, magic %lx\n", __func__,
> +		  codec->name, codec->type, codec->flags, codec->magic);
>  
>  	if (!h) {
>  		zrdev_err(zr, "%s: no device left...\n", __func__);
> @@ -141,7 +132,7 @@ int videocodec_detach(struct videocodec *codec)
>  			if (codec == a->codec) {
>  				res = a->codec->unset(a->codec);
>  				if (res >= 0) {
> -					dprintk(3, "%s: '%s'\n", __func__, a->codec->name);
> +					zrdev_dbg(zr, "%s: '%s'\n", __func__, a->codec->name);
>  					a->codec->master_data = NULL;
>  				} else {
>  					zrdev_err(zr, "%s: '%s'\n", __func__, a->codec->name);
> @@ -149,10 +140,10 @@ int videocodec_detach(struct videocodec *codec)
>  				}
>  				if (!prev) {
>  					h->list = a->next;
> -					dprintk(4, "videocodec: delete first\n");
> +					zrdev_dbg(zr, "videocodec: delete first\n");
>  				} else {
>  					prev->next = a->next;
> -					dprintk(4, "videocodec: delete middle\n");
> +					zrdev_dbg(zr, "videocodec: delete middle\n");
>  				}
>  				kfree(a->codec);
>  				kfree(a);
> @@ -179,9 +170,8 @@ int videocodec_register(const struct videocodec *codec)
>  		return -EINVAL;
>  	}
>  
> -	dprintk(2,
> -		"videocodec: register '%s', type: %x, flags %lx, magic %lx\n",
> -		codec->name, codec->type, codec->flags, codec->magic);
> +	zrdev_dbg(zr, "videocodec: register '%s', type: %x, flags %lx, magic %lx\n",
> +		  codec->name, codec->type, codec->flags, codec->magic);
>  
>  	ptr = kzalloc(sizeof(*ptr), GFP_KERNEL);
>  	if (!ptr)
> @@ -190,13 +180,13 @@ int videocodec_register(const struct videocodec *codec)
>  
>  	if (!h) {
>  		codeclist_top = ptr;
> -		dprintk(4, "videocodec: hooked in as first element\n");
> +		zrdev_dbg(zr, "videocodec: hooked in as first element\n");
>  	} else {
>  		while (h->next)
>  			h = h->next;	// find the end
>  		h->next = ptr;
> -		dprintk(4, "videocodec: hooked in after '%s'\n",
> -			h->codec->name);
> +		zrdev_dbg(zr, "videocodec: hooked in after '%s'\n",
> +			  h->codec->name);
>  	}
>  
>  	return 0;
> @@ -212,9 +202,8 @@ int videocodec_unregister(const struct videocodec *codec)
>  		return -EINVAL;
>  	}
>  
> -	dprintk(2,
> -		"videocodec: unregister '%s', type: %x, flags %lx, magic %lx\n",
> -		codec->name, codec->type, codec->flags, codec->magic);
> +	zrdev_dbg(zr, "videocodec: unregister '%s', type: %x, flags %lx, magic %lx\n",
> +		  codec->name, codec->type, codec->flags, codec->magic);
>  
>  	if (!h) {
>  		zrdev_err(zr, "%s: no device left...\n", __func__);
> @@ -227,16 +216,14 @@ int videocodec_unregister(const struct videocodec *codec)
>  				zrdev_err(zr, "videocodec: '%s' is used\n", h->codec->name);
>  				return -EBUSY;
>  			}
> -			dprintk(3, "videocodec: unregister '%s' is ok.\n",
> -				h->codec->name);
> +			zrdev_dbg(zr, "videocodec: unregister '%s' is ok.\n",
> +				  h->codec->name);
>  			if (!prev) {
>  				codeclist_top = h->next;
> -				dprintk(4,
> -					"videocodec: delete first element\n");
> +				zrdev_dbg(zr, "videocodec: delete first element\n");
>  			} else {
>  				prev->next = h->next;
> -				dprintk(4,
> -					"videocodec: delete middle element\n");
> +				zrdev_dbg(zr, "videocodec: delete middle element\n");
>  			}
>  			kfree(h);
>  			return 0;
> diff --git a/drivers/staging/media/zoran/zr36016.c b/drivers/staging/media/zoran/zr36016.c
> index 3e3376af0cfa..afdd74e7c59f 100644
> --- a/drivers/staging/media/zoran/zr36016.c
> +++ b/drivers/staging/media/zoran/zr36016.c
> @@ -22,16 +22,6 @@
>  /* amount of chips attached via this driver */
>  static int zr36016_codecs;
>  
> -static int zr36016_debug;
> -module_param(zr36016_debug, int, 0);
> -MODULE_PARM_DESC(zr36016_debug, "Debug level (0-4)");
> -
> -#define dprintk(num, format, args...) \
> -	do { \
> -		if (zr36016_debug >= num) \
> -			printk(format, ##args); \
> -	} while (0)
> -
>  /* =========================================================================
>     Local hardware I/O functions:
>  
> @@ -50,7 +40,7 @@ static u8 zr36016_read(struct zr36016 *ptr, u16 reg)
>  	else
>  		zrdev_err(zr, "%s: invalid I/O setup, nothing read!\n", ptr->name);
>  
> -	dprintk(4, "%s: reading from 0x%04x: %02x\n", ptr->name, reg, value);
> +	zrdev_dbg(zr, "%s: reading from 0x%04x: %02x\n", ptr->name, reg, value);
>  
>  	return value;
>  }
> @@ -59,7 +49,7 @@ static void zr36016_write(struct zr36016 *ptr, u16 reg, u8 value)
>  {
>  	struct zoran *zr = videocodec_to_zoran(ptr->codec);
>  
> -	dprintk(4, "%s: writing 0x%02x to 0x%04x\n", ptr->name, value, reg);
> +	zrdev_dbg(zr, "%s: writing 0x%02x to 0x%04x\n", ptr->name, value, reg);
>  
>  	// just in case something is wrong...
>  	if (ptr->codec->master_data->writereg)
> @@ -84,7 +74,7 @@ static u8 zr36016_readi(struct zr36016 *ptr, u16 reg)
>  		zrdev_err(zr, "%s: invalid I/O setup, nothing read (i)!\n", ptr->name);
>  	}
>  
> -	dprintk(4, "%s: reading indirect from 0x%04x: %02x\n", ptr->name, reg, value);
> +	zrdev_dbg(zr, "%s: reading indirect from 0x%04x: %02x\n", ptr->name, reg, value);
>  	return value;
>  }
>  
> @@ -92,8 +82,8 @@ static void zr36016_writei(struct zr36016 *ptr, u16 reg, u8 value)
>  {
>  	struct zoran *zr = videocodec_to_zoran(ptr->codec);
>  
> -	dprintk(4, "%s: writing indirect 0x%02x to 0x%04x\n", ptr->name,
> -		value, reg);
> +	zrdev_dbg(zr, "%s: writing indirect 0x%02x to 0x%04x\n", ptr->name,
> +		  value, reg);
>  
>  	/* just in case something is wrong... */
>  	if (ptr->codec->master_data->writereg) {
> @@ -127,14 +117,14 @@ static int zr36016_basic_test(struct zr36016 *ptr)
>  {
>  	struct zoran *zr = videocodec_to_zoran(ptr->codec);
>  
> -	if (zr36016_debug) {
> +	if (*KERN_INFO <= CONSOLE_LOGLEVEL_DEFAULT) {
>  		int i;
>  
>  		zr36016_writei(ptr, ZR016I_PAX_LO, 0x55);
> -		dprintk(1, KERN_INFO "%s: registers: ", ptr->name);
> +		zrdev_info(zr, "%s: registers: ", ptr->name);
>  		for (i = 0; i <= 0x0b; i++)
> -			dprintk(1, "%02x ", zr36016_readi(ptr, i));
> -		dprintk(1, "\n");
> +			zrdev_dbg(zr, "%02x ", zr36016_readi(ptr, i));
> +		zrdev_dbg(zr, "\n");
>  	}
>  	// for testing just write 0, then the default value to a register and read
>  	// it back in both cases
> @@ -171,10 +161,11 @@ static int zr36016_pushit(struct zr36016 *ptr,
>  			   u16             len,
>  			   const char     *data)
>  {
> +	struct zoran *zr = videocodec_to_zoran(ptr->codec);
>  	int i = 0;
>  
> -	dprintk(4, "%s: write data block to 0x%04x (len=%d)\n",
> -		ptr->name, startreg, len);
> +	zrdev_dbg(zr, "%s: write data block to 0x%04x (len=%d)\n",
> +		  ptr->name, startreg, len);
>  	while (i < len) {
>  		zr36016_writei(ptr, startreg++,  data[i++]);
>  	}
> @@ -232,8 +223,9 @@ static void zr36016_init(struct zr36016 *ptr)
>  static int zr36016_set_mode(struct videocodec *codec, int mode)
>  {
>  	struct zr36016 *ptr = (struct zr36016 *)codec->data;
> +	struct zoran *zr = videocodec_to_zoran(codec);
>  
> -	dprintk(2, "%s: set_mode %d call\n", ptr->name, mode);
> +	zrdev_dbg(zr, "%s: set_mode %d call\n", ptr->name, mode);
>  
>  	if ((mode != CODEC_DO_EXPANSION) && (mode != CODEC_DO_COMPRESSION))
>  		return -EINVAL;
> @@ -249,11 +241,12 @@ static int zr36016_set_video(struct videocodec *codec, const struct tvnorm *norm
>  			     struct vfe_settings *cap, struct vfe_polarity *pol)
>  {
>  	struct zr36016 *ptr = (struct zr36016 *)codec->data;
> +	struct zoran *zr = videocodec_to_zoran(codec);
>  
> -	dprintk(2, "%s: set_video %d.%d, %d/%d-%dx%d (0x%x) call\n",
> -		ptr->name, norm->h_start, norm->v_start,
> -		cap->x, cap->y, cap->width, cap->height,
> -		cap->decimation);
> +	zrdev_dbg(zr, "%s: set_video %d.%d, %d/%d-%dx%d (0x%x) call\n",
> +		  ptr->name, norm->h_start, norm->v_start,
> +		  cap->x, cap->y, cap->width, cap->height,
> +		  cap->decimation);
>  
>  	/* if () return -EINVAL;
>  	 * trust the master driver that it knows what it does - so
> @@ -283,9 +276,10 @@ static int zr36016_set_video(struct videocodec *codec, const struct tvnorm *norm
>  static int zr36016_control(struct videocodec *codec, int type, int size, void *data)
>  {
>  	struct zr36016 *ptr = (struct zr36016 *)codec->data;
> +	struct zoran *zr = videocodec_to_zoran(codec);
>  	int *ival = (int *)data;
>  
> -	dprintk(2, "%s: control %d call with %d byte\n", ptr->name, type, size);
> +	zrdev_dbg(zr, "%s: control %d call with %d byte\n", ptr->name, type, size);
>  
>  	switch (type) {
>  	case CODEC_G_STATUS:	/* get last status - we don't know it ... */
> @@ -332,11 +326,12 @@ static int zr36016_control(struct videocodec *codec, int type, int size, void *d
>  static int zr36016_unset(struct videocodec *codec)
>  {
>  	struct zr36016 *ptr = codec->data;
> +	struct zoran *zr = videocodec_to_zoran(codec);
>  
>  	if (ptr) {
>  		/* do wee need some codec deinit here, too ???? */
>  
> -		dprintk(1, "%s: finished codec #%d\n", ptr->name, ptr->num);
> +		zrdev_dbg(zr, "%s: finished codec #%d\n", ptr->name, ptr->num);
>  		kfree(ptr);
>  		codec->data = NULL;
>  
> @@ -362,7 +357,7 @@ static int zr36016_setup(struct videocodec *codec)
>  	struct zr36016 *ptr;
>  	int res;
>  
> -	dprintk(2, "zr36016: initializing VFE subsystem #%d.\n", zr36016_codecs);
> +	zrdev_dbg(zr, "zr36016: initializing VFE subsystem #%d.\n", zr36016_codecs);
>  
>  	if (zr36016_codecs == MAX_CODECS) {
>  		zrdev_err(zr, "zr36016: Can't attach more codecs!\n");
> @@ -392,7 +387,7 @@ static int zr36016_setup(struct videocodec *codec)
>  	ptr->ydec = 0;
>  	zr36016_init(ptr);
>  
> -	dprintk(1, KERN_INFO "%s: codec v%d attached and running\n", ptr->name, ptr->version);
> +	zrdev_info(zr, "%s: codec v%d attached and running\n", ptr->name, ptr->version);
>  
>  	return 0;
>  }
> @@ -425,9 +420,8 @@ int zr36016_init_module(void)
>  void zr36016_cleanup_module(void)
>  {
>  	if (zr36016_codecs) {
> -		dprintk(1,
> -			"zr36016: something's wrong - %d codecs left somehow.\n",
> -			zr36016_codecs);
> +		pr_debug("zr36016: something's wrong - %d codecs left somehow.\n",
> +			 zr36016_codecs);
>  	}
>  	videocodec_unregister(&zr36016_codec);
>  }
> diff --git a/drivers/staging/media/zoran/zr36050.c b/drivers/staging/media/zoran/zr36050.c
> index 950dd79f5c81..b26b0711461c 100644
> --- a/drivers/staging/media/zoran/zr36050.c
> +++ b/drivers/staging/media/zoran/zr36050.c
> @@ -29,17 +29,6 @@
>  /* amount of chips attached via this driver */
>  static int zr36050_codecs;
>  
> -/* debugging is available via module parameter */
> -static int zr36050_debug;
> -module_param(zr36050_debug, int, 0);
> -MODULE_PARM_DESC(zr36050_debug, "Debug level (0-4)");
> -
> -#define dprintk(num, format, args...) \
> -	do { \
> -		if (zr36050_debug >= num) \
> -			printk(format, ##args); \
> -	} while (0)
> -
>  /* =========================================================================
>     Local hardware I/O functions:
>  
> @@ -49,32 +38,32 @@ MODULE_PARM_DESC(zr36050_debug, "Debug level (0-4)");
>  /* read and write functions */
>  static u8 zr36050_read(struct zr36050 *ptr, u16 reg)
>  {
> +	struct zoran *zr = videocodec_to_zoran(ptr->codec);
>  	u8 value = 0;
>  
>  	/* just in case something is wrong... */
>  	if (ptr->codec->master_data->readreg)
>  		value = (ptr->codec->master_data->readreg(ptr->codec, reg)) & 0xFF;
>  	else
> -		dprintk(1,
> -			KERN_ERR "%s: invalid I/O setup, nothing read!\n", ptr->name);
> +		zrdev_err(zr, "%s: invalid I/O setup, nothing read!\n", ptr->name);
>  
> -	dprintk(4, "%s: reading from 0x%04x: %02x\n", ptr->name, reg, value);
> +	zrdev_dbg(zr, "%s: reading from 0x%04x: %02x\n", ptr->name, reg, value);
>  
>  	return value;
>  }
>  
>  static void zr36050_write(struct zr36050 *ptr, u16 reg, u8 value)
>  {
> -	dprintk(4, "%s: writing 0x%02x to 0x%04x\n", ptr->name, value, reg);
> +	struct zoran *zr = videocodec_to_zoran(ptr->codec);
> +
> +	zrdev_dbg(zr, "%s: writing 0x%02x to 0x%04x\n", ptr->name, value, reg);
>  
>  	/* just in case something is wrong... */
>  	if (ptr->codec->master_data->writereg)
>  		ptr->codec->master_data->writereg(ptr->codec, reg, value);
>  	else
> -		dprintk(1,
> -			KERN_ERR
> -			"%s: invalid I/O setup, nothing written!\n",
> -			ptr->name);
> +		zrdev_err(zr, "%s: invalid I/O setup, nothing written!\n",
> +			  ptr->name);
>  }
>  
>  /* =========================================================================
> @@ -117,14 +106,14 @@ static u16 zr36050_read_scalefactor(struct zr36050 *ptr)
>  
>  static void zr36050_wait_end(struct zr36050 *ptr)
>  {
> +	struct zoran *zr = videocodec_to_zoran(ptr->codec);
>  	int i = 0;
>  
>  	while (!(zr36050_read_status1(ptr) & 0x4)) {
>  		udelay(1);
>  		if (i++ > 200000) {	// 200ms, there is for sure something wrong!!!
> -			dprintk(1,
> -				"%s: timeout at wait_end (last status: 0x%02x)\n",
> -				ptr->name, ptr->status1);
> +			zrdev_dbg(zr, "%s: timeout at wait_end (last status: 0x%02x)\n",
> +				  ptr->name, ptr->status1);
>  			break;
>  		}
>  	}
> @@ -138,33 +127,29 @@ static void zr36050_wait_end(struct zr36050 *ptr)
>  
>  static int zr36050_basic_test(struct zr36050 *ptr)
>  {
> +	struct zoran *zr = videocodec_to_zoran(ptr->codec);
> +
>  	zr36050_write(ptr, ZR050_SOF_IDX, 0x00);
>  	zr36050_write(ptr, ZR050_SOF_IDX + 1, 0x00);
>  	if ((zr36050_read(ptr, ZR050_SOF_IDX) |
>  	     zr36050_read(ptr, ZR050_SOF_IDX + 1)) != 0x0000) {
> -		dprintk(1,
> -			KERN_ERR
> -			"%s: attach failed, can't connect to jpeg processor!\n",
> -			ptr->name);
> +		zrdev_err(zr, "%s: attach failed, can't connect to jpeg processor!\n",
> +			  ptr->name);
>  		return -ENXIO;
>  	}
>  	zr36050_write(ptr, ZR050_SOF_IDX, 0xff);
>  	zr36050_write(ptr, ZR050_SOF_IDX + 1, 0xc0);
>  	if (((zr36050_read(ptr, ZR050_SOF_IDX) << 8) |
>  	     zr36050_read(ptr, ZR050_SOF_IDX + 1)) != 0xffc0) {
> -		dprintk(1,
> -			KERN_ERR
> -			"%s: attach failed, can't connect to jpeg processor!\n",
> -			ptr->name);
> +		zrdev_err(zr, "%s: attach failed, can't connect to jpeg processor!\n",
> +			  ptr->name);
>  		return -ENXIO;
>  	}
>  
>  	zr36050_wait_end(ptr);
>  	if ((ptr->status1 & 0x4) == 0) {
> -		dprintk(1,
> -			KERN_ERR
> -			"%s: attach failed, jpeg processor failed (end flag)!\n",
> -			ptr->name);
> +		zrdev_err(zr, "%s: attach failed, jpeg processor failed (end flag)!\n",
> +			  ptr->name);
>  		return -EBUSY;
>  	}
>  
> @@ -179,10 +164,11 @@ static int zr36050_basic_test(struct zr36050 *ptr)
>  
>  static int zr36050_pushit(struct zr36050 *ptr, u16 startreg, u16 len, const char *data)
>  {
> +	struct zoran *zr = videocodec_to_zoran(ptr->codec);
>  	int i = 0;
>  
> -	dprintk(4, "%s: write data block to 0x%04x (len=%d)\n", ptr->name,
> -		startreg, len);
> +	zrdev_dbg(zr, "%s: write data block to 0x%04x (len=%d)\n", ptr->name,
> +		  startreg, len);
>  	while (i < len)
>  		zr36050_write(ptr, startreg++, data[i++]);
>  
> @@ -305,11 +291,12 @@ static const char zr36050_decimation_v[8] = { 1, 1, 1, 0, 0, 0, 0, 0 };
>  
>  static int zr36050_set_sof(struct zr36050 *ptr)
>  {
> +	struct zoran *zr = videocodec_to_zoran(ptr->codec);
>  	char sof_data[34];	// max. size of register set
>  	int i;
>  
> -	dprintk(3, "%s: write SOF (%dx%d, %d components)\n", ptr->name,
> -		ptr->width, ptr->height, NO_OF_COMPONENTS);
> +	zrdev_dbg(zr, "%s: write SOF (%dx%d, %d components)\n", ptr->name,
> +		  ptr->width, ptr->height, NO_OF_COMPONENTS);
>  	sof_data[0] = 0xff;
>  	sof_data[1] = 0xc0;
>  	sof_data[2] = 0x00;
> @@ -336,10 +323,11 @@ static int zr36050_set_sof(struct zr36050 *ptr)
>  
>  static int zr36050_set_sos(struct zr36050 *ptr)
>  {
> +	struct zoran *zr = videocodec_to_zoran(ptr->codec);
>  	char sos_data[16];	// max. size of register set
>  	int i;
>  
> -	dprintk(3, "%s: write SOS\n", ptr->name);
> +	zrdev_dbg(zr, "%s: write SOS\n", ptr->name);
>  	sos_data[0] = 0xff;
>  	sos_data[1] = 0xda;
>  	sos_data[2] = 0x00;
> @@ -363,9 +351,10 @@ static int zr36050_set_sos(struct zr36050 *ptr)
>  
>  static int zr36050_set_dri(struct zr36050 *ptr)
>  {
> +	struct zoran *zr = videocodec_to_zoran(ptr->codec);
>  	char dri_data[6];	// max. size of register set
>  
> -	dprintk(3, "%s: write DRI\n", ptr->name);
> +	zrdev_dbg(zr, "%s: write DRI\n", ptr->name);
>  	dri_data[0] = 0xff;
>  	dri_data[1] = 0xdd;
>  	dri_data[2] = 0x00;
> @@ -390,7 +379,7 @@ static void zr36050_init(struct zr36050 *ptr)
>  	long bitcnt, tmp;
>  
>  	if (ptr->mode == CODEC_DO_COMPRESSION) {
> -		dprintk(2, "%s: COMPRESSION SETUP\n", ptr->name);
> +		zrdev_dbg(zr, "%s: COMPRESSION SETUP\n", ptr->name);
>  
>  		/* 050 communicates with 057 in master mode */
>  		zr36050_write(ptr, ZR050_HARDWARE, ZR050_HW_MSTR);
> @@ -420,7 +409,7 @@ static void zr36050_init(struct zr36050 *ptr)
>  
>  		/* setup the fixed jpeg tables - maybe variable, though -
>  		 * (see table init section above) */
> -		dprintk(3, "%s: write DQT, DHT, APP\n", ptr->name);
> +		zrdev_dbg(zr, "%s: write DQT, DHT, APP\n", ptr->name);
>  		sum += zr36050_pushit(ptr, ZR050_DQT_IDX,
>  				      sizeof(zr36050_dqt), zr36050_dqt);
>  		sum += zr36050_pushit(ptr, ZR050_DHT_IDX,
> @@ -443,8 +432,8 @@ static void zr36050_init(struct zr36050 *ptr)
>  
>  		zr36050_write(ptr, ZR050_GO, 1);	// launch codec
>  		zr36050_wait_end(ptr);
> -		dprintk(2, "%s: Status after table preload: 0x%02x\n",
> -			ptr->name, ptr->status1);
> +		zrdev_dbg(zr, "%s: Status after table preload: 0x%02x\n",
> +			  ptr->name, ptr->status1);
>  
>  		if ((ptr->status1 & 0x4) == 0) {
>  			zrdev_err(zr, "%s: init aborted!\n", ptr->name);
> @@ -458,9 +447,8 @@ static void zr36050_init(struct zr36050 *ptr)
>  		bitcnt = sum << 3;	/* need the size in bits */
>  
>  		tmp = bitcnt >> 16;
> -		dprintk(3,
> -			"%s: code: csize=%d, tot=%d, bit=%ld, highbits=%ld\n",
> -			ptr->name, sum, ptr->real_code_vol, bitcnt, tmp);
> +		zrdev_dbg(zr, "%s: code: csize=%d, tot=%d, bit=%ld, highbits=%ld\n",
> +			  ptr->name, sum, ptr->real_code_vol, bitcnt, tmp);
>  		zr36050_write(ptr, ZR050_TCV_NET_HI, tmp >> 8);
>  		zr36050_write(ptr, ZR050_TCV_NET_MH, tmp & 0xff);
>  		tmp = bitcnt & 0xffff;
> @@ -471,8 +459,8 @@ static void zr36050_init(struct zr36050 *ptr)
>  		bitcnt -= ((bitcnt * 5) >> 6);	// bits without eob
>  
>  		tmp = bitcnt >> 16;
> -		dprintk(3, "%s: code: nettobit=%ld, highnettobits=%ld\n",
> -			ptr->name, bitcnt, tmp);
> +		zrdev_dbg(zr, "%s: code: nettobit=%ld, highnettobits=%ld\n",
> +			  ptr->name, bitcnt, tmp);
>  		zr36050_write(ptr, ZR050_TCV_DATA_HI, tmp >> 8);
>  		zr36050_write(ptr, ZR050_TCV_DATA_MH, tmp & 0xff);
>  		tmp = bitcnt & 0xffff;
> @@ -490,7 +478,7 @@ static void zr36050_init(struct zr36050 *ptr)
>  			      ((ptr->app.len > 0) ? ZR050_ME_APP : 0) |
>  			      ((ptr->com.len > 0) ? ZR050_ME_COM : 0));
>  	} else {
> -		dprintk(2, "%s: EXPANSION SETUP\n", ptr->name);
> +		zrdev_dbg(zr, "%s: EXPANSION SETUP\n", ptr->name);
>  
>  		/* 050 communicates with 055 in master mode */
>  		zr36050_write(ptr, ZR050_HARDWARE,
> @@ -503,7 +491,7 @@ static void zr36050_init(struct zr36050 *ptr)
>  		zr36050_write(ptr, ZR050_INT_REQ_0, 0);
>  		zr36050_write(ptr, ZR050_INT_REQ_1, 3);	// low 2 bits always 1
>  
> -		dprintk(3, "%s: write DHT\n", ptr->name);
> +		zrdev_dbg(zr, "%s: write DHT\n", ptr->name);
>  		zr36050_pushit(ptr, ZR050_DHT_IDX, sizeof(zr36050_dht),
>  			       zr36050_dht);
>  
> @@ -512,8 +500,8 @@ static void zr36050_init(struct zr36050 *ptr)
>  
>  		zr36050_write(ptr, ZR050_GO, 1);	// launch codec
>  		zr36050_wait_end(ptr);
> -		dprintk(2, "%s: Status after table preload: 0x%02x\n",
> -			ptr->name, ptr->status1);
> +		zrdev_dbg(zr, "%s: Status after table preload: 0x%02x\n",
> +			  ptr->name, ptr->status1);
>  
>  		if ((ptr->status1 & 0x4) == 0) {
>  			zrdev_err(zr, "%s: init aborted!\n", ptr->name);
> @@ -540,8 +528,9 @@ static void zr36050_init(struct zr36050 *ptr)
>  static int zr36050_set_mode(struct videocodec *codec, int mode)
>  {
>  	struct zr36050 *ptr = (struct zr36050 *)codec->data;
> +	struct zoran *zr = videocodec_to_zoran(codec);
>  
> -	dprintk(2, "%s: set_mode %d call\n", ptr->name, mode);
> +	zrdev_dbg(zr, "%s: set_mode %d call\n", ptr->name, mode);
>  
>  	if ((mode != CODEC_DO_EXPANSION) && (mode != CODEC_DO_COMPRESSION))
>  		return -EINVAL;
> @@ -557,12 +546,13 @@ static int zr36050_set_video(struct videocodec *codec, const struct tvnorm *norm
>  			     struct vfe_settings *cap, struct vfe_polarity *pol)
>  {
>  	struct zr36050 *ptr = (struct zr36050 *)codec->data;
> +	struct zoran *zr = videocodec_to_zoran(codec);
>  	int size;
>  
> -	dprintk(2, "%s: set_video %d.%d, %d/%d-%dx%d (0x%x) q%d call\n",
> -		ptr->name, norm->h_start, norm->v_start,
> -		cap->x, cap->y, cap->width, cap->height,
> -		cap->decimation, cap->quality);
> +	zrdev_dbg(zr, "%s: set_video %d.%d, %d/%d-%dx%d (0x%x) q%d call\n",
> +		  ptr->name, norm->h_start, norm->v_start,
> +		  cap->x, cap->y, cap->width, cap->height,
> +		  cap->decimation, cap->quality);
>  	/* if () return -EINVAL;
>  	 * trust the master driver that it knows what it does - so
>  	 * we allow invalid startx/y and norm for now ... */
> @@ -595,10 +585,11 @@ static int zr36050_set_video(struct videocodec *codec, const struct tvnorm *norm
>  static int zr36050_control(struct videocodec *codec, int type, int size, void *data)
>  {
>  	struct zr36050 *ptr = (struct zr36050 *)codec->data;
> +	struct zoran *zr = videocodec_to_zoran(codec);
>  	int *ival = (int *)data;
>  
> -	dprintk(2, "%s: control %d call with %d byte\n", ptr->name, type,
> -		size);
> +	zrdev_dbg(zr, "%s: control %d call with %d byte\n", ptr->name, type,
> +		  size);
>  
>  	switch (type) {
>  	case CODEC_G_STATUS:	/* get last status */
> @@ -714,12 +705,12 @@ static int zr36050_control(struct videocodec *codec, int type, int size, void *d
>  static int zr36050_unset(struct videocodec *codec)
>  {
>  	struct zr36050 *ptr = codec->data;
> +	struct zoran *zr = videocodec_to_zoran(codec);
>  
>  	if (ptr) {
>  		/* do wee need some codec deinit here, too ???? */
>  
> -		dprintk(1, "%s: finished codec #%d\n", ptr->name,
> -			ptr->num);
> +		zrdev_dbg(zr, "%s: finished codec #%d\n", ptr->name, ptr->num);
>  		kfree(ptr);
>  		codec->data = NULL;
>  
> @@ -742,14 +733,14 @@ static int zr36050_unset(struct videocodec *codec)
>  static int zr36050_setup(struct videocodec *codec)
>  {
>  	struct zr36050 *ptr;
> +	struct zoran *zr = videocodec_to_zoran(codec);
>  	int res;
>  
> -	dprintk(2, "zr36050: initializing MJPEG subsystem #%d.\n",
> -		zr36050_codecs);
> +	zrdev_dbg(zr, "zr36050: initializing MJPEG subsystem #%d.\n",
> +		  zr36050_codecs);
>  
>  	if (zr36050_codecs == MAX_CODECS) {
> -		dprintk(1,
> -			KERN_ERR "zr36050: Can't attach more codecs!\n");
> +		zrdev_err(zr, "zr36050: Can't attach more codecs!\n");
>  		return -ENOSPC;
>  	}
>  	//mem structure init
> @@ -790,8 +781,7 @@ static int zr36050_setup(struct videocodec *codec)
>  
>  	zr36050_init(ptr);
>  
> -	dprintk(1, KERN_INFO "%s: codec attached and running\n",
> -		ptr->name);
> +	zrdev_info(zr, "%s: codec attached and running\n", ptr->name);
>  
>  	return 0;
>  }
> @@ -824,9 +814,8 @@ int zr36050_init_module(void)
>  void zr36050_cleanup_module(void)
>  {
>  	if (zr36050_codecs) {
> -		dprintk(1,
> -			"zr36050: something's wrong - %d codecs left somehow.\n",
> -			zr36050_codecs);
> +		pr_debug("zr36050: something's wrong - %d codecs left somehow.\n",
> +			 zr36050_codecs);
>  	}
>  	videocodec_unregister(&zr36050_codec);
>  }
> diff --git a/drivers/staging/media/zoran/zr36060.c b/drivers/staging/media/zoran/zr36060.c
> index c09910669585..81e8bfd05d6a 100644
> --- a/drivers/staging/media/zoran/zr36060.c
> +++ b/drivers/staging/media/zoran/zr36060.c
> @@ -32,16 +32,6 @@ static bool low_bitrate;
>  module_param(low_bitrate, bool, 0);
>  MODULE_PARM_DESC(low_bitrate, "Buz compatibility option, halves bitrate");
>  
> -static int zr36060_debug;
> -module_param(zr36060_debug, int, 0);
> -MODULE_PARM_DESC(zr36060_debug, "Debug level (0-4)");
> -
> -#define dprintk(num, format, args...) \
> -	do { \
> -		if (zr36060_debug >= num) \
> -			printk(format, ##args); \
> -	} while (0)
> -
>  /* =========================================================================
>   * Local hardware I/O functions:
>   * read/write via codec layer (registers are located in the master device)
> @@ -66,7 +56,7 @@ static void zr36060_write(struct zr36060 *ptr, u16 reg, u8 value)
>  {
>  	struct zoran *zr = videocodec_to_zoran(ptr->codec);
>  
> -	dprintk(4, "0x%02x @0x%04x\n", value, reg);
> +	zrdev_dbg(zr, "0x%02x @0x%04x\n", value, reg);
>  
>  	// just in case something is wrong...
>  	if (ptr->codec->master_data->writereg)
> @@ -104,14 +94,14 @@ static u16 zr36060_read_scalefactor(struct zr36060 *ptr)
>  /* wait if codec is ready to proceed (end of processing) or time is over */
>  static void zr36060_wait_end(struct zr36060 *ptr)
>  {
> +	struct zoran *zr = videocodec_to_zoran(ptr->codec);
>  	int i = 0;
>  
>  	while (zr36060_read_status(ptr) & ZR060_CFSR_BUSY) {
>  		udelay(1);
>  		if (i++ > 200000) {	// 200ms, there is for sure something wrong!!!
> -			dprintk(1,
> -				"%s: timeout at wait_end (last status: 0x%02x)\n",
> -				ptr->name, ptr->status);
> +			zrdev_dbg(zr, "%s: timeout at wait_end (last status: 0x%02x)\n",
> +				  ptr->name, ptr->status);
>  			break;
>  		}
>  	}
> @@ -140,10 +130,11 @@ static int zr36060_basic_test(struct zr36060 *ptr)
>  /* simple loop for pushing the init datasets */
>  static int zr36060_pushit(struct zr36060 *ptr, u16 startreg, u16 len, const char *data)
>  {
> +	struct zoran *zr = videocodec_to_zoran(ptr->codec);
>  	int i = 0;
>  
> -	dprintk(4, "%s: write data block to 0x%04x (len=%d)\n", ptr->name,
> -		startreg, len);
> +	zrdev_dbg(zr, "%s: write data block to 0x%04x (len=%d)\n", ptr->name,
> +		  startreg, len);
>  	while (i < len)
>  		zr36060_write(ptr, startreg++, data[i++]);
>  
> @@ -254,11 +245,12 @@ static const char zr36060_decimation_v[8] = { 1, 1, 1, 0, 0, 0, 0, 0 };
>  /* SOF (start of frame) segment depends on width, height and sampling ratio of each color component */
>  static int zr36060_set_sof(struct zr36060 *ptr)
>  {
> +	struct zoran *zr = videocodec_to_zoran(ptr->codec);
>  	char sof_data[34];	// max. size of register set
>  	int i;
>  
> -	dprintk(3, "%s: write SOF (%dx%d, %d components)\n", ptr->name,
> -		ptr->width, ptr->height, NO_OF_COMPONENTS);
> +	zrdev_dbg(zr, "%s: write SOF (%dx%d, %d components)\n", ptr->name,
> +		  ptr->width, ptr->height, NO_OF_COMPONENTS);
>  	sof_data[0] = 0xff;
>  	sof_data[1] = 0xc0;
>  	sof_data[2] = 0x00;
> @@ -282,10 +274,11 @@ static int zr36060_set_sof(struct zr36060 *ptr)
>  /* SOS (start of scan) segment depends on the used scan components of each color component */
>  static int zr36060_set_sos(struct zr36060 *ptr)
>  {
> +	struct zoran *zr = videocodec_to_zoran(ptr->codec);
>  	char sos_data[16];	// max. size of register set
>  	int i;
>  
> -	dprintk(3, "%s: write SOS\n", ptr->name);
> +	zrdev_dbg(zr, "%s: write SOS\n", ptr->name);
>  	sos_data[0] = 0xff;
>  	sos_data[1] = 0xda;
>  	sos_data[2] = 0x00;
> @@ -307,9 +300,10 @@ static int zr36060_set_sos(struct zr36060 *ptr)
>  /* DRI (define restart interval) */
>  static int zr36060_set_dri(struct zr36060 *ptr)
>  {
> +	struct zoran *zr = videocodec_to_zoran(ptr->codec);
>  	char dri_data[6];	// max. size of register set
>  
> -	dprintk(3, "%s: write DRI\n", ptr->name);
> +	zrdev_dbg(zr, "%s: write DRI\n", ptr->name);
>  	dri_data[0] = 0xff;
>  	dri_data[1] = 0xdd;
>  	dri_data[2] = 0x00;
> @@ -329,7 +323,7 @@ static void zr36060_init(struct zr36060 *ptr)
>  	long bitcnt, tmp;
>  
>  	if (ptr->mode == CODEC_DO_COMPRESSION) {
> -		dprintk(2, "%s: COMPRESSION SETUP\n", ptr->name);
> +		zrdev_dbg(zr, "%s: COMPRESSION SETUP\n", ptr->name);
>  
>  		zr36060_write(ptr, ZR060_LOAD, ZR060_LOAD_SYNC_RST);
>  
> @@ -382,9 +376,8 @@ static void zr36060_init(struct zr36060 *ptr)
>  		bitcnt = sum << 3;	/* need the size in bits */
>  
>  		tmp = bitcnt >> 16;
> -		dprintk(3,
> -			"%s: code: csize=%d, tot=%d, bit=%ld, highbits=%ld\n",
> -			ptr->name, sum, ptr->real_code_vol, bitcnt, tmp);
> +		zrdev_dbg(zr, "%s: code: csize=%d, tot=%d, bit=%ld, highbits=%ld\n",
> +			  ptr->name, sum, ptr->real_code_vol, bitcnt, tmp);
>  		zr36060_write(ptr, ZR060_TCV_NET_HI, tmp >> 8);
>  		zr36060_write(ptr, ZR060_TCV_NET_MH, tmp & 0xff);
>  		tmp = bitcnt & 0xffff;
> @@ -395,8 +388,8 @@ static void zr36060_init(struct zr36060 *ptr)
>  		bitcnt -= ((bitcnt * 5) >> 6);	// bits without eob
>  
>  		tmp = bitcnt >> 16;
> -		dprintk(3, "%s: code: nettobit=%ld, highnettobits=%ld\n",
> -			ptr->name, bitcnt, tmp);
> +		zrdev_dbg(zr, "%s: code: nettobit=%ld, highnettobits=%ld\n",
> +			  ptr->name, bitcnt, tmp);
>  		zr36060_write(ptr, ZR060_TCV_DATA_HI, tmp >> 8);
>  		zr36060_write(ptr, ZR060_TCV_DATA_MH, tmp & 0xff);
>  		tmp = bitcnt & 0xffff;
> @@ -414,7 +407,7 @@ static void zr36060_init(struct zr36060 *ptr)
>  		zr36060_write(ptr, ZR060_VCR, ZR060_VCR_RANGE);
>  
>  	} else {
> -		dprintk(2, "%s: EXPANSION SETUP\n", ptr->name);
> +		zrdev_dbg(zr, "%s: EXPANSION SETUP\n", ptr->name);
>  
>  		zr36060_write(ptr, ZR060_LOAD, ZR060_LOAD_SYNC_RST);
>  
> @@ -447,7 +440,7 @@ static void zr36060_init(struct zr36060 *ptr)
>  	/* Load the tables */
>  	zr36060_write(ptr, ZR060_LOAD, ZR060_LOAD_SYNC_RST | ZR060_LOAD_LOAD);
>  	zr36060_wait_end(ptr);
> -	dprintk(2, "%s: Status after table preload: 0x%02x\n", ptr->name, ptr->status);
> +	zrdev_dbg(zr, "%s: Status after table preload: 0x%02x\n", ptr->name, ptr->status);
>  
>  	if (ptr->status & ZR060_CFSR_BUSY) {
>  		zrdev_err(zr, "%s: init aborted!\n", ptr->name);
> @@ -467,8 +460,9 @@ static void zr36060_init(struct zr36060 *ptr)
>  static int zr36060_set_mode(struct videocodec *codec, int mode)
>  {
>  	struct zr36060 *ptr = (struct zr36060 *)codec->data;
> +	struct zoran *zr = videocodec_to_zoran(codec);
>  
> -	dprintk(2, "%s: set_mode %d call\n", ptr->name, mode);
> +	zrdev_dbg(zr, "%s: set_mode %d call\n", ptr->name, mode);
>  
>  	if (mode != CODEC_DO_EXPANSION && mode != CODEC_DO_COMPRESSION)
>  		return -EINVAL;
> @@ -484,11 +478,12 @@ static int zr36060_set_video(struct videocodec *codec, const struct tvnorm *norm
>  			     struct vfe_settings *cap, struct vfe_polarity *pol)
>  {
>  	struct zr36060 *ptr = (struct zr36060 *)codec->data;
> +	struct zoran *zr = videocodec_to_zoran(codec);
>  	u32 reg;
>  	int size;
>  
> -	dprintk(2, "%s: set_video %d/%d-%dx%d (%%%d) call\n", ptr->name,
> -		cap->x, cap->y, cap->width, cap->height, cap->decimation);
> +	zrdev_dbg(zr, "%s: set_video %d/%d-%dx%d (%%%d) call\n", ptr->name,
> +		  cap->x, cap->y, cap->width, cap->height, cap->decimation);
>  
>  	/* if () return -EINVAL;
>  	 * trust the master driver that it knows what it does - so
> @@ -643,10 +638,11 @@ static int zr36060_set_video(struct videocodec *codec, const struct tvnorm *norm
>  static int zr36060_control(struct videocodec *codec, int type, int size, void *data)
>  {
>  	struct zr36060 *ptr = (struct zr36060 *)codec->data;
> +	struct zoran *zr = videocodec_to_zoran(codec);
>  	int *ival = (int *)data;
>  
> -	dprintk(2, "%s: control %d call with %d byte\n", ptr->name, type,
> -		size);
> +	zrdev_dbg(zr, "%s: control %d call with %d byte\n", ptr->name, type,
> +		  size);
>  
>  	switch (type) {
>  	case CODEC_G_STATUS:	/* get last status */
> @@ -759,11 +755,12 @@ static int zr36060_control(struct videocodec *codec, int type, int size, void *d
>  static int zr36060_unset(struct videocodec *codec)
>  {
>  	struct zr36060 *ptr = codec->data;
> +	struct zoran *zr = videocodec_to_zoran(codec);
>  
>  	if (ptr) {
>  		/* do wee need some codec deinit here, too ???? */
>  
> -		dprintk(1, "%s: finished codec #%d\n", ptr->name, ptr->num);
> +		zrdev_dbg(zr, "%s: finished codec #%d\n", ptr->name, ptr->num);
>  		kfree(ptr);
>  		codec->data = NULL;
>  
> @@ -787,7 +784,7 @@ static int zr36060_setup(struct videocodec *codec)
>  	struct zr36060 *ptr;
>  	int res;
>  
> -	dprintk(2, "zr36060: initializing MJPEG subsystem #%d.\n", zr36060_codecs);
> +	zrdev_dbg(zr, "zr36060: initializing MJPEG subsystem #%d.\n", zr36060_codecs);
>  
>  	if (zr36060_codecs == MAX_CODECS) {
>  		zrdev_err(zr, "zr36060: Can't attach more codecs!\n");
> @@ -830,7 +827,7 @@ static int zr36060_setup(struct videocodec *codec)
>  
>  	zr36060_init(ptr);
>  
> -	dprintk(1, KERN_INFO "%s: codec attached and running\n", ptr->name);
> +	zrdev_info(zr, "%s: codec attached and running\n", ptr->name);
>  
>  	return 0;
>  }
> @@ -859,9 +856,8 @@ int zr36060_init_module(void)
>  void zr36060_cleanup_module(void)
>  {
>  	if (zr36060_codecs) {
> -		dprintk(1,
> -			"zr36060: something's wrong - %d codecs left somehow.\n",
> -			zr36060_codecs);
> +		pr_debug("zr36060: something's wrong - %d codecs left somehow.\n",
> +			 zr36060_codecs);
>  	}
>  
>  	/* however, we can't just stay alive */

