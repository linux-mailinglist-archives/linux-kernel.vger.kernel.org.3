Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFFA4CFC2F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241726AbiCGLDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241972AbiCGLCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:02:55 -0500
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FA60BC8D;
        Mon,  7 Mar 2022 02:24:43 -0800 (PST)
Date:   Mon, 7 Mar 2022 11:24:06 +0100
From:   Alexander Dahl <ada@thorsis.com>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Tom Rini <trini@konsulko.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Ricardo Salveti <ricardo@foundries.io>,
        Michal Simek <michal.simek@xilinx.com>,
        Jorge Ramirez-Ortiz <jorge@foundries.io>,
        Sean Anderson <seanga2@gmail.com>, devicetree@vger.kernel.org,
        u-boot@lists.denx.de, linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V2] dt-bindings: nvmem: add U-Boot environment variables
 binding
Message-ID: <YiXdRiM3ZREngl0N@ada-deb-carambola.ifak-system.com>
Mail-Followup-To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh@kernel.org>, Tom Rini <trini@konsulko.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Ricardo Salveti <ricardo@foundries.io>,
        Michal Simek <michal.simek@xilinx.com>,
        Jorge Ramirez-Ortiz <jorge@foundries.io>,
        Sean Anderson <seanga2@gmail.com>, devicetree@vger.kernel.org,
        u-boot@lists.denx.de, linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20220217130235.7450-1-zajec5@gmail.com>
 <YhkHAQclxNHqmBwO@robh.at.kernel.org>
 <96f5a8d3-83db-fa1f-a27c-5c27d7c143e1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96f5a8d3-83db-fa1f-a27c-5c27d7c143e1@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hei hei,

just want to give a little more background here from embedded non
openwrt point of view.  See below.

Am Mon, Feb 28, 2022 at 12:32:11PM +0100 schrieb Rafał Miłecki:
> On 25.02.2022 17:42, Rob Herring wrote:
> > On Thu, Feb 17, 2022 at 02:02:35PM +0100, Rafał Miłecki wrote:
> > > From: Rafał Miłecki <rafal@milecki.pl>
> > > 
> > > U-Boot uses environment variables for storing device setup data. It
> > > usually needs to be accessed by a bootloader, kernel and often
> > > user-space.
> > 
> > How much of this is already in use vs. proposed? I know I've seen
> > something, but that may have been a u-boot env string in 'label' and
> > that's it.
> 
> [bootloader]
> Right now U-Boot doesn't use any binding for describing env variables.
> It's location is usually hardcoded, see (in U-Boot):
> * CONFIG_ENV_ADDR
> * CONFIG_ENV_SECT_SIZE
> * CONFIG_ENV_ADDR_REDUND

And more … U-Boot has a variety of options to store the U-Boot env,
from the top of my head:

- at some offset in raw flash / mtd partition on NAND, NOR, serial dataflash, etc.
- at some offset on a block device, e.g. on eMMC
- as a file in a FAT partition
- in a UBI volume
- …

And yes, it's determined by some build option and hardcoded at compile
time.

> [kernel]
> There is no support for accessing U-Boot env data. This patch is the
> first step for adding such a support.
> 
> [user-space]
> OpenWrt uses bash script to store a list of devices and their U-Boot env
> variables location. In a long term I'd like to replace it and use DT
> info + possibly a kernel exposed NVMEM data.

U-Boot source itself has userspace tools fw_setenv and fw_printenv
and those look into /etc/fw_env.config on how that env should be
accessed.

Greets
Alex

> 
> 
> > > This binding allows describing environment data located in a raw flash
> > > partition. It's treated as NVMEM device and can be reused later for
> > > other storage devices.
> > > 
> > > Using DT should be cleaner than hardcoding & duplicating such info in
> > > multiple places. Bootloader & kernel can share DTS and user-space can
> > > try reading it too or just have correct data exposed by a kernel.
> > > 
> > > A custom "compatible" string allows system to automatically load
> > > relevant NVMEM driver but phandle can be also used for reading raw
> > > location.
> > > 
> > > Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> > > ---
> > > V2: Update descriptions to don't make this binding MTD (flash partition)
> > >      specific. Mention multiple possible storage ways.
> > > ---
> > >   .../devicetree/bindings/nvmem/u-boot,env.yaml | 66 +++++++++++++++++++
> > >   MAINTAINERS                                   |  5 ++
> > >   2 files changed, 71 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> > > new file mode 100644
> > > index 000000000000..a53e34152c97
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> > > @@ -0,0 +1,66 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/nvmem/u-boot,env.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: U-Boot environment variables
> > > +
> > > +description: |
> > > +  U-Boot uses environment variables to store device parameters and
> > > +  configuration. They may be used for booting process, setup or keeping end user
> > > +  info.
> > > +
> > > +  Data is stored using U-Boot specific formats (variant specific header and NUL
> > > +  separated key-value pairs).
> > > +
> > > +  Environment data can be stored on various storage entities, e.g.:
> > > +  1. Raw flash partition
> > > +  2. UBI volume
> > > +
> > > +  This binding allows marking storage device (as containing env data) and
> > > +  specifying used format.
> > > +
> > > +  Right now only flash partition case is covered but it may be extended to e.g.
> > > +  UBI volumes in the future.
> > > +
> > > +maintainers:
> > > +  - Rafał Miłecki <rafal@milecki.pl>
> > > +
> > > +allOf:
> > > +  - $ref: nvmem.yaml#
> > 
> > What exactly is used from nvmem.yaml? Based on the example, nothing.
> 
> Nothing. I thought it's nice for a context. I'll drop it.
> 
> 
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - description: A standalone env data block
> > > +        const: u-boot,env
> > 
> > > +      - description: Two redundant blocks with active one flagged
> > > +        const: u-boot,env-redundant-bool
> > > +      - description: Two redundant blocks with active having higher counter
> > > +        const: u-boot,env-redundant-count
> > 
> > Aren't these 2 discoverable based on a flag or count property?
> 
> U-Boot discovers that based on a type of flash device(s). In redundant
> mode env data can be stored on one or two flash devices.
> 
> U-Boot conditions:
> 
> /* Check flag scheme compatibility */
> if (DEVTYPE(dev_current) == MTD_NORFLASH &&
> 	DEVTYPE(!dev_current) == MTD_NORFLASH) {
> 	environment.flag_scheme = FLAG_BOOLEAN;
> } else if (DEVTYPE(dev_current) == MTD_NANDFLASH &&
> 		DEVTYPE(!dev_current) == MTD_NANDFLASH) {
> 	environment.flag_scheme = FLAG_INCREMENTAL;
> } else if (DEVTYPE(dev_current) == MTD_DATAFLASH &&
> 		DEVTYPE(!dev_current) == MTD_DATAFLASH) {
> 	environment.flag_scheme = FLAG_BOOLEAN;
> } else if (DEVTYPE(dev_current) == MTD_UBIVOLUME &&
> 		DEVTYPE(!dev_current) == MTD_UBIVOLUME) {
> 	environment.flag_scheme = FLAG_INCREMENTAL;
> } else if (DEVTYPE(dev_current) == MTD_ABSENT &&
> 		DEVTYPE(!dev_current) == MTD_ABSENT &&
> 		IS_UBI(dev_current) == IS_UBI(!dev_current)) {
> 	environment.flag_scheme = FLAG_INCREMENTAL;
> } else {
> 	fprintf(stderr, "Incompatible flash types!\n");
> 	ret = -EINVAL;
> 	goto open_cleanup;
> }
> 
> I thought it's better & more flexible to describe format explicitly in
> the DT. That way vendors have more options - they can e.g. start using
> incremental setup on NOR flash devices.
> 
> 
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +unevaluatedProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    partitions {
> > > +        compatible = "fixed-partitions";
> > > +        #address-cells = <1>;
> > > +        #size-cells = <1>;
> > > +
> > > +        partition@0 {
> > > +            reg = <0x0 0x40000>;
> > > +            label = "u-boot";
> > > +            read-only;
> > > +        };
> > > +
> > > +        env: partition@40000 {
> > > +            compatible = "u-boot,env";
> > > +            reg = <0x40000 0x10000>;
> > > +            label = "u-boot-env";
> > > +        };
> > > +    };
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 66aa3a589f6a..55c56ce82856 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -19905,6 +19905,11 @@ W:	http://linuxtv.org
> > >   T:	git git://linuxtv.org/media_tree.git
> > >   F:	drivers/media/pci/tw686x/
> > > +U-BOOT ENVIRONMENT VARIABLES
> > > +M:	Rafał Miłecki <rafal@milecki.pl>
> > > +S:	Maintained
> > > +F:	Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> > > +
> > >   UACCE ACCELERATOR FRAMEWORK
> > >   M:	Zhangfei Gao <zhangfei.gao@linaro.org>
> > >   M:	Zhou Wang <wangzhou1@hisilicon.com>
> > > -- 
> > > 2.34.1
> > > 
> > > 
> 

