Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0360A50649C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 08:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348911AbiDSGjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 02:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241450AbiDSGi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 02:38:59 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C090D2E9E1;
        Mon, 18 Apr 2022 23:36:17 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id z12so19976728edl.2;
        Mon, 18 Apr 2022 23:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OT4LGPUm7UJSjHuUjobOQB7rDPRvHB6tAnR+txOs9lU=;
        b=OqODbScMT38lvhuE5ew5aG2rwx6ftw+UfcSuTGxLrA0mwJxXrid9/GHenNcl6fTULY
         /PytgT6fkdbGnujJiFc5LHBSE9H9HtqtSwyVOZQRMsBfdkHRy7bjc0fM99WUw9uyKynk
         Si9JxgStD5egDO5BHQ0baceSOoWLQszGs87D1SkAuO+8BZXBx49G+In17ziFVk+vOE6P
         znR5NJDMl3M9RyJgB/4GWIuxtUqyfylYkCZIY2AtHmL/L2UmQ3V4rPaIAQnaWIm8WhmV
         zN9WWUR4q/OhFs0bLPQzlGRkL0tnTJkAg8LfkeLfUwa5uoUoEppZio1s2s80Lz2pL/nz
         jAaQ==
X-Gm-Message-State: AOAM530QdKRNZjEzqTpDJeG5NX8qWazvpv5iqU0y37Tya3iq1xTmuTVn
        otGmaZhFGS8jBwi412Hncmg=
X-Google-Smtp-Source: ABdhPJzn0VqJcDgI7/Mr182wAV0/kJA3RdhbB1JWUcHIAASgD/AiaINytaG0yg1r8hPJRqVtEFJ3fw==
X-Received: by 2002:a05:6402:e85:b0:41d:121b:f436 with SMTP id h5-20020a0564020e8500b0041d121bf436mr15804453eda.121.1650350176399;
        Mon, 18 Apr 2022 23:36:16 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id bs2-20020a056402304200b0041fc40eeb91sm7919023edb.49.2022.04.18.23.36.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 23:36:15 -0700 (PDT)
Message-ID: <2f051c7c-24cc-3e2a-5f32-056de83cba1b@kernel.org>
Date:   Tue, 19 Apr 2022 08:36:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: linux-next: build warning after merge of the tty tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>
Cc:     Jiri Slaby <jslaby@suse.cz>, Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220419163318.0682ffb8@canb.auug.org.au>
 <20220419163530.616d1a7e@canb.auug.org.au>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220419163530.616d1a7e@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 04. 22, 8:35, Stephen Rothwell wrote:
> Hi all,
> 
> On Tue, 19 Apr 2022 16:33:18 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> After merging the tty tree, today's linux-next build (htmldocs) produced
>> this warning:
>>
>> Documentation/driver-api/index.rst:14: WARNING: toctree contains reference to nonexisting document 'driver-api/tty'
>>
>> Introduced by commit
>>
>>    b96cd8b05ead ("Documentation: move tty to driver-api")
> 
> Also, this:
> 
> Documentation/driver-api/tty/index.rst: WARNING: document isn't included in any toctree

That looks to be the very same issue -- a bad link.

-- 
js
suse labs
