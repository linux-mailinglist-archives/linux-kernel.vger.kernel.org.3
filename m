Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9298D47931D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239315AbhLQRwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:52:13 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:45931 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbhLQRwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:52:12 -0500
Received: by mail-ot1-f49.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso3780500otf.12;
        Fri, 17 Dec 2021 09:52:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fe76QOXnDpK1H1l8gPbmrZn/OhgK8G9yInA0bZrVdeg=;
        b=zHugODi2s20KZkLnlWuhN18UVP2sW6qDdt0CRF7+KTvdqS6ivT6CaZElaI7aEqTRFl
         4qfF/JNmCyolEdbTSX9kP4XWauv1vzFp1Knc8XmJ+WNGpS8vPqXPbVE5MiNKVrzDPtAo
         GCeA/VVgDX5KOtRCDsfQhVHaM14Mk5o965wRcTpEY7p529QOH/6n1tZhO/6ZqIGSHxMU
         8e8nv+LaxZFW+u7KhGCTTguJrDgcUpxt7Sf66DCsluEWp/O0CusGEcO2aUJV5nIEp4YR
         oGr1bOB4IT9zK5HcKwaeeaur3Drao5pzS+wuEC1RwMmHO6nJvIoESkrJWQLFv6y2iw9J
         RLBw==
X-Gm-Message-State: AOAM5334q5PJKXt2nUzzL1HyMxU1o87j2dNzAiKKw/hMnfJ2L/buVZqF
        lhbgHNFamtWavMVZudaqimrxfleNZiykvD7/0v333pCwubU=
X-Google-Smtp-Source: ABdhPJzm42Z+otkyxL5wSvj8/hZCrDNtEV1UjaxA3ACkAZqx0RSmmWbeq1LOMvMxPcEkRtKe1+eaVYq3zlEA1Ibi58Y=
X-Received: by 2002:a05:6830:348f:: with SMTP id c15mr3074208otu.254.1639763531658;
 Fri, 17 Dec 2021 09:52:11 -0800 (PST)
MIME-Version: 1.0
References: <20211203212358.31444-1-anand.ashok.dumbre@xilinx.com> <20211203212358.31444-2-anand.ashok.dumbre@xilinx.com>
In-Reply-To: <20211203212358.31444-2-anand.ashok.dumbre@xilinx.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Dec 2021 18:52:00 +0100
Message-ID: <CAJZ5v0hG409ffmAiOO5j4O9iPN_qGp4Wnw8eNPKjm5kvncwRLA@mail.gmail.com>
Subject: Re: [PATCH v12 1/5] device property: Add fwnode_iomap()
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, git@xilinx.com, michals@xilinx.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 3, 2021 at 10:24 PM Anand Ashok Dumbre
<anand.ashok.dumbre@xilinx.com> wrote:
>
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
> + * @fwnode:    Pointer to the firmware node
> + * @index:     Index of the IO range
> + *
> + * Returns a pointer to the mapped memory.
> + */
> +void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index)
> +{
> +       if (IS_ENABLED(CONFIG_OF_ADDRESS) && is_of_node(fwnode))
> +               return of_iomap(to_of_node(fwnode), index);
> +
> +       return NULL;
> +}
> +EXPORT_SYMBOL(fwnode_iomap);

So why is this EXPORT_SYMBOL() and not EXPORT_SYMBOL_GPL()?

Other than this I'm not an OF_ expert, but I trust Andy, so with the
above addressed:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

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
> --
> 2.17.1
>
