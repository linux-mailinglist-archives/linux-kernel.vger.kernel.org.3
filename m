Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C88531CCF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiEWT1L convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 May 2022 15:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiEWT0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:26:40 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12AE220DE;
        Mon, 23 May 2022 12:06:01 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-30026b1124bso1700397b3.1;
        Mon, 23 May 2022 12:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=BW9FLVAoEz0thUnrwhUY9ppanou9e/CkpaLoGAd8XiE=;
        b=5gcdJxp7Bhxl1u6yHiQB4cMpOpgaF8L+ZHfTXFVBRX9ENiQ7oxv56hP2I8F1ExUs3G
         nCryp4qC/tewBgZk/8JuVipMOVAWCdeyzYTmrJCMDV9PYAffT5inXfcT75F267NRCkds
         V4WsmaDrdcNE/Qzh9DMnePpiLCFA5MeZ2Pceghm6Qp7Q++4WDpJGkosnpUkL9BZA0KIR
         WiJQcm/KSRF+okaqnSFHZ2JDQ4IapeADKviGfbtwvnQcpbZGjmsXw4YEXXED2xsx2KbB
         h72CslRT4L2O+hbjalRanG+0d8a2KV6A+M1j57E81dHiZHEOdOsQAvC3mTeQh+Lksdhf
         DfdA==
X-Gm-Message-State: AOAM533gq3+kK1F3h7DrbP5jZT3bCimnq/y41DZvn4MKkE9SDqGs8VYX
        DxwEkq2Id6T6qdyHkhC9E2gvcu5FQ0HAHMs1B4+jt3N5RPM=
X-Google-Smtp-Source: ABdhPJxKC+dxip9wq70l3pqBAGrteED2khbqAXrm/ieH914+VQ6nIRC2jxTDUNOpl1z8eTGq390SSY54PotZyptS20Q=
X-Received: by 2002:a81:8844:0:b0:2fe:a7de:20c2 with SMTP id
 y65-20020a818844000000b002fea7de20c2mr25248240ywf.515.1653332760945; Mon, 23
 May 2022 12:06:00 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 May 2022 21:05:50 +0200
Message-ID: <CAJZ5v0iMu3BP9bo_pjHmCB=+Y_7yir3pvLvoALR98=6NoE7ZYw@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v5.19-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.19-rc1

with top-most commit 5db9ce20951c8163ee3d505b81d458c83155e311

 Merge branches 'acpi-apei', 'acpi-dptf', 'acpi-x86' and 'acpi-docs'

on top of commit 42226c989789d8da4af1de0c31070c96726d990c

 Linux 5.18-rc7

to receive ACPI updates for 5.19-rc1.

These update the ACPICA kernel code to upstream revision 20220331,
improve handling of PCI devices that are in D3cold during system
initialization, add support for a few features, fix bugs and clean up
code.

Specifics:

 - Update ACPICA code in the kernel to upstream revision 20220331
   including the following changes:

   * Add support for the Windows 11 _OSI string (Mario Limonciello)
   * Add the CFMWS subtable to the CEDT table (Lawrence Hileman).
   * iASL: NHLT: Treat Terminator as specific_config (Piotr Maziarz).
   * iASL: NHLT: Fix parsing undocumented bytes at the end of Endpoint
     Descriptor (Piotr Maziarz).
   * iASL: NHLT: Rename linux specific strucures to device_info (Piotr
     Maziarz).
   * Add new ACPI 6.4 semantics to Load() and LoadTable() (Bob Moore).
   * Clean up double word in comment (Tom Rix).
   * Update copyright notices to the year 2022 (Bob Moore).
   * Remove some tabs and // comments - automated cleanup (Bob Moore).
   * Replace zero-length array with flexible-array member (Gustavo A. R.
     Silva).
   * Interpreter: Add units to time variable names (Paul Menzel).
   * Add support for ARM Performance Monitoring Unit Table (Besar
     Wicaksono).
   * Inform users about ACPI spec violation related to sleep length (Paul
     Menzel).
   * iASL/MADT: Add OEM-defined subtable (Bob Moore).
   * Interpreter: Fix some typo mistakes (Selvarasu Ganesan).
   * Updates for revision E.d of IORT (Shameer Kolothum).
   * Use ACPI_FORMAT_UINT64 for 64-bit output (Bob Moore).

 - Improve debug messages in the ACPI device PM code (Rafael Wysocki).

 - Block ASUS B1400CEAE from suspend to idle by default (Mario
   Limonciello).

 - Improve handling of PCI devices that are in D3cold during system
   initialization (Rafael Wysocki).

 - Fix BERT error region memory mapping (Lorenzo Pieralisi).

 - Add support for NVIDIA 16550-compatible port subtype to the SPCR
   parsing code (Jeff Brasen).

 - Use static for BGRT_SHOW kobj_attribute defines (Tom Rix).

 - Fix missing prototype warning for acpi_agdi_init() (Ilkka Koskinen).

 - Fix missing ERST record ID in the APEI code (Liu Xinpeng).

 - Make APEI error injection to refuse to inject into the zero
   page (Tony Luck).

 - Correct description of INT3407 / INT3532 DPTF attributes in sysfs
   (Sumeet Pawnikar).

 - Add support for high frequency impedance notification to the DPTF
   driver (Sumeet Pawnikar).

 - Make mp_config_acpi_gsi() a void function (Li kunyu).

 - Unify Package () representation for properties in the ACPI device
   properties documentation (Andy Shevchenko).

 - Include UUID in _DSM evaluation warning (Michael Niewöhner).

Thanks!


---------------

Andy Shevchenko (1):
      ACPI: docs: enumeration: Unify Package () for properties (part 2)

Besar Wicaksono (1):
      ACPICA: Add support for ARM Performance Monitoring Unit Table.

Bob Moore (7):
      ACPICA: Add new ACPI 6.4 semantics to the Load() operator
      ACPICA: Add new ACPI 6.4 semantics for LoadTable() operator
      ACPICA: Update copyright notices to the year 2022
      ACPICA: Removed some tabs and // comments
      ACPICA: iASL/MADT: Add OEM-defined subtable
      ACPICA: exsystem.c: Use ACPI_FORMAT_UINT64 for 64-bit output
      ACPICA: Update version to 20220331

Gustavo A. R. Silva (1):
      ACPICA: Headers: Replace zero-length array with flexible-array member

Ilkka Koskinen (1):
      ACPI: AGDI: Fix missing prototype warning for acpi_agdi_init()

Jeff Brasen (1):
      ACPI: SPCR: Add support for NVIDIA 16550-compatible port subtype

Lawrence Hileman (1):
      ACPICA: Add the subtable CFMWS to the CEDT table

Li kunyu (1):
      x86: ACPI: Make mp_config_acpi_gsi() a void function

Liu Xinpeng (1):
      ACPI: APEI: Fix missing ERST record id

Lorenzo Pieralisi (1):
      ACPI: sysfs: Fix BERT error region memory mapping

Mario Limonciello (2):
      ACPICA: Add support for the Windows 11 _OSI string
      ACPI: PM: Block ASUS B1400CEAE from suspend to idle by default

Michael Niewöhner (1):
      ACPI: utils: include UUID in _DSM evaluation warning

Paul Menzel (3):
      ACPICA: executer/exsystem: Add units to time variable names
      ACPICA: executer/exsystem: Inform users about ACPI spec violation
      ACPICA: executer/exsystem: Warn about sleeps greater than 10 ms

Piotr Maziarz (3):
      ACPICA: iASL: NHLT: Treat Terminator as specific_config
      ACPICA: iASL: NHLT: Fix parsing undocumented bytes at the end of
Endpoint Descriptor
      ACPICA: iASL: NHLT: Rename linux specific strucures to device_info

Rafael J. Wysocki (9):
      ACPI: PM: Convert debug message in acpi_device_get_power()
      ACPI: PM: Change pr_fmt() in device_pm.c
      ACPI: PM: Unify debug messages in acpi_device_set_power()
      ACPI: bus: Introduce acpi_dev_for_each_child()
      ACPI: PM: Introduce acpi_dev_power_up_children_with_adr()
      PCI: ACPI: PM: Power up devices in D3cold before scanning them
      ACPI: PM: Always print final debug message in acpi_device_set_power()
      ACPI: bus: Avoid non-ACPI device objects in walks over children
      Revert "ACPICA: executer/exsystem: Warn about sleeps greater than 10 ms"

Selvarasu Ganesan (1):
      ACPICA: executer/exsystem: Fix some typo mistakes

Shameer Kolothum (1):
      ACPICA: IORT: Updates for revision E.d

Sumeet Pawnikar (2):
      ACPI: DPTF: Correct description of INT3407 / INT3532 attributes
      ACPI: DPTF: Add support for high frequency impedance notification

Tom Rix (2):
      ACPICA: Clean up double word in comment
      ACPI: BGRT: use static for BGRT_SHOW kobj_attribute defines

Tony Luck (1):
      ACPI, APEI, EINJ: Refuse to inject into the zero page

---------------

 Documentation/firmware-guide/acpi/enumeration.rst  |   3 +-
 arch/x86/kernel/acpi/boot.c                        |   7 +-
 arch/x86/kernel/cpu/mce/apei.c                     |   8 +-
 drivers/acpi/acpica/acapps.h                       |   4 +-
 drivers/acpi/acpica/accommon.h                     |   2 +-
 drivers/acpi/acpica/acconvert.h                    |   2 +-
 drivers/acpi/acpica/acdebug.h                      |   2 +-
 drivers/acpi/acpica/acdispat.h                     |   2 +-
 drivers/acpi/acpica/acevents.h                     |   2 +-
 drivers/acpi/acpica/acglobal.h                     |   2 +-
 drivers/acpi/acpica/achware.h                      |   2 +-
 drivers/acpi/acpica/acinterp.h                     |   2 +-
 drivers/acpi/acpica/aclocal.h                      |   2 +-
 drivers/acpi/acpica/acmacros.h                     |   2 +-
 drivers/acpi/acpica/acnamesp.h                     |   2 +-
 drivers/acpi/acpica/acobject.h                     |   2 +-
 drivers/acpi/acpica/acopcode.h                     |   2 +-
 drivers/acpi/acpica/acparser.h                     |   2 +-
 drivers/acpi/acpica/acpredef.h                     |   2 +-
 drivers/acpi/acpica/acresrc.h                      |   2 +-
 drivers/acpi/acpica/acstruct.h                     |   2 +-
 drivers/acpi/acpica/actables.h                     |   2 +-
 drivers/acpi/acpica/acutils.h                      |   2 +-
 drivers/acpi/acpica/amlcode.h                      |   2 +-
 drivers/acpi/acpica/amlresrc.h                     |   2 +-
 drivers/acpi/acpica/dbhistry.c                     |   2 +-
 drivers/acpi/acpica/dsargs.c                       |   2 +-
 drivers/acpi/acpica/dscontrol.c                    |   2 +-
 drivers/acpi/acpica/dsdebug.c                      |   2 +-
 drivers/acpi/acpica/dsfield.c                      |   2 +-
 drivers/acpi/acpica/dsinit.c                       |   2 +-
 drivers/acpi/acpica/dsmethod.c                     |   2 +-
 drivers/acpi/acpica/dsobject.c                     |   2 +-
 drivers/acpi/acpica/dsopcode.c                     |   2 +-
 drivers/acpi/acpica/dspkginit.c                    |   2 +-
 drivers/acpi/acpica/dswexec.c                      |   4 +-
 drivers/acpi/acpica/dswload.c                      |   2 +-
 drivers/acpi/acpica/dswload2.c                     |   2 +-
 drivers/acpi/acpica/dswscope.c                     |   2 +-
 drivers/acpi/acpica/dswstate.c                     |   2 +-
 drivers/acpi/acpica/evevent.c                      |   2 +-
 drivers/acpi/acpica/evglock.c                      |   2 +-
 drivers/acpi/acpica/evgpe.c                        |   2 +-
 drivers/acpi/acpica/evgpeblk.c                     |   2 +-
 drivers/acpi/acpica/evgpeinit.c                    |   2 +-
 drivers/acpi/acpica/evgpeutil.c                    |   2 +-
 drivers/acpi/acpica/evhandler.c                    |   2 +-
 drivers/acpi/acpica/evmisc.c                       |   2 +-
 drivers/acpi/acpica/evregion.c                     |   2 +-
 drivers/acpi/acpica/evrgnini.c                     |   2 +-
 drivers/acpi/acpica/evxface.c                      |   2 +-
 drivers/acpi/acpica/evxfevnt.c                     |   2 +-
 drivers/acpi/acpica/evxfgpe.c                      |   2 +-
 drivers/acpi/acpica/evxfregn.c                     |   2 +-
 drivers/acpi/acpica/exconcat.c                     |   2 +-
 drivers/acpi/acpica/exconfig.c                     |  61 ++++---
 drivers/acpi/acpica/exconvrt.c                     |   2 +-
 drivers/acpi/acpica/excreate.c                     |   2 +-
 drivers/acpi/acpica/exdebug.c                      |   2 +-
 drivers/acpi/acpica/exdump.c                       |   2 +-
 drivers/acpi/acpica/exfield.c                      |   2 +-
 drivers/acpi/acpica/exfldio.c                      |   4 +-
 drivers/acpi/acpica/exmisc.c                       |   2 +-
 drivers/acpi/acpica/exmutex.c                      |   2 +-
 drivers/acpi/acpica/exnames.c                      |   2 +-
 drivers/acpi/acpica/exoparg1.c                     |  23 ++-
 drivers/acpi/acpica/exoparg2.c                     |   2 +-
 drivers/acpi/acpica/exoparg3.c                     |   2 +-
 drivers/acpi/acpica/exoparg6.c                     |   2 +-
 drivers/acpi/acpica/exprep.c                       |   2 +-
 drivers/acpi/acpica/exregion.c                     |   2 +-
 drivers/acpi/acpica/exresnte.c                     |   2 +-
 drivers/acpi/acpica/exresolv.c                     |   2 +-
 drivers/acpi/acpica/exresop.c                      |   2 +-
 drivers/acpi/acpica/exserial.c                     |   2 +-
 drivers/acpi/acpica/exstore.c                      |   2 +-
 drivers/acpi/acpica/exstoren.c                     |   2 +-
 drivers/acpi/acpica/exstorob.c                     |   2 +-
 drivers/acpi/acpica/exsystem.c                     |  29 ++--
 drivers/acpi/acpica/extrace.c                      |   2 +-
 drivers/acpi/acpica/exutils.c                      |   2 +-
 drivers/acpi/acpica/hwacpi.c                       |   2 +-
 drivers/acpi/acpica/hwesleep.c                     |   2 +-
 drivers/acpi/acpica/hwgpe.c                        |   2 +-
 drivers/acpi/acpica/hwregs.c                       |   2 +-
 drivers/acpi/acpica/hwsleep.c                      |   2 +-
 drivers/acpi/acpica/hwtimer.c                      |   2 +-
 drivers/acpi/acpica/hwvalid.c                      |   2 +-
 drivers/acpi/acpica/hwxface.c                      |   2 +-
 drivers/acpi/acpica/hwxfsleep.c                    |   2 +-
 drivers/acpi/acpica/nsarguments.c                  |   2 +-
 drivers/acpi/acpica/nsconvert.c                    |   2 +-
 drivers/acpi/acpica/nsdump.c                       |   2 +-
 drivers/acpi/acpica/nsdumpdv.c                     |   2 +-
 drivers/acpi/acpica/nsinit.c                       |   2 +-
 drivers/acpi/acpica/nsload.c                       |   2 +-
 drivers/acpi/acpica/nsparse.c                      |   2 +-
 drivers/acpi/acpica/nspredef.c                     |   2 +-
 drivers/acpi/acpica/nsprepkg.c                     |   2 +-
 drivers/acpi/acpica/nsrepair.c                     |   2 +-
 drivers/acpi/acpica/nsrepair2.c                    |   2 +-
 drivers/acpi/acpica/nsutils.c                      |   2 +-
 drivers/acpi/acpica/nswalk.c                       |   2 +-
 drivers/acpi/acpica/nsxfname.c                     |   2 +-
 drivers/acpi/acpica/psargs.c                       |   2 +-
 drivers/acpi/acpica/psloop.c                       |   2 +-
 drivers/acpi/acpica/psobject.c                     |   2 +-
 drivers/acpi/acpica/psopcode.c                     |   6 +-
 drivers/acpi/acpica/psopinfo.c                     |   2 +-
 drivers/acpi/acpica/psparse.c                      |   2 +-
 drivers/acpi/acpica/psscope.c                      |   2 +-
 drivers/acpi/acpica/pstree.c                       |   2 +-
 drivers/acpi/acpica/psutils.c                      |   2 +-
 drivers/acpi/acpica/pswalk.c                       |   2 +-
 drivers/acpi/acpica/psxface.c                      |   2 +-
 drivers/acpi/acpica/tbdata.c                       |   2 +-
 drivers/acpi/acpica/tbfadt.c                       |   2 +-
 drivers/acpi/acpica/tbfind.c                       |   2 +-
 drivers/acpi/acpica/tbinstal.c                     |   2 +-
 drivers/acpi/acpica/tbprint.c                      |   2 +-
 drivers/acpi/acpica/tbutils.c                      |   2 +-
 drivers/acpi/acpica/tbxface.c                      |   2 +-
 drivers/acpi/acpica/tbxfload.c                     |   2 +-
 drivers/acpi/acpica/tbxfroot.c                     |   2 +-
 drivers/acpi/acpica/utaddress.c                    |   2 +-
 drivers/acpi/acpica/utalloc.c                      |   2 +-
 drivers/acpi/acpica/utascii.c                      |   2 +-
 drivers/acpi/acpica/utbuffer.c                     |   2 +-
 drivers/acpi/acpica/utcache.c                      |   2 +-
 drivers/acpi/acpica/utcopy.c                       |   2 +-
 drivers/acpi/acpica/utdebug.c                      |   2 +-
 drivers/acpi/acpica/utdecode.c                     |   2 +-
 drivers/acpi/acpica/uteval.c                       |   2 +-
 drivers/acpi/acpica/utglobal.c                     |   2 +-
 drivers/acpi/acpica/uthex.c                        |   2 +-
 drivers/acpi/acpica/utids.c                        |   2 +-
 drivers/acpi/acpica/utinit.c                       |   2 +-
 drivers/acpi/acpica/utlock.c                       |   2 +-
 drivers/acpi/acpica/utobject.c                     |   2 +-
 drivers/acpi/acpica/utosi.c                        |   3 +-
 drivers/acpi/acpica/utpredef.c                     |   2 +-
 drivers/acpi/acpica/utprint.c                      |   2 +-
 drivers/acpi/acpica/uttrack.c                      |   2 +-
 drivers/acpi/acpica/utuuid.c                       |   2 +-
 drivers/acpi/acpica/utxface.c                      |   2 +-
 drivers/acpi/acpica/utxfinit.c                     |   2 +-
 drivers/acpi/apei/einj.c                           |   3 +
 drivers/acpi/apei/erst-dbg.c                       |   3 +-
 drivers/acpi/apei/erst.c                           |  77 ++++++++-
 drivers/acpi/arm64/agdi.c                          |   1 +
 drivers/acpi/bgrt.c                                |   2 +-
 drivers/acpi/bus.c                                 |  26 +++
 drivers/acpi/device_pm.c                           |  83 +++++++---
 drivers/acpi/dptf/dptf_power.c                     |   9 +-
 drivers/acpi/pci_root.c                            |   2 +
 drivers/acpi/sleep.c                               |  12 ++
 drivers/acpi/spcr.c                                |   1 +
 drivers/acpi/sysfs.c                               |  25 ++-
 drivers/acpi/utils.c                               |   2 +-
 drivers/pci/pci-acpi.c                             |   3 +
 include/acpi/acbuffer.h                            |   2 +-
 include/acpi/acconfig.h                            |   2 +-
 include/acpi/acexcep.h                             |   2 +-
 include/acpi/acnames.h                             |   2 +-
 include/acpi/acoutput.h                            |   2 +-
 include/acpi/acpi.h                                |   2 +-
 include/acpi/acpi_bus.h                            |   3 +
 include/acpi/acpiosxf.h                            |   2 +-
 include/acpi/acpixf.h                              |   4 +-
 include/acpi/acrestyp.h                            |   2 +-
 include/acpi/actbl.h                               |   2 +-
 include/acpi/actbl1.h                              |  18 ++-
 include/acpi/actbl2.h                              | 175 ++++++++++++++++-----
 include/acpi/actbl3.h                              |   2 +-
 include/acpi/actypes.h                             |  19 +--
 include/acpi/acuuid.h                              |   2 +-
 include/acpi/apei.h                                |   2 +
 include/acpi/platform/acenv.h                      |   2 +-
 include/acpi/platform/acenvex.h                    |   2 +-
 include/acpi/platform/acgcc.h                      |   2 +-
 include/acpi/platform/acgccex.h                    |   2 +-
 include/acpi/platform/acintel.h                    |   2 +-
 include/acpi/platform/aclinux.h                    |   2 +-
 include/acpi/platform/aclinuxex.h                  |   2 +-
 tools/power/acpi/common/cmfsize.c                  |   2 +-
 tools/power/acpi/common/getopt.c                   |   2 +-
 .../acpi/os_specific/service_layers/oslinuxtbl.c   |   2 +-
 .../acpi/os_specific/service_layers/osunixdir.c    |   2 +-
 .../acpi/os_specific/service_layers/osunixmap.c    |   2 +-
 .../acpi/os_specific/service_layers/osunixxf.c     |   2 +-
 tools/power/acpi/tools/acpidump/acpidump.h         |   2 +-
 tools/power/acpi/tools/acpidump/apdump.c           |   2 +-
 tools/power/acpi/tools/acpidump/apfiles.c          |   2 +-
 tools/power/acpi/tools/acpidump/apmain.c           |   2 +-
 194 files changed, 626 insertions(+), 322 deletions(-)
