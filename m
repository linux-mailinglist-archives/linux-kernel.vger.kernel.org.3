Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B995B26A3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbiIHTSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 15:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiIHTSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:18:14 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5B6F2979
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 12:18:13 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id q9so17654050pgq.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 12:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=uXZ72Rh6Uf1P0vaCNWsktiSS+D98F5G+wYh6Ba3CkY4=;
        b=5quAYYt4J8enmwF/gk0DsGJfpzDcms+2Sm3DS9sHUdaYGFchMgcUDNOD9dtxb8qNzC
         Gl01AjLNITNHcqURX2zNy9ceVGdJ1OM2onrNOYuNlrZsTSoLFxuACkXdwnA4C1YkPLEO
         O54QURbFenuAK7w/j3MzjRjE0N9Y+pLD17CIZ1QpJBFxK1uU7Ez+3r+w1u5rhZHkkKsX
         wYXZ3FtS0NMnt6UOdo6cepj7J5ge9JyTXK3/dFQ8DhYMTPOTNfSwB6U2FJaF+B2PbcJz
         1IM0qD6T0t6M+Uts1mDD4NnEZTj7ASNEbA+CI1lT8ljEjJ7NZAbxZ++FRpVUVT6jcNmj
         sWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=uXZ72Rh6Uf1P0vaCNWsktiSS+D98F5G+wYh6Ba3CkY4=;
        b=WXfTQzYzA/2D+PAOlLlguN4ivLXHTQmDAwsdoT974n6WYf/GV0/o/RNiXXwdEL5Db8
         WcaiTqqMnwWQLmHIz2McZESuFSj07Sk1TQ3IXVdvPAaa5znNzkDe3dkEQ23wxqASvGXM
         MCNvrlHRXtpj9GUXuwokz4GgJUOtNHpXPBgxvCVhGfrxr4HRy047WpkmfuiEkz6v8uww
         iGdFDJdr5sNfClHnRQjzPPrcc1axHbT7Ysheyj+1MXxLTEVqIQKAcp+tQ836wBs8ApZN
         /JRS0ndSW6sOzcDcE3ej1qhrWCt7RCo9BU0LSVoVKwm1p0fmO7ubjxay7gfocZ6eNFPR
         LcXw==
X-Gm-Message-State: ACgBeo2NUedeUdJY6cj+QQPAwP2NM7ODsGVHjXihAsWnN0Db/iWEKzU8
        id75eBE6EEq8XZFTfnsDX05RC9Dq3RYTWRBxug9P6g==
X-Google-Smtp-Source: AA6agR7oNmciwKq2tiyIsHcViJHuF8+srT5YSZJe69xXEupuFoh3naveFjCmdSh7sLmwjnoEzw0y4VtC8OyYvC3Qnuk=
X-Received: by 2002:a63:8a4a:0:b0:434:c99c:6fd4 with SMTP id
 y71-20020a638a4a000000b00434c99c6fd4mr8787361pgd.24.1662664693483; Thu, 08
 Sep 2022 12:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220908170133.1159747-1-abrestic@rivosinc.com>
 <20220908185006.1212126-1-abrestic@rivosinc.com> <CANaf2sf=W=X0aEpj5haN3ns3XVqZt2si+Q=xFdhaK6GwNR7Tnw@mail.gmail.com>
In-Reply-To: <CANaf2sf=W=X0aEpj5haN3ns3XVqZt2si+Q=xFdhaK6GwNR7Tnw@mail.gmail.com>
From:   Andrew Bresticker <abrestic@rivosinc.com>
Date:   Thu, 8 Sep 2022 15:18:02 -0400
Message-ID: <CALE4mHpO5eFk9-G=RCk97JiwnBMMFLiB4qvV-XXO+N8oxz0QTA@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: Make mmap() with PROT_WRITE imply PROT_READ
To:     SS JieJi <c141028@gmail.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        Celeste Liu <coelacanthus@outlook.com>,
        dram <dramforever@live.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 8, 2022 at 2:57 PM SS JieJi <c141028@gmail.com> wrote:
>
> The v2 patch looks great,
> > -       if (unlikely((prot & PROT_WRITE) && !(prot & PROT_READ)))
> > -               return -EINVAL;
> > -
> This also removes the check for --x pages, which used to be present in
> previous versions (before the submission of the to-be-reverted patch).
> Is this intended? Thanks!

There's no change in behavior for --X mappings; those have always been
allowed as it's a valid set of PTE permissions.

This patch does allow -WX mappings, which were originally disallowed
in commit e0d17c842c0f ("RISC-V: Don't allow write+exec only page
mapping request in mmap"), by implying read permissions for such
mappings as well. I have a note in the commit message about this.

-Andrew
