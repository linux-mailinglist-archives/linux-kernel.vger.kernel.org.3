Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3D34FBAA9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343897AbiDKLRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344023AbiDKLQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:16:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D6D62EF;
        Mon, 11 Apr 2022 04:14:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5FD9B81235;
        Mon, 11 Apr 2022 11:14:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484C5C385A4;
        Mon, 11 Apr 2022 11:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649675650;
        bh=FUDidj+yCQNkWNCiBLcbArSmTaPpfuHtOr8LouhWG+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rSl639lb7udqT6DSX4cnfiDXPgbyFVOHMEgKSq9xuCbR961zFqwwIMBFzVz3U1yuu
         +p0Y/NsgAhPiiKanHNXCl0/pV7uvUQU42qI1Odgwj6YJERQRm7Y+27dHbFzHYkvrb5
         EvyswOgvtitaIJV5gateSBfsZDh00lweKS2RKqCscnapvxbW4mzZY0JXzC8lOn7K60
         A8R6hW9Tzw6DySBe3XqNdC31MN/CuX1PTJVZKmHYZwMJcvaWdQ4NjzlP5/wqzIvTqu
         HHw7UaV4eFJab/ISPsRgjs2jbA3TSrbtKsL9kKOQ0Hu+VQ+IYWwY+Dd8eRtOInHTey
         HMFAF1Y+1VkWw==
Received: by pali.im (Postfix)
        id 22C70807; Mon, 11 Apr 2022 13:14:07 +0200 (CEST)
Date:   Mon, 11 Apr 2022 13:14:07 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] PCI: Add function for parsing
 'slot-power-limit-milliwatt' DT property
Message-ID: <20220411111407.7ycuoldxjvqnkoo4@pali>
References: <20220325093827.4983-4-pali@kernel.org>
 <20220408152750.GA306189@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220408152750.GA306189@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 April 2022 10:27:50 Bjorn Helgaas wrote:
> On Fri, Mar 25, 2022 at 10:38:26AM +0100, Pali Rohár wrote:
> > Add function of_pci_get_slot_power_limit(), which parses the
> > 'slot-power-limit-milliwatt' DT property, returning the value in
> > milliwatts and in format ready for the PCIe Slot Capabilities Register.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > Signed-off-by: Marek Behún <kabel@kernel.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> > Changes in v3:
> > * Set 600 W when DT slot-power-limit-milliwatt > 600 W
> > Changes in v2:
> > * Added support for PCIe 6.0 slot power limit encodings
> > * Round down slot power limit value
> > ---
> >  drivers/pci/of.c  | 64 +++++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/pci/pci.h | 15 +++++++++++
> >  2 files changed, 79 insertions(+)
> > 
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index cb2e8351c2cc..5ebff26edd41 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -633,3 +633,67 @@ int of_pci_get_max_link_speed(struct device_node *node)
> >  	return max_link_speed;
> >  }
> >  EXPORT_SYMBOL_GPL(of_pci_get_max_link_speed);
> > +
> > +/**
> > + * of_pci_get_slot_power_limit - Parses the "slot-power-limit-milliwatt"
> > + *				 property.
> > + *
> > + * @node: device tree node with the slot power limit information
> > + * @slot_power_limit_value: pointer where the value should be stored in PCIe
> > + *			    Slot Capabilities Register format
> > + * @slot_power_limit_scale: pointer where the scale should be stored in PCIe
> > + *			    Slot Capabilities Register format
> > + *
> > + * Returns the slot power limit in milliwatts and if @slot_power_limit_value
> > + * and @slot_power_limit_scale pointers are non-NULL, fills in the value and
> > + * scale in format used by PCIe Slot Capabilities Register.
> > + *
> > + * If the property is not found or is invalid, returns 0.
> > + */
> > +u32 of_pci_get_slot_power_limit(struct device_node *node,
> > +				u8 *slot_power_limit_value,
> > +				u8 *slot_power_limit_scale)
> > +{
> > +	u32 slot_power_limit_mw;
> > +	u8 value, scale;
> > +
> > +	if (of_property_read_u32(node, "slot-power-limit-milliwatt",
> > +				 &slot_power_limit_mw))
> > +		slot_power_limit_mw = 0;
> > +
> > +	/* Calculate Slot Power Limit Value and Slot Power Limit Scale */
> > +	if (slot_power_limit_mw == 0) {
> > +		value = 0x00;
> > +		scale = 0;
> > +	} else if (slot_power_limit_mw <= 255) {
> > +		value = slot_power_limit_mw;
> > +		scale = 3;
> > +	} else if (slot_power_limit_mw <= 255*10) {
> > +		value = slot_power_limit_mw / 10;
> > +		scale = 2;
> > +	} else if (slot_power_limit_mw <= 255*100) {
> > +		value = slot_power_limit_mw / 100;
> > +		scale = 1;
> > +	} else if (slot_power_limit_mw <= 239*1000) {
> > +		value = slot_power_limit_mw / 1000;
> > +		scale = 0;
> > +	} else if (slot_power_limit_mw <= 250*1000) {
> > +		value = 0xF0;
> > +		scale = 0;
> 
> I think the spec is poorly worded here.  PCIe r6.0, sec 7.5.3.9, says:
> 
>   F0h   > 239 W and <= 250 W Slot Power Limit
> 
> I don't think it's meaningful for the spec to include a range here.
> The amount of power the slot can supply has a single maximum.  I
> suspect the *intent* of F0h/00b is that a device in the slot may
> consume up to 250W.
> 
> Your code above would mean that slot_power_limit_mw == 245,000 would
> cause the slot to advertise F0h/00b (250W), which seems wrong.

So for slot_power_limit_mw == 245 W we should set following values?

  slot_power_limit_mw = 239 W
  value = 0xF0
  scale = 0

> I think we should do something like this instead:
> 
>   scale = 0;
>   if (slot_power_limit_mw >= 600*1000) {
>     value = 0xFE;
>     slot_power_limit_mw = 600*1000;
>   } else if (slot_power_limit_mw >= 575*1000) {
>     value = 0xFD;
>     slot_power_limit_mw = 575*1000;
>   } ...

This is already implemented in branch:

  } else if (slot_power_limit_mw <= 600*1000) {
  	value = 0xF0 + (slot_power_limit_mw / 1000 - 250) / 25;
  	scale = 0;

I will just add reducing of final slot_power_limit_mw value.

> I raised an issue with the PCI SIG about this.
> 
> > +	} else if (slot_power_limit_mw <= 600*1000) {
> > +		value = 0xF0 + (slot_power_limit_mw / 1000 - 250) / 25;
> > +		scale = 0;
> > +	} else {
> > +		value = 0xFE;
> > +		scale = 0;
> > +	}
> > +
> > +	if (slot_power_limit_value)
> > +		*slot_power_limit_value = value;
> > +
> > +	if (slot_power_limit_scale)
> > +		*slot_power_limit_scale = scale;
> > +
> > +	return slot_power_limit_mw;
> 
> If the DT tells us 800W is available, we'll store (FEh/00b), which
> means the slot can advertise to a downstream device that 600W is
> available.  I think that's correct, since the current spec doesn't
> provide a way to encode any value larger than 600W.
> 
> But the function still returns 800,000 mW, which means the next patch will
> print:
> 
>   %s: Slot power limit 800.0W
> 
> even though it programs Slot Capabilities to advertise 600W.
> That's why I suggested setting slot_power_limit_mw = 600*1000 above.

Ok, I will update slot_power_limit_mw value in next patch version.

> > +}
> > +EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 3d60cabde1a1..e10cdec6c56e 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -627,6 +627,9 @@ struct device_node;
> >  int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
> >  int of_get_pci_domain_nr(struct device_node *node);
> >  int of_pci_get_max_link_speed(struct device_node *node);
> > +u32 of_pci_get_slot_power_limit(struct device_node *node,
> > +				u8 *slot_power_limit_value,
> > +				u8 *slot_power_limit_scale);
> >  void pci_set_of_node(struct pci_dev *dev);
> >  void pci_release_of_node(struct pci_dev *dev);
> >  void pci_set_bus_of_node(struct pci_bus *bus);
> > @@ -653,6 +656,18 @@ of_pci_get_max_link_speed(struct device_node *node)
> >  	return -EINVAL;
> >  }
> >  
> > +static inline u32
> > +of_pci_get_slot_power_limit(struct device_node *node,
> > +			    u8 *slot_power_limit_value,
> > +			    u8 *slot_power_limit_scale)
> > +{
> > +	if (slot_power_limit_value)
> > +		*slot_power_limit_value = 0;
> > +	if (slot_power_limit_scale)
> > +		*slot_power_limit_scale = 0;
> > +	return 0;
> > +}
> > +
> >  static inline void pci_set_of_node(struct pci_dev *dev) { }
> >  static inline void pci_release_of_node(struct pci_dev *dev) { }
> >  static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
> > -- 
> > 2.20.1
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
