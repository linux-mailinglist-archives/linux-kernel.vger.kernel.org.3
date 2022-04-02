Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB344F0690
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 00:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349735AbiDBWQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 18:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiDBWQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 18:16:38 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C42F3E5C2
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 15:14:45 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id D531792009C; Sun,  3 Apr 2022 00:14:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id CEAFF92009B;
        Sat,  2 Apr 2022 23:14:43 +0100 (BST)
Date:   Sat, 2 Apr 2022 23:14:43 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     James Jones <linux@theinnocuous.com>
cc:     Kees Cook <keescook@chromium.org>, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Remove a.out support
In-Reply-To: <bfbd9394-161b-0e70-00c5-79d0dd722e08@theinnocuous.com>
Message-ID: <alpine.DEB.2.21.2204022255430.47162@angie.orcam.me.uk>
References: <4c449fab-8135-5057-7d2c-7b948ce130cc@theinnocuous.com> <0b31b1d3-852d-6cab-82ae-5eecaec05679@theinnocuous.com> <202203151150.1CDB1D8DA@keescook> <bfbd9394-161b-0e70-00c5-79d0dd722e08@theinnocuous.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2022, James Jones wrote:

> Probably getting a bit off topic, but I did spend a few hours searching
> around for any existing tools to convert a binary from a.out->ELF, and
> trying to come up with something myself by extracting the sections with
> objdump and re-combining them into an ELF using a linker script placing
> the sections at the same locations. I couldn't get it working in an
> evening or two messing with it so I moved on, but I agree something like
> this seems possible in theory.

 Chiming in late as I'm scanning outstanding mailing list traffic: if this 
is as you say all statically linked stuff, then converting from a.out to 
ELF might be as easy as:

$ objcopy -I a.out-i386-linux -O elf32-i386 a.out-binary elf-binary

though you may have to build yourself suitably old i386-linux-gnu binutils 
(from ftp.gnu.org), e.g. this version does support a.out:

$ objcopy --info
BFD header file version 2.15.91 20040527
elf32-i386
 (header little endian, data little endian)
  i386
a.out-i386-linux
 (header little endian, data little endian)
  i386
efi-app-ia32
 (header little endian, data little endian)
  i386
elf32-little
 (header little endian, data little endian)
  i386
elf32-big
 (header big endian, data big endian)
  i386
srec
 (header endianness unknown, data endianness unknown)
  i386
symbolsrec
 (header endianness unknown, data endianness unknown)
  i386
tekhex
 (header endianness unknown, data endianness unknown)
  i386
binary
 (header endianness unknown, data endianness unknown)
  i386
ihex
 (header endianness unknown, data endianness unknown)
  i386
trad-core
 (header endianness unknown, data endianness unknown)

               elf32-i386 a.out-i386-linux efi-app-ia32 elf32-little elf32-big 
          i386 elf32-i386 a.out-i386-linux efi-app-ia32 elf32-little elf32-big 

               srec symbolsrec tekhex binary ihex trad-core 
          i386 srec symbolsrec tekhex binary ihex --------- 

The last binutils version to support a.out-i386-linux was 2.30 I believe.  
Just configuring for i386-linux-gnu should do as a.out used to be included 
as a secondary BFD target (you can also do `--enable-targets=all' to get 
support for all kinds of the exotic and less exotic BFD targets).

 HTH,

  Maciej
