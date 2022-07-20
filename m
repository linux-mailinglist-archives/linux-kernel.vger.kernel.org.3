Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D6457B1E0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 09:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240089AbiGTHjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 03:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235565AbiGTHjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 03:39:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 751E767C89
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 00:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658302769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JRD5gze5iCgumqb7DRzeC17ppeyLAWxOOTxgcR3iPKc=;
        b=VhYGVJwCvqFptKJJ2roDyh6qwx9yCXmKsXJmSQuSkuTLjhPfpRr1L/2JMX/J0k0EAgsZZA
        E5EMPV4ZmCZX0Fga6cBBWS71NPpEcbceoQWLkwP+xsw0esvHy0MCSlYfp9cMVQtn+g6pqA
        rChWMlN8b9u7bGLirKJTB6lUlOBHTeA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-FCe16L--PtaFm1MPCTj6kQ-1; Wed, 20 Jul 2022 03:38:43 -0400
X-MC-Unique: FCe16L--PtaFm1MPCTj6kQ-1
Received: by mail-wr1-f72.google.com with SMTP id q9-20020adfb189000000b0021e3e7d3242so731302wra.19
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 00:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=JRD5gze5iCgumqb7DRzeC17ppeyLAWxOOTxgcR3iPKc=;
        b=J546P3bVDjeVlNdIrWVLUN/eMG0qa2Tg+wtN+UG2nu4U6DF4Hu3fCx3z06hUCfaQ8b
         ZFpL92et2JMkNiQtLyyzAK4FuVFHjmDj/S5AZ0JRVp7IvbJ9WNU9TiMV48ujC0LnreC0
         mQt8ckXpEzbb41eMqjngSGdbVvgjKx3G5hXgU9BFPaM9/wHxIsYhCnmWvhXaJNYri/bD
         VLb2Qa6BrRRhHd33EE9XMw1GYMpLLcLTLBHQcu/5Tlcu7JmQcarwiXS1jMB7bwRI6trs
         OQxif7g6bdPBO3HvD7UhS7XlGL3sFxnJJ8PMUsh+f+VjU+gNbivRN8XjaBr/F77Y/bbi
         Nz+Q==
X-Gm-Message-State: AJIora8yy6Nk88rqiv/cbROw+iG8Gk9dWGCwWW/N992AyeheO5R31oZ+
        fxEatkAc7J99UUB9vvDmw1v3AI4LDouq/nbo03QOlIHvDy/l5wSF6Sh4gKOXo6qO9s7jLHm1Bx/
        BdqXeB5isObiXPuJpLMAwgTfI
X-Received: by 2002:adf:fb86:0:b0:21e:3cc8:a917 with SMTP id a6-20020adffb86000000b0021e3cc8a917mr5058444wrr.538.1658302717046;
        Wed, 20 Jul 2022 00:38:37 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sIHxRRulozed77eh09MMR3TpyPXp6QvGSSUylqHFikk73Szma/PVU/ZZnOsW9vrL/e0eKrOA==
X-Received: by 2002:adf:fb86:0:b0:21e:3cc8:a917 with SMTP id a6-20020adffb86000000b0021e3cc8a917mr5058437wrr.538.1658302716785;
        Wed, 20 Jul 2022 00:38:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:e00:8d96:5dba:6bc4:6e89? (p200300cbc7060e008d965dba6bc46e89.dip0.t-ipconnect.de. [2003:cb:c706:e00:8d96:5dba:6bc4:6e89])
        by smtp.gmail.com with ESMTPSA id co18-20020a0560000a1200b0021b5861eaf7sm14998954wrb.3.2022.07.20.00.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 00:38:36 -0700 (PDT)
Message-ID: <2551d5bf-63f1-f3f3-0971-930923c4c087@redhat.com>
Date:   Wed, 20 Jul 2022 09:38:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] memblock tests: change build options to run-time options
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220714031717.12258-1-remckee0@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220714031717.12258-1-remckee0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.07.22 05:17, Rebecca Mckeever wrote:
> Change verbose and movable node build options to run-time options.
> 
> Movable node usage:
>     $ ./main -m
> 
>     Or:
>     $ ./main --movable-node
> 
> Verbose usage:
>     $ ./main -v
> 
>     Or:
>     $ ./main --verbose
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>

LGTM, thanks!

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

