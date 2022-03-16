Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD464DA97C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 06:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353569AbiCPFHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 01:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235942AbiCPFHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 01:07:31 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F574FC5C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 22:06:16 -0700 (PDT)
Date:   Wed, 16 Mar 2022 05:06:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theinnocuous.com;
        s=protonmail; t=1647407174;
        bh=JcA2Bw/VmBv9ZYP7f55QJSNCUONYlIwl8L6H9SP7KLY=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=sHida3cL7byHm5pa5HMwrV13eGTHsRoKzk9qV6aGRvZh8YiGJVn5YOg6T1EXPT3Jc
         fkyR3bbF2QoTQCxTypu0CPh/DO43Gny8It/v7HspS1GoxT+YGLQ7ujemv3ly0+vEqp
         y3CiWvn++F0UbKK5UjGHU4N2ZSHA1JpjTd5tVzqxh6UadNtHbqJJPU0lykmde6Ihf+
         cIeis2rjB/qoh0RocHMuZQwH9R/KAlP4uKz1ltK9jJ7xPJxqOFav/J3zOC6EvSychF
         miw83EoZ5W9QYqTiQhFnWJBAFGGslZMtDW2OMWyPxQTZw3HAWEhunRdRDgxauggQL3
         EMmrhNgGWRMNg==
To:     Kees Cook <keescook@chromium.org>
From:   James Jones <linux@theinnocuous.com>
Cc:     bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org
Reply-To: James Jones <linux@theinnocuous.com>
Subject: Re: [PATCH] x86: Remove a.out support
Message-ID: <bfbd9394-161b-0e70-00c5-79d0dd722e08@theinnocuous.com>
In-Reply-To: <202203151150.1CDB1D8DA@keescook>
References: <4c449fab-8135-5057-7d2c-7b948ce130cc@theinnocuous.com> <0b31b1d3-852d-6cab-82ae-5eecaec05679@theinnocuous.com> <202203151150.1CDB1D8DA@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/22 12:51 PM, Kees Cook wrote:
> On Sat, Mar 12, 2022 at 06:06:26PM +0000, James Jones wrote:
>> [...]
>>> docs, including copies of the old mac and aln a.out binaries, is
>>> available here:
>>>
>>> https://github.com/cubanismo/jaguar-sdk
>
> Do these end up requiring libc4, etc? I see "uselib" syscalls in the
> disassembly...
>
> $ for i in $(objdump -b binary -D -m i386 aln mac | grep -B4 'int.*$0x80'=
 \
> =09| grep -E 'int|eax' | grep mov | awk '{print $8}' | cut -d, -f1 \
> =09| cut -c2- | sort -u); do printf "%d\n" $i; done | sort -n
> 1       exit
> 3       read
> 4       write
> 5       open
> 6       close
> 10      unlink
> 13      time
> 19      lseek
> 20      getpid
> 37      kill
> 45      brk
> 54      ioctl
> 55      fcntl
> 86      uselib
> 89      readdir
> 91      munmap
> 106     stat
> 107     lstat
> 108     fstat
> 126     sigprocmask
>
> It seems like it should be possible to create an ELF wrapper for simple
> a.out binaries...

I didn't need to dig up any ancient libraries to get these working. They
seem to be completely statically linked.

Probably getting a bit off topic, but I did spend a few hours searching
around for any existing tools to convert a binary from a.out->ELF, and
trying to come up with something myself by extracting the sections with
objdump and re-combining them into an ELF using a linker script placing
the sections at the same locations. I couldn't get it working in an
evening or two messing with it so I moved on, but I agree something like
this seems possible in theory. I got 'mac' converted to an ELF that
would load up and print its input prompt if run without parameters, but
only if run as root. As a regular user, it segfaults somewhere before it
even starts executing in the text section AFAICT. Any actual assembling
segfaults even when running as root. I never got 'aln' to do anything
but segfault.

I dug the scripts up in the state they were in when I gave up (September
2020 according to mtime), and put them on github in case anyone wants to
have a go at it:

https://github.com/cubanismo/aout-to-elf/

It was an interesting problem in its own right, and I'd be curious to
know what I missed.

Thanks,
-James

> --
> Kees Cook

