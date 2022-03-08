Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E785B4D109B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 07:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344319AbiCHHAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 02:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiCHHAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 02:00:05 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B6A25C46;
        Mon,  7 Mar 2022 22:59:09 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0533B68AFE; Tue,  8 Mar 2022 07:59:06 +0100 (CET)
Date:   Tue, 8 Mar 2022 07:59:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ondrej Zary <linux@zary.sk>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/16] pata_parport: add core driver (PARIDE
 replacement)
Message-ID: <20220308065905.GB24269@lst.de>
References: <20220305201411.501-1-linux@zary.sk> <20220305201411.501-2-linux@zary.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220305201411.501-2-linux@zary.sk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +
> +static void pata_parport_dev_release(struct device *dev)
> +{
> +	struct pi_adapter *pi = container_of(dev, struct pi_adapter, dev);
> +
> +	kfree(pi);
> +}
>
> +void pata_parport_bus_release(struct device *dev)
> +{
> +	/* nothing to do here but required to avoid warning on device removal */
> +}
> +
> +static struct bus_type pata_parport_bus_type = {
> +	.name = DRV_NAME,
> +};
> +
> +static struct device pata_parport_bus = {
> +	.init_name = DRV_NAME,
> +	.release = pata_parport_bus_release,
> +};

Hmm, wouldn't it make sense to let the libata device hang off the device
in struct pardevice?
