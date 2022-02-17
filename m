Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC3E4B9BF0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 10:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238607AbiBQJX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 04:23:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237832AbiBQJX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 04:23:27 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9ED6409
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 01:23:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EABD11F37D;
        Thu, 17 Feb 2022 09:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645089791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vsms1laasN9bDNBa5Gyy927e4pwnc3wqU760PwJVFo8=;
        b=XS7lJXtjmCX+f5/hW3wFALQ3U/zpAxRjk1go/dpM9ju+q0y1niyXCfSBG61gaz59E55B4T
        FqO1vAIC+75j69i3Y+++Lu0l0MifP3wkVJKOJtjxDTOUeMF6L5ekReHSvorcSjs6ulRaz+
        hqRX1FVMIjICZYhfyHo/BcJroITwC+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645089791;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vsms1laasN9bDNBa5Gyy927e4pwnc3wqU760PwJVFo8=;
        b=fpl7+vW1PQmsiNMXxRUtpzhte9b7y/ou28/3JnfYWlrngBIMJLNgwk6Vn8Vry8cu3mYap0
        RXYO7OyesoGH26Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CC13C13BBF;
        Thu, 17 Feb 2022 09:23:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id A2XoMP8TDmKsHgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 17 Feb 2022 09:23:11 +0000
Message-ID: <8f307e8a-5f97-cf5d-0a77-1c79b05abd60@suse.cz>
Date:   Thu, 17 Feb 2022 10:23:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] mm/slab_common: use helper function is_power_of_2()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220217091609.8214-1-linmiaohe@huawei.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220217091609.8214-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/22 10:16, Miaohe Lin wrote:
> Use helper function is_power_of_2() to check if KMALLOC_MIN_SIZE is power
> of two. Minor readability improvement.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

We can try, but in case some compiler will no longer able to perform the
check at build-time (although is_power_of_2() looks sufficiently trivial
too), we'll have to revert it.

> ---
>  mm/slab_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 23f2ab0713b7..6ee64d6208b3 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -807,7 +807,7 @@ void __init setup_kmalloc_cache_index_table(void)
>  	unsigned int i;
>  
>  	BUILD_BUG_ON(KMALLOC_MIN_SIZE > 256 ||
> -		(KMALLOC_MIN_SIZE & (KMALLOC_MIN_SIZE - 1)));
> +		!is_power_of_2(KMALLOC_MIN_SIZE));
>  
>  	for (i = 8; i < KMALLOC_MIN_SIZE; i += 8) {
>  		unsigned int elem = size_index_elem(i);

