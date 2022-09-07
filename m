Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEA45B0883
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiIGPZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiIGPYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:24:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E16DFDF
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 08:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662564266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0iho6+f9z5iRGGjb89HO9wY/SFqf6LDgVvj0vNpVUXY=;
        b=SRO/rLTyXVItdachGCen2xqnkqbNDSmuMw/0Ub7BlrLpeDjmG2H/+45JuDXGEJHu7P3imy
        BfxvTeOMIjUthzvvznWSUO/ULbu0/r/0LHMZFiAaQ6KjVJLvfXlCzk7HqJ5CaICxaGjNUB
        tkyyEbR0cJEodwYOhJs10bX1K6OI+iU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-468-FHwvfR03N1meo_sPdLv7qA-1; Wed, 07 Sep 2022 11:24:23 -0400
X-MC-Unique: FHwvfR03N1meo_sPdLv7qA-1
Received: by mail-wr1-f72.google.com with SMTP id r23-20020adfb1d7000000b002286358a916so2865984wra.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 08:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=0iho6+f9z5iRGGjb89HO9wY/SFqf6LDgVvj0vNpVUXY=;
        b=E6P4d3ndch9bPQ1a7hGCsAn2iaGCNEFtduIpjrgGGcREXVy3eCImJQlVrmPEzcQL9c
         tahqyiJnM1vHHzUShi80ovH7oZNl+sqq8yNZ513hJoURaYgNwdPYwnIAwxNYenGMvDmJ
         VQlMXaqpGyvxztl45ve0pPWNkmDcjUPfCd/iFaYB5m2KZqyhGLPT+GkWX4zSHxl5iQbG
         jqk/G4e/crBP0zIP+B89xC30cwmQyGQS7NC59ig7nhfA4LNBzm9jj1g00Wr28c9Kmr3d
         oxUlBGUJ+IiGl6XCjJLRO2g/BpIMz7y10tHLoQjkf9kUvHAjtSSbLli5HjWHXMVStlxt
         AhKg==
X-Gm-Message-State: ACgBeo2iLuJHq6hze3iiqeeS4KRqfwfGMlKDfiKzrbUEI9wToSIv0DwL
        vnRSnJVymC4iFGz+LDGeUTiUUi0wIb2QAD/O3pNjlWPXeG4Hn0P5wQ7L0+x1dEtfM2/yc074EQ5
        VMGV4xrfHzy1Q5d0fRxCiUZJH
X-Received: by 2002:a05:6000:15c2:b0:228:dc85:d1b0 with SMTP id y2-20020a05600015c200b00228dc85d1b0mr2432129wry.9.1662564262260;
        Wed, 07 Sep 2022 08:24:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR54VhhbaXXAuW8Gfur51p1bJ4MXnIleZvevw+Ruf936LdZMl4U/+HMZ3kpOi6iQ5mdfjE1jkQ==
X-Received: by 2002:a05:6000:15c2:b0:228:dc85:d1b0 with SMTP id y2-20020a05600015c200b00228dc85d1b0mr2432113wry.9.1662564262041;
        Wed, 07 Sep 2022 08:24:22 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0? (p200300d82f0dba00c95131d7b2b08ba0.dip0.t-ipconnect.de. [2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0])
        by smtp.gmail.com with ESMTPSA id n2-20020a5d6b82000000b00228d52b935asm8209217wrx.71.2022.09.07.08.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 08:24:21 -0700 (PDT)
Message-ID: <a3aee507-6fc1-56f7-ee22-d48e674b1af3@redhat.com>
Date:   Wed, 7 Sep 2022 17:24:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 3/3] mm: add pageblock_aligned() macro
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
References: <20220907060844.126891-1-wangkefeng.wang@huawei.com>
 <20220907060844.126891-3-wangkefeng.wang@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220907060844.126891-3-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.09.22 08:08, Kefeng Wang wrote:
> Add pageblock_aligned() and use it to simplify code.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

