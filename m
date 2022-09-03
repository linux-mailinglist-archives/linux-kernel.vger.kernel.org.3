Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF7B5ABEB4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 13:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiICLQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 07:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiICLQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 07:16:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7780B7D780
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 04:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662203775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UBJMSkBRZTowTyH4eG/6+JTwlsQFP4f0tRt2x+lCpg4=;
        b=eiBaitA87Hf6m6ICLBJbw0iEB6DnFECinIQziAnFyFWRnEoyl7l02UlXhYY7o3YWDqtBe/
        nf8y6nxnZzMpSkrkMI4GPEA+NAWpvel9oybW+Vve1rlV5fSTzIsex1zLz0uV2cOTQW5fhR
        t4SmkFc4DdvHj7E5fUen3eU5KFrYzM4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449--ERg3iukP9SBb0OdKm4ZLA-1; Sat, 03 Sep 2022 07:16:12 -0400
X-MC-Unique: -ERg3iukP9SBb0OdKm4ZLA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC2AB29AA3B8;
        Sat,  3 Sep 2022 11:16:11 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A39B5492CA2;
        Sat,  3 Sep 2022 11:16:07 +0000 (UTC)
Date:   Sat, 3 Sep 2022 19:16:07 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [RFC PATCH V2 2/6] ublk_drv: refactor ublk_cancel_queue()
Message-ID: <YxM3d6VB51sbZPYV@T590>
References: <20220831155136.23434-1-ZiyangZhang@linux.alibaba.com>
 <20220831155136.23434-3-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831155136.23434-3-ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 11:51:32PM +0800, ZiyangZhang wrote:
> Assume only a few FETCH_REQ ioucmds are sent to ublk_drv, then the
> ubq_daemon exits, We have to call io_uring_cmd_done() for all ioucmds
> received so that io_uring ctx will not leak.
> 
> ublk_cancel_queue() may be called before START_DEV or after STOP_DEV,
> we decrease ubq->nr_io_ready and clear UBLK_IO_FLAG_ACTIVE so that we
> won't call io_uring_cmd_done() twice for one ioucmd to avoid UAF. Also
> clearing UBLK_IO_FLAG_ACTIVE makes the code more reasonable.
> 
> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
> ---

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

