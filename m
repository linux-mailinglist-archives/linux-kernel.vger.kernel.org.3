Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6B547702F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbhLPL1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbhLPL1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:27:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA40AC061574;
        Thu, 16 Dec 2021 03:27:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AAB561D74;
        Thu, 16 Dec 2021 11:27:48 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 108F6C36AE2;
        Thu, 16 Dec 2021 11:27:44 +0000 (UTC)
Date:   Thu, 16 Dec 2021 11:33:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Cc:     <linux-kernel@vger.kernel.org>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <git@xilinx.com>,
        <michals@xilinx.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
        <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v12 1/5] device property: Add fwnode_iomap()
Message-ID: <20211216113310.2da9f8d2@jic23-huawei>
In-Reply-To: <20211203212358.31444-2-anand.ashok.dumbre@xilinx.com>
References: <20211203212358.31444-1-anand.ashok.dumbre@xilinx.com>
        <20211203212358.31444-2-anand.ashok.dumbre@xilinx.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Dec 2021 21:23:54 +0000
Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com> wrote:

> This patch introduces a new helper routine - fwnode_iomap(), which
> allows to map the memory mapped IO for a given device node.
> 
> This implementation does not cover the ACPI case and may be expanded
> in the future. The main purpose here is to be able to develop resource
> provider agnostic drivers.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This is one of those corners of the kernel where I'm not sure whose
Acks etc I should be looking for. Maintainers would put it firmly
in Greg's territory but seems we've been flexible around this
particular file at times.

History seems to suggest maybe Greg or Rafael?

If either of you have time to sanity check this that would be great!

Thanks,

Jonathan


> ---
>  drivers/base/property.c  | 16 ++++++++++++++++
>  include/linux/property.h |  2 ++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index f1f35b48ab8b..ed4470410030 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -958,6 +958,22 @@ int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index)
>  }
>  EXPORT_SYMBOL(fwnode_irq_get);
>  
> +/**
> + * fwnode_iomap - Maps the memory mapped IO for a given fwnode
> + * @fwnode:	Pointer to the firmware node
> + * @index:	Index of the IO range
> + *
> + * Returns a pointer to the mapped memory.
> + */
> +void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index)
> +{
> +	if (IS_ENABLED(CONFIG_OF_ADDRESS) && is_of_node(fwnode))
> +		return of_iomap(to_of_node(fwnode), index);
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL(fwnode_iomap);
> +
>  /**
>   * fwnode_graph_get_next_endpoint - Get next endpoint firmware node
>   * @fwnode: Pointer to the parent firmware node
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 88fa726a76df..6670d5a1ec2a 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -122,6 +122,8 @@ void fwnode_handle_put(struct fwnode_handle *fwnode);
>  
>  int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index);
>  
> +void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index);
> +
>  unsigned int device_get_child_node_count(struct device *dev);
>  
>  static inline bool device_property_read_bool(struct device *dev,

