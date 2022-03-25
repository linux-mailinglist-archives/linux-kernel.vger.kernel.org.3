Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC2A4E791F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 17:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356454AbiCYQog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 12:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344427AbiCYQod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:44:33 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13854E09BA;
        Fri, 25 Mar 2022 09:42:58 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id A4AF810306A7A;
        Fri, 25 Mar 2022 17:42:55 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 7E20F2BC2EC; Fri, 25 Mar 2022 17:42:55 +0100 (CET)
Date:   Fri, 25 Mar 2022 17:42:55 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Felipe Balbi <balbi@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCHv2 1/3] software node: Power management operations for
 software nodes
Message-ID: <20220325164255.GA12710@wunner.de>
References: <20201029105941.63410-1-heikki.krogerus@linux.intel.com>
 <20201029105941.63410-2-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029105941.63410-2-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

saw this linked in your WSR and felt compelled to reply... ;)

On Thu, Oct 29, 2020 at 01:59:39PM +0300, Heikki Krogerus wrote:
> +static int software_node_runtime_suspend(struct device *dev)
> +{
> +	struct swnode_pm_domain *domain = to_swnode_pm_domain(dev->pm_domain);
> +	struct swnode *swnode = dev_to_swnode(dev);
> +	int ret;
> +
> +	if (domain->primary && domain->primary->ops.runtime_suspend)
> +		ret = domain->primary->ops.runtime_suspend(dev);
> +	else if (dev->type && dev->type->pm && dev->type->pm->runtime_suspend)
> +		ret = dev->type->pm->runtime_suspend(dev);
> +	else if (dev->class && dev->class->pm && dev->class->pm->runtime_suspend)
> +		ret = dev->class->pm->runtime_suspend(dev);
> +	else if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_suspend)
> +		ret = dev->bus->pm->runtime_suspend(dev);
> +	else
> +		ret = pm_generic_runtime_suspend(dev);

This if/else ladder seems to be duplicated for every single PM callback
in this patch.

Code size can be reduced significantly if you use offsetof() to determine
the offset of the given callback in struct pm_ops, then pass that offset
to a helper which contains the above-quoted if/else ladder and retrieves
the callback.  Finally invoke the callback you've just retrieved.

That way you only need the if/else ladder once in your patch.

For an example, see pcie_port_device_iter() and its callers
pcie_port_device_suspend() and so on:

https://elixir.bootlin.com/linux/latest/source/drivers/pci/pcie/portdrv_core.c#L372

Thanks,

Lukas
