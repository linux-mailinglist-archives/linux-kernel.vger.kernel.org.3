Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D5F48FA3D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 03:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbiAPCFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 21:05:24 -0500
Received: from inbound.memeplex.com ([35.162.238.239]:53876 "EHLO
        relay.memeplex.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234072AbiAPCFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 21:05:23 -0500
Received: from mail.memeplex.com ([35.162.238.239])
        by relay.memeplex.com (Postfix) with ESMTPS id 6B73F4012F
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 02:05:23 +0000 (UTC)
Message-ID: <d6b66503-47c4-0f2b-b718-678976a1a6a6@memeplex.com>
Date:   Sat, 15 Jan 2022 18:05:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
From:   Andrew than <linux_kernel_aathan@memeplex.com>
Subject: Catastrophic data loss in Mac OS X VirtualBox guest running Linux
 ubuntu 5.11.0-41-generic
To:     linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please cc: me on any response, I am not subscribed to LKML

I've posted this issue on the Virtual Box bug reporting site at Oracle, 
but I'm not sure whether it's a VirtualBox only issue.

Would someone please direct me as to how best to pursue this issue with 
the kernel gods? It's not clear to me that the problem is in a storage 
driver because I was also getting soft lockup errors reported prior to 
the data loss.

[1359528.850122] systemd-journald[284]: Failed to write entry (22 items, 739 bytes), ignoring: Read-only file system


(the above dmesg reported error occurs many many times with different 
timestamps of course)

which seems to stem from:

Jan 15 21:35:14 ubuntu CRON[1188952]: (root) CMD (command -v debian-sa1 > /dev/null && debian-sa1 1 1)
Jan 15 21:37:35 ubuntu kernel: [1355482.810724] ata3.00: exception Emask 0x0 SAct 0x8000000 SErr 0x0 action 0x6 frozen
Jan 15 21:37:35 ubuntu kernel: [1355482.810769] ata3.00: failed command: WRITE FPDMA QUEUED
Jan 15 21:37:35 ubuntu kernel: [1355482.810786] ata3.00: cmd 61/10:d8:90:a0:53/00:00:00:00:00/40 tag 27 ncq dma 8192 out
Jan 15 21:37:35 ubuntu kernel: [1355482.810786]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Jan 15 21:37:35 ubuntu kernel: [1355482.810824] ata3.00: status: { DRDY }
Jan 15 21:37:35 ubuntu kernel: [1355482.810839] ata3: hard resetting link
Jan 15 21:37:37 ubuntu kernel: [1355485.044289] ata3: SATA link down (SStatus 1 SControl 300)
Jan 15 21:37:42 ubuntu kernel: [1355490.294132] ata3: hard resetting link
Jan 15 21:37:45 ubuntu kernel: [1355492.509352] ata3: SATA link down (SStatus 1 SControl 300)
Jan 15 21:38:07 ubuntu kernel: [1355497.707142] ata3: hard resetting link



Sorry about the formatting of these ... although looking at this again, 
maybe it *is* an issue with the SATA drivers that affects any system 
that writes to disk??

[483574.483756] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! 
[swapper/1:0] Jan 6 11:36:36 ubuntu kernel: [541789.358312] watchdog: 
BUG: soft lockup - CPU#1 stuck for 23s! [swapper/1:0] Jan 6 13:37:15 
ubuntu kernel: [549027.924906] watchdog: BUG: soft lockup - CPU#1 stuck 
for 21s! [swapper/1:0] Jan 6 13:37:15 ubuntu kernel: 
[549027.925052] do_softirq+0xce/0x281 Jan 6 13:37:15 ubuntu kernel: 
[549027.925059] do_softirq_own_stack+0x3d/0x50 Jan 7 05:12:07 ubuntu 
kernel: [605122.533658] watchdog: BUG: soft lockup - CPU#1 stuck for 
21s! [swapper/1:0]
