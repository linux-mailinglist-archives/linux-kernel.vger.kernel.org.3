Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA9E5546AC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbiFVKAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbiFVKAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:00:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53CA73A18D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655892009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IkMvOPfdMWwswbFZMxK+E4fP6g4yd53+UQxz7jPKZx4=;
        b=VfIzsMGs0AcTA/yWZxza3FpsgzubV/J0C6B/CMhRxkBuIpq+2DapCtGYTK1+zjlepKeapi
        UYU0iK3iMy678Zhp8QZIJLo2nEBlfRV17/tOKiXCxQaQqmA0n/aMLqcI5gGVX19oqHYoaN
        oCtkbizKyYesndADI5XcgahfTmbVvDg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-496-fzhECZ5IOKWwwFrfOV2HOw-1; Wed, 22 Jun 2022 06:00:07 -0400
X-MC-Unique: fzhECZ5IOKWwwFrfOV2HOw-1
Received: by mail-wm1-f72.google.com with SMTP id k5-20020a05600c0b4500b003941ca130f9so5348721wmr.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:00:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=IkMvOPfdMWwswbFZMxK+E4fP6g4yd53+UQxz7jPKZx4=;
        b=S7XUCedpkFvgNHrAzSlvkASGTt+j2Oh+wthW0k2diq3jMg28JDnNhUz8nGkFRTQ/PS
         wP6BRhc/nocvWdnGg2LagEhXc2ATjKH+KIcKzpkbeqFBxfpnKpbICrajjhUD+DIKuVc8
         8C90xx89F+/39gKL5fvBu4c178V/a5RazL++9VpOs/PfAtd2h7IJ5gTX2hGHNBwPYBwO
         +JwKQ2ZI/jZ10PnxlaW5odOdG1lF+e9O8cpcgIyHQkFUL0MkE2Ni1/iCH6KQe6usux2j
         30JuRGvSC/YvgRCElvCwqxoz2q0b15b72cGuBjacYurd+ZqU5SjEyWRw7TbQgRQBLTmQ
         wHDA==
X-Gm-Message-State: AJIora9eSf8FWMw5yKxbV37/mQui/11ci5UUkmsiRisAR44jRkpISNVf
        22jyBQNT5gj01dLHf/TJnJOGEhrPBHiu44btYY2XXjWm79sSprx6AAi8L6mZNC9lNAdFmlW//Xy
        vceorl618PsLdkhMvfCjdQFz3
X-Received: by 2002:a05:600c:3d0e:b0:39e:fb96:7f21 with SMTP id bh14-20020a05600c3d0e00b0039efb967f21mr2993523wmb.133.1655892006757;
        Wed, 22 Jun 2022 03:00:06 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t8BYwFIA5ilB+fEglZ025uq/shC1UBoMOOlUTgU4/sXPxstdRr6VAUvRBbIySuyxGQP+Zs8Q==
X-Received: by 2002:a05:600c:3d0e:b0:39e:fb96:7f21 with SMTP id bh14-20020a05600c3d0e00b0039efb967f21mr2993495wmb.133.1655892006453;
        Wed, 22 Jun 2022 03:00:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:5100:9c77:ce13:2aeb:8748? (p200300cbc70351009c77ce132aeb8748.dip0.t-ipconnect.de. [2003:cb:c703:5100:9c77:ce13:2aeb:8748])
        by smtp.gmail.com with ESMTPSA id bj19-20020a0560001e1300b0021b9f126fd3sm1649366wrb.14.2022.06.22.03.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 03:00:06 -0700 (PDT)
Message-ID: <0754cefe-e8e1-6eec-cad0-35c081c880d7@redhat.com>
Date:   Wed, 22 Jun 2022 12:00:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 0/4] memblock tests: add VERBOSE and MEMBLOCK_DEBUG
 Makefile options
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1655889641.git.remckee0@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <cover.1655889641.git.remckee0@gmail.com>
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

On 22.06.22 11:29, Rebecca Mckeever wrote:
> These patches add options VERBOSE and MEMBLOCK_DEBUG to Memblock
> simulator, which can be specified when running make. These patches also
> implement the functionality for these options.
> 
> VERBOSE
> Usage:
> 
> $ make VERBOSE=1
> 
> Passing VERBOSE=1 will enable verbose output from Memblock simulator. For
> each test, the verbose output includes the name of the memblock function
> being tested, the name of the test, and whether the test passed or failed.
> Since all the tests in Memblock simulator run as one monolithic test, this
> output is a quick way to get a summary of test results.
> 
> MEMBLOCK_DEBUG
> Usage:
> 
> $ make MEMBLOCK_DEBUG=1
> 
> Passing MEMBLOCK_DEBUG=1 will enable memblock_dbg() messages. These
> are debug messages built into several functions in memblock that include
> information such as the name of the function and the size and start and
> end addresses of the memblock region.
> 
> Rebecca Mckeever (4):
>   memblock tests: add user-provided arguments to Makefile
>   memblock tests: add verbose output to memblock tests
>   memblock tests: set memblock_debug to enable memblock_dbg() messages
>   memblock tests: remove completed TODO items
> 
>  tools/testing/memblock/Makefile               |   4 +
>  tools/testing/memblock/README                 |  10 +-
>  tools/testing/memblock/TODO                   |  14 +-
>  tools/testing/memblock/internal.h             |   7 +
>  .../testing/memblock/scripts/Makefile.include |  10 +
>  tools/testing/memblock/tests/alloc_api.c      | 241 ++++++++----
>  .../memblock/tests/alloc_helpers_api.c        | 135 +++++--
>  tools/testing/memblock/tests/alloc_nid_api.c  | 371 ++++++++++++------
>  tools/testing/memblock/tests/basic_api.c      | 365 ++++++++++++-----
>  tools/testing/memblock/tests/common.c         |  58 +++
>  tools/testing/memblock/tests/common.h         |  54 +++
>  11 files changed, 913 insertions(+), 356 deletions(-)
> 
> ---
> Changes
> 
> v1 -> v2
> PATCH 2, in common.c:
>   Remove #ifdef VERBOSE around prefixes and related constants
>   Add __maybe_unused to prefixes
>   Move PREFIXES_LEN_MAX, DELIM, and DELIM_LEN so that they are
>     immediately after the other constants
>   Add #ifdef VERBOSE around definitions for test_*() and prefix_*()
> 
> v2 -> v3
> PATCH 1:
>   Add Reviewed-by tag
> ---
> 

Hi Rebecca,

no need to resend a new version that frequently; wait for more feedback
first.

Usually, people expect a new version when there hasn't been more review
feedback for a few days.

Also, there is usually no need to send a new version when you get a
rb/ack tag: the maintainer might just pick them up when applying the
patches.

-- 
Thanks,

David / dhildenb

