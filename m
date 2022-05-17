Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBA75298A6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 06:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbiEQEUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 00:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiEQEUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 00:20:47 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323B11002;
        Mon, 16 May 2022 21:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652761246; x=1684297246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JRiuzdYWctL1qMfq0r1v3m9Ry+xcxBuvYeZ27K1VOXk=;
  b=nXynFBP7NUPIjsBiu+UdgjbNi9iMuAOtp11Ea0lFMhMVJV+uyzP32N9e
   Kn9Y4yr1pmpx+RcNgkOEbzjeOg7qpMYcBNDaT/DoX4wJLnmJ6jZcFCc6U
   sHHgfMqFXGGybeXDM8jUfuEvtykf686wEZKSJ+xe9FOUDEqIkmmSyg4WQ
   7xehAFFCnoxqWrE6fZIWZkOTIfyMR4rpjfysF/ivFxOYCfRYtJqvJtHAM
   CLnfLUWftOEm22RPS1z5u7yjuU+v0GRVkKyWT9E3hzm97WPL65qO/eVIY
   xvc/oP87ui1xZWcSPeA+BqoTtvxg2DVNX0ObsDsoOivayPsTcAiCauIoj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="268632063"
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="268632063"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 21:20:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="544698037"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga006.jf.intel.com with ESMTP; 16 May 2022 21:20:42 -0700
Date:   Tue, 17 May 2022 12:13:10 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, lee.jones@linaro.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, marpagan@redhat.com, lgoncalv@redhat.com,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com
Subject: Re: [PATCH v20 3/5] fpga: m10bmc-sec: expose max10 flash update count
Message-ID: <20220517041310.GA40711@yilunxu-OptiPlex-7050>
References: <20220516234941.592886-1-russell.h.weight@intel.com>
 <20220516234941.592886-4-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516234941.592886-4-russell.h.weight@intel.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 04:49:39PM -0700, Russ Weight wrote:
> Extend the MAX10 BMC Secure Update driver to provide a sysfs file to
> expose the flash update count.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> ---
> v20:
>   - No change
> v19:
>   - Change "card bmc" naming back to "m10 bmc" naming to be consistent
>     with the parent driver.
> v18:
>   - No change
> v17:
>   - Update the Date and KernelVersion for the ABI documentation to Jul 2022
>     and 5.19 respectively.
>   - Change "m10bmc" in symbol names to "cardbmc" to reflect the fact that the
>     future devices will not necessarily use the MAX10.
> v16:
>   - No Change
> v15:
>   - Updated the Dates and KernelVersions in the ABI documentation
> v14:
>   - No change
> v13:
>   - Updated ABI documentation date and kernel version
> v12:
>   - Updated Date and KernelVersion fields in ABI documentation
> v11:
>   - No change
> v10:
>   - Changed the path expression in the sysfs documentation to
>     replace the n3000 reference with something more generic to
>     accomodate other devices that use the same driver.
> v9:
>   - Rebased to 5.12-rc2 next
>   - Updated Date and KernelVersion in ABI documentation
> v8:
>   - Previously patch 3/6, otherwise no change
> v7:
>   - Updated Date and KernelVersion in ABI documentation
> v6:
>   - Changed flash_count_show() parameter list to achieve
>     reverse-christmas tree format.
>   - Added WARN_ON() call for (FLASH_COUNT_SIZE / stride) to ensure
>     that the proper count is passed to regmap_bulk_read().
> v5:
>   - Renamed sysfs node user_flash_count to flash_count and updated the
>     sysfs documentation accordingly.
> v4:
>   - Moved the sysfs file for displaying the flash count from the
>     FPGA Security Manager class driver to here. The
>     m10bmc_user_flash_count() function is removed and the
>     functionality is moved into a user_flash_count_show()
>     function.
>   - Added ABI documentation for the new sysfs entry
> v3:
>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>   - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure Update
>     driver"
>   - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
>     underlying functions are now called directly.
> v2:
>   - Renamed get_qspi_flash_count() to m10bmc_user_flash_count()
>   - Minor code cleanup per review comments
>   - Added m10bmc_ prefix to functions in m10bmc_iops structure
> ---
>  .../sysfs-driver-intel-m10-bmc-sec-update     |  8 +++++
>  drivers/fpga/intel-m10-bmc-sec-update.c       | 36 +++++++++++++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> index 2bb271695e14..1132e39b2125 100644
> --- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> @@ -27,3 +27,11 @@ Description:	Read only. Returns the root entry hash for the BMC image
>  		"hash not programmed".  This file is only visible if the
>  		underlying device supports it.
>  		Format: string.
> +
> +What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/flash_count
> +Date:		Jul 2022
> +KernelVersion:	5.19
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns number of times the secure update
> +		staging area has been flashed.
> +		Format: "%u".
> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> index f9f39d2cfe5b..3f183202de3b 100644
> --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> @@ -78,7 +78,43 @@ DEVICE_ATTR_SEC_REH_RO(bmc, BMC_PROG_MAGIC, BMC_PROG_ADDR, BMC_REH_ADDR);
>  DEVICE_ATTR_SEC_REH_RO(sr, SR_PROG_MAGIC, SR_PROG_ADDR, SR_REH_ADDR);
>  DEVICE_ATTR_SEC_REH_RO(pr, PR_PROG_MAGIC, PR_PROG_ADDR, PR_REH_ADDR);
>  
> +#define FLASH_COUNT_SIZE 4096	/* count stored as inverted bit vector */
> +
> +static ssize_t flash_count_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct m10bmc_sec *sec = dev_get_drvdata(dev);
> +	unsigned int stride, num_bits;
> +	u8 *flash_buf;
> +	int cnt, ret;
> +
> +	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
> +	num_bits = FLASH_COUNT_SIZE * 8;
> +
> +	flash_buf = kmalloc(FLASH_COUNT_SIZE, GFP_KERNEL);
> +	if (!flash_buf)
> +		return -ENOMEM;
> +
> +	WARN_ON(FLASH_COUNT_SIZE % stride);

The same concern here. Stop users from getting the broken value.

> +	ret = regmap_bulk_read(sec->m10bmc->regmap, STAGING_FLASH_COUNT,
> +			       flash_buf, FLASH_COUNT_SIZE / stride);
> +	if (ret) {
> +		dev_err(sec->dev,
> +			"failed to read flash count: %x cnt %x: %d\n",
> +			STAGING_FLASH_COUNT, FLASH_COUNT_SIZE / stride, ret);
> +		goto exit_free;
> +	}
> +	cnt = num_bits - bitmap_weight((unsigned long *)flash_buf, num_bits);
> +
> +exit_free:
> +	kfree(flash_buf);
> +
> +	return ret ? : sysfs_emit(buf, "%u\n", cnt);
> +}
> +static DEVICE_ATTR_RO(flash_count);
> +
>  static struct attribute *m10bmc_security_attrs[] = {
> +	&dev_attr_flash_count.attr,
>  	&dev_attr_bmc_root_entry_hash.attr,
>  	&dev_attr_sr_root_entry_hash.attr,
>  	&dev_attr_pr_root_entry_hash.attr,
> -- 
> 2.25.1
