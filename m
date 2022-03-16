Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14B24DB451
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240477AbiCPPKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357021AbiCPPKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:10:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72CE2673E1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 08:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647443346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q3DnrzNIWK5lpwiizhurtr0FleyyyipHQEpXQTzwkW4=;
        b=OrZIWuS7OrW5YXzYwGe7r897ZHBIZIrokAXDEffnHcAhPhO1zNCXvaJsXQ3sBFQ52VA67Y
        +dAd5EUCUc8qUIKJ69mHC2EYvQ8yJajUctSkh6KtHouRByAhYXlF47I8QRbkah4MR87gtg
        4snVMTYjxjxj7/HxrSkhVyCOuksybR0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-BYDh9V_BPV-cnrEAKuledg-1; Wed, 16 Mar 2022 11:09:05 -0400
X-MC-Unique: BYDh9V_BPV-cnrEAKuledg-1
Received: by mail-wr1-f70.google.com with SMTP id p18-20020adfba92000000b001e8f7697cc7so655096wrg.20
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 08:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=q3DnrzNIWK5lpwiizhurtr0FleyyyipHQEpXQTzwkW4=;
        b=SdCZMobSV/lbWIEuIC2ZeYgSLMX8A4d3mpCPw3zO3GSVY7Cn4G0nPfnShY4dC1wtc0
         exmVHMjXdQ6YCGs48E3VHr/5CYpCg+jeHQr8bMorhzRxRDyYT1C4jBuAOCYQw2rkew3g
         opyp+H1Lqzwqi+TRhOOZAHif/DhOaImqzdMcpwa/iM43VrFGHhLjUR7NQECPeUCg7veo
         PajObFmyoLtsLWMGgKv1KqgwY01OXNFLpZ3h3Go4mvLlIz6cWZhdpz9MRVLgr9y/6bbB
         CTZ2EdbnMilwKQoH0Ue9VEdXTlIvK+SE6H8YeVRf5/7ayYuHVM1IzCuAqHB1nQkk0PVq
         IyQQ==
X-Gm-Message-State: AOAM532qzuXk79iQVL+Js1mKZvgOPgw8VvPlk3UoNBb0H0phI/wHuVXg
        fNM17OuPSWgqvPMG00ek7JDpojgWkFCS5J122yG42n3s7lxP4OPfBA+oxQ858QoiQBcrruIW2Fu
        hM1Xjqy2uT8IPAi8xntP1uNDh
X-Received: by 2002:a5d:4487:0:b0:1f1:232b:794f with SMTP id j7-20020a5d4487000000b001f1232b794fmr282045wrq.715.1647443343781;
        Wed, 16 Mar 2022 08:09:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdGMAOtiEgH+F8EM8SK3ODiymGuIa/tjM0Wd/84EkJ4ZNTP9/YNOOhdV9pi6WwJFJAXQUx6g==
X-Received: by 2002:a5d:4487:0:b0:1f1:232b:794f with SMTP id j7-20020a5d4487000000b001f1232b794fmr282025wrq.715.1647443343525;
        Wed, 16 Mar 2022 08:09:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:f900:aa79:cd25:e0:32d1? (p200300cbc706f900aa79cd2500e032d1.dip0.t-ipconnect.de. [2003:cb:c706:f900:aa79:cd25:e0:32d1])
        by smtp.gmail.com with ESMTPSA id z2-20020a056000110200b001e7140ddb44sm1849465wrw.49.2022.03.16.08.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 08:09:03 -0700 (PDT)
Message-ID: <a1e0a9e9-07ef-8d1c-a409-2b4fb12ed553@redhat.com>
Date:   Wed, 16 Mar 2022 16:09:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [RFC PATCH V1 0/3] mm/damon: Add CMA minotor support
Content-Language: en-US
To:     Xin Hao <xhao@linux.alibaba.com>, sj@kernel.org
Cc:     rongwei.wang@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1647378112.git.xhao@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <cover.1647378112.git.xhao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.22 17:37, Xin Hao wrote:

s/minotor/monitor/

> The purpose of these patches is to add CMA memory monitoring function.
> In some memory tight scenarios, it will be a good choice to release more
> memory by monitoring the CMA memory.

I'm sorry, but it's hard to figure out what the target use case should
be. Who will release CMA memory and how? Who will monitor that? What are
the "some memory tight scenarios"? What's the overall design goal?

-- 
Thanks,

David / dhildenb

