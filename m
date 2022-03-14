Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776544D8A59
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 18:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241866AbiCNRFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 13:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbiCNRFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 13:05:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD37A13E3A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 10:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647277444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nWCgHwgDDKj06QMJn9h/A4XF35PO8btbj9WvrUaFqDk=;
        b=dzIu6IVH7tymc7PyUU6wgymHqVQ1DIbJeKhKT5aOXFRo505llQWd8fiM/oo+WNp4rQwTWo
        6JtwaOxII6CfDq6XWOmv2xGwp6KeICzVkVuT3OwUV3S9NPF866ccEQQf4D1frkKzcmjVA4
        YWmVpCXa2YydiRU33+IubYftbJIote8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554--cA0q14fOPCkOW6QPTPqRA-1; Mon, 14 Mar 2022 13:04:03 -0400
X-MC-Unique: -cA0q14fOPCkOW6QPTPqRA-1
Received: by mail-wm1-f71.google.com with SMTP id 26-20020a05600c22da00b00388307f3503so7293433wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 10:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=nWCgHwgDDKj06QMJn9h/A4XF35PO8btbj9WvrUaFqDk=;
        b=KaH6hamGU5EKc7/ATeBBSt/sjYGvOboZq2ECLW6AWLM4Ga4pu/KIiUCm06Tcog6uJ7
         rfM94tir7JFndk7C+A7D5e2Vv0WDwuqQJEH/hWaJAAL7KTkqv6qAhIn9SBl+FZxuKrbH
         NjvKMR0FIf/AhOx0qRArNIyr8kMpnIKfpE4crHKogrAHWI7fV/bAaGQJeenMhXWBS5Jz
         J8cE2NTomCRx34jqSLfT78cYSyyUkWwy5WT+xSD2wO86xq04z3foV6Ixon6SU7k3QZ27
         4TfCBAL8Z8pWsMUgQNCz+lCnp99f08g55UUfwDq0QgBQjENlw8c8uSWrSF1XAYdO+JQU
         40lQ==
X-Gm-Message-State: AOAM533EqjocQVjpsYbqlmMujRD1IvK1BZK+EQkkckoDk9mixw1AXOz4
        2qLN/VMsbnX1wQZxGwEu3yZRy+s8AnGg9tLJPODb6IAdiSedqfB/31X69yDyd6+ZgrDFKfT4QEq
        xbZPtlB9J3vYOwnSGmHYm6ZtD
X-Received: by 2002:a7b:c150:0:b0:389:95ee:4a20 with SMTP id z16-20020a7bc150000000b0038995ee4a20mr107049wmi.145.1647277442111;
        Mon, 14 Mar 2022 10:04:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzq4tXnPaZX7aE2z3rCDRky8biOX0gv+k8itzfOQumoQ0ijxnuBob9bchKuevyzXDNc3986mA==
X-Received: by 2002:a7b:c150:0:b0:389:95ee:4a20 with SMTP id z16-20020a7bc150000000b0038995ee4a20mr107027wmi.145.1647277441876;
        Mon, 14 Mar 2022 10:04:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:9a00:b2c1:8682:b807:e870? (p200300cbc7049a00b2c18682b807e870.dip0.t-ipconnect.de. [2003:cb:c704:9a00:b2c1:8682:b807:e870])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c22cb00b00382a960b17csm88614wmg.7.2022.03.14.10.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 10:04:01 -0700 (PDT)
Message-ID: <753f3cca-6862-a6b9-05a1-0b0fcc4565b8@redhat.com>
Date:   Mon, 14 Mar 2022 18:03:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v7 1/5] mm: page_isolation: move has_unmovable_pages() to
 mm/page_isolation.c
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20220311183656.1911811-1-zi.yan@sent.com>
 <20220311183656.1911811-2-zi.yan@sent.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220311183656.1911811-2-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.03.22 19:36, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> has_unmovable_pages() is only used in mm/page_isolation.c. Move it from
> mm/page_alloc.c and make it static.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

