Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFD54B9510
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 01:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiBQAec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 19:34:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiBQAea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 19:34:30 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AD7296900
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 16:34:17 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id d10so3025955eje.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 16:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=32dF3wm+g52NnE8DQB91PZHPpwomq5mRNnLyxvWUNLQ=;
        b=JbKRy81VTIkdZzhMQDMTPYqb445XGaPdvUkBXz3BrJBistMYZbkg+llEJ08x6Hr2jl
         zfQow6BTfc/FQx5ZDbPsBTF2TRX7/+f15uuBg71NiACV37+bFgKqnlBYAtTey+gQbRVV
         Q93AL8PN5GJIsIpmDFu0QztHw38YG3y4JjM1YOXw6cw9epvKqq7qvUfNzmqCqzikDtSM
         ev5uIVYkWJJk+DlS0B2Wj+PSUDoOoFK1g9wYL+J3aONhyLSV+P/OGPUHV0QtmHw15Q7d
         sMSth8O5Q55dp3mN7gBKgDgpQ7o2tunosV1NQiFJTp7V09xbEhfflLaJIU5oYrSel3nk
         3O8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=32dF3wm+g52NnE8DQB91PZHPpwomq5mRNnLyxvWUNLQ=;
        b=gZE+jTx/3FmvEjngUfggjdoWjAaDHk3O9PUy4jCa+lu9hbd2v6HkHVWG7R9ClSaxyX
         7C9y8S86IJNWE54rN0KraWFH7zTonHeJyAHFXC2NgxGmmw4NFgQgycHozJQYbzAXu70r
         P7vTYzc+BYBpWBnqlHBY/BRLpzQcGQxTNG8aTVfg3lXQIjqq2H4evc9DUNckA2eA5Cof
         BoUxv/Jumc33W0wM8289uh1rhWQrdX1+Y5/AvwNPxrt4GvvAnwp6pIIEQiVAyH6tjIur
         LwhmcvKtn5FcRRJmw1bIfYLTE2fQPf1YG1Bg9wVaBRiZwkWDjOoBA9JoPMhWhihAoEpO
         RYEA==
X-Gm-Message-State: AOAM531vaNq5bMMo/E83oSxZ7K62328gMsQpXXsdgDwAvr8VSYXmOSpE
        lzfb4/fQ+VuZ6CnoeHcgMgo=
X-Google-Smtp-Source: ABdhPJx1XEP3KL5vKq8o8WcWLV89sp98c5B85McoH873G4uGa9a1VnbgKgQDxwyXsZzwXXcD2+dA4w==
X-Received: by 2002:a17:906:858e:b0:6cf:d198:37a1 with SMTP id v14-20020a170906858e00b006cfd19837a1mr398091ejx.545.1645058055999;
        Wed, 16 Feb 2022 16:34:15 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a11sm2383994edu.61.2022.02.16.16.34.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Feb 2022 16:34:15 -0800 (PST)
Date:   Thu, 17 Feb 2022 00:34:14 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@gmail.com>, peterz@infradead.org,
        vbabka@suse.cz, will@kernel.org, linyunsheng@huawei.com,
        aarcange@redhat.com, feng.tang@intel.com, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove offset check on page->compound_head and
 folio->lru
Message-ID: <20220217003414.jmrdpv5ytoklz6yb@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220106235254.19190-1-richard.weiyang@gmail.com>
 <Yde6hZ41agqa2zs3@casper.infradead.org>
 <20220107134059.flxr2hcd6ilb6vt7@master>
 <Ydi6iMbSZ/FewYPT@casper.infradead.org>
 <20220107160825.13c71fdd871d7d5611d116b9@linux-foundation.org>
 <YdjfsbAR0UlwyC6b@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdjfsbAR0UlwyC6b@casper.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2022 at 12:49:53AM +0000, Matthew Wilcox wrote:
>On Fri, Jan 07, 2022 at 04:08:25PM -0800, Andrew Morton wrote:
>> On Fri, 7 Jan 2022 22:11:20 +0000 Matthew Wilcox <willy@infradead.org> wrote:
>> 
[...]
>> > > Hi, Matthew
>> > > 
>> > > Would you mind sharing some insight on this check?
>> > 
>> > It's right there in the comments.
>> 
>> Well I can't figure out which comment you're referring to?
>
>         * WARNING: bit 0 of the first word is used for PageTail(). That
>         * means the other users of this union MUST NOT use the bit to
>         * avoid collision and false-positive PageTail().
>
>> > If you can't be bothered to read, why should I write?
>> 

Hi, Matthew

This change is introduced in commit 1d798ca3f164 'mm: make compound_head()
robust'.

As mentioned in the changelog.

```
    That means page->compound_head shares storage space with:

    - page->lru.next;
    - page->next;
    - page->rcu_head.next;
```

We need to make sure those fields in page don't use bit 0 of the word.

So this is an internal guarantee in struct page. I don't see the reason to
compare page->compound_head and folio->lru here.

Maybe I miss something. If you would explain a little, I would appreciate
much.

-- 
Wei Yang
Help you, Help me
