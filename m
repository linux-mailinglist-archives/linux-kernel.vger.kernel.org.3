Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8F4539B67
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 04:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349246AbiFACwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 22:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbiFACwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 22:52:39 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373826C0E8
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 19:52:38 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id cx11so712028pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 19:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=U/LdHjgkKQR9c1pFdxPe1+kCYGuz8uBK8l8SqH25EJM=;
        b=m2EycO58iayRzm1kxcDcgLFV/MdZgoflZpYXSA0ZfhwhxpCTavWaM0gh3j2JZV6W1c
         xL7nRq7aVa+GWYj4en6mQdbEpGGWwW3HL+OAkNfymgnaEBpwXBxMN+l+wiphH832r0LT
         LfNyDitFlnCe5AgSF4v6NNNpy8zJKDZa9e3UqlEPgyviQGXWDvwq5/B6/T/WU+w3KhM9
         ygDP/cDK1ftGXwj9naDxci0M6BeWMBw6A4nIc7SXOq5EtlrHrYe2mFhns8PLgjvIAO2W
         iVjBetYLFw9ZDCdG8/clSe3n27+tzSAnWydXMrxy1XiR9gmzfCEQwvysAGvcjR2rRXGJ
         lWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=U/LdHjgkKQR9c1pFdxPe1+kCYGuz8uBK8l8SqH25EJM=;
        b=DKbunAYdi4qApWxSBn7Vk3SA8K4RwvXjtmFw+xaEPXRH+wR2ENh243Z3XQPVbbmbS9
         lkvU8V4d9vMjMs6KFIjeBPLnZ0xgTsunyfAJJnCTB23s5NaJOMQwkklSgkTFzmQerUAG
         V6fxP4P+q8yEvq9klG09Ad2qVJ6Z569G88/WqFTpXgTi3urGZCHWHhOgTlmztgyBgT1y
         OX9cTsXPXZXL6V0FopzmZPuNjQRFfI6awFvJi8xT7E0cOZh79qt0EnEMmam/IHeewUwX
         jomK15Xjgs/04dEQ61Zbpbz2YSNS0qR/rASYkTy7l/Z9XLFUJUIEGlGrOGt86fqdPXSM
         gVfQ==
X-Gm-Message-State: AOAM530xc+kiLk4YNOevvzgEu5m1oh9S38JCd7lqO70y8CePnZnDtW7e
        x2p4koZ7ot+avKxjdG4ksTnKaUASzgOj6w==
X-Google-Smtp-Source: ABdhPJw5IjFkfq3yuClWAbbZR66c4eyol+5MN1bA/Z6B327STKtSZf99CoUQ1q12TsI/tLvLh5qWOA==
X-Received: by 2002:a17:902:a981:b0:156:229d:6834 with SMTP id bh1-20020a170902a98100b00156229d6834mr62118025plb.128.1654051957670;
        Tue, 31 May 2022 19:52:37 -0700 (PDT)
Received: from localhost (subs03-180-214-233-86.three.co.id. [180.214.233.86])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902ed8c00b0015e8d4eb278sm225762plj.194.2022.05.31.19.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 19:52:36 -0700 (PDT)
Date:   Wed, 1 Jun 2022 09:52:32 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: outside array bounds error on ppc64_defconfig, GCC 12.1.0
Message-ID: <YpbUcPrm61RLIiZF@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to verify Drop ppc_inst_as_str() patch on [1] by performing
ppc64_defconfig build with powerpc64-unknown-linux-gnu-gcc (GCC 12.1.0).
The patch is applied on top of powerpc tree, next branch.

I got outside array bounds error:

  CC      arch/powerpc/kernel/dbell.o
In function 'do_byte_reverse',
    inlined from 'do_vec_store' at arch/powerpc/lib/sstep.c:722:3,
    inlined from 'emulate_loadstore' at arch/powerpc/lib/sstep.c:3509:9:
arch/powerpc/lib/sstep.c:286:25: error: array subscript [3, 4] is outside array bounds of 'union <anonymous>[1]' [-Werror=array-bounds]
  286 |                 up[0] = byterev_8(up[3]);
      |                         ^~~~~~~~~~~~~~~~
arch/powerpc/lib/sstep.c: In function 'emulate_loadstore':
arch/powerpc/lib/sstep.c:708:11: note: at offset [24, 39] into object 'u' of size 16
  708 |         } u;
      |           ^
In function 'do_byte_reverse',
    inlined from 'do_vec_store' at arch/powerpc/lib/sstep.c:722:3,
    inlined from 'emulate_loadstore' at arch/powerpc/lib/sstep.c:3509:9:
arch/powerpc/lib/sstep.c:287:23: error: array subscript [3, 4] is outside array bounds of 'union <anonymous>[1]' [-Werror=array-bounds]
  287 |                 up[3] = tmp;
      |                 ~~~~~~^~~~~
arch/powerpc/lib/sstep.c: In function 'emulate_loadstore':
arch/powerpc/lib/sstep.c:708:11: note: at offset [24, 39] into object 'u' of size 16
  708 |         } u;
      |           ^
In function 'do_byte_reverse',
    inlined from 'do_vec_store' at arch/powerpc/lib/sstep.c:722:3,
    inlined from 'emulate_loadstore' at arch/powerpc/lib/sstep.c:3509:9:
arch/powerpc/lib/sstep.c:288:23: error: array subscript 2 is outside array bounds of 'union <anonymous>[1]' [-Werror=array-bounds]
  288 |                 tmp = byterev_8(up[2]);
      |                       ^~~~~~~~~~~~~~~~
arch/powerpc/lib/sstep.c: In function 'emulate_loadstore':
arch/powerpc/lib/sstep.c:708:11: note: at offset 16 into object 'u' of size 16
  708 |         } u;
      |           ^
In function 'do_byte_reverse',
    inlined from 'do_vec_store' at arch/powerpc/lib/sstep.c:722:3,
    inlined from 'emulate_loadstore' at arch/powerpc/lib/sstep.c:3509:9:
arch/powerpc/lib/sstep.c:289:23: error: array subscript 2 is outside array bounds of 'union <anonymous>[1]' [-Werror=array-bounds]
  289 |                 up[2] = byterev_8(up[1]);
      |                 ~~~~~~^~~~~~~~~~~~~~~~~~
arch/powerpc/lib/sstep.c: In function 'emulate_loadstore':
arch/powerpc/lib/sstep.c:708:11: note: at offset 16 into object 'u' of size 16
  708 |         } u;
      |           ^
In function 'do_byte_reverse',
    inlined from 'do_vec_load' at arch/powerpc/lib/sstep.c:691:3,
    inlined from 'emulate_loadstore' at arch/powerpc/lib/sstep.c:3438:9:
arch/powerpc/lib/sstep.c:286:25: error: array subscript [3, 4] is outside array bounds of 'u8[16]' {aka 'unsigned char[16]'} [-Werror=array-bounds]
  286 |                 up[0] = byterev_8(up[3]);
      |                         ^~~~~~~~~~~~~~~~
arch/powerpc/lib/sstep.c: In function 'emulate_loadstore':
arch/powerpc/lib/sstep.c:681:11: note: at offset [24, 39] into object 'u' of size 16
  681 |         } u = {};
      |           ^
arch/powerpc/lib/sstep.c:681:11: note: at offset [24, 39] into object 'u' of size 16
arch/powerpc/lib/sstep.c:681:11: note: at offset [24, 39] into object 'u' of size 16
arch/powerpc/lib/sstep.c:681:11: note: at offset [24, 39] into object 'u' of size 16
arch/powerpc/lib/sstep.c:681:11: note: at offset [24, 39] into object 'u' of size 16
In function 'do_byte_reverse',
    inlined from 'do_vec_load' at arch/powerpc/lib/sstep.c:691:3,
    inlined from 'emulate_loadstore' at arch/powerpc/lib/sstep.c:3438:9:
arch/powerpc/lib/sstep.c:287:23: error: array subscript [3, 4] is outside array bounds of 'u8[16]' {aka 'unsigned char[16]'} [-Werror=array-bounds]
  287 |                 up[3] = tmp;
      |                 ~~~~~~^~~~~
arch/powerpc/lib/sstep.c: In function 'emulate_loadstore':
arch/powerpc/lib/sstep.c:681:11: note: at offset [24, 39] into object 'u' of size 16
  681 |         } u = {};
      |           ^
arch/powerpc/lib/sstep.c:681:11: note: at offset [24, 39] into object 'u' of size 16
arch/powerpc/lib/sstep.c:681:11: note: at offset [24, 39] into object 'u' of size 16
arch/powerpc/lib/sstep.c:681:11: note: at offset [24, 39] into object 'u' of size 16
arch/powerpc/lib/sstep.c:681:11: note: at offset [24, 39] into object 'u' of size 16
In function 'do_byte_reverse',
    inlined from 'do_vec_load' at arch/powerpc/lib/sstep.c:691:3,
    inlined from 'emulate_loadstore' at arch/powerpc/lib/sstep.c:3438:9:
arch/powerpc/lib/sstep.c:288:23: error: array subscript 2 is outside array bounds of 'u8[16]' {aka 'unsigned char[16]'} [-Werror=array-bounds]
  288 |                 tmp = byterev_8(up[2]);
      |                       ^~~~~~~~~~~~~~~~
arch/powerpc/lib/sstep.c: In function 'emulate_loadstore':
arch/powerpc/lib/sstep.c:681:11: note: at offset 16 into object 'u' of size 16
  681 |         } u = {};
      |           ^
arch/powerpc/lib/sstep.c:681:11: note: at offset 16 into object 'u' of size 16
arch/powerpc/lib/sstep.c:681:11: note: at offset 16 into object 'u' of size 16
arch/powerpc/lib/sstep.c:681:11: note: at offset 16 into object 'u' of size 16
arch/powerpc/lib/sstep.c:681:11: note: at offset 16 into object 'u' of size 16
In function 'do_byte_reverse',
    inlined from 'do_vec_load' at arch/powerpc/lib/sstep.c:691:3,
    inlined from 'emulate_loadstore' at arch/powerpc/lib/sstep.c:3438:9:
arch/powerpc/lib/sstep.c:289:23: error: array subscript 2 is outside array bounds of 'u8[16]' {aka 'unsigned char[16]'} [-Werror=array-bounds]
  289 |                 up[2] = byterev_8(up[1]);
      |                 ~~~~~~^~~~~~~~~~~~~~~~~~
arch/powerpc/lib/sstep.c: In function 'emulate_loadstore':
arch/powerpc/lib/sstep.c:681:11: note: at offset 16 into object 'u' of size 16
  681 |         } u = {};
      |           ^
arch/powerpc/lib/sstep.c:681:11: note: at offset 16 into object 'u' of size 16
arch/powerpc/lib/sstep.c:681:11: note: at offset 16 into object 'u' of size 16
arch/powerpc/lib/sstep.c:681:11: note: at offset 16 into object 'u' of size 16
arch/powerpc/lib/sstep.c:681:11: note: at offset 16 into object 'u' of size 16
  CC      arch/powerpc/kernel/jump_label.o
cc1: all warnings being treated as errors
make[2]: *** [scripts/Makefile.build:271: arch/powerpc/lib/sstep.o] Error 1

These errors above are unrelated to the patch.

[1]: https://lore.kernel.org/linuxppc-dev/20220531065936.3674348-1-mpe@ellerman.id.au/

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
