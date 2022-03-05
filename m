Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECE34CE6C4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 21:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbiCEUPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 15:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbiCEUPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 15:15:33 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0539FE0F5;
        Sat,  5 Mar 2022 12:14:41 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 9B91E7A01BF;
        Sat,  5 Mar 2022 21:14:39 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] pata_parport: paride replacement
Date:   Sat,  5 Mar 2022 21:13:55 +0100
Message-Id: <20220305201411.501-1-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
this is a RFC patch for the new pata_parport libata driver - a paride
replacement.

Protocol driver registration and device creation was changed since the
second preview - no more protocol numbers or parport I/O addresses.

All parports and all protocol drivers are now probed automatically unless
probe=0 parameter is used. So just "modprobe epat" is enough for a Imation
SuperDisk drive to work.

Manual device creation:
echo auto >/sys/bus/pata_parport/new_device
echo "parport0 epat 4" >/sys/bus/pata_parport/new_device
echo "parport0 auto" >/sys/bus/pata_parport/new_device
echo "auto epat" >/sys/bus/pata_parport/new_device

Deleting devices:
echo pata_parport.0 >/sys/bus/pata_parport/delete_device

Haven't found any sane way to hook pi_connect() and pi_disconnect() to
libata. So pi_connect() is called on every protocol driver access and
pi_disconnect() is called by a timer that's activated after protocol driver
access.

Found that the EPP-32 mode is buggy in EPAT - and also in many (all?) other
protocol drivers - they don't handle non-multiple-of-4 block transfers
correctly. I'll fix that later.

The bpck_connect() in bpck driver seems to need to know if a CD drive is
attached (weird) but it's called before device detection. This probably
cannot be fixed without the HW.

I have only two devices and both have the same EPAT chip, unfortunately:
Imation SupserDisk
HP C4381A (drive was dead, replaced by TOSHIBA CD-ROM XM-6202B)

The both work:
# modprobe epat
[  122.635395] pata_parport: protocol epat registered
[  122.738114] epat pata_parport.0: epat, Shuttle EPAT chip c6 at 0x378, mode 5 (EPP-32), delay 1
[  122.789035] scsi host4: pata_parport-epat
[  122.789226] ata5: PATA max PIO0 port parport0 protocol epat
[  127.831534] ata5: link is slow to respond, please be patient (ready=0)
[  132.811623] ata5: device not ready (errno=-16), forcing hardreset
[  133.015024] ata5.00: ATAPI: TOSHIBA CD-ROM XM-6202B, 1108, max MWDMA2
[  133.023016] scsi 4:0:0:0: CD-ROM            TOSHIBA  CD-ROM XM-6202B  1108 PQ: 0 ANSI: 5
[  133.043817] scsi 4:0:0:0: Attached scsi generic sg1 type 5
[  133.088146] sr 4:0:0:0: [sr0] scsi3-mmc drive: 32x/32x cd/rw xa/form2 cdda tray
[  133.088163] cdrom: Uniform CD-ROM driver Revision: 3.20
[  133.125939] sr 4:0:0:0: Attached scsi CD-ROM sr0
# mount /dev/sr0 /mnt
mount: /mnt: WARNING: source write-protected, mounted read-only.
[  157.922575] ISO 9660 Extensions: Microsoft Joliet Level 3
[  157.991030] ISO 9660 Extensions: RRIP_1991A
# hdparm -t --direct /dev/sr0

/dev/sr0:
 Timing O_DIRECT disk reads:   2 MB in  3.08 seconds = 664.47 kB/sec



# modprobe epat
[  448.160910] pata_parport: protocol epat registered
[  448.267068] epat pata_parport.0: epat, Shuttle EPAT chip c6 at 0x378, mode 5 (EPP-32), delay 1
[  448.301624] scsi host4: pata_parport-epat
[  448.301769] ata6: PATA max PIO0 port parport0 protocol epat
[  448.533850] ata6.00: ATAPI: LS-120 COSM   04              UHD Floppy, 0270M09T, max PIO2
[  448.615500] scsi 4:0:0:0: Direct-Access     MATSHITA LS-120 COSM   04 0270 PQ: 0 ANSI: 5
[  448.651279] sd 4:0:0:0: Attached scsi generic sg1 type 0
[  448.686028] sd 4:0:0:0: [sdb] Media removed, stopped polling
[  448.717879] sd 4:0:0:0: [sdb] Attached SCSI removable disk
[  472.259786] sd 4:0:0:0: [sdb] Read Capacity(16) failed: Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK
[  472.259805] sd 4:0:0:0: [sdb] Sense not available.
[  483.042442] sd 4:0:0:0: [sdb] 246528 512-byte logical blocks: (126 MB/120 MiB)
[  483.158446] sdb: detected capacity change from 0 to 246528
[  483.309771]  sdb:
# hdparm -t --direct /dev/sdb

/dev/sdb:
 Timing O_DIRECT disk reads:   2 MB in 44.19 seconds =  46.35 kB/sec


