Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D496552DF9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348817AbiFUJJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348736AbiFUJJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:09:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 444B1A45E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655802594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p6YYqoeBYUlu/VJufYNPYGtqIyaJ1M+ZkJJuqhZoIco=;
        b=buxwxhJ2HnOB3Nwo8otDSl47pX6cJ3lKQygPquU8hFCnEwSKbEQRNCtxIY1COMeEMusDQp
        4Iou0/W7hQhq8P2XT05OdisJNvI/KBG+JfU8spFiZhqkcDIGZ1GTyL2zR8j5BZi4QSWS2P
        bt8jpDogaBaSazHOpOreZfrH3VcdYzQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-359-unZr_BQmMVuHXRPADCDddQ-1; Tue, 21 Jun 2022 05:09:53 -0400
X-MC-Unique: unZr_BQmMVuHXRPADCDddQ-1
Received: by mail-wm1-f72.google.com with SMTP id k32-20020a05600c1ca000b0039c4cf75023so8150576wms.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=p6YYqoeBYUlu/VJufYNPYGtqIyaJ1M+ZkJJuqhZoIco=;
        b=jdIInuqWLA5nWp8ys3CiyeKN9vw/THBol8wPcD4/pwXrbS/J9mQUj16BGYPB3uGbLn
         JPTGA5dag2d/7UgqXO6AkPFVVI7sh3H4B9RYFtOXluLbLhwa/t9gd1e5WYMsCaH3wkUl
         FIlen0VxvUMlpjfeQsWdzZcREPpaNOY9ss3LW9C+O+LOgEZ30vnXo4/ScyXh8AHvLcsy
         ERg9b5xk+k9yG+58mMJACuJBZitsgOLkXE2SZmFi+YWX3p3EyDsoJHWpsyQfW8hGVQoA
         KzJA+9UsYjeprwTqkWLL8ughFu73VbCiXHcss8fd+PGq3S+7lV8TjztmG7A5CBnqtbv8
         8MfA==
X-Gm-Message-State: AJIora9xTnfrnQNiHgpc/WduNspc+xKwmZrgqix25uvGL8qLTbrEyJQa
        jssPKxnw609uK7uUGH2r0Y6Rtk9LhyrVenb5EFq3hm9cHyM4JxDURXY8yK0/Z3f+SAceNwQGfAN
        MEN6OeqVhB+4TBCSFTNMCVGZY
X-Received: by 2002:adf:eecd:0:b0:21b:7f2d:47bd with SMTP id a13-20020adfeecd000000b0021b7f2d47bdmr19757779wrp.26.1655802592043;
        Tue, 21 Jun 2022 02:09:52 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tDQqiFdsiM0RmmM6T7X/6TbXNmyK6Rjm0rXyvCFabqXryy8DMxqQmhHjyF/YbQWw5GjbYaEw==
X-Received: by 2002:adf:eecd:0:b0:21b:7f2d:47bd with SMTP id a13-20020adfeecd000000b0021b7f2d47bdmr19757755wrp.26.1655802591829;
        Tue, 21 Jun 2022 02:09:51 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f04:2500:cdb0:9b78:d423:43f? (p200300d82f042500cdb09b78d423043f.dip0.t-ipconnect.de. [2003:d8:2f04:2500:cdb0:9b78:d423:43f])
        by smtp.gmail.com with ESMTPSA id y16-20020a5d6150000000b0021b932de5d6sm3880603wrt.39.2022.06.21.02.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 02:09:51 -0700 (PDT)
Message-ID: <f7e9b2a7-9ec8-3922-ee06-eea0e26a26dd@redhat.com>
Date:   Tue, 21 Jun 2022 11:09:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] maple_tree: Make mas_prealloc() error checking more
 generic
Content-Language: en-US
To:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220615174213.738849-1-Liam.Howlett@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220615174213.738849-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.06.22 19:42, Liam Howlett wrote:
> Return the error regardless of what it is.  This is a safer option.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  lib/maple_tree.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index f413b6f0da2b..89ff5ef7ee28 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5670,16 +5670,15 @@ void mas_store_prealloc(struct ma_state *mas, void *entry)
>   */
>  int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
>  {
> -
>  	mas_set_alloc_req(mas, 1 + mas_mt_height(mas) * 3);
>  	mas_alloc_nodes(mas, gfp);
> -	if (likely(mas->node != MA_ERROR(-ENOMEM)))
> +	if (likely(!mas_is_err(mas)))
>  		return 0;
>  
>  	mas_set_alloc_req(mas, 0);
>  	mas_destroy(mas);
>  	mas->node = MAS_START;
> -	return -ENOMEM;
> +	return xa_err(mas->node);
>  }
>  
>  /*

Liam, (as asked privately before, I was just too busy to respond :) )
once all known issues are fixed, can we have a new version posted to
ease review? That would make my life easier to see what needs review and
in which order patches apply. Thanks!

-- 
Thanks,

David / dhildenb

