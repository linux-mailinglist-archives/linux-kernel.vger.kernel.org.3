Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E644D7834
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 21:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbiCMUjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 16:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiCMUjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 16:39:31 -0400
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A058B3BA5D;
        Sun, 13 Mar 2022 13:38:15 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 1AF2520AA834
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH] pata_parport: add driver (PARIDE replacement)
To:     Ondrej Zary <linux@zary.sk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, <linux-block@vger.kernel.org>,
        <linux-parport@lists.infradead.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220312144415.20010-1-linux@zary.sk>
Organization: Open Mobile Platform
Message-ID: <a8189d8e-03e2-1b6f-3251-8e44e4e5e423@omp.ru>
Date:   Sun, 13 Mar 2022 23:38:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220312144415.20010-1-linux@zary.sk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
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

On 3/12/22 5:44 PM, Ondrej Zary wrote:

> The pata_parport is a libata-based replacement of the old PARIDE
> subsystem - driver for parallel port IDE devices.
> It uses the original paride low-level protocol drivers but does not
> need the high-level drivers (pd, pcd, pf, pt, pg). The IDE devices
> behind parallel port adapters are handled by the ATA layer.
> 
> This will allow paride and its high-level drivers to be removed.
> 
> paride and pata_parport are mutually exclusive because the compiled
> protocol drivers are incompatible.
> 
> Tested with Imation SuperDisk LS-120 and HP C4381A (both use EPAT
> chip).
> 
> Note: EPP-32 mode is buggy in EPAT - and also in all other protocol
> drivers - they don't handle non-multiple-of-4 block transfers
> correctly. This causes problems with LS-120 drive.
> There is also another bug in EPAT: EPP modes don't work unless a 4-bit
> or 8-bit mode is used first (probably some initialization missing?).
> Once the device is initialized, EPP works until power cycle.
> 
> So after device power on, you have to:
> echo "parport0 epat 0" >/sys/bus/pata_parport/new_device
> echo pata_parport.0 >/sys/bus/pata_parport/delete_device
> echo "parport0 epat 4" >/sys/bus/pata_parport/new_device
> (autoprobe will initialize correctly as it tries the slowest modes
> first but you'll get the broken EPP-32 mode)
> 
> Signed-off-by: Ondrej Zary <linux@zary.sk>
[...]
> diff --git a/Documentation/admin-guide/blockdev/paride.rst b/Documentation/admin-guide/blockdev/paride.rst
> index e1ce90af602a..e431a1ef41eb 100644
> --- a/Documentation/admin-guide/blockdev/paride.rst
> +++ b/Documentation/admin-guide/blockdev/paride.rst
[...]
> diff --git a/drivers/ata/pata_parport.c b/drivers/ata/pata_parport.c
> new file mode 100644
> index 000000000000..783764626a27
> --- /dev/null
> +++ b/drivers/ata/pata_parport.c
> @@ -0,0 +1,819 @@
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
> +	/*
> +	 * See if the controller thinks it is still busy - if so the command
> +	 * isn't a lost IRQ but is still in progress
> +	 */
> +	status = pata_parport_check_altstatus(ap);
> +	if (status & ATA_BUSY)
> +		return;
> +
> +	/*
> +	 * There was a command running, we are no longer busy and we have
> +	 * no interrupt.
> +	 */
> +	ata_port_warn(ap, "lost interrupt (Status 0x%x)\n", status);
> +	/* Run the host interrupt logic as if the interrupt had not been lost */
> +	ata_sff_port_intr(ap, qc);
> +}

   As I said, ata_sff_lost_interrupt() could be used instead...

[...]
> +static void pi_remove_one(struct device *dev)
> +{
> +	struct ata_host *host = dev_get_drvdata(dev);
> +	struct pi_adapter *pi = host->private_data;
> +
> +	ata_host_detach(host);
> +	del_timer_sync(&pi->timer);
> +	if (pi->claimed) {
> +		pi->proto->disconnect(pi);
> +		parport_release(pi->pardev);
> +	}

   This duplicates most of pci_disconnect_timer(), worth factoring out?

> +	pi_release(pi);
> +	device_unregister(dev);
> +	ida_free(&pata_parport_bus_dev_ids, dev->id);
> +	/* pata_parport_dev_release will do kfree(pi) */
> +}
[...]
> diff --git a/include/linux/pata_parport.h b/include/linux/pata_parport.h
> new file mode 100644
> index 000000000000..f1ba57bb319c
> --- /dev/null
> +++ b/include/linux/pata_parport.h
> @@ -0,0 +1,108 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + *	pata_parport.h	(c) 1997-8  Grant R. Guenther <grant@torque.net>
> + *				    Under the terms of the GPL.
> + *
> + * This file defines the interface for parallel port IDE adapter chip drivers.
> + */
> +
> +#include <linux/libata.h>
> +
> +#define PI_PCD	1	/* dummy for paride protocol modules */
> +
> +struct pi_adapter {
> +	struct device dev;
> +	struct pi_protocol *proto;	/* adapter protocol */
> +	int port;			/* base address of parallel port */
> +	int mode;			/* transfer mode in use */
> +	int delay;			/* adapter delay setting */
> +	int devtype;			/* dummy for paride protocol modules */
> +	char *device;			/* dummy for paride protocol modules */
> +	int unit;			/* unit number for chained adapters */
> +	int saved_r0;			/* saved port state */
> +	int saved_r2;			/* saved port state */
> +	unsigned long private;		/* for protocol module */
> +	struct pardevice *pardev;	/* pointer to pardevice */
> +	bool claimed;			/* parport has already been claimed */
> +	struct timer_list timer;	/* disconnect timer */
> +};
> +
> +typedef struct pi_adapter PIA;	/* for paride protocol modules */
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
> +
> +#define w0(byte)		out_p(0, byte)
> +#define r0()			(in_p(0) & 0xff)
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
> +

   I still don't think all this masking achieves anything...

> +static inline u16 pi_swab16(char *b, int k)
> +{
> +	union { u16 u; char t[2]; } r;
> +
> +	r.t[0] = b[2 * k + 1]; r.t[1] = b[2 * k];
> +	return r.u;
> +}
> +
> +static inline u32 pi_swab32(char *b, int k)
> +{
> +	union { u32 u; char f[4]; } r;
> +
> +	r.f[0] = b[4 * k + 1]; r.f[1] = b[4 * k];
> +	r.f[2] = b[4 * k + 3]; r.f[3] = b[4 * k + 2];
> +	return r.u;

   Hey, I was serious about swab{16|32}p()! Please don't use home grown byte
swapping...

[...]

MBR, Sergey
