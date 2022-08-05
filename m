Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1F158A793
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 09:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240385AbiHEH7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 03:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbiHEH7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 03:59:34 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784C1220F9
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 00:59:33 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id j8so3600939ejx.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 00:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=azItuMjcULTJ7HJCVkLEBIxeeauBN6eYRbAvwgPXWnU=;
        b=U2d/jroq0zsw5+eY3d19/zefaVNsbBlJ9Bi0spM4lr3wlRb7Mx6hD4tcC6APVNBOtz
         +fmU3R8Kyj2pg/5U3/JUGMZjBElkfaj+50cGuyg9ZaGObXtowBbHE5UdBiQufU7fdq2a
         d2vHLm6zn9p8BmFWeAVWl8s44xFUeJttRTRR2zyaujqM2vJsJHdrC6h3IQ/nyAuJFImL
         9O+V5uzAcaZJMoiCT4G4hFBVkv9SM/XvmaAwmmW/Ohsa2EsOkQp4NJDXeLcGc2tko1Va
         WrOZqsazPApQ7ezOaku0lwSkQ3BjMzZz3eT1Jmlo77Kn8vp2Q5b8x/6lkc5i7Oa/8S/z
         sdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=azItuMjcULTJ7HJCVkLEBIxeeauBN6eYRbAvwgPXWnU=;
        b=8KVHacdtQy+2iGDbBUI3lf+RQK8Fu8Hkt+ZnLFdviGQoticPtQjY9cmjph6e4l+Wkb
         mFsESbWZacApGI37C1TbL0N4FZglIhZxtc07aT++1tPLyp7V5fCFXbxlgLPb6SIJW8XX
         Bqo7t9yD9iBcYSjjGU7nzcfRLQjG8Da0Y/zvymYVz+PrsbjizwTscfuKDtgVCYd/2vn+
         ZE73baBwjQ0GluOlY4mEg579g7MtKfV4MpDDGkH5tClytT6QjylfzB2JBbS/OTn4x2y5
         7TgWHSu+MjUz24c7Ipws+yLUsGeG+Iz4j5roeouDUgyAdaFKbJYSvi9Kg16nXGWkO47Y
         sD6Q==
X-Gm-Message-State: ACgBeo3D0ZqPlpVuPgdFSIsDUWQ1cpyqbG4xgGeG8OIBr0Txb+6+nzd9
        /OepEKoznvkxiJJ4/mI1VxM=
X-Google-Smtp-Source: AA6agR6rK1SbjNrVnDvI6psDqKbtosqtpc6Z3ro1puQx7dBZ6XNH+qavFW+ZrhhPYC149KS0g5MubA==
X-Received: by 2002:a17:907:a06f:b0:730:69c7:9a1d with SMTP id ia15-20020a170907a06f00b0073069c79a1dmr4262087ejc.685.1659686371966;
        Fri, 05 Aug 2022 00:59:31 -0700 (PDT)
Received: from gmail.com (195-38-112-141.pool.digikabel.hu. [195.38.112.141])
        by smtp.gmail.com with ESMTPSA id pg25-20020a170907205900b007306ae5bb1esm1275079ejb.82.2022.08.05.00.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 00:59:31 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 5 Aug 2022 09:59:29 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Thomas Gleixner <tglx@linutronix.de>, Dave Jones <dsj@fb.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2]  x86,mm: print likely CPU at segfault time
Message-ID: <YuzN4WeH6GER2YJy@gmail.com>
References: <20220804155450.08c5b87e@imladris.surriel.com>
 <YuwpQEYCwTl+m6j5@gmail.com>
 <17b83f59efbc568c1fe3154f82a5300f3b4cfe24.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17b83f59efbc568c1fe3154f82a5300f3b4cfe24.camel@surriel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Rik van Riel <riel@surriel.com> wrote:

> The show_unhandled_signals variable seems to be controlled through 
> /proc/sys/debug/exception-trace, and be on by default.

Indeed ... then this too should be pointed out in the changelog.

Plus the patch doesn't build on top of the latest upstream kernel, 
x86-defconfig:

  CC      arch/x86/mm/fault.o
  In file included from ./arch/x86/include/generated/asm/rwonce.h:1,
                  from ./include/linux/compiler.h:248,
                  from ./arch/x86/include/asm/current.h:5,
                  from ./include/linux/sched.h:12,
                  from arch/x86/mm/fault.c:7:
  arch/x86/mm/fault.c: In function ‘show_signal_msg’:
  ./include/asm-generic/rwonce.h:44:71: error: lvalue required as unary ‘&’ operand
     44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
        |                                                                       ^
  ./include/asm-generic/rwonce.h:50:9: note: in expansion of macro ‘__READ_ONCE’
     50 |         __READ_ONCE(x);                                                 \
        |         ^~~~~~~~~~~
  arch/x86/mm/fault.c:773:19: note: in expansion of macro ‘READ_ONCE’
    773 |         int cpu = READ_ONCE(raw_smp_processor_id());
        |                   ^~~~~~~~~
  make[2]: *** [scripts/Makefile.build:249: arch/x86/mm/fault.o] Error 1

Thanks,

	Ingo
