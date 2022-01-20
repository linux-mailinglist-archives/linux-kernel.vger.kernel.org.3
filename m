Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C55494CA6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 12:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiATLS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:18:28 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:39116 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiATLSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:18:25 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 92BE3218A9;
        Thu, 20 Jan 2022 11:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642677504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d8VO0ro5++eVxYPby3+L4F01fUksoPWmYpmpbS50Btk=;
        b=nuvuzlBVkYDxr2xgcBnJJiv47ULnPtdRTDJScmiMOA8+bNYz8tWoANqYonVXzt4soCYFrK
        +/jLJxWE56mdhnq1q+62Zw/5zOjz7ksITJrIeLbJdbhfzzK8wn4/sBB/6KUEnTOf5cj7G4
        b1X1qXujMdoGKFuHdMhXOwJAVF1wau4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642677504;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d8VO0ro5++eVxYPby3+L4F01fUksoPWmYpmpbS50Btk=;
        b=o/YDxOoqxKLCyAgRaLIyLdzQLNJAPwzZkHyjn/gD5o0DZnCJU+JSia1+osg7H6mZ385V6a
        BmCE59UmpQyevtBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 857CD13E46;
        Thu, 20 Jan 2022 11:18:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dewfIABF6WFKPwAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 20 Jan 2022 11:18:24 +0000
Subject: Re: [PATCH 2/2] block: hold queue lock while iterating in
 diskstats_show
To:     Daniel Wagner <dwagner@suse.de>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20220120105248.117025-1-dwagner@suse.de>
 <20220120105248.117025-3-dwagner@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <bcd9ee08-d751-84f4-7334-b107ee3ca294@suse.de>
Date:   Thu, 20 Jan 2022 12:18:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220120105248.117025-3-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/22 11:52 AM, Daniel Wagner wrote:
> The request queues can be freed while we operate on them. Make sure we
> hold a reference when using blk_mq_queue_tag_busy_iter.
> 
> RIP: blk_mq_queue_tag_busy_iter
> Call Trace:
>  ? blk_mq_hctx_mark_pending
>  ? diskstats_show
>  ? blk_mq_hctx_mark_pending
>  blk_mq_in_flight
>  diskstats_show
>  ? klist_next
>  seq_read
>  proc_reg_read
>  vfs_read
>  ksys_read
>  do_syscall_64
>  entry_SYSCALL_64_after_hwframe
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  block/genhd.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index c9d4386dd177..0e163055a4e6 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1167,10 +1167,13 @@ static int diskstats_show(struct seq_file *seqf, void *v)
>  		if (bdev_is_partition(hd) && !bdev_nr_sectors(hd))
>  			continue;
>  		part_stat_read_all(hd, &stat);
> +		if (blk_queue_enter(gp->queue, BLK_MQ_REQ_NOWAIT))
> +			continue;
>  		if (queue_is_mq(gp->queue))
>  			inflight = blk_mq_in_flight(gp->queue, hd);
>  		else
>  			inflight = part_in_flight(hd);
> +		blk_queue_exit(gp->queue);
>  
>  		seq_printf(seqf, "%4d %7d %pg "
>  			   "%lu %lu %lu %u "
> 
While this looks good, it seems to have been cut against an earlier
branch; the code in question looks different in my copy.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
