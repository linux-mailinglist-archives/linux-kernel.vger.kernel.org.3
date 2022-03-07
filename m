Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939EC4CF9B5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240623AbiCGKIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239529AbiCGJtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:49:51 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F7070CD9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 01:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646646207; x=1678182207;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N2seRYX1hcqgxap/x7LFh0klPrZhZjBDJB9QAYAdZME=;
  b=cDO/JHrujvGSlJNyJrU8/0QVhtExbP+3yGUrxBmTS9PoHdeODQSMUSGg
   UDitdm42hwWqKpIkYruCOseAnlrEDqmqVSlERWZ8rJdpxu+k9uEWfiURW
   oXEDrzSskpdkHEzaXaXvtrFhxVBR+unmVJg3daQoqN8OS6GG7H1LzSY+A
   77BCHT0ZH+tKkGMiL1dSXBw+5fJaBPdOKdvu3EVCC+Gk7675ZMY1Q4Yzz
   585qR0l3zQ9gfcYCWnOpm1czO1FnxMpevBBPkFClyQbjXC0cmmKt9C6o5
   4RpjVT6zOcDhYlRe/v54N4ANuVymflbXvNqykJb81k/p8x6bx9hP2Zibo
   g==;
X-IronPort-AV: E=Sophos;i="5.90,161,1643644800"; 
   d="scan'208";a="298788408"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2022 17:42:52 +0800
IronPort-SDR: ntTyQ6SE9Ew1ziV2OkHW0I/Fv0IJ5AWqWbl4g/3Yhndb7hfn5FrIbEqbyweGVr5lirLpRojSmy
 MPidHGrNGZLA2yGD3vO7OYdXaWcAxi9YeVrTQdJdku4bjnBaB9glhV9mZQwOj+tXXXvxSHhXkS
 S8J7tnt3bY4cmVptFKjbQqC+5veX+6nvWPrKiZ6LQXO5Ez0ghn203lAm6mLwY3B8FrAE1riJJk
 +Rg0QHq4ONantT/0eljMZbsxNutrIql8g0U3PFFo35W4J1X4KOKHPFCe/1AnpwBJI9Rrz4USAZ
 MHFC+ORnoAuBFHQ4ihO8baaI
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 01:14:10 -0800
IronPort-SDR: f99kkXKgmPWqVeJeYgbLTh9483uD1RH4c7zJwQLn8RsrbAg5Ct1tk8Xz+RTZUXeQyH83ou1d0d
 WaP30AtFuWhuWKW8Z0lMOIGPKGl8P8Ufisq/RfExHxIGjjWBTXmcvkuUvtZmimh/F1gk2JmNn5
 dI11GZl3SNeb1n3gFfJd++4QtIBEBq/gWMlVCXvhGYla9aoTAvm2HC4+CLaFuP1ZBjz5bw7NGl
 4DtUg2HB8j4aZO1jQxxX4sJFy9mkeoILZ8NaC36u07IPQFAi9fRz8Eq+C/Vm+e+e7zyffcJkx3
 Vjo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 01:42:53 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KBtmX5J24z1SHwl
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 01:42:52 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646646166; x=1649238167; bh=N2seRYX1hcqgxap/x7LFh0klPrZhZjBDJB9
        QAYAdZME=; b=LO6GTMpWgC/XrJnfpXk+5R2J/K0JpP/B7dxor+JMIBUESGNLQew
        tkO++s8jLgI/g1zXUsOuQQGDPsx9MWCXwL2eCnGnoNtadHutzOYTusSXrmpJyMbE
        fs1sHxJzLySd6ZD7yt7qfDwf6lpgimWSR5UbswlYAKfHOITWYf6zBJ5QrhNzIqim
        TbsyuxsoqsAbhGEq+CFhvQtnDwPGMSzzMQnPSOVVKgzVn5g8MUQloZGKh94rGtt/
        044tZeoZYtarVB0nNsHk+5gZw95U/kq6jkVZHpfP8jirTo7DqrJ2R1E29DzlwCRU
        +0IuTl5rkaLv6US25nikENfDWx5usaq51rw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QIk3TsnPJ-lI for <linux-kernel@vger.kernel.org>;
        Mon,  7 Mar 2022 01:42:46 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KBtmP0drcz1Rvlx;
        Mon,  7 Mar 2022 01:42:44 -0800 (PST)
Message-ID: <b7774aff-d391-5e37-58b5-abe6bc17e7df@opensource.wdc.com>
Date:   Mon, 7 Mar 2022 18:42:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 01/16] pata_parport: add core driver (PARIDE replacement)
Content-Language: en-US
To:     Ondrej Zary <linux@zary.sk>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220305201411.501-1-linux@zary.sk>
 <20220305201411.501-2-linux@zary.sk>
 <2a79b7ac-6648-7855-fcfa-de0800c9a310@opensource.wdc.com>
 <202203070955.05800.linux@zary.sk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <202203070955.05800.linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/22 17:55, Ondrej Zary wrote:
>>> +module_param(probe, bool, 0644);
>>> +MODULE_PARM_DESC(probe, "Enable automatic device probing (0=off, 1=on [default])");
>>> +
>>> +static bool verbose;
>>> +module_param(verbose, bool, 0644);
>>> +MODULE_PARM_DESC(verbose, "Enable verbose messages (0=off [default], 1=on)");
>>
>> Is this really necessary ? pr_debug() and all ata_xxx_debug() functions
>> can be enabled dynamically.
> 
> The verbose messages are for adapter chip detection. That happens before the
> ata host is registered.

Sure. But you can still use pr_debug(). So instead of

if (verbose)
	dev_info();

simply use:

dev_dbg()

And these calls can be enabled with the standard dynamic debug control.

> 
>>> +
>>> +#define DISCONNECT_TIMEOUT	(HZ / 10)
>>> +
>>> +static void pi_connect(struct pi_adapter *pi)
>>> +{
>>> +	del_timer_sync(&pi->timer);
>>> +	if (pi->claimed)
>>> +		return;
>>
>> Nit: I would reverse the condition to avoid the return. Or add a block
>> line to separate the following hunk. Better readability this way, I think.
>>
>>> +	pi->claimed = 1;
>>> +	parport_claim_or_block(pi->pardev);
>>> +	pi->proto->connect(pi);
>>> +}
>>> +
>>> +static void pi_disconnect_later(struct pi_adapter *pi)
>>> +{
>>> +	mod_timer(&pi->timer, jiffies + DISCONNECT_TIMEOUT);
>>> +}
>>
>> Is this really needed ? Not sure it helps in any way. At least the name
>> should be changed to reflect what this does. May be something like
>> pi_start_disconnect_timeout() ?
> 
> Disconnect needs to happen after end of an operation so the parport is freed
> for device(s) (like a printer) connected to pass-through port of a paride
> device. There could be even multiple paride devices chained on one parport.
> 
> Disconnecting immediately at the end of each function does not work
> (probably breaks the protocol?)
> 
> The old high-level drivers (pd, pf...) did connect and disconnect manually
> on each operation (command or data transfer) but it does not seem to be
> possible with libata.

I am not questioning how you handle the disconnect. I was only
commenting that the inline function may not be that usefull and you
could simply directly use the mod_timer() calls directly.

or

rename pi_disconnect_later() to something that better explains what the
function does.

> 
>>> +
>>> +static void pi_disconnect_timer(struct timer_list *t)
>>> +{
>>> +	struct pi_adapter *pi = from_timer(pi, t, timer);
>>> +
>>> +	if (!pi->claimed)
>>> +		return;
>>
>> A blank line here would be nice for readability.
>>
>>> +	pi->proto->disconnect(pi);
>>> +	parport_release(pi->pardev);
>>> +	pi->claimed = 0;
>>> +}
>>> +
>>> +/* functions taken from libata-sff.c and converted from direct port I/O */
>>> +static unsigned int pata_parport_devchk(struct ata_port *ap, unsigned int device)
>>
>> Should this be a bool function ?
> 
> I don't know. It's copied from libata-sff.c
>  
>>> +{
>>> +	struct pi_adapter *pi = ap->host->private_data;
>>> +	u8 nsect, lbal;
>>> +
>>> +	ap->ops->sff_dev_select(ap, device);
>>> +
>>> +	pi_connect(pi);
>>> +	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 0x55);
>>> +	pi->proto->write_regr(pi, 0, ATA_REG_LBAL, 0xaa);
>>> +
>>> +	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 0xaa);
>>> +	pi->proto->write_regr(pi, 0, ATA_REG_LBAL, 0x55);
>>> +
>>> +	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 055);
>>> +	pi->proto->write_regr(pi, 0, ATA_REG_LBAL, 0xaa);
>>> +
>>> +	nsect = pi->proto->read_regr(pi, 0, ATA_REG_NSECT);
>>> +	lbal = pi->proto->read_regr(pi, 0, ATA_REG_LBAL);
>>> +	pi_disconnect_later(pi);
>>> +
>>> +	if ((nsect == 0x55) && (lbal == 0xaa))
>>> +		return 1;	/* we found a device */
>>> +
>>> +	return 0;		/* nothing found */
>>> +}
>>> +
>>> +static int pata_parport_bus_softreset(struct ata_port *ap, unsigned int devmask,
>>> +				      unsigned long deadline)
>>> +{
>>> +	struct pi_adapter *pi = ap->host->private_data;
>>> +
>>> +	pi_connect(pi);
>>> +	/* software reset.  causes dev0 to be selected */
>>> +	pi->proto->write_regr(pi, 1, 6, ap->ctl);
>>> +	udelay(20);	/* FIXME: flush */
>>
>> Then please fix it.
> 
> I don't know what that means. It's copied from libata-sff.c

OK. Will have a look there too.

> 
>>> +	pi->proto->write_regr(pi, 1, 6, ap->ctl | ATA_SRST);
>>> +	udelay(20);	/* FIXME: flush */
>>
>> Here too.
>>
>>> +	pi->proto->write_regr(pi, 1, 6, ap->ctl);
>>> +	ap->last_ctl = ap->ctl;
>>> +	pi_disconnect_later(pi);
>>> +
>>> +	/* wait the port to become ready */
>>> +	return ata_sff_wait_after_reset(&ap->link, devmask, deadline);
>>> +}
>>> +
>>> +static int pata_parport_softreset(struct ata_link *link, unsigned int *classes,
>>> +				  unsigned long deadline)
>>> +{
>>> +	struct ata_port *ap = link->ap;
>>> +	unsigned int slave_possible = ap->flags & ATA_FLAG_SLAVE_POSS;
>>> +	unsigned int devmask = 0;
>>> +	int rc;
>>> +	u8 err;
>>> +
>>> +	/* determine if device 0/1 are present */
>>> +	if (pata_parport_devchk(ap, 0))
>>> +		devmask |= (1 << 0);
>>> +	if (slave_possible && pata_parport_devchk(ap, 1))
>>> +		devmask |= (1 << 1);
>>> +
>>> +	/* select device 0 again */
>>> +	ap->ops->sff_dev_select(ap, 0);
>>> +
>>> +	/* issue bus reset */
>>> +	rc = pata_parport_bus_softreset(ap, devmask, deadline);
>>> +	/* if link is occupied, -ENODEV too is an error */
>>
>> Please merge this comment with the one above. That will make the code
>> more readable (I know this is the style used by many drivers, but let's
>> not repeat the weird style :)).
>>
>>> +	if (rc && (rc != -ENODEV || sata_scr_valid(link))) {
>>> +		ata_link_err(link, "SRST failed (errno=%d)\n", rc);
>>> +		return rc;
>>> +	}
>>> +
>>> +	/* determine by signature whether we have ATA or ATAPI devices */
>>> +	classes[0] = ata_sff_dev_classify(&link->device[0],
>>> +					  devmask & (1 << 0), &err);
>>> +	if (slave_possible && err != 0x81)
>>> +		classes[1] = ata_sff_dev_classify(&link->device[1],
>>> +						  devmask & (1 << 1), &err);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static u8 pata_parport_check_status(struct ata_port *ap)
>>> +{
>>> +	u8 status;
>>> +	struct pi_adapter *pi = ap->host->private_data;
>>> +
>>> +	pi_connect(pi);
>>> +	status = pi->proto->read_regr(pi, 0, ATA_REG_STATUS);
>>> +	pi_disconnect_later(pi);
>>> +
>>> +	return status;
>>> +}
>>> +
>>> +static u8 pata_parport_check_altstatus(struct ata_port *ap)
>>> +{
>>> +	u8 altstatus;
>>> +	struct pi_adapter *pi = ap->host->private_data;
>>> +
>>> +	pi_connect(pi);
>>> +	altstatus = pi->proto->read_regr(pi, 1, 6);
>>> +	pi_disconnect_later(pi);
>>> +
>>> +	return altstatus;
>>> +}
>>> +
>>> +static void pata_parport_dev_select(struct ata_port *ap, unsigned int device)
>>> +{
>>> +	struct pi_adapter *pi = ap->host->private_data;
>>> +	u8 tmp;
>>> +
>>> +	pi_connect(pi);
>>> +	if (device == 0)
>>> +		tmp = ATA_DEVICE_OBS;
>>> +	else
>>> +		tmp = ATA_DEVICE_OBS | ATA_DEV1;
>>> +
>>> +	pi->proto->write_regr(pi, 0, ATA_REG_DEVICE, tmp);
>>> +	pi_disconnect_later(pi);
>>> +	ata_sff_pause(ap);	/* needed; also flushes, for mmio */
>>
>> The comment does not parse... Why is it needed ?
>> And pleasde move the comment above the call, with a blank line
>> separating it from the previous lines.
> 
> I don't know. It's copied from libata-sff.c

Drop the comment then.

> 
>>> +}
>>> +
>>> +static void pata_parport_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
>>> +{
>>> +	struct pi_adapter *pi = ap->host->private_data;
>>> +	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
>>> +
>>> +	pi_connect(pi);
>>> +	if (tf->ctl != ap->last_ctl) {
>>> +		pi->proto->write_regr(pi, 1, 6, tf->ctl);
>>> +		ap->last_ctl = tf->ctl;
>>> +		ata_wait_idle(ap);
>>> +	}
>>> +
>>> +	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
>>> +		pi->proto->write_regr(pi, 0, ATA_REG_FEATURE, tf->hob_feature);
>>> +		pi->proto->write_regr(pi, 0, ATA_REG_NSECT, tf->hob_nsect);
>>> +		pi->proto->write_regr(pi, 0, ATA_REG_LBAL, tf->hob_lbal);
>>> +		pi->proto->write_regr(pi, 0, ATA_REG_LBAM, tf->hob_lbam);
>>> +		pi->proto->write_regr(pi, 0, ATA_REG_LBAH, tf->hob_lbah);
>>> +	}
>>> +
>>> +	if (is_addr) {
>>
>> Move this if above the previous one. Doing so, you can remove the need
>> for is_addr var and simplify the previous if condition.
>>
>> That said, many pata drivers check that flag but it is always set by
>> libata core. So checking it seems useless. Need to dig into this.
> 
> It's copied from libata-sff.c which is almost libata core.

Yes. Saw the same pattern in different drivers. Need to figure out what
is going on here. That flag really seem totally useless. Will check.
Keep the flag use for now, but at least rewrite as suggested to avoid
the need for that is_addr variable.

>>> +	struct timer_list timer;	/* disconnect timer */
>>> +};
>>> +
>>> +/* registers are addressed as (cont,regr)
>>> + *	cont: 0 for command register file, 1 for control register(s)
>>> + *	regr: 0-7 for register number.
>>> + */
>>> +
>>> +/* macros and functions exported to the protocol modules */
>>> +#define delay_p			(pi->delay ? udelay(pi->delay) : (void)0)
>>> +#define out_p(offs, byte)	do { outb(byte, pi->port + offs); delay_p; } while (0)
>>> +#define in_p(offs)		(delay_p, inb(pi->port + offs))
>>> +
>>> +#define w0(byte)		out_p(0, byte)
>>> +#define r0()			(in_p(0) & 0xff)
>>> +#define w1(byte)		out_p(1, byte)
>>> +#define r1()			(in_p(1) & 0xff)
>>> +#define w2(byte)		out_p(2, byte)
>>> +#define r2()			(in_p(2) & 0xff)
>>> +#define w3(byte)		out_p(3, byte)
>>> +#define w4(byte)		out_p(4, byte)
>>> +#define r4()			(in_p(4) & 0xff)
>>> +#define w4w(data)		do { outw(data, pi->port + 4); delay_p; } while (0)
>>> +#define w4l(data)		do { outl(data, pi->port + 4); delay_p; } while (0)
>>> +#define r4w()			(delay_p, inw(pi->port + 4) & 0xffff)
>>> +#define r4l()			(delay_p, inl(pi->port + 4) & 0xffffffff)
>>
>> Why not align this with the others ?
> 
> It's aligned properly in the file, only looks bad in a diff.
> 

OK.

>>> +
>>> +/**
>>> + * module_pata_parport_driver() - Helper macro for registering a pata_parport driver
>>> + * @__pi_protocol: pi_protocol struct
>>> + *
>>> + * Helper macro for pata_parport drivers which do not do anything special in module
>>> + * init/exit. This eliminates a lot of boilerplate. Each module may only
>>> + * use this macro once, and calling it replaces module_init() and module_exit()
>>> + */
>>> +#define module_pata_parport_driver(__pi_protocol) \
>>> +	module_driver(__pi_protocol, pata_parport_register_driver, pata_parport_unregister_driver)
>>
>> Make this a static inline ?
> 
> It's a macro that expands to other macro (defined in include/linux/device/driver.h)
> that expands to __init and __exit functions, module_init() and
> module_exit() so we can use:
> 
> module_pata_parport_driver(on26);
> 
> instead of:
> 
> static int __init on26_init(void)
> {
> 	return pata_parport_register_driver(&on26);
> }
> 
> static void __exit on26_exit(void)
> {
> 	pata_parport_unregister_driver(&on26);
> }
> 
> module_init(on26_init)
> module_exit(on26_exit)

OK.


-- 
Damien Le Moal
Western Digital Research
