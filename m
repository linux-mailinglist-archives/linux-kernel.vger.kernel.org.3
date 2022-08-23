Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6786859E75F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242894AbiHWQch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244774AbiHWQcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:32:02 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56953A2872;
        Tue, 23 Aug 2022 06:03:50 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 301D761EA192D;
        Tue, 23 Aug 2022 15:03:47 +0200 (CEST)
Message-ID: <03f4ae8c-c918-0499-c70c-50a19a8abd30@molgen.mpg.de>
Date:   Tue, 23 Aug 2022 15:03:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Content-Language: en-US
To:     Clemens Ladisch <clemens@ladisch.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Dell.Client.Kernel@dell.com
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Dell XPS 13 9370: hpet_acpi_add: no address or irqs in _CRS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


On the Dell XPS 13 9370 with Debian sid/unstable Linux 5.18.16 warns 
about missing values in _CRS:

     [    0.000000] DMI: Dell Inc. XPS 13 9370/0RMYH9, BIOS 1.21.0 
07/06/2022

     [    1.868930] calling  hpet_init+0x0/0x76 @ 1
     [    1.869360] hpet_acpi_add: no address or irqs in _CRS
     [    1.869812] initcall hpet_init+0x0/0x76 returned 0 after 876 usecs

All HPET logs:

     $ dmesg | grep -i HPET
     [    0.008467] ACPI: HPET 0x000000003F0E8CD8 000038 (v01 DELL 
CBX3     01072009 AMI. 0005000B)
     [    0.008477] ACPI: HPET 0x000000003F0EA378 000038 (v01 INTEL 
KBL-ULT  00000001 MSFT 0000005F)
     [    0.008539] ACPI: Reserving HPET table memory at [mem 
0x3f0e8cd8-0x3f0e8d0f]
     [    0.008542] ACPI: Reserving HPET table memory at [mem 
0x3f0ea378-0x3f0ea3af]
     [    0.013206] ACPI: HPET id: 0x8086a701 base: 0xfed00000
     [    0.055379] hpet: HPET dysfunctional in PC10. Force disabled.
     [    0.055401] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
     [    0.542049] hpet_acpi_add: no address or irqs in _CRS

I attached the full Linux logs (`dmesg`), and the output of `acpidump` 
to the bug #216402 in the Linux kernel bugtracker [1].

 From the disassembled DSDT:

         Device (HPET)
         {
             Name (_HID, EisaId ("PNP0103") /* HPET System Timer */)  // 
_HID: Hardware ID
             Name (_UID, Zero)  // _UID: Unique ID
             Name (BUF0, ResourceTemplate ()
             {
                 Memory32Fixed (ReadWrite,
                     0xFED00000,         // Address Base
                     0x00000400,         // Address Length
                     _Y34)
             })
             Method (_STA, 0, NotSerialized)  // _STA: Status
             {
                 If (HPTE)
                 {
                     Return (0x0F)
                 }

                 Return (Zero)
             }

             Method (_CRS, 0, Serialized)  // _CRS: Current Resource 
Settings
             {
                 If (HPTE)
                 {
                     CreateDWordField (BUF0, 
\_SB.PCI0.LPCB.HPET._Y34._BAS, HPT0)  // _BAS: Base Address
                     HPT0 = HPTB /* \HPTB */
                 }

                 Return (BUF0) /* \_SB_.PCI0.LPCB.HPET.BUF0 */
             }
         }

Besides adding `hpet=disable` to Linux’ CLI, is there a way to address 
the warning?


Kind regards,

Paul


[1]: https://bugzilla.kernel.org/show_bug.cgi?id=216402
