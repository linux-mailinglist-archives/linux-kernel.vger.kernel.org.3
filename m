Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BDC5AFF62
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiIGIln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiIGIlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:41:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B164CA59B7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662539933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v7tXqiRu6Q/ASgIKZPVujZFkCxqS9SjkhigXRzRcRk0=;
        b=gJzfcGg43yx9ZKmLyB4wANMeXvxOfylsMFSuQq8InX313uv0IkBhmhupKQOJlhZ71lqkTO
        4SxlHypt9bH1RT63N2m8MOLjCXd5/xjhoiDVq+5+NkgDeEGxSBxM9fgB2WZilF2lC0ntdl
        QuDz6OrSCVI2AjhyAxwXsgHPGV2WZJg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-zdi2S9TtMO-e-EHkgYTvBg-1; Wed, 07 Sep 2022 04:38:48 -0400
X-MC-Unique: zdi2S9TtMO-e-EHkgYTvBg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80F398041BE;
        Wed,  7 Sep 2022 08:38:47 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2050C1415102;
        Wed,  7 Sep 2022 08:38:42 +0000 (UTC)
Date:   Wed, 7 Sep 2022 16:38:37 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dusty Mabe <dusty@dustymabe.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org
Subject: Re: regression caused by block: freeze the queue earlier in
 del_gendisk
Message-ID: <YxhYjaA3CrMz5njZ@T590>
References: <017845ae-fbae-70f6-5f9e-29aff2742b8c@dustymabe.com>
 <YxBZ4BBjxvAkvI2A@T590>
 <20220907073324.GB23826@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907073324.GB23826@lst.de>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 09:33:24AM +0200, Christoph Hellwig wrote:
> On Thu, Sep 01, 2022 at 03:06:08PM +0800, Ming Lei wrote:
> > It is a bit hard to associate the above commit with reported issue.
> 
> So the messages clearly are about something trying to open a device
> that went away at the block layer, but somehow does not get removed
> in time by udev (which seems to be a userspace bug in CoreOS).  But
> even with that we really should not hang.

The new device should be allocated from md_probe() via blk_request_module(),
and the underlying devices are virtio-blk from the fedora BZ2121791.

[1] https://bugzilla.redhat.com/show_bug.cgi?id=2121791

Thanks,
Ming

