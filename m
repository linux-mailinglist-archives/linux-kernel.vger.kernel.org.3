Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B5B5588BE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiFWT1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiFWT0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:26:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C2124B1CD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 11:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656010046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bLAm3pMxOh+9zY21Oi845s3fU5zLtsAou6fuo/Fr2Z4=;
        b=duFKbtBCPiitPeBs2FIjpdzmeWSOO5PO7rX1Y7959lRRmlvSsqTM7XIsC3Gj/QBunBZ5GH
        O3WAhEcFVGdcQWBxcuVyMgd+iqAe9HhdNaekkO2Bh1kw/vI02md7YeQdMkMpMxCqzVzBlA
        EHfVpkqph664XqnZkCdJYcjYIKGG+J0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-Mv17TxNtOk2JMYZMYlPLMg-1; Thu, 23 Jun 2022 14:47:25 -0400
X-MC-Unique: Mv17TxNtOk2JMYZMYlPLMg-1
Received: by mail-wm1-f70.google.com with SMTP id 6-20020a1c0206000000b003a02cd754d1so1784wmc.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 11:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=bLAm3pMxOh+9zY21Oi845s3fU5zLtsAou6fuo/Fr2Z4=;
        b=yEOT+kc0T++cEUYSscnYzpblUuT2DbYQY2IOL+1hhbnDSU2OSiZqNDddBfziXYmJSb
         Zyrbo0nbPt5mSDdpid1CJlev72Fl2EARKbb85jHMbNP/98luu1jRabAc072yE3DbZwn+
         Y04OPBvE7alRloulIdG0dE10KZWwUQJZXp3ISYWIBsyXRpCIyjRrqFm410qER8coB3iY
         bC8PvZr3EidHIvPutvKDg6/iq8SLyBKXlrN2/XCw665z4guFJlOR/540VOc9Kn9S5aY0
         DpZ1dUXQPFdbo20zUr4JfdPKQqcZvQG2lslOkQBQVIerHC8xeuHX3L+G2vHjAp7aJmNL
         W14w==
X-Gm-Message-State: AJIora8VBGLKmWLDgWfEpBZY35gwqgFjrPvG+HIhlPVkIe0YujkZShDR
        yroR6nuGuJfVRmSEG/woT+8Hc4kWJHHag9brZED85u2Ae23VtSXVs/X9sDccp+sLBHKmUHikODK
        SvXAs/XcsigzaONPFevl6IPSb
X-Received: by 2002:a7b:c242:0:b0:3a0:1acc:4893 with SMTP id b2-20020a7bc242000000b003a01acc4893mr5974862wmj.66.1656010044518;
        Thu, 23 Jun 2022 11:47:24 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t/VUf72rhZDrZZIGKZe7nO+zIr5UrHo8zc6e2z0WNLhkOCYb4WSIBQqaJSjp9/jUHkySkmQg==
X-Received: by 2002:a7b:c242:0:b0:3a0:1acc:4893 with SMTP id b2-20020a7bc242000000b003a01acc4893mr5974842wmj.66.1656010044308;
        Thu, 23 Jun 2022 11:47:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:b100:7694:f34e:d0dd:95e7? (p200300cbc704b1007694f34ed0dd95e7.dip0.t-ipconnect.de. [2003:cb:c704:b100:7694:f34e:d0dd:95e7])
        by smtp.gmail.com with ESMTPSA id q13-20020adfcd8d000000b00219b391c2d2sm195465wrj.36.2022.06.23.11.47.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 11:47:23 -0700 (PDT)
Message-ID: <b0699467-dc88-3b91-2f1c-4a1b54ac9383@redhat.com>
Date:   Thu, 23 Jun 2022 20:47:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v10 15/69] damon: convert __damon_va_three_regions to use
 the VMA iterator
Content-Language: en-US
To:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
 <20220621204632.3370049-16-Liam.Howlett@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220621204632.3370049-16-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.06.22 22:46, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> This rather specialised walk can use the VMA iterator.  If this proves to
> be too slow, we can write a custom routine to find the two largest gaps,
> but it will be somewhat complicated, so let's see if we need it first.
> 
> Update the kunit test case to use the maple tree.  This also fixes an
> issue with the kunit testcase not adding the last VMA to the list.
> 
> Link: https://lkml.kernel.org/r/20220504011215.661968-1-Liam.Howlett@oracle.com
> Fixes: 17ccae8bb5c9 (mm/damon: add kunit tests)
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: SeongJae Park <sj@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Will Deacon <will@kernel.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---

Nothing jumped at me

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

