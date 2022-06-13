Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FE8549EBA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350946AbiFMUQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235858AbiFMUPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:15:40 -0400
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03AE612A5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 11:51:34 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4LMLJP11JyzMqHNQ;
        Mon, 13 Jun 2022 20:51:33 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4LMLJN2Ghszlpb36;
        Mon, 13 Jun 2022 20:51:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1655146293;
        bh=wBMZpf+0xP3n2uuaiisiDHxgL9FxcJ7+UVn4cHmWGUI=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=rpPYeY2uEwL2b/Kq8B7y41Xy48cThtF+LAYSo6v6TUrchKzFc4m+62Z2XxRbXEBKI
         MAJ7NGRYrTqgeDRv7DHUgFSEWsXzoQrspz6agFZrgDqZRsqAeGOHuFKhsYHfslamfq
         aY7ojd7wI0i94L6qClmOKsBYT+EAKCtzKVeo9JLM=
Message-ID: <7560779e-a4a4-9092-7616-2a6bc4310cdd@digikod.net>
Date:   Mon, 13 Jun 2022 20:51:31 +0200
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
 <20220611172233.1494073-3-masahiroy@kernel.org>
 <e7850717-dad6-daef-c96c-2a74248e98f6@digikod.net>
 <CAK7LNASR6Hwj-Q+z6GCGTOz0gXv5XXTV8phqe7duGm+uuo3eDQ@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH 3/4] certs: move scripts/check-blacklist-hashes.awk to
 certs/
In-Reply-To: <CAK7LNASR6Hwj-Q+z6GCGTOz0gXv5XXTV8phqe7duGm+uuo3eDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/06/2022 17:28, Masahiro Yamada wrote:
> On Mon, Jun 13, 2022 at 9:36 PM Mickaël Salaün <mic@digikod.net> wrote:
>>
>>
>>
>> On 11/06/2022 19:22, Masahiro Yamada wrote:
>>> This script is only used in certs/Makefile, so certs/ is a better
>>> home for it.
>>>
>>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>>> ---
>>>
>>>    MAINTAINERS                                   | 1 -
>>>    certs/Makefile                                | 2 +-
>>>    {scripts => certs}/check-blacklist-hashes.awk | 0
>>>    3 files changed, 1 insertion(+), 2 deletions(-)
>>>    rename {scripts => certs}/check-blacklist-hashes.awk (100%)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 1fc9ead83d2a..7c2a7c304824 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -4627,7 +4627,6 @@ L:      keyrings@vger.kernel.org
>>>    S:  Maintained
>>>    F:  Documentation/admin-guide/module-signing.rst
>>>    F:  certs/
>>> -F:   scripts/check-blacklist-hashes.awk >   F:       scripts/sign-file.c
>>>    F:  tools/certs/
>>>
>>> diff --git a/certs/Makefile b/certs/Makefile
>>> index a8d628fd5f7b..df7aaeafd19c 100644
>>> --- a/certs/Makefile
>>> +++ b/certs/Makefile
>>> @@ -13,7 +13,7 @@ CFLAGS_blacklist_hashes.o := -I $(obj)
>>>
>>>    quiet_cmd_check_and_copy_blacklist_hash_list = GEN     $@
>>>          cmd_check_and_copy_blacklist_hash_list = \
>>> -     $(AWK) -f $(srctree)/scripts/check-blacklist-hashes.awk $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) >&2; \
>>> +     $(AWK) -f $(srctree)/$(src)/check-blacklist-hashes.awk $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) >&2; \
>>>        cat $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) > $@
>>>
>>>    $(obj)/blacklist_hash_list: $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) FORCE
>>> diff --git a/scripts/check-blacklist-hashes.awk b/certs/check-blacklist-hashes.awk
>>> similarity index 100%
>>> rename from scripts/check-blacklist-hashes.awk
>>> rename to certs/check-blacklist-hashes.awk
>>
>> It looks more appropriate and consistent to me to keep it in scripts/,
>> close to other cert scripts. Is there some precedent to move such script?
> 
> 
> I always did that.   For example,
> 
>    f6f57a46435d7253a52a1a07a58183678ad266a0
>    78a20a012ecea857e438b1f9e8091acb290bd0f5
>    28ba53c07638f31b153e3a32672a6124d0ff2a97
>    4484aa800ac588a1fe2175cd53076c21067f44b4
>    340a02535ee785c64c62a9c45706597a0139e972
> 
> 
> Tools can stay in scripts/ if and only if:
> 
>    - it is used globally during kernel builds
> 
>    - it is still needed after the kernel builds.
>       "make clean" removes most of the build artifacts
>        but keeps ones under scripts/.
> 

OK, it would be nice to have these rules in the documentation (didn't 
find them).

Reviewed-by: Mickaël Salaün <mic@linux.microsoft.com>

> 
> 
> scripts/insert-sys-cert is apparently unneeded for building the kernel.
> If the intended use is to manipulate vmlinux later,
> that is the legitimate reason to stay in scripts/.
> (but even better place might be tools/)
> 
> 
> certs/signing_key.pem is needed even after kernel builds.
> So, it should have been kept under scripts/ instead of certs/.
> 
> 
> 
> 
> 
> --
> Best Regards
> Masahiro Yamada
