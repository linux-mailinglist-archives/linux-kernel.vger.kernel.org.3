Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF92524E65
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354480AbiELNiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354353AbiELNiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:38:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4301E14C752
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652362680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N8e+gXdF4Rt32wAzlMm0HLoNXNQ/0Ieuz5/O4oeRXo4=;
        b=hNhif9kRbq52zu86Cbt+AzojTQuexxUTnvhzgVS4eRH9thd0sCrUkjN2e3+KF5twCgOS4G
        /i/Sae7Vfi7w7YRK4Ku739twdqQvEIlW2ubtaI0WSH/P4zOmJ+5ak1qMk5dO+WWNk7x5xz
        xQ3NgXejmn8B4yzYDUpYUUz7kOc6aRQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-207-r7d66dYdNLCBVYD_3NEFdQ-1; Thu, 12 May 2022 09:37:59 -0400
X-MC-Unique: r7d66dYdNLCBVYD_3NEFdQ-1
Received: by mail-wm1-f71.google.com with SMTP id i131-20020a1c3b89000000b00393fbb0718bso4429507wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=N8e+gXdF4Rt32wAzlMm0HLoNXNQ/0Ieuz5/O4oeRXo4=;
        b=i/4iS1KlFIxekLijppELRheZ0foQmYPmYCSM73hm1mhuMkuE+4RqkSqL2o6EyETBBO
         N6K5Ur+yzOjA9Zb0e23Ycr8xden9rsru3uzAaD0Tdy6+6h2Ebin9WaX1N0pAk+61X8Dg
         dhnjNbC/livh5vU/pnDd/DLn14fUcA1/chHX0wpI/mcncBS/SFg6g27lQK6C9KttMIFE
         8hxXwBjCrhIK9BbgYr0HJUAzt7VlWcoKeD8CNBkkAGChPDjZm5ngAH09EI16CIaJ2eB5
         M22jiE8N06Noxwi6AO9yEK4046E2SZQfOPe9r/jc22n9wpTm1mFTj9nvTt6yxt8yf9T7
         DSGg==
X-Gm-Message-State: AOAM53321kHxybd5rZtP4OPiUGD3Fmifjp6hiuPGXotYQTsrCy5lfG6A
        o5fPnWj+vIj7qTFtIj59v4msZZ3nyrb7XrEMowj0KB3IMTVdyD2099l7+QRmJJ7MpRrQQnw7u8y
        1mkGcGVa/ULgeeH95zKasxn8A
X-Received: by 2002:a5d:61c2:0:b0:20a:d92f:9056 with SMTP id q2-20020a5d61c2000000b0020ad92f9056mr26892242wrv.652.1652362677943;
        Thu, 12 May 2022 06:37:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzY1zewJ/fqnODYg7imJ16tz9qpZ3ZbXXs9WgoASNTNxE1AvunXIx9bUiuPLdC2yb6LwlVkSg==
X-Received: by 2002:a5d:61c2:0:b0:20a:d92f:9056 with SMTP id q2-20020a5d61c2000000b0020ad92f9056mr26892230wrv.652.1652362677713;
        Thu, 12 May 2022 06:37:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:d200:ee5d:1275:f171:136d? (p200300cbc701d200ee5d1275f171136d.dip0.t-ipconnect.de. [2003:cb:c701:d200:ee5d:1275:f171:136d])
        by smtp.gmail.com with ESMTPSA id y25-20020a1c4b19000000b0039489e1bbd6sm2553468wma.47.2022.05.12.06.37.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 06:37:56 -0700 (PDT)
Message-ID: <dbc37879-9279-dfcc-7566-60003b1f3780@redhat.com>
Date:   Thu, 12 May 2022 15:37:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 07/15] mm/swap: remove unneeded p != NULL check in
 __swap_duplicate
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     willy@infradead.org, vbabka@suse.cz, dhowells@redhat.com,
        neilb@suse.de, apopple@nvidia.com, surenb@google.com,
        peterx@redhat.com, naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220509131416.17553-1-linmiaohe@huawei.com>
 <20220509131416.17553-8-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220509131416.17553-8-linmiaohe@huawei.com>
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
> If p is NULL, __swap_duplicate will already return -EINVAL. So if we
> reach here, p must be non-NULL.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

