Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7476523C21
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 20:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240843AbiEKSAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 14:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345975AbiEKSA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 14:00:27 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79356FA2D
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:00:25 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id b32so3638307ljf.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=E8mjJ6/ikRW6L571DVojfVrb9ZxPwMSvTMao2Z2WwQs=;
        b=CxXImu2j0+p3LHhyN50CJeB53M+2Hb3IcMtcPocNwHtOPLHymInaRXaqIkerIMFi7H
         3AAk7OAUSRSMVl2kweGmfn7v1SUHYCFVml14xpbzHUO+LI0KCa8TC32claH6Tki5FmF9
         PzVDHN5YibHIpuwYghdy4NwMdrtdetm177DeXhXLmsteu0ZBOJmPAlovXFCUdjJLUfX6
         L2+5D8Ort7kY8A7FVQywUetv79hWfG9Vqc+nAhyefHOmAfaqZcxDdxNOreZExbSD7xgA
         OEG8Bp97wkINldw+lYKZ9J6zvn4Y7SQq8AtGS0ZZ3FBCHpJt5QfnhSruyWa1RMmeGNbL
         yRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=E8mjJ6/ikRW6L571DVojfVrb9ZxPwMSvTMao2Z2WwQs=;
        b=2AOj2259zym7Ag9lSPFLhdnAnxi1OS+oGVDnAecHaFkJso2bqVcRdP4jA83xciOUDD
         pb5JD1ACPuKO5YZ+qcwmkfSRgIyY94Uwh9FUz5pGtClKjuUPnW2H5XtXSWkrEoHqnbL+
         2xA6vB78WxcP+NgVfKI4ogJJmrFLIKcsB+Zoj3oVuPvvu+5dkjkM5or6hjZOCP/F7g2Z
         N8ohHQ+ytytWhD+3fxXWv2UHCIQjG9srun8S68MVh+Nv65hLvYeiqtrqE0lxzX9PMHva
         +GW77a0hc+K4N9O+HTlobwO7DsWl6EtPLbluPlyYDliLnNBN3279BfRNQUFHRWxa12Of
         JouQ==
X-Gm-Message-State: AOAM532a6zT+FVQayBomLaKfifdNWjefcnhWLKnd7omAqw0gDlGubtuD
        69V30dKP9fO1oFnmFFzDHIY=
X-Google-Smtp-Source: ABdhPJwEES/rkW+laUoE12K+xOg2R39+JFoCFELxlp3+devgkaiCx/4uXvllW3Tr1XtvaKaEyM0+YA==
X-Received: by 2002:a05:651c:50a:b0:24f:50a2:beda with SMTP id o10-20020a05651c050a00b0024f50a2bedamr18420964ljp.189.1652292023783;
        Wed, 11 May 2022 11:00:23 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id s9-20020a19ad49000000b0047255d21131sm382089lfd.96.2022.05.11.11.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 11:00:23 -0700 (PDT)
Subject: Re: [PATCH V2 2/7] xen/grants: support allocating consecutive grants
From:   Oleksandr <olekstysh@gmail.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
References: <1651947548-4055-1-git-send-email-olekstysh@gmail.com>
 <1651947548-4055-3-git-send-email-olekstysh@gmail.com>
Message-ID: <8409e636-94e3-e231-f181-c76a849534a1@gmail.com>
Date:   Wed, 11 May 2022 21:00:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1651947548-4055-3-git-send-email-olekstysh@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.05.22 21:19, Oleksandr Tyshchenko wrote:

Hello Boris, Stefano


> From: Juergen Gross <jgross@suse.com>
>
> For support of virtio via grant mappings in rare cases larger mappings
> using consecutive grants are needed. Support those by adding a bitmap
> of free grants.
>
> As consecutive grants will be needed only in very rare cases (e.g. when
> configuring a virtio device with a multi-page ring), optimize for the
> normal case of non-consecutive allocations.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> Changes RFC -> V1:
>     - no changes
>     
> Changes V1 -> V2:
>     - no changes


May I please ask for the review here?


This patch has been tested in various scenarios:

1. Guest with Xen PV drivers only (gnttab_alloc(free)_grant_reference() 
usage only)

2. Guest with Virtio drivers only 
(gnttab_alloc(free)_grant_reference_seq() usage only)

3. Guest with Virtio and Xen PV drivers (combined 
gnttab_alloc(free)_grant_reference() and 
gnttab_alloc(free)_grant_reference_seq() usage)


> ---
>   drivers/xen/grant-table.c | 238 +++++++++++++++++++++++++++++++++++++++-------
>   include/xen/grant_table.h |   4 +
>   2 files changed, 210 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
> index 8ccccac..1b458c0 100644
> --- a/drivers/xen/grant-table.c
> +++ b/drivers/xen/grant-table.c
> @@ -33,6 +33,7 @@
>   
>   #define pr_fmt(fmt) "xen:" KBUILD_MODNAME ": " fmt
>   
> +#include <linux/bitmap.h>
>   #include <linux/memblock.h>
>   #include <linux/sched.h>
>   #include <linux/mm.h>
> @@ -72,9 +73,32 @@
>   
>   static grant_ref_t **gnttab_list;
>   static unsigned int nr_grant_frames;
> +
> +/*
> + * Handling of free grants:
> + *
> + * Free grants are in a simple list anchored in gnttab_free_head. They are
> + * linked by grant ref, the last element contains GNTTAB_LIST_END. The number
> + * of free entries is stored in gnttab_free_count.
> + * Additionally there is a bitmap of free entries anchored in
> + * gnttab_free_bitmap. This is being used for simplifying allocation of
> + * multiple consecutive grants, which is needed e.g. for support of virtio.
> + * gnttab_last_free is used to add free entries of new frames at the end of
> + * the free list.
> + * gnttab_free_tail_ptr specifies the variable which references the start
> + * of consecutive free grants ending with gnttab_last_free. This pointer is
> + * updated in a rather defensive way, in order to avoid performance hits in
> + * hot paths.
> + * All those variables are protected by gnttab_list_lock.
> + */
>   static int gnttab_free_count;
> -static grant_ref_t gnttab_free_head;
> +static unsigned int gnttab_size;
> +static grant_ref_t gnttab_free_head = GNTTAB_LIST_END;
> +static grant_ref_t gnttab_last_free = GNTTAB_LIST_END;
> +static grant_ref_t *gnttab_free_tail_ptr;
> +static unsigned long *gnttab_free_bitmap;
>   static DEFINE_SPINLOCK(gnttab_list_lock);
> +
>   struct grant_frames xen_auto_xlat_grant_frames;
>   static unsigned int xen_gnttab_version;
>   module_param_named(version, xen_gnttab_version, uint, 0);
> @@ -170,16 +194,111 @@ static int get_free_entries(unsigned count)
>   
>   	ref = head = gnttab_free_head;
>   	gnttab_free_count -= count;
> -	while (count-- > 1)
> -		head = gnttab_entry(head);
> +	while (count--) {
> +		bitmap_clear(gnttab_free_bitmap, head, 1);
> +		if (gnttab_free_tail_ptr == __gnttab_entry(head))
> +			gnttab_free_tail_ptr = &gnttab_free_head;
> +		if (count)
> +			head = gnttab_entry(head);
> +	}
>   	gnttab_free_head = gnttab_entry(head);
>   	gnttab_entry(head) = GNTTAB_LIST_END;
>   
> +	if (!gnttab_free_count) {
> +		gnttab_last_free = GNTTAB_LIST_END;
> +		gnttab_free_tail_ptr = NULL;
> +	}
> +
>   	spin_unlock_irqrestore(&gnttab_list_lock, flags);
>   
>   	return ref;
>   }
>   
> +static int get_seq_entry_count(void)
> +{
> +	if (gnttab_last_free == GNTTAB_LIST_END || !gnttab_free_tail_ptr ||
> +	    *gnttab_free_tail_ptr == GNTTAB_LIST_END)
> +		return 0;
> +
> +	return gnttab_last_free - *gnttab_free_tail_ptr + 1;
> +}
> +
> +/* Rebuilds the free grant list and tries to find count consecutive entries. */
> +static int get_free_seq(unsigned int count)
> +{
> +	int ret = -ENOSPC;
> +	unsigned int from, to;
> +	grant_ref_t *last;
> +
> +	gnttab_free_tail_ptr = &gnttab_free_head;
> +	last = &gnttab_free_head;
> +
> +	for (from = find_first_bit(gnttab_free_bitmap, gnttab_size);
> +	     from < gnttab_size;
> +	     from = find_next_bit(gnttab_free_bitmap, gnttab_size, to + 1)) {
> +		to = find_next_zero_bit(gnttab_free_bitmap, gnttab_size,
> +					from + 1);
> +		if (ret < 0 && to - from >= count) {
> +			ret = from;
> +			bitmap_clear(gnttab_free_bitmap, ret, count);
> +			from += count;
> +			gnttab_free_count -= count;
> +			if (from == to)
> +				continue;
> +		}
> +
> +		while (from < to) {
> +			*last = from;
> +			last = __gnttab_entry(from);
> +			gnttab_last_free = from;
> +			from++;
> +		}
> +		if (to < gnttab_size)
> +			gnttab_free_tail_ptr = __gnttab_entry(to - 1);
> +	}
> +
> +	*last = GNTTAB_LIST_END;
> +	if (gnttab_last_free != gnttab_size - 1)
> +		gnttab_free_tail_ptr = NULL;
> +
> +	return ret;
> +}
> +
> +static int get_free_entries_seq(unsigned int count)
> +{
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	spin_lock_irqsave(&gnttab_list_lock, flags);
> +
> +	if (gnttab_free_count < count) {
> +		ret = gnttab_expand(count - gnttab_free_count);
> +		if (ret < 0)
> +			goto out;
> +	}
> +
> +	if (get_seq_entry_count() < count) {
> +		ret = get_free_seq(count);
> +		if (ret >= 0)
> +			goto out;
> +		ret = gnttab_expand(count - get_seq_entry_count());
> +		if (ret < 0)
> +			goto out;
> +	}
> +
> +	ret = *gnttab_free_tail_ptr;
> +	*gnttab_free_tail_ptr = gnttab_entry(ret + count - 1);
> +	gnttab_free_count -= count;
> +	if (!gnttab_free_count)
> +		gnttab_free_tail_ptr = NULL;
> +	bitmap_clear(gnttab_free_bitmap, ret, count);
> +
> + out:
> +	spin_unlock_irqrestore(&gnttab_list_lock, flags);
> +
> +	return ret;
> +}
> +
>   static void do_free_callbacks(void)
>   {
>   	struct gnttab_free_callback *callback, *next;
> @@ -206,17 +325,48 @@ static inline void check_free_callbacks(void)
>   		do_free_callbacks();
>   }
>   
> -static void put_free_entry(grant_ref_t ref)
> +static void put_free_entry_locked(grant_ref_t ref)
>   {
> -	unsigned long flags;
> -	spin_lock_irqsave(&gnttab_list_lock, flags);
>   	gnttab_entry(ref) = gnttab_free_head;
>   	gnttab_free_head = ref;
> +	if (!gnttab_free_count)
> +		gnttab_last_free = ref;
> +	if (gnttab_free_tail_ptr == &gnttab_free_head)
> +		gnttab_free_tail_ptr = __gnttab_entry(ref);
>   	gnttab_free_count++;
> +	bitmap_set(gnttab_free_bitmap, ref, 1);
> +}
> +
> +static void put_free_entry(grant_ref_t ref)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&gnttab_list_lock, flags);
> +	put_free_entry_locked(ref);
>   	check_free_callbacks();
>   	spin_unlock_irqrestore(&gnttab_list_lock, flags);
>   }
>   
> +static void gnttab_set_free(unsigned int start, unsigned int n)
> +{
> +	unsigned int i;
> +
> +	for (i = start; i < start + n - 1; i++)
> +		gnttab_entry(i) = i + 1;
> +
> +	gnttab_entry(i) = GNTTAB_LIST_END;
> +	if (!gnttab_free_count) {
> +		gnttab_free_head = start;
> +		gnttab_free_tail_ptr = &gnttab_free_head;
> +	} else {
> +		gnttab_entry(gnttab_last_free) = start;
> +	}
> +	gnttab_free_count += n;
> +	gnttab_last_free = i;
> +
> +	bitmap_set(gnttab_free_bitmap, start, n);
> +}
> +
>   /*
>    * Following applies to gnttab_update_entry_v1 and gnttab_update_entry_v2.
>    * Introducing a valid entry into the grant table:
> @@ -448,23 +598,31 @@ void gnttab_free_grant_references(grant_ref_t head)
>   {
>   	grant_ref_t ref;
>   	unsigned long flags;
> -	int count = 1;
> -	if (head == GNTTAB_LIST_END)
> -		return;
> +
>   	spin_lock_irqsave(&gnttab_list_lock, flags);
> -	ref = head;
> -	while (gnttab_entry(ref) != GNTTAB_LIST_END) {
> -		ref = gnttab_entry(ref);
> -		count++;
> +	while (head != GNTTAB_LIST_END) {
> +		ref = gnttab_entry(head);
> +		put_free_entry_locked(head);
> +		head = ref;
>   	}
> -	gnttab_entry(ref) = gnttab_free_head;
> -	gnttab_free_head = head;
> -	gnttab_free_count += count;
>   	check_free_callbacks();
>   	spin_unlock_irqrestore(&gnttab_list_lock, flags);
>   }
>   EXPORT_SYMBOL_GPL(gnttab_free_grant_references);
>   
> +void gnttab_free_grant_reference_seq(grant_ref_t head, unsigned int count)
> +{
> +	unsigned long flags;
> +	unsigned int i;
> +
> +	spin_lock_irqsave(&gnttab_list_lock, flags);
> +	for (i = count; i > 0; i--)
> +		put_free_entry_locked(head + i - 1);
> +	check_free_callbacks();
> +	spin_unlock_irqrestore(&gnttab_list_lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(gnttab_free_grant_reference_seq);
> +
>   int gnttab_alloc_grant_references(u16 count, grant_ref_t *head)
>   {
>   	int h = get_free_entries(count);
> @@ -478,6 +636,24 @@ int gnttab_alloc_grant_references(u16 count, grant_ref_t *head)
>   }
>   EXPORT_SYMBOL_GPL(gnttab_alloc_grant_references);
>   
> +int gnttab_alloc_grant_reference_seq(unsigned int count, grant_ref_t *first)
> +{
> +	int h;
> +
> +	if (count == 1)
> +		h = get_free_entries(1);
> +	else
> +		h = get_free_entries_seq(count);
> +
> +	if (h < 0)
> +		return -ENOSPC;
> +
> +	*first = h;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(gnttab_alloc_grant_reference_seq);
> +
>   int gnttab_empty_grant_references(const grant_ref_t *private_head)
>   {
>   	return (*private_head == GNTTAB_LIST_END);
> @@ -570,16 +746,13 @@ static int grow_gnttab_list(unsigned int more_frames)
>   			goto grow_nomem;
>   	}
>   
> +	gnttab_set_free(gnttab_size, extra_entries);
>   
> -	for (i = grefs_per_frame * nr_grant_frames;
> -	     i < grefs_per_frame * new_nr_grant_frames - 1; i++)
> -		gnttab_entry(i) = i + 1;
> -
> -	gnttab_entry(i) = gnttab_free_head;
> -	gnttab_free_head = grefs_per_frame * nr_grant_frames;
> -	gnttab_free_count += extra_entries;
> +	if (!gnttab_free_tail_ptr)
> +		gnttab_free_tail_ptr = __gnttab_entry(gnttab_size);
>   
>   	nr_grant_frames = new_nr_grant_frames;
> +	gnttab_size += extra_entries;
>   
>   	check_free_callbacks();
>   
> @@ -1424,7 +1597,6 @@ int gnttab_init(void)
>   	int i;
>   	unsigned long max_nr_grant_frames;
>   	unsigned int max_nr_glist_frames, nr_glist_frames;
> -	unsigned int nr_init_grefs;
>   	int ret;
>   
>   	gnttab_request_version();
> @@ -1452,6 +1624,13 @@ int gnttab_init(void)
>   		}
>   	}
>   
> +	i = gnttab_interface->grefs_per_grant_frame * max_nr_grant_frames;
> +	gnttab_free_bitmap = bitmap_zalloc(i, GFP_KERNEL);
> +	if (!gnttab_free_bitmap) {
> +		ret = -ENOMEM;
> +		goto ini_nomem;
> +	}
> +
>   	ret = arch_gnttab_init(max_nr_grant_frames,
>   			       nr_status_frames(max_nr_grant_frames));
>   	if (ret < 0)
> @@ -1462,15 +1641,9 @@ int gnttab_init(void)
>   		goto ini_nomem;
>   	}
>   
> -	nr_init_grefs = nr_grant_frames *
> -			gnttab_interface->grefs_per_grant_frame;
> -
> -	for (i = NR_RESERVED_ENTRIES; i < nr_init_grefs - 1; i++)
> -		gnttab_entry(i) = i + 1;
> +	gnttab_size = nr_grant_frames * gnttab_interface->grefs_per_grant_frame;
>   
> -	gnttab_entry(nr_init_grefs - 1) = GNTTAB_LIST_END;
> -	gnttab_free_count = nr_init_grefs - NR_RESERVED_ENTRIES;
> -	gnttab_free_head  = NR_RESERVED_ENTRIES;
> +	gnttab_set_free(NR_RESERVED_ENTRIES, gnttab_size - NR_RESERVED_ENTRIES);
>   
>   	printk("Grant table initialized\n");
>   	return 0;
> @@ -1479,6 +1652,7 @@ int gnttab_init(void)
>   	for (i--; i >= 0; i--)
>   		free_page((unsigned long)gnttab_list[i]);
>   	kfree(gnttab_list);
> +	bitmap_free(gnttab_free_bitmap);
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(gnttab_init);
> diff --git a/include/xen/grant_table.h b/include/xen/grant_table.h
> index dfd5bf3..d815e1d 100644
> --- a/include/xen/grant_table.h
> +++ b/include/xen/grant_table.h
> @@ -129,10 +129,14 @@ int gnttab_try_end_foreign_access(grant_ref_t ref);
>    */
>   int gnttab_alloc_grant_references(u16 count, grant_ref_t *pprivate_head);
>   
> +int gnttab_alloc_grant_reference_seq(unsigned int count, grant_ref_t *first);
> +
>   void gnttab_free_grant_reference(grant_ref_t ref);
>   
>   void gnttab_free_grant_references(grant_ref_t head);
>   
> +void gnttab_free_grant_reference_seq(grant_ref_t head, unsigned int count);
> +
>   int gnttab_empty_grant_references(const grant_ref_t *pprivate_head);
>   
>   int gnttab_claim_grant_reference(grant_ref_t *pprivate_head);

-- 
Regards,

Oleksandr Tyshchenko

