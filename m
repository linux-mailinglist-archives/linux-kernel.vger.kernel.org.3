Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B092851EAB8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 02:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353878AbiEHApa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 20:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237678AbiEHAp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 20:45:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3655DE013
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 17:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651970497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/xslxuZsbP0SHIK82QMmeHFbJ0tORO76aQX/cXKHW5s=;
        b=D1F2pFxzgiw5Mz3FUTPnuZYR/rUXHM+0u9BaGaa9dtkXeWwwuRp8QgbVWXgCVRcMGCSljY
        p+YzOG5ygUoufmuvOH4Ykd3QD2mkwDKtBTr0uaDflmR1bPVn7auUkyalrCesJkOM/3s3/A
        xtUa3nqEwpiptZ3Uai/wfwCnK6NIeuA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288--MDa9JGEN8Gr2H07yg9ehA-1; Sat, 07 May 2022 20:41:36 -0400
X-MC-Unique: -MDa9JGEN8Gr2H07yg9ehA-1
Received: by mail-qk1-f198.google.com with SMTP id p129-20020a37a687000000b0069fc31a594bso7429650qke.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 17:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=/xslxuZsbP0SHIK82QMmeHFbJ0tORO76aQX/cXKHW5s=;
        b=iUVktd9s+4MeZ692M3sJNHtX8wm6nMpSvtxCZ87N/TypPfCfjTRZZ3cJj5khuPl6/m
         6H4cprzwjkQkmTZkP0XBS7fntx8xZbfRfM93L9Iq+98qsf41sf9e9UXuOFdPxJDcCe//
         0SfvGByc0elygd4HhrEicAgrv0iYL4GlSKOGZBO4XROuZP1uzE3aASQBWLDmU3hMKpfT
         D4pU8LJ9RQhaj4hXulcSkGikw88H81qGbVGi9ed3MqHZiow7tMrKe1S+vznYvJdc3IxX
         WZh++mhNf6fHLgcH3AKY7XwBMie3EiDqzE6hFjvGY4CCT3MJcVHOEc2gd44iXGss0pXa
         u+kQ==
X-Gm-Message-State: AOAM533uofLd+Aoc4JM04HDrXatzPzFiYXJ0GupRAR4zZAHkLWVArOFo
        NcswTMSLYu/Wi3iTL3DZFiS+Fv3H/q+U1VpD8Qt/6ZmueZNJxBEuc3qZkOa8mVGUZY6x9dyonx3
        JoyvVcnepxVx6G5n6x29LbXIa
X-Received: by 2002:a05:6214:2421:b0:45a:ee0d:822a with SMTP id gy1-20020a056214242100b0045aee0d822amr6836129qvb.102.1651970495556;
        Sat, 07 May 2022 17:41:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwHNVatmx4PKQQeJ08ZHWBq5vL2iTwBNiLjsKCICf5mUTNWA/XcoQxUBtAFwD/8xNhk+xa8A==
X-Received: by 2002:a05:6214:2421:b0:45a:ee0d:822a with SMTP id gy1-20020a056214242100b0045aee0d822amr6836120qvb.102.1651970495357;
        Sat, 07 May 2022 17:41:35 -0700 (PDT)
Received: from [10.23.153.165] ([46.248.132.196])
        by smtp.gmail.com with ESMTPSA id z11-20020ac8454b000000b002f39b99f6aasm4976079qtn.68.2022.05.07.17.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 May 2022 17:41:34 -0700 (PDT)
Message-ID: <62cc2efa-6a47-4426-c115-3ebc2303a7d3@redhat.com>
Date:   Sun, 8 May 2022 02:41:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 0/5] memblock tests: update style of comments
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>, outreachy@lists.linux.dev
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1651357434.git.remckee0@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <cover.1651357434.git.remckee0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.05.22 00:49, Rebecca Mckeever wrote:
> These patches update the style of comments for memblock_add_*(),
> memblock_reserve_*(), memblock_remove_*(), and memblock_free_*()
> functions to match the style of comments in tests/alloc_*.c and
> remove extra spaces in those comments to conform to Linux kernel
> coding style. This completes an item from the TODO list.
> 
> Rebecca Mckeever (5):
>   memblock tests: update style of comments for memblock_add_*()
>     functions
>   memblock tests: update style of comments for memblock_reserve_*()
>     functions
>   memblock tests: update style of comments for memblock_remove_*()
>     functions
>   memblock tests: update style of comments for memblock_free_*()
>     functions
>   memblock tests: remove completed TODO item
> 
>  tools/testing/memblock/TODO              |   3 -
>  tools/testing/memblock/tests/basic_api.c | 392 ++++++++++++++++-------
>  2 files changed, 278 insertions(+), 117 deletions(-)
> 
> ---

Series

Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks!

-- 
Thanks,

David / dhildenb

