Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B0449BA73
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356895AbiAYRe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:34:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60272 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1588385AbiAYRdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:33:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643131981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hHrbMaICyVWZJZVuCs/Sc0unbjuRdIuWQiuze8whQJY=;
        b=Lfj+hvtBq2fAum6Ch/KcNUdzyRv+WO15P0rWIOW0bXjxcuzVhuG6JJYgld+z0yBGVJKkMZ
        DMwv0J6wQ635cLctfVece7s0tm5DohrLzE05lPr20TooKc1mTTyNBW0ET1hV9OB7ms3rMk
        2Nd2HU9mSjyBcx5W4mcRMmCvdJCmgC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-uXO9vnS6NjyFGN3gckN4iA-1; Tue, 25 Jan 2022 12:32:58 -0500
X-MC-Unique: uXO9vnS6NjyFGN3gckN4iA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00FD81006AA6;
        Tue, 25 Jan 2022 17:32:57 +0000 (UTC)
Received: from [10.22.34.217] (unknown [10.22.34.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8097E22DEB;
        Tue, 25 Jan 2022 17:32:55 +0000 (UTC)
Message-ID: <e8a62329-12d1-048a-9968-abefc978a49a@redhat.com>
Date:   Tue, 25 Jan 2022 12:32:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] scsi: bnx2fc: make bnx2fc_recv_frame mp safe
Content-Language: en-US
From:   John Meneghini <jmeneghi@redhat.com>
To:     skashyap@marvell.com, njavali@marvell.com, mlombard@redhat.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        GR-QLogic-Storage-Upstream@marvell.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20220124145110.442335-1-jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20220124145110.442335-1-jmeneghi@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can I please get a review and approval for this patch?

I'd like this to get into v5.17-rc2

Thanks,

/John


On 1/24/22 09:51, John Meneghini wrote:
>      Running tests with a debug kernel shows that bnx2fc_recv_frame is
>      modifying the per_cpu lport stats counters in a non-mpsafe way.
>      Just boot a debug kernel and run the bnx2fc driver with the hardware
>      enabled.
> 
>      [ 1391.699147] BUG: using smp_processor_id() in preemptible [00000000] code: bnx2fc_
>      [ 1391.699160] caller is bnx2fc_recv_frame+0xbf9/0x1760 [bnx2fc]
>      [ 1391.699174] CPU: 2 PID: 4355 Comm: bnx2fc_l2_threa Kdump: loaded Tainted: G    B
>      [ 1391.699180] Hardware name: HP ProLiant DL120 G7, BIOS J01 07/01/2013
>      [ 1391.699183] Call Trace:
>      [ 1391.699188]  dump_stack_lvl+0x57/0x7d
>      [ 1391.699198]  check_preemption_disabled+0xc8/0xd0
>      [ 1391.699205]  bnx2fc_recv_frame+0xbf9/0x1760 [bnx2fc]
>      [ 1391.699215]  ? do_raw_spin_trylock+0xb5/0x180
>      [ 1391.699221]  ? bnx2fc_npiv_create_vports.isra.0+0x4e0/0x4e0 [bnx2fc]
>      [ 1391.699229]  ? bnx2fc_l2_rcv_thread+0xb7/0x3a0 [bnx2fc]
>      [ 1391.699240]  bnx2fc_l2_rcv_thread+0x1af/0x3a0 [bnx2fc]
>      [ 1391.699250]  ? bnx2fc_ulp_init+0xc0/0xc0 [bnx2fc]
>      [ 1391.699258]  kthread+0x364/0x420
>      [ 1391.699263]  ? _raw_spin_unlock_irq+0x24/0x50
>      [ 1391.699268]  ? set_kthread_struct+0x100/0x100
>      [ 1391.699273]  ret_from_fork+0x22/0x30
> 
>      To fix the problem: restore the old get_cpu/put_cpu code with some
>      modifications to reduce the size of the critical section.
> 
> Fixes: d576a5e80cd0 ("bnx2fc: Improve stats update mechanism")
> Tested-by: Guangwu Zhang <guazhang@redhat.com>
> Signed-off-by: John Meneghini <jmeneghi@redhat.com>
> ---
>   drivers/scsi/bnx2fc/bnx2fc_fcoe.c | 21 +++++++++++++--------
>   1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
> index 71fa62bd3083..e41a94dc2d1f 100644
> --- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
> +++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
> @@ -508,7 +508,8 @@ static int bnx2fc_l2_rcv_thread(void *arg)
>   
>   static void bnx2fc_recv_frame(struct sk_buff *skb)
>   {
> -	u32 fr_len;
> +	u64 crc_err;
> +	u32 fr_len, fr_crc;
>   	struct fc_lport *lport;
>   	struct fcoe_rcv_info *fr;
>   	struct fc_stats *stats;
> @@ -542,6 +543,11 @@ static void bnx2fc_recv_frame(struct sk_buff *skb)
>   	skb_pull(skb, sizeof(struct fcoe_hdr));
>   	fr_len = skb->len - sizeof(struct fcoe_crc_eof);
>   
> +	stats = per_cpu_ptr(lport->stats, get_cpu());
> +	stats->RxFrames++;
> +	stats->RxWords += fr_len / FCOE_WORD_TO_BYTE;
> +	put_cpu();
> +
>   	fp = (struct fc_frame *)skb;
>   	fc_frame_init(fp);
>   	fr_dev(fp) = lport;
> @@ -624,16 +630,15 @@ static void bnx2fc_recv_frame(struct sk_buff *skb)
>   		return;
>   	}
>   
> -	stats = per_cpu_ptr(lport->stats, smp_processor_id());
> -	stats->RxFrames++;
> -	stats->RxWords += fr_len / FCOE_WORD_TO_BYTE;
> +	fr_crc = le32_to_cpu(fr_crc(fp));
>   
> -	if (le32_to_cpu(fr_crc(fp)) !=
> -			~crc32(~0, skb->data, fr_len)) {
> -		if (stats->InvalidCRCCount < 5)
> +	if (unlikely(fr_crc != ~crc32(~0, skb->data, fr_len))) {
> +		stats = per_cpu_ptr(lport->stats, get_cpu());
> +		crc_err = (stats->InvalidCRCCount++);
> +		put_cpu();
> +		if (crc_err < 5)
>   			printk(KERN_WARNING PFX "dropping frame with "
>   			       "CRC error\n");
> -		stats->InvalidCRCCount++;
>   		kfree_skb(skb);
>   		return;
>   	}

