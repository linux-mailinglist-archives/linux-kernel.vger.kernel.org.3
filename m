Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1545351CCA5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 01:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386683AbiEEXXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 19:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386686AbiEEXXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 19:23:00 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A844606E5
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651792755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ItiPDp2je/Kp/U+WrNcavPKDbIiJIWhg9WRpKTS0IW0=;
        b=ByOWqq9/lUTKl32JtxPshFoXfI3ATyxzMzM6CJPrZhqIwOPL+GgtjCnvx3LCmwxNl49CKu
        twKhCY/a4Vj2Z2kfHrZAq8IJee+4KBGmcS49wR1XRgJ9gbqWgF5xDwPjwFuBQ+TXpMKHKK
        jbYRCm7I86mwPJZp/fTTQ2R/wflBIak=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-167-6goZ4s7XN1uYhsB4BTmkZA-1; Thu, 05 May 2022 19:19:12 -0400
X-MC-Unique: 6goZ4s7XN1uYhsB4BTmkZA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5006B811E75;
        Thu,  5 May 2022 23:19:12 +0000 (UTC)
Received: from localhost (ovpn-12-55.pek2.redhat.com [10.72.12.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 782D4400DFA2;
        Thu,  5 May 2022 23:19:11 +0000 (UTC)
Date:   Fri, 6 May 2022 07:19:07 +0800
From:   Baoquan He <bhe@redhat.com>
To:     lizhe <sensor1010@163.com>
Cc:     vgoyal@redhat.com, dyoung@redhat.com, prudo@redhat.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/crash_core.c : Remove redundant checks for
 ck_cmdline is NULL
Message-ID: <20220505231907.GB2331@MiWiFi-R3L-srv>
References: <20220504123623.36852-1-sensor1010@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504123623.36852-1-sensor1010@163.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/22 at 05:36am, lizhe wrote:
> When ck_cmdline is NULL. The last three lines of
> this function(get_last_crashkernel()) are equivalent to :
> 	if (!NULL)
> 		return NULL;
> 
> 	return NULL;
> This is obviously a redundant check

Now the patch log correctly reflects the code change, even though the
log is a little redundant. While it's far far better than a wrong log
which will definitely confuse, even mislead people. I would go with:

======
kernel/crash_core.c : remove redundant check of ck_cmdline

At the end of get_last_crashkernel(), the judgement of ck_cmdline is
obviously unnecessary and causes redundance, let's clean it up.
======

And the patch version is missing. If you agree on the above log
rephrasing, please post v4 with the updated log, and can add my ack:

Acked-by: Baoquan He <bhe@redhat.com>

Thanks
Baoquan

> 
> Signed-off-by: lizhe <sensor1010@163.com>
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

