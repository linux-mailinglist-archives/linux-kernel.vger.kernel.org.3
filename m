Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74BB5251AC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 17:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356126AbiELPzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 11:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346693AbiELPyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:54:55 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578A3261FB7;
        Thu, 12 May 2022 08:54:54 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id j4so9853076lfh.8;
        Thu, 12 May 2022 08:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=b6dHBzZHYFawdsy4O632nGec+yXs3DOqDdaqitWNAyU=;
        b=kkxIBt25yQVh72J7htbdZ0+boce9c51K7QdvKzM2utgpPgf7/9x/+TUUxbYFuApgmV
         bnUFlpbTxLHE5PTgFQu3NzGbEM10s10dGTDVZrZE/pehXevsuukvK0ZoZLtlWj0AV25A
         B/z29NJoMJQnQv2J0g3LJufoqoVQKFnsmkYLDZ+6DTzkfYxBRAsdizg3WNRKkUVEZZFH
         I9poGIZQiRMDrmFLUTNImgzIxKWndYdzknqq+v4zM2eU1T7ZopgWQbExIB1rOBdXOzTi
         ELzzYMVyZTZbqk9g7924TPfLIO8G5RTiXjXlIxXe5hPjvslnZRfY5LGLYKcScsElF3Fi
         ftYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=b6dHBzZHYFawdsy4O632nGec+yXs3DOqDdaqitWNAyU=;
        b=Hn5O07R3gl8wry1IPUW7zXcVKFe/ayTOG+QX+BZBBhK8wSXqVh1gvXKwNTemEo+smG
         bkdNtDby9kL2OgrEE9Soq0+BU26vEO0oLd05xVbifEgxmOkELQqc8f94O07bpD/j6fm8
         XaMcRJJPYjyP3CmNukw+2jqs4dI8K7+oan8EdZdtnnJUEQ3qV67AN9gkpppuI3WXxcJ0
         Bp9L0vPZwkvNvMCwPT5G38Ne0mn4ejnOHotWLq6Lin/CnMKU2GUG0ifferJ3fYMlYYlE
         Q1C3vZrxGvnlkfrVdFJ4qpvrv3s8CEjb+WcDqSlje331sCqQlQQ2gTO5mGgVr9EaSCME
         0+bw==
X-Gm-Message-State: AOAM533g2pShtKv4l2Zz5ZkUnO0KN0D+O/y0qJuFz8CabvqQ4j21PQXZ
        wMNqyHYqH3YstJQVMSt3k2Y=
X-Google-Smtp-Source: ABdhPJy19GaOobI+L2O4l/zjL1xqEvT28l/K/G2QWXTgolia3s1bRO6/I6n4I54AQ984fHOcR9iUgA==
X-Received: by 2002:ac2:4c51:0:b0:473:ab19:87d9 with SMTP id o17-20020ac24c51000000b00473ab1987d9mr307285lfk.634.1652370891164;
        Thu, 12 May 2022 08:54:51 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id p22-20020a2eba16000000b0024f3d1dae91sm942679lja.25.2022.05.12.08.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 08:54:50 -0700 (PDT)
Date:   Thu, 12 May 2022 18:54:48 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 17/23] ata: ahci: Introduce firmware-specific caps
 initialization
Message-ID: <20220512155448.rcnfhju4zoqyi5el@mobilestation>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-18-Sergey.Semin@baikalelectronics.ru>
 <122e0019-4bee-f469-5e04-a9fbc66f3313@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <122e0019-4bee-f469-5e04-a9fbc66f3313@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 09:05:01AM +0200, Hannes Reinecke wrote:
> On 5/12/22 01:18, Serge Semin wrote:
> > There are systems with no BIOS or comprehensive embedded firmware which
> > could be able to properly initialize the SATA AHCI controller
> > platform-specific capabilities. In that case a good alternative to having
> > a clever bootloader is to create a device tree node with the properties
> > well describing all the AHCI-related platform specifics. All the settings
> > which are normally detected and marked as available in the HBA and its
> > ports capabilities fields [1] could be defined in the platform DTB by
> > means of a set of the dedicated properties. Such approach perfectly fits
> > to the DTB-philosophy - to provide hardware/platform description.
> > 
> > So here we suggest to extend the SATA AHCI device tree bindings with the
> > next set of additional DT boolean properties:
> > 1) hba-sss - Controller supports Staggered Spin-up.
> > 2) hba-smps - Mechanical Presence Switch is support by controller.
> > 3) hba-hpcp - Hot Plug Capable Port.
> > 4) hba-mpsp - Mechanical Presence Switch Attached to Port.
> > 5) hba-cpd - Cold Presence Detection.
> > 6) hba-esp - External SATA Port.
> > 7) hba-fbscp - FIS-based Switching Capable Port.
> > All of these capabilities require to have a corresponding hardware
> > configuration. Thus it's ok to have them defined in DTB.
> > 
> > Even though the driver currently takes into account the state of the ESP
> > and FBSCP flags state only, there is nothing wrong with having all them
> > supported by the generic AHCI library in order to have a complete OF-based
> > platform-capabilities initialization procedure. These properties will be
> > parsed in the ahci_platform_get_resources() method and their values will
> > be stored in the saved_* fields of the ahci_host_priv structure, which in
> > its turn then will be used to restore the H.CAP, H.PI and P#.CMD
> > capability fields on device init and after HBA reset.
> > 
> > Please note this modification concerns the HW-init HBA and its ports flags
> > only, which are by specification [1] are supposed to be initialized by the
> > BIOS/platform firmware/expansion ROM and which are normally declared in
> > the one-time-writable-after-reset register fields. Even though these flags
> > aren't supposed to be cleared after HBA reset some AHCI instances may
> > violate that rule so we still need to perform the fields resetting after
> > each reset. Luckily the corresponding functionality has already been
> > partly implemented in the framework of the ahci_save_initial_config() and
> > ahci_restore_initial_config() methods.
> > 
> > [1] Serial ATA AHCI 1.3.1 Specification, p. 103
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >   drivers/ata/ahci.h             |  1 +
> >   drivers/ata/libahci.c          | 51 ++++++++++++++++++++++++++++------
> >   drivers/ata/libahci_platform.c | 51 ++++++++++++++++++++++++++++++++--
> >   3 files changed, 92 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> > index 8b9826533ae5..0de221055961 100644
> > --- a/drivers/ata/ahci.h
> > +++ b/drivers/ata/ahci.h
> > @@ -337,6 +337,7 @@ struct ahci_host_priv {
> >   	u32			saved_cap;	/* saved initial cap */
> >   	u32			saved_cap2;	/* saved initial cap2 */
> >   	u32			saved_port_map;	/* saved initial port_map */
> > +	u32			saved_port_cap[AHCI_MAX_PORTS]; /* saved port_cap */
> >   	u32 			em_loc; /* enclosure management location */
> >   	u32			em_buf_sz;	/* EM buffer size in byte */
> >   	u32			em_msg_type;	/* EM message type */
> > diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> > index 1ffaa5f5f21a..763ff1058da6 100644
> > --- a/drivers/ata/libahci.c
> > +++ b/drivers/ata/libahci.c
> > @@ -16,6 +16,7 @@
> >    * http://www.intel.com/technology/serialata/pdf/rev1_1.pdf
> >    */
> > +#include <linux/bitops.h>
> >   #include <linux/kernel.h>
> >   #include <linux/gfp.h>
> >   #include <linux/module.h>
> > @@ -443,16 +444,28 @@ static ssize_t ahci_show_em_supported(struct device *dev,
> >   void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
> >   {
> >   	void __iomem *mmio = hpriv->mmio;
> > -	u32 cap, cap2, vers, port_map;
> > +	void __iomem *port_mmio;
> > +	unsigned long port_map;
> 
> Why is this an 'unsigned long' now? I thought we could have only 32 ports?
> 
> > +	u32 cap, cap2, vers;
> >   	int i;
> >   	/* make sure AHCI mode is enabled before accessing CAP */
> >   	ahci_enable_ahci(mmio);
> > -	/* Values prefixed with saved_ are written back to host after
> > -	 * reset.  Values without are used for driver operation.
> > +	/*
> > +	 * Values prefixed with saved_ are written back to the HBA and ports
> > +	 * registers after reset. Values without are used for driver operation.
> > +	 */
> > +
> > +	/*
> > +	 * Override HW-init HBA capability fields with platform-specific values.
> > +	 * The rest of the HBA capabilities are defined with strictly RO flags
> > +	 * and can't be modified in CSR anyway.
> >   	 */
> > -	hpriv->saved_cap = cap = readl(mmio + HOST_CAP);
> > +	cap = readl(mmio + HOST_CAP);
> > +	if (hpriv->saved_cap)
> > +		cap = (cap & ~(HOST_CAP_SSS | HOST_CAP_MPS)) | hpriv->saved_cap;
> > +	hpriv->saved_cap = cap;
> >   	/* CAP2 register is only defined for AHCI 1.2 and later */
> >   	vers = readl(mmio + HOST_VERSION);
> > @@ -519,7 +532,7 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
> >   	/* Override the HBA ports mapping if the platform needs it */
> >   	port_map = readl(mmio + HOST_PORTS_IMPL);
> 

> And we're still using 'readl', so we will only initialize 32 bits ...
> 
> >   	if (hpriv->saved_port_map && port_map != hpriv->saved_port_map) {
> 
> Tsk. And now comparing is to a u32 ...
> 
> Please change it back to be 32 bits.

Your comment made me thinking I was going crazy. =) After getting this
patchset submitted and delivered I've switched to and already finished
several more kernel patches series in another subsystems. So the
AHCI/SATA context has stashed in my subconscious during that time.

Indeed what you are saying seems very much reasonable especially
seeing not changing the variable type causes much less code
alterations. Anyway the reason of having the port_map variable defined
as 'unsigned long' is due to using the for_each_set_bit() macro. It
has find_next_bit() called which expects a pointer to unsigned long
passed. Needless to say that using 'unsigned long' in the port_map
definition is very much required due to that.

-Sergey

> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke		           Kernel Storage Architect
> hare@suse.de			                  +49 911 74053 688
> SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
> HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
