Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50A958377E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 05:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237960AbiG1DX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 23:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbiG1DXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 23:23:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19A1454671
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658978600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v9LhRjSIf3o5u+vJMOmzrjg7t2ZrAPOj2TMz4HPmonI=;
        b=hJqahIMkLYuShzAnkzycPeq9WgriwD2bv5DRoVKpaWKpzKWZllwZ2VqxyXpLcfTPa7JbfS
        JgNRw5JV4KKoSZneFfz0TGV5gAxozQcpLcyoDDKKbqN83tKIKiG6NOcnhN5I8d/zVLKDml
        /HAlRXQSg23YRUA4a82fkmp/fwUCVmY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-91-zzHKPZ03OJCnh03EM3nw3w-1; Wed, 27 Jul 2022 23:23:17 -0400
X-MC-Unique: zzHKPZ03OJCnh03EM3nw3w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3435D3801F5C;
        Thu, 28 Jul 2022 03:23:17 +0000 (UTC)
Received: from T590 (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E462C492C3B;
        Thu, 28 Jul 2022 03:23:11 +0000 (UTC)
Date:   Thu, 28 Jul 2022 11:23:06 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the device-mapper tree with the
 block tree
Message-ID: <YuIBGvDfMk+wDG8Q@T590>
References: <20220728131459.7348fe5e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728131459.7348fe5e@canb.auug.org.au>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 01:14:59PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the device-mapper tree got a conflict in:
> 
>   drivers/md/dm.c
> 
> between commit:
> 
>   1be3479b8533 ("block: move ->bio_split to the gendisk")
> 
> from the block tree and commit:
> 
>   8b211aaccb91 ("dm: add two stage requeue mechanism")
> 
> from the device-mapper tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/md/dm.c
> index b7458f2dd3e4,47bcc5081b2b..000000000000
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@@ -962,6 -1001,58 +1001,58 @@@ static void __dm_io_complete(struct dm_
>   	}
>   }
>   
> + static void dm_wq_requeue_work(struct work_struct *work)
> + {
> + 	struct mapped_device *md = container_of(work, struct mapped_device,
> + 						requeue_work);
> + 	unsigned long flags;
> + 	struct dm_io *io;
> + 
> + 	/* reuse deferred lock to simplify dm_handle_requeue */
> + 	spin_lock_irqsave(&md->deferred_lock, flags);
> + 	io = md->requeue_list;
> + 	md->requeue_list = NULL;
> + 	spin_unlock_irqrestore(&md->deferred_lock, flags);
> + 
> + 	while (io) {
> + 		struct dm_io *next = io->next;
> + 
>  -		dm_io_rewind(io, &md->queue->bio_split);
> ++		dm_io_rewind(io, &md->disk->bio_split);

This fix looks fine.


Thanks,
Ming

