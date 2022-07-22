Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D383757D904
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 05:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbiGVDf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 23:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGVDfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 23:35:20 -0400
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F0665AD
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 20:35:17 -0700 (PDT)
X-QQ-mid: bizesmtp85t1658460907t912l0q3
Received: from eureka.localdomain ( [123.124.208.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 22 Jul 2022 11:34:47 +0800 (CST)
X-QQ-SSF: 01400000000000B0D000000A0000020
X-QQ-FEAT: WKaXkSLX6oOXnGCcaje1boJasvyWVkJgPLT9jk/rpR+aSt4zsc831xepIrtNs
        +ERuWed9ZqjNu8mzddm4YRgbhV9dL1UdzZmD34oULqCFRU17QR2UnGTVBQoI/GZ7io7dZZ5
        5Ifxc5lCE6PHo1/TNVFyo0lMwfFtd6j9fE/2+mFA+2PHQqCR7j5uLPbN1w3a6kP2kT02dXP
        y1x7YA+Z63PXPLeOSSPdtDrpggGk6NiomnimC8mTdUWcmtCkMJLltvlk60I2pt8cKojL2Vb
        XVmMItnpl0ofpECNmBKQWH6DkFwp/cm2S/hKknlZ54YewQ78gRZYYyEkVCBFHckBU1YSPOv
        QAbNlURxsT+hfas0G7Ywg17zsKjGr1t0pJiBeaNrbibYqAjJqxErl0yqjnSVutIGWGK3nZv
        xKOKflmHgSw=
X-QQ-GoodBg: 1
From:   Wang You <wangyoua@uniontech.com>
To:     bvanassche@acm.org
Cc:     axboe@kernel.dk, fio@vger.kernel.org, hch@lst.de,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        wangxiaohua@uniontech.com, wangyoua@uniontech.com
Subject: Re: [PATCH 2/2] block/mq-deadline: Prioritize first request
Date:   Fri, 22 Jul 2022 11:34:47 +0800
Message-Id: <20220722033447.342887-1-wangyoua@uniontech.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <c4da04a9-3f3d-3e22-a59a-1ab2867a5649@acm.org>
References: <c4da04a9-3f3d-3e22-a59a-1ab2867a5649@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> The test hardware is:
>> Kunpeng-920, HW-SAS3508+(MG04ACA400N * 2), RAID0.
> Please also provide performance numbers for a single hard disk and with 
> no RAID controller between the host and the hard disk.

> Thanks,

> Bart.

Hi,

Yesterday I found another server without raid controller to test a same HDD, 
but the performance(The data is not stable, so I tested it many times) wasn't 
what I expected.

Also I tested a SSD with raid contriller on a previous Kunpeng server and 
the performance improved, but that's not always the case with SSDs on 
other servers.

This may indicate that the raid controller plays an important role in this, 
so I'm not sure if this patch really has the desired effect.

Thanks,

Wang.


The test hardware is:
Hygon C86, MG04ACA400N

The test command is:
fio -ioengine=psync -lockmem=1G -buffered=0 -time_based=1 -direct=1 -iodepth=1 
-thread -bs=512B -size=110g -numjobs=32 -runtime=300 -group_reporting 
-name=read -filename=/dev/sdc -ioscheduler=mq-deadline -rw=read[,write,rw]

The following is the test data:
origin/master:
read iops: 15463	write iops: 5949	rw iops: 574,576

nr_sched_batch = 1:
read iops: 15082	write iops: 6283	rw iops: 783,786

nr_sched_batch = 1, use deadline_head_request:
read iops: 15368	write iops: 6575	rw iops: 907,906


The test hardware is:
Kunpeng-920, HW-SAS3508 + Samsung SSD 780, RAID0.

The test command is:
fio -ioengine=psync -lockmem=1G -buffered=0 -time_based=1 -direct=1 -iodepth=1 
-thread -bs=512B -size=110g -numjobs=16 -runtime=300 -group_reporting 
-name=read -filename=/dev/sda -ioscheduler=mq-deadline -rw=read[,write,rw]

The following is the test data:
origin/master:
read iops: 115399       write iops: 136801      rw iops: 58082,58084

nr_sched_batch = 1, use deadline_head_request:
read iops: 136473       write iops: 184646      rw iops: 56460,56454


