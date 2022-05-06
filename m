Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D53851D078
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 07:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389062AbiEFFLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 01:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237609AbiEFFLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 01:11:04 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B81FF5C743
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 22:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651813641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g6E1pXSuXnGJCOs9j++ophWFQwyix2hw0YWNzaJ/VKU=;
        b=TV0XJxjkXUA89kfNWpZZnsDVwc1WRpv222Wac01p1uBB/Z7rPMJaXwMUIz4zYzhelG/3no
        985KA/lDItLYaRYcZLWjeZR5nQReQxDC5V/fDeORErZdUikiGUcvJz2Fi5McIhzYVF/haM
        BQw08+qe6h2JdzHDGyMWX8Rfn3z0sQE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-3738OETYOhmEkUGeAwj4Kw-1; Fri, 06 May 2022 01:07:17 -0400
X-MC-Unique: 3738OETYOhmEkUGeAwj4Kw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 308AF803B42;
        Fri,  6 May 2022 05:07:17 +0000 (UTC)
Received: from localhost (ovpn-13-105.pek2.redhat.com [10.72.13.105])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CC584021D9;
        Fri,  6 May 2022 05:07:16 +0000 (UTC)
Date:   Fri, 6 May 2022 13:07:13 +0800
From:   Baoquan He <bhe@redhat.com>
To:     lizhe <sensor1010@163.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     vgoyal@redhat.com, dyoung@redhat.com, prudo@redhat.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] kernel/crash_core.c : remove redundant check of
 ck_cmdline
Message-ID: <YnStAT+Mudy1xslV@MiWiFi-R3L-srv>
References: <20220506043226.125611-1-sensor1010@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506043226.125611-1-sensor1010@163.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Andrew to CC list

On 05/05/22 at 09:32pm, lizhe wrote:
> At the end of get_last_crashkernel(), the judgement of ck_cmdline is
> obviously unnecessary and causes redundance, let's clean it up.
> 
> Signed-off-by: lizhe <sensor1010@163.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> Acked-by: Philipp Rudo <prudo@redhat.com>
> ---
>  kernel/crash_core.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 256cf6db573c..c232f01a2c54 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -222,9 +222,6 @@ static __init char *get_last_crashkernel(char *cmdline,
>  		p = strstr(p+1, name);
>  	}
>  
> -	if (!ck_cmdline)
> -		return NULL;
> -
>  	return ck_cmdline;
>  }
>  
> -- 
> 2.25.1
> 

