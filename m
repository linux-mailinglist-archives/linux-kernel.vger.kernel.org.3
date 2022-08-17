Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E627597A60
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 01:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242242AbiHQXwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 19:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiHQXwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 19:52:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0B490C41
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 16:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=4HQ4+ZOQvyiLzvnxSRlvKOtZIC2PHqV+nyF4RISozSQ=; b=oG4OY8SE4JEDrmtR/hSyS2pGkg
        jpMdk6PpPEwoVjVgseZO7JNPPY75C7lo1i+1vySLAHJH0kmcvOMplrsfVLm/302TmCEC2183GnvTl
        MO/pevEnK4RgvWYSEi/la4PZzJ0C1Ko3dsudbZcXu9xy9/XhqM9Iq3rP0/D3itaK0Rcb7aboNKtIM
        Om74kw9FUT1vF6H34J6oxuStZKjou0TLmKwFFMZaen7FC0cngInNH7Wr5C7FBXcUnmyKBpYKmoaDv
        08wNnVYOQrEdg4H6EMyiNbqQH739lexP+qrsZEfIC3fMWT3HNm74F8YeSyAzHXmeHcS6UFP4QGR7E
        J+M94iKg==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOSpk-008lXK-5r; Wed, 17 Aug 2022 23:52:24 +0000
Message-ID: <7eacd1d9-42ba-fd61-7f37-0635cebcb33d@infradead.org>
Date:   Wed, 17 Aug 2022 16:52:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] init/Kconfig: fix CC_HAS_ASM_GOTO_TIED_OUTPUT test with
 dash
Content-Language: en-US
To:     Nick Desaulniers <ndesaulniers@google.com>,
        alexandre.belloni@bootlin.com,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20220804190320.262510-1-alexandre.belloni@bootlin.com>
 <CAKwvOd=3N8_Rx1P8J7pVnjM6sEzJA233BnwmD1VyMRqgujq2_Q@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAKwvOd=3N8_Rx1P8J7pVnjM6sEzJA233BnwmD1VyMRqgujq2_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/17/22 16:46, Nick Desaulniers wrote:
> On Thu, Aug 4, 2022 at 12:03 PM <alexandre.belloni@bootlin.com> wrote:
>>
>> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
>>
>> When using dash as /bin/sh, the CC_HAS_ASM_GOTO_TIED_OUTPUT test fails
>> with a syntax error which is not the one we are looking for:
> 
> Thanks for the patch, though I think I'd rather see `/bin/bash`
> hardcoded. Bash is a non-optional requirement as of
> commit da4288b95baa ("scripts/check-local-export: avoid 'wait $!' for
> process substitution")
> scripts/ is kind of a mess...
> 

Well, once upon a time, we took patches to remove bash-isms (convert to
standard shell)...
No longer, AFAICT.

>>
>> <stdin>: In function ‘foo’:
>> <stdin>:1:29: warning: missing terminating " character
>> <stdin>:1:29: error: missing terminating " character
>> <stdin>:2:5: error: expected ‘:’ before ‘+’ token
>> <stdin>:2:7: warning: missing terminating " character
>> <stdin>:2:7: error: missing terminating " character
>> <stdin>:2:5: error: expected declaration or statement at end of input
>>
>> Move all the CC_HAS_ASM_GOTO tests to scripts/gcc-goto.sh to solve the
>> escaping issues.
>>
>> Fixes: 1aa0e8b144b6 ("Kconfig: Add option for asm goto w/ tied outputs to workaround clang-13 bug")
>> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>> ---
>>  init/Kconfig        |  6 +++---
>>  scripts/gcc-goto.sh | 31 +++++++++++++++++++++++++++++++
>>  2 files changed, 34 insertions(+), 3 deletions(-)
>>
>> diff --git a/init/Kconfig b/init/Kconfig
>> index c984afc489de..9903a11cfe7d 100644
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -71,16 +71,16 @@ config CC_CAN_LINK_STATIC
>>         default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag) -static)
>>
>>  config CC_HAS_ASM_GOTO
>> -       def_bool $(success,$(srctree)/scripts/gcc-goto.sh $(CC))
>> +       def_bool $(success,$(srctree)/scripts/gcc-goto.sh goto $(CC))
>>
>>  config CC_HAS_ASM_GOTO_OUTPUT
>>         depends on CC_HAS_ASM_GOTO
>> -       def_bool $(success,echo 'int foo(int x) { asm goto ("": "=r"(x) ::: bar); return x; bar: return 0; }' | $(CC) -x c - -c -o /dev/null)
>> +       def_bool $(success,$(srctree)/scripts/gcc-goto.sh goto_output $(CC))
>>
>>  config CC_HAS_ASM_GOTO_TIED_OUTPUT
>>         depends on CC_HAS_ASM_GOTO_OUTPUT
>>         # Detect buggy gcc and clang, fixed in gcc-11 clang-14.
>> -       def_bool $(success,echo 'int foo(int *x) { asm goto (".long (%l[bar]) - .\n": "+m"(*x) ::: bar); return *x; bar: return 0; }' | $CC -x c - -c -o /dev/null)
>> +       def_bool $(success,$(srctree)/scripts/gcc-goto.sh goto_tied_output $(CC))
>>
>>  config TOOLS_SUPPORT_RELR
>>         def_bool $(success,env "CC=$(CC)" "LD=$(LD)" "NM=$(NM)" "OBJCOPY=$(OBJCOPY)" $(srctree)/scripts/tools-support-relr.sh)
>> diff --git a/scripts/gcc-goto.sh b/scripts/gcc-goto.sh
>> index 8b980fb2270a..aa9498b74df8 100755
>> --- a/scripts/gcc-goto.sh
>> +++ b/scripts/gcc-goto.sh
>> @@ -3,6 +3,11 @@
>>  # Test for gcc 'asm goto' support
>>  # Copyright (C) 2010, Jason Baron <jbaron@redhat.com>
>>
>> +TEST=$1
>> +shift
>> +
>> +case $TEST in
>> +    "goto")
>>  cat << "END" | $@ -x c - -fno-PIE -c -o /dev/null
>>  int main(void)
>>  {
>> @@ -20,3 +25,29 @@ entry:
>>         return 0;
>>  }
>>  END
>> +    ;;
>> +
>> +    "goto_output")
>> +cat << "END" | $@ -x c - -c -o /dev/null
>> +int foo(int x) {
>> +       asm goto ("": "=r"(x) ::: bar);
>> +       return x;
>> +       bar: return 0;
>> +}
>> +END
>> +    ;;
>> +
>> +    "goto_tied_output")
>> +cat << "END" | $@ -x c - -c -o /dev/null
>> +int foo(int *x) {
>> +       asm goto (".long (%l[bar]) - .\n": "+m"(*x) ::: bar);
>> +       return *x;
>> +       bar: return 0;
>> +}
>> +END
>> +    ;;
>> +
>> +    *)
>> +       exit -1
>> +    ;;
>> +esac
>> --
>> 2.37.1
>>
> 
> 

-- 
~Randy
