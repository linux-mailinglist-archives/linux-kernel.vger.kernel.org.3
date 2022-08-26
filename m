Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE5B5A248A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344069AbiHZJb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343891AbiHZJbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:31:17 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAA6ACA0C
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:30:45 -0700 (PDT)
Received: from mail-ej1-f49.google.com ([209.85.218.49]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mi2Fj-1p5EDC2Axl-00e4O8 for <linux-kernel@vger.kernel.org>; Fri, 26 Aug
 2022 11:30:43 +0200
Received: by mail-ej1-f49.google.com with SMTP id cu2so2127742ejb.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:30:43 -0700 (PDT)
X-Gm-Message-State: ACgBeo2Wkugvqr484+kz612A007e5YkwemIIDjetfdzfxWg5GNwTD7N+
        sbf3wy6sDs0xY14r/8ZKiozS3oXB1/LDZ7tG+cM=
X-Google-Smtp-Source: AA6agR5zhGF9mzoWCaPEcROFHwnBUwStiaSTKXmkpCqTBaUZ9tbsyjcAa2ol84dp24RH8sH9Me5p4ygFgW6eagFvC7E=
X-Received: by 2002:a17:907:6d8a:b0:73b:d9e4:e628 with SMTP id
 sb10-20020a1709076d8a00b0073bd9e4e628mr4976713ejc.75.1661506243208; Fri, 26
 Aug 2022 02:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220815032025.2685516-1-tongtiangen@huawei.com> <20220815032025.2685516-2-tongtiangen@huawei.com>
In-Reply-To: <20220815032025.2685516-2-tongtiangen@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Aug 2022 11:30:26 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0ixaYimjCh77QBJpbHbVsw+9C7RiW2LEnwQ8HnwG_jHg@mail.gmail.com>
Message-ID: <CAK8P3a0ixaYimjCh77QBJpbHbVsw+9C7RiW2LEnwQ8HnwG_jHg@mail.gmail.com>
Subject: Re: [PATCH -next v2 1/2] riscv: uaccess: rename __get/put_user_nocheck
 to __get/put_mem_nocheck
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Conor.Dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wangkefeng.wang@huawei.com, Guohanjun <guohanjun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:21wg4Af8vMqmfAMRWeb9fgbFin1L64mzB1JUEB7Rix+ihc7J8Tf
 /UugRLP+HSTYSDkck3sK30iQ8OxUUDmORQXSEh7YpY1xL8UNNj5djrJzR8STZ5uvxjaTjJd
 sMOLsPOf/6oaAMCZFdZ4AUlev5LN5gmsJ8vaqTPCpS8j/wxt3wYa6dkn6PANwI/MY6XkcS1
 u++f4Jq4G6GstuUH+jjEQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HjVqvFD8ruw=:U5uUH1w55Rhch2BZhbJ/8N
 gFim4FEqg6F3nt0y950ddJ+csDGT4v5Xdaz5YIEqzGTABoh3S/lPWVP3gnM68IU0LAklEambV
 o53DO7dNsVJ9a7R+YURG3OLgQuBbPYMu1ZOmQ1KChyMr0pZJw7i+/5a4dhuBGG8cbSLWlPRwC
 zZXe9WnZUOldp/Pv0xIt9xfjhn8NyeGxXr1fo0/ooDRYHTSsu3bMsXOj29+790YSNdydrqcCh
 Cqy9Cq/Jjq3CTj2A0A+iEdDRrI5FpfIwFqacb6ArKhfYpR4gImHYVQsj7jSTnWunVoJqOJyFp
 OYL2ELZsF8QvKJrnQFbOTtocK4WxZvKstYuzvhGCLq6GJE24EzpwwjrH4F4j8NHYvyr6AOr1c
 PSMYVEwDFSeE4Uy4x9N5NRGP3Z8zn4p346dpYctD2GQOeTRB+UNMx/q/WYpQG2jpS7HNGQwXz
 GvxvUXtseSTuvvVIrczcNQjS9w1JhQGIwv5mhlq/Szd0KBsHZ9R6yq2BPDcOecfy8Z2KHn1QE
 HPpFRBykI6ZUqojatT0hGVw0iDiQbY9H5eC4oNQE4yn14/fHmurVO5js9dRmpX5NvE/OnvE1V
 XZiS8OPoScisT/phnSlCnwtYnEgoQBv/GFRfDdyLBGMTaz45kJAV2cbMhdZAiA+RYMRsmcbXL
 yNoOHeIiEzEZoc57JwhYxUCpZuBo6RDx6eByZLTxFvUswaP1P7wghztmE1J+Jk4wpLcxRYBA7
 tr0OUGiJT2YWmAvBXVCsb8Xi5gQVpqfx2lmZ60n4qubUUxY9tYcq6BzDQ6GvgpG1Qzoq1iYJ6
 UJ5TIEx+p3G0pbN+9FVh6dAbUNCawzegek2z7d/cF37vDvn2hqw690kov88gPLDuZdXjAsk+M
 vgeadXU1F5SbTcfB5ZOw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 5:20 AM Tong Tiangen <tongtiangen@huawei.com> wrote:
>
> Current, The helpers __get/put_user_nocheck() is used by get/put_user() and
> __get/put_kernel_nofault(), which is not always uaccess, so the name with
> *user* is not appropriate.
>
> Also rename xxx_user_xxx to xxx_mem_xx  on the call path of
> __get/put_user_nocheck()
>
> Only refactor code without any functional changes.
>
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>

I would prefer this not being done, it just makes riscv diverge from the
code on other architectures. While the new name does make more sense,
it ends up making it harder to refactor this across architectures in the end.

There are two important cleanups that I would like to see done in
asm/uaccess.h across architectures:

 - generalize the __get_user()/__put_user()/__get_kernel_nofault()/
  __put_kernel_nofault() wrappers to the point that architectures do not
  need to worry about the variable type stuff but instead just provide
  trivial fixed-length helpers of some sort

- change the calling conventions in a way that allows the use of the
  asm-goto-with-output method for better object code on modern
  compilers.

The x86 version already has most of this, with their
__get_user_size() macro supporting both the asm-goto label
and the error code assignment, so the generalized code should
probably be based on that approach.

       Arnd
