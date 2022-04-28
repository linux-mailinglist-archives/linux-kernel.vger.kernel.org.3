Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFFF5133D3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 14:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346362AbiD1Mil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 08:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346309AbiD1Mid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 08:38:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2DD434654
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 05:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651149317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nGWQ6H7zY//+ePLV7y3mXzYy2j68sneKy+Fe3Uh+WKw=;
        b=KNJ2Li3Q0wGUwR1JyctR0IuE7Nf0kPkYFnk952XcFk1+Y5yM6hbCvb0d4is4MHUm6a8AjC
        xx3L8nuDjJCPzf2CGmnuBkeO+AN9GPlvcjKZaCVB/ylTIJTe25/gIX2Z524ZJITgBull5V
        o1P2iXN/Fc1gl3PDhvrOD69VI6TfEaU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-41-yqziudmhPyeZSGEbbiVmCw-1; Thu, 28 Apr 2022 08:35:15 -0400
X-MC-Unique: yqziudmhPyeZSGEbbiVmCw-1
Received: by mail-ej1-f71.google.com with SMTP id sd16-20020a1709076e1000b006f3c9ec53f6so2840271ejc.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 05:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=nGWQ6H7zY//+ePLV7y3mXzYy2j68sneKy+Fe3Uh+WKw=;
        b=vaD1NtPVgzHV24nERjngkIIYt608kZmAVCSctrzXzECYHiaw4DT86udypamlek50rZ
         NdLPD4UNy/HHGV+tmoO7RtENwHAJYofvkPC8o5xWUz2zB6BgP0fR/1iL/2xxf3k5Pg2f
         nDeAqY8FZ++RzCVwpLFMi9RXCA7CaQNendbHQLuK4CTJwdZ1/ePtvtvDq9uVn2yNq8iL
         WHPRKPgPgKyR6L8P3sNEetZQSzLAVd4UPbsBMhGofvCcHMR/IcP5n3xUOYKWuKn/2HrB
         zu/ejKs59Wtb+5bMRIpz8sUve9x6GuyxChJiF66SPvaiK2Gvj44/KWPtf15sqdaU/iAy
         nMHQ==
X-Gm-Message-State: AOAM530MighVr914Nt3BjpbCCl/wt1WCDZZjnsoHNYAFNNdF0ecwqMgm
        thtYv3/mGFV5rbPOmHWuoX69GXI68evBaz5nuVpv9T8VdCrfLIAi3p5etMHKofHnsZBKEcpc4Nl
        z4Go8VzneA6dK3MYhsJrkPio3
X-Received: by 2002:aa7:cd0a:0:b0:425:bc13:4ccb with SMTP id b10-20020aa7cd0a000000b00425bc134ccbmr34085909edw.229.1651149314522;
        Thu, 28 Apr 2022 05:35:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5fl50Q/sAa6D8th7Nk6LW9E3kVKKq1obRR9aikELreRwxgNIJHimE11UjYQ7ynsMj1mw9zQ==
X-Received: by 2002:aa7:cd0a:0:b0:425:bc13:4ccb with SMTP id b10-20020aa7cd0a000000b00425bc134ccbmr34085879edw.229.1651149314257;
        Thu, 28 Apr 2022 05:35:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:ef00:7443:a23c:26b8:b96? (p200300cbc708ef007443a23c26b80b96.dip0.t-ipconnect.de. [2003:cb:c708:ef00:7443:a23c:26b8:b96])
        by smtp.gmail.com with ESMTPSA id su22-20020a17090703d600b006f3a97cda9esm4579895ejb.18.2022.04.28.05.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 05:35:12 -0700 (PDT)
Message-ID: <7946f6ca-fe03-e286-32f9-b22ff1edb52f@redhat.com>
Date:   Thu, 28 Apr 2022 14:35:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 3/3] mm/memory_hotplug: Refactor hotadd_init_pgdat and
 try_online_node
Content-Language: en-US
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220307150725.6810-1-osalvador@suse.de>
 <20220307150725.6810-4-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220307150725.6810-4-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.03.22 16:07, Oscar Salvador wrote:
> Since we pre-allocate all nodes now, hotadd_init_pgdat() does
> not need to return a pgdat struct, as that was meant for
> __try_online_node() to check whether the node was succesfully
> allocated.
> 
> Also get rid of the __ref as all functions hotadd_init_pgdat()
> calls fall within the same section.
> 
> Also try to make more clear the return codes from __try_online_node().
> __try_online_node() can return either 0, 1 or -errno (the latter not really
> as the BUG_ON() would catch it before we return) but depending on the caller
> that has different meanings.
> For add_memory_resource(), when __try_online_node() returns non-zero,
> it means that the node was already allocated and it does not need to bring
> it up. It is fine not to check for -errno values because we do not
> get to call register_one_node() when !set_node_online.
> For those who call try_online_node(), so set_node_online is true, a value
> other than zero means a failure (e.g: cpu_up() or find_and_online_cpu_nid()).
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/memory_hotplug.c | 35 ++++++++++++++---------------------
>  1 file changed, 14 insertions(+), 21 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 07cece9e22e4..5c92ac81a399 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1161,8 +1161,7 @@ static void reset_node_present_pages(pg_data_t *pgdat)
>  	pgdat->node_present_pages = 0;
>  }
>  
> -/* we are OK calling __meminit stuff here - we have CONFIG_MEMORY_HOTPLUG */
> -static pg_data_t __ref *hotadd_init_pgdat(int nid)
> +static void hotadd_init_pgdat(int nid)
>  {
>  	struct pglist_data *pgdat = NODE_DATA(nid);
>  
> @@ -1182,8 +1181,6 @@ static pg_data_t __ref *hotadd_init_pgdat(int nid)
>  	 * to access not-initialized zonelist, build here.
>  	 */
>  	build_all_zonelists(pgdat);
> -
> -	return pgdat;
>  }
>  
>  /*
> @@ -1193,31 +1190,27 @@ static pg_data_t __ref *hotadd_init_pgdat(int nid)
>   * called by cpu_up() to online a node without onlined memory.
>   *
>   * Returns:
> - * 1 -> a new node has been allocated
> - * 0 -> the node is already online
> - * -ENOMEM -> the node could not be allocated
> + * 1 -> The node has been initialized.
> + * 0 -> Either the node was already online, or we succesfully registered a new
> + *      one.
> + * -errno -> register_one_node() failed.
>   */
>  static int __try_online_node(int nid, bool set_node_online)
>  {
> -	pg_data_t *pgdat;
> -	int ret = 1;
> +	int ret;
>  
>  	if (node_online(nid))
>  		return 0;
>  
> -	pgdat = hotadd_init_pgdat(nid);
> -	if (!pgdat) {
> -		pr_err("Cannot online node %d due to NULL pgdat\n", nid);
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> +	hotadd_init_pgdat(nid);
> +
> +	if (!set_node_online)
> +		return 1;
> +
> +	node_set_online(nid);
> +	ret = register_one_node(nid);
> +	BUG_ON(ret);
>  
> -	if (set_node_online) {
> -		node_set_online(nid);
> -		ret = register_one_node(nid);
> -		BUG_ON(ret);
> -	}
> -out:
>  	return ret;

BUG_ON(ret);
return ret;

hm? This will never return :)

So either leave the old code flow or "return 1;" I'd actually prefer the
old code flow to then "return 1;" here:

if (set_node_online) {
	node_set_online(nid);
	BUG_ON(register_one_node(nid));
}
return 1;

We can then let go of "ret".

-- 
Thanks,

David / dhildenb

