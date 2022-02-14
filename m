Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F394B557B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356063AbiBNP6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:58:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiBNP6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:58:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB8B049F97
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644854312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BwPcxG7GXfBZETSb97PgmAP5B3mSuQ1CgEvrfbrVFY8=;
        b=KL5ForjJSaUNPrjFVUKnjJ/gDDbZooF32QvNWW0T++ynTeh2HKXy0V2IlmAr6JYFyYCzG+
        xz/qXOVcYhrf1fmO7z+asBbU7fbmDbKh23wO+ZV78ihZN1KChmYVwW9go4uM3P/8MGgptT
        tbmfDn+hvbcmdae8VmhYRf+IAAQ6vGc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-vtB3X6x8ORypTR9Z9AQk0Q-1; Mon, 14 Feb 2022 10:58:31 -0500
X-MC-Unique: vtB3X6x8ORypTR9Z9AQk0Q-1
Received: by mail-wm1-f69.google.com with SMTP id n26-20020a05600c3b9a00b0037c524e6d97so2166879wms.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:58:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=BwPcxG7GXfBZETSb97PgmAP5B3mSuQ1CgEvrfbrVFY8=;
        b=jR1rtZnw4TARB9htN8Pj12rmZiBEIimNry2OGpDXnCxJoVWFHYkLzL951uhjrSvJxp
         lgJQE4mNEtJV1EDKFzySFmp2t/UfF3d+jVaoJz+8ex56OGRRh41mmpjOd/8K86ZFhJke
         +YJmCHSmMMqrSb77pbqKcTwBAYJW/fKcNmXWBrKZCT48nOT1Q1KQ5j+TWh4yMBaHe7sE
         +tCYU/HnSHveqVAZ3OXjLSMSzT7flwqSm0d5QOiHjU9MLQ9C0lmjtrtNJEaoH3EJTEDi
         jufxg7DOpLEOO7cA0pK1xqG/ukBqac/SdnMTb3SQKfA8ESXX3n9gKbfXMvXKdD19FXs8
         d3AA==
X-Gm-Message-State: AOAM530gSHVAnwJl13oSIO/ZnLlVCZyMBcA5FatZd4RMRejPPrc+xhJC
        fAXkV3EaAb12sdpOGevEAorPBHlJK3YtieQfkx8aMECgfVGAIMqLe8pJ1l1SvjvVQkjGWfnzD+8
        1eyMGTqRcuzAo5d4I8GI0rjTP
X-Received: by 2002:a5d:56c7:: with SMTP id m7mr197256wrw.719.1644854310402;
        Mon, 14 Feb 2022 07:58:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyU+wMnrU8uKiQ9kc0i00+FPg/8JDT0Ak/u/4ssrO2toCkdRLScwxXwHmexchmtJvcAvxx9VQ==
X-Received: by 2002:a5d:56c7:: with SMTP id m7mr197239wrw.719.1644854310068;
        Mon, 14 Feb 2022 07:58:30 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:5400:d8a3:8885:3275:4529? (p200300cbc7075400d8a3888532754529.dip0.t-ipconnect.de. [2003:cb:c707:5400:d8a3:8885:3275:4529])
        by smtp.gmail.com with ESMTPSA id v18sm25852909wrm.105.2022.02.14.07.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 07:58:29 -0800 (PST)
Message-ID: <0a85d63e-8f51-4aaf-1b8e-c323f496cba7@redhat.com>
Date:   Mon, 14 Feb 2022 16:58:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: circular locking splat in fs/proc/vmcore.c
Content-Language: en-US
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org
References: <yt9dee4579sc.fsf@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <yt9dee4579sc.fsf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.02.22 16:22, Sven Schnelle wrote:
> Hi David,
> 
> i've seen the following lockdep splat in CI on one of our systems:
> 
> [   25.964518] kdump[727]: saving vmcore-dmesg.txt complete
> [   26.049877]
> [   26.049879] ======================================================
> [   26.049881] WARNING: possible circular locking dependency detected
> [   26.049883] 5.17.0-20220211.rc3.git2.2636bbc7cadf.300.fc35.s390x+debug #1 Tainted: G        W
> [   26.049885] ------------------------------------------------------
> [   26.049886] makedumpfile/730 is trying to acquire lock:
> [   26.049887] 0000000001a25720 (vmcore_cb_rwsem){.+.+}-{3:3}, at: mmap_vmcore+0x148/0x458
> [   26.049896]
> [   26.049896] but task is already holding lock:
> [   26.049897] 0000000013539d28 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0x8e/0x170
> [   26.049904]
> [   26.049904] which lock already depends on the new lock.
> [   26.049904]
> [   26.049906]
> [   26.049906] the existing dependency chain (in reverse order) is:
> [   26.049907]
> [   26.049907] -> #1 (&mm->mmap_lock){++++}-{3:3}:
> [   26.049910]        __lock_acquire+0x604/0xbd8
> [   26.049914]        lock_acquire.part.0+0xe2/0x250
> [   26.049916]        lock_acquire+0xb0/0x200
> [   26.049918]        __might_fault+0x70/0xa0
> [   26.049921]        copy_to_user_real+0x8e/0xf8
> [   26.049925]        copy_oldmem_page+0xc0/0x158
> [   26.049930]        read_from_oldmem.part.0+0x14c/0x1b8
> [   26.049932]        __read_vmcore+0x116/0x1f8
> [   26.049933]        proc_reg_read+0x9a/0xf0
> [   26.049938]        vfs_read+0x94/0x1a8
> [   25.973256] kdump[729]: saving vmcore
> [   26.049941]        __s390x_sys_pread64+0x90/0xc8
> [   26.049958]        __do_syscall+0x1da/0x208
> [   26.049963]        system_call+0x82/0xb0
> [   26.049967]
> [   26.049967] -> #0 (vmcore_cb_rwsem){.+.+}-{3:3}:
> [   26.049971]        check_prev_add+0xe0/0xed8
> [   26.049972]        validate_chain+0x736/0xb20
> [   26.049974]        __lock_acquire+0x604/0xbd8
> [   26.049976]        lock_acquire.part.0+0xe2/0x250
> [   26.049978]        lock_acquire+0xb0/0x200
> [   26.049980]        down_read+0x5e/0x180
> [   26.049982]        mmap_vmcore+0x148/0x458
> [   26.049983]        proc_reg_mmap+0x8e/0xe0
> [   26.049985]        mmap_region+0x412/0x668
> [   26.049988]        do_mmap+0x3ec/0x4d0
> [   26.049989]        vm_mmap_pgoff+0xd4/0x170
> [   26.049992]        ksys_mmap_pgoff+0x1d8/0x228
> [   26.049994]        __s390x_sys_old_mmap+0xa4/0xb8
> [   26.049995]        __do_syscall+0x1da/0x208
> [   26.049997]        system_call+0x82/0xb0
> [   26.049999]
> [   26.049999] other info that might help us debug this:
> [   26.049999]
> [   26.050001]  Possible unsafe locking scenario:
> [   26.050001]
> [   26.050002]        CPU0                    CPU1
> [   26.050003]        ----                    ----
> [   26.050004]   lock(&mm->mmap_lock);
> [   26.050006]                                lock(vmcore_cb_rwsem);
> [   26.050008]                                lock(&mm->mmap_lock);
> [   26.050010]   lock(vmcore_cb_rwsem);
> [   26.050012]
> [   26.050012]  *** DEADLOCK ***
> [   26.050012]
> [   26.050013] 1 lock held by makedumpfile/730:
> [   26.050015]  #0: 0000000013539d28 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0x8e/0x170
> 
> I think this was introduced with cc5f2704c934 ("proc/vmcore: convert
> oldmem_pfn_is_ram callback to more generic vmcore callbacks")
> 
> One fix might be to move the vmcore_cb_rwsem into the loop around the
> pfn_is_ram(). But this would likely slow down things. So the diff would
> look like: (UNTESTED)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 702754dd1daf..4acd91507d21 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -133,6 +133,7 @@ ssize_t read_from_oldmem(char *buf, size_t count,
>  	unsigned long pfn, offset;
>  	size_t nr_bytes;
>  	ssize_t read = 0, tmp;
> +	int is_ram;
>  
>  	if (!count)
>  		return 0;
> @@ -140,7 +141,6 @@ ssize_t read_from_oldmem(char *buf, size_t count,
>  	offset = (unsigned long)(*ppos % PAGE_SIZE);
>  	pfn = (unsigned long)(*ppos / PAGE_SIZE);
>  
> -	down_read(&vmcore_cb_rwsem);
>  	do {
>  		if (count > (PAGE_SIZE - offset))
>  			nr_bytes = PAGE_SIZE - offset;
> @@ -148,7 +148,10 @@ ssize_t read_from_oldmem(char *buf, size_t count,
>  			nr_bytes = count;
>  
>  		/* If pfn is not ram, return zeros for sparse dump files */
> -		if (!pfn_is_ram(pfn)) {
> +		down_read(&vmcore_cb_rwsem);
> +		is_ram = pfn_is_ram(pfn);
> +		up_read(&vmcore_cb_rwsem);
> +		if (!is_ram) {
>  			tmp = 0;
>  			if (!userbuf)
>  				memset(buf, 0, nr_bytes);
> @@ -164,10 +167,8 @@ ssize_t read_from_oldmem(char *buf, size_t count,
>  				tmp = copy_oldmem_page(pfn, buf, nr_bytes,
>  						       offset, userbuf);
>  		}
> -		if (tmp < 0) {
> -			up_read(&vmcore_cb_rwsem);
> +		if (tmp < 0)
>  			return tmp;
> -		}
>  
>  		*ppos += nr_bytes;
>  		count -= nr_bytes;
> @@ -177,7 +178,6 @@ ssize_t read_from_oldmem(char *buf, size_t count,
>  		offset = 0;
>  	} while (count);
>  
> -	up_read(&vmcore_cb_rwsem);
>  	return read;
>  }
>  
> I think we could also switch the list to an rcu protected list, but i
> don't know the code really. Any opinions how to fix this?
> 

Hi Sven,

did you stumble over

https://lkml.kernel.org/r/20220119193417.100385-1-david@redhat.com

yet?

It should be fixing the (mostly impossible to trigger) splat you've seen
--  via sleepable rcu :)

The fix is scheduled for v5.18.

-- 
Thanks,

David / dhildenb

