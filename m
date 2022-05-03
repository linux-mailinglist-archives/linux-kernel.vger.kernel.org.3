Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97071518C10
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241174AbiECSVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbiECSV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:21:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 096CB3EAB7
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 11:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651601875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P63ZGOtEGiivSqfcLZo0Ewf/QknQvuPiQQu+5Py7rXA=;
        b=NpX580En+Vh8jZHDpBVXYoRJsCHw49ofLO1IIBK7TJEYgN94LXPGBR/Mw+b0e+IPWwFjK4
        9zEe9TfTffDGi1iAN2tVk4SGce4C2kXIVmqNd5PQoDKToPdXSMuJ689vY7D4FlkN0EC4PN
        nTLx32tyA9YDdDRxFBwJzEvvTEu2clA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-lBbBxEX6Ph6o6Yf9pF1NvA-1; Tue, 03 May 2022 14:17:38 -0400
X-MC-Unique: lBbBxEX6Ph6o6Yf9pF1NvA-1
Received: by mail-pj1-f69.google.com with SMTP id o16-20020a17090ab89000b001d84104fc2cso1158180pjr.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 11:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=P63ZGOtEGiivSqfcLZo0Ewf/QknQvuPiQQu+5Py7rXA=;
        b=3zZgLyZnuYGy6BzuOei+amDKGn7R3s9uasznZhs76Nbo04b5xcfs2CMNp+s5s6zTU9
         ak76OUCiUUg/WNu9KUGHwY5nJVKygS3u6KldelD012p93j01DttWgFp0bxua5TpqNawd
         ObV5fKufnai36qrwNHMb5Dy7v5AL2fGb6oKfRtXE3SesuXSUPkb58WNjsn95LeC/Hmcy
         H9V6YG50G42IcTKfrxpkNj8FPHJT+V++9jT3QHTE9UMcxY7Zk19JFeQhqXHWgV16lLsY
         wQTya2DFy0zXPr6ZdAmrvOdbdXriclVPsxt6dbKQxQp22/qjPGdnPnCfBoIwwQnhB3SY
         wbUw==
X-Gm-Message-State: AOAM531KTsR4B+gQftRV6Jtq1YgStUJiHsP5P526rQ2ED8DB+f0Uv2nw
        cF/ecpbjgeW+oIzbxwnCP9pUHvtm3GvtuT9iyJufiZXiSyQQuhgV7NyAgQDjlukaerRAj4f5+br
        NvToLhIMeQPpXzFqdYkIiAGnE
X-Received: by 2002:a17:902:bf09:b0:153:99a6:55b8 with SMTP id bi9-20020a170902bf0900b0015399a655b8mr17547408plb.142.1651601857856;
        Tue, 03 May 2022 11:17:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuI7TcozKFCyPppg6x8KBz2OVqVxwFQ8U4CwwNi/frBVHhp6t110Iv+HC7VWKGZ5BO8WqnhQ==
X-Received: by 2002:a17:902:bf09:b0:153:99a6:55b8 with SMTP id bi9-20020a170902bf0900b0015399a655b8mr17547366plb.142.1651601857503;
        Tue, 03 May 2022 11:17:37 -0700 (PDT)
Received: from [10.10.69.234] ([8.34.116.185])
        by smtp.gmail.com with ESMTPSA id c21-20020aa78c15000000b0050dc7628179sm6610559pfd.83.2022.05.03.11.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 11:17:36 -0700 (PDT)
Message-ID: <383d5191-ec3f-49d6-106a-ffb33e0c3a5d@redhat.com>
Date:   Tue, 3 May 2022 20:17:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/6] drivers/base/node: cleanup register_node()
Content-Language: en-US
To:     Davidlohr Bueso <dave@stgolabs.net>, linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org, rientjes@google.com,
        yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com,
        dave.hansen@linux.intel.com, tim.c.chen@linux.intel.com,
        roman.gushchin@linux.dev, gthelen@google.com,
        a.manzanares@samsung.com, heekwon.p@samsung.com,
        gim.jongmin@samsung.com, linux-kernel@vger.kernel.org
References: <20220416053902.68517-1-dave@stgolabs.net>
 <20220416053902.68517-2-dave@stgolabs.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220416053902.68517-2-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.04.22 07:38, Davidlohr Bueso wrote:
> Trivially get rid of some unnecessary indentation.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/base/node.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index ec8bb24a5a22..6cdf25fd26c3 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -661,16 +661,16 @@ static int register_node(struct node *node, int num)
>  	node->dev.bus = &node_subsys;
>  	node->dev.release = node_device_release;
>  	node->dev.groups = node_dev_groups;
> -	error = device_register(&node->dev);
>  
> -	if (error)
> +	error = device_register(&node->dev);
> +	if (error) {
>  		put_device(&node->dev);
> -	else {
> -		hugetlb_register_node(node);
> -
> -		compaction_register_node(node);
> +		return error;
>  	}
> -	return error;
> +
> +	hugetlb_register_node(node);
> +	compaction_register_node(node);
> +	return 0;
>  }
>  
>  /**

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

