Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F27A4F9E44
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 22:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239526AbiDHUib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 16:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbiDHUi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 16:38:28 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331761C4B2D;
        Fri,  8 Apr 2022 13:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=h1s1cl/MNWphmQvefqBf/suSv8LXWFq0XUy8/QL01ko=; b=jCxIh0U5Itm6wOdVKyoTPtDOmS
        h+xliojQYmGDxuMt7M/9qtH5lpWyHy+sZh5kGgFJcTL1SaLniX+SW9Q1KkcQHr2HdJLtY4K1uusNv
        Vd+BEfUdTBp71B0R1yPRkIMIHJyIzaSZ6JIwHlSQBAygnO4PtZbBxEVf6+gHQXV0hWzKpIcNMHR7m
        pD+b63I50huejCCym8GfCY5otCjl29tettWJF2m3zC60B6HLqD0rSg1v1zNire5ydOkZGQda05K65
        d+Uqmd3FikSfKx2thSw+WadvnXURMtWqEosxjAa1jjjeDlbkvrAYlZXbhmzetrwgetYvAVaLLy6p4
        AprZ4NFQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncvKy-0033Qr-GE; Fri, 08 Apr 2022 20:36:09 +0000
Message-ID: <81585705-6ed8-12e5-1355-332a6a5d2b17@infradead.org>
Date:   Fri, 8 Apr 2022 13:36:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCHv1] kbuild: support W=e to make build abort in case of
 warning
Content-Language: en-US
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Yann Droneaud <ydroneaud@opteya.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <1422803720-14723-1-git-send-email-ydroneaud@opteya.com>
 <20220408084607.106468-1-ydroneaud@opteya.com>
 <CAK7LNAQZLt_OecOogOQiSu5snW+sffsMoFgVcjPTx_idj_=_tQ@mail.gmail.com>
 <CAKwvOd=yNnKsHJo0QWvoTuFF9p-y=cTftTD+7FY-wJ_f23zFTQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAKwvOd=yNnKsHJo0QWvoTuFF9p-y=cTftTD+7FY-wJ_f23zFTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/8/22 13:29, Nick Desaulniers wrote:
> On Fri, Apr 8, 2022 at 4:06 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>>
>> On Fri, Apr 8, 2022 at 5:46 PM Yann Droneaud <ydroneaud@opteya.com> wrote:
>>>
>>> When developing new code/feature, CONFIG_WERROR is most
>>> often turned off, especially for people using make W=12 to
>>> get more warnings.
>>>
>>> In such case, turning on -Werror temporarily would require
>>> switching on CONFIG_WERROR in the configuration, building,
>>> then switching off CONFIG_WERROR.
>>>
>>> For this use case, this patch introduces a new 'e' modifier
>>> to W= as a short hand for KCFLAGS+=-Werror" so that -Werror
>>> got added to the kernel (built-in) and modules' CFLAGS.
>>>
>>> Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
>>> ---
>>>  Makefile                   |  1 +
>>>  scripts/Makefile.extrawarn | 13 +++++++++++--
>>>  2 files changed, 12 insertions(+), 2 deletions(-)
>>>
>>> Changes since v0[0]:
>>>
>>>  - rebase on top of commit 64a91907c896 ("kbuild: refactor scripts/Makefile.extrawarn")
>>>  - document use case after commit 3fe617ccafd6 ("Enable '-Werror' by default for all kernel builds")
>>>
>>> [0] https://lore.kernel.org/all/1422803720-14723-1-git-send-email-ydroneaud@opteya.com/
>>
>>
>> I remembered the previous submission, I liked it, but I had lost it.
>>
>> It seems already 7 years ago, (before I became the Kbuild maintainer).
>> Thanks for coming back to this.
>>
>>
>> I like this, but I will wait some time for review comments.
> 
> Dunno, this seems pretty simple:
> 
> $ ./scripts/config -e WERROR
> $ make ... W=12

Yeah, that's about what I was thinking too..

-- 
~Randy
