Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD42A54A9E9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237671AbiFNG7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 02:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiFNG7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:59:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A52843AA79
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 23:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655189939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=165bFaZlwfKqEUi4HtU3Zw6CrU4RiJY/1bnRkwVsKqg=;
        b=cPFcvqv53LD4OaiHOZ7VjRqlyDs5vjAxc1Iu/5PUQKKJfWHEAY8R7oY2ARJUryIWUgAX3S
        p8C6mB/l3pFglTQEtWkPA0wJC3zwAdPCYRdOguM6D2Fwivb3xgJpDStLu35HLxo/x8RP7Y
        7IQLkSZd1Ny280ILtNAN+MrRaMJM7/o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-348-ox3dwkx9PQe3fFExGo3z_g-1; Tue, 14 Jun 2022 02:58:58 -0400
X-MC-Unique: ox3dwkx9PQe3fFExGo3z_g-1
Received: by mail-wm1-f69.google.com with SMTP id v184-20020a1cacc1000000b0039c7efa3e95so3470042wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 23:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=165bFaZlwfKqEUi4HtU3Zw6CrU4RiJY/1bnRkwVsKqg=;
        b=v8XRh558k3/zOg5KFted6gss+p/7CbdF2s/mtxyCysLLIf9edCHrU8/3AsE9Kh9Y33
         zZIWDGUh/jy7b9nn873ksuwqch6HN18K2RlZFbqIK9TIqsEb7UktiCwszYcoN/rVm0pQ
         T3yFdZu/ZbUey9GvUFJ9OJNda2K7k1Ukj9deCdBh/E4UZHeC9Y2cg3Z67YzJ46O/75by
         CwGwmLZElMCbZDo23XKuiEEExzVjj+lGHESaBu+KUGs+4eq4VLq6dp6KjX2+gfDFpyMt
         og7GEUAi0W62/TvJ0egCS/Ct9V2GIXb0qbZuOKuRALk23tHWX/ubYYW7fdSWNpg0X3/e
         lIXg==
X-Gm-Message-State: AJIora8n1PBfrsSefLVRwzNk6ucZcxG4k+bS0fu//0Qvgl0eOvWQXrwL
        fIuwL+fCIdL/gePZgr1YRRR0Cdx0A4SCMu/8NEmyhA6VlIl9tzQsZ3lphOV35EZyjSMiO2ZY+SK
        fMP8aFannFDYvZMXutIbInr2TJhCA19U4lPDTQqjgKaE/5kDtN/f9vvpvaIRqwM5miZEWPKTe
X-Received: by 2002:a05:6000:18a9:b0:218:7791:a9ad with SMTP id b9-20020a05600018a900b002187791a9admr3355803wri.116.1655189937376;
        Mon, 13 Jun 2022 23:58:57 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ssHMKYH4k8kw7gv+GTlRPt8sCrt8JRY/ON2cjIiR3mrj3iL38gK+9L6AhGJt18kf80tVLISg==
X-Received: by 2002:a05:6000:18a9:b0:218:7791:a9ad with SMTP id b9-20020a05600018a900b002187791a9admr3355771wri.116.1655189937051;
        Mon, 13 Jun 2022 23:58:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:cf00:aace:de16:d459:d411? (p200300cbc70bcf00aacede16d459d411.dip0.t-ipconnect.de. [2003:cb:c70b:cf00:aace:de16:d459:d411])
        by smtp.gmail.com with ESMTPSA id m10-20020a5d56ca000000b0020c5253d8f7sm10737307wrw.67.2022.06.13.23.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 23:58:56 -0700 (PDT)
Message-ID: <72194595-a177-088d-28a9-0a24d4192777@redhat.com>
Date:   Tue, 14 Jun 2022 08:58:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oscar Salvador <osalvador@suse.de>
References: <20220610101258.75738-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1] MAINTAINERS: add MEMORY HOT(UN)PLUG section and add
 myself as reviewer
In-Reply-To: <20220610101258.75738-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.06.22 12:12, David Hildenbrand wrote:
> There are certainly a lot more files that partially fall into the memory
> hot(un)plug category, including parts of mm/sparse.c, mm/page_isolation.c
> and mm/page_alloc.c. Let's only add what's almost completely memory
> hot(un)plug related.
> 
> Add myself as reviewer so it's easier for contributors to figure out
> whom to CC.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  MAINTAINERS | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a6d3bd9d2a8d..77aebce76288 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12848,6 +12848,18 @@ F:	include/linux/vmalloc.h
>  F:	mm/
>  F:	tools/testing/selftests/vm/
>  
> +MEMORY HOT(UN)PLUG
> +M:	Andrew Morton <akpm@linux-foundation.org>
> +R:	David Hildenbrand <david@redhat.com>
> +L:	linux-mm@kvack.org
> +S:	Maintained
> +F:	Documentation/admin-guide/mm/memory-hotplug.rst
> +F:	Documentation/core-api/memory-hotplug.rst
> +F:	drivers/base/memory.c
> +F:	include/linux/memory_hotplug.h
> +F:	mm/memory_hotplug.c
> +F:	tools/testing/selftests/memory-hotplug/

(thanks for the kind words from reviewers :) )

Thinking about it (and remembering having a discussion about
submaintainers for MM in general at LSF/MM):

@Andrew, do we want "official" submaintainers for that section? If so,
we could turn my R into an M. Further, Oscar did a lot of work in the
memory hot(un)plug world as well -- so if we want submaintainers, Oscar
might be a very good fit as well.

... I guess, that would mostly reflect reality :)

-- 
Thanks,

David / dhildenb

