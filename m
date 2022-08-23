Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A5E59E868
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343928AbiHWRED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343790AbiHWRBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:01:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A461313E36
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 07:08:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5DC9E1F8FF;
        Tue, 23 Aug 2022 14:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661263738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qqt+sqPfQ5YZMyDpqRmx3/6lQYTEzFiEGh9Y/BPZ7oo=;
        b=tSjKqvrTKocvq6Ylkq3q678K3+RuzZy1LqQ+Tzu7rWhrbJIZ3lUEYbE+TaqPz+UnptO6fe
        gITrAy1pOEdpca1l/xVR8Cwz6DODiRJ6FuFTVRvdOhsig4WpOuSbSj9xMUD8FMQQo+MWP4
        174oM7DibqY0+fa0HXhaCt7pzyKtsxw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661263738;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qqt+sqPfQ5YZMyDpqRmx3/6lQYTEzFiEGh9Y/BPZ7oo=;
        b=CvyHJyKm8vmChdO4dt4xvi7pyckLkFDrGvCgONpTO312QxH6+nlaZ1KVWtV+z84D3FlxBM
        pA4vQy39x/rbRACg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0479A13AB7;
        Tue, 23 Aug 2022 14:08:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jed6OnnfBGO5dwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 23 Aug 2022 14:08:57 +0000
Message-ID: <42323fe6-3ac1-4dff-cf49-6e97525df837@suse.cz>
Date:   Tue, 23 Aug 2022 16:08:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH linux-next v2] mm/slub: Remove the unneeded result
 variable
Content-Language: en-US
To:     cgel.zte@gmail.com, 42.hyeyoo@gmail.com
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220822013830.199836-1-ye.xingchen@zte.com.cn>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220822013830.199836-1-ye.xingchen@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/22 03:38, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Return the value from attribute->store(s, buf, len) and
> attribute->show(s, buf) directly instead of storing it in
> another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Thanks, added to slab.git for-6.1/trivial

> ---
> v1 -> v2
> Add the whitespace between subsystem and summary in subject line.
>  mm/slub.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 6953c3367bc2..7bea010a20ff 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5852,7 +5852,6 @@ static ssize_t slab_attr_show(struct kobject *kobj,
>  {
>  	struct slab_attribute *attribute;
>  	struct kmem_cache *s;
> -	int err;
>  
>  	attribute = to_slab_attr(attr);
>  	s = to_slab(kobj);
> @@ -5860,9 +5859,7 @@ static ssize_t slab_attr_show(struct kobject *kobj,
>  	if (!attribute->show)
>  		return -EIO;
>  
> -	err = attribute->show(s, buf);
> -
> -	return err;
> +	return attribute->show(s, buf);
>  }
>  
>  static ssize_t slab_attr_store(struct kobject *kobj,
> @@ -5871,7 +5868,6 @@ static ssize_t slab_attr_store(struct kobject *kobj,
>  {
>  	struct slab_attribute *attribute;
>  	struct kmem_cache *s;
> -	int err;
>  
>  	attribute = to_slab_attr(attr);
>  	s = to_slab(kobj);
> @@ -5879,8 +5875,7 @@ static ssize_t slab_attr_store(struct kobject *kobj,
>  	if (!attribute->store)
>  		return -EIO;
>  
> -	err = attribute->store(s, buf, len);
> -	return err;
> +	return attribute->store(s, buf, len);
>  }
>  
>  static void kmem_cache_release(struct kobject *k)

