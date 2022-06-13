Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903A3549F1B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbiFMUaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344608AbiFMU1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:27:46 -0400
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [IPv6:2001:1600:4:17::190e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C02E003
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 12:14:39 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4LMLq01nMXzMpypd;
        Mon, 13 Jun 2022 21:14:36 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4LMLpz345czlnRWJ;
        Mon, 13 Jun 2022 21:14:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1655147676;
        bh=DptoC5CtpA0paKgo5YiL6B5L56+hCSKBbaRlDlyG1xU=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=xuKhCqkbYSiLCXnby1uxSpEEdeUQXoodRpEkkGTao0DtUs51H6UZyCH/10ow6wH7V
         YD6TCpZWq3lYXZh//b7E4KPv/K1fNIs9sZo3E4DrHCDactJ1Yc2S4CSiF1Wtq1j5XC
         6FQ2e2qc4OikXYOX0QltmlL5AMQmjl414dOcXXro=
Message-ID: <9bfdbd00-9f8d-0fc6-34d2-f23aea148c27@digikod.net>
Date:   Mon, 13 Jun 2022 21:14:34 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
References: <20220611172233.1494073-1-masahiroy@kernel.org>
 <20220611172233.1494073-2-masahiroy@kernel.org>
 <58a20890-557e-f31c-ed59-7e256445a26c@digikod.net>
 <CAK7LNAQ3p2XiLO7tJSJ9JWnqRomCwjYeQy-Z3j0m904Yn6Av_g@mail.gmail.com>
 <f6fbf06a-6507-a908-33ed-1218713de09b@digikod.net>
 <CAK7LNARKT=em99+BY79yWu-i+1O+uDt19pGpw3P=9=baS1AEYQ@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH 2/4] certs: fix and refactor
 CONFIG_SYSTEM_BLACKLIST_HASH_LIST build
In-Reply-To: <CAK7LNARKT=em99+BY79yWu-i+1O+uDt19pGpw3P=9=baS1AEYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/06/2022 20:56, Masahiro Yamada wrote:
> On Tue, Jun 14, 2022 at 3:06 AM Mickaël Salaün <mic@digikod.net> wrote:
>>
>>
>> On 13/06/2022 16:55, Masahiro Yamada wrote:
>>> On Mon, Jun 13, 2022 at 9:34 PM Mickaël Salaün <mic@digikod.net> wrote:
>>>>
>>>>
>>>>
>>>> On 11/06/2022 19:22, Masahiro Yamada wrote:
>>>>> Commit addf466389d9 ("certs: Check that builtin blacklist hashes are
>>>>> valid") was applied 8 months after the submission.
>>>>>
>>>>> In the meantime, the base code had been removed by commit b8c96a6b466c
>>>>> ("certs: simplify $(srctree)/ handling and remove config_filename
>>>>> macro").
>>>>>
>>>>> Fix the Makefile.
>>>>>
>>>>> Create a local copy of $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST). It is
>>>>> included from certs/blacklist_hashes.c and also works as a timestamp.
>>>>>
>>>>> Send error messages from check-blacklist-hashes.awk to stderr instead
>>>>> of stdout.
>>>>>
>>>>> Fixes: addf466389d9 ("certs: Check that builtin blacklist hashes are valid")
>>>>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>>>>
>>>> Reviewed-by: Mickaël Salaün <mic@linux.microsoft.com>
>>>>
>>>> As a side note, it may let an orphan certs/blacklist_hashes_checked file
>>>> but we can't really do something about that and it's OK.
>>>
>>>
>>> GNU Make uses timestamps of files for dependency tracking,
>>> so Kbuild keeps all intermediate files.
>>>
>>> Keeping certs/blacklist_hashes_checked
>>> is the right thing to do.
>>
>> blacklist_hashes_checked is the file you replaced with
>> blacklist_hash_list, and is then not used in any Makefile anymore. There
>> is then no timestamp issue. I just wanted to mention that it is normal
>> that a git status will show it on build directories also used as source
>> directories that were already using such feature.
> 
> 
> Ah, sorry, I misunderstood your feedback.
> 
> If 'git status' is your concern,
> we can add certs/blacklist_hashes_checked
> to scripts/remove-stale-files.
> 
> addf466389d9d78f255e8b15ac44ab4791029852
> was merged into mainline just recently, and
> not contained in any release.

Indeed, it's all good then.

> 
> But, if the orphan timestamp matters, I will do it.
> It is just a one-liner addition.
