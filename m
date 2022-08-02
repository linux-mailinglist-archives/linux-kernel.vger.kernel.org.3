Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62899587E7E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 16:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236972AbiHBO7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 10:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbiHBO7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 10:59:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 777061EEC9
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 07:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659452375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TiEVWlyldriK6u+7IZclS64oyMv2tQAk41MyojiltD4=;
        b=hy8pn/cbvBX0kEdiSVCh/smgAkI+pvRli0UxJq9YHGTSGsrGZtCVavRkmvt6KUpD/n/WEK
        Z+UYNzzFV3UbPwtPcp9bly/1YFYALwMp2godAn/WKVQ4qSRetuCqVy88lSGTM3YQ0q2CWL
        LT4d3SR1GOha0ir3ZjE3XycsRI8Hen0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-35-sUT9OL9lNUKPkV9Wvxzazw-1; Tue, 02 Aug 2022 10:59:34 -0400
X-MC-Unique: sUT9OL9lNUKPkV9Wvxzazw-1
Received: by mail-wm1-f70.google.com with SMTP id ay19-20020a05600c1e1300b003a315c2c1c0so9600294wmb.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 07:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=TiEVWlyldriK6u+7IZclS64oyMv2tQAk41MyojiltD4=;
        b=nMaplOICQobUwHchehfXrFU90Ya5RyjeFudrtbDINncrLRCtgrynvmsPNLg5PZwPqY
         /yS/XvXjiz/m6X1b+701XUi/LpT5LfkelLFJGTmefMmg8Khmh2Ih92FnjGE4BZ4L3kpo
         yZXNsLZBmv5qSyhK2mvlvBh7EAAYI3lUDGmNvwyTRIl8uDEYEcm+HUrCZ9bHBUW3UBCO
         xvrJ2YJRUTM7Ip5N5/S8HAD8NYKOagD1qEcvthZOiA+fRWFs1EUZu/xE+8wtgYwg9OQq
         13MHYMoSuRxi+y3bncqBar9urZMksyrQjAz1o9e3NGSgYB2U/Kl+TDif3CepYvVz5Zub
         BNLQ==
X-Gm-Message-State: AJIora/kvkHJtMJvkynhnqzUWm6SlGom+boh1UkCb+JfNYYFy4AiGvEb
        kvR6MIlMsv8IT+KfXxCAS/Vh9mWhOaf4doQjRNw5U56Iq00jYQYIPUvwHWrZ+OPGbGsvw5RSDVC
        QjRcq7hsyGiEg3zfnBZmJsWBr
X-Received: by 2002:a05:600c:a41:b0:39c:1512:98bd with SMTP id c1-20020a05600c0a4100b0039c151298bdmr14793140wmq.88.1659452373044;
        Tue, 02 Aug 2022 07:59:33 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uVcy9Uhg/u4K309FT0W3bmnAaw4bdK83/8GL9sXHMylj8ESdtJLqkyEA7z9bDjEmji9qyLrA==
X-Received: by 2002:a05:600c:a41:b0:39c:1512:98bd with SMTP id c1-20020a05600c0a4100b0039c151298bdmr14793119wmq.88.1659452372798;
        Tue, 02 Aug 2022 07:59:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3800:8435:659e:f80:9b3d? (p200300cbc70738008435659e0f809b3d.dip0.t-ipconnect.de. [2003:cb:c707:3800:8435:659e:f80:9b3d])
        by smtp.gmail.com with ESMTPSA id u11-20020a056000038b00b0021e4829d359sm16597094wrf.39.2022.08.02.07.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 07:59:32 -0700 (PDT)
Message-ID: <01362246-05e6-f57f-9f64-c8d2524e685d@redhat.com>
Date:   Tue, 2 Aug 2022 16:59:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mm: Split huge PUD on wp_huge_pud fallback
Content-Language: en-US
To:     "Gowans, James" <jgowans@amazon.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?U2Now7ZuaGVyciwgSmFuIEgu?= <jschoenh@amazon.de>,
        "thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <6f48d622eb8bce1ae5dd75327b0b73894a2ec407.camel@amazon.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <6f48d622eb8bce1ae5dd75327b0b73894a2ec407.camel@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.06.22 07:24, Gowans, James wrote:
> Currently the implementation will split the PUD when a fallback is taken
> inside the create_huge_pud function. This isn't where it should be done:
> the splitting should be done in wp_huge_pud, just like it's done for
> PMDs. Reason being that if a callback is taken during create, there is
> no PUD yet so nothing to split, whereas if a fallback is taken when
> encountering a write protection fault there is something to split.
> 
> It looks like this was the original intention with the commit where the
> splitting was introduced, but somehow it got moved to the wrong place
> between v1 and v2 of the patch series. Rebase mistake perhaps.
> 
> Fixes: 327e9fd48972 ("mm: Split huge pages on write-notify or COW")

Right, the functions should just look like create_huge_pmd()/wp_huge_pmd().

I do wonder if there was a reason to do it differently, though ... I
can't spot any in current code.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

