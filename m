Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DBB4D07F2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 20:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244125AbiCGTvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 14:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245131AbiCGTvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 14:51:09 -0500
Received: from mxout03.lancloud.ru (mxout03.lancloud.ru [45.84.86.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7D64FC6D;
        Mon,  7 Mar 2022 11:50:03 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 20BFC208D334
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH 01/16] pata_parport: add core driver (PARIDE replacement)
To:     Ondrej Zary <linux@zary.sk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, <linux-block@vger.kernel.org>,
        <linux-parport@lists.infradead.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220305201411.501-1-linux@zary.sk>
 <20220305201411.501-2-linux@zary.sk>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <6178f89d-b84d-51af-37fc-44f7016d0a70@omp.ru>
Date:   Mon, 7 Mar 2022 22:49:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220305201411.501-2-linux@zary.sk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 3/5/22 11:13 PM, Ondrej Zary wrote:

> Add pata_parport (PARIDE replacement) core libata driver.
> 
> Signed-off-by: Ondrej Zary <linux@zary.sk>
> ---
>  drivers/ata/Kconfig                     |  25 +
>  drivers/ata/Makefile                    |   2 +
>  drivers/ata/pata_parport/Kconfig        |  10 +
>  drivers/ata/pata_parport/Makefile       |   9 +
>  drivers/ata/pata_parport/pata_parport.c | 809 ++++++++++++++++++++++++
>  drivers/ata/pata_parport/pata_parport.h | 110 ++++

   I'd like to suggest to just name the new subdirectory 'parport'.
And it looks like I'll need to update my MAINTAINBERS entry to include this driver... :-)

[...]
> diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
> new file mode 100644
> index 000000000000..7f814062cedd
> --- /dev/null
> +++ b/drivers/ata/pata_parport/pata_parport.c
> @@ -0,0 +1,809 @@
[...]
> +static bool probe = 1;

   s/1/true/.

[...]
> +/* functions taken from libata-sff.c and converted from direct port I/O */
> +static unsigned int pata_parport_devchk(struct ata_port *ap, unsigned int device)

   Should return bool now, see e.g..:

https://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git/commit/?h=for-next&id=1336aa88d8553292604878c53538297fbc65bf0a

> +{
> +	struct pi_adapter *pi = ap->host->private_data;
> +	u8 nsect, lbal;
> +
> +	ap->ops->sff_dev_select(ap, device);

   Could call your sff-dev_select() methid directly here?

[...]
> +static int pata_parport_bus_softreset(struct ata_port *ap, unsigned int devmask,
> +				      unsigned long deadline)
> +{
> +	struct pi_adapter *pi = ap->host->private_data;
> +
> +	pi_connect(pi);
> +	/* software reset.  causes dev0 to be selected */
> +	pi->proto->write_regr(pi, 1, 6, ap->ctl);
> +	udelay(20);	/* FIXME: flush */

   I don't think this FIXME applies to your driver...

[...]
> +static int pata_parport_softreset(struct ata_link *link, unsigned int *classes,
> +				  unsigned long deadline)
> +{
> +	struct ata_port *ap = link->ap;
> +	unsigned int slave_possible = ap->flags & ATA_FLAG_SLAVE_POSS;

   Isn't this flag always set in your driver?

> +	unsigned int devmask = 0;
> +	int rc;
> +	u8 err;
> +
> +	/* determine if device 0/1 are present */
> +	if (pata_parport_devchk(ap, 0))
> +		devmask |= (1 << 0);
> +	if (slave_possible && pata_parport_devchk(ap, 1))
> +		devmask |= (1 << 1);
> +
> +	/* select device 0 again */
> +	ap->ops->sff_dev_select(ap, 0);

   Again, could you call this directly?

> +
> +	/* issue bus reset */
> +	rc = pata_parport_bus_softreset(ap, devmask, deadline);
> +	/* if link is occupied, -ENODEV too is an error */
> +	if (rc && (rc != -ENODEV || sata_scr_valid(link))) {

   It's a PATA driver, why call sata_scr_valid() at all?

[...]
> +static void pata_parport_dev_select(struct ata_port *ap, unsigned int device)
> +{
> +	struct pi_adapter *pi = ap->host->private_data;
> +	u8 tmp;
> +
> +	pi_connect(pi);

   Why not call it after this *if*?

> +	if (device == 0)
> +		tmp = ATA_DEVICE_OBS;
> +	else
> +		tmp = ATA_DEVICE_OBS | ATA_DEV1;
> +
> +	pi->proto->write_regr(pi, 0, ATA_REG_DEVICE, tmp);
> +	pi_disconnect_later(pi);
> +	ata_sff_pause(ap);	/* needed; also flushes, for mmio */

   Does this comment make sense in your driver?

[...]
> +static void pata_parport_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
> +{
> +	struct pi_adapter *pi = ap->host->private_data;
> +
> +	pi_connect(pi);
> +	tf->command = pi->proto->read_regr(pi, 0, ATA_REG_STATUS);

   Use tf->status please, see:

https://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git/commit/?h=for-next&id=efcef265fd83d9a68a68926abecb3e1dd3e260a8

> +	tf->feature = pi->proto->read_regr(pi, 0, ATA_REG_ERR);

   Use tf->error as well please.

[...]
> +static void pata_parport_lost_interrupt(struct ata_port *ap)
> +{
> +	u8 status;
> +	struct ata_queued_cmd *qc;
> +
> +	/* Only one outstanding command per SFF channel */
> +	qc = ata_qc_from_tag(ap, ap->link.active_tag);
> +	/* We cannot lose an interrupt on a non-existent or polled command */
> +	if (!qc || qc->tf.flags & ATA_TFLAG_POLLING)
> +		return;
> +	/* See if the controller thinks it is still busy - if so the command
> +	   isn't a lost IRQ but is still in progress */
> +	status = pata_parport_check_altstatus(ap);
> +	if (status & ATA_BUSY)
> +		return;
> +
> +	/* There was a command running, we are no longer busy and we have
> +	   no interrupt. */
> +	ata_port_warn(ap, "lost interrupt (Status 0x%x)\n", status);
> +	/* Run the host interrupt logic as if the interrupt had not been lost */
> +	ata_sff_port_intr(ap, qc);
> +}

   Hm, it looks like ata_sff_lost_interrupt() could be used instead...

> +
> +static struct ata_port_operations pata_parport_port_ops = {

   Maybe inherit from ata_sff_port_ops? 

[...]
> +static int default_test_proto(struct pi_adapter *pi, char *scratch)
> +{
> +	int j, k;
> +	int e[2] = { 0, 0 };
> +
> +	pi->proto->connect(pi);
> +
> +	for (j = 0; j < 2; j++) {
> +		pi->proto->write_regr(pi, 0, 6, 0xa0 + j * 0x10);
> +		for (k = 0; k < 256; k++) {
> +			pi->proto->write_regr(pi, 0, 2, k ^ 0xaa);
> +			pi->proto->write_regr(pi, 0, 3, k ^ 0x55);
> +			if (pi->proto->read_regr(pi, 0, 2) != (k ^ 0xaa))
> +				e[j]++;
> +		}
> +	}
> +	pi->proto->disconnect(pi);
> +
> +	if (verbose)
> +		dev_info(&pi->dev, "%s: port 0x%x, mode  %d, test=(%d,%d)\n",

   Whyu 2 spaces after "mode"?

> +		       pi->proto->name, pi->port,
> +		       pi->mode, e[0], e[1]);
> +
> +	return (e[0] && e[1]);	/* not here if both > 0 */

   No need for parens.

> +}

   This function kinda duplicates pata_parport_devchk()? :-)

[...]
> +static int pi_probe_mode(struct pi_adapter *pi, int max, char *scratch)
> +{
> +	int best, range;
> +
> +	if (pi->mode != -1) {
> +		if (pi->mode >= max)
> +			return 0;
> +		range = 3;
> +		if (pi->mode >= pi->proto->epp_first)
> +			range = 8;
> +		if ((range == 8) && (pi->port % 8))

   No need for inner parens...

> +			return 0;
> +		return (!pi_test_proto(pi, scratch));

   No need for outer parens, this time... :-)

> +	}
> +	best = -1;
> +	for (pi->mode = 0; pi->mode < max; pi->mode++) {
> +		range = 3;
> +		if (pi->mode >= pi->proto->epp_first)
> +			range = 8;
> +		if ((range == 8) && (pi->port % 8))

   No need for inner parens...

> +			break;
> +		if (!pi_test_proto(pi, scratch))
> +			best = pi->mode;
> +	}
> +	pi->mode = best;
> +	return (best > -1);

   No need for parens...

> +}
> +
> +

   Isn't one empty line enough?

> +static int pi_probe_unit(struct pi_adapter *pi, int unit, char *scratch)

   Looks like it's worth making this function return bool?

[...]
> +static ssize_t new_device_store(struct bus_type *bus, const char *buf, size_t count)
> +{
> +	char port[12] = "auto";
> +	char protocol[8] = "auto";
> +	int mode = -1, unit = -1, delay = -1;
> +	struct pi_protocol *pr, *pr_wanted;
> +	struct device_driver *drv;
> +	struct parport *parport;
> +	int port_num, port_wanted, pr_num;
> +	bool ok = false;
> +
> +	if (sscanf(buf, "%11s %7s %d %d %d",
> +			port, protocol, &mode, &unit, &delay) < 1)
> +		return -EINVAL;
> +
> +	if (sscanf(port, "parport%u", &port_wanted) < 1) {
> +		if (!strcmp(port, "auto"))
> +			port_wanted = -1;
> +		else {

   Need {} on both branches.

> +			pr_err("invalid port name %s\n", port);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	drv = driver_find(protocol, &pata_parport_bus_type);
> +	if (!drv) {
> +		if (!strcmp(protocol, "auto"))
> +			pr_wanted = NULL;
> +		else {

   Same here.

> +			pr_err("protocol %s not found\n", protocol);
> +			return -EINVAL;
> +		}
> +	} else

   And here.

> +		pr_wanted = container_of(drv, struct pi_protocol, driver);
[...]
> +static ssize_t delete_device_store(struct bus_type *bus, const char *buf, size_t count)
> +{
> +	struct device *dev;
> +	char device_name[32];
> +	int fields;
> +
> +	fields = sscanf(buf, "%31s", device_name);
> +	if (fields < 1)

   Strange variable name where you expect only one field... And you don't even
use it after this check, so hardly needed at all...

[...]
> diff --git a/drivers/ata/pata_parport/pata_parport.h b/drivers/ata/pata_parport/pata_parport.h
> new file mode 100644
> index 000000000000..c4201b809b20
> --- /dev/null
> +++ b/drivers/ata/pata_parport/pata_parport.h
> @@ -0,0 +1,110 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + *	paride.h	(c) 1997-8  Grant R. Guenther <grant@torque.net>

   Doesn't match the file name anymore...

> + *				    Under the terms of the GPL.
> + *
> + * This file defines the interface for adapter chip drivers.
> + */
> +
> +#include <linux/libata.h>
> +
> +struct pi_adapter {
> +	struct device dev;
> +	struct pi_protocol *proto;	/* adapter protocol */
> +	int port;			/* base address of parallel port */
> +	int mode;			/* transfer mode in use */
> +	int delay;			/* adapter delay setting */
> +	int unit;			/* unit number for chained adapters */
> +	int saved_r0;			/* saved port state */
> +	int saved_r2;			/* saved port state */
> +	unsigned long private;		/* for protocol module */
> +	struct pardevice *pardev;	/* pointer to pardevice */
> +	int claimed;			/* parport has already been claimed */

   Use bool instead?

> +	struct timer_list timer;	/* disconnect timer */
> +};
> +
> +/* registers are addressed as (cont,regr)
> + *	cont: 0 for command register file, 1 for control register(s)
> + *	regr: 0-7 for register number.
> + */
> +
> +/* macros and functions exported to the protocol modules */
> +#define delay_p			(pi->delay ? udelay(pi->delay) : (void)0)
> +#define out_p(offs, byte)	do { outb(byte, pi->port + offs); delay_p; } while (0)
> +#define in_p(offs)		(delay_p, inb(pi->port + offs))

   Hm, why not pass pi as an extra parameter?

> +
> +#define w0(byte)		out_p(0, byte)
> +#define r0()			(in_p(0) & 0xff)

   Why mask the result of inb()?

> +#define w1(byte)		out_p(1, byte)
> +#define r1()			(in_p(1) & 0xff)
> +#define w2(byte)		out_p(2, byte)
> +#define r2()			(in_p(2) & 0xff)
> +#define w3(byte)		out_p(3, byte)
> +#define w4(byte)		out_p(4, byte)
> +#define r4()			(in_p(4) & 0xff)
> +#define w4w(data)		do { outw(data, pi->port + 4); delay_p; } while (0)
> +#define w4l(data)		do { outl(data, pi->port + 4); delay_p; } while (0)
> +#define r4w()			(delay_p, inw(pi->port + 4) & 0xffff)
> +#define r4l()			(delay_p, inl(pi->port + 4) & 0xffffffff)

   Again, why mask these?

> +
> +static inline u16 pi_swab16(char *b, int k)
> +{
> +	union { u16 u; char t[2]; } r;
> +
> +	r.t[0] = b[2 * k + 1]; r.t[1] = b[2 * k];
> +	return r.u;

   Hm, swab16() instead?

> +}
> +
> +static inline u32 pi_swab32(char *b, int k)
> +{
> +	union { u32 u; char f[4]; } r;
> +
> +	r.f[0] = b[4 * k + 1]; r.f[1] = b[4 * k];
> +	r.f[2] = b[4 * k + 3]; r.f[3] = b[4 * k + 2];
> +	return r.u;

   And swab32() here instead?

> +}
[...]

MNR, Sergey
