Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED2B4FAECE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 18:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243538AbiDJQOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 12:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240551AbiDJQOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 12:14:48 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC43506CF;
        Sun, 10 Apr 2022 09:12:37 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u15so7658139ejf.11;
        Sun, 10 Apr 2022 09:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=n3XGAdzzz/+5bT8q+RENXVS4bI+kwN6cAFNKDEuZ0CM=;
        b=fvJKrQJTDmhHz0iOM8fM0KwsGjkIykaNWD1jdY+C9TWjGFr+d6dYicINChuFgTeoAA
         jNK+GFEKcCY3Rcjm2pYFIkGxSGF3LavBhM3mzAKr/4AvCAVoEleq/jbxVcgwXaPhkJfk
         QHAnb2/pscghhG1kaQtwNiYqr7lLAEgwornR2G0tvnUHL/Ip0MUqElhw/RcK+LWpAJdu
         wi9HMrUhzloQnkUoU21IW3cv0WTOGA27tnZmRFKJ+c654Hs5qAQbTEcThr8Mwb/AGHJ6
         Udkv38Pgi04b1HXI1hjJJZzMyws9j45MDIntOEAgp2/wBQyBrw8ikvQbrmK6anfnCslv
         Q2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=n3XGAdzzz/+5bT8q+RENXVS4bI+kwN6cAFNKDEuZ0CM=;
        b=hLi9/qmUPk7naNT84MFBgmDS57S+Ai9sWS9ThUksLSKLENaefx3D8NpFmpzlhGNwl2
         CCidSLYOZD32xZoQwWtCCFhtbqlyFtpegFpBmArN/6Xyp7aROw8T2VIydl6kGRlvzNTU
         vAXgjqcbZR5HkIk4o4ODWyzqXzghiQS05gRpoz+4e1Oah+8XdXG8DpWboIcE+DttFofN
         /RPwgKEB2QRTrpRSrUViusnJ58/OS/z0rjOyif5vGF5Qmt8V4X9NY6+AX4AcrsS1qaXz
         VYbBMuEg3jpqRLxQ4QOUwbq5zaZBctyDX8WtSGm/nEMlw2FUXXpBzBr74dKn/2hefADm
         5cPw==
X-Gm-Message-State: AOAM530dJz57Zfq0L+urBL/jekZXDU5Q6S7tupMBOy1LR0POHKFQgkQZ
        1NtlIMFniUIsSxEFae/rF14=
X-Google-Smtp-Source: ABdhPJxF7lFhqFw6a56Dsiepy+Qq5WHEgzFtdFF8g1vUVid2LANDepiYCz2afM8oYFSWNNgdXuQkYA==
X-Received: by 2002:a17:907:7b86:b0:6e8:5116:f4f6 with SMTP id ne6-20020a1709077b8600b006e85116f4f6mr11001952ejc.392.1649607156304;
        Sun, 10 Apr 2022 09:12:36 -0700 (PDT)
Received: from [192.168.0.48] (ip-046-005-230-076.um12.pools.vodafone-ip.de. [46.5.230.76])
        by smtp.gmail.com with ESMTPSA id bw3-20020a170906c1c300b006e88cdfbc32sm656132ejb.45.2022.04.10.09.12.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Apr 2022 09:12:35 -0700 (PDT)
From:   Edward Shishkin <edward.shishkin@gmail.com>
Subject: Reiser5: Parallel scaling out on local hosts. Numbers!
To:     ReiserFS development mailing list 
        <reiserfs-devel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Andy Lavr <andy.lavr@gmail.com>
Message-ID: <488ed272-d2ee-d311-aa0c-23eb212b21bf@gmail.com>
Date:   Sun, 10 Apr 2022 18:12:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Earlier we announced a logical volume manager with parallel scaling out
on local hosts, which is different from the traditional RAID arrays and
is more like volume managers of networking file systems:
https://reiser4.wiki.kernel.org/index.php/Logical_Volumes_Background

Here we provide some numbers for the latest Reiser5 software release.

Note that performance of volume operations have different topicality.
E.g. performance of device removal is more topical than performance of
adding a device. Indeed, user usually wants the deleted device to go to
other needs immediately, whereas, when adding a device he gets more disk
space immediately after issuing the command (there is no need to wait
for rebalancing completion).



Hardware:

Dell OptiPlex 7050 6C2XR, Intel Core i7-7700, 16GB RAM
(4 Cores / 8 Threads)

Storage media:

DEV1: Lite-On LCS-256M6S, SSD 256GB, SATAIII, 2.5"
DEV2: Intenso 2.5" SSD TOP, 256G, SATAIII, 2.5"
DEV3: Intenso 2.5" SSD TOP, 256G, SATAIII, 2.5"
DEV4: Intenso M.2  SSD TOP, 256G, SATAIII, m.2 2280
RAM0: Block device in RAM


Software:

Reiser4-for-5.16.patch (software release 5.1.3), download at:
https://sourceforge.net/projects/reiser4/files/v5-unstable/kernel/reiser4-for-5.16.patch.gz/download


Reiser4progs-2.0.5 (software release 5.1.3), download at:
https://sourceforge.net/projects/reiser4/files/v5-unstable/progs/reiser4progs-2.0.5.tar.gz/download




                Sequential RAW operations


Data set: 10G at zero offset


1. Read from RAW device

Device     Speed, M/s

   DEV1         470
   DEV2         530


2. Write to RAW device

Device     Speed, M/s


   DEV1        390
   DEV2        420



              Sequential file operations


Stripe size: 128K
Data set: one 10G file



            1. Read/Write a large file, Speed (M/s)



Nr of Disks in the Volume       Write               Read

  1 (DEV1)                        380                 460
  1 (DEV2)                        410                 518
  2 (DEV1+DEV2)                   695                 744
  3 (DEV1+DEV2+DEV3)              890                 970
  4 (DEV1+DEV2+DEV3+DEV4)         950                1100



             2. Copy data from/to formatted device



  From device                  To device           Speed (M/s)

      DEV1                        DEV2                260
      DEV2                        DEV1                255


                         Volume operations


Stripe size: 128K
Data set: one 10G file


Speed of any volume operation is defined as D/T, where
D - total amount of data stored on the volume
T - operation time (including full data rebalancing/migration and sync)
Caches are dropped before each operation.

More details about logical volumes management can be found here:
https://reiser4.wiki.kernel.org/index.php/Logical_Volumes_Administration



              1. Adding a device to a logical volume



      Volume             Device to add              Speed M/s

  DEV1                        DEV2                     284
  DEV1+DEV2                   DEV3                     457
  DEV1+DEV2+DEV3              DEV4                     574


               2. Removing a device from a logical volume



     Volume              Device to remove           Speed M/s

  DEV1+DEV2+DEV3+DEV4         DEV4                     890
  DEV1+DEV2+DEV3              DEV3                     606
  DEV1+DEV2                   DEV2                     336



                    3. Flushing a proxy device



More details about proxy device management can be found here:
https://reiser4.wiki.kernel.org/index.php/Proxy_Device_Administration

Before each operation all data of the logical volume are on the proxy
device. After the operation all the data are on the permanent storage
denoted as "Volume".


     Volume                Proxy device             Speed M/s


  DEV1                         DEV4                    228
  DEV1+DEV2                    DEV4                    244
  DEV1+DEV2+DEV3               DEV4                    290


  DEV1                         RAM0                    283
  DEV1+DEV2                    RAM0                    301
  DEV1+DEV2+DEV3               RAM0                    374
  DEV1+DEV2+DEV3+DEV4          RAM0                    427



                     4. Migrating a file



More details about file migration in Reiser5 volumes can be found here:
https://reiser4.wiki.kernel.org/index.php/Transparent_File_Migration

Before each operation all data of the file are fairly distributed among
all devices-components of the logical Volume. After the operation all
file's data are stored on the Target device.


     Volume                Target Device            Speed M/s


DEV1+DEV2+DEV3+DEV4           DEV1                     387
DEV1+DEV2+DEV3                DEV1                     403
DEV1+DEV2                     DEV1                     427


Comment. With increasing number of components, the speed of file
migration approaches (from top) the write speed to the formatted device
DEV1 (380 M/s).



                            Comments



Parallel O(1)-defragmentor of compound Reiser5 volumes is in plans!
Proxy devices are also a subject of defragmentation.

All file and volume operations are a subject of further performance
improvements. Currently IO requests against devices-components of a
logical volume are submitted by the same thread. This serialization
factor leads to performance drop. Once the software stability reaches
beta level, the things should be parallelized. Also currently for
simplicity _all_ data are read from the volume during its re-balancing.
It would be more reasonable to read only those data which are a subject
of migration.

Theoretical limit for the speed of adding(removing) a second device is a
double copy speed from DEV1 to DEV2 (respectively from DEV2 to DEV1).
Currently we have respectively 1.1 and 1.3 of the copy speed.
