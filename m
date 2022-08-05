Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5410C58AD0D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 17:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238351AbiHEP26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 11:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbiHEP24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 11:28:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C11E21E24
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 08:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659713334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s17SDCL9MKLYF/3ndrof+ed7FioVUBYUF/ImBULyBsI=;
        b=GIxGLSZ6mLeNTcDYblSjbXW/hcnskWkfH7GgKQj2fQ1e6FZJQVybZh6ehuPKQjw7DXNCbE
        UIjOGXq7MinV33/sUbhXl+vefF9NiWNPkhIAOkazXEBSRevrSc3RFAFGnHegdVlxy1SbSZ
        gnCLTHgWOCljwFGQwbOi8An9FBTwUQE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-DABy7RKEM-aqShGkCuXKpQ-1; Fri, 05 Aug 2022 11:28:53 -0400
X-MC-Unique: DABy7RKEM-aqShGkCuXKpQ-1
Received: by mail-wm1-f70.google.com with SMTP id n19-20020a05600c3b9300b003a314062cf4so3623572wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 08:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=s17SDCL9MKLYF/3ndrof+ed7FioVUBYUF/ImBULyBsI=;
        b=dSOgbXqjC7NggCpOOHhhX5vu3g+vO2nJxlvCjyjf2/oo79Ez+BOiljHfj8KTYTm0cP
         elJd86dS6YSg8VeXnQt5hkeY0tHyPQ4iHArD+TiPaCU+xvwj9xTeS1U2p4c24pTMCJ7N
         2JQ/LQPcad+uMk/UcWBECFpbKVqOEI3se8zNrDYEAO6gk2fq9o4AP0/XVbzeJ5pjBhcb
         eoiTXd4ypm2qm5GveYzpOHKN4nX1OEORM3WFF9eA9YvuIVREfNL6HYKYX8qG3l7xCsPl
         ff71WAKT+fXuJP+Jommb+Ec0O77hOrIxUtRIS42hRp4BIUTsnr4vnO68jsoBA9427aiy
         FaGg==
X-Gm-Message-State: ACgBeo2vL8AQ8ZAd9bhi6yoEUP6kvwbR2rPl51zijT0z2GDRhgx9+WZJ
        aWWrpTs4wIlzC5dM8b43+pa872LSld+6ceLNGUbt/Tmk6zNTeRXYVq2CHTd5Zq/NTuybTwB3nFh
        nnQEu6CKNE0qNlJh6Ww6RBx2a
X-Received: by 2002:a5d:5343:0:b0:220:6203:ed4a with SMTP id t3-20020a5d5343000000b002206203ed4amr4485500wrv.146.1659713331905;
        Fri, 05 Aug 2022 08:28:51 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6RP8jmEyNrgxdjMqN6pGfce2kXfKzdRs6fMoDWGxhWO4VNgKwbo4vWrf5CdNQijFgvKiR+Ag==
X-Received: by 2002:a5d:5343:0:b0:220:6203:ed4a with SMTP id t3-20020a5d5343000000b002206203ed4amr4485489wrv.146.1659713331631;
        Fri, 05 Aug 2022 08:28:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:fb00:f5c3:24b2:3d03:9d52? (p200300cbc706fb00f5c324b23d039d52.dip0.t-ipconnect.de. [2003:cb:c706:fb00:f5c3:24b2:3d03:9d52])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c05c600b003a2eacc8179sm4879123wmd.27.2022.08.05.08.28.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 08:28:51 -0700 (PDT)
Message-ID: <4437f656-99ac-400b-0d3b-4e1c7e6094da@redhat.com>
Date:   Fri, 5 Aug 2022 17:28:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Li Chen <me@linux.beauty>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Li Chen <lchen@ambarella.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
References: <20220711122459.13773-1-me@linux.beauty>
 <20220711122459.13773-5-me@linux.beauty>
 <CAK8P3a2Mr0ZMXGDx6htYEbBBtm4mubk-meSASJjPRK1j1O-hEA@mail.gmail.com>
 <181efcca6ae.de84203d522625.7740936811073442334@linux.beauty>
 <CAK8P3a30o1RLifV1TMqDJ26vLhVdOzz3wP6yPrayLV2GPxUtwQ@mail.gmail.com>
 <18267b7a61f.12b26bd91245310.4476663913461696630@linux.beauty>
 <CAK8P3a0zSGqj3YEi+i9yfSLk8-aJtyiY6Bj069cxCdErk81+cw@mail.gmail.com>
 <1826852ea3a.10a917cc826728.6077661125986568031@linux.beauty>
 <CAK8P3a2hyhzjYqeL1LY7WziDjXQJasg3jFe83eErzKgbfP-a3w@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 4/4] sample/reserved_mem: Introduce a sample of struct
 page and dio support to no-map rmem
In-Reply-To: <CAK8P3a2hyhzjYqeL1LY7WziDjXQJasg3jFe83eErzKgbfP-a3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.08.22 16:09, Arnd Bergmann wrote:
> On Thu, Aug 4, 2022 at 12:07 PM Li Chen <me@linux.beauty> wrote:
> 
>> Apart from our cases, I heard there are some other cases where cma_alloc
>>  failed even non-cma system memory has enough memory because pages in
>> CMA memory are pinned and cannot move out of CMA. There are some fixes like
>> 1. move these memory out of CMA before pinned
>> 2. only allow non-long-time pinned memory allocation from CMA.
>>
>> But these two solutions are not merged into the mainline yet.
> 
> Right, I think this has come up before, not sure why it wasn't implemented.
> My feeling is that 2. cannot work because you don't know if memory will be
> pinned in the future at the time of allocation, but 1. should be doable.

We disallow longterm pinning of CMA memory already and migrate it out of
the CMA region. If migration fails, we reject pinning.

See

9a4e9f3b2d73 ("mm: update get_user_pages_longterm to migrate pages
allocated from CMA region")

and recent

1c563432588d ("mm: fix is_pinnable_page against a cma page")


It's worth nothing that is_pinnable_page() will be renamed to
is_longterm_pinnable_page() soon to express what it actually means.

Note that some FOLL_GET users (vmsplice, O_DIRECT) still have to be
converted to FOLL_PIN, and especially also set FOLL_LONGTERM (vmsplice).

-- 
Thanks,

David / dhildenb

