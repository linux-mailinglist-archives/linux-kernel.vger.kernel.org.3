Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E7E4ED192
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 04:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352231AbiCaCQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 22:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352494AbiCaCQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 22:16:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C7E1673D1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 19:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648692899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nwh3gJUQoLB7DUzrgSSSj4DXGfbcFSKDANnPN2mcEc4=;
        b=Xa4wrHgEBsz6nCnrfLvxJwdNU4tMdhegr+pF1kQYyroP9220ETGx2xQM68VFsCJ5/YU6DE
        hHPVTIYNQdi+z1Dy1ZF0/tMBZjnNW34GwDNZAFpAJCiDjwCOG2wleDsIgD48iYGEHHmOgw
        zU+ka8eEEE/aPsdYqq2tq1UOtgN3ClI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-OoFNJCvhNueID-FIUzmeDw-1; Wed, 30 Mar 2022 22:14:56 -0400
X-MC-Unique: OoFNJCvhNueID-FIUzmeDw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79F4685A5BE;
        Thu, 31 Mar 2022 02:14:55 +0000 (UTC)
Received: from T590 (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BE9782166B3F;
        Thu, 31 Mar 2022 02:14:39 +0000 (UTC)
Date:   Thu, 31 Mar 2022 10:14:34 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Martin Wilck <martin.wilck@suse.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: filesystem corruption with "scsi: core: Reallocate device's
 budget map on queue depth change"
Message-ID: <YkUOip75R8DH613s@T590>
References: <YkQsumJ3lgGsagd2@arighi-desktop>
 <f7bacce8-b5e5-3ef1-e116-584c01533f69@huawei.com>
 <YkQ9KoKb+VK06zXi@arighi-desktop>
 <08717833-19bb-8aaa-4f24-2989a9f56cd3@huawei.com>
 <263108383b1c01cf9237ff2fcd2e97a482eff83e.camel@linux.ibm.com>
 <YkRfrjgNpD+S2WpN@T590>
 <ba090f1b-a767-46a1-5728-82d9c587ef3c@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba090f1b-a767-46a1-5728-82d9c587ef3c@opensource.wdc.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 07:30:35AM +0900, Damien Le Moal wrote:
> On 3/30/22 22:48, Ming Lei wrote:
> > On Wed, Mar 30, 2022 at 09:31:35AM -0400, James Bottomley wrote:
> >> On Wed, 2022-03-30 at 13:59 +0100, John Garry wrote:
> >>> On 30/03/2022 12:21, Andrea Righi wrote:
> >>>> On Wed, Mar 30, 2022 at 11:38:02AM +0100, John Garry wrote:
> >>>>> On 30/03/2022 11:11, Andrea Righi wrote:
> >>>>>> Hello,
> >>>>>>
> >>>>>> after this commit I'm experiencing some filesystem corruptions
> >>>>>> at boot on a power9 box with an aacraid controller.
> >>>>>>
> >>>>>> At the moment I'm running a 5.15.30 kernel; when the filesystem
> >>>>>> is mounted at boot I see the following errors in the console:
> >>>
> >>> About "scsi: core: Reallocate device's budget map on queue depth
> >>> change" being added to a stable kernel, I am not sure if this was
> >>> really a fix  or just a memory optimisation.
> >>
> >> I can see how it becomes the problem: it frees and allocates a new
> >> bitmap across a queue freeze, but bits in the old one might still be in
> >> use.  This isn't a problem except when they return and we now possibly
> >> see a tag greater than we think we can allocate coming back. 
> >> Presumably we don't check this and we end up doing a write to
> >> unallocated memory.
> >>
> >> I think if you want to reallocate on queue depth reduction, you might
> >> have to drain the queue as well as freeze it.
> > 
> > After queue is frozen, there can't be any in-flight request/scsi
> > command, so the sbitmap is zeroed at that time, and safe to reallocate.
> > 
> > The problem is aacraid specific, since the driver has hard limit
> > of 256 queue depth, see aac_change_queue_depth().
> 
> 256 is the scsi hard limit per device... Any SAS drive has the same limit
> by default since there is no way to know the max queue depth of a scsi
> disk.So what is special about aacraid ?
> 

I meant aac_change_queue_depth() sets hard limit of 256.

Yeah, for any hba driver which implements its own .change_queue_depth(),
there may be one hard limit there.

So I still don't understand why you mention '256 is the scsi hard limit per
device', and where is the code? If both .cma_per_lun and .can_queue are > 256
and the driver uses default scsi_change_queue_depth() and sdev->tagged_supported
is true, then user is free to change queue depth via /sys/block/$SDN/device/queue_depth
to > 256. It is same for SAS, see sas_change_queue_depth().

Also I am pretty sure some type of scsi device is capable of supporting >256 queue
depth, include sas, and sas usually has big queue depth.


Thanks,
Ming

