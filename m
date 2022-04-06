Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53F04F6479
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbiDFP7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237593AbiDFP6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:58:19 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E28B29F59D;
        Wed,  6 Apr 2022 06:26:20 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id v75so2379113oie.1;
        Wed, 06 Apr 2022 06:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=k4VcmKIOsmyZH5t4kT7Utx6jWPWiKKmJzHkLsoZj38g=;
        b=wTp10f93U+lQqRiQB+AOSDiz9Jmt7oFN2RQxXFB+8HTCxh+CqXwIU5SfK9rwRDYBid
         RTMCMwb7U+LuFeBi2Mdt4Fa5IoDBGcj74+rjrmfKpppn4RwMTTTaPXzRlVj+sdPEFOZM
         9ds4uRYSiDBkDN6+S6HGtuUuthuUqhPCuhlwmvo4GAbbrwBLdxpji2c1bGtqxY3YM/1W
         D+Fb/kPTekqkFU1lVSarY/RdtR8Y096GHX5cM9dvGd/J7flsV686mvuqSgoaLNgKVil4
         As03ZiqpvEE8j6A3Lbctyx5rEgWCkSZEJ4TagStexrYRDJXD+UF8BfHGXraVZfNF/1Uw
         yX4g==
X-Gm-Message-State: AOAM530JBbal4ERm6TQQW2mdICij4xY4zpK2SmnQVH18zpcKB5pVHGe6
        ZJzZUxLuZAg4eOAUZrFcEA==
X-Google-Smtp-Source: ABdhPJyMqacL2zWJjEh9BuZjYIHqBz+gp4gsyY/PVFRALGFqi4v3VPgJOcuD+ZaJwpyFPur+JcO+/w==
X-Received: by 2002:a05:6808:314:b0:2ec:e160:ef24 with SMTP id i20-20020a056808031400b002ece160ef24mr3795946oie.196.1649251579451;
        Wed, 06 Apr 2022 06:26:19 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:20d6:52b3:6546:933d:31a7:672c])
        by smtp.gmail.com with ESMTPSA id k30-20020a056870819e00b000e18ee342c0sm6732792oae.18.2022.04.06.06.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 06:26:19 -0700 (PDT)
Received: (nullmailer pid 2113457 invoked by uid 1000);
        Wed, 06 Apr 2022 13:19:16 -0000
Date:   Wed, 6 Apr 2022 08:19:16 -0500
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
        Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/3] add fwnode support to reset subsystem
Message-ID: <Yk2TVAfPVh9a1tUR@robh.at.kernel.org>
References: <20220324141237.297207-1-clement.leger@bootlin.com>
 <Ykst0Vb4fk+iALzc@robh.at.kernel.org>
 <20220405092434.6e424ed4@fixe.home>
 <YkxWeMNw9Ba0KjHM@robh.at.kernel.org>
 <20220405175120.23fc6b2a@fixe.home>
 <CAL_JsqLdBcAw1KPnrATHqEngRWkx6moxDODH1xV67EKAufc6_w@mail.gmail.com>
 <20220406094019.670a2956@fixe.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220406094019.670a2956@fixe.home>
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

On Wed, Apr 06, 2022 at 09:40:19AM +0200, Clément Léger wrote:
> Le Tue, 5 Apr 2022 12:11:51 -0500,
> Rob Herring <robh@kernel.org> a écrit :
> 
> > On Tue, Apr 5, 2022 at 10:52 AM Clément Léger <clement.leger@bootlin.com> wrote:
> > >
> > > Le Tue, 5 Apr 2022 09:47:20 -0500,
> > > Rob Herring <robh@kernel.org> a écrit :
> > >  
> 
> [...]
> 
> > >
> > > I also tried loading an overlay from a driver on an ACPI based system.
> > > Their patch is (I guess) targeting the specific problem that there is
> > > no base DT when using ACPI. However, Mark Brown feedback was not to
> > > mix OF and ACPI:  
> > 
> > I agree there. I don't think we should use DT bindings in ACPI tables
> > which is already happening. In this case, I think what's described by
> > ACPI and DT must be completely disjoint. I think that's the case here
> > as everything is downstream of the PCIe device.
> 
> Yes, there is no references to the host devices (at least in my case).
> 
> > 
> > > "That seems like it's opening a can of worms that might be best left
> > > closed."
> > >
> > > But I would be interested to know how the Xilinx guys are doing that
> > > on x86/ACPI based system.  
> > 
> > They aren't, yet...
> 
> Ok...
> 
> [...]
> 
> > 
> > 
> > > > I've told the Xilinx folks the same thing, but I would separate this
> > > > into 2 parts. First is just h/w work in a DT based system. Second is
> > > > creating a base tree an overlay can be applied to. The first part should
> > > > be pretty straightforward. We already have PCI bus bindings. The only
> > > > tricky part is getting address translation working from leaf device thru
> > > > the PCI bus to host bus, but support for that should all be in place
> > > > (given we support ISA buses off of PCI bus). The second part will
> > > > require generating PCI DT nodes at runtime. That may be needed for both
> > > > DT and ACPI systems as we don't always describe all the PCI hierarchy
> > > > in DT.  
> > >
> > > But then, if the driver generate the nodes, it will most probably
> > > have to describe the nodes by hardcoding them right ?  
> > 
> > No, the kernel already maintains its own tree of devices. You just
> > need to use that to generate the tree. That's really not much more
> > than nodes with a 'reg' property encoding the device and function
> > numbers.
> 
> Just to clarified a point, my PCI device exposes multiple peripherals
> behind one single PCI function.

Right. I would expect your PCI device DT node to have a 'simple-bus' 
child node with all those peripherals. And maybe there's other nodes 
like fixed-clocks, etc.

> To be sure I understood what you are suggesting, you propose to create
> a DT node from the PCI driver that has been probed dynamically
> matching this same PCI device with a 'reg' property. I also think
> this would requires to generate some 'pci-ranges' to remap the
> downstream devices that are described in the DTBO, finally, load the
> overlay to be apply under this newly created node. Is that right ?

Right. You'll need to take the BAR address(es) for the device and stick 
those into 'ranges' to translate offsets to BAR+offset.

Rob
