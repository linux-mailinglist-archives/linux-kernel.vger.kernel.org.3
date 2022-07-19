Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13855790C0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbiGSCTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236906AbiGSCTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:19:14 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F37F3C8F0;
        Mon, 18 Jul 2022 19:19:13 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IKl2Vj029315;
        Mon, 18 Jul 2022 18:26:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=date : message-id :
 from : subject : to : cc; s=pfptdkimsnps;
 bh=COPTPm3EMr8WRZHUlyc4tgVtypE3DwFmFDD1gdpWOFI=;
 b=YHMX8ewuH0HIlAnsCFSgPhr1f0T2pn6TIQPajv3TNXnpLqjLkrdfrWOHWWNIGM4NzD0Z
 q8KQfMDD/z1crz7mRqakm6nkpntbvnNVln5wYN40Pg6qNp0tUTVkDWWW68TtSBdFUrvs
 F8nQ3R1dmLBiQM2P/MAN2x6tApMqxmOeHs6kx8QbHqbQbsSAR5kZ7PEpo/V95pClEH5g
 IiGHkOVBgX4Ew0M04LdgJC21K9FIV48iCHnS5uJVOImEcFHGYBnzBseWwfmlcRJhkl3v
 w9HBbuPXlOtUdFqVNiBDEoFeijRi1xWVp6RahiBiEFzcn+LgAurz0xE3iMqXRnV2nrdu UQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3hc6dec5dh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 18:26:09 -0700
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D26C3C0649;
        Tue, 19 Jul 2022 01:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658193968; bh=sN2bY+Y8yu4N8TOkVjs7wvM69O71lZE1IA+24DnsDXs=;
        h=Date:From:Subject:To:Cc:From;
        b=giykU5fp4GTrrGDkDhKKTftA1/IIgJndUsSpMA/v/XxHjAZutqMBSSaB7UumXWDaq
         Xn3l9py/kM8mOm2ckyGE9QRLX2TUVVGEFPJ6xrUOuj7e5UoJo99ZSFXtrfZmbfjutS
         1/hLtFCa04F+tkNgVykepJ/0GYbBfNLHFwR+f7zxAC5Yd+JIMbKGWBx4LsDlhp62de
         soF5CKkQTF5scrdrboUwhXXm5jxA9vCuhTdka6njc9xAuHuZfr5mIGDVZ4+0A0fNkj
         2K8Gh7TzomVrgGcQbO7AJ1ZThUugoy2utFkjOKjvVMdukxmmePhgo+llNyv51II68w
         EAnIDYr6fZq9g==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 2D22DA0096;
        Tue, 19 Jul 2022 01:26:01 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Mon, 18 Jul 2022 18:26:01 -0700
Date:   Mon, 18 Jul 2022 18:26:01 -0700
Message-Id: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v2 00/25] usb: gadget: f_tcm: Enhance UASP driver
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Dmitry Bogdanov <d.bogdanov@yadro.com>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     John Youn <John.Youn@synopsys.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Christoph Hellwig <hch@lst.de>
X-Proofpoint-ORIG-GUID: JoWuj9HIzBybo8AlX2Huicef-EyxlM-f
X-Proofpoint-GUID: JoWuj9HIzBybo8AlX2Huicef-EyxlM-f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=271 clxscore=1011 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207190004
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux UASP gadget driver is incomplete and remained broken for a long time.
It was not implemented for performance either. This series adds some of the
required features for the UASP driver to work. It also makes some changes to
the target core.

This is tested against UASP CV and DWC_usb3x controller. It still needs some
fixes in the target core, which will be separated from this series.

There are still more room for performance improvement and fixes. However, this
series should be sufficient to bring up a working UASP device.


Changes in v2:
 - Remove most target core changes from this series and only keep the must-have
   ones
 - Split the task-management patch to smaller patches
 - Don't send failure Task Management response to target core, reducing
   dependency
 - Add UASP bringup script example in cover page
 - Make various small updates according to feedbacks


Example script
==============
To test UASP, here's an example perl script snippet to bring it up.

Note: the script was cut down and quickly rewritten, so sorry if I make
mistakes. :)

    my $MY_UAS_VID = xxxx;
    my $MY_UAS_PID = yyyy;
    my $SERIAL = "1234";
    my $VENDOR = "VENDOR";
    my $MY_VER = "VER";

    my $vendor_id = "my_vid";
    my $product_id = "my_pid";
    my $revision = "my_rev";

    # Must update:
    my $backing_storage = "/tmp/some_file";
    my $backing_storage_size = 1024*1024*16;
    my $use_ramdisk = 0;

    my $g = "/sys/kernel/config/usb_gadget/g1";

    system("modprobe libcomposite");
    system("modprobe usb_f_tcm");
    system("mkdir -p $g");
    system("mkdir -p $g/configs/c.1");
    system("mkdir -p $g/functions/tcm.0");
    system("mkdir -p $g/strings/0x409");
    system("mkdir -p $g/configs/c.1/strings/0x409");

    my $tp = "/sys/kernel/config/target/usb_gadget/naa.0/tpgt_1";

    my $tf;
    my $ctrl;

    if ($use_ramdisk) {
        $tf = "/sys/kernel/config/target/core/rd_mcp_0/ramdisk";
        $ctrl = 'rd_pages=524288';
    } else {
        $tf = "/sys/kernel/config/target/core/fileio_0/fileio";
        $ctrl = 'fd_dev_name=$backing_storage,fd_dev_size=$backing_storage_size,fd_async_io=1';
    }

    system("mkdir -p /etc/target");

    system("mkdir -p $tp");
    system("mkdir -p $tf");
    system("mkdir -p $tp/lun/lun_0");

    system("echo naa.0         > $tp/nexus");
    system("echo $ctrl         > $tf/control");
    system("echo 1             > $tf/attrib/emulate_ua_intlck_ctrl");
    system("echo 123           > $tf/wwn/vpd_unit_serial");
    system("echo $vendor_id    > $tf/wwn/vendor_id");
    system("echo $product_id   > $tf/wwn/product_id");
    system("echo $revision     > $tf/wwn/revision");
    system("echo 1             > $tf/enable");

    system("ln -s $tf $tp/lun/lun_0/virtual_scsi_port");
    system("echo 1             > $tp/enable");

    system("echo $MY_UAS_PID   > $g/idProduct");

    system("ln -s $g/functions/tcm.0 $g/configs/c.1");

    system("echo $MY_UAS_VID   > $g/idVendor");
    system("echo $SERIAL       > $g/strings/0x409/serialnumber");
    system("echo $VENDOR       > $g/strings/0x409/manufacturer");
    system("echo \"$MY_VER\"   > $g/strings/0x409/product");
    system("echo \"Conf 1\"    > $g/configs/c.1/strings/0x409/configuration");

    system("echo super-speed-plus > $g/max_speed");

    # Make sure the UDC is available
    system("echo $my_udc       > $g/UDC");


Thinh Nguyen (25):
  target: Add overlapped response to tmrsp_table
  target: Add common TMR enum
  usb: gadget: f_tcm: Increase stream count
  usb: gadget: f_tcm: Increase bMaxBurst
  usb: gadget: f_tcm: Don't set static stream_id
  usb: gadget: f_tcm: Allocate matching number of commands to streams
  usb: gadget: f_tcm: Limit number of sessions
  usb: gadget: f_tcm: Handle multiple commands in parallel
  usb: gadget: f_tcm: Use extra number of commands
  usb: gadget: f_tcm: Return ATA cmd direction
  usb: gadget: f_tcm: Execute command on write completion
  usb: gadget: f_tcm: Minor cleanup redundant code
  usb: gadget: f_tcm: Don't free command immediately
  usb: gadget: f_tcm: Translate error to sense
  usb: gadget: f_tcm: Cleanup unused variable
  usb: gadget: f_tcm: Update state on data write
  usb: gadget: f_tcm: Handle abort command
  usb: gadget: f_tcm: Cleanup requests on ep disable
  usb: gadget: f_tcm: Decrement command ref count on cleanup
  usb: gadget: f_tcm: Save CPU ID per command
  usb: gadget: f_tcm: Get stream by tag
  usb: gadget: f_tcm: Send sense on cancelled transfer
  usb: gadget: f_tcm: Handle TASK_MANAGEMENT commands
  usb: gadget: f_tcm: Check overlapped command
  usb: gadget: f_tcm: Comply with UAS Task Management requirement

 drivers/target/target_core_transport.c |  10 +
 drivers/usb/gadget/function/f_tcm.c    | 536 +++++++++++++++++++------
 drivers/usb/gadget/function/tcm.h      |  20 +-
 include/target/target_core_base.h      |   5 +
 4 files changed, 436 insertions(+), 135 deletions(-)


base-commit: 88a15fbb47db483d06b12b1ae69f114b96361a96
-- 
2.28.0

