Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A3A50E209
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240825AbiDYNmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239865AbiDYNmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:42:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65B774092C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650893957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pm+NNZ/YV7VS9Z5vMhYXE2vlZstaKvSFd8SQzWKhXa4=;
        b=Xz6xcl74RfZsQe2JF6DB2j7ar3GPrS7nJ8kpcsC1g84RG6AGBRvB1ugkgpLcnOv2gVySny
        OI6MZOejfl3ppwvGIsr0F470sFVF0SHAN5n0cPnlFBcXI0mYyfu7aP+3eimREgJPYHhrGT
        bwBzsmDJd5zFWqEuQkt0w4mmdLvy7II=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-Iqi3PSZmPtSXDPbSooBj0g-1; Mon, 25 Apr 2022 09:39:16 -0400
X-MC-Unique: Iqi3PSZmPtSXDPbSooBj0g-1
Received: by mail-wm1-f70.google.com with SMTP id m125-20020a1c2683000000b00391893a2febso6756225wmm.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=pm+NNZ/YV7VS9Z5vMhYXE2vlZstaKvSFd8SQzWKhXa4=;
        b=d57qvVaCpkKEb6ai84I0q/CzU9iqDm0bVaoTKqoDE/AXtqc8B7pISEBgCuBKW8xnWt
         UbzZrPaBa0MxMqH42g1ai35vM7bhG/mCfTix3iKlywEnp5jKv8eoJ4eILDMT8M+X7eTu
         QJAMLPP/aYJYw97lh93PvNus+aQE926qsAiRuFjqjbGEI6MSrpL/VMWy6KLqqp2nsDsR
         YMurjjAi7bKtKfAPzntU++Pu8QE35jtzoGW5FWqem3+ZTl3yPN/g8CzAiGT2SZfbTBGB
         tkbI5qRzkYpwfyv4YkfpSEU7Pm7OuqlnZQArnagCOFfqu1AyhUVn4K/skQ6OtMPiop43
         iAdA==
X-Gm-Message-State: AOAM531QtFanAiIoXe3SrYuSBc3hiO8/Mjy8t49pZyx52kxAlvH+YAnk
        ucYiH/6fZ/SYTqJtHNpxISU/bVlYS1WMtSLGYkjWI+bY/ZEIrYMTH9Y+RpApRUCtTchSIYhM5JS
        sQWbsUItnv49lTzXN4pcIzV1g
X-Received: by 2002:a05:600c:b54:b0:390:82ee:e15b with SMTP id k20-20020a05600c0b5400b0039082eee15bmr16338578wmr.17.1650893955016;
        Mon, 25 Apr 2022 06:39:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyVm6uYzjDLqJQlFa/Cd3V5cm8Gl9fxAcUxr6d7iLSE7Dfvnf9RSY0cKHsP9GHjWUFipXAsg==
X-Received: by 2002:a05:600c:b54:b0:390:82ee:e15b with SMTP id k20-20020a05600c0b5400b0039082eee15bmr16338550wmr.17.1650893954706;
        Mon, 25 Apr 2022 06:39:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:fc00:490d:ed6a:8b22:223a? (p200300cbc700fc00490ded6a8b22223a.dip0.t-ipconnect.de. [2003:cb:c700:fc00:490d:ed6a:8b22:223a])
        by smtp.gmail.com with ESMTPSA id q16-20020adff950000000b00205aa05fa03sm8733178wrr.58.2022.04.25.06.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 06:39:14 -0700 (PDT)
Message-ID: <bdbd5cb5-b480-46b9-4b81-10d2891fa7ea@redhat.com>
Date:   Mon, 25 Apr 2022 15:39:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3 2/5] memblock tests: update style of comments for
 memblock_reserve_*() functions
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>, outreachy@lists.linux.dev
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1650633253.git.remckee0@gmail.com>
 <7e21d96491ed573f1f7823cfe56c4d8ced4f78fe.1650633253.git.remckee0@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <7e21d96491ed573f1f7823cfe56c4d8ced4f78fe.1650633253.git.remckee0@gmail.com>
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
> Update comments in memblock_reserve_*() functions to match the style used
> in tests/alloc_*.c by rewording to make the expected outcome more apparent
> and, if more than one memblock is involved, adding a visual of the
> memory blocks.
> 
> If the comment has an extra column of spaces, remove the extra space at
> the beginning of each line for consistency and to conform to Linux kernel
> coding style.
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

