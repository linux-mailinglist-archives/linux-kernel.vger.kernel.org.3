Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BF6479A55
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 11:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhLRKdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 05:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhLRKdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 05:33:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A5FC061574;
        Sat, 18 Dec 2021 02:33:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F0F460A5C;
        Sat, 18 Dec 2021 10:33:08 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id CD4BDC36AE5;
        Sat, 18 Dec 2021 10:33:03 +0000 (UTC)
Date:   Sat, 18 Dec 2021 10:38:24 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, git@xilinx.com, michals@xilinx.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v12 1/5] device property: Add fwnode_iomap()
Message-ID: <20211218103824.67099464@jic23-huawei>
In-Reply-To: <CAJZ5v0hG409ffmAiOO5j4O9iPN_qGp4Wnw8eNPKjm5kvncwRLA@mail.gmail.com>
References: <20211203212358.31444-1-anand.ashok.dumbre@xilinx.com>
        <20211203212358.31444-2-anand.ashok.dumbre@xilinx.com>
        <CAJZ5v0hG409ffmAiOO5j4O9iPN_qGp4Wnw8eNPKjm5kvncwRLA@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 18:52:00 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Fri, Dec 3, 2021 at 10:24 PM Anand Ashok Dumbre
> <anand.ashok.dumbre@xilinx.com> wrote:
> >
> > This patch introduces a new helper routine - fwnode_iomap(), which
> > allows to map the memory mapped IO for a given device node.
> >
> > This implementation does not cover the ACPI case and may be expanded
> > in the future. The main purpose here is to be able to develop resource
> > provider agnostic drivers.
> >
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/base/property.c  | 16 ++++++++++++++++
> >  include/linux/property.h |  2 ++
> >  2 files changed, 18 insertions(+)
> >
> > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > index f1f35b48ab8b..ed4470410030 100644
> > --- a/drivers/base/property.c
> > +++ b/drivers/base/property.c
> > @@ -958,6 +958,22 @@ int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index)
> >  }
> >  EXPORT_SYMBOL(fwnode_irq_get);
> >
> > +/**
> > + * fwnode_iomap - Maps the memory mapped IO for a given fwnode
> > + * @fwnode:    Pointer to the firmware node
> > + * @index:     Index of the IO range
> > + *
> > + * Returns a pointer to the mapped memory.
> > + */
> > +void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index)
> > +{
> > +       if (IS_ENABLED(CONFIG_OF_ADDRESS) && is_of_node(fwnode))
> > +               return of_iomap(to_of_node(fwnode), index);
> > +
> > +       return NULL;
> > +}
> > +EXPORT_SYMBOL(fwnode_iomap);  
> 
> So why is this EXPORT_SYMBOL() and not EXPORT_SYMBOL_GPL()?

Good question.  I'm guessing this is because of_iomap is EXPORT_SYMBOL()
and we don't want to discourage use of this function in preference to it.

Series applied to the togreg branch of iio.git but initially pushed out
as testing to let 0-day see if it can find anything we broke.

Note I can still rebase if people would prefer _GPL() so feel free to
discuss further. +CC Rob Herring and DT list.

Thanks,

Jonathan


> 
> Other than this I'm not an OF_ expert, but I trust Andy, so with the
> above addressed:
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> > +
> >  /**
> >   * fwnode_graph_get_next_endpoint - Get next endpoint firmware node
> >   * @fwnode: Pointer to the parent firmware node
> > diff --git a/include/linux/property.h b/include/linux/property.h
> > index 88fa726a76df..6670d5a1ec2a 100644
> > --- a/include/linux/property.h
> > +++ b/include/linux/property.h
> > @@ -122,6 +122,8 @@ void fwnode_handle_put(struct fwnode_handle *fwnode);
> >
> >  int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index);
> >
> > +void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index);
> > +
> >  unsigned int device_get_child_node_count(struct device *dev);
> >
> >  static inline bool device_property_read_bool(struct device *dev,
> > --
> > 2.17.1
> >  

