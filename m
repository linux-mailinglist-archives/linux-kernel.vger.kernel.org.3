Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C284537175
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 17:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiE2PDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 11:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiE2PC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 11:02:59 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54A2939A7;
        Sun, 29 May 2022 08:02:57 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c65so7900951pfb.1;
        Sun, 29 May 2022 08:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bLCmpWQzHcqeVCB87cxLHHFCd5x0M9YCEtp4WUsQ82Y=;
        b=P6z7lxhi9GL7jZKTwXRm/Ke9ijypFXom3hc0wwJF1KlOi5wNneFMPqQ4haGxkaYHQn
         tuZIl9f9/2/OtHiFgwpz7y/h693fk+PEnkmHNCJtvKE+ZxrNcJV7FQR5uC6H8JANQg3A
         NoyyIii1y7K/EOvLaEcMd4pK17M1Uk/FbpJz1AFk/wsGjkccadilsK6cAcKSGOoIJoeA
         W4zNEg8TVM0sKb3RblMsS0+J8a9U6d8qlpRuXbrQkEeDqWMSsIqrarwhPdHDcB3yjb4I
         SEre0KelOMMHCVyR4O1+HWCzGUXd1jIH8FuLbts5VHMLY6bHtiGMiWYHMBlnxhMGHyZ5
         7LvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bLCmpWQzHcqeVCB87cxLHHFCd5x0M9YCEtp4WUsQ82Y=;
        b=4ODDpkrRaBbmqxmu4bhBFpFK6/r5CVjJeagcUTXO+LBQlSegAPUNMryuL37ARjoFLf
         T5qqu8uElElHA7zSVF3OXaWnbxfLbxAirZbVxVTJK5N1omCToBUj79/Jo/15pDAoYaVB
         tTMMxuXh3BiqXiYnlSvw+JLvTF6k+g7dkFQZfPdmeoxunn23nw97GLt1iJdwM96Sawfh
         gXBkGADnMgkIDFiPQBSGtZiFxzVmvLdIUm7J50CZoeWVpRX9BPV5gEin3RomdoOKL+ls
         T8aM8MwKvDXUyWsyfpQJ3OvZ0WG0cef2ct+VMrk7e6AayYqlRa828cxEp0Yu81n0/JYK
         RqjQ==
X-Gm-Message-State: AOAM5306KfWnfIewOFhKty0aQGizDT2K5KpLz//vHgvn/W4JWFSlaPtP
        DnXyJpKUePAhnfiR8Xq5t0o=
X-Google-Smtp-Source: ABdhPJzCcBxx7xT7JPAGtcDAhscY5giHijK08sTWr8RdGXxgY5ZS8mRjDiz+ZSiX4bhupXj3aoeAuw==
X-Received: by 2002:a05:6a00:7d8:b0:518:8f93:555f with SMTP id n24-20020a056a0007d800b005188f93555fmr38432094pfu.31.1653836577104;
        Sun, 29 May 2022 08:02:57 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id 66-20020a621545000000b0051849bc0c23sm7022050pfv.23.2022.05.29.08.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 08:02:56 -0700 (PDT)
Date:   Mon, 30 May 2022 00:02:54 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Guo Ren <guoren@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-csky@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        nicolas@debian.org
Subject: Re: [PATCH] kbuild: ignore *.cmd files for objects that come from
 libgcc.a
Message-ID: <YpOLHkUZImdEr7yl@antec>
References: <20220529042318.2630379-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220529042318.2630379-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc Joel, Nicolas

On Sun, May 29, 2022 at 01:23:18PM +0900, Masahiro Yamada wrote:
> Guenter Roeck reported the build breakage for parisc and csky.
> I confirmed nios2 and openrisc are broken as well.

Joel reported and issue building the openrisc kernel as well with this error:

    This fails at the link step:

      LD      vmlinux.o
    + or1k-elf-ld -r -o vmlinux.o --whole-archive
    arch/openrisc/kernel/head.o init/built-in.a usr/built-in.a
    arch/openrisc/built-in.a kernel/built-in.a certs/built-in.a
    mm/built-in.a fs/built-in.a ipc/built-in.a security/built-in.a
    crypto/built-in.a block/built-in.a lib/built-in.a drivers/built-in.a
    sound/built-in.a net/built-in.a virt/built-in.a --no-whole-archive
    --start-group lib/lib.a /usr/lib/gcc/or1k-elf/12/libgcc.a --end-group
    or1k-elf-ld: /usr/lib/gcc/or1k-elf/12/libgcc.a: error adding symbols:
    archive has no index; run ranlib to add one

Is it the same? It might be good to have details of the error in the commit
message.

> The reason is that they borrow libgcc.a from the toolchains.
> 
> For example, see this line in arch/parisc/Makefile:
> 
>     LIBGCC          := $(shell $(CC) -print-libgcc-file-name)
> 
> Some objects in libgcc.a are linked to vmlinux.o, but they do not have
> .*.cmd files.
> 
> Obviously, there is no EXPORT_SYMBOL in external objects. Ignore them.
> 
> (Most of the architectures import library code into the kernel tree.
> Perhaps those 4 architectures can do similar, but I am not sure.)

Ill have a look at this.  Could you give an example of what you mean by import
library code, from where?  OpenRISC imports builtins from libgcc, also we have
string and other lib routines from within the port.

-Stafford
 
