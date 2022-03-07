Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E09F4CF41C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 09:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbiCGI4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 03:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbiCGI4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:56:09 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7416C17E3E;
        Mon,  7 Mar 2022 00:55:11 -0800 (PST)
Received: from [192.168.1.3] (ns.gsystem.sk [62.176.172.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 4BA337A0182;
        Mon,  7 Mar 2022 09:55:08 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 01/16] pata_parport: add core driver (PARIDE replacement)
Date:   Mon, 7 Mar 2022 09:55:05 +0100
User-Agent: KMail/1.9.10
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220305201411.501-1-linux@zary.sk> <20220305201411.501-2-linux@zary.sk> <2a79b7ac-6648-7855-fcfa-de0800c9a310@opensource.wdc.com>
In-Reply-To: <2a79b7ac-6648-7855-fcfa-de0800c9a310@opensource.wdc.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202203070955.05800.linux@zary.sk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 March 2022, Damien Le Moal wrote:
> On 3/6/22 05:13, Ondrej Zary wrote:
> > Add pata_parport (PARIDE replacement) core libata driver.
> > 
> > Signed-off-by: Ondrej Zary <linux@zary.sk>
> > ---
> >  drivers/ata/Kconfig                     |  25 +
> >  drivers/ata/Makefile                    |   2 +
> >  drivers/ata/pata_parport/Kconfig        |  10 +
> >  drivers/ata/pata_parport/Makefile       |   9 +
> >  drivers/ata/pata_parport/pata_parport.c | 809 ++++++++++++++++++++++++
> >  drivers/ata/pata_parport/pata_parport.h | 110 ++++
> >  6 files changed, 965 insertions(+)
> >  create mode 100644 drivers/ata/pata_parport/Kconfig
> >  create mode 100644 drivers/ata/pata_parport/Makefile
> >  create mode 100644 drivers/ata/pata_parport/pata_parport.c
> >  create mode 100644 drivers/ata/pata_parport/pata_parport.h
> > 
> > diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> > index cb54631fd950..de4548471398 100644
> > --- a/drivers/ata/Kconfig
> > +++ b/drivers/ata/Kconfig
> > @@ -1161,6 +1161,31 @@ config PATA_WINBOND_VLB
> >  	  Support for the Winbond W83759A controller on Vesa Local Bus
> >  	  systems.
> >  
> > +config PATA_PARPORT
> > +	tristate "Parallel port IDE device support (PARIDE replacement)"
> 
> I would remove the "(PARIDE replacement)" from the title. If really
> needed, mention it in the description that this support used to be
> implemented by PARIDE. But I do not think that is necessary. The last
> paragraph of the description implies that.
> 
> > +	depends on PARPORT_PC
> > +	help
> > +	  There are many external CD-ROM and disk devices that connect through
> > +	  your computer's parallel port. Most of them are actually IDE devices
> > +	  using a parallel port IDE adapter. This option enables the PATA_PARPORT
> > +	  subsystem which contains drivers for many of these external drives.
> > +	  Read <file:Documentation/admin-guide/blockdev/paride.rst> for more information.
> > +
> > +	  If you have said Y to the "Parallel-port support" configuration
> > +	  option, you may share a single port between your printer and other
> > +	  parallel port devices. Answer Y to build PATA_PARPORT support into your
> > +	  kernel, or M if you would like to build it as a loadable module. If
> > +	  your parallel port support is in a loadable module, you must build
> > +	  PATA_PARPORT as a module. If you built PATA_PARPORT support into your kernel,
> > +	  you may still build the individual protocol modules as loadable
> > +	  modules. If you build this support as a module, it will be called pata_parport.
> > +
> > +	  Unlike the old PARIDE, there are no high-level drivers needed.
> > +	  The IDE devices behind parallel port adapters are handled by the
> > +	  ATA layer.
> 
> Several lines are too long. Rewrap please.
> 
> > +
> > +source "drivers/ata/pata_parport/Kconfig"
> > +
> >  comment "Generic fallback / legacy drivers"
> >  
> >  config PATA_ACPI
> > diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> > index b8aebfb14e82..bd6b5fdc004e 100644
> > --- a/drivers/ata/Makefile
> > +++ b/drivers/ata/Makefile
> > @@ -114,6 +114,8 @@ obj-$(CONFIG_PATA_SAMSUNG_CF)	+= pata_samsung_cf.o
> >  
> >  obj-$(CONFIG_PATA_PXA)		+= pata_pxa.o
> >  
> > +obj-$(CONFIG_PATA_PARPORT)	+= pata_parport/
> > +
> >  # Should be last but two libata driver
> >  obj-$(CONFIG_PATA_ACPI)		+= pata_acpi.o
> >  # Should be last but one libata driver
> > diff --git a/drivers/ata/pata_parport/Kconfig b/drivers/ata/pata_parport/Kconfig
> > new file mode 100644
> > index 000000000000..56dc6b25d5fa
> > --- /dev/null
> > +++ b/drivers/ata/pata_parport/Kconfig
> > @@ -0,0 +1,10 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# PATA_PARPORT configuration
> > +#
> > +# PATA_PARPORT doesn't need PARPORT, but if PARPORT is configured as a module,
> > +# PATA_PARPORT must also be a module.
> 
> This does not parse. If PARPORT is not needed, then why does how PARPORT
> is compiled matter ? Something is not consistent here.
> 
> > +# PATA_PARPORT only supports PC style parports. Tough for USB or other parports...
> 
> The second sentence does not parse. What are you trying to say ?

It's copied from paride.

> > +
> > +comment "Parallel IDE protocol modules"
> > +	depends on PATA_PARPORT
> > diff --git a/drivers/ata/pata_parport/Makefile b/drivers/ata/pata_parport/Makefile
> > new file mode 100644
> > index 000000000000..b105e1cb8dc6
> > --- /dev/null
> > +++ b/drivers/ata/pata_parport/Makefile
> > @@ -0,0 +1,9 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Makefile for Parallel port IDE device drivers.
> > +#
> > +# 7 October 2000, Bartlomiej Zolnierkiewicz <bkz@linux-ide.org>
> > +# Rewritten to use lists instead of if-statements.
> > +#
> > +
> > +obj-$(CONFIG_PATA_PARPORT)		+= pata_parport.o
> > diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
> > new file mode 100644
> > index 000000000000..7f814062cedd
> > --- /dev/null
> > +++ b/drivers/ata/pata_parport/pata_parport.c
> > @@ -0,0 +1,809 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/parport.h>
> > +#include "pata_parport.h"
> > +
> > +#define DRV_NAME "pata_parport"
> > +
> > +static DEFINE_IDR(parport_list);
> > +static DEFINE_IDR(protocols);
> > +static DEFINE_IDA(pata_parport_bus_dev_ids);
> > +static DEFINE_MUTEX(pi_mutex);
> > +
> > +static bool probe = 1;
> 
> s/1/true to match the type.
> 
> > +module_param(probe, bool, 0644);
> > +MODULE_PARM_DESC(probe, "Enable automatic device probing (0=off, 1=on [default])");
> > +
> > +static bool verbose;
> > +module_param(verbose, bool, 0644);
> > +MODULE_PARM_DESC(verbose, "Enable verbose messages (0=off [default], 1=on)");
> 
> Is this really necessary ? pr_debug() and all ata_xxx_debug() functions
> can be enabled dynamically.

The verbose messages are for adapter chip detection. That happens before the
ata host is registered.

> > +
> > +#define DISCONNECT_TIMEOUT	(HZ / 10)
> > +
> > +static void pi_connect(struct pi_adapter *pi)
> > +{
> > +	del_timer_sync(&pi->timer);
> > +	if (pi->claimed)
> > +		return;
> 
> Nit: I would reverse the condition to avoid the return. Or add a block
> line to separate the following hunk. Better readability this way, I think.
> 
> > +	pi->claimed = 1;
> > +	parport_claim_or_block(pi->pardev);
> > +	pi->proto->connect(pi);
> > +}
> > +
> > +static void pi_disconnect_later(struct pi_adapter *pi)
> > +{
> > +	mod_timer(&pi->timer, jiffies + DISCONNECT_TIMEOUT);
> > +}
> 
> Is this really needed ? Not sure it helps in any way. At least the name
> should be changed to reflect what this does. May be something like
> pi_start_disconnect_timeout() ?

Disconnect needs to happen after end of an operation so the parport is freed
for device(s) (like a printer) connected to pass-through port of a paride
device. There could be even multiple paride devices chained on one parport.

Disconnecting immediately at the end of each function does not work
(probably breaks the protocol?)

The old high-level drivers (pd, pf...) did connect and disconnect manually
on each operation (command or data transfer) but it does not seem to be
possible with libata.

> > +
> > +static void pi_disconnect_timer(struct timer_list *t)
> > +{
> > +	struct pi_adapter *pi = from_timer(pi, t, timer);
> > +
> > +	if (!pi->claimed)
> > +		return;
> 
> A blank line here would be nice for readability.
> 
> > +	pi->proto->disconnect(pi);
> > +	parport_release(pi->pardev);
> > +	pi->claimed = 0;
> > +}
> > +
> > +/* functions taken from libata-sff.c and converted from direct port I/O */
> > +static unsigned int pata_parport_devchk(struct ata_port *ap, unsigned int device)
> 
> Should this be a bool function ?

I don't know. It's copied from libata-sff.c
 
> > +{
> > +	struct pi_adapter *pi = ap->host->private_data;
> > +	u8 nsect, lbal;
> > +
> > +	ap->ops->sff_dev_select(ap, device);
> > +
> > +	pi_connect(pi);
> > +	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 0x55);
> > +	pi->proto->write_regr(pi, 0, ATA_REG_LBAL, 0xaa);
> > +
> > +	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 0xaa);
> > +	pi->proto->write_regr(pi, 0, ATA_REG_LBAL, 0x55);
> > +
> > +	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 055);
> > +	pi->proto->write_regr(pi, 0, ATA_REG_LBAL, 0xaa);
> > +
> > +	nsect = pi->proto->read_regr(pi, 0, ATA_REG_NSECT);
> > +	lbal = pi->proto->read_regr(pi, 0, ATA_REG_LBAL);
> > +	pi_disconnect_later(pi);
> > +
> > +	if ((nsect == 0x55) && (lbal == 0xaa))
> > +		return 1;	/* we found a device */
> > +
> > +	return 0;		/* nothing found */
> > +}
> > +
> > +static int pata_parport_bus_softreset(struct ata_port *ap, unsigned int devmask,
> > +				      unsigned long deadline)
> > +{
> > +	struct pi_adapter *pi = ap->host->private_data;
> > +
> > +	pi_connect(pi);
> > +	/* software reset.  causes dev0 to be selected */
> > +	pi->proto->write_regr(pi, 1, 6, ap->ctl);
> > +	udelay(20);	/* FIXME: flush */
> 
> Then please fix it.

I don't know what that means. It's copied from libata-sff.c

> > +	pi->proto->write_regr(pi, 1, 6, ap->ctl | ATA_SRST);
> > +	udelay(20);	/* FIXME: flush */
> 
> Here too.
> 
> > +	pi->proto->write_regr(pi, 1, 6, ap->ctl);
> > +	ap->last_ctl = ap->ctl;
> > +	pi_disconnect_later(pi);
> > +
> > +	/* wait the port to become ready */
> > +	return ata_sff_wait_after_reset(&ap->link, devmask, deadline);
> > +}
> > +
> > +static int pata_parport_softreset(struct ata_link *link, unsigned int *classes,
> > +				  unsigned long deadline)
> > +{
> > +	struct ata_port *ap = link->ap;
> > +	unsigned int slave_possible = ap->flags & ATA_FLAG_SLAVE_POSS;
> > +	unsigned int devmask = 0;
> > +	int rc;
> > +	u8 err;
> > +
> > +	/* determine if device 0/1 are present */
> > +	if (pata_parport_devchk(ap, 0))
> > +		devmask |= (1 << 0);
> > +	if (slave_possible && pata_parport_devchk(ap, 1))
> > +		devmask |= (1 << 1);
> > +
> > +	/* select device 0 again */
> > +	ap->ops->sff_dev_select(ap, 0);
> > +
> > +	/* issue bus reset */
> > +	rc = pata_parport_bus_softreset(ap, devmask, deadline);
> > +	/* if link is occupied, -ENODEV too is an error */
> 
> Please merge this comment with the one above. That will make the code
> more readable (I know this is the style used by many drivers, but let's
> not repeat the weird style :)).
> 
> > +	if (rc && (rc != -ENODEV || sata_scr_valid(link))) {
> > +		ata_link_err(link, "SRST failed (errno=%d)\n", rc);
> > +		return rc;
> > +	}
> > +
> > +	/* determine by signature whether we have ATA or ATAPI devices */
> > +	classes[0] = ata_sff_dev_classify(&link->device[0],
> > +					  devmask & (1 << 0), &err);
> > +	if (slave_possible && err != 0x81)
> > +		classes[1] = ata_sff_dev_classify(&link->device[1],
> > +						  devmask & (1 << 1), &err);
> > +
> > +	return 0;
> > +}
> > +
> > +static u8 pata_parport_check_status(struct ata_port *ap)
> > +{
> > +	u8 status;
> > +	struct pi_adapter *pi = ap->host->private_data;
> > +
> > +	pi_connect(pi);
> > +	status = pi->proto->read_regr(pi, 0, ATA_REG_STATUS);
> > +	pi_disconnect_later(pi);
> > +
> > +	return status;
> > +}
> > +
> > +static u8 pata_parport_check_altstatus(struct ata_port *ap)
> > +{
> > +	u8 altstatus;
> > +	struct pi_adapter *pi = ap->host->private_data;
> > +
> > +	pi_connect(pi);
> > +	altstatus = pi->proto->read_regr(pi, 1, 6);
> > +	pi_disconnect_later(pi);
> > +
> > +	return altstatus;
> > +}
> > +
> > +static void pata_parport_dev_select(struct ata_port *ap, unsigned int device)
> > +{
> > +	struct pi_adapter *pi = ap->host->private_data;
> > +	u8 tmp;
> > +
> > +	pi_connect(pi);
> > +	if (device == 0)
> > +		tmp = ATA_DEVICE_OBS;
> > +	else
> > +		tmp = ATA_DEVICE_OBS | ATA_DEV1;
> > +
> > +	pi->proto->write_regr(pi, 0, ATA_REG_DEVICE, tmp);
> > +	pi_disconnect_later(pi);
> > +	ata_sff_pause(ap);	/* needed; also flushes, for mmio */
> 
> The comment does not parse... Why is it needed ?
> And pleasde move the comment above the call, with a blank line
> separating it from the previous lines.

I don't know. It's copied from libata-sff.c

> > +}
> > +
> > +static void pata_parport_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
> > +{
> > +	struct pi_adapter *pi = ap->host->private_data;
> > +	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
> > +
> > +	pi_connect(pi);
> > +	if (tf->ctl != ap->last_ctl) {
> > +		pi->proto->write_regr(pi, 1, 6, tf->ctl);
> > +		ap->last_ctl = tf->ctl;
> > +		ata_wait_idle(ap);
> > +	}
> > +
> > +	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
> > +		pi->proto->write_regr(pi, 0, ATA_REG_FEATURE, tf->hob_feature);
> > +		pi->proto->write_regr(pi, 0, ATA_REG_NSECT, tf->hob_nsect);
> > +		pi->proto->write_regr(pi, 0, ATA_REG_LBAL, tf->hob_lbal);
> > +		pi->proto->write_regr(pi, 0, ATA_REG_LBAM, tf->hob_lbam);
> > +		pi->proto->write_regr(pi, 0, ATA_REG_LBAH, tf->hob_lbah);
> > +	}
> > +
> > +	if (is_addr) {
> 
> Move this if above the previous one. Doing so, you can remove the need
> for is_addr var and simplify the previous if condition.
> 
> That said, many pata drivers check that flag but it is always set by
> libata core. So checking it seems useless. Need to dig into this.

It's copied from libata-sff.c which is almost libata core.

> > +		pi->proto->write_regr(pi, 0, ATA_REG_FEATURE, tf->feature);
> > +		pi->proto->write_regr(pi, 0, ATA_REG_NSECT, tf->nsect);
> > +		pi->proto->write_regr(pi, 0, ATA_REG_LBAL, tf->lbal);
> > +		pi->proto->write_regr(pi, 0, ATA_REG_LBAM, tf->lbam);
> > +		pi->proto->write_regr(pi, 0, ATA_REG_LBAH, tf->lbah);
> > +	}
> > +
> > +	if (tf->flags & ATA_TFLAG_DEVICE)
> > +		pi->proto->write_regr(pi, 0, ATA_REG_DEVICE, tf->device);
> > +
> > +	ata_wait_idle(ap);
> > +	pi_disconnect_later(pi);
> > +}
> > +
> > +static void pata_parport_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
> > +{
> > +	struct pi_adapter *pi = ap->host->private_data;
> > +
> > +	pi_connect(pi);
> > +	tf->command = pi->proto->read_regr(pi, 0, ATA_REG_STATUS);
> > +	tf->feature = pi->proto->read_regr(pi, 0, ATA_REG_ERR);
> > +	tf->nsect = pi->proto->read_regr(pi, 0, ATA_REG_NSECT);
> > +	tf->lbal = pi->proto->read_regr(pi, 0, ATA_REG_LBAL);
> > +	tf->lbam = pi->proto->read_regr(pi, 0, ATA_REG_LBAM);
> > +	tf->lbah = pi->proto->read_regr(pi, 0, ATA_REG_LBAH);
> > +	tf->device = pi->proto->read_regr(pi, 0, ATA_REG_DEVICE);
> > +
> > +	if (tf->flags & ATA_TFLAG_LBA48) {
> > +		pi->proto->write_regr(pi, 1, 6, tf->ctl | ATA_HOB);
> > +		tf->hob_feature = pi->proto->read_regr(pi, 0, ATA_REG_ERR);
> > +		tf->hob_nsect = pi->proto->read_regr(pi, 0, ATA_REG_NSECT);
> > +		tf->hob_lbal = pi->proto->read_regr(pi, 0, ATA_REG_LBAL);
> > +		tf->hob_lbam = pi->proto->read_regr(pi, 0, ATA_REG_LBAM);
> > +		tf->hob_lbah = pi->proto->read_regr(pi, 0, ATA_REG_LBAH);
> > +		pi->proto->write_regr(pi, 1, 6, tf->ctl);
> > +		ap->last_ctl = tf->ctl;
> > +	}
> > +	pi_disconnect_later(pi);
> > +}
> > +
> > +static void pata_parport_exec_command(struct ata_port *ap, const struct ata_taskfile *tf)
> > +{
> > +	struct pi_adapter *pi = ap->host->private_data;
> > +
> > +	pi_connect(pi);
> > +	pi->proto->write_regr(pi, 0, ATA_REG_CMD, tf->command);
> > +	ata_sff_pause(ap);
> > +	pi_disconnect_later(pi);
> > +}
> > +
> > +static unsigned int pata_parport_data_xfer(struct ata_queued_cmd *qc, unsigned char *buf,
> > +					   unsigned int buflen, int rw)
> > +{
> > +	struct ata_port *ap = qc->dev->link->ap;
> > +	struct pi_adapter *pi = ap->host->private_data;
> > +
> > +	pi_connect(pi);
> > +	if (rw == READ)
> > +		pi->proto->read_block(pi, buf, buflen);
> > +	else
> > +		pi->proto->write_block(pi, buf, buflen);
> > +	pi_disconnect_later(pi);
> > +
> > +	return buflen;
> > +}
> > +
> > +static void pata_parport_drain_fifo(struct ata_queued_cmd *qc)
> > +{
> > +	int count;
> > +	struct ata_port *ap;
> > +	struct pi_adapter *pi;
> > +	char junk[2];
> > +
> > +	/* We only need to flush incoming data when a command was running */
> > +	if (qc == NULL || qc->dma_dir == DMA_TO_DEVICE)
> > +		return;
> > +
> > +	ap = qc->ap;
> > +	pi = ap->host->private_data;
> > +	/* Drain up to 64K of data before we give up this recovery method */
> > +	for (count = 0; (ap->ops->sff_check_status(ap) & ATA_DRQ)
> > +						&& count < 65536; count += 2) {
> > +		pi_connect(pi);
> > +		pi->proto->read_block(pi, junk, 2);
> > +		pi_disconnect_later(pi);
> > +	}
> > +
> > +	if (count)
> > +		ata_port_dbg(ap, "drained %d bytes to clear DRQ\n", count);
> > +}
> > +
> > +static void pata_parport_lost_interrupt(struct ata_port *ap)
> > +{
> > +	u8 status;
> > +	struct ata_queued_cmd *qc;
> > +
> > +	/* Only one outstanding command per SFF channel */
> > +	qc = ata_qc_from_tag(ap, ap->link.active_tag);
> > +	/* We cannot lose an interrupt on a non-existent or polled command */
> > +	if (!qc || qc->tf.flags & ATA_TFLAG_POLLING)
> > +		return;
> > +	/* See if the controller thinks it is still busy - if so the command
> > +	   isn't a lost IRQ but is still in progress */
> 
> Please use multi-line comment style:
> 
> /*
>  * See if...
>  * ...
>  */
> 
> > +	status = pata_parport_check_altstatus(ap);
> > +	if (status & ATA_BUSY)
> > +		return;
> > +
> > +	/* There was a command running, we are no longer busy and we have
> > +	   no interrupt. */
> 
> same
> 
> > +	ata_port_warn(ap, "lost interrupt (Status 0x%x)\n", status);
> > +	/* Run the host interrupt logic as if the interrupt had not been lost */
> > +	ata_sff_port_intr(ap, qc);
> > +}
> > +
> > +static struct ata_port_operations pata_parport_port_ops = {
> > +	.qc_prep		= ata_noop_qc_prep,
> > +	.qc_issue		= ata_sff_qc_issue,
> > +	.qc_fill_rtf		= ata_sff_qc_fill_rtf,
> > +
> > +	.freeze			= ata_sff_freeze,
> > +	.thaw			= ata_sff_thaw,
> > +	.prereset		= ata_sff_prereset,
> > +	.softreset		= pata_parport_softreset,
> > +	.postreset		= ata_sff_postreset,
> > +	.error_handler		= ata_sff_error_handler,
> > +	.sched_eh		= ata_std_sched_eh,
> > +	.end_eh			= ata_std_end_eh,
> > +
> > +	.sff_dev_select		= pata_parport_dev_select,
> > +	.sff_check_status	= pata_parport_check_status,
> > +	.sff_check_altstatus	= pata_parport_check_altstatus,
> > +	.sff_tf_load		= pata_parport_tf_load,
> > +	.sff_tf_read		= pata_parport_tf_read,
> > +	.sff_exec_command	= pata_parport_exec_command,
> > +	.sff_data_xfer		= pata_parport_data_xfer,
> > +	.sff_drain_fifo		= pata_parport_drain_fifo,
> > +
> > +	.lost_interrupt		= pata_parport_lost_interrupt,
> > +};
> > +
> > +static const struct ata_port_info pata_parport_port_info = {
> > +	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_PIO_POLLING,
> > +	.pio_mask	= ATA_PIO0,
> > +	/* No DMA */
> > +	.port_ops	= &pata_parport_port_ops,
> > +};
> > +
> > +void pi_release(struct pi_adapter *pi)
> > +{
> > +	parport_unregister_device(pi->pardev);
> > +	if (pi->proto->release_proto)
> > +		pi->proto->release_proto(pi);
> > +	module_put(pi->proto->owner);
> > +}
> > +
> > +static int default_test_proto(struct pi_adapter *pi, char *scratch)
> > +{
> > +	int j, k;
> > +	int e[2] = { 0, 0 };
> > +
> > +	pi->proto->connect(pi);
> > +
> > +	for (j = 0; j < 2; j++) {
> > +		pi->proto->write_regr(pi, 0, 6, 0xa0 + j * 0x10);
> > +		for (k = 0; k < 256; k++) {
> > +			pi->proto->write_regr(pi, 0, 2, k ^ 0xaa);
> > +			pi->proto->write_regr(pi, 0, 3, k ^ 0x55);
> > +			if (pi->proto->read_regr(pi, 0, 2) != (k ^ 0xaa))
> > +				e[j]++;
> > +		}
> > +	}
> > +	pi->proto->disconnect(pi);
> > +
> > +	if (verbose)
> > +		dev_info(&pi->dev, "%s: port 0x%x, mode  %d, test=(%d,%d)\n",
> > +		       pi->proto->name, pi->port,
> > +		       pi->mode, e[0], e[1]);
> > +
> > +	return (e[0] && e[1]);	/* not here if both > 0 */
> > +}
> > +
> > +static int pi_test_proto(struct pi_adapter *pi, char *scratch)
> > +{
> > +	int res;
> > +
> > +	parport_claim_or_block(pi->pardev);
> > +	if (pi->proto->test_proto)
> > +		res = pi->proto->test_proto(pi, scratch, verbose);
> > +	else
> > +		res = default_test_proto(pi, scratch);
> > +	parport_release(pi->pardev);
> > +
> > +	return res;
> > +}
> > +
> > +static int pi_probe_mode(struct pi_adapter *pi, int max, char *scratch)
> > +{
> > +	int best, range;
> > +
> > +	if (pi->mode != -1) {
> > +		if (pi->mode >= max)
> > +			return 0;
> > +		range = 3;
> > +		if (pi->mode >= pi->proto->epp_first)
> > +			range = 8;
> > +		if ((range == 8) && (pi->port % 8))
> 
> extra internal parenthesis not needed.
> 
> > +			return 0;
> > +		return (!pi_test_proto(pi, scratch));
> > +	}
> > +	best = -1;
> > +	for (pi->mode = 0; pi->mode < max; pi->mode++) {
> > +		range = 3;
> > +		if (pi->mode >= pi->proto->epp_first)
> > +			range = 8;
> > +		if ((range == 8) && (pi->port % 8))
> 
> same
> 
> > +			break;
> > +		if (!pi_test_proto(pi, scratch))
> > +			best = pi->mode;
> > +	}
> > +	pi->mode = best;
> > +	return (best > -1);
> 
> same
> 
> > +}
> > +
> > +
> > +static int pi_probe_unit(struct pi_adapter *pi, int unit, char *scratch)
> > +{
> > +	int max, s, e;
> > +
> > +	s = unit;
> > +	e = s + 1;
> > +
> > +	if (s == -1) {
> > +		s = 0;
> > +		e = pi->proto->max_units;
> > +	}
> > +
> > +	if (pi->proto->test_port) {
> > +		parport_claim_or_block(pi->pardev);
> > +		max = pi->proto->test_port(pi);
> > +		parport_release(pi->pardev);
> > +	} else
> > +		max = pi->proto->max_mode;
> 
> Please add curly bracket for the else too.
> 
> > +
> > +	if (pi->proto->probe_unit) {
> > +		parport_claim_or_block(pi->pardev);
> > +		for (pi->unit = s; pi->unit < e; pi->unit++)
> > +			if (pi->proto->probe_unit(pi)) {
> > +				parport_release(pi->pardev);
> > +				if (pi_probe_mode(pi, max, scratch))
> > +					return 1;
> > +				return 0;
> > +			}
> 
> Please add curly bracket for the for too. Technically not needed, but
> since the "if" is over multiple lines, this will make the code more
> readable (I had to recheck why the following parport_release() call was
> indented like this...).
> 
> > +		parport_release(pi->pardev);
> > +		return 0;
> > +	}
> > +
> > +	if (!pi_probe_mode(pi, max, scratch))
> > +		return 0;
> > +	return 1;
> 
> return pi_probe_mode(pi, max, scratch); ?
> 
> > +}
> > +
> > +static void pata_parport_dev_release(struct device *dev)
> > +{
> > +	struct pi_adapter *pi = container_of(dev, struct pi_adapter, dev);
> > +
> > +	kfree(pi);
> > +}
> > +
> > +void pata_parport_bus_release(struct device *dev)
> > +{
> > +	/* nothing to do here but required to avoid warning on device removal */
> > +}
> > +
> > +static struct bus_type pata_parport_bus_type = {
> > +	.name = DRV_NAME,
> > +};
> > +
> > +static struct device pata_parport_bus = {
> > +	.init_name = DRV_NAME,
> > +	.release = pata_parport_bus_release,
> > +};
> > +
> > +struct pi_adapter *pi_init_one(struct parport *parport, struct pi_protocol *pr,
> > +			       int mode, int unit, int delay)
> > +{
> > +	struct pardev_cb par_cb = { };
> > +	char scratch[512];
> > +	const struct ata_port_info *ppi[] = { &pata_parport_port_info };
> > +	struct ata_host *host;
> > +	struct pi_adapter *pi = kzalloc(sizeof(struct pi_adapter), GFP_KERNEL);
> 
> I would prefer hainving the pi = kzalloc() initialization right above
> the "if (!pi)" below.
> 
> > +
> > +	if (!pi)
> > +		return NULL;
> > +
> > +	/* set up pi->dev before pi_probe_unit() so it can use dev_printk() */
> > +	pi->dev.parent = &pata_parport_bus;
> > +	pi->dev.bus = &pata_parport_bus_type;
> > +	pi->dev.driver = &pr->driver;
> > +	pi->dev.release = pata_parport_dev_release;
> > +	pi->dev.id = ida_alloc(&pata_parport_bus_dev_ids, GFP_KERNEL);
> > +	if (pi->dev.id < 0)
> > +		return NULL; /* pata_parport_dev_release will do kfree(pi) */
> > +	dev_set_name(&pi->dev, "pata_parport.%u", pi->dev.id);
> > +	if (device_register(&pi->dev)) {
> > +		put_device(&pi->dev);
> > +		goto out_ida_free;
> > +	}
> > +
> > +	pi->proto = pr;
> > +
> > +	/* still racy */
> 
> What is racy ?

I don't know - the comment came from paride. I'll probably just delete it.

> > +	if (!try_module_get(pi->proto->owner))
> > +		goto out_unreg_dev;
> > +	if (pi->proto->init_proto && pi->proto->init_proto(pi) < 0)
> > +		goto out_module_put;
> > +
> > +	pi->delay = (delay == -1) ? pi->proto->default_delay : delay;
> > +	pi->mode = mode;
> > +	pi->port = parport->base;
> > +
> > +	par_cb.private = pi;
> > +	pi->pardev = parport_register_dev_model(parport, dev_name(&pi->dev),
> > +						&par_cb, pi->dev.id);
> > +	if (!pi->pardev)
> > +		goto out_module_put;
> > +
> > +	if (!pi_probe_unit(pi, unit, scratch)) {
> > +		dev_info(&pi->dev, "Adapter not found\n");
> > +		goto out_unreg_parport;
> > +	}
> > +
> > +	pi->proto->log_adapter(pi, scratch, verbose);
> > +
> > +	host = ata_host_alloc_pinfo(&pi->dev, ppi, 1);
> > +	if (!host)
> > +		goto out_unreg_parport;
> > +	dev_set_drvdata(&pi->dev, host);
> > +	host->private_data = pi;
> > +
> > +	ata_port_desc(host->ports[0], "port %s", pi->pardev->port->name);
> > +	ata_port_desc(host->ports[0], "protocol %s", pi->proto->name);
> > +
> > +	timer_setup(&pi->timer, pi_disconnect_timer, 0);
> > +
> > +	if (ata_host_activate(host, 0, NULL, 0, &pi->proto->sht))
> > +		goto out_unreg_parport;
> > +
> > +	return pi;
> > +
> > +out_unreg_parport:
> > +	parport_unregister_device(pi->pardev);
> > +	if (pi->proto->release_proto)
> > +		pi->proto->release_proto(pi);
> > +out_module_put:
> > +	module_put(pi->proto->owner);
> > +out_unreg_dev:
> > +	device_unregister(&pi->dev);
> > +out_ida_free:
> > +	ida_free(&pata_parport_bus_dev_ids, pi->dev.id);
> > +	return NULL;
> > +}
> > +
> > +int pata_parport_register_driver(struct pi_protocol *pr)
> > +{
> > +	int error;
> > +	struct parport *parport;
> > +	int port_num;
> > +
> > +	pr->driver.bus = &pata_parport_bus_type;
> > +	pr->driver.name = pr->name;
> > +	error = driver_register(&pr->driver);
> > +	if (error)
> > +		return error;
> > +
> > +	mutex_lock(&pi_mutex);
> > +	error = idr_alloc(&protocols, pr, 0, 0, GFP_KERNEL);
> > +	if (error < 0) {
> > +		driver_unregister(&pr->driver);
> > +		mutex_unlock(&pi_mutex);
> > +		return error;
> > +	}
> > +
> > +	pr_info("pata_parport: protocol %s registered\n", pr->name);
> > +
> > +	if (probe)	/* probe all parports using this protocol */
> 
> Please move the comment inside the if and use curly brackets for the if
> since its statement is multi-line.
> 
> > +		idr_for_each_entry(&parport_list, parport, port_num)
> > +			pi_init_one(parport, pr, -1, 0, -1);
> > +	mutex_unlock(&pi_mutex);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(pata_parport_register_driver);
> > +
> > +void pata_parport_unregister_driver(struct pi_protocol *pr)
> > +{
> > +	struct pi_protocol *pr_iter;
> > +	int id = -1;
> > +
> > +	mutex_lock(&pi_mutex);
> > +	idr_for_each_entry(&protocols, pr_iter, id)
> 
> Add curly brackets.
> 
> > +		if (pr_iter == pr)
> > +			break;
> > +	idr_remove(&protocols, id);
> > +	mutex_unlock(&pi_mutex);
> > +	pr_info("pata_parport: protocol %s removed\n", pr->name);
> 
> I do not think this message is needed.
> 
> > +	driver_unregister(&pr->driver);
> > +}
> > +EXPORT_SYMBOL(pata_parport_unregister_driver);
> > +
> > +static ssize_t new_device_store(struct bus_type *bus, const char *buf, size_t count)
> > +{
> > +	char port[12] = "auto";
> > +	char protocol[8] = "auto";
> > +	int mode = -1, unit = -1, delay = -1;
> > +	struct pi_protocol *pr, *pr_wanted;
> > +	struct device_driver *drv;
> > +	struct parport *parport;
> > +	int port_num, port_wanted, pr_num;
> > +	bool ok = false;
> > +
> > +	if (sscanf(buf, "%11s %7s %d %d %d",
> > +			port, protocol, &mode, &unit, &delay) < 1)
> > +		return -EINVAL;
> > +
> > +	if (sscanf(port, "parport%u", &port_wanted) < 1) {
> > +		if (!strcmp(port, "auto"))
> 
> Curly brackets please.
> > +			port_wanted = -1;
> > +		else {
> > +			pr_err("invalid port name %s\n", port);
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	drv = driver_find(protocol, &pata_parport_bus_type);
> > +	if (!drv) {
> > +		if (!strcmp(protocol, "auto"))
> > +			pr_wanted = NULL;
> 
> same.
> 
> > +		else {
> > +			pr_err("protocol %s not found\n", protocol);
> > +			return -EINVAL;
> > +		}
> > +	} else
> > +		pr_wanted = container_of(drv, struct pi_protocol, driver);
> 
> Here too.
> 
> > +
> > +	mutex_lock(&pi_mutex);
> > +	/* walk all parports */
> > +	idr_for_each_entry(&parport_list, parport, port_num) {
> > +		if (port_num == port_wanted || port_wanted == -1) {
> > +			parport = parport_find_number(port_num);
> > +			if (!parport) {
> > +				pr_err("no such port %s\n", port);
> > +				mutex_unlock(&pi_mutex);
> > +				return -ENODEV;
> > +			}
> > +			/* walk all protocols */
> > +			idr_for_each_entry(&protocols, pr, pr_num)
> 
> Add curly brackets to this one too.
> 
> > +				if (pr == pr_wanted || !pr_wanted)
> > +					if (pi_init_one(parport, pr, mode, unit,
> > +							delay))
> > +						ok = true;
> > +			parport_put_port(parport);
> > +		}
> > +	}
> > +	mutex_unlock(&pi_mutex);
> > +	if (!ok)
> > +		return -ENODEV;
> > +
> > +	return count;
> > +}
> > +static BUS_ATTR_WO(new_device);
> > +
> > +static void pi_remove_one(struct device *dev)
> > +{
> > +	struct ata_host *host = dev_get_drvdata(dev);
> > +	struct pi_adapter *pi = host->private_data;
> > +
> > +	ata_host_detach(host);
> > +	del_timer_sync(&pi->timer);
> > +	pi_release(pi);
> > +	device_unregister(dev);
> > +	ida_free(&pata_parport_bus_dev_ids, dev->id);
> > +	/* pata_parport_dev_release will do kfree(pi) */
> > +}
> > +
> > +static ssize_t delete_device_store(struct bus_type *bus, const char *buf, size_t count)
> > +{
> > +	struct device *dev;
> > +	char device_name[32];
> > +	int fields;
> > +
> > +	fields = sscanf(buf, "%31s", device_name);
> > +	if (fields < 1)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&pi_mutex);
> > +	dev = bus_find_device_by_name(bus, NULL, device_name);
> > +	if (!dev) {
> > +		mutex_unlock(&pi_mutex);
> > +		return -ENODEV;
> > +	}
> > +
> > +	pi_remove_one(dev);
> > +	mutex_unlock(&pi_mutex);
> > +
> > +	return count;
> > +}
> > +static BUS_ATTR_WO(delete_device);
> > +
> > +static void pata_parport_attach(struct parport *port)
> > +{
> > +	struct pi_protocol *pr;
> > +	int pr_num, id;
> > +
> > +	mutex_lock(&pi_mutex);
> > +	id = idr_alloc(&parport_list, port, port->number, port->number, GFP_KERNEL);
> > +	if (id < 0) {
> > +		mutex_unlock(&pi_mutex);
> > +		return;
> > +	}
> > +
> > +	if (probe) /* probe this port using all protocols */
> > +		idr_for_each_entry(&protocols, pr, pr_num)
> > +			pi_init_one(port, pr, -1, 0, -1);
> 
> Curly brackets and comment under the if.
> 
> > +	mutex_unlock(&pi_mutex);
> > +}
> > +
> > +static int pi_remove_port(struct device *dev, void *p)
> > +{
> > +	struct ata_host *host = dev_get_drvdata(dev);
> > +	struct pi_adapter *pi = host->private_data;
> > +
> > +	if (pi->pardev->port == p)
> > +		pi_remove_one(dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static void pata_parport_detach(struct parport *port)
> > +{
> > +	mutex_lock(&pi_mutex);
> > +	bus_for_each_dev(&pata_parport_bus_type, NULL, port, pi_remove_port);
> > +	idr_remove(&parport_list, port->number);
> > +	mutex_unlock(&pi_mutex);
> > +}
> > +
> > +static struct parport_driver pata_parport_driver = {
> > +	.name = DRV_NAME,
> > +	.match_port = pata_parport_attach,
> > +	.detach = pata_parport_detach,
> > +	.devmodel = true,
> > +};
> > +
> > +static __init int pata_parport_init(void)
> > +{
> > +	int error;
> > +
> > +	error = bus_register(&pata_parport_bus_type);
> > +	if (error) {
> > +		pr_err("failed to register pata_parport bus, error: %d\n", error);
> > +		return error;
> > +	}
> > +
> > +	error = device_register(&pata_parport_bus);
> > +	if (error) {
> > +		pr_err("failed to register pata_parport bus, error: %d\n", error);
> > +		return error;
> 
> Bug. This should not be here.
> 
> > +		goto out_unregister_bus;
> > +	}
> > +
> > +	error = bus_create_file(&pata_parport_bus_type, &bus_attr_new_device);
> > +	if (error) {
> > +		pr_err("unable to create sysfs file, error: %d\n", error);
> > +		goto out_unregister_dev;
> > +	}
> > +
> > +	error = bus_create_file(&pata_parport_bus_type, &bus_attr_delete_device);
> > +	if (error) {
> > +		pr_err("unable to create sysfs file, error: %d\n", error);
> > +		goto out_remove_new;
> > +	}
> > +
> > +	error = parport_register_driver(&pata_parport_driver);
> > +	if (error) {
> > +		pr_err("unable to register parport driver, error: %d\n", error);
> > +		goto out_remove_del;
> > +	}
> > +
> > +	return 0;
> > +
> > +out_remove_del:
> > +	bus_remove_file(&pata_parport_bus_type, &bus_attr_delete_device);
> > +out_remove_new:
> > +	bus_remove_file(&pata_parport_bus_type, &bus_attr_new_device);
> > +out_unregister_dev:
> > +	device_unregister(&pata_parport_bus);
> > +out_unregister_bus:
> > +	bus_unregister(&pata_parport_bus_type);
> > +	return error;
> > +}
> > +
> > +static __exit void pata_parport_exit(void)
> > +{
> > +	parport_unregister_driver(&pata_parport_driver);
> > +	bus_remove_file(&pata_parport_bus_type, &bus_attr_new_device);
> > +	bus_remove_file(&pata_parport_bus_type, &bus_attr_delete_device);
> > +	device_unregister(&pata_parport_bus);
> > +	bus_unregister(&pata_parport_bus_type);
> > +}
> > +
> > +MODULE_AUTHOR("Ondrej Zary");
> > +MODULE_DESCRIPTION("driver for parallel port ATA adapters");
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("paride");
> > +
> > +module_init(pata_parport_init);
> > +module_exit(pata_parport_exit);
> > diff --git a/drivers/ata/pata_parport/pata_parport.h b/drivers/ata/pata_parport/pata_parport.h
> > new file mode 100644
> > index 000000000000..c4201b809b20
> > --- /dev/null
> > +++ b/drivers/ata/pata_parport/pata_parport.h
> > @@ -0,0 +1,110 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + *	paride.h	(c) 1997-8  Grant R. Guenther <grant@torque.net>
> > + *				    Under the terms of the GPL.
> > + *
> > + * This file defines the interface for adapter chip drivers.
> 
> Which adapter ? "Parallel port IDE adapter chip", no ?
> 
> > + */
> > +
> > +#include <linux/libata.h>
> > +
> > +struct pi_adapter {
> > +	struct device dev;
> > +	struct pi_protocol *proto;	/* adapter protocol */
> > +	int port;			/* base address of parallel port */
> > +	int mode;			/* transfer mode in use */
> > +	int delay;			/* adapter delay setting */
> > +	int unit;			/* unit number for chained adapters */
> > +	int saved_r0;			/* saved port state */
> > +	int saved_r2;			/* saved port state */
> > +	unsigned long private;		/* for protocol module */
> > +	struct pardevice *pardev;	/* pointer to pardevice */
> > +	int claimed;			/* parport has already been claimed */
> 
> Make this a bool ?
> 
> > +	struct timer_list timer;	/* disconnect timer */
> > +};
> > +
> > +/* registers are addressed as (cont,regr)
> > + *	cont: 0 for command register file, 1 for control register(s)
> > + *	regr: 0-7 for register number.
> > + */
> > +
> > +/* macros and functions exported to the protocol modules */
> > +#define delay_p			(pi->delay ? udelay(pi->delay) : (void)0)
> > +#define out_p(offs, byte)	do { outb(byte, pi->port + offs); delay_p; } while (0)
> > +#define in_p(offs)		(delay_p, inb(pi->port + offs))
> > +
> > +#define w0(byte)		out_p(0, byte)
> > +#define r0()			(in_p(0) & 0xff)
> > +#define w1(byte)		out_p(1, byte)
> > +#define r1()			(in_p(1) & 0xff)
> > +#define w2(byte)		out_p(2, byte)
> > +#define r2()			(in_p(2) & 0xff)
> > +#define w3(byte)		out_p(3, byte)
> > +#define w4(byte)		out_p(4, byte)
> > +#define r4()			(in_p(4) & 0xff)
> > +#define w4w(data)		do { outw(data, pi->port + 4); delay_p; } while (0)
> > +#define w4l(data)		do { outl(data, pi->port + 4); delay_p; } while (0)
> > +#define r4w()			(delay_p, inw(pi->port + 4) & 0xffff)
> > +#define r4l()			(delay_p, inl(pi->port + 4) & 0xffffffff)
> 
> Why not align this with the others ?

It's aligned properly in the file, only looks bad in a diff.

> > +
> > +static inline u16 pi_swab16(char *b, int k)
> > +{
> > +	union { u16 u; char t[2]; } r;
> > +
> > +	r.t[0] = b[2 * k + 1]; r.t[1] = b[2 * k];
> > +	return r.u;
> > +}
> > +
> > +static inline u32 pi_swab32(char *b, int k)
> > +{
> > +	union { u32 u; char f[4]; } r;
> > +
> > +	r.f[0] = b[4 * k + 1]; r.f[1] = b[4 * k];
> > +	r.f[2] = b[4 * k + 3]; r.f[3] = b[4 * k + 2];
> > +	return r.u;
> > +}
> > +
> > +struct pi_protocol {
> > +	char name[8];		/* name for this protocol */
> > +
> > +	int max_mode;		/* max mode number */
> > +	int epp_first;		/* modes >= this use 8 ports */
> > +
> > +	int default_delay;	/* delay parameter if not specified */
> > +	int max_units;		/* max chained units probed for */
> 
> Except maybe epp_first, I find the comments for these fields useless: no
> information added.
> 
> > +
> > +	void (*write_regr)(struct pi_adapter *pi, int cont, int regr, int val);
> > +	int (*read_regr)(struct pi_adapter *pi, int cont, int regr);
> > +	void (*write_block)(struct pi_adapter *pi, char *buf, int count);
> > +	void (*read_block)(struct pi_adapter *pi, char *buf, int count);
> > +
> > +	void (*connect)(struct pi_adapter *pi);
> > +	void (*disconnect)(struct pi_adapter *pi);
> > +
> > +	int (*test_port)(struct pi_adapter *pi);
> > +	int (*probe_unit)(struct pi_adapter *pi);
> > +	int (*test_proto)(struct pi_adapter *pi, char *scratch, int verbose);
> > +	void (*log_adapter)(struct pi_adapter *pi, char *scratch, int verbose);
> > +
> > +	int (*init_proto)(struct pi_adapter *pi);
> > +	void (*release_proto)(struct pi_adapter *pi);
> > +	struct module *owner;
> > +	struct device_driver driver;
> > +	struct scsi_host_template sht;
> > +};
> > +
> > +#define PATA_PARPORT_SHT ATA_PIO_SHT
> > +
> > +extern int pata_parport_register_driver(struct pi_protocol *pr);
> > +extern void pata_parport_unregister_driver(struct pi_protocol *pr);
> 
> No need for extern.
> 
> > +
> > +/**
> > + * module_pata_parport_driver() - Helper macro for registering a pata_parport driver
> > + * @__pi_protocol: pi_protocol struct
> > + *
> > + * Helper macro for pata_parport drivers which do not do anything special in module
> > + * init/exit. This eliminates a lot of boilerplate. Each module may only
> > + * use this macro once, and calling it replaces module_init() and module_exit()
> > + */
> > +#define module_pata_parport_driver(__pi_protocol) \
> > +	module_driver(__pi_protocol, pata_parport_register_driver, pata_parport_unregister_driver)
> 
> Make this a static inline ?

It's a macro that expands to other macro (defined in include/linux/device/driver.h)
that expands to __init and __exit functions, module_init() and
module_exit() so we can use:

module_pata_parport_driver(on26);

instead of:

static int __init on26_init(void)
{
	return pata_parport_register_driver(&on26);
}

static void __exit on26_exit(void)
{
	pata_parport_unregister_driver(&on26);
}

module_init(on26_init)
module_exit(on26_exit)

-- 
Ondrej Zary
