Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E39584A8A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 06:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbiG2ESj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 00:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiG2ES1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 00:18:27 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB9072EF4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 21:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1659068305; x=1690604305;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=31L8L+2HSdaLmVhe3jl0kN3T+O/9UjLVGzzRdZbxZec=;
  b=Sq5zdniK7C2RUYLPOSpWQXBjt8O8Oc2BSAsxBXk+slYQcy1hkjloNBB3
   PUbDU2QGKm9THR68Krv9QLbDMOJsKxCwhpsm64lyce8JmlGV9vZTtSqiy
   9uU0/6r4eXOMlNPBvR3UHEN25VZmOOvXbJQJtt2V43BocwXlO2yYBcxK1
   tpoNEr2r8irWOQ9+zaiTUxNvWcdvP76GBDU1vt8YVu2o8MyTbSpn5h0Ro
   GhS2ePZvZ2U7RW/j+nGg3FOxLWf/AK1S9eNaALv0gwLkC5lLwrvtBIv2l
   5HYN5l6hf5qOr+a7d8bpuVNaDa/jNDfdLog93f7myynFfFJqbzaBKWXGz
   g==;
X-IronPort-AV: E=Sophos;i="5.93,200,1654531200"; 
   d="scan'208";a="212186172"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jul 2022 12:18:23 +0800
IronPort-SDR: WLSFy5udy6jvqV1Tvq+iBuC9fnl//2siUnV8G5XVSrY4nd9zYf8mUYjY7dvFfPHqZe4KwLxxSO
 +fyDNYwXcKKeDPxWhzIK9qA44mBcjZYjzdXidrnuzCMXBEICNvuASqcAxfeFQXdJFpQIn2hqsk
 oG4Gs1FvJ7TNIfdhzq9bZ3HbKopOIkj9jaXA8l/XB87D/xIIqraQjKmqDR7vWQgQ+rBzkRuSPy
 j1iBNHrz9NU1LIONRbBxfVShDvS/Zt2EBQkr0X6NCzpj8JBe0ZUX+3Q91ObvC/XnSomviAE27y
 r2vCVWjmisHnE4MJ0zyBRqX8
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2022 20:34:27 -0700
IronPort-SDR: kQ4UL+sLxKlcz1EjfoxrRMP2gKZpUjL7hY8D1eHhBJdCOzUS3+RWmnsZUyEeWNwP9soUTHkxyJ
 W5XgvUaFDjbtMpfQ+npOdjtggWPAb2B2DuEhOZhqmICNBOj9WR3DaOr+9o4e8QwquXFNrzaOmh
 hIxXpgYF3a0hwhgCEGfrV8no6lgT9I7Dv9tpME/ZPn+dLykPM+ibrR7pWP9N1yFuROShN7hbB1
 4g/gD3EQem4S9vaNzmoG/Y6GBRX/XcaZvijRL1RvhzlbCTQPldE+5MHUlx92OEn1fXHA356/BX
 4RI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2022 21:18:24 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LvDlg20wWz1Rwnl
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 21:18:23 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1659068300; x=1661660301; bh=31L8L+2HSdaLmVhe3jl0kN3T+O/9UjLVGzz
        RdZbxZec=; b=ArAFC7yCoCQygXBMonuSUZnq16RNf4P6GSFuYbMuYLC1avDto0S
        QYbRxrxekuierQGCb/6g0X91xQ9meRzngpYAf1hMMZpawVco/Qbr2AYDH3J/dZQr
        6r+yGPyWMzQO9bigZM6gvfuwuwTYavxa7bEPVf5jX56Pand+m56pomJSW+8JiHuv
        m2wpPdPvVDuTLvdltSnXfRi6dDTe8O2A4vRK/cutaeWO2DU2Ny+0Q1SiCNhiO6sL
        aV6iRZwfSGMslH+N3ymOdC4Qolgm44VfWyYeLsTyY4ePRwWf4wYso+ojL/AN7pHm
        1TevQP7AM6eZNCoxlEjxVkfQ3SVT4Cyxwvg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cN52PCRae9ZR for <linux-kernel@vger.kernel.org>;
        Thu, 28 Jul 2022 21:18:20 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LvDlZ2qrJz1RtVk;
        Thu, 28 Jul 2022 21:18:18 -0700 (PDT)
Message-ID: <fcddb6ba-b1ad-224a-4706-2e53ce5f636a@opensource.wdc.com>
Date:   Fri, 29 Jul 2022 13:18:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RESEND v6 00/23] ata: ahci: Add DWC/Baikal-T1 AHCI SATA
 support
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220728111905.12427-1-Sergey.Semin@baikalelectronics.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220728111905.12427-1-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/22 20:18, Serge Semin wrote:
> The main goal of this patchset was to add Baikal-T1 AHCI SATA specifics
> support into the kernel AHCI subsystem. On the way of doing that we
> figured out that mainly these specifics are actually DWC AHCI SATA
> controller features, but still there were some Baikal-T1 SoC platform
> peculiarities which we had to take into account. So the patchset
> introduces two AHCI SATA controllers support and one AHCI SATA driver
> with a series of preparation, optimization and cleanup patches.
> 
> The series starts used to start with converting the legacy AHCI SATA
> controllers text-based DT-bindings to the DT-schema. But turned out that
> has already been done in kernel v5.17. So instead we suggest to improve
> the bindings usability by splitting up the AHCI DT bindings into two
> schemas: one common AHCI SATA controller yaml-file, which can be reused by
> any AHCI-compatible controller utilizing the kernel AHCI library
> functions, and DT-bindings for the generic AHCI SATA devices indicated by
> the "generic-ahci" compatible string and implemented in the
> ahci_platform.c driver. Note after doing that we had to fix the
> sata-common.yaml file SATA port IDs constraint.
> 
> Then a series of generic preparations-cleanups goes. First of all it
> concerns the device-managed methods usage in the framework of the CSR
> space remapping and the clocks requesting and enabling. Note since the
> clocks handlers are requested and kept in the generic AHCI library it
> seemed a good idea to add an AHCI-platform generic method to find and get
> a particular clock handler from the pool of the requested ones. It was
> used later in the series in the DWC/Baikal-T1-specific code. Secondly we
> suggested to at least sanity check the number of SATA ports DT-sub-nodes
> before using it further.  Thirdly the ports-implemented DT-property
> parsing was moved from the AHCI platform-driver to the AHCI-library so to
> be used by the non-generic AHCI drivers if required (DT-schema is
> accordingly fixed too). Finally due to having the shared-reset control
> support we had to add a new AHCI-resource getter flag -
> AHCI_PLATFORM_RST_TRIGGER, which indicated using a trigger-like reset
> control. For such platforms the controller reset will be performed by
> means of the reset_control_reset() and reset_control_rearm() methods.
> AHCI-library reset functions encapsulating the way the reset procedure is
> performed have been also added.
> 
> After that goes a patches series with the platform-specific
> AHCI-capabilities initialization. The suggested functionality will be
> useful for the platforms with no BIOS, comprehensive bootloader/firmware
> installed. In that case the AHCI-related platform-specifics like drive
> staggered spin-up, mechanical presence switch attached or FIS-based
> switching capability usage, etc will be left uninitialized with no generic
> way to be indicated as available if required. We suggested to use the AHCI
> device tree node and its ports sub-nodes for that. AHCI-platform library
> will be responsible fo the corresponding DT-properties parsing and
> pre-initialization of the internal capability registers cache, which will
> be then flashed back to the corresponding CSR after HBA reset. Thus a
> supposed to be firmware-work will be done by means of the AHCI-library and
> the DT-data. A set of the preparations/cleanups required to be done before
> introducing the feature.  First the DT-properties indicating the
> corresponding capability availability were described in the common AHCI
> DT-binding schema. Second we needed to add the enum items with the AHCI
> Port CMD fields, which hadn't been added so far. Thirdly we suggested to
> discard one of the port-map internal storage (force_port_map) in favor of
> re-using another one (save_port_map) in order to simplify the port-map
> initialization interface a bit by getting rid from a redundant variable.
> Finally after discarding the double AHCI-version read procedure and
> changing the __ahci_port_base() method prototype the platform
> firmware-specific caps initialization functionality was introduced.
> 
> The main part of the series goes afterwards. A dedicated DWC AHCI SATA
> controller driver was introduced together with the corresponding
> DT-binding schema pre-patch. Note the driver built mode is activated
> synchronously with the generic AHCI-platform driver by default so
> automatically to be integrated into the kernel for the DWC AHCI-based
> platforms which relied on activating the generic AHCI SATA controller
> driver. Aside with the generic resources getting and AHCI-host
> initialization, the driver implements the DWC-specific setups. In
> particular it checks whether the platform capabilities activated by the
> firmware (see the functionality described above) are actually supported by
> the controller. It's done by means of the vendor-specific registers. Then
> it makes sure that the embedded 1ms timer interval, which is used for the
> DevSleep and CCC features, is correctly initialized based on the
> application clock rate.  The last but not least the driver provides a way
> to tune the DMA-interface performance up by setting the Tx/Rx transactions
> maximum size up. The required values are specified by means of the
> "snps,tx-ts-max" and snps,rx-ts-max" DT-properties.
> 
> Finally we suggest to extend the DWC AHCI SATA controller driver
> functionality with a way to add the DWC-AHCI-based platform-specific
> quirks. Indeed there are many DWC AHCI-based controllers and just a few of
> them are diverged too much to be handled by a dedicated AHCI-driver. The
> rest of them most likely can work well either with a generic version of
> the driver or require a simple normally platform-specific quirk to get up
> and running. Such platforms can define a platform-data in the DWC AHCI
> driver with a set of the controller-specific flags and initialization
> functions. Those functions will be called at the corresponding stages of
> the device probe/resume/remove procedures so to be performing the platform
> setups/cleanups.
> 
> After the denoted above functionality is added we can finally introduce
> the Baikal-T1 AHCI SATA controller support into the DWC AHCI SATA driver.
> The controller is based on the DWC AHCI SATA IP-core v4.10a and can work
> well with the generic DWC AHCI driver. The only peculiarity of it is
> connected with the SATA Ports reference clock source. It can be supplied
> either from the internal SoC PLL or from the chip pads. Currently we have
> to prefer selecting the signal coming from the pads if the corresponding
> clock source is specified because the link doesn't get stably established
> when the internal clock signal is activated. In addition the platform has
> trigger-based reset signals so the corresponding flag must be passed to
> the generic AHCI-resource getter.
> 
> Link: https://lore.kernel.org/linux-ide/20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v2:
> - Rebase from kernel v5.17 to v5.18-rc3. (@Rob)
> - Rebase onto the already available AHCI DT schema. As a result two more
>   patches have been added. (@Rob)
> - Rename 'syscon' property to 'baikal,bt1-syscon'. (@Rob)
> - Replace min/max constraints of the snps,{tx,rx}-ts-max property with
>   enum [ 1, 2, 4, ..., 1024 ]. (@Rob)
> - Use dlemoal/libata.git git tree for the LIBATA SATA AHCI SYNOPSYS
>   DWC driver (@Damien).
> - Change the local objects prefix from 'dwc_ahci_' to 'ahci_dwc_',
>   from 'bt1_ahci_' to 'ahci_bt1_'. (@Damien)
> - Use LLDD term in place of 'glue-driver'. (@Damien)
> - Convert the ahci_platform_assert_rsts() method to returning int status
>   (@Damien).
> - Drop the else word from the DT child_nodes value checking if-else-if
>   statement (@Damien) and convert the after-else part into the ternary
>   operator-based statement.
> - Convert to checking the error-case first in the devm_clk_bulk_get_all()
>   method invocation. (@Damien)
> - Drop the rc variable initialization in the ahci_platform_get_resources()
>   method. (@Damien)
> - Add comma and replace "channel" with "SATA port" in the reg property
>   description of the sata-common.yaml schema. (@Damien)
> 
> Link: https://lore.kernel.org/lkml/20220503200938.18027-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v3:
> - Replace Jens's email address with Damien's one in the list of the
>   common DT schema maintainers. (@Damien)
> 
> Link: https://lore.kernel.org/linux-ide/20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v4:
> - Drop clocks, clock-names, resets, reset-names and power-domains
>   properties from the AHCI common schema. (@Rob)
> - Make sure the interrupts DT-property can have from 1 to 32 items
>   specified. (@Rob)
> - Decrease the "additionalProperties" property identation in the DW AHCI
>   SATA DT-schema otherwise it's percieved as the node property instead of
>   the key one. (@Rob)
> - Convert the HBA-capabilities boolean properties to the bitfield
>   DT-properties. (@Rob)
> - Create SATA/AHCI-port properties definition hierarchy so the sub-schemas
>   could inherit and extend the ports properties of the super-schema. (@Rob)
> - Drop Baikal-T1 syscon reference and implement the clock signal
>   source in the framework of the clock controller. (@Rob)
> - Refactor the patch
>   [PATCH v3 01/23] dt-bindings: ata: ahci-platform: Drop dma-coherent property declaration
>   to
>   [PATCH v3 01/23] dt-bindings: ata: ahci-platform: Move dma-coherent to sata-common.yaml
>   (@Rob)
> - Add a new patch:
>   [PATCH v4 05/24] dt-bindings: ata: sata-brcm: Apply common AHCI schema
> - Drop the patch:
>   [PATCH v3 05/23] ata: libahci_platform: Explicitly set rc on devres_alloc failure
>   (@Hannes, @Damien)
> - Convert ahci_dwc_plat and ahci_bt1_plat to being statically defined.
>   (@kbot)
> - Rebase onto the kernel v5.18.
> 
> Link: https://lore.kernel.org/linux-ide/20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru/T/
> Changelog v5:
> - Add a comment regarding the PORT_CMD_CAP enum entity purpose. (@Damien)
> - Fix the patchlogs grammer notes. (@Damien)
> - Fix the ahci_platform_find_clk() declaration identations. (@Damien)
> - Replace "?:" operator with the if-else statement in the NoF child-nodes
>   calculation procedure. (@Damien)
> - Simplify the ahci_platform_find_clk() method body by dropping
>   the local poiter to the clk structure. (@Damien)
> - Drop the "default SATA_AHCI_PLATFORM" setting from the AHCI_DWC
>   config. (@Randy)
> - Replace deprecated SIMPLE_DEV_PM_OPS() with the
>   DEFINE_SIMPLE_DEV_PM_OPS() macro usage. (@Damien)
> - Dual-licese the include/dt-bindings/ata/ahci.h file. (@Rob)
> - Fix the "resets" property description: replace "clocks" with "resets".
>   (@Rob)
> - Extend resets/clocks{-names} property definitions. (@Rob)
> - Add DWC AHCI SATA "resets" property min/maxItems constraints. (@Rob)
> - Add names for the basic resets like RxOOB and PM-alive in the
>   generic DWC AHCI SATA DT-schema. (@Rob)
> - Add generic DWC AHCI SATA fallback for "rockchip,rk3568-dwc-ahci"
>   bindings. (@Rob)
> - Due to the change above the DWC AHCI SATA DT-schema has been split up
>   into two parts: common DWC AHCI SATA properties and generic DW AHCI
>   SATA controller DT-schema. (@Rob)
> - Drop generic compatible fallback "snps,dwc-ahci" from Baikal-T1
>   DT-schema. (@Rob)
> - Define SATA-port pattern property to be applicable for two ports
>   only on the Baikal-T1 AHCI SATA node.
> - Drop "|" qualifier from the Baikal-T1 AHCI SATA bindings description
>   property.
> - Rebase onto the kernel 5.19-rcX.
> 
> Link: https://lore.kernel.org/linux-ide/20220713052917.27036-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v6:
> - Just resend.

The build bot generated a warning on V5. You did not fix that ?

Note that this will not go into the 5.20 merge window. Too late for that.
This will be for the following cycle (5.21), so you may need to rebase
once more on 5.20-rc1 or rc2, once I create the for-5.21 branch.

> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-ide@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> 
> Serge Semin (23):
>   dt-bindings: ata: ahci-platform: Move dma-coherent to sata-common.yaml
>   dt-bindings: ata: ahci-platform: Detach common AHCI bindings
>   dt-bindings: ata: ahci-platform: Clarify common AHCI props constraints
>   dt-bindings: ata: sata: Extend number of SATA ports
>   dt-bindings: ata: sata-brcm: Apply common AHCI schema
>   ata: libahci_platform: Convert to using platform devm-ioremap methods
>   ata: libahci_platform: Convert to using devm bulk clocks API
>   ata: libahci_platform: Sanity check the DT child nodes number
>   ata: libahci_platform: Parse ports-implemented property in resources
>     getter
>   ata: libahci_platform: Introduce reset assertion/deassertion methods
>   dt-bindings: ata: ahci: Add platform capability properties
>   ata: libahci: Extend port-cmd flags set with port capabilities
>   ata: libahci: Discard redundant force_port_map parameter
>   ata: libahci: Don't read AHCI version twice in the save-config method
>   ata: ahci: Convert __ahci_port_base to accepting hpriv as arguments
>   ata: ahci: Introduce firmware-specific caps initialization
>   dt-bindings: ata: ahci: Add DWC AHCI SATA controller DT schema
>   ata: libahci_platform: Add function returning a clock-handle by id
>   ata: ahci: Add DWC AHCI SATA controller support
>   dt-bindings: ata: ahci: Add Baikal-T1 AHCI SATA controller DT schema
>   ata: ahci-dwc: Add platform-specific quirks support
>   ata: ahci-dwc: Add Baikal-T1 AHCI SATA interface support
>   MAINTAINERS: Add maintainers for DWC AHCI SATA driver
> 
>  .../devicetree/bindings/ata/ahci-common.yaml  | 123 +++++
>  .../bindings/ata/ahci-platform.yaml           |  92 +---
>  .../bindings/ata/baikal,bt1-ahci.yaml         | 115 ++++
>  .../bindings/ata/brcm,sata-brcm.yaml          |   4 +-
>  .../devicetree/bindings/ata/sata-common.yaml  |  17 +-
>  .../bindings/ata/snps,dwc-ahci-common.yaml    | 102 ++++
>  .../bindings/ata/snps,dwc-ahci.yaml           |  75 +++
>  MAINTAINERS                                   |   9 +
>  drivers/ata/Kconfig                           |  10 +
>  drivers/ata/Makefile                          |   1 +
>  drivers/ata/ahci.c                            |   4 +-
>  drivers/ata/ahci.h                            |  22 +-
>  drivers/ata/ahci_dwc.c                        | 495 ++++++++++++++++++
>  drivers/ata/ahci_mtk.c                        |   2 -
>  drivers/ata/ahci_platform.c                   |   5 -
>  drivers/ata/ahci_st.c                         |   3 -
>  drivers/ata/libahci.c                         |  63 ++-
>  drivers/ata/libahci_platform.c                | 219 ++++++--
>  include/dt-bindings/ata/ahci.h                |  20 +
>  include/linux/ahci_platform.h                 |   8 +-
>  20 files changed, 1220 insertions(+), 169 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ata/ahci-common.yaml
>  create mode 100644 Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
>  create mode 100644 Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
>  create mode 100644 Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
>  create mode 100644 drivers/ata/ahci_dwc.c
>  create mode 100644 include/dt-bindings/ata/ahci.h
> 


-- 
Damien Le Moal
Western Digital Research
