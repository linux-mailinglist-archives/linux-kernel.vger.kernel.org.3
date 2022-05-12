Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32087524E47
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354415AbiELNaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353288AbiELNaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:30:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 598C7606E5
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652362198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DA2o1oH2CnQN4rTgeJBlz0Z2QZ9OepNnqTduzJ6TFAE=;
        b=FkFY81K5VTwaR6IFSKmoVbupZKIhz7eaHH+gzI77B9D9E1d8eDhFIV5YfbzpL9g8AAipf4
        X/I8mOoH2gndp3GOjewpkWXLqMGrg7ZIGhDxzho05WZuuqc/HcTWXjdftbTgRUsyjEa7M8
        cH1ZlqDseXBPwiXZBX/v6MAwEox9CMk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-63bzjTfzOqWPBxqpPOgk4Q-1; Thu, 12 May 2022 09:29:57 -0400
X-MC-Unique: 63bzjTfzOqWPBxqpPOgk4Q-1
Received: by mail-wr1-f70.google.com with SMTP id m8-20020adfc588000000b0020c4edd8a57so2069940wrg.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=DA2o1oH2CnQN4rTgeJBlz0Z2QZ9OepNnqTduzJ6TFAE=;
        b=USygqw8KO0deVXX8OKsC+51OIlyjmwFzwKpAkhHfiss68s1Yos7w1sEa3rsSpTceDC
         juukYcWGvfFAbTrrw8k3xF1S8tJWz/XQlcVGMgi3vZGy50fr7urTlLpIFmXCNCiHoRNY
         v9yg07Krh6be/+IdhuO76wXWccwU1ulR9/+HQqQhrAt5lGX/jGMSecsEfa/9ytb9fVzl
         KAn0xDBTPvtu9k9fGzFu3qIwCmriXjNW8GAaWgGNtqykfC+LVBtWKVA3dSB+kj14H4vq
         ZJsk9WIa2xhziu+VIV9I8Xb9OYPuCuMLITN+59hDQ2wpq25yiJCEoresgMUebLYPNs2L
         kvdw==
X-Gm-Message-State: AOAM533d2hsK5C1RLsKCaCOnDnfacUQcYt/gliDpxuEXIyUMH7TgzyIV
        VwjJrCMRtNB2A+DXBVfumc9jplwKcvxRkqN+B+XNtOpiT/oI66mls568jXcp9XMq7yOdGxe2TPi
        QsdRtUa1oOgMpRJvojywlgM8s
X-Received: by 2002:a5d:6752:0:b0:20a:ce1f:2ceb with SMTP id l18-20020a5d6752000000b0020ace1f2cebmr27778393wrw.715.1652362196080;
        Thu, 12 May 2022 06:29:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXNlsPbzl2/GTRWfDAonlU3oNOseB8s5XhieI0K7okUkzO9jJ++Jt9yrmxfwD5f9zfWe7EZw==
X-Received: by 2002:a5d:6752:0:b0:20a:ce1f:2ceb with SMTP id l18-20020a5d6752000000b0020ace1f2cebmr27778377wrw.715.1652362195861;
        Thu, 12 May 2022 06:29:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:d200:ee5d:1275:f171:136d? (p200300cbc701d200ee5d1275f171136d.dip0.t-ipconnect.de. [2003:cb:c701:d200:ee5d:1275:f171:136d])
        by smtp.gmail.com with ESMTPSA id n7-20020adffe07000000b0020c5253d8dasm4166161wrr.38.2022.05.12.06.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 06:29:55 -0700 (PDT)
Message-ID: <f6e93064-a7ec-5509-e75c-0548ea5f9ed1@redhat.com>
Date:   Thu, 12 May 2022 15:29:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 03/15] mm/swap: fold __swap_info_get() into its sole
 caller
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     willy@infradead.org, vbabka@suse.cz, dhowells@redhat.com,
        neilb@suse.de, apopple@nvidia.com, surenb@google.com,
        peterx@redhat.com, naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220509131416.17553-1-linmiaohe@huawei.com>
 <20220509131416.17553-4-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220509131416.17553-4-linmiaohe@huawei.com>
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

On 09.05.22 15:14, Miaohe Lin wrote:
> Fold __swap_info_get() into its sole caller to make code more clear.
> Minor readability improvement.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

