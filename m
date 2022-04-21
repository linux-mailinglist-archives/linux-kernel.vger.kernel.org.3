Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C262550A494
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390246AbiDUPq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241885AbiDUPqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:46:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 941374830F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650555843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4gc2M0v0er8UCG8V53Vh3iWVHg/oNsB78Q63SvOvkq8=;
        b=IacfNhJ0ej4n8WfEO/+R8ZQHWpmBgdeiakzPRr+9SufLwPfu9y3shUqJNcp2i2lzf5zu0e
        WzQsyDSwBb6R8cB1MEEy/W0b5TVqpBT53ZEIpYix7Fx0+En7soWXWCFao/7ywrgQJYSM0N
        i/xxcjjhgLMyg15IpcMsebUYPCtKdRA=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-EWlSdXKMPRiH0cfzoha_VA-1; Thu, 21 Apr 2022 11:43:11 -0400
X-MC-Unique: EWlSdXKMPRiH0cfzoha_VA-1
Received: by mail-io1-f71.google.com with SMTP id x8-20020a056602160800b00654b3a46b66so3512966iow.19
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4gc2M0v0er8UCG8V53Vh3iWVHg/oNsB78Q63SvOvkq8=;
        b=Qd+dH9FBThQAci0LJQ/jRYWx9RpgA85iLUnyD9TVJ7cWULsTl3BVY+WNdhgjdgIKUx
         Da/VmoTtJveMZB8uR/vqO7FD8veipGTFjL6vWQsLA0s12FqW7wOruCfp0K2dMk1WTYsY
         p1uEXwhQDbbSFl+zo3TYCMPmqLJTHJgPY8H4INgBJTCNehK2jd2i1mIyYaca/A4A564u
         pNVf0i4UaDj2UIz2/COMJawgz/wV/U8IQrym1dWI5CEqaZuQPGSvRe/QOgXYiUMxWvEg
         5PYaNG9lXMKgBbrw9exOcsAIYZLgqzSv3nCxObX9HJYuyfkG0+28uVFfo8itxUT2A9rH
         4R/w==
X-Gm-Message-State: AOAM532Rpf9nCTHYNOkRc1SiXSREPnOHDYeOXHRoZdUueZWXfFHX6NKo
        FOkOZc0SoysdCKnwTJeRIYehnG1/8fP59+PPZkQObz9u0mwa557h4zBnjm/I0RzhfKmouuBJ/yB
        Ub1/gSOKWhy0EKD/0kj8QCig7
X-Received: by 2002:a05:6638:279:b0:328:5fae:8913 with SMTP id x25-20020a056638027900b003285fae8913mr94717jaq.157.1650555790607;
        Thu, 21 Apr 2022 08:43:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjsXov89LqgRKDG8j9vehDNDyPDT79M93ZWcRO17dZH1LAZ7SUOnOLcrWeWsNkDz+RMjwZSw==
X-Received: by 2002:a05:6638:279:b0:328:5fae:8913 with SMTP id x25-20020a056638027900b003285fae8913mr94711jaq.157.1650555790400;
        Thu, 21 Apr 2022 08:43:10 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id c2-20020a92dc82000000b002c9b0f25e62sm12341111iln.60.2022.04.21.08.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 08:43:10 -0700 (PDT)
Date:   Thu, 21 Apr 2022 11:43:09 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -mmotm] hugetlb: use mm.h instead of mm_types.h
Message-ID: <YmF7jTjaku6PNoZt@xz-m1.local>
References: <20220421014723.5802-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220421014723.5802-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 06:47:23PM -0700, Randy Dunlap wrote:
> mm_types.h does not have zap_flags_t in it so use mm.h instead
> in hugetlb.h.
> 
> Fixes this build error:
> 
> In file included from ../drivers/virt/nitro_enclaves/ne_misc_dev.c:16:0:
> ../include/linux/hugetlb.h:414:4: error: unknown type name ‘zap_flags_t’; did you mean ‘vm_flags_t’?
>     zap_flags_t zap_flags)
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Signed-off-by: Peter Xu <peterx@redhat.com>
      ~~~~~~~~~~~~~~~
            ^
            |
            +-------- could drop these..

> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: linux-mm@kvack.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
> Fixes: mm-hugetlb-only-drop-uffd-wp-special-pte-if-required-fix.patch
> 
>  include/linux/hugetlb.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -2,7 +2,7 @@
>  #ifndef _LINUX_HUGETLB_H
>  #define _LINUX_HUGETLB_H
>  
> -#include <linux/mm_types.h>
> +#include <linux/mm.h>
>  #include <linux/mmdebug.h>
>  #include <linux/fs.h>
>  #include <linux/hugetlb_inline.h>
> 

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks for fixing it,

-- 
Peter Xu

