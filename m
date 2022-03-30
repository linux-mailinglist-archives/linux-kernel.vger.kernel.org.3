Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6EB4EC5D8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244608AbiC3Nnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346293AbiC3NnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:43:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0021623BF8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 06:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648647685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0pfhQO9+ySCIUtxxomjsvRcGynOcpOy3BREwqAMYCYg=;
        b=hKlzhtEMJQxwuOX7FaGdOyTEyf8nnXhrB6qA51SLP9WdQlJVHN39vsK2Sn+0m+l8uH4c40
        JAVDc+tPvf9nMrVs1lme40QzVe6y7t/SG0xvLUqZ+Do0wTImYaWVXoI4BZPK0+AmTPf6fg
        a2/KjFAA7TbxR0eBvEgtEAgKONuwJsQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-kNYIdQ5CPQ6sD-4FDTX4Bw-1; Wed, 30 Mar 2022 09:41:20 -0400
X-MC-Unique: kNYIdQ5CPQ6sD-4FDTX4Bw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F9D6805F6B;
        Wed, 30 Mar 2022 13:41:19 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 546F540CF8F8;
        Wed, 30 Mar 2022 13:41:09 +0000 (UTC)
Date:   Wed, 30 Mar 2022 21:41:04 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Andrea Righi <andrea.righi@canonical.com>,
        Martin Wilck <martin.wilck@suse.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: filesystem corruption with "scsi: core: Reallocate device's
 budget map on queue depth change"
Message-ID: <YkRd8O+kW/MRQJbw@T590>
References: <YkQsumJ3lgGsagd2@arighi-desktop>
 <f7bacce8-b5e5-3ef1-e116-584c01533f69@huawei.com>
 <YkQ9KoKb+VK06zXi@arighi-desktop>
 <08717833-19bb-8aaa-4f24-2989a9f56cd3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08717833-19bb-8aaa-4f24-2989a9f56cd3@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 01:59:43PM +0100, John Garry wrote:
> On 30/03/2022 12:21, Andrea Righi wrote:
> > On Wed, Mar 30, 2022 at 11:38:02AM +0100, John Garry wrote:
> > > On 30/03/2022 11:11, Andrea Righi wrote:
> > > > Hello,
> > > > 
> > > > after this commit I'm experiencing some filesystem corruptions at boot
> > > > on a power9 box with an aacraid controller.
> > > > 
> > > > At the moment I'm running a 5.15.30 kernel; when the filesystem is
> > > > mounted at boot I see the following errors in the console:
> 
> About "scsi: core: Reallocate device's budget map on queue depth change"
> being added to a stable kernel, I am not sure if this was really a fix or
> just a memory optimisation.
> 
> > > > 
> > > > Begin: Will now check root file system ... fsck from util-linux 2.36.1
> > > > [/usr/sbin/fsck.ext4 (1) -- /dev/sda2] fsck.ext4 -a -C0 /dev/sda2
> > > > root: clean, 99646/122101760 files, 11187342/488376336 blocks
> > > > done.
> > > > [    4.636613] sd 0:2:0:0: [sda] tag#257 FAILED Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK cmd_age=0s
> > > > [    4.636655] sd 0:2:0:0: [sda] tag#257 CDB: Read(10) 28 00 00 00 4c 10 00 00 08 00
> > > > [    4.636689] blk_update_request: I/O error, dev sda, sector 19472 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> > > > [    4.636734] sd 0:2:0:0: [sda] tag#258 FAILED Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK cmd_age=0s
> > > > [    4.636772] sd 0:2:0:0: [sda] tag#258 CDB: Read(10) 28 00 00 00 4c 18 00 00 08 00
> > > > [    4.636796] blk_update_request: I/O error, dev sda, sector 19480 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> > > > [    4.636840] sd 0:2:0:0: [sda] tag#260 FAILED Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK cmd_age=0s
> > > > [    4.636877] sd 0:2:0:0: [sda] tag#260 CDB: Read(10) 28 00 00 00 4c 28 00 00 08 00
> > > > [    4.636901] blk_update_request: I/O error, dev sda, sector 19496 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> > > > [    4.636944] sd 0:2:0:0: [sda] tag#259 FAILED Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK cmd_age=0s
> > > > [    4.636971] sd 0:2:0:0: [sda] tag#259 CDB: Read(10) 28 00 00 00 4c 20 00 00 08 00
> > > > [    4.637005] blk_update_request: I/O error, dev sda, sector 19488 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> > > > [    4.637049] sd 0:2:0:0: [sda] tag#262 FAILED Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK cmd_age=0s
> > > > [    4.637085] sd 0:2:0:0: [sda] tag#262 CDB: Read(10) 28 00 00 00 4c 38 00 00 08 00
> > > > [    4.637118] blk_update_request: I/O error, dev sda, sector 19512 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> > > > [    4.637161] sd 0:2:0:0: [sda] tag#264 FAILED Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK cmd_age=0s
> > > > [    4.637197] sd 0:2:0:0: [sda] tag#264 CDB: Read(10) 28 00 00 00 4c 48 00 00 08 00
> > > > [    4.637221] blk_update_request: I/O error, dev sda, sector 19528 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> > > > [    4.637270] sd 0:2:0:0: [sda] tag#284 FAILED Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK cmd_age=0s
> > > > [    4.637306] sd 0:2:0:0: [sda] tag#284 CDB: Read(10) 28 00 00 00 4c e8 00 00 08 00
> > > > [    4.637332] blk_update_request: I/O error, dev sda, sector 19688 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> > > > [    4.637375] sd 0:2:0:0: [sda] tag#286 FAILED Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK cmd_age=0s
> > > > [    4.637411] sd 0:2:0:0: [sda] tag#286 CDB: Read(10) 28 00 00 00 4c f8 00 00 08 00
> > > > [    4.637444] blk_update_request: I/O error, dev sda, sector 19704 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> > > > [    4.637481] blk_update_request: I/O error, dev sda, sector 19664 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> > > > [    4.637485] sd 0:2:0:0: [sda] tag#282 FAILED Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK cmd_age=0s
> > > > [    4.637487] sd 0:2:0:0: [sda] tag#287 FAILED Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK cmd_age=0s
> > > > [    4.637491] sd 0:2:0:0: [sda] tag#287 CDB: Read(10) 28 00 00 00 4d 00 00 00 08 00
> > > > [    4.637491] sd 0:2:0:0: [sda] tag#282 CDB: Read(10) 28 00 00 00 4c d8 00 00 08 00
> > > > [    4.637494] blk_update_request: I/O error, dev sda, sector 19672 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> > > > [    4.747771] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
> > > > 
> 
> We need to find where that memory corruption is coming from. Maybe the root
> is that too many commands are being sent to the disk. Ming?

Yeah, looks aacraid limits max queue depth as 256, see aac_change_queue_depth().


Thanks, 
Ming

