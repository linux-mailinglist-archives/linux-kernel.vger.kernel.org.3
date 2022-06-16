Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D766454DF8A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 12:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376530AbiFPKwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 06:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359357AbiFPKwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 06:52:34 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE26DB55;
        Thu, 16 Jun 2022 03:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655376750; x=1686912750;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FkMwX3n7BLt8msPC+gv9jdQ+dildTIVsFnnTojmG2vE=;
  b=QdC2T24s3U4VoXv8f//P0ZOkLdMU1+mpSLJCSCrsij3L99JNfchXHfau
   36WOujWRNO090A9zNE1F/d3HJ56HM+1Lr+eakVDdfgA/jMZ89gzvrdQ7c
   UnKnYRDqNk0m7V8miiXQ4BKUZpeaS0VxZQWA+U4PvnqkMYVwjw8XhLvGJ
   NRH+a9du4+9a35HJ302vtyrTKVmWYvNguHwmJ72HpCRinTSqbrNT+Kdhz
   KJEfBxLhBsOdWxpqfmIlYPk+2JfPI/fFAeaoQyC0EQBthyTKUODpmAJTe
   B+WNBV9s502tG+2h7iuo19er6ISq6uCreVIH26VBY5eFw3fbTqrOPp0rS
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="262241300"
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="262241300"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 03:52:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="687769984"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga002.fm.intel.com with ESMTP; 16 Jun 2022 03:52:26 -0700
Date:   Thu, 16 Jun 2022 18:44:24 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com, corbet@lwn.net,
        Conor.Dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: Re: [PATCH v19 1/4] fpga: fpga-mgr: support bitstream offset in
 image buffer
Message-ID: <20220616104424.GA1064215@yilunxu-OptiPlex-7050>
References: <20220615110137.21902-1-i.bornyakov@metrotek.ru>
 <20220615110137.21902-2-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615110137.21902-2-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 02:01:34PM +0300, Ivan Bornyakov wrote:
> At the moment FPGA manager core loads to the device entire image
> provided to fpga_mgr_load(). But it is not always whole FPGA image
> buffer meant to be written to the device. In particular, .dat formatted
> image for Microchip MPF contains meta info in the header that is not
> meant to be written to the device. This is issue for those low level
> drivers that loads data to the device with write() fpga_manager_ops
> callback, since write() can be called in iterator over scatter-gather
> table, not only linear image buffer. On the other hand, write_sg()
> callback is provided with whole image in scatter-gather form and can
> decide itself which part should be sent to the device.
> 
> Add header_size and data_size to the fpga_image_info struct and adjust
> fpga_mgr_write() callers with respect to them.
> 
>   * info->header_size indicates part at the beginning of image buffer
>     that is *not* meant to be written to the device. It is optional and
>     can be 0.
> 
>   * info->data_size is the size of actual bitstream data that *is* meant
>     to be written to the device, starting at info->header_size from the
>     beginning of image buffer. It is also optional and can be 0, which
>     means bitstream data is up to the end of image buffer.
> 
> Also add parse_header() callback to fpga_manager_ops, which purpose is
> to set info->header_size and info->data_size. At least
> initial_header_size bytes of image buffer will be passed into
> parse_header() first time. If it is not enough, parse_header() should
> set desired size into info->header_size and return -EAGAIN, then it will
> be called again with greater part of image buffer on the input.
> 
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> ---
>  drivers/fpga/fpga-mgr.c       | 237 ++++++++++++++++++++++++++++++----
>  include/linux/fpga/fpga-mgr.h |  17 ++-
>  2 files changed, 227 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index 08dc85fcd511..52b826b62207 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -74,6 +74,15 @@ static inline int fpga_mgr_write_complete(struct fpga_manager *mgr,
>  	return 0;
>  }
>  
> +static inline int fpga_mgr_parse_header(struct fpga_manager *mgr,
> +					struct fpga_image_info *info,
> +					const char *buf, size_t count)
> +{
> +	if (mgr->mops->parse_header)
> +		return mgr->mops->parse_header(mgr, info, buf, count);
> +	return 0;
> +}
> +
>  static inline int fpga_mgr_write_init(struct fpga_manager *mgr,
>  				      struct fpga_image_info *info,
>  				      const char *buf, size_t count)
> @@ -136,24 +145,146 @@ void fpga_image_info_free(struct fpga_image_info *info)
>  EXPORT_SYMBOL_GPL(fpga_image_info_free);
>  
>  /*
> - * Call the low level driver's write_init function.  This will do the
> + * Call the low level driver's parse_header function with entire FPGA image
> + * buffer on the input. This will set info->header_size and info->data_size.
> + */
> +static int fpga_mgr_parse_header_mapped(struct fpga_manager *mgr,
> +					struct fpga_image_info *info,
> +					const char *buf, size_t count)
> +{
> +	int ret;
> +
> +	mgr->state = FPGA_MGR_STATE_PARSE_HEADER;
> +	ret = fpga_mgr_parse_header(mgr, info, buf, count);
> +
> +	if (info->header_size + info->data_size > count) {
> +		dev_err(&mgr->dev, "Bitsream data outruns FPGA image\n");
> +		ret = -EINVAL;
> +	}
> +
> +	if (ret) {
> +		dev_err(&mgr->dev, "Error while parsing FPGA image header\n");
> +		mgr->state = FPGA_MGR_STATE_PARSE_HEADER_ERR;
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * Call the low level driver's parse_header function with first fragment of
> + * scattered FPGA image on the input. If header fits first fragment,
> + * parse_header will set info->header_size and info->data_size. If it is not,
> + * parse_header will set desired size to info->header_size and -EAGAIN will be
> + * returned.
> + */
> +static int fpga_mgr_parse_header_sg_first(struct fpga_manager *mgr,
> +					  struct fpga_image_info *info,
> +					  struct sg_table *sgt)
> +{
> +	size_t header_size = mgr->mops->initial_header_size;
> +	struct sg_mapping_iter miter;
> +	int ret;
> +
> +	mgr->state = FPGA_MGR_STATE_PARSE_HEADER;
> +
> +	sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
> +	if (sg_miter_next(&miter) &&
> +	    miter.length >= header_size)
> +		ret = fpga_mgr_parse_header(mgr, info, miter.addr, miter.length);
> +	else
> +		ret = -EAGAIN;
> +	sg_miter_stop(&miter);
> +
> +	if (ret && ret != -EAGAIN) {
> +		dev_err(&mgr->dev, "Error while parsing FPGA image header\n");
> +		mgr->state = FPGA_MGR_STATE_PARSE_HEADER_ERR;
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * Copy scattered FPGA image fragments to temporary buffer and call the
> + * low level driver's parse_header function. This should be called after
> + * fpga_mgr_parse_header_sg_first() returned -EAGAIN. In case of success,
> + * pointer to the newly allocated image header copy will be returned and
> + * its size will be set into *ret_size. Returned buffer needs to be freed.
> + */
> +static void *fpga_mgr_parse_header_sg(struct fpga_manager *mgr,
> +				      struct fpga_image_info *info,
> +				      struct sg_table *sgt, size_t *ret_size)
> +{
> +	size_t len, header_size = mgr->mops->initial_header_size;
> +	char *new_buf, *buf = NULL;
> +	int ret;
> +
> +	do {
> +		if (info->header_size)
> +			header_size = info->header_size;
> +
> +		new_buf = krealloc(buf, header_size, GFP_KERNEL);
> +		if (new_buf)
> +			buf = new_buf;
> +
> +		if (ZERO_OR_NULL_PTR(new_buf)) {
> +			ret = -ENOMEM;
> +			break;
> +		}

Could we firstly check header_size? Then we don't have to always
consider ZERO_PTR_SIZE case in mind. Maybe this makes the code
easier to understand.

	do {
		[...]

		if (!header_size) {
			ret = -EFAULT;
			break;
		}

		new_buf = krealloc(buf, header_size, GFP_KERNEL);
		if (!new_buf) {
			ret = -ENOMEM;
			break;
		}

		buf = new_buf;

		[...]
	} while(...)

Thanks,
Yilun

> +
> +		len = sg_copy_to_buffer(sgt->sgl, sgt->nents, buf, header_size);
> +		if (len != header_size) {
> +			ret = -EFAULT;
> +			break;
> +		}
> +
> +		ret = fpga_mgr_parse_header(mgr, info, buf, header_size);
> +		if (ret == -EAGAIN && info->header_size <= header_size) {
> +			dev_err(&mgr->dev, "Requested invalid header size\n");
> +			ret = -EFAULT;
> +		}
> +	} while (ret == -EAGAIN);
> +
> +	if (ret) {
> +		dev_err(&mgr->dev, "Error while parsing FPGA image header\n");
> +		mgr->state = FPGA_MGR_STATE_PARSE_HEADER_ERR;
> +		kfree(buf);
> +		buf = ERR_PTR(ret);
> +	}
> +
> +	*ret_size = header_size;
> +
> +	return buf;
> +}
> +
> +/*
> + * Call the low level driver's write_init function. This will do the
>   * device-specific things to get the FPGA into the state where it is ready to
> - * receive an FPGA image. The low level driver only gets to see the first
> - * initial_header_size bytes in the buffer.
> + * receive an FPGA image. If info->header_size is defined, the low level
> + * driver gets to see at least first info->header_size bytes in the buffer,
> + * mgr->mops->initial_header_size otherwise. If neither initial_header_size
> + * nor header_size are not set, write_init will not get any bytes of image
> + * buffer.
>   */
>  static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
>  				   struct fpga_image_info *info,
>  				   const char *buf, size_t count)
>  {
> +	size_t header_size;
>  	int ret;
>  
>  	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
> -	if (!mgr->mops->initial_header_size) {
> +
> +	if (info->header_size)
> +		header_size = info->header_size;
> +	else
> +		header_size = mgr->mops->initial_header_size;
> +
> +	if (header_size > count)
> +		ret = -EINVAL;
> +	else if (!header_size)
>  		ret = fpga_mgr_write_init(mgr, info, NULL, 0);
> -	} else {
> -		count = min(mgr->mops->initial_header_size, count);
> +	else
>  		ret = fpga_mgr_write_init(mgr, info, buf, count);
> -	}
>  
>  	if (ret) {
>  		dev_err(&mgr->dev, "Error preparing FPGA for writing\n");
> @@ -164,39 +295,49 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
>  	return 0;
>  }
>  
> -static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
> -				  struct fpga_image_info *info,
> -				  struct sg_table *sgt)
> +static int fpga_mgr_prepare_sg(struct fpga_manager *mgr,
> +			       struct fpga_image_info *info,
> +			       struct sg_table *sgt)
>  {
>  	struct sg_mapping_iter miter;
>  	size_t len;
>  	char *buf;
>  	int ret;
>  
> -	if (!mgr->mops->initial_header_size)
> +	if (!mgr->mops->initial_header_size && !mgr->mops->parse_header)
>  		return fpga_mgr_write_init_buf(mgr, info, NULL, 0);
>  
>  	/*
>  	 * First try to use miter to map the first fragment to access the
>  	 * header, this is the typical path.
>  	 */
> -	sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
> -	if (sg_miter_next(&miter) &&
> -	    miter.length >= mgr->mops->initial_header_size) {
> -		ret = fpga_mgr_write_init_buf(mgr, info, miter.addr,
> -					      miter.length);
> +	ret = fpga_mgr_parse_header_sg_first(mgr, info, sgt);
> +	/* If 0, header fits first fragment, call write_init on it */
> +	if (!ret) {
> +		sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
> +		if (sg_miter_next(&miter)) {
> +			ret = fpga_mgr_write_init_buf(mgr, info, miter.addr,
> +						      miter.length);
> +			sg_miter_stop(&miter);
> +			return ret;
> +		}
>  		sg_miter_stop(&miter);
> +	/*
> +	 * If -EAGAIN, more sg buffer is needed,
> +	 * otherwise an error has occurred.
> +	 */
> +	} else if (ret != -EAGAIN) {
>  		return ret;
>  	}
> -	sg_miter_stop(&miter);
>  
> -	/* Otherwise copy the fragments into temporary memory. */
> -	buf = kmalloc(mgr->mops->initial_header_size, GFP_KERNEL);
> -	if (!buf)
> -		return -ENOMEM;
> +	/*
> +	 * Otherwise copy the fragments into temporary memory.
> +	 * Copying is done inside fpga_mgr_parse_header_sg()
> +	 */
> +	buf = fpga_mgr_parse_header_sg(mgr, info, sgt, &len);
> +	if (IS_ERR(buf))
> +		return PTR_ERR(buf);
>  
> -	len = sg_copy_to_buffer(sgt->sgl, sgt->nents, buf,
> -				mgr->mops->initial_header_size);
>  	ret = fpga_mgr_write_init_buf(mgr, info, buf, len);
>  
>  	kfree(buf);
> @@ -227,7 +368,7 @@ static int fpga_mgr_buf_load_sg(struct fpga_manager *mgr,
>  {
>  	int ret;
>  
> -	ret = fpga_mgr_write_init_sg(mgr, info, sgt);
> +	ret = fpga_mgr_prepare_sg(mgr, info, sgt);
>  	if (ret)
>  		return ret;
>  
> @@ -237,11 +378,40 @@ static int fpga_mgr_buf_load_sg(struct fpga_manager *mgr,
>  		ret = fpga_mgr_write_sg(mgr, sgt);
>  	} else {
>  		struct sg_mapping_iter miter;
> +		size_t length, data_size;
> +		bool last = false;
> +		ssize_t count;
> +		char *addr;
> +
> +		data_size = info->data_size;
> +		count = -info->header_size;
>  
>  		sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
>  		while (sg_miter_next(&miter)) {
> -			ret = fpga_mgr_write(mgr, miter.addr, miter.length);
> -			if (ret)
> +			count += miter.length;
> +
> +			/* sg block contains only header, no data */
> +			if (count <= 0)
> +				continue;
> +
> +			if (count < miter.length) {
> +				/* sg block contains both header and data */
> +				addr = miter.addr + miter.length - count;
> +				length = count;
> +			} else {
> +				/* sg block contains pure data */
> +				addr = miter.addr;
> +				length = miter.length;
> +			}
> +
> +			/* truncate last block to data_size, if needed */
> +			if (data_size && count > data_size) {
> +				length -= count - data_size;
> +				last = true;
> +			}
> +
> +			ret = fpga_mgr_write(mgr, addr, length);
> +			if (ret || last)
>  				break;
>  		}
>  		sg_miter_stop(&miter);
> @@ -262,10 +432,21 @@ static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr,
>  {
>  	int ret;
>  
> +	ret = fpga_mgr_parse_header_mapped(mgr, info, buf, count);
> +	if (ret)
> +		return ret;
> +
>  	ret = fpga_mgr_write_init_buf(mgr, info, buf, count);
>  	if (ret)
>  		return ret;
>  
> +	if (info->data_size)
> +		count = info->data_size;
> +	else
> +		count -= info->header_size;
> +
> +	buf += info->header_size;
> +
>  	/*
>  	 * Write the FPGA image to the FPGA.
>  	 */
> @@ -424,6 +605,10 @@ static const char * const state_str[] = {
>  	[FPGA_MGR_STATE_FIRMWARE_REQ] =		"firmware request",
>  	[FPGA_MGR_STATE_FIRMWARE_REQ_ERR] =	"firmware request error",
>  
> +	/* Parse FPGA image header */
> +	[FPGA_MGR_STATE_PARSE_HEADER] =		"parse header",
> +	[FPGA_MGR_STATE_PARSE_HEADER_ERR] =	"parse header error",
> +
>  	/* Preparing FPGA to receive image */
>  	[FPGA_MGR_STATE_WRITE_INIT] =		"write init",
>  	[FPGA_MGR_STATE_WRITE_INIT_ERR] =	"write init error",
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index 0f9468771bb9..cba8bb7827a5 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -22,6 +22,8 @@ struct sg_table;
>   * @FPGA_MGR_STATE_RESET: FPGA in reset state
>   * @FPGA_MGR_STATE_FIRMWARE_REQ: firmware request in progress
>   * @FPGA_MGR_STATE_FIRMWARE_REQ_ERR: firmware request failed
> + * @FPGA_MGR_STATE_PARSE_HEADER: parse FPGA image header
> + * @FPGA_MGR_STATE_PARSE_HEADER_ERR: Error during PARSE_HEADER stage
>   * @FPGA_MGR_STATE_WRITE_INIT: preparing FPGA for programming
>   * @FPGA_MGR_STATE_WRITE_INIT_ERR: Error during WRITE_INIT stage
>   * @FPGA_MGR_STATE_WRITE: writing image to FPGA
> @@ -42,6 +44,8 @@ enum fpga_mgr_states {
>  	FPGA_MGR_STATE_FIRMWARE_REQ_ERR,
>  
>  	/* write sequence: init, write, complete */
> +	FPGA_MGR_STATE_PARSE_HEADER,
> +	FPGA_MGR_STATE_PARSE_HEADER_ERR,
>  	FPGA_MGR_STATE_WRITE_INIT,
>  	FPGA_MGR_STATE_WRITE_INIT_ERR,
>  	FPGA_MGR_STATE_WRITE,
> @@ -85,6 +89,8 @@ enum fpga_mgr_states {
>   * @sgt: scatter/gather table containing FPGA image
>   * @buf: contiguous buffer containing FPGA image
>   * @count: size of buf
> + * @header_size: offset in image buffer where bitstream data starts
> + * @data_size: size of bitstream. If 0, (count - header_size) will be used.
>   * @region_id: id of target region
>   * @dev: device that owns this
>   * @overlay: Device Tree overlay
> @@ -98,6 +104,8 @@ struct fpga_image_info {
>  	struct sg_table *sgt;
>  	const char *buf;
>  	size_t count;
> +	size_t header_size;
> +	size_t data_size;
>  	int region_id;
>  	struct device *dev;
>  #ifdef CONFIG_OF
> @@ -137,9 +145,13 @@ struct fpga_manager_info {
>  
>  /**
>   * struct fpga_manager_ops - ops for low level fpga manager drivers
> - * @initial_header_size: Maximum number of bytes that should be passed into write_init
> + * @initial_header_size: minimum number of bytes that should be passed into
> + *	parse_header and write_init.
>   * @state: returns an enum value of the FPGA's state
>   * @status: returns status of the FPGA, including reconfiguration error code
> + * @parse_header: parse FPGA image header to set info->header_size and
> + *	info->data_size. In case the input buffer is not large enough, set
> + *	required size to info->header_size and return -EAGAIN.
>   * @write_init: prepare the FPGA to receive configuration data
>   * @write: write count bytes of configuration data to the FPGA
>   * @write_sg: write the scatter list of configuration data to the FPGA
> @@ -155,6 +167,9 @@ struct fpga_manager_ops {
>  	size_t initial_header_size;
>  	enum fpga_mgr_states (*state)(struct fpga_manager *mgr);
>  	u64 (*status)(struct fpga_manager *mgr);
> +	int (*parse_header)(struct fpga_manager *mgr,
> +			    struct fpga_image_info *info,
> +			    const char *buf, size_t count);
>  	int (*write_init)(struct fpga_manager *mgr,
>  			  struct fpga_image_info *info,
>  			  const char *buf, size_t count);
> -- 
> 2.35.1
> 
