Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE4C5B07C1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiIGO7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiIGO66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:58:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9DEB2745
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 07:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662562735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wAgFYn04JWkSi5U/2as7gYF5HiZ1Ev8Ucg8sfjGskc4=;
        b=guHjeCXGaRlAZYqXpYcL+Mg4scvbST+I4EnBjOJoioli1EUqEVZooo6pAALRGk80vWNUpS
        WKpm8Tj/KrT1A1AXhlvMFjJX0i/INSD/bnuExiluvlYg3tSjkaVv0seIujOALcGGsfNd9v
        N454moL7aCE84toIuFtdi1OwmDIFl+M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-438-XaJFF-k5O8G3Wajxg5ExDQ-1; Wed, 07 Sep 2022 10:58:54 -0400
X-MC-Unique: XaJFF-k5O8G3Wajxg5ExDQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7799E185A7BA;
        Wed,  7 Sep 2022 14:58:53 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0597340CF916;
        Wed,  7 Sep 2022 14:58:46 +0000 (UTC)
Date:   Wed, 7 Sep 2022 22:58:41 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dusty Mabe <dusty@dustymabe.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Xiao Ni <xni@redhat.com>, Song Liu <song@kernel.org>,
        Nigel Croxon <ncroxon@redhat.com>
Subject: Re: regression caused by block: freeze the queue earlier in
 del_gendisk
Message-ID: <YxixoYNB0VTc8Zd+@T590>
References: <017845ae-fbae-70f6-5f9e-29aff2742b8c@dustymabe.com>
 <YxBZ4BBjxvAkvI2A@T590>
 <20220907073324.GB23826@lst.de>
 <YxhYjaA3CrMz5njZ@T590>
 <44ab9f7d-8f00-5f80-210e-f65f02f6fd82@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44ab9f7d-8f00-5f80-210e-f65f02f6fd82@nvidia.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 02:40:57PM +0000, Chaitanya Kulkarni wrote:
> Hi all,
> 
> On 9/7/22 01:38, Ming Lei wrote:
> > On Wed, Sep 07, 2022 at 09:33:24AM +0200, Christoph Hellwig wrote:
> >> On Thu, Sep 01, 2022 at 03:06:08PM +0800, Ming Lei wrote:
> >>> It is a bit hard to associate the above commit with reported issue.
> >>
> >> So the messages clearly are about something trying to open a device
> >> that went away at the block layer, but somehow does not get removed
> >> in time by udev (which seems to be a userspace bug in CoreOS).  But
> >> even with that we really should not hang.
> > 
> > The new device should be allocated from md_probe() via blk_request_module(),
> > and the underlying devices are virtio-blk from the fedora BZ2121791.
> > 
> > [1] https://bugzilla.redhat.com/show_bug.cgi?id=2121791
> > 
> > Thanks,
> > Ming
> > 
> 
> It would be really helpful if mdraid experts can write blktests so it
> will get tested in the nightly builds along with other tests with
> different distros.

Can't agree more, and Cc linux-raid and our raid guys.

And looks this one is more related with imsm.


Thanks,
Ming

