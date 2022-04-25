Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAEC50E207
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238256AbiDYNmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiDYNmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:42:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 955313A5D6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650893943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U/nJVlrnckJY6gYEpBiKmEsvpHCZZ3VcmakjaLJFA5o=;
        b=VKawoTl7MD840PNCpt2qXroLcPRPmkyQS/QfkBZ4xW88jYCicnT+z4DjJ4KT12F2oQ7DgN
        ncR0vXSL9isxbmUqCOB+H8pXdkcXuSCNxJXSWVcdq1wwUHMPJh5QNcxMoO/s5wO/BZEOcg
        WstIxPhcgU6Pc1h6oso5TeecGwWjf+o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-UyoPzDn6PgiWOWu69qV5ZA-1; Mon, 25 Apr 2022 09:39:01 -0400
X-MC-Unique: UyoPzDn6PgiWOWu69qV5ZA-1
Received: by mail-wm1-f71.google.com with SMTP id q6-20020a1cf306000000b0038c5726365aso7166991wmq.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=U/nJVlrnckJY6gYEpBiKmEsvpHCZZ3VcmakjaLJFA5o=;
        b=74MVCyY1IfI/2RxXLa0aKu1z6HeDQ0wtv3W003evdfUVtUQQeA/MhrmZDbXtc3Hs1m
         pz79mpPUeXuh9by32p6bvZSiTCfmxHvsf3EdyAO/ed3S3obtg1tvrRSYuRyqB+i2OTli
         dCzePu6E09HumpilLUfXBDkDV8coZIF+arzjp1eA+SUf9fCeS1s67DU1YdfPG5reG+Nx
         5hil3dcXVdQAFkjlWO1GpKkrPIrFnXhw/J/HsLu4GkNjZaKEnqRZv3dURtKM0g7i/dXe
         blzRqr1OdmqLzT9boDj+ZkmeKiBoU1+a+qzwkwLSqKmFO7l4earwNSrolvFZ4IgH8IzP
         aeFQ==
X-Gm-Message-State: AOAM533FOenSIU+IK9oSb0U6dZgUQgYnWvaTO5zjl/3s6ormgjKLN2X/
        YDbqUj+bsGmP+NgCfGTK8DtFoPihyiJrBJKvYvxLM7QbQKROzHwqR2yQIcB/MkxgDJ7hAhpxC+u
        5AIsbiT6qDiSL8Cgeg6zMEabc
X-Received: by 2002:adf:df05:0:b0:20a:c402:6811 with SMTP id y5-20020adfdf05000000b0020ac4026811mr14592008wrl.275.1650893940357;
        Mon, 25 Apr 2022 06:39:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzl7suWwaROQq9b2PYFvA50sZlPXavnDV5jI48/WjywXp6wyfpRVASVT+F8KZzW6eKW4s1J6A==
X-Received: by 2002:adf:df05:0:b0:20a:c402:6811 with SMTP id y5-20020adfdf05000000b0020ac4026811mr14591990wrl.275.1650893940038;
        Mon, 25 Apr 2022 06:39:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:fc00:490d:ed6a:8b22:223a? (p200300cbc700fc00490ded6a8b22223a.dip0.t-ipconnect.de. [2003:cb:c700:fc00:490d:ed6a:8b22:223a])
        by smtp.gmail.com with ESMTPSA id e30-20020adf9bde000000b0020ad8ffb0f9sm3844998wrc.69.2022.04.25.06.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 06:38:59 -0700 (PDT)
Message-ID: <8d80cb56-4216-2d5b-7ab5-8abd60d2871c@redhat.com>
Date:   Mon, 25 Apr 2022 15:38:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3 1/5] memblock tests: update style of comments for
 memblock_add_*() functions
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>, outreachy@lists.linux.dev
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1650633253.git.remckee0@gmail.com>
 <2ea997e7b5c4737d674a2e5d9288938d557cb0c3.1650633253.git.remckee0@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <2ea997e7b5c4737d674a2e5d9288938d557cb0c3.1650633253.git.remckee0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.04.22 15:32, Rebecca Mckeever wrote:
> Update comments in memblock_add_*() functions to match the style used
> in tests/alloc_*.c by rewording to make the expected outcome more apparent
> and, if more than one memblock is involved, adding a visual of the
> memory blocks.
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>

Please make sure to not drop Rb/Ack tags and instead carry them along
when you resend patches. This, for example,  makes it easier for
reviewers to spot what needs attention and review.

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

