Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C40F4875BC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347134AbiAGKht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:37:49 -0500
Received: from angie.orcam.me.uk ([78.133.224.34]:38658 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346805AbiAGKgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:36:50 -0500
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 02B749200B3; Fri,  7 Jan 2022 11:36:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id F2A7B92009D;
        Fri,  7 Jan 2022 10:36:46 +0000 (GMT)
Date:   Fri, 7 Jan 2022 10:36:46 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
cc:     Douglas Gilbert <dgilbert@interlog.com>,
        Khalid Aziz <khalid@gonehiking.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Nix <nix@esperi.org.uk>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] scsi: Set allocation length to 255 for ATA
 Information VPD page
In-Reply-To: <yq1lezty169.fsf@ca-mkp.ca.oracle.com>
Message-ID: <alpine.DEB.2.21.2201070039040.56863@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2201020010540.56863@angie.orcam.me.uk> <alpine.DEB.2.21.2201020030130.56863@angie.orcam.me.uk> <d9eaa1f8-7abb-645b-d624-5069205c6983@interlog.com> <alpine.DEB.2.21.2201032017290.56863@angie.orcam.me.uk> <yq1tuek347m.fsf@ca-mkp.ca.oracle.com>
 <alpine.DEB.2.21.2201032324230.56863@angie.orcam.me.uk> <yq1tuej1j22.fsf@ca-mkp.ca.oracle.com> <yq1lezty169.fsf@ca-mkp.ca.oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin,

> > Oh, you'll also need a follow-on patch that uses the cached ATA
> > Information VPD page. I'll try to get my full series out today.
> 
> I would really appreciate it if you would be willing give this a whirl:
> 
> 	https://git.kernel.org/mkp/h/5.18/discovery

 I have tried your tree and it does not clobber the HBA anymore, however 
partitions (of the MS-DOS type) are not recognised with any of the disks 
including one holding the root device, so the system fails to mount the 
root filesystem and therefore does not complete booting:

VFS: Cannot open root device "802" or unknown-block(8,2): error -6
Please append a correct "root=" boot option; here are the available partitions:
0800        17921835 sda
 driver: sd
0810        35843686 sdb
 driver: sd
0830          239816 sdd
 driver: sd
0b00         1048575 sr0
 driver: sr
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(8,2)

-- is that expected?

 Here's the relevant part of the boot log:

scsi host0: BusLogic BT-958
scsi 0:0:0:0: Direct-Access     IBM      DDYS-T18350M     SA5A PQ: 0 ANSI: 3
scsi 0:0:1:0: Direct-Access     SEAGATE  ST336607LW       0006 PQ: 0 ANSI: 3
scsi 0:0:4:0: Sequential-Access HP       C5683A           C908 PQ: 0 ANSI: 2
scsi 0:0:5:0: Direct-Access     IOMEGA   ZIP 100          E.08 PQ: 0 ANSI: 2
st: Version 20160209, fixed bufsize 32768, s/g segs 256
st 0:0:4:0: Attached scsi tape st0
st 0:0:4:0: st0: try direct i/o: yes (alignment 4 B)
sd 0:0:0:0: [sda] 35843670 512-byte logical blocks: (18.4 GB/17.1 GiB)
sd 0:0:5:0: [sdc] Media removed, stopped polling
sd 0:0:1:0: [sdb] 71687372 512-byte logical blocks: (36.7 GB/34.2 GiB)
sd 0:0:5:0: [sdc] Attached SCSI removable disk
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:1:0: [sdb] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: cb 00 00 08
sd 0:0:1:0: [sdb] Mode Sense: ab 00 10 08
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sda: detected capacity change from 0 to 35843670
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, supports DPO and FUA
sdb: detected capacity change from 0 to 71687372
sd 0:0:1:0: [sdb] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:1:0: Attached scsi generic sg1 type 0
st 0:0:4:0: Attached scsi generic sg2 type 1
sd 0:0:5:0: Attached scsi generic sg3 type 0

while upon a succesful boot with the upstream kernel (and my patch(es) 
applied) it looks like:

scsi host0: BusLogic BT-958
scsi 0:0:0:0: Direct-Access     IBM      DDYS-T18350M     SA5A PQ: 0 ANSI: 3
scsi 0:0:1:0: Direct-Access     SEAGATE  ST336607LW       0006 PQ: 0 ANSI: 3
scsi 0:0:4:0: Sequential-Access HP       C5683A           C908 PQ: 0 ANSI: 2
scsi 0:0:5:0: Direct-Access     IOMEGA   ZIP 100          E.08 PQ: 0 ANSI: 2
st: Version 20160209, fixed bufsize 32768, s/g segs 256
st 0:0:4:0: Attached scsi tape st0
st 0:0:4:0: st0: try direct i/o: yes (alignment 4 B)
sd 0:0:0:0: [sda] 35843670 512-byte logical blocks: (18.4 GB/17.1 GiB)
sd 0:0:5:0: [sdc] Media removed, stopped polling
sd 0:0:1:0: [sdb] 71687372 512-byte logical blocks: (36.7 GB/34.2 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:1:0: [sdb] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: cb 00 00 08
sd 0:0:1:0: [sdb] Mode Sense: ab 00 10 08
sd 0:0:5:0: [sdc] Attached SCSI removable disk
sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, supports DPO and FUA
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb: sdb1 sdb2
sd 0:0:1:0: [sdb] Attached SCSI disk
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 >
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:1:0: Attached scsi generic sg1 type 0
st 0:0:4:0: Attached scsi generic sg2 type 1
sd 0:0:5:0: Attached scsi generic sg3 type 0

The failure is not specific to this HBA as `hdd' is a PATA device and it 
doesn't get its partitions scanned either.

 There's no significant difference between the two .config files:

--- ../linux-macro/.config
+++ .config
@@ -1,6 +1,6 @@
 #
 # Automatically generated file; DO NOT EDIT.
-# Linux/i386 5.16.0-rc7 Kernel Configuration
+# Linux/i386 5.16.0-rc1 Kernel Configuration
 #
 CONFIG_CC_VERSION_TEXT="i386-linux-gnu-gcc (GCC) 11.0.0 20200919 (experimental)"
 CONFIG_CC_IS_GCC=y
@@ -518,7 +518,6 @@
 CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
 CONFIG_HAVE_EXIT_THREAD=y
 CONFIG_ARCH_MMAP_RND_BITS=8
-CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
 CONFIG_ISA_BUS_API=y
 CONFIG_CLONE_BACKWARDS=y
 CONFIG_OLD_SIGSUSPEND3=y
@@ -1061,7 +1060,6 @@
 # CONFIG_SCSI_MPI3MR is not set
 # CONFIG_SCSI_SMARTPQI is not set
 # CONFIG_SCSI_UFSHCD is not set
-# CONFIG_SCSI_UFS_HWMON is not set
 # CONFIG_SCSI_HPTIOP is not set
 CONFIG_SCSI_BUSLOGIC=y
 # CONFIG_SCSI_FLASHPOINT is not set

 Shall I try anything else?

  Maciej
