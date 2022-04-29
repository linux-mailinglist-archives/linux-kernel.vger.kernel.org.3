Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471DB515270
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 19:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379741AbiD2Rno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 13:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379249AbiD2Rnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:43:42 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D20B1BE89
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 10:40:22 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id o11so6267706qtp.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 10:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=7R74MuG17CM4y+tqR9noT9bT0HIvwsXlMQlpqocbRZ0=;
        b=o+9kiW06Ear6403XlouAhjtHmvWajVAJup+DwkzmRZDB+EMWCIK5RtC0JBtIyGp37V
         /F6kRqoueF/HyQCdTymTba1S7XZwMWYvMxZvakEMCRyGfV6nLAF7Xnr7RyDNc33QUOU5
         ruylKv7Xozy8JvUqWXVLBBRw56lMPjQHXfWTqhr5JPgy04r90+cI9cIFOu8jBozY5dZA
         HOAy3hJ1DDMuOtFdCU/odzcFjY/RpO2Zm8MLXBLGPIe7BQxVUAoSFOtjvuyy14VtHO7k
         19d33diYxHBZv8Cu+acbqmW98CGX21OWkQB9AtURV5gzGUb2oDu6scDZJuJTAVYdWoFl
         Ui3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=7R74MuG17CM4y+tqR9noT9bT0HIvwsXlMQlpqocbRZ0=;
        b=exFoNhoe76M/gB8Ae6QMgcWN/hODBEf425DxZLOUk9aibHRBsU8vQ08CDAQ04/Re1N
         edwZLPaOdHLF47uc8M/OT1+/VKr7qm9fqPiQishlA9+OQEow3pJW/Um9pqF0UdJZAJYR
         jA+zRVA9d4YufZcMEzXQo8YyhHHl7s1CSuX+L/xyRbG1j5V6S49E/DnlVLMe0JBlNDLN
         PSo+pZV3WRtejsOD4RHDLuzE/YjDm+G35FVVG5Rl2rjSSEEGIs/wnYwtIEqULVIiJY4K
         7SmZYfc+WjfejbXoE3fI1jaGsLYQamGIUtq01EufAA7txyIj26/KAvnuPm1zcSaHJPfK
         BVzg==
X-Gm-Message-State: AOAM531pcLdkGKVRIv1mKXXa6/rUhLh/8f5qP7SH3elEH/pLewuhMqTp
        D5pLKie9X6K4cVMg/hKD/9/In/D+sxPj0PSgeL2YB/Il+f+Kyg==
X-Google-Smtp-Source: ABdhPJyhZPnRHRsx2Fr8nKWfckqtZ7fx6cgBIwqCsAGaWziFpvo7WI5UnhsQ1OPW9phEMafD2Zpvkiz5VO8VCWwEdJ0=
X-Received: by 2002:a05:622a:613:b0:2f3:64b5:82d with SMTP id
 z19-20020a05622a061300b002f364b5082dmr496287qta.176.1651254021146; Fri, 29
 Apr 2022 10:40:21 -0700 (PDT)
MIME-Version: 1.0
From:   Mauro Rossi <issor.oruam@gmail.com>
Date:   Fri, 29 Apr 2022 19:40:07 +0200
Message-ID: <CAEQFVGZ=6K8wudbS--3z+JpKTsL_dfM-8Co7NwViRo0i3t2EZg@mail.gmail.com>
Subject: arch/x86/entry/entry: RFC on recent kernels building error with llvm
 11.0.2 internal assembler
To:     luto@kernel.org
Cc:     Chih-Wei Huang <cwhuang@android-x86.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I am an hobbyist contributing to android-x86 FOSS project lead by
Chih-Huwei Huang (in Cc: for information/alignement)

I am performing periodic tests to build kernel for Android 11 based iso image
which relies on aosp shipped prebuild clang toolchain (clang version 11.0.2)

When building linux 5.18rc4 and also with linux 5.17 x86_64 64bit kernel targets
there is a building error in arch/x86/entry

  AS      arch/x86/entry/entry_64.o
<instantiation>:2:2: error: unknown use of instruction mnemonic
without a size suffix
 lsl %rax, %rax
 ^
<instantiation>:1:1: note: while in macro instantiation
LOAD_CPU_AND_NODE_SEG_LIMIT %rax
^
<instantiation>:2:2: note: while in macro instantiation
 GET_PERCPU_BASE %rax
 ^
/home/utente/r-x86_kernel/kernel/arch/x86/entry/entry_64.S:890:2:
note: while in macro instantiation
 SAVE_AND_SET_GSBASE scratch_reg=%rax save_reg=%rbx
 ^
make[3]: *** [/home/utente/r-x86_kernel/kernel/scripts/Makefile.build:389:
arch/x86/entry/entry_64.o] Error 1
make[2]: *** [/home/utente/r-x86_kernel/kernel/scripts/Makefile.build:550:
arch/x86/entry] Error 2
make[1]: *** [/home/utente/r-x86_kernel/kernel/Makefile:1887: arch/x86] Error 2
make[1]: *** Waiting for unfinished jobs....

As other interesting info, the building error does not happen when
building x86 32bit kernel target and i can build 86_64 64bit kernel
target only by setting the LLVM_IAS=0 parameter to disable the
internal llvm assembler

I wanted to ask you if you could help us, if there could be a way to
improve arch/x86/entry/entry_64.S code to be able to complete the
build without disabling the llvm internal assembler.

I don't know if this building error may be caused by the clang version
11.0.2, but at some point the aosp and android version may hit this
same issue,
so I wanted to highlight this issue to you to have a competent person feedback,
as I am more a "trial and error" guy than a kernel expert

Thanks in advance for any info

Mauro Rossi
android-x86 team
