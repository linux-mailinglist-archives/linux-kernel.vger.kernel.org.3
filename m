Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A84C4B9B91
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238266AbiBQI5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:57:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238253AbiBQI5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:57:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04BA125EAC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 00:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645088220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m+PV3OZADpNe2kw4Z7nkM5UpGpDI3QTeZpn64zU3Xck=;
        b=MJDOJuJSO9jjentIstg8YlcRPtQpUvjg+AlRGDYOdoovdTzOMLvL9cQ6bMY0qztMYpliiF
        FmD7LIspwtPCfybZd+uwhHomkWuLG++MNhpno5IUUVtBFO6R5bpgxF4C1zJzzGR3v9W8Pq
        IMJzMbRzBc5UBU/gQUYP0ZcvEXjtjXA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-UoKsbixqM2e3p3iR_0pk_g-1; Thu, 17 Feb 2022 03:56:58 -0500
X-MC-Unique: UoKsbixqM2e3p3iR_0pk_g-1
Received: by mail-ej1-f72.google.com with SMTP id gn20-20020a1709070d1400b006cf1fcb4c8dso1194190ejc.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 00:56:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=m+PV3OZADpNe2kw4Z7nkM5UpGpDI3QTeZpn64zU3Xck=;
        b=BT5ZubwmUa9Gs3v4ahr+rm28I7q64NUSJoLCnHvgz48jk5Q1mcSBmCAelpfe+wujpu
         h4icr/zSq5RcbMe1OxUUBfD07oCYHYTVbgDBZ2eES0Te30sRPjFOPlwYvdinjdS0Imfq
         7eC+Lh7BA6GUjyonSiOZUx6/GBkdaSrAORiSfo+mWt1PhAPhF2cpar5wvWTN9c23CfOA
         nWfjR+0hkrK8jf7xUy32XYlAFCMWwSv67vwolWOaCF7Mle49hNaDgxcjf2PNX9oDx5LN
         h3nOh5rWMsSNxQ8XGTSNfA6nKk3+nBSMi9YkGFySp14N2RoYG8l7/vJN4us1R+GHpuWf
         srog==
X-Gm-Message-State: AOAM532nePryhFjQ2F9DoMskVc3HxHWICuBj7IWaN0Mb2FxG9rgqhVIi
        RQ/kkgn2saFRR1OPGR7pEyUonmhDXyuckmE2XQB6OuCl7lWMoarB2rSLbnKQyHaRQCwI+G3MLgF
        M9LvWR2Zli+mv6v6SGq8fRUer
X-Received: by 2002:a17:906:5804:b0:6ce:3f17:bf35 with SMTP id m4-20020a170906580400b006ce3f17bf35mr1503345ejq.346.1645088217579;
        Thu, 17 Feb 2022 00:56:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzNvgzq7ojbEwxfSo08JfU/P8TRiyKKW/bXmQmsDhGqyNsIPeOpkuAQDMeGfQXZomm/oDkzZQ==
X-Received: by 2002:a17:906:5804:b0:6ce:3f17:bf35 with SMTP id m4-20020a170906580400b006ce3f17bf35mr1503325ejq.346.1645088217320;
        Thu, 17 Feb 2022 00:56:57 -0800 (PST)
Received: from ?IPV6:2003:cb:c711:b800:254c:2d22:aab2:20a? (p200300cbc711b800254c2d22aab2020a.dip0.t-ipconnect.de. [2003:cb:c711:b800:254c:2d22:aab2:20a])
        by smtp.gmail.com with ESMTPSA id c5sm2914605edk.43.2022.02.17.00.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 00:56:56 -0800 (PST)
Message-ID: <aa1f2e9f-d165-e4a4-d5c3-d285dae4e1a0@redhat.com>
Date:   Thu, 17 Feb 2022 09:56:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] mm: fix dereference a null pointer in
 migrate[_huge]_page_move_mapping()
Content-Language: en-US
To:     =?UTF-8?B?5p2O5Yqb55C8?= <liqiong@nfschina.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20220217063808.42018-1-liqiong@nfschina.com>
 <Yg35UXjB7RpqVCOI@kroah.com>
 <d29fd91b-2043-0880-17ab-0ef7ec14bf62@redhat.com>
 <8f00ecbf-245d-f063-40a3-4aaa77680b73@nfschina.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <8f00ecbf-245d-f063-40a3-4aaa77680b73@nfschina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.02.22 09:48, 李力琼 wrote:
> 在 2022/2/17 下午3:51, David Hildenbrand 写道:
>> On 17.02.22 08:29, Greg KH wrote:
>>> On Thu, Feb 17, 2022 at 02:38:08PM +0800, liqiong wrote:
>>>> Upstream has no this bug.
>>> What do you mean by this?
>>>
>>> confused,
>> Dito. If this is fixed upstream and broken in stable kernels, we'd want
>> either a backport of the relevant upstream fix, or if too complicated, a
>> stable-only fix.
>>
>>
> There is a wrong describe， i thought 'Upstream' as the newest code.
> The newest code has no this bug, i should submit this patch to "longterm:4.19".

See https://www.kernel.org/doc/Documentation/process/stable-kernel-rules.rst

Make sure your patch subject starts with something like "[PATCH 4.19
STABLE]" and that your patch targets that stable branch.

Make sure to describe why it doesn't apply to upstream, how it was fixed
upstream, and why we cannot simply backport the upstream way to fix it.

Thanks!

-- 
Thanks,

David / dhildenb

