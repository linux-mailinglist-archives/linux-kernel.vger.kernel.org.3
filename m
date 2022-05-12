Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCC252470E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351048AbiELHfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237649AbiELHfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:35:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F22A13FD5E
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652340919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+zsFil+xpvaoKN6a+jTI1zh8ma/r9ny4YN2UU7DGZeg=;
        b=fllsoleq3ityokjbDJG60sOZc8GEBpybaiJMoIfOAuk9gQt4SqIs07YRbF3kygMKkReW0F
        cphMFykVubLD9ChB3LkOED5eirtxTIlqmYhcwP7EbUDUcjQk/yOZQkZUOW104qnWD8RrhM
        lQ4ssX5979ohc0fI5jm/CcIbuRSDYjs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-108-MGcK5m8wOxSZdU_U5IS0Ag-1; Thu, 12 May 2022 03:35:17 -0400
X-MC-Unique: MGcK5m8wOxSZdU_U5IS0Ag-1
Received: by mail-wm1-f70.google.com with SMTP id 26-20020a05600c021a00b003940660c053so1302513wmi.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=+zsFil+xpvaoKN6a+jTI1zh8ma/r9ny4YN2UU7DGZeg=;
        b=c/YXVYh5FIRsBjWHN+tnBjctsOhBSQiDbYo7/PzJSCisszbEOC3A6WtvqNY2saV0az
         XM4BoU1oScA4XuvKeqooAXCDaBJ1QUCzz3VOxPGgH3/OuZ8+9Fwry86USkWzPlo/BHhA
         29MKtPqzOEKm1r72RqhJDjxoMZ9evmZfjTA7COnpBgBh+EiUyXYB0WmxgoSDWgFhhB6k
         d+Js0iq/fiCa/wwsiFBzeDigpak3NJq4WJDMGGctq9cZyPG+Nk+2oQ23YK6HinijOnXp
         p36cJxmByV8TszIfJAJ4okHequ4pfwFtMaZ3TAAXyaI+7zqBwo6clvYRQ9zNdGle48G9
         8zJw==
X-Gm-Message-State: AOAM5334RqU7R8TzE9LrH5L8xzPla2+huEccv2vThjdh0PyQRtZw/mrg
        YzKPkOn/XnoOaQ77ocZKD/rfej6vgK0gExX3Skxww49Sr2aNfRR99HXkvQaBzOrqh+JCEyi0uPO
        CO12ZjQy8g2xPd9mq0g5/KK0Y
X-Received: by 2002:a05:600c:a01:b0:395:c416:d82d with SMTP id z1-20020a05600c0a0100b00395c416d82dmr536194wmp.88.1652340916518;
        Thu, 12 May 2022 00:35:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxkHWUCG109V9dmEtXYn9ON6yKtJ2KB9KefS0ZtZFYwDhXPmkaHKz4k0WD7SYd3wb+b0eANA==
X-Received: by 2002:a05:600c:a01:b0:395:c416:d82d with SMTP id z1-20020a05600c0a0100b00395c416d82dmr536163wmp.88.1652340916271;
        Thu, 12 May 2022 00:35:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:d200:ee5d:1275:f171:136d? (p200300cbc701d200ee5d1275f171136d.dip0.t-ipconnect.de. [2003:cb:c701:d200:ee5d:1275:f171:136d])
        by smtp.gmail.com with ESMTPSA id y12-20020adff6cc000000b0020c5253d920sm3973325wrp.108.2022.05.12.00.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 00:35:15 -0700 (PDT)
Message-ID: <f9a45337-102a-6787-4cef-3ef799490f01@redhat.com>
Date:   Thu, 12 May 2022 09:35:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v10 1/4] mm: hugetlb_vmemmap: disable
 hugetlb_optimize_vmemmap when struct page crosses page boundaries
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, masahiroy@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com
References: <20220509062703.64249-1-songmuchun@bytedance.com>
 <20220509062703.64249-2-songmuchun@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220509062703.64249-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.05.22 08:27, Muchun Song wrote:
> If the size of "struct page" is not the power of two but with the feature
> of minimizing overhead of struct page associated with each HugeTLB is
> enabled, then the vmemmap pages of HugeTLB will be corrupted after
> remapping (panic is about to happen in theory).  But this only exists when
> !CONFIG_MEMCG && !CONFIG_SLUB on x86_64.  However, it is not a conventional
> configuration nowadays.  So it is not a real word issue, just the result
> of a code review.
> 
> But we cannot prevent anyone from configuring that combined configure.
> This hugetlb_optimize_vmemmap should be disable in this case to fix this
> issue.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

