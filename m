Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D568554B16F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356070AbiFNMoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356096AbiFNMnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:43:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C86DFC1;
        Tue, 14 Jun 2022 05:43:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2B39B81870;
        Tue, 14 Jun 2022 12:42:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1EBC3411E;
        Tue, 14 Jun 2022 12:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655210578;
        bh=8HAAgr9x6d3Aho4yDZuUzaQfjz5OmeJJsR6i0W8q4AA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lhe/rgtI5TpX93cgKsJMRK8LuBotejc1V8ob+vfhaEWmnW3nK4w1rY5/XW4fHISdK
         afoBHjqFKQ4iIW75YTilSo/mthgmZrYDG+SsSstbsMqVzeoPpkjkJ6SgCJGZAccgwK
         vbbCwmD/5SvFei6YSX+lmSZ0oX+dO2onrxOIH7YQ=
Date:   Tue, 14 Jun 2022 14:42:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai Ye <yekai13@huawei.com>
Cc:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhangfei.gao@linaro.org,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH v2 1/3] uacce: supports device isolation feature
Message-ID: <YqiCT1HT/Y0BeiBf@kroah.com>
References: <20220614122943.1406-1-yekai13@huawei.com>
 <20220614122943.1406-2-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614122943.1406-2-yekai13@huawei.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 08:29:38PM +0800, Kai Ye wrote:
> UACCE add the hardware error isolation API. Users can configure
> the error frequency threshold by this vfs node. This API interface
> certainly supports the configuration of user protocol strategy. Then
> parse it inside the device driver. UACCE only reports the device
> isolate state. When the error frequency is exceeded, the device
> will be isolated. The isolation strategy should be defined in each
> driver module.
> 
> Signed-off-by: Kai Ye <yekai13@huawei.com>
> Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
> ---
>  drivers/misc/uacce/uacce.c | 37 +++++++++++++++++++++++++++++++++++++
>  include/linux/uacce.h      | 16 +++++++++++++---
>  2 files changed, 50 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> index b6219c6bfb48..525623215132 100644
> --- a/drivers/misc/uacce/uacce.c
> +++ b/drivers/misc/uacce/uacce.c
> @@ -346,12 +346,47 @@ static ssize_t region_dus_size_show(struct device *dev,
>  		       uacce->qf_pg_num[UACCE_QFRT_DUS] << PAGE_SHIFT);
>  }
>  
> +static ssize_t isolate_show(struct device *dev,
> +			    struct device_attribute *attr, char *buf)
> +{
> +	struct uacce_device *uacce = to_uacce_device(dev);
> +
> +	return sysfs_emit(buf, "%d\n", uacce->ops->get_isolate_state(uacce));
> +}
> +
> +static ssize_t isolate_strategy_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct uacce_device *uacce = to_uacce_device(dev);
> +
> +	return sysfs_emit(buf, "%s\n", uacce->isolate_strategy);
> +}
> +
> +static ssize_t isolate_strategy_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t count)
> +{
> +	struct uacce_device *uacce = to_uacce_device(dev);
> +	int ret;
> +
> +	if (!buf || sizeof(buf) > UACCE_MAX_ISOLATE_STRATEGY_LEN)
> +		return -EINVAL;
> +
> +	memcpy(uacce->isolate_strategy, buf, strlen(buf));
> +
> +	ret = uacce->ops->isolate_strategy_write(uacce, buf);
> +
> +	return ret ? ret : count;
> +}
> +
>  static DEVICE_ATTR_RO(api);
>  static DEVICE_ATTR_RO(flags);
>  static DEVICE_ATTR_RO(available_instances);
>  static DEVICE_ATTR_RO(algorithms);
>  static DEVICE_ATTR_RO(region_mmio_size);
>  static DEVICE_ATTR_RO(region_dus_size);
> +static DEVICE_ATTR_RO(isolate);
> +static DEVICE_ATTR_RW(isolate_strategy);
>  
>  static struct attribute *uacce_dev_attrs[] = {
>  	&dev_attr_api.attr,
> @@ -360,6 +395,8 @@ static struct attribute *uacce_dev_attrs[] = {
>  	&dev_attr_algorithms.attr,
>  	&dev_attr_region_mmio_size.attr,
>  	&dev_attr_region_dus_size.attr,
> +	&dev_attr_isolate.attr,
> +	&dev_attr_isolate_strategy.attr,
>  	NULL,
>  };
>  
> diff --git a/include/linux/uacce.h b/include/linux/uacce.h
> index 48e319f40275..0f7668bfa645 100644
> --- a/include/linux/uacce.h
> +++ b/include/linux/uacce.h
> @@ -8,6 +8,7 @@
>  #define UACCE_NAME		"uacce"
>  #define UACCE_MAX_REGION	2
>  #define UACCE_MAX_NAME_SIZE	64
> +#define UACCE_MAX_ISOLATE_STRATEGY_LEN	256

So it's a random string of characters?  What format?

>  
>  struct uacce_queue;
>  struct uacce_device;
> @@ -30,6 +31,8 @@ struct uacce_qfile_region {
>   * @is_q_updated: check whether the task is finished
>   * @mmap: mmap addresses of queue to user space
>   * @ioctl: ioctl for user space users of the queue
> + * @get_isolate_state: get the device state after set the isolate strategy
> + * @isolate_strategy_store: stored the isolate strategy to the device
>   */
>  struct uacce_ops {
>  	int (*get_available_instances)(struct uacce_device *uacce);
> @@ -43,6 +46,8 @@ struct uacce_ops {
>  		    struct uacce_qfile_region *qfr);
>  	long (*ioctl)(struct uacce_queue *q, unsigned int cmd,
>  		      unsigned long arg);
> +	enum uacce_dev_state (*get_isolate_state)(struct uacce_device *uacce);
> +	int (*isolate_strategy_write)(struct uacce_device *uacce, const char *buf);

Length of the buffer?

>  };
>  
>  /**
> @@ -57,6 +62,12 @@ struct uacce_interface {
>  	const struct uacce_ops *ops;
>  };
>  
> +enum uacce_dev_state {
> +	UACCE_DEV_ERR = -1,
> +	UACCE_DEV_NORMAL,
> +	UACCE_DEV_ISOLATE,
> +};
> +
>  enum uacce_q_state {
>  	UACCE_Q_ZOMBIE = 0,
>  	UACCE_Q_INIT,
> @@ -117,6 +128,7 @@ struct uacce_device {
>  	struct list_head queues;
>  	struct mutex queues_lock;
>  	struct inode *inode;
> +	char isolate_strategy[UACCE_MAX_ISOLATE_STRATEGY_LEN];
>  };
>  
>  #if IS_ENABLED(CONFIG_UACCE)
> @@ -125,7 +137,7 @@ struct uacce_device *uacce_alloc(struct device *parent,
>  				 struct uacce_interface *interface);
>  int uacce_register(struct uacce_device *uacce);
>  void uacce_remove(struct uacce_device *uacce);
> -
> +struct uacce_device *dev_to_uacce(struct device *dev);

Why is this moved to the .h file yet the function is not exported?

thanks,

greg k-h
