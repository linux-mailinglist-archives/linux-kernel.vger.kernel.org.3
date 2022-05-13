Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5726752600C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379391AbiEMKXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 06:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379382AbiEMKXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 06:23:00 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C145A15ECE1
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 03:22:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1652437361; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=gy8cg4nRK3QkVWuxPt5FLylQaN67alTsp1s1//B3xv8E7e7JwTElOiJcTE5EqimvYuwkgyENlgR7x/8Qj8+ZCFdH9d/mUo6dgVzRoizQOyrYYF5Ip+y6mCf4YQpxlbQKDUYYFTI238BF2IfqMfXFoS1PboeccczCrNMXGhC6xcg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1652437361; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=R+gLxoOtKPI7qqTGU47IzjFxGges8Y/9fRH40op9p9A=; 
        b=LaQvuR7zQ87GZS8h2upEHmp4+p2XYKsDjf/A14ng+yIgZ9Zb2k7KrZrhWuuQ+coFJIt9SowMG3wPw6o/0DVtjtOTgRuGvBG7jbA2bvYZwYrXjScZ0Y36sioHzgoSzCYk95DreLgWIGAEJ2a9BslJPiVaxWi7zpxdpCvhbLrg2c0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1652437361;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=R+gLxoOtKPI7qqTGU47IzjFxGges8Y/9fRH40op9p9A=;
        b=N/9UhyfhEgcRiwle+U6L3lUGJ0dJUt57yg4WKxAYTiP2IonDCFdLiK6/26LmsIkM
        jSOq4uhMOvGH5Ebk3VzpwJ51Ork2fp8iLle8/QGQYZHYUkh2tkGS0XOLHsTIOJadgxM
        V7CqdEd658mLg1pdFTOaVVrPYt1lasLKXS1IhqGc=
Received: from [10.10.10.3] (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1652437358346705.3569668476114; Fri, 13 May 2022 03:22:38 -0700 (PDT)
Message-ID: <8e5d2f7f-0b48-6317-d1d9-dee6a7c06d3c@arinc9.com>
Date:   Fri, 13 May 2022 13:22:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: linux-next: build warnings after merge of the arm-soc tree
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Olof Johansson <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
References: <20220506085815.5a3cfa83@canb.auug.org.au>
 <20220513172933.5dbf4ffb@canb.auug.org.au>
 <CAK8P3a27bPttwrOBKPwNZ=B1zGZqKV=Js-zWcO7ofnqc=xyHQA@mail.gmail.com>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <CAK8P3a27bPttwrOBKPwNZ=B1zGZqKV=Js-zWcO7ofnqc=xyHQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2022 12:18, Arnd Bergmann wrote:
> On Fri, May 13, 2022 at 9:29 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> On Fri, 6 May 2022 08:58:15 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>>
>>> After merging the arm-soc tree, today's linux-next build (arm
>>> multi_v7_defconfig) produced these warnings:
>>>
>>> arch/arm/boot/dts/bcm953012hr.dts:57.3-33: Warning (reg_format): /nand-controller@18028000/nand@0/partition@0:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
>>> arch/arm/boot/dts/bcm953012hr.dts:62.3-33: Warning (reg_format): /nand-controller@18028000/nand@0/partition@200000:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
>>> arch/arm/boot/dts/bcm953012hr.dts:66.3-33: Warning (reg_format): /nand-controller@18028000/nand@0/partition@600000:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
>>> arch/arm/boot/dts/bcm953012hr.dts:70.3-33: Warning (reg_format): /nand-controller@18028000/nand@0/partition@1000000:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
>>> arch/arm/boot/dts/bcm953012hr.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
>>> arch/arm/boot/dts/bcm953012hr.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
>>> arch/arm/boot/dts/bcm953012hr.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
>>> arch/arm/boot/dts/bcm953012hr.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
>>> arch/arm/boot/dts/bcm953012hr.dts:55.14-59.4: Warning (avoid_default_addr_size): /nand-controller@18028000/nand@0/partition@0: Relying on default #address-cells value
>>> arch/arm/boot/dts/bcm953012hr.dts:55.14-59.4: Warning (avoid_default_addr_size): /nand-controller@18028000/nand@0/partition@0: Relying on default #size-cells value
>>> arch/arm/boot/dts/bcm953012hr.dts:60.19-63.4: Warning (avoid_default_addr_size): /nand-controller@18028000/nand@0/partition@200000: Relying on default #address-cells value
>>> arch/arm/boot/dts/bcm953012hr.dts:60.19-63.4: Warning (avoid_default_addr_size): /nand-controller@18028000/nand@0/partition@200000: Relying on default #size-cells value
>>> arch/arm/boot/dts/bcm953012hr.dts:64.19-67.4: Warning (avoid_default_addr_size): /nand-controller@18028000/nand@0/partition@600000: Relying on default #address-cells value
>>> arch/arm/boot/dts/bcm953012hr.dts:64.19-67.4: Warning (avoid_default_addr_size): /nand-controller@18028000/nand@0/partition@600000: Relying on default #size-cells value
>>> arch/arm/boot/dts/bcm953012hr.dts:68.20-71.4: Warning (avoid_default_addr_size): /nand-controller@18028000/nand@0/partition@1000000: Relying on default #address-cells value
>>> arch/arm/boot/dts/bcm953012hr.dts:68.20-71.4: Warning (avoid_default_addr_size): /nand-controller@18028000/nand@0/partition@1000000: Relying on default #size-cells value
>>>
>>> I don't know what caused this now.
>>
>> I am still getting these warnings.
> 
> Thank you for the reminder, I have now reverted commit 90103611d573 ("ARM: dts:
> BCM5301X: Fix DTC warning for NAND node"), which caused the problem.
> 
> The patch was meant to fix a different warning
> 
> Warning (avoid_unnecessary_addr_size):
> /nand-controller@18028000/nand@0: unnecessary
> #address-cells/#size-cells without "ranges" or child "reg" property
> 
> but I don't see that here, so I don't know if it was actually required.
> 
> Arınç, Rafał, Florian: if the original problem comes back now, please
> send a follow-up patch
> that addresses all the warnings.

I was using an unusual method to compile DTs which produced the warning:

$ cpp -nostdinc -I include -I arch -undef -x assembler-with-cpp 
arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dts processed.dts && 
scripts/dtc/dtc -I dts -O dtb processed.dts -o processed.dtb
arch/arm/boot/dts/bcm5301x-nand-cs0.dtsi:10.18-19.5: Warning 
(avoid_unnecessary_addr_size): /nand-controller@18028000/nand@0: 
unnecessary #address-cells/#size-cells without "ranges" or child "reg" 
property
   also defined at arch/arm/boot/dts/bcm5301x-nand-cs0-bch8.dtsi:13.9-17.3
   also defined at arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dts:249.9-272.3
arch/arm/boot/dts/bcm5301x.dtsi:22.28-45.4: Warning 
(unique_unit_address): /chipcommon-a-bus@18000000: duplicate 
unit-address (also used in node /axi@18000000)
arch/arm/boot/dts/bcm5301x.dtsi:358.22-363.4: Warning 
(unique_unit_address): /mdio@18003000: duplicate unit-address (also used 
in node /mdio-mux@18003000)

Now that I know how to properly compile the dt files, I don't see any 
issues before the fix DTC commit or after the revert:

$ ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make clean dtbs -j$(nproc)
   SYNC    include/config/auto.conf.cmd
   HOSTCC  scripts/basic/fixdep
   HOSTCC  scripts/kconfig/conf.o
   HOSTCC  scripts/kconfig/confdata.o
   HOSTCC  scripts/kconfig/expr.o
   LEX     scripts/kconfig/lexer.lex.c
   YACC    scripts/kconfig/parser.tab.[ch]
   HOSTCC  scripts/kconfig/menu.o
   HOSTCC  scripts/kconfig/preprocess.o
   HOSTCC  scripts/kconfig/symbol.o
   HOSTCC  scripts/kconfig/util.o
   HOSTCC  scripts/kconfig/lexer.lex.o
   HOSTCC  scripts/kconfig/parser.tab.o
   HOSTLD  scripts/kconfig/conf
   HOSTCC  scripts/dtc/dtc.o
   HOSTCC  scripts/dtc/flattree.o
   HOSTCC  scripts/dtc/fstree.o
   HOSTCC  scripts/dtc/data.o
   HOSTCC  scripts/dtc/livetree.o
   HOSTCC  scripts/dtc/treesource.o
   HOSTCC  scripts/dtc/srcpos.o
   HOSTCC  scripts/dtc/checks.o
   HOSTCC  scripts/dtc/util.o
   LEX     scripts/dtc/dtc-lexer.lex.c
   YACC    scripts/dtc/dtc-parser.tab.[ch]
   HOSTCC  scripts/dtc/libfdt/fdt.o
   HOSTCC  scripts/dtc/libfdt/fdt_ro.o
   HOSTCC  scripts/dtc/libfdt/fdt_wip.o
   HOSTCC  scripts/dtc/libfdt/fdt_sw.o
   HOSTCC  scripts/dtc/libfdt/fdt_rw.o
   HOSTCC  scripts/dtc/libfdt/fdt_strerror.o
   HOSTCC  scripts/dtc/libfdt/fdt_empty_tree.o
   HOSTCC  scripts/dtc/libfdt/fdt_addresses.o
   HOSTCC  scripts/dtc/libfdt/fdt_overlay.o
   HOSTCC  scripts/dtc/fdtoverlay.o
   HOSTCC  scripts/dtc/dtc-lexer.lex.o
   HOSTCC  scripts/dtc/dtc-parser.tab.o
   UPD     include/config/kernel.release
   HOSTLD  scripts/dtc/fdtoverlay
   HOSTLD  scripts/dtc/dtc
   DTC     arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb
   DTC     arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb
   DTC     arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb
   DTC     arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb
   DTC     arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb
   DTC     arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb
   DTC     arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb
   DTC     arch/arm/boot/dts/bcm4708-netgear-r6250.dtb
   DTC     arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb
   DTC     arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb
   DTC     arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb
   DTC     arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb
   DTC     arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb
   DTC     arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb
   DTC     arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb
   DTC     arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb
   DTC     arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb
   DTC     arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb
   DTC     arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb
   DTC     arch/arm/boot/dts/bcm4709-netgear-r7000.dtb
   DTC     arch/arm/boot/dts/bcm4709-netgear-r8000.dtb
   DTC     arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb
   DTC     arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb
   DTC     arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb
   DTC     arch/arm/boot/dts/bcm47094-linksys-panamera.dtb
   DTC     arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb
   DTC     arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb
   DTC     arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb
   DTC     arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb
   DTC     arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb
   DTC     arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb
   DTC     arch/arm/boot/dts/bcm47094-netgear-r8500.dtb
   DTC     arch/arm/boot/dts/bcm47094-phicomm-k3.dtb
   DTC     arch/arm/boot/dts/bcm53016-meraki-mr32.dtb
   DTC     arch/arm/boot/dts/bcm94708.dtb
   DTC     arch/arm/boot/dts/bcm94709.dtb
   DTC     arch/arm/boot/dts/bcm953012er.dtb
   DTC     arch/arm/boot/dts/bcm953012hr.dtb
   DTC     arch/arm/boot/dts/bcm953012k.dtb

Sorry for the noise, I'll be more careful in the future.

Arınç
