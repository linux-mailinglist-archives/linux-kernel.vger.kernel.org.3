Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E53F4FA16F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 03:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240449AbiDIB4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 21:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiDIB42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:56:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01B51D7631;
        Fri,  8 Apr 2022 18:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=po28GC7DIdQXTfB1hhQQWcuehU2iBp5gBTF64q3n/f0=; b=ipuebQ7QloxLERMoDAWtI9BBqE
        9c6+dhRf4zs5UEY7JNpVvY/z+3dWVyYo5ArYY84HMpNC5xbXkb/UZtlffJstBmeIKCU3+1JOq6s+U
        luZUmbmvFoWJ6KuNb5wulkCbkdHq5frsH75fjmZQMXq2iHE7HIcuM0CPrc4J+ZgMRDN2RxGyoQXNf
        hLYXNoUWWaYX6X/cJgw+dwHA07xFsnkgNbSNU56U9lSKcWaHcDfHs772IQ8nE3wXwDWqHTEng27Ov
        JBiSCxSFsFX/nYlPzmEfFRnXi9mqiwRe1hHkF9kesThsfg0MeBuntVP+vjCFrQ+0+++J0/Gy8EZfb
        3X6DjlhQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nd0In-00ALMa-7e; Sat, 09 Apr 2022 01:54:13 +0000
Message-ID: <ca208328-f632-3285-2f57-83dded6bd930@infradead.org>
Date:   Fri, 8 Apr 2022 18:54:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCHv1] kbuild: support W=e to make build abort in case of
 warning
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Yann Droneaud <ydroneaud@opteya.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <1422803720-14723-1-git-send-email-ydroneaud@opteya.com>
 <20220408084607.106468-1-ydroneaud@opteya.com>
 <CAK7LNAQZLt_OecOogOQiSu5snW+sffsMoFgVcjPTx_idj_=_tQ@mail.gmail.com>
 <CAKwvOd=yNnKsHJo0QWvoTuFF9p-y=cTftTD+7FY-wJ_f23zFTQ@mail.gmail.com>
 <81585705-6ed8-12e5-1355-332a6a5d2b17@infradead.org>
 <CAK7LNAS6ap9dR=kzRgQgt+d7FBBbVrwEqGU9g_pFD+nzMUt+gQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAK7LNAS6ap9dR=kzRgQgt+d7FBBbVrwEqGU9g_pFD+nzMUt+gQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/8/22 18:47, Masahiro Yamada wrote:
> On Sat, Apr 9, 2022 at 5:36 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>>
>>
>> On 4/8/22 13:29, Nick Desaulniers wrote:
>>> On Fri, Apr 8, 2022 at 4:06 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>>>>
>>>> On Fri, Apr 8, 2022 at 5:46 PM Yann Droneaud <ydroneaud@opteya.com> wrote:
>>>>>
>>>>> When developing new code/feature, CONFIG_WERROR is most
>>>>> often turned off, especially for people using make W=12 to
>>>>> get more warnings.
>>>>>
>>>>> In such case, turning on -Werror temporarily would require
>>>>> switching on CONFIG_WERROR in the configuration, building,
>>>>> then switching off CONFIG_WERROR.
>>>>>
>>>>> For this use case, this patch introduces a new 'e' modifier
>>>>> to W= as a short hand for KCFLAGS+=-Werror" so that -Werror
>>>>> got added to the kernel (built-in) and modules' CFLAGS.
>>>>>
>>>>> Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
>>>>> ---
>>>>>  Makefile                   |  1 +
>>>>>  scripts/Makefile.extrawarn | 13 +++++++++++--
>>>>>  2 files changed, 12 insertions(+), 2 deletions(-)
>>>>>
>>>>> Changes since v0[0]:
>>>>>
>>>>>  - rebase on top of commit 64a91907c896 ("kbuild: refactor scripts/Makefile.extrawarn")
>>>>>  - document use case after commit 3fe617ccafd6 ("Enable '-Werror' by default for all kernel builds")
>>>>>
>>>>> [0] https://lore.kernel.org/all/1422803720-14723-1-git-send-email-ydroneaud@opteya.com/
>>>>
>>>>
>>>> I remembered the previous submission, I liked it, but I had lost it.
>>>>
>>>> It seems already 7 years ago, (before I became the Kbuild maintainer).
>>>> Thanks for coming back to this.
>>>>
>>>>
>>>> I like this, but I will wait some time for review comments.
>>>
>>> Dunno, this seems pretty simple:
>>>
>>> $ ./scripts/config -e WERROR
>>> $ make ... W=12
>>
>> Yeah, that's about what I was thinking too..
> 
> 
> 
> But, you cannot change the .config
> when you build external modules.
> 
> "make W=e" might be useful for people who strive to
> keep their downstream modules warning-free.
> 
> 
> W=e is the same pattern.
> I do not see much downside.
> 

Well, I don't see much downside either.

> 
> 
> (BTW, I do not like CONFIG_WERROR.)

Yeah, I disable it most of the time, but I am pretty good
at searching for errors & warnings. Apparently some people
are not.

-- 
~Randy
