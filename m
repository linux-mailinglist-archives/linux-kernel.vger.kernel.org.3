Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E5B4EC5F0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346335AbiC3Nut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243622AbiC3Nur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:50:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17A07C625B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 06:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648648141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q+NBE/hTdM81w8Dvz+19s18J//AsPztVXsL/1M4A+3M=;
        b=CW0LDq+xEFaQGQZFCH4wMsx0HDoDHXYOixkA8kHa4hWzVozGsbdZjzw2Yp2u38hga5OIjI
        BiErsbbmoIDjlT023uE5j/zQr1rHTK8ieWMvFmT1wHhojs8XFh308z/HzWbCaCHsTkXWKV
        xdAx8U8JH7nZJrAlYvh8Lp/QCZaUsPU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-20-ypCrzs0fOZusgdauwxujjQ-1; Wed, 30 Mar 2022 09:48:55 -0400
X-MC-Unique: ypCrzs0fOZusgdauwxujjQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B87C180D2A2;
        Wed, 30 Mar 2022 13:48:48 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EAB5457B60A;
        Wed, 30 Mar 2022 13:48:36 +0000 (UTC)
Date:   Wed, 30 Mar 2022 21:48:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     John Garry <john.garry@huawei.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Martin Wilck <martin.wilck@suse.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: filesystem corruption with "scsi: core: Reallocate device's
 budget map on queue depth change"
Message-ID: <YkRfrjgNpD+S2WpN@T590>
References: <YkQsumJ3lgGsagd2@arighi-desktop>
 <f7bacce8-b5e5-3ef1-e116-584c01533f69@huawei.com>
 <YkQ9KoKb+VK06zXi@arighi-desktop>
 <08717833-19bb-8aaa-4f24-2989a9f56cd3@huawei.com>
 <263108383b1c01cf9237ff2fcd2e97a482eff83e.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <263108383b1c01cf9237ff2fcd2e97a482eff83e.camel@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 09:31:35AM -0400, James Bottomley wrote:
> On Wed, 2022-03-30 at 13:59 +0100, John Garry wrote:
> > On 30/03/2022 12:21, Andrea Righi wrote:
> > > On Wed, Mar 30, 2022 at 11:38:02AM +0100, John Garry wrote:
> > > > On 30/03/2022 11:11, Andrea Righi wrote:
> > > > > Hello,
> > > > > 
> > > > > after this commit I'm experiencing some filesystem corruptions
> > > > > at boot on a power9 box with an aacraid controller.
> > > > > 
> > > > > At the moment I'm running a 5.15.30 kernel; when the filesystem
> > > > > is mounted at boot I see the following errors in the console:
> > 
> > About "scsi: core: Reallocate device's budget map on queue depth
> > change" being added to a stable kernel, I am not sure if this was
> > really a fix  or just a memory optimisation.
> 
> I can see how it becomes the problem: it frees and allocates a new
> bitmap across a queue freeze, but bits in the old one might still be in
> use.  This isn't a problem except when they return and we now possibly
> see a tag greater than we think we can allocate coming back. 
> Presumably we don't check this and we end up doing a write to
> unallocated memory.
> 
> I think if you want to reallocate on queue depth reduction, you might
> have to drain the queue as well as freeze it.

After queue is frozen, there can't be any in-flight request/scsi
command, so the sbitmap is zeroed at that time, and safe to reallocate.

The problem is aacraid specific, since the driver has hard limit
of 256 queue depth, see aac_change_queue_depth().


Thanks,
Ming

