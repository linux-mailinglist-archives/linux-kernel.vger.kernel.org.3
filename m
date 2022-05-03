Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E803518113
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 11:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbiECJgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 05:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiECJgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 05:36:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FBC228E2D
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 02:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651570365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QO7u9m/33fXuqnKaaI9617/vJfWpf9h0WEBZgCNeDpE=;
        b=HtrKcEq37lZjOc4UbYiNiCSxgHi1DnxAw5inxH/aTqjw+xzmPCJxpzNchx3a6GTkx1Ednp
        GupuZhCX+oa8m2u0cweBAA8jRen814sQ3UrpTG6mHaAoWfq25gSRYwKqX23TsAnWHsxNNG
        ndWz8M04ds/G5UXe+LU66kg8FT0crpA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-avCOQNVeNiG23yaRsfJHFw-1; Tue, 03 May 2022 05:32:44 -0400
X-MC-Unique: avCOQNVeNiG23yaRsfJHFw-1
Received: by mail-wm1-f72.google.com with SMTP id n186-20020a1c27c3000000b00392ae974ca1so624601wmn.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 02:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QO7u9m/33fXuqnKaaI9617/vJfWpf9h0WEBZgCNeDpE=;
        b=3kU6Llf48ld/C8UQFRpZ7mscXWd+NqB3xgMlBu/+F4jdjRB9uojCLYeBkA7XQ9J0LR
         4HmmakP+VOWt+6cPJiF2vtpDjmmL/aKoZ0x/IEV1xCIGe72nKSnEb8gPDB/vYejGhFBy
         fIHJcBNMD4dYQg2jLrtSjGHGxx5l0Trnikjacvk53aYvqbeVb+teJ8JF/SkAHz6c0CHg
         gQLWEUxSujDB6a+bNeyhrDvccvHfCx8AiXeL49GK8LXDhgmB4ao7Lrkr5CKN1yWbUEEy
         o/oTXqnt8jaCH6pUjuJ8hu9qekB3MoMvUCbpfYP/A7qpz3cYtioW8oG23+YNOk4g0YRR
         9A7w==
X-Gm-Message-State: AOAM5328+vFMmTWcyiXJPSpU7z4nNU3U3XhpGJJOaUBHPfigPS+hXEpQ
        /q3SWesN34pz4erRcNNDahHHL/ZJmIc+tHfYHR9ry923JRpNnKqFZTvDlB2frYxQhd7sFLEmMm/
        eAXr0ojVvVPqytajlLcauHxom
X-Received: by 2002:a05:600c:4e87:b0:394:4992:ab8a with SMTP id f7-20020a05600c4e8700b003944992ab8amr2548643wmq.97.1651570359984;
        Tue, 03 May 2022 02:32:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwWll5WaK675NsGg3hsRio/Tn5a0/PsUj7oJJ5eiLm4CLv1T7CdmkmxigBHV2lc+sjusW1sw==
X-Received: by 2002:a05:600c:4e87:b0:394:4992:ab8a with SMTP id f7-20020a05600c4e8700b003944992ab8amr2548626wmq.97.1651570359712;
        Tue, 03 May 2022 02:32:39 -0700 (PDT)
Received: from [10.32.181.74] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.googlemail.com with ESMTPSA id c3-20020adfc043000000b0020c5253d905sm11253866wrf.81.2022.05.03.02.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 02:32:38 -0700 (PDT)
Message-ID: <fa567ab7-bf5d-3c95-aea8-2dcba00d50cd@redhat.com>
Date:   Tue, 3 May 2022 11:32:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] KVM: x86/mmu: Speed up slot_rmap_walk_next for
 sparsely populated rmaps
Content-Language: en-US
To:     Vipin Sharma <vipinsh@google.com>
Cc:     seanjc@google.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, dmatlack@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220502220347.174664-1-vipinsh@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220502220347.174664-1-vipinsh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/22 00:03, Vipin Sharma wrote:
> Avoid calling handlers on empty rmap entries and skip to the next non
> empty rmap entry.
> 
> Empty rmap entries are noop in handlers.
> 
> Signed-off-by: Vipin Sharma <vipinsh@google.com>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> ---
> 
> v2:
> - Removed noinline from slot_rmap_walk_next signature
> 
> v1:
> - https://lore.kernel.org/lkml/20220325233125.413634-1-vipinsh@google.com
> 
>   arch/x86/kvm/mmu/mmu.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 77785587332e..4e8d546431eb 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -1501,9 +1501,11 @@ static bool slot_rmap_walk_okay(struct slot_rmap_walk_iterator *iterator)
>   
>   static void slot_rmap_walk_next(struct slot_rmap_walk_iterator *iterator)
>   {
> -	if (++iterator->rmap <= iterator->end_rmap) {
> +	while (++iterator->rmap <= iterator->end_rmap) {
>   		iterator->gfn += (1UL << KVM_HPAGE_GFN_SHIFT(iterator->level));
> -		return;
> +
> +		if (iterator->rmap->val)
> +			return;
>   	}
>   
>   	if (++iterator->level > iterator->end_level) {
> 
> base-commit: 71d7c575a673d42ad7175ad5fc27c85c80330311

Queued, thanks.

Paolo

