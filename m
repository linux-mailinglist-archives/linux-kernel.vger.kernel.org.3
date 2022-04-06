Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1974F646C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbiDFP6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237592AbiDFP6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:58:19 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8F63682F1;
        Wed,  6 Apr 2022 06:26:22 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id e189so2347932oia.8;
        Wed, 06 Apr 2022 06:26:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1zwzlI7cDrUzx3niiG9DPxuZXhYhVpti1uJIhGlGfYY=;
        b=BVSJ8J0OM0HgsNezJy9eJIOp66aZeOHqkFqd0EjYfsOwibtO41hrzFWXLs6ytTz7+D
         lYvev3oJunZpL+aIqqev/II4GgGfEsqrUXnh+1G/LaDXRH7VdGRYaiUSYE+mcuWO7Yja
         BUnCrjwXGfFuh7js99qGO+VKi4c6/tFFklBl6hB4b3UdqIIbH1p3VIFSTNRYjAJrDL/6
         j65/6z58KEnWaN6TpMrgA3Y3g15hHWBm9KQLrFLxOAiDOJUdugpuXzuwzUMULm1b9sty
         G33PFaDG/CRqJLXvbBtsLBzmcf4Zn4NQKsMI5//SNHNz76Q8Mmpi3Af2bzQKScTC9FWr
         Nfjw==
X-Gm-Message-State: AOAM530UWtcak+PPu+JRYHdE20EQuKGsYqthspbeaNnHQ7nc3jtWcnaC
        m+GkBD6IQk3lqeFVczydww==
X-Google-Smtp-Source: ABdhPJxRu/8yUMGQBmDRWK9rgvz5VsTpRYrAT/ZBZZqPkpqxXBOa3HIPT9w7lInfRN59KLNvMwy4/A==
X-Received: by 2002:aca:4b50:0:b0:2ef:b47:294a with SMTP id y77-20020aca4b50000000b002ef0b47294amr3479270oia.69.1649251582202;
        Wed, 06 Apr 2022 06:26:22 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:20d6:52b3:6546:933d:31a7:672c])
        by smtp.gmail.com with ESMTPSA id a17-20020a056870b31100b000e1fc4e696esm3454144oao.28.2022.04.06.06.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 06:26:21 -0700 (PDT)
Received: (nullmailer pid 2091366 invoked by uid 1000);
        Wed, 06 Apr 2022 13:04:35 -0000
Date:   Wed, 6 Apr 2022 08:04:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Cc:     Lizhi Hou <lizhi.hou@xilinx.com>,
        Sonal Santan <sonal.santan@xilinx.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 0/3] add fwnode support to reset subsystem
Message-ID: <Yk2P4zgKP8dVYUWm@robh.at.kernel.org>
References: <20220324141237.297207-1-clement.leger@bootlin.com>
 <Ykst0Vb4fk+iALzc@robh.at.kernel.org>
 <20220405092434.6e424ed4@fixe.home>
 <YkxWeMNw9Ba0KjHM@robh.at.kernel.org>
 <20220405175120.23fc6b2a@fixe.home>
 <CAL_JsqLdBcAw1KPnrATHqEngRWkx6moxDODH1xV67EKAufc6_w@mail.gmail.com>
 <CAL_JsqL4xY-k4ZsJDuxX6Wbevv+aNRki4WfeiXg0R-4NkqPC1w@mail.gmail.com>
 <20220406095213.21cf3ffb@fixe.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220406095213.21cf3ffb@fixe.home>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 09:52:13AM +0200, Clément Léger wrote:
> Le Tue, 5 Apr 2022 16:28:02 -0500,
> Rob Herring <robh@kernel.org> a écrit :
> 
> 
> > >
> > > No, the kernel already maintains its own tree of devices. You just
> > > need to use that to generate the tree. That's really not much more
> > > than nodes with a 'reg' property encoding the device and function
> > > numbers.
> > >
> > > We already support matching a PCI device to a DT node. The PCI
> > > subsystem checks if there is a corresponding DT node for each PCI
> > > device created and sets the of_node pointer if there is. For
> > > OpenFirmware systems (PPC), there always is a node. For FDT, we
> > > generally don't have a node unless there are additional
> > > non-discoverable properties. Hikey960 is an example with PCI device
> > > nodes in the DT as it has a soldered down PCIe switch with downstream
> > > devices and non-discoverable properties (e.g. reset GPIO for each
> > > port).  
> > 
> > Here's a quick and dirty implementation creating DT nodes for PCI devices:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git dt/pop-pci-nodes
> 
> Ok, thanks, after looking at the branch, it appears that you expect the
> PCI nodes matching the probed PCI devices should be created by the PCI
> subsystem itself. My previous comment saying that the node would be
> created by the PCI driver itself is then wrong and I understand what
> you meant.

As I said before, the driver could create its node and all the parents. 
I went with the other option partly because I didn't have a particular 
driver. That has the advantage of only creating necessary nodes and 
provides a way to trigger doing so. The issue with it is the timing of 
when the node gets set (after parent devices have probed).

> Then, there is still a bit of magic to do to correctly fill the ranges
> for translation and then the driver "simply" have to load the dtbo and
> apply it with of_overlay_fdt_apply().

The host bridge resource list should have all the information needed.

Rob
