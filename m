Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D264D5ABF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346513AbiCKFrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345203AbiCKFrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:47:03 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E79B1AD391;
        Thu, 10 Mar 2022 21:45:59 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C6E7E68AFE; Fri, 11 Mar 2022 06:45:55 +0100 (CET)
Date:   Fri, 11 Mar 2022 06:45:55 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ondrej Zary <linux@zary.sk>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v0] pata_parport: add driver (PARIDE replacement)
Message-ID: <20220311054555.GA16362@lst.de>
References: <20220310212812.13944-1-linux@zary.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310212812.13944-1-linux@zary.sk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 10:28:12PM +0100, Ondrej Zary wrote:
> Add pata_parport (PARIDE replacement) core libata driver.
> 
> The original paride protocol modules are used for now so allow them to
> be compiled without old PARIDE core.

I agree with Damien that this needs a bit more text here.  Explaining
what kind of hardware this drives, that this will allow to eventually
drop paride, how it reuesed the low-level drivers, etc.

> +	  If your parallel port support is in a loadable module, you must build
> +	  PATA_PARPORT as a module. If you built PATA_PARPORT support into your
> +	  kernel, you may still build the individual protocol modules
> +	  as loadable modules.

I'd drop the above.  The dependencies are already enforced by Kconfig
and we don't really tend to mention this elsewhere.

> +	  Unlike the old PARIDE, there are no high-level drivers needed.
> +	  The IDE devices behind parallel port adapters are handled by the
> +	  ATA layer.

I also don't think this is needed.

> index 000000000000..3ea8d824091e
> --- /dev/null
> +++ b/drivers/ata/parport/pata_parport.c
> @@ -0,0 +1,805 @@
> +// SPDX-License-Identifier: GPL-2.0-only

Please add your copyright statement here.

> +static void pata_parport_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)

Overly long line.

> +			pi->proto->write_regr(pi, 0, ATA_REG_NSECT, tf->hob_nsect);
> +			pi->proto->write_regr(pi, 0, ATA_REG_LBAL, tf->hob_lbal);
> +			pi->proto->write_regr(pi, 0, ATA_REG_LBAM, tf->hob_lbam);
> +			pi->proto->write_regr(pi, 0, ATA_REG_LBAH, tf->hob_lbah);

Same here.

> +static void pata_parport_exec_command(struct ata_port *ap, const struct ata_taskfile *tf)

.. and here.

And a bunch more.

> +static void pata_parport_bus_release(struct device *dev)
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
> +
> +/* temporary for old paride protocol modules */
> +static struct scsi_host_template pata_parport_sht = {
> +	PATA_PARPORT_SHT("pata_parport")
> +};

Did you look into my suggestion to use struct pardevice.dev instead?

> index ddb9e589da7f..f3bd01a9c9ec 100644
> --- a/drivers/block/paride/paride.h
> +++ b/drivers/block/paride/paride.h
> @@ -1,3 +1,7 @@
> +#if IS_ENABLED(CONFIG_PATA_PARPORT)
> +#include "../../ata/parport/pata_parport.h"
> +
> +#else

Maybe add a comment here?  Also this is a pretty clear indication
that pata_parport.h should be in include/linux/ at least for now.
