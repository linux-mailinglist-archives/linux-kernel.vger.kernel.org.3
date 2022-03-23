Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E05B4E4E8C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 09:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242889AbiCWIvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 04:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237342AbiCWIvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 04:51:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FDF2710E6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 01:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648025391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DuaFBfkU5mZppkqVIrrjjLRuEeroDbRieuMkt8MGpmI=;
        b=PzAnbJaurH7sZ8JLSeqQUynwFNgfH1CeXZugKuT7Hsp7tVR9yN0+3296SrJx95RhwRAK95
        OmkfbPn8R7Gvmgl1yFggfzEXNWv3RUScRqDakx2oiMnqJlMWAMAXaX8SA1+bkToA+4QpXQ
        V95subUEe/TtL7SjIE5BQZQ7xzatTi4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-266-z--uxB0GPBedGSm3gxW_Pg-1; Wed, 23 Mar 2022 04:49:50 -0400
X-MC-Unique: z--uxB0GPBedGSm3gxW_Pg-1
Received: by mail-wr1-f71.google.com with SMTP id z16-20020adff1d0000000b001ef7dc78b23so267229wro.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 01:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=DuaFBfkU5mZppkqVIrrjjLRuEeroDbRieuMkt8MGpmI=;
        b=wjYDPPgE14vFXGpBCiG65h3U0Bd2ySV+iO3LUpHtsVwklx690uWLpddhScmKvgimf6
         3+e9y/yzwuxGtqq9mq2Arelre1V4JKysZupOsqebTUb4l+D0PODI2CVFLpFCokIPqsNg
         tlNtyjb4+yGFho6w1vrxR1C4gTb2pJ9nWwnW2Af21iRwImR8BtbTahcNk/dlIu/789Ae
         wsWTxeLFtgm6gAxNu7gpkSXfXQB+jWWdVfrIPk+hjuaKbNDo6DlMetMgPL7AAJ/Rd+6d
         RTWEXODLWLXcObtALx08CoGAXIRjZZRLEZQZOVP0U8B0gT6wG9vtWSGQesXg0wSgGGGu
         TsSw==
X-Gm-Message-State: AOAM530WReeU15FB8eSmvsqsMibVP69IuOr41Mqg7DRk7mYEBe6hWKk0
        pjl4pU8CzSJCc4z3fEYryJVXA1MiAE+QWnu8dzX8gfvP99h/hCoP9+yw3S1mRcMWnWYx5u8EY02
        LZjiGOOuAs+wGk/4UZ04qa3XO
X-Received: by 2002:a5d:6f11:0:b0:203:ff6b:5df9 with SMTP id ay17-20020a5d6f11000000b00203ff6b5df9mr17313711wrb.361.1648025389205;
        Wed, 23 Mar 2022 01:49:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSnr0uXtRn05WsTbb0UWoFxm84f7c+DyhXxFVQhbmoS9ZDQtkNLkurqKhCs1uameHDB7HjEQ==
X-Received: by 2002:a5d:6f11:0:b0:203:ff6b:5df9 with SMTP id ay17-20020a5d6f11000000b00203ff6b5df9mr17313695wrb.361.1648025388968;
        Wed, 23 Mar 2022 01:49:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:a300:f7c1:f4a5:f958:a561? (p200300cbc704a300f7c1f4a5f958a561.dip0.t-ipconnect.de. [2003:cb:c704:a300:f7c1:f4a5:f958:a561])
        by smtp.gmail.com with ESMTPSA id e8-20020a056000178800b00203da3bb4d2sm18730863wrg.41.2022.03.23.01.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 01:49:48 -0700 (PDT)
Message-ID: <9f9ddbf7-797a-58d8-2903-beacb2698329@redhat.com>
Date:   Wed, 23 Mar 2022 09:49:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     cgel.zte@gmail.com, akpm@linux-foundation.org
Cc:     bsingharora@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
References: <20220322110444.2340748-1-yang.yang29@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] delayacct: track delays from COW
In-Reply-To: <20220322110444.2340748-1-yang.yang29@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.03.22 12:04, cgel.zte@gmail.com wrote:
> From: Yang Yang <yang.yang29@zte.com.cn>
> 
> Delay accounting does not track the delay of COW. When tasks trigger
> much COW, it may spend a amount of time waiting for it. To get the
> impact of tasks in COW, measure the delay when it happens. This
> could help users to do tunnings, such as decide whether to use
> ksm or not.
> 
> Also update tools/accounting/getdelays.c:
> 
>     / # ./getdelays -dl -p 231
>     print delayacct stats ON
>     listen forever
>     PID     231
> 
>     CPU             count     real total  virtual total    delay total  delay average
>                      6247     1859000000     2154070021     1674255063          0.268ms
>     IO              count    delay total  delay average
>                         0              0              0ms
>     SWAP            count    delay total  delay average
>                         0              0              0ms
>     RECLAIM         count    delay total  delay average
>                         0              0              0ms
>     THRASHING       count    delay total  delay average
>                         0              0              0ms
>     COMPACT         count    delay total  delay average
>                         3          72758              0ms
>     COW             count    delay total  delay average
>                      3635      271567604              0ms

You should also update Documentation/accounting/delay-accounting.rst
most probably.

Overall LGTM and this might be of value not only for KSM but for anybody
using fork(). There will be collisions with [1], especially [2], which I
want to get in -next early after we have v5.18-rc1 (after rebasing [1]
on top of this).

We'll have to decide if we want to also account hugetlb wp code
(hugetlb_cow), and if we want to account "unsharing" here as well under
cow (I tend to say that we want to for simplicity). For THP, we only
split and don't copy, so there isn't anything to account.

[1] https://lore.kernel.org/r/20220315104741.63071-1-david@redhat.com
[2] https://lore.kernel.org/r/20220315104741.63071-14-david@redhat.com

-- 
Thanks,

David / dhildenb

