Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73C359DBD4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbiHWMR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 08:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353989AbiHWMOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 08:14:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FBEE9902
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661247573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tdpZcpZ9CAoMWvOU4u52qpOeJcc0NvknOBwRKuLXRGY=;
        b=ilAGyRzm8Vyi3TI+sQd/fuPNpJjS+S5EDaWmHiEDEOIMgVJEeWuBx+m9s/S8umXLoZ1PAI
        b2rr3D8MgqkqReeNF7QUQnSxXwlVUr6hkeGHBoStngg2SHF85Kgr6dqqyjBBm7x5+ZlzOS
        tzZ3F7NbVhElvJvuAhhFISr6fw51mnw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-34-AojcZbXgMG6Ai86EMMYcQg-1; Tue, 23 Aug 2022 05:39:32 -0400
X-MC-Unique: AojcZbXgMG6Ai86EMMYcQg-1
Received: by mail-wm1-f72.google.com with SMTP id m22-20020a7bca56000000b003a652939bd1so1231983wml.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=tdpZcpZ9CAoMWvOU4u52qpOeJcc0NvknOBwRKuLXRGY=;
        b=YyKrC8jBbp9U10vJ3xtOrk5EqHVKbpmEfJEUYy19ujjqHAo3SI2SPZjBF3sVIl4IxP
         l+W/DBgiNpu5gc28Ookdd/QgmrvAY2nO8XVJfLYwt3wKTlVitCIEtqpvXV7osOBWGiqB
         /n+IjSk6TLHjQnjrqeIJC1PvrkU9dbJVj14Epz0TMuzJijVTMnU1QTy6rBV7UF6EO2qS
         34cFXKJ0JgD53uqN5Sllnw5z3e4f0P8Ary2CJoKOL/c9H8lhCDSsh1RH/XYxZLbkJcPe
         2y+0WfcalWd7mS6vbLWqlYW6uEuJ7vnPFXL8y+3icjtQjIf1rMmIClhlxR5hHuiDuW0L
         YXkg==
X-Gm-Message-State: ACgBeo3dTqy6afGcZbesOYYAvPojRgXLgwUbywNGFd2CGA50BBjrD0Bj
        Lug3HrvGo/MiTH5EgFMz/bsEYSj9WrA/8+g3jcQRoRryzfcFtB8d15OLZW+IoEaNTRk0+YowZwN
        UOsA7HqixSvWGD8l6g6DzSBOc
X-Received: by 2002:adf:f743:0:b0:225:5132:379a with SMTP id z3-20020adff743000000b002255132379amr5854154wrp.561.1661247571325;
        Tue, 23 Aug 2022 02:39:31 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7OK9RNwoiKfRoHHyVrT9xLA2H8J4H1paEAH/U4GbHCCas8R9NbZAQEttdP4bnnw+I+jVjI9A==
X-Received: by 2002:adf:f743:0:b0:225:5132:379a with SMTP id z3-20020adff743000000b002255132379amr5854147wrp.561.1661247571102;
        Tue, 23 Aug 2022 02:39:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:1600:c48b:1fab:a330:5182? (p200300cbc70b1600c48b1faba3305182.dip0.t-ipconnect.de. [2003:cb:c70b:1600:c48b:1fab:a330:5182])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600c510400b003a5dde32e4bsm21918622wms.37.2022.08.23.02.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 02:39:30 -0700 (PDT)
Message-ID: <031e2b78-7356-013c-9375-5fa0c7deba9e@redhat.com>
Date:   Tue, 23 Aug 2022 11:39:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 4/8] memblock tests: add additional tests for basic api
 and memblock_alloc
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1660897732.git.remckee0@gmail.com>
 <c15e2b50ba481647e5fe9fd0be92af0768f35356.1660897732.git.remckee0@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <c15e2b50ba481647e5fe9fd0be92af0768f35356.1660897732.git.remckee0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.08.22 10:34, Rebecca Mckeever wrote:
> Add tests for memblock_add(), memblock_reserve(), memblock_remove(),
> memblock_free(), and memblock_alloc() for the following test scenarios.
> 
> memblock_add() and memblock_reserve():
> - add/reserve a memory block in the gap between two existing memory
>   blocks, and check that the blocks are merged into one region
> - try to add/reserve memblock regions that extend past PHYS_ADDR_MAX
> 
> memblock_remove() and memblock_free():
> - remove/free a region when it is the only available region
>     + These tests ensure that the first region is overwritten with a
>       "dummy" region when the last remaining region of that type is
>       removed or freed.
> - remove/free() a region that overlaps with two existing regions of the
>   relevant type
> - try to remove/free memblock regions that extend past PHYS_ADDR_MAX
> 
> memblock_alloc():
> - try to allocate a region that is larger than the total size of available
>   memory (memblock.memory)
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

