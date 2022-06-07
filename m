Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D964C53FF98
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 15:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244371AbiFGM7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244341AbiFGM7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:59:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77DF2AFAE1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654606788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lLkIExdSAfZXhKlnnfUm2v8chK83vx8JP1WYxXIWoTk=;
        b=QGfferDzUOKCu4jgL8TvWAj1ObsAuuU6a42CjdW6SSxKIfoiFegmQ/Aqz/jw36GPu/s5Ow
        J3Q8w/OOLlZas7T/5TnDiT0DwuYlBdP/i71IHBOuM9NDikt+mxO0RWSPwhcP2dr+Gg3KJe
        tVLewkCjKlsHsQWkNrHe2MwHSXdxuNo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-XUBJBii2MAyaEWEJny3ohA-1; Tue, 07 Jun 2022 08:59:47 -0400
X-MC-Unique: XUBJBii2MAyaEWEJny3ohA-1
Received: by mail-wr1-f70.google.com with SMTP id i10-20020a5d55ca000000b002103d76ffcaso3903022wrw.17
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 05:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=lLkIExdSAfZXhKlnnfUm2v8chK83vx8JP1WYxXIWoTk=;
        b=WdfSD6etcR7WFSZptZR9RUTpDGmADpQzLJyPawBbvoAFp5AM5ER1237G9zITZFaZwv
         4qhWcIAusI3K2hs87r9PgqnrrY+9ZDbB1E8ZJRxTH1mxK81AcDUZ6m5sgzVaEsYoCbtB
         p4eEd5rwKSZN4brDSk9UNdNrGN+ikXVF+yzU36gq7PPeCTRt//nKHHAtxbEvyitVsdaA
         dKU8KiiWpAp0o/lNU40s5RkAddnd1IjICc5MDMfACBRcsurIza8B4SEl+APROvt/CmKy
         8VwFe30KYjQgQdienNm8s3VT1TOwK/7tVw8BhAfgKQyWrkswOjW3lbFvOFW3jq4dogYa
         PEtQ==
X-Gm-Message-State: AOAM5325msm8wqqITCahvmHAnbWzo5ZpT4D06mJcHPx9sIMtl/aZsIxb
        t/g+xJOnuWMT5hnTLzCYXcAyyqjMlPS8n+lkk72BNEVaUIwg5IxfGnX/RWEcGSCh7tHSwuJaMbZ
        1gh4ZRy4eKPvUHbfTKJdB2Zmr
X-Received: by 2002:a05:600c:154d:b0:394:880f:ae3a with SMTP id f13-20020a05600c154d00b00394880fae3amr57162982wmg.13.1654606786071;
        Tue, 07 Jun 2022 05:59:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqobIROp0frQyRbHeDBQX0/wyK9D7b9XqZKUc3BVsApHVxTT80upGqI6zMshvJq/DgrW/pbQ==
X-Received: by 2002:a05:600c:154d:b0:394:880f:ae3a with SMTP id f13-20020a05600c154d00b00394880fae3amr57162952wmg.13.1654606785803;
        Tue, 07 Jun 2022 05:59:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:500:4c8d:4886:f874:7b6f? (p200300cbc70905004c8d4886f8747b6f.dip0.t-ipconnect.de. [2003:cb:c709:500:4c8d:4886:f874:7b6f])
        by smtp.gmail.com with ESMTPSA id be5-20020a05600c1e8500b003942a244ee6sm20657928wmb.43.2022.06.07.05.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 05:59:44 -0700 (PDT)
Message-ID: <16c92358-0daf-94d0-0f73-92faef827d51@redhat.com>
Date:   Tue, 7 Jun 2022 14:59:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/3] mm/slab: delete cache_alloc_debugcheck_before()
Content-Language: en-US
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org
References: <20220605152539.3196045-1-daniel.vetter@ffwll.ch>
 <20220605152539.3196045-2-daniel.vetter@ffwll.ch>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220605152539.3196045-2-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.06.22 17:25, Daniel Vetter wrote:
> It only does a might_sleep_if(GFP_RECLAIM) check, which is already
> covered by the might_alloc() in slab_pre_alloc_hook(). And all callers
> of cache_alloc_debugcheck_before() call that beforehand already.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: linux-mm@kvack.org
> ---

LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

