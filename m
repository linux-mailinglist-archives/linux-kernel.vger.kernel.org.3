Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4524EBE6D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 12:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245223AbiC3KNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 06:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245224AbiC3KMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:12:54 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D742F15E88A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 03:11:09 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 81BDE410E7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1648635068;
        bh=Wr5cnF6Wo1fv2bl+DDbGCAzsAfmDm2PkbazjLBhDedo=;
        h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type;
        b=KR91eHQ/Iq4PhntbNfgQYEPeYNtAY6/MA2IfKb6i7ewDm4HMCExZDHDJ+lCMKrO1O
         8UANu393O7ZhKhDmJjKuWkcsH3KsO77XNhVhxylFiYdfHnGAEddBdUmM3nYqb5LW7m
         Q+LrkhKNTEEjdfYZmtuY73TH9alRX5lSTTH421uLP81PYz4h1M7UZM9v7b0C3ALQYi
         SX9QNGbIL6z0yuJVvhKo+fZXUmWmvTSoZRkTQVFqVSpseRPMy+2x3bck06ptvS7ohY
         6MFUBgNXgUPn9hTu5kSOZotD1PyRMCw+TNAZ2mpIkZOa1qN8iEMUcFdJRIFjmNTSb0
         EkfTmfWdbR3JQ==
Received: by mail-ej1-f72.google.com with SMTP id ml20-20020a170906cc1400b006df8c9357efso9560901ejb.21
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 03:11:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Wr5cnF6Wo1fv2bl+DDbGCAzsAfmDm2PkbazjLBhDedo=;
        b=zVOn/gII9iFjt2IO8iW6fKW9b8Y0Vp9Xq+HOscZIdM+g+qaVw0KgqVyN5fdNJbNvdo
         59Zx+tCarGNjZZbK9iB0e0zNNuRxHOIC04Iqs/6Jq0+EGx3G0YWC4FlEEb1rpRGkrVsq
         t5Em5eDcWjy0A7MaBoadc0T+oghMGTJ7T7Ksru2YNaMZcTMdU52/SfV4DDZn3JbeB9sp
         4My4tZZ5tPefKKQV/9jSfGO/Qj+MQ3yX1eQFnT85wtX9felX36VTzYkG5MEQKMRhx197
         D7po3nKQ4oLY+55sQhs+o+DrQkvd8Bj/ol20NVu/8+KWz8v+0qsI64F4qjbD1iSXYcFe
         q2PQ==
X-Gm-Message-State: AOAM532Iyqo5vrg1PTGgpzMW7Lkz0eF5TldNVtRb1PfRJTsgKFc7NC65
        MEOCein19wekAD0IECTxOcL6H9SH46L+c/jrZi/JzLDDpZSeK5SFvcNlEoBdE/EeLhCSdgbS3z8
        NMAfBZXi5ZQImv+dxTK1VlwGCI2cgW5g/OVW0jeVHdg==
X-Received: by 2002:a17:907:16a2:b0:6e0:dc75:eb5a with SMTP id hc34-20020a17090716a200b006e0dc75eb5amr23623721ejc.508.1648635067976;
        Wed, 30 Mar 2022 03:11:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrtp+ahE3zPsf6Vc6tKusbmMySKU3iBqHiDdu0z06iIgdQGERPeTc0fRaFx53ZEIF98lJPQQ==
X-Received: by 2002:a17:907:16a2:b0:6e0:dc75:eb5a with SMTP id hc34-20020a17090716a200b006e0dc75eb5amr23623705ejc.508.1648635067731;
        Wed, 30 Mar 2022 03:11:07 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c1b6])
        by smtp.gmail.com with ESMTPSA id o17-20020a056402439100b0041938757232sm9797742edc.17.2022.03.30.03.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 03:11:07 -0700 (PDT)
Date:   Wed, 30 Mar 2022 12:11:06 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Ming Lei <ming.lei@redhat.com>,
        Martin Wilck <martin.wilck@suse.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: filesystem corruption with "scsi: core: Reallocate device's budget
 map on queue depth change"
Message-ID: <YkQsumJ3lgGsagd2@arighi-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

after this commit I'm experiencing some filesystem corruptions at boot
on a power9 box with an aacraid controller.

At the moment I'm running a 5.15.30 kernel; when the filesystem is
mounted at boot I see the following errors in the console:

Begin: Will now check root file system ... fsck from util-linux 2.36.1
[/usr/sbin/fsck.ext4 (1) -- /dev/sda2] fsck.ext4 -a -C0 /dev/sda2 
root: clean, 99646/122101760 files, 11187342/488376336 blocks
done.
[    4.636613] sd 0:2:0:0: [sda] tag#257 FAILED Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK cmd_age=0s
[    4.636655] sd 0:2:0:0: [sda] tag#257 CDB: Read(10) 28 00 00 00 4c 10 00 00 08 00
[    4.636689] blk_update_request: I/O error, dev sda, sector 19472 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[    4.636734] sd 0:2:0:0: [sda] tag#258 FAILED Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK cmd_age=0s
[    4.636772] sd 0:2:0:0: [sda] tag#258 CDB: Read(10) 28 00 00 00 4c 18 00 00 08 00
[    4.636796] blk_update_request: I/O error, dev sda, sector 19480 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[    4.636840] sd 0:2:0:0: [sda] tag#260 FAILED Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK cmd_age=0s
[    4.636877] sd 0:2:0:0: [sda] tag#260 CDB: Read(10) 28 00 00 00 4c 28 00 00 08 00
[    4.636901] blk_update_request: I/O error, dev sda, sector 19496 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[    4.636944] sd 0:2:0:0: [sda] tag#259 FAILED Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK cmd_age=0s
[    4.636971] sd 0:2:0:0: [sda] tag#259 CDB: Read(10) 28 00 00 00 4c 20 00 00 08 00
[    4.637005] blk_update_request: I/O error, dev sda, sector 19488 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[    4.637049] sd 0:2:0:0: [sda] tag#262 FAILED Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK cmd_age=0s
[    4.637085] sd 0:2:0:0: [sda] tag#262 CDB: Read(10) 28 00 00 00 4c 38 00 00 08 00
[    4.637118] blk_update_request: I/O error, dev sda, sector 19512 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[    4.637161] sd 0:2:0:0: [sda] tag#264 FAILED Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK cmd_age=0s
[    4.637197] sd 0:2:0:0: [sda] tag#264 CDB: Read(10) 28 00 00 00 4c 48 00 00 08 00
[    4.637221] blk_update_request: I/O error, dev sda, sector 19528 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[    4.637270] sd 0:2:0:0: [sda] tag#284 FAILED Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK cmd_age=0s
[    4.637306] sd 0:2:0:0: [sda] tag#284 CDB: Read(10) 28 00 00 00 4c e8 00 00 08 00
[    4.637332] blk_update_request: I/O error, dev sda, sector 19688 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[    4.637375] sd 0:2:0:0: [sda] tag#286 FAILED Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK cmd_age=0s
[    4.637411] sd 0:2:0:0: [sda] tag#286 CDB: Read(10) 28 00 00 00 4c f8 00 00 08 00
[    4.637444] blk_update_request: I/O error, dev sda, sector 19704 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[    4.637481] blk_update_request: I/O error, dev sda, sector 19664 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[    4.637485] sd 0:2:0:0: [sda] tag#282 FAILED Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK cmd_age=0s
[    4.637487] sd 0:2:0:0: [sda] tag#287 FAILED Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK cmd_age=0s
[    4.637491] sd 0:2:0:0: [sda] tag#287 CDB: Read(10) 28 00 00 00 4d 00 00 00 08 00
[    4.637491] sd 0:2:0:0: [sda] tag#282 CDB: Read(10) 28 00 00 00 4c d8 00 00 08 00
[    4.637494] blk_update_request: I/O error, dev sda, sector 19672 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[    4.747771] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.

If I reboot multiple times fsck requires a manual fix and I get dropped
to the initramfs shell. Some times the filesystem gets corrupted and I
need to redeploy the box.

If I use the same kernel with this commit reverted I can reboot as many
times as I want without any failure:

 813c6871f76b ("scsi: core: Reallocate device's budget map on queue depth change")

For now I've just reverted the commit, but I'll try to add some
debugging and collect more info.

Let me know if there's any specific test that you want me to try.

Thanks,
-Andrea
