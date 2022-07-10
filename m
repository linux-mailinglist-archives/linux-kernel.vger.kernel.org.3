Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036CB56D157
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 23:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiGJVWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 17:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJVWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 17:22:30 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76454FD32
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:22:28 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id y14-20020a17090a644e00b001ef775f7118so6569662pjm.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/3Levsfw6LIMCbRxqktEi2reG0/qjlmvH+w7aAlSmdQ=;
        b=oLoJ9m6gLkrWpmwDhevTP4Lanm9YsSml/B7z3qiRlVE833P2ZZ3Y5SiZ9urJqTJTZX
         ZFS2GcEmPq0bWE1V6Phq1cI0c/qNpYLh3VsR7ANRzlMgH1xQqSL1HWYMZUD1XMF0hLSS
         pmcFDIlxPDMEylv3u38YXFb6psCs7nX/BOpSD0Ovk9Q/A5R+gpcEyV63u+eOtckuQ37a
         cYlV+3HhWz7fq12spQqTzH9337RQ5R77Ojq2R54XMsyiagievBsmu/GHyqPkTdtzvbH3
         x7hZsuyOz422y6/i083SoEjcPGByEmbTQ3IzfWx0TfqKLYYaUUyUt17z55g50n2I+q2N
         vJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/3Levsfw6LIMCbRxqktEi2reG0/qjlmvH+w7aAlSmdQ=;
        b=vcORSzwwD0QnTeVJmiJBqf+QQ5yfeLYyifKmKFrcS38qUxqy+0/3BEmMDeBlegyQ16
         95nbPVs20TN4ecqkz4kcdFSQmQpWWghj2NsdwrXU+5F5QD7wt6UlsSFwyG2v3btmoUqG
         AfG8QBA08C7K3sAMa4n5ljeEj6d5Fr0rzeYbz6mMpJAxbMf0ExLETUfq43/PMzkQD5xf
         9BljqWWo4kQ9PGX4BEJSDAL2IBjYnbI2CXef8pE23J1CCmY8M13ZcPVKtU75lDomgUA2
         ExmxFDwoIuD2PgWSbU0gUZ5ldw27mKmU21E1jO6xgEe4k2VIUUpbOJXo2u91X2QZlzdS
         jk7w==
X-Gm-Message-State: AJIora8s7JOgy58+pOSqxNacICF/QIQbZ4LT7muSo6SdknSwJDYxq2fx
        DKv3aFlAfNiD0jBhtNWU/i8=
X-Google-Smtp-Source: AGRyM1vMqaM/EJyjGdtD9cIKE8AIgpk7yw38zaY2CA4Y1uh5UF5JsX+gOuF00xlxIRM4O06+hvXr6Q==
X-Received: by 2002:a17:90a:f48a:b0:1ed:5ec:f890 with SMTP id bx10-20020a17090af48a00b001ed05ecf890mr13982041pjb.40.1657488147615;
        Sun, 10 Jul 2022 14:22:27 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id t16-20020a170902e85000b001678dcb4c5asm3145580plg.100.2022.07.10.14.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 14:22:27 -0700 (PDT)
Date:   Mon, 11 Jul 2022 06:22:25 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Peter Zijlstra <peterz@infradead.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH 1/2] openrisc: Add pci bus support
Message-ID: <YstDEargBYwjN2Yp@antec>
References: <20220709211549.1163327-1-shorne@gmail.com>
 <20220709211549.1163327-2-shorne@gmail.com>
 <CAK8P3a0Mw0Q9_W+xawMe=7UfiQiJT98wybygqg8E8gEuurZCuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0Mw0Q9_W+xawMe=7UfiQiJT98wybygqg8E8gEuurZCuw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2022 at 05:54:22PM +0200, Arnd Bergmann wrote:
> On Sat, Jul 9, 2022 at 11:15 PM Stafford Horne <shorne@gmail.com> wrote:
> >
> > This patch adds required definitions to allow for PCI buses on OpenRISC.
> > This is being in the QEMU virt platform.
> >
> > OpenRISC does not have IO ports so this defines PCI IO to be allowed in
> > any range.  Keeping PIO_RESERVED defined as 0 allows OpenRISC to use
> > MMIO for all IO.
> 
> >
> >  /*
> > - * PCI: can we really do 0 here if we have no port IO?
> > + * PCI: All address space can be used for IO
> >   */
> > -#define IO_SPACE_LIMIT         0
> > +#define IO_SPACE_LIMIT ~(0UL)
> 
> I think '0' is the correct limit here if you don't support PCI controllers
> that can map their I/O ports into MMIO space. If you don't define
> PCI_IOBASE to a meaningful value and set IO_SPACE_LIMIT as you
> do here, every virtual address is treated as an I/O port, so accessing
> a low port through /dev/ioport or a PCI driver results in an access to
> a NULL pointer, which is either a userspace address or low kernel
> memory, both of which are bad.

OK, I see, but I think IO_SPACE_LIMIT needs to be defined as something other
than 0.  It is used to define kernel/resource.c's ioport_resource. For example
on risc-v they set it to 16MB.

I will setup a LIMIT smaller than 4GB and add a PCI_IOBASE.

> Most PCI controller are however able to map I/O ports into the
> physical address space of the CPU, and in that case you can just
> define an otherwise unused address as PCI_IOBASE and map the
> ports there from the PCI host bridge driver.

OK, understood, do you think this needs to be documented in a architecture
manual?  Maybe it's fine for it to be linux specific.

-Stafford
