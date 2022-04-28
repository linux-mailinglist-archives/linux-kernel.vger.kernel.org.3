Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B17512A9E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 06:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242699AbiD1EkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 00:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239642AbiD1EkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 00:40:20 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAE92B18A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 21:37:04 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id j4so6493091lfh.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 21:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LTNCTDXwD0m5fnU3nRCZyUZ2Z4+nGspg+RVsi3XsvCA=;
        b=D9tvI1Yc8PHKlElRfTCfEiW/GgIxV8hjidcQv77IWEgZ2VsrSnRa1t4dk7eQ47p0IQ
         zPzi4kCwsaFXzkKGmV6K96vHeHOHys/YFeiSaOosFjBpT/HDLwwKL69IoqZSwKCJ6LfZ
         WXdAbqt0h0S57RV/0tyalW9ev1TiDIYbPlXhQe+v+joufiVTjHZ0nAUbqj/nx2T4+7g5
         VMl5r6q+cprizf0qxT0Sw1ck/IJYekUH24djwznD86UB9XPRQ65+gg9INgUHap7lo5Dc
         WlPq9FezKQH9gMBqRlbUDkTZ750ueKUcMLFwtp+LrG81EnQ+dHzI8Y8IDLykpLRvXOBA
         jJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LTNCTDXwD0m5fnU3nRCZyUZ2Z4+nGspg+RVsi3XsvCA=;
        b=PLJVywR4S4a1YW6EL7Kdxw8cilL5IOPruuem4HFTncxXVcHNI6FEh+mQjPZy00E4bW
         RPHa+TbVChQMtdRUfIVD7UUyGvF+9gtBrqIb8GQG8Lwab6DLUIcGS7ueDIz3FKB201WC
         qfSMAXUDv/DwIDO+KeceAYGOyON0efFdi8N1hxpZ6V8SP6WkZXDaYVHB8XUYgOfFTCZO
         OcbW6e9yAMM7sQkPZCCwx3YHzSyN2sVtvmD56q4d3lensIkNYMhycL009xt13Zf0tn0t
         nztL3xy7ZqCbSt4C29ZrfwBHZq2Kta68VI4gU9Drtp6Ak+WLPpy00z7C8jl6BKFW0Qhm
         7XXA==
X-Gm-Message-State: AOAM532OQ/2QOwS9egGrSZf/GtXe3rnaLOXYaQTI+hpmb9kEEqUcjXA4
        dS/8CM2cK8fi6sU19MfZALHlZw==
X-Google-Smtp-Source: ABdhPJxRiZBp004uWXWFXfySCv8ZU9C+OtgyMaNUKU7rICbEnlIXi+h4fn2r8j30BRSurlaG+vkMag==
X-Received: by 2002:a05:6512:3194:b0:472:ed8:3905 with SMTP id i20-20020a056512319400b004720ed83905mr11571712lfe.439.1651120622998;
        Wed, 27 Apr 2022 21:37:02 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id x30-20020a2e585e000000b0024f21b267a3sm645978ljd.53.2022.04.27.21.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 21:37:02 -0700 (PDT)
Message-ID: <ec08a059-2a04-3e9c-cbad-a5af2d2744e0@openvz.org>
Date:   Thu, 28 Apr 2022 07:37:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH memcg v4] net: set proper memcg for net_init hooks
 allocations
Content-Language: en-US
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Shakeel Butt <shakeelb@google.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>, kernel@openvz.org,
        Florian Westphal <fw@strlen.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Cgroups <cgroups@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <YmdeCqi6wmgiSiWh@carbon>
 <33085523-a8b9-1bf6-2726-f456f59015ef@openvz.org>
 <CALvZod4oaj9MpBDVUp9KGmnqu4F3UxjXgOLkrkvmRfFjA7F1dw@mail.gmail.com>
 <20220427122232.GA9823@blackbody.suse.cz>
 <CALvZod7v0taU51TNRu=OM5iJ-bnm1ryu9shjs80PuE-SWobqFg@mail.gmail.com>
 <6b18f82d-1950-b38e-f3f5-94f6c23f0edb@openvz.org> <YmnFUwhmqJwYGQ5j@carbon>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <YmnFUwhmqJwYGQ5j@carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/22 01:36, Roman Gushchin wrote:
> We can point root_mem_cgroup at a statically allocated structure
> on both CONFIG_MEMCG and !CONFIG_MEMCG.
> Does it sound reasonable or I'm missing some important points?

I expect Embedded developers will be highly disagree.
Pointer only should be acceptable for them.

Thank you,
	Vasily Averin
