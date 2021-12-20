Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29EA447AB1A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbhLTOPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:15:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52089 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230064AbhLTOPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:15:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640009731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y2zKTjtWC8qQJKYu3OSHVKTrxYwjXDv23/M6ziEy9QE=;
        b=iI4aszeTeCfsxYo2MPHuE7d6iazNkaSNFtO1Uc9XB+sHB2e8WHUQ38qyMEvxBTaSkt2O/S
        wFXaZEtArH/MGFS1rYQcW7+BxVotHTB4+buZHdaZSdVbKy700ue3JUP3jwRZ3OENpmXkML
        9YS6PRz6uWW3xCpidVgpVUWUTDwnNxM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-tJQAhPPPOMaQ7tJBMH4Fzw-1; Mon, 20 Dec 2021 09:15:30 -0500
X-MC-Unique: tJQAhPPPOMaQ7tJBMH4Fzw-1
Received: by mail-wm1-f69.google.com with SMTP id bg20-20020a05600c3c9400b0033a9300b44bso3406653wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 06:15:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=y2zKTjtWC8qQJKYu3OSHVKTrxYwjXDv23/M6ziEy9QE=;
        b=lbar2N8B6V317ubvKq3c0O3Y9OzZ5m3yP9p29fY++5iW9eqKlv8LZVkgwIP6+ekJmi
         2upgPX4+A9/tE1T/tjc7G4UrYBAZ9aQ67wJN6PGdq3I1WBcLqCHbfciJUi8uj8Lzrbr4
         TrgD50yonbPI0HbLQuvxyPgFs7BhQGgXwAA4KQqYMxGjCiCXMmpv9pdu0rH8kKEaRJPF
         Tn2NPqrt9Y9oS+7A393FjZVPI79EfxOYdW5cakh44djbFrstm9EMZdYZVQt36nsEldRq
         VE24TQrbs28XLrTHoYmGJ1ot9CgVKwJGxoURrzaTIYr/wKM1lEuIQax3NMtOOHoqXriX
         ZTlQ==
X-Gm-Message-State: AOAM530ebRjNmfUX2I+m1thKV+/JD03EmFgNre5PykS12H/0RAtXH4nC
        2z3y43XUdVXflXhoXnLdP/AVAn8hWLTcsWHfqnPCjLqbHtU04jOwrBHKlM1MHBMDOlnW/zCwkZ7
        B80dBiE5jomTVPwDY3qZOvRlc
X-Received: by 2002:a05:6000:a:: with SMTP id h10mr10697737wrx.253.1640009729090;
        Mon, 20 Dec 2021 06:15:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWSuGqasYHOPp3mmlFqxJ/jQudcyZmnJ6sIfsR+xBpP+qxTnyJAkzE0f8+hWR1mHzSiS95Xg==
X-Received: by 2002:a05:6000:a:: with SMTP id h10mr10697726wrx.253.1640009728805;
        Mon, 20 Dec 2021 06:15:28 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6403.dip0.t-ipconnect.de. [91.12.100.3])
        by smtp.gmail.com with ESMTPSA id u14sm16403601wrf.39.2021.12.20.06.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 06:15:28 -0800 (PST)
Message-ID: <32103255-7eba-08c1-8ab8-0730486332c1@redhat.com>
Date:   Mon, 20 Dec 2021 15:15:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Eric Ren <renzhengeek@gmail.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, vbabka@suse.cz, ziy@nvidia.com
References: <e60a66f60c059237bbf5cec3623c162a1bb1cbcb.1640005703.git.renzhen.rz@alibaba-inc.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2] virtio_mem: fix panic on mb_states indexing overflow
In-Reply-To: <e60a66f60c059237bbf5cec3623c162a1bb1cbcb.1640005703.git.renzhen.rz@alibaba-inc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.12.21 14:18, Eric Ren wrote:
> `mb_id` is unsigned integer, which is used to index
> `mb_states` array in reverse order. `mb_id` can decrease
> to `0UL - 1` that is a very large number, causing invalid
> address access.

Hi Eric,

thanks for your report!

The only way I can see this happening would be if

next_mb_id == 0, in which case we would get

	_mb_id = _vm->sbm.next_mb_id - 1
	-> _mb_id = 0 - 1 = -1ULL

Otherwise we should always stay above _vm->sbm.first_mb_id.

Am I correct or am I missing something?


But in that case we would have to have
	vm->sbm.first_mb_id == 0

and consequently the start address of the device would have to be at
address 0.

... but that does sound very weird, especially on x86_64?

Do you have details about the device layout / position in guest physical
address space?

virtio_mem_bbm_for_each_bb_rev() would need a similar fix.


> 
> The calltrace is like below:
> ```
> [  286.344977] BUG: unable to handle page fault for address: ffffa95180cf8fff
> [  286.345800] #PF: supervisor read access in kernel mode
> [  286.346738] #PF: error_code(0x0000) - not-present page
> [  286.347440] PGD 1000067 P4D 1000067 PUD 138c067 PMD 1840435067 PTE 0
> [  286.348156] Oops: 0000 [#1] SMP PTI                                                        [  286.348556] CPU: 1 PID: 122 Comm: kworker/1:2 Tainted: G           OE
> ...
> [  286.350740] Workqueue: events_freezable virtio_mem_run_wq [virtio_mem]
> [  286.351605] RIP: 0010:virtio_mem_unplug_request+0x418/0x890 [virtio_mem]
> [  286.352519] Code: 0f 87 fc 00 00 00 4a 63 54 ac 30 48 83 bc d5 f8 00 00 00 00 48 89 d0 0f 8
> 4 e5 00 00 00 48 8b b5 38 01 00 00 4c 89 e2 48 29 ca <0f> b6 34 16 39 c6 75 c7 40 80 fe 02 0f
> 82 a4 01 00 00 40 80 fe 03
> [  286.355030] RSP: 0018:ffffa95181c4bd50 EFLAGS: 00010286
> [  286.355737] RAX: 0000000000000005 RBX: 0000000000006100 RCX: 0000000000000000
> [  286.356752] RDX: ffffffffffffffff RSI: ffffa95180cf9000 RDI: ffff8e5dc393b348
> [  286.357649] RBP: ffff8e5dc393b200 R08: ffff8e463cd2b610 R09: 0000000000000021
> [  286.358627] R10: ffffa95181c4bcd0 R11: ffffa95181c4baa0 R12: ffffffffffffffff
> [  286.359617] R13: 0000000000000003 R14: ffff8e5dc393b348 R15: 00000000fffffff0
> [  286.360503] FS:  0000000000000000(0000) GS:ffff8e463cd00000(0000) knlGS:0000000000000000
> [  286.361532] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  286.362229] CR2: ffffa95180cf8fff CR3: 0000001846234000 CR4: 00000000000006e0
> [  286.363168] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  286.364162] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  286.365054] Call Trace:
> [  286.365431]  ? virtio_mem_run_wq+0x5a4/0x870 [virtio_mem]
> [  286.366132]  ? __schedule+0x4b3/0x800
> [  286.366547]  ? process_one_work+0x18b/0x350
> [  286.367041]  ? worker_thread+0x4f/0x3a0
> [  286.367675]  ? rescuer_thread+0x350/0x350
> [  286.368234]  ? kthread+0xfa/0x130
> [  286.368605]  ? kthread_create_worker_on_cpu+0x70/0x70
> [  286.369155]  ? ret_from_fork+0x1f/0x30
> ```
> 
> Fixes by also checking its up boundary.
> 
> Signed-off-by: Eric Ren <renzhengeek@gmail.com>
> --
> v2: Correct the SOB
>     Use _vm and remove duplicated spaces
> ---
>  drivers/virtio/virtio_mem.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 96e5a8782769..f1ba0dadd47a 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -486,7 +486,9 @@ static int virtio_mem_sbm_mb_states_prepare_next_mb(struct virtio_mem *vm)
>  
>  #define virtio_mem_sbm_for_each_mb_rev(_vm, _mb_id, _state) \
>  	for (_mb_id = _vm->sbm.next_mb_id - 1; \
> -	     _mb_id >= _vm->sbm.first_mb_id && _vm->sbm.mb_count[_state]; \
> +	     _mb_id >= _vm->sbm.first_mb_id && \
> +	     _mb_id < _vm->sbm.next_mb_id && \
> +	     _vm->sbm.mb_count[_state]; \
>  	     _mb_id--) \
>  		if (virtio_mem_sbm_get_mb_state(_vm, _mb_id) == _state)
>  


-- 
Thanks,

David / dhildenb

