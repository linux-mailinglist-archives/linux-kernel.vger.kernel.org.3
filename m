Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4E054B896
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 20:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242526AbiFNS1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 14:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353350AbiFNS1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 14:27:18 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD8B46C9E;
        Tue, 14 Jun 2022 11:27:16 -0700 (PDT)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LMxdc2MYlz67Zjl;
        Wed, 15 Jun 2022 02:23:32 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 14 Jun 2022 20:27:13 +0200
Received: from [10.195.33.253] (10.195.33.253) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 14 Jun 2022 19:27:12 +0100
Message-ID: <bc567212-af8c-6aba-30ab-fb1b2390e2e4@huawei.com>
Date:   Tue, 14 Jun 2022 19:30:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH RFC v2 01/18] blk-mq: Add a flag for reserved requests
To:     Bart Van Assche <bvanassche@acm.org>, <axboe@kernel.dk>,
        <damien.lemoal@opensource.wdc.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <brking@us.ibm.com>, <hare@suse.de>,
        <hch@lst.de>
CC:     <linux-block@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <chenxiang66@hisilicon.com>
References: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
 <1654770559-101375-2-git-send-email-john.garry@huawei.com>
 <1f8e7891-a557-bd8e-221a-6cb14770ea8b@acm.org>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <1f8e7891-a557-bd8e-221a-6cb14770ea8b@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.33.253]
X-ClientProxiedBy: lhreml746-chm.china.huawei.com (10.201.108.196) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2022 19:00, Bart Van Assche wrote:
> On 6/9/22 03:29, John Garry wrote:
>> Add a flag for reserved requests so that drivers may know this for any
>> special handling.
>>
>> The 'reserved' argument in blk_mq_ops.timeout callback could now be
>> replaced by using this flag.
> 
> Why not to combine that change into this patch?
> 

If we remove the 'reserved' argument in blk_mq_ops.timeout callback then 
we can also remove the 'reserved' member of busy_tag_iter_fn. I gave 
that all a try and the diffstat looks like this:

  block/blk-mq-debugfs.c              |  2 +-
  block/blk-mq-tag.c                  | 13 +++++--------
  block/blk-mq.c                      | 22 +++++++++++++---------
  block/bsg-lib.c                     |  2 +-
  drivers/block/mtip32xx/mtip32xx.c   | 11 +++++------
  drivers/block/nbd.c                 |  5 ++---
  drivers/block/null_blk/main.c       |  2 +-
  drivers/infiniband/ulp/srp/ib_srp.c |  3 +--
  drivers/mmc/core/queue.c            |  3 +--
  drivers/nvme/host/apple.c           |  3 +--
  drivers/nvme/host/core.c            |  2 +-
  drivers/nvme/host/fc.c              |  6 ++----
  drivers/nvme/host/nvme.h            |  2 +-
  drivers/nvme/host/pci.c             |  2 +-
  drivers/nvme/host/rdma.c            |  3 +--
  drivers/nvme/host/tcp.c             |  3 +--
  drivers/s390/block/dasd.c           |  2 +-
  drivers/scsi/aacraid/comminit.c     |  2 +-
  drivers/scsi/aacraid/linit.c        |  2 +-
  drivers/scsi/hosts.c                | 14 ++++++--------
  drivers/scsi/mpi3mr/mpi3mr_os.c     | 15 ++++-----------
  drivers/scsi/scsi_lib.c             | 12 ++----------
  include/linux/blk-mq.h              | 10 ++++++++--
  include/scsi/scsi_host.h            |  2 +-
  24 files changed, 62 insertions(+), 81 deletions(-)

It would seem sensible to send that all separately and break it down a 
bit - this series is already almost unmanageable.

> Anyway:
> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> .

Thanks
