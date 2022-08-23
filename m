Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCE059E3D3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243444AbiHWMeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 08:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349547AbiHWMbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 08:31:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B4B206
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661247903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CRVlovo98Y63Ora7pIDLAYaVags/Zx8gD9Y9NQogzCI=;
        b=TYM//Z1qd0fnLvrEn1Wk/1ICQhv37mvsCc2rZixaDR4emxTk/NFPcCmqMEEyZVRx6VLSoc
        gmYwlf7KkAjRleDUOrK1icajYa2PuQ4VD0kOnI2RnVnjxrg+sIjkkLFsqGVncUQwpOLb6g
        SPDbfxkpQmFhbSI5hksNhwHdu9qRGOA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-85-Fdmxe_6KNMuedw8vjC4GFg-1; Tue, 23 Aug 2022 05:37:56 -0400
X-MC-Unique: Fdmxe_6KNMuedw8vjC4GFg-1
Received: by mail-wr1-f69.google.com with SMTP id h21-20020adfaa95000000b002252a5b0917so2112812wrc.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=CRVlovo98Y63Ora7pIDLAYaVags/Zx8gD9Y9NQogzCI=;
        b=GcthvLfSji+IQ5TldftCWTFc6881T8FJobgK5mNHnW55FHBVGsJmT3+rjcNp8RFxby
         x2KGE+KCf3ETXFKLZRDRKBbqFIbk0B6nX7gTsUELpdPrRdChbzZORXesh0FOY0BAGKXY
         7J7wv4Bnk1u3QJZAAywNEmI3PRr+FpR027emldY0oN4vqc+JGTN7Z7ZcPJlhDGUjuc2p
         KvXjQAKfybOMWVg5Cg1s/oI80cGqBip8QPL6CAnUVaYXHV5vCi0g3cjeXgVVeprPLqnM
         kxaMAT/aoR75PJgRt+C69Q2gyUfDIPkrcihAi6Hruibzs/+VHf5Y6HAXA/uYGYKrtblk
         bUzQ==
X-Gm-Message-State: ACgBeo3fUH268kiZenlnfOeHkf04mCpzE3n6HxPtOUr4pjJL3LHiFStz
        qr2ml+621J+XJaHHuR2BqHcE1vHhCAc+4BZ/togJX2XpJ4pLcvO0hs59loUL0iuvXJ56ddALLKK
        5Z4ss2Hqoyj5h7QHF8CjzyqyW
X-Received: by 2002:a05:6000:18a2:b0:221:7db8:de02 with SMTP id b2-20020a05600018a200b002217db8de02mr13027301wri.132.1661247475585;
        Tue, 23 Aug 2022 02:37:55 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5NNxDZo0JtEBe15rIXcKpNp2OSAcdwyisFO81B1Fq3JNCTxzQZ5cbS5nYZUBA1gkycfelrxA==
X-Received: by 2002:a05:6000:18a2:b0:221:7db8:de02 with SMTP id b2-20020a05600018a200b002217db8de02mr13027291wri.132.1661247475359;
        Tue, 23 Aug 2022 02:37:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:1600:c48b:1fab:a330:5182? (p200300cbc70b1600c48b1faba3305182.dip0.t-ipconnect.de. [2003:cb:c70b:1600:c48b:1fab:a330:5182])
        by smtp.gmail.com with ESMTPSA id g17-20020a5d46d1000000b0020fff0ea0a3sm13697885wrs.116.2022.08.23.02.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 02:37:54 -0700 (PDT)
Message-ID: <fb230dec-cd9d-6543-fb7f-02016ca59245@redhat.com>
Date:   Tue, 23 Aug 2022 11:37:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/8] memblock tests: add labels to verbose output for
 generic alloc tests
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1660897732.git.remckee0@gmail.com>
 <b68f49313bb64305b23168953a2802f27878f953.1660897732.git.remckee0@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <b68f49313bb64305b23168953a2802f27878f953.1660897732.git.remckee0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.08.22 10:34, Rebecca Mckeever wrote:
> Generic tests for memblock_alloc*() functions do not use separate
> functions for testing top-down and bottom-up allocation directions.
> Therefore, the function name that is displayed in the verbose testing
> output does not include the allocation direction.
> 
> Add an additional prefix when running generic tests for
> memblock_alloc*() functions that indicates which allocation direction is
> set. The prefix will be displayed when the tests are run in verbose mode.
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

