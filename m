Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810834F1606
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 15:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354992AbiDDNjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 09:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354683AbiDDNjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:39:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A3ED3DA7E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 06:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649079467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jQvLoKlrABbqIctyIUROGClX4i0qGIlwv3fYjTBt7+Y=;
        b=hRS1bZ58RUS3vsOwlKumHSwUsdt39hZTVx0t615Pl+UHJpdGnmV+towpHelN5gpADLvjOo
        hDMF4msGVuIIfYvnjKp3rx1f0TZ5Qn7P0LO6DHm0F+TZtRdeUV2f1nigialwyaE6HSm205
        3x8eAEcT25wk2ONCq41UmlmuuhXmDbY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-quPPbVorM3GAm45Or9i1dA-1; Mon, 04 Apr 2022 09:37:39 -0400
X-MC-Unique: quPPbVorM3GAm45Or9i1dA-1
Received: by mail-wm1-f72.google.com with SMTP id r6-20020a05600c35c600b0038e6db5da9cso821726wmq.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 06:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=jQvLoKlrABbqIctyIUROGClX4i0qGIlwv3fYjTBt7+Y=;
        b=bLudeQSWljFCnCdL+VevTkxGqesL7FKDSUBTL9BVLr+v1LnvEBOjX9gRf2lrpRYwkZ
         oLn2KAnwLHVhRBf9aYRR7P1cbDr/RZ7LMuk28bgQ5KfUY+C1HoeU08omjxKSd6QlNjUc
         PXqRDBfHGm8Qz/LFNQs5gwAcJCgjbNEyfEcgLz0Pkak2LND87fZJoLKC3lOaXO65bgck
         LH/9WcoyecWARRxmBHEMPudwbWporDCtYCN8t3qsLDtKbNkTtKlsVzz0UhioWzfARlB3
         9PoMHyGys3vT4P5pKmE0kjUB0XgNfC19v933sXK1lS4suZNqRuVGsR65qPCck6Y6e3h8
         2wIw==
X-Gm-Message-State: AOAM533lMvxi5XF2jlCIcwidYH6vuTlkbM9o17MhrUDS050Yi7pk4W5n
        2RYPLGDMvbgFObwGlT6EmW6ZYA8+8fW531T0eJnjHsch10szXI4vEyt5OijHo0A5SdzP/iJbVZq
        TuLM9cecsXioPCuyC89bAJ6od
X-Received: by 2002:adf:914f:0:b0:1ed:bb92:d0cc with SMTP id j73-20020adf914f000000b001edbb92d0ccmr17053054wrj.297.1649079458487;
        Mon, 04 Apr 2022 06:37:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1E8fYvOP0IaOzRyeEC7XVJ6g436XRj+7kMCuM/Z2olmC4aFghSJXcacegyMJ49gpuImGpyQ==
X-Received: by 2002:adf:914f:0:b0:1ed:bb92:d0cc with SMTP id j73-20020adf914f000000b001edbb92d0ccmr17053037wrj.297.1649079458195;
        Mon, 04 Apr 2022 06:37:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:4100:c220:ede7:17d4:6ff4? (p200300cbc7044100c220ede717d46ff4.dip0.t-ipconnect.de. [2003:cb:c704:4100:c220:ede7:17d4:6ff4])
        by smtp.gmail.com with ESMTPSA id l4-20020a5d5604000000b0020615e8d2b4sm1907903wrv.47.2022.04.04.06.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 06:37:37 -0700 (PDT)
Message-ID: <ac13a529-5000-19c9-bbd8-3ee634a923cc@redhat.com>
Date:   Mon, 4 Apr 2022 15:37:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] mm/swapfile: unuse_pte can map random data if swap read
 fails
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220401072926.45051-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220401072926.45051-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.04.22 09:29, Miaohe Lin wrote:
> There is a bug in unuse_pte(): when swap page happens to be unreadable,
> page filled with random data is mapped into user address space. The fix
> is to check for PageUptodate and fail swapoff in case of error.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/swapfile.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 63c61f8b2611..e72a35de7a0f 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1795,6 +1795,10 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>  		ret = 0;
>  		goto out;
>  	}
> +	if (unlikely(!PageUptodate(page))) {
> +		ret = -EIO;
> +		goto out;
> +	}

Yeah, we have the same handling in do_swap_page(), whereby we send a
SIGBUS because we're dealing with an actual access.

Interestingly, folio_test_uptodate() states:

"Anonymous and CoW folios are always uptodate."

@Willy, is that true or is the swapin case not documented there?

-- 
Thanks,

David / dhildenb

