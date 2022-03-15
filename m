Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FF44D9DC9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 15:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348996AbiCOOjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 10:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244213AbiCOOjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:39:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B107B55231
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 07:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647355100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oIP9eWTq1MZaXmiOhkKg9VYEpBhdJtYGb5hpV7ZOjz8=;
        b=Q4kLC5IX3BjQrHNoRawbNw3Bmvhm/FU0oz6Iz+gNnlpCPrOnH/BRMMf1ttHPpewjRMbVPw
        SXiV493t5wYfjC8RmxfTjJQ2JmHRCwQfrptMVIc/b5O+nnsDPbgqAbkaC2n668CukBY3wd
        nAi7qP/9bbCr9LaWmud17ljHYPVpdmI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-mOGPsvbkMpqlRSkpcsHQfQ-1; Tue, 15 Mar 2022 10:38:19 -0400
X-MC-Unique: mOGPsvbkMpqlRSkpcsHQfQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E249438008A2;
        Tue, 15 Mar 2022 14:38:18 +0000 (UTC)
Received: from T590 (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 80DADC28100;
        Tue, 15 Mar 2022 14:38:11 +0000 (UTC)
Date:   Tue, 15 Mar 2022 22:38:05 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     damien.lemoal@opensource.wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, bvanassche@acm.org, hch@lst.de,
        hare@suse.de, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.wilck@suse.com
Subject: Re: [PATCH 1/2] scsi: core: Fix sbitmap depth in
 scsi_realloc_sdev_budget_map()
Message-ID: <YjCkzSDc6HQ6hhKR@T590>
References: <1647340746-17600-1-git-send-email-john.garry@huawei.com>
 <1647340746-17600-2-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1647340746-17600-2-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 06:39:05PM +0800, John Garry wrote:
> In commit edb854a3680b ("scsi: core: Reallocate device's budget map on
> queue depth change"), the sbitmap for the device budget map may be
> reallocated after the slave device depth is configured.
> 
> When the sbitmap is reallocated we use the result from
> scsi_device_max_queue_depth() for the sbitmap size, but don't resize to
> match the actual device queue depth.
> 
> Fix by resizing the sbitmap after reallocating the budget sbitmap.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/scsi/scsi_scan.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
> index f4e6c68ac99e..2ef78083f1ef 100644
> --- a/drivers/scsi/scsi_scan.c
> +++ b/drivers/scsi/scsi_scan.c
> @@ -223,6 +223,8 @@ static int scsi_realloc_sdev_budget_map(struct scsi_device *sdev,
>  	int ret;
>  	struct sbitmap sb_backup;
>  
> +	depth = min_t(unsigned int, depth, scsi_device_max_queue_depth(sdev));
> +
>  	/*
>  	 * realloc if new shift is calculated, which is caused by setting
>  	 * up one new default queue depth after calling ->slave_configure
> @@ -245,6 +247,9 @@ static int scsi_realloc_sdev_budget_map(struct scsi_device *sdev,
>  				scsi_device_max_queue_depth(sdev),
>  				new_shift, GFP_KERNEL,
>  				sdev->request_queue->node, false, true);
> +	if (!ret)
> +		sbitmap_resize(&sdev->budget_map, depth);
> +

Looks fine, 

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

