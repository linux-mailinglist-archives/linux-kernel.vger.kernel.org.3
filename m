Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B408B52296D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 04:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240996AbiEKCH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 22:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235872AbiEKCHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:07:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADFBF34642
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652234832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NlO8iEufHMnKg+NhkfN0TsHAyOYUXpgbfoZ0SDeWqus=;
        b=SACAfeI8w2vrPlyN2SLi3p24VPF2Xaoc82LrpfnH9GfGeKR7rqgDJs0M1zSUisBjr4e9kU
        1VLe44tPXgWbsbTeMYLg/9FyGvyHTThEv3wtrwzEE6+7dPxBWsjrxUg+dt8802kUqF0RiY
        rK4PXXgrzXKpsi6tsVywqNTCdH79Jrc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-14-5G8zIGwkMES5IyDnPiMtrA-1; Tue, 10 May 2022 22:07:11 -0400
X-MC-Unique: 5G8zIGwkMES5IyDnPiMtrA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01A5C805B25;
        Wed, 11 May 2022 02:07:11 +0000 (UTC)
Received: from T590 (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 58DBF40CF8E7;
        Wed, 11 May 2022 02:07:05 +0000 (UTC)
Date:   Wed, 11 May 2022 10:07:01 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] sbitmap: NUMA node spreading
Message-ID: <YnsaRXzKR5FKjC66@T590>
References: <1652181274-136198-1-git-send-email-john.garry@huawei.com>
 <1afd2c01-69b3-ab8f-6bfe-118e3e56001c@kernel.dk>
 <9ede7211-ae58-5cd4-4cf6-74c1f508f1a6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ede7211-ae58-5cd4-4cf6-74c1f508f1a6@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 02:44:50PM +0100, John Garry wrote:
> On 10/05/2022 13:50, Jens Axboe wrote:
> > > fio config:
> > > bs=4096, iodepth=128, numjobs=10, cpus_allowed_policy=split, rw=read,
> > > ioscheduler=none
> > > 
> > > Before:
> > > 7130K
> > > 
> > > After:
> > > 7630K
> > > 
> > > So a +7% IOPS gain.
> 
> Thanks for having a look.
> 
> > What does the comparison run on a non-NUMA non-shared queue look like?
> > Because I bet it'd be slower.
> 
> I could test more to get a solid result for that.
> 
> > 
> > To be honest, I don't like this approach at all. It makes the normal
> > case quite a bit slower by having an extra layer of indirection for the
> > word, that's quite a bit of extra cost.
> 
> Yes, there is the extra load. I would hope that there would be a low cost,
> but I agree that we still want to avoid it. So prob no point in testing this
> more.
> 
> > It doesn't seem like a good
> > approach for the issue, as it pessimizes the normal fast case.
> > 
> > Spreading the memory out does probably make sense, but we need to retain
> > the fast normal case. Making sbitmap support both, selected at init
> > time, would be far more likely to be acceptable imho.
> 
> I wanted to keep the code changes minimal for an initial RFC to test the
> water.
> 
> My original approach did not introduce the extra load for normal path and
> had some init time selection for a normal word map vs numa word map, but the
> code grew and became somewhat unmanageable. I'll revisit it to see how to
> improve that.

I understand this approach just splits shared sbitmap into per-numa-node
part, but what if all IOs are just from CPUs in one same numa node? Doesn't
this way cause tag starvation and waste?


Thanks,
Ming

