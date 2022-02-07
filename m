Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D954AB7D4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347249AbiBGJ1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 04:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344147AbiBGJYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:24:19 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 01:24:18 PST
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71763C043181;
        Mon,  7 Feb 2022 01:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644225858; x=1675761858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1z1k3NFAvHcc9e0Mx/KGHH5k0M0yUJtCdBjP4j5K64g=;
  b=Vb9ljBKYKJAFMifEoZUMTglM7IWED37lNbYNdPY3j4F/9lpYbAVInL2c
   dBdyz4pVFsBqGBng7TUOCX5i6aZc7fvNkVs7iCHGse/6Z6pgOpAC8SWjl
   rNW0lJEw+RGyeY4waKvhkx+pDXpEGFwK8VN+ZleVmFkaRKg0g9UykDEA7
   pMSvAizPtJLkPQJcKlbatk+/vXM2JGuf9pNPcuA/zAA+R6iQE7pmGOJsk
   FZc5oeh8vnZ0S1SyNetTkH+NozpxBsxCA8QqZP7bNrFlIIuth3+6l74Qu
   hzp0fO7+wTqcAHHvBlAJRxp5YvEMbncFP6G1L9YtT1cA96uCZsoeD7KbA
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="311977638"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="311977638"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 01:23:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="677704920"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 07 Feb 2022 01:22:57 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 07 Feb 2022 11:22:56 +0200
Date:   Mon, 7 Feb 2022 11:22:56 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>, Benson Leung <bleung@google.com>
Subject: Re: [PATCH v1 1/2] usb: typec: Introduce typec attributes for
 limiting source current
Message-ID: <YgDk8M3N8VEZK5Sk@kuha.fi.intel.com>
References: <20220207043907.2758424-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207043907.2758424-1-badhri@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Benson

On Sun, Feb 06, 2022 at 08:39:06PM -0800, Badhri Jagan Sridharan wrote:
> This change introduces the following two attributes to the
> typec sysfs class which allows userspace to limit the power
> advertised while acting as source. This is useful to mitigate
> battery drain in portable devices when the battery SOC is low.
> 
> New attibutes introduced:
> 1. limit_src_current_active
> 2. limit_src_current_ma
> 
> The port while in PD contract and acting as source would
> only advertise vSafe5V fixed PDO with current set through
> limit_src_current_ma when limit_src_current_active is set
> to 1. When limit_src_current_active is set to 0, the port
> would publish the default source capabilities.
> limit_src_current_ma would limit the current to the
> Maximum current published by vSafe5V fixed pdo of the default
> source capabilities of the port.

This competes with Benson's idea of having "sets" of capabilites from
which to choose the ones that we advertise to the partner. You could
also use that idea to cover this case as well. You just have two
source capabilities sets defined - one where you only have the vSafe5V
and another for everything.

Benson's idea also seems to be something what we can support with UCSI
and some native USB PD controller host interfaces, but limiting the
source capabitites to only vSafe5V is something that we can't do. I
means, on some platforms we may have a source capabilities "set" that
we can choose that only exposes the vSafe5V, but there is no guarantee
that we always have it (and it's unlikely that we ever have it). It's
up to some firmware that we have no control over.

So this is the wrong way and Benson's idea is the right way IMO.

I already prepared a proposal for adding support for Benson's idea:
https://lore.kernel.org/linux-usb/20220203144657.16527-1-heikki.krogerus@linux.intel.com/

This patch adds the attributes that you can use to choose the
capabilities that are advertised to the partner:
https://lore.kernel.org/linux-usb/20220203144657.16527-3-heikki.krogerus@linux.intel.com/

> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  Documentation/ABI/testing/sysfs-class-typec | 25 ++++++
>  drivers/usb/typec/class.c                   | 99 +++++++++++++++++++++
>  drivers/usb/typec/class.h                   |  5 ++
>  include/linux/usb/typec.h                   |  4 +
>  4 files changed, 133 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> index 75088ecad202..dd2240632172 100644
> --- a/Documentation/ABI/testing/sysfs-class-typec
> +++ b/Documentation/ABI/testing/sysfs-class-typec
> @@ -141,6 +141,31 @@ Description:
>  		- "reverse": CC2 orientation
>  		- "unknown": Orientation cannot be determined.
>  
> +What:		/sys/class/typec/<port>/limit_src_current_active
> +Date:		February 2022
> +Contact:	Badhri Jagan Sridharan <badhri@google.com>
> +Description:
> +		This attribute can be used to make the port only publish
> +		vSafe5V fixed pdo with Maximum current limited to the
> +		current limit set by limit_src_current_ma when the port
> +		is acting as source.
> +		Valid values:
> +		- write(2) "1" limits source capabilities to vSafe5V
> +		  with max current specified by limit_src_current_ma
> +		- write(2) "0" publishes the default source capabilities
> +		  of the port.
> +
> +What:		/sys/class/typec/<port>/limit_src_current_ma
> +Date:		February 2022
> +Contact:	Badhri Jagan Sridharan <badhri@google.com>
> +Description:
> +		This attribute allows write(2) to set the Maximum
> +		current published when limit_src_current_active is set
> +		to 1. When limit_src_current_active is already set
> +		to 1, if the port is already acting as source with
> +		explicit contract in place, write(2) will make the port
> +		renegotiate the pd contract.
> +
>  USB Type-C partner devices (eg. /sys/class/typec/port0-partner/)
>  
>  What:		/sys/class/typec/<port>-partner/accessory_mode
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 45a6f0c807cb..3b3c7b080ad1 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -1403,6 +1403,102 @@ port_type_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RW(port_type);
>  
> +static ssize_t
> +limit_src_current_active_store(struct device *dev, struct device_attribute *attr, const char *buf,
> +			       size_t size)
> +{
> +	struct typec_port *port = to_typec_port(dev);
> +	int ret;
> +	u8 active;
> +
> +	if (port->cap->type == TYPEC_PORT_SNK || !port->ops || !port->ops->limit_src_current_set ||
> +	    !port->cap->pd_revision) {
> +		dev_dbg(dev, "Limiting source current not supported\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (kstrtou8(buf, 0, &active))
> +		return -EINVAL;
> +
> +	if (active != 1 && active != 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&port->limit_src_current_lock);
> +
> +	if (port->limit_src_current_active == (bool)active) {
> +		ret = size;
> +		goto unlock_and_ret;
> +	}
> +
> +	ret = port->ops->limit_src_current_set(port, port->limit_src_current_ma, active);
> +	if (ret)
> +		goto unlock_and_ret;
> +
> +	port->limit_src_current_active = active;
> +	ret = size;
> +
> +unlock_and_ret:
> +	mutex_unlock(&port->limit_src_current_lock);
> +	return ret;
> +}
> +
> +static ssize_t
> +limit_src_current_active_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct typec_port *port = to_typec_port(dev);
> +
> +	return sysfs_emit(buf, "%d\n", port->limit_src_current_active ? 1 : 0);
> +}
> +static DEVICE_ATTR_RW(limit_src_current_active);
> +
> +static ssize_t
> +limit_src_current_ma_store(struct device *dev, struct device_attribute *attr, const char *buf,
> +			   size_t size)
> +{
> +	struct typec_port *port = to_typec_port(dev);
> +	int ret;
> +	u32 src_current_ma;
> +
> +	if (port->cap->type == TYPEC_PORT_SNK || !port->ops || !port->ops->limit_src_current_set ||
> +	    !port->cap->pd_revision) {
> +		dev_dbg(dev, "Limiting source current not supported\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (kstrtou32(buf, 0, &src_current_ma))
> +		return -EINVAL;
> +
> +	mutex_lock(&port->limit_src_current_lock);
> +
> +	if (port->limit_src_current_ma == src_current_ma) {
> +		ret = size;
> +		goto unlock_and_ret;
> +	}
> +
> +	if (port->limit_src_current_active) {
> +		ret = port->ops->limit_src_current_set(port, src_current_ma,
> +						       port->limit_src_current_active);
> +		if (ret)
> +			goto unlock_and_ret;
> +	}
> +
> +	port->limit_src_current_ma = src_current_ma;
> +	ret = size;
> +
> +unlock_and_ret:
> +	mutex_unlock(&port->limit_src_current_lock);
> +	return ret;
> +}
> +
> +static ssize_t
> +limit_src_current_ma_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct typec_port *port = to_typec_port(dev);
> +
> +	return sysfs_emit(buf, "%u\n", port->limit_src_current_ma);
> +}
> +static DEVICE_ATTR_RW(limit_src_current_ma);
> +
>  static const char * const typec_pwr_opmodes[] = {
>  	[TYPEC_PWR_MODE_USB]	= "default",
>  	[TYPEC_PWR_MODE_1_5A]	= "1.5A",
> @@ -1536,6 +1632,8 @@ static struct attribute *typec_attrs[] = {
>  	&dev_attr_vconn_source.attr,
>  	&dev_attr_port_type.attr,
>  	&dev_attr_orientation.attr,
> +	&dev_attr_limit_src_current_active.attr,
> +	&dev_attr_limit_src_current_ma.attr,
>  	NULL,
>  };
>  
> @@ -2039,6 +2137,7 @@ struct typec_port *typec_register_port(struct device *parent,
>  
>  	ida_init(&port->mode_ids);
>  	mutex_init(&port->port_type_lock);
> +	mutex_init(&port->limit_src_current_lock);
>  
>  	port->id = id;
>  	port->ops = cap->ops;
> diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
> index 0f1bd6d19d67..3856bc058444 100644
> --- a/drivers/usb/typec/class.h
> +++ b/drivers/usb/typec/class.h
> @@ -54,6 +54,11 @@ struct typec_port {
>  
>  	const struct typec_capability	*cap;
>  	const struct typec_operations   *ops;
> +
> +	/* lock to protect limit_src_current_*_store operation */
> +	struct mutex			limit_src_current_lock;
> +	u32				limit_src_current_ma;
> +	bool				limit_src_current_active;
>  };
>  
>  #define to_typec_port(_dev_) container_of(_dev_, struct typec_port, dev)
> diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> index 7ba45a97eeae..1b1958ae4c16 100644
> --- a/include/linux/usb/typec.h
> +++ b/include/linux/usb/typec.h
> @@ -213,6 +213,8 @@ struct typec_partner_desc {
>   * @pr_set: Set Power Role
>   * @vconn_set: Source VCONN
>   * @port_type_set: Set port type
> + * @limit_src_current_set: Used to limit source current advertisement while
> + *                         acting as source
>   */
>  struct typec_operations {
>  	int (*try_role)(struct typec_port *port, int role);
> @@ -221,6 +223,8 @@ struct typec_operations {
>  	int (*vconn_set)(struct typec_port *port, enum typec_role role);
>  	int (*port_type_set)(struct typec_port *port,
>  			     enum typec_port_type type);
> +	int (*limit_src_current_set)(struct typec_port *port, u32 limit_src_current_ma,
> +				     bool enable);
>  };
>  
>  enum usb_pd_svdm_ver {
> -- 
> 2.35.0.263.gb82422642f-goog

-- 
heikki
