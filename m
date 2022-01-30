Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5974A3352
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 03:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353799AbiA3Chz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 21:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347293AbiA3Cho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 21:37:44 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9373FC061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 18:37:40 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id f17so18560841wrx.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 18:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vLtkfxTppzjqAs4qFSW7j7IwVyTvqHPGWoj6Ja3JSVA=;
        b=V3qFFxZu0vXFacwzlhDVKlK+Z9HezkvglwIKGkkPfXh7itlxl21vgvvXUgJpZlS3DK
         vQCF9uWe9gSvMiOhGKY+gZutXPZGe/e4JsHlSD328ZliAgyqkwZ8MVIuW5XPs8UEKbn6
         YRTRNjlyhpv3qCrwDpecjmmIMuMX38FbpqLpmuK8A2rOQZ7MetXxEQzu8CdMCzoWH1yb
         Hnk7tqS8oA0a2bxnpy32duUpAKPr+ii0XAYHSI6fv9PMqN2hNK2RUUsCUkApCzkNct7C
         D98Bp7Sa1iNM+jsQozt3fSOcT/UHvjAaxt453xGzNFre52sRDb7Jlqch5TAb939BcAel
         wz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vLtkfxTppzjqAs4qFSW7j7IwVyTvqHPGWoj6Ja3JSVA=;
        b=6CToF5/tCFPg2KR2Z77R4y5fkWAsomWn7Pc64mSB7d4eNsRmc8H0UDZCnxDaUJZ6MP
         FS8pMdqve+t7uFUvYj7KsEyEguxmhpUzyk3CQ+KNHxwEBpo/HfTlz78p7ryBF8h0GLFa
         LV1d3nBT6jpm/EsvYZ3vIZuyF1ENTBb4NCuks51l4PoPG+yGubpxkfWlV+0Es8vEUmgO
         +TnwAAa5LUtUpjck44pqMj8eOlrFDgAt0zKwA25xnWgHyBELsvxN+Y0332UyHcnP7uV/
         JncR3wOXAqIf2qMRdbF65BFNMRouoo9Y55drYIbhGsqQBtKA+idGHAQwr4Mdued4pFLF
         /Nww==
X-Gm-Message-State: AOAM5304GwMZ++AUi/rQk3YTA18YGpvNdLbU6TRvedqSyIdxqUvVLLHs
        Xb3bH96Vn9TQsEmswbun4Ut/2eACPodAwbxnoOeLUzYZ
X-Google-Smtp-Source: ABdhPJzwIjjthFuSWsXAiAOcT5gd/S8JKB3665K8xUDZBXELJ+JZAaje+zwScKKgrOb+L+MnpZ2sTxtbesWt/LM0lB4=
X-Received: by 2002:a5d:5283:: with SMTP id c3mr12176707wrv.554.1643510259157;
 Sat, 29 Jan 2022 18:37:39 -0800 (PST)
MIME-Version: 1.0
References: <20220113013835.503285-1-xiehuan09@gmail.com> <20220118232448.891fbf550b50193e0155b59c@kernel.org>
 <CAEr6+EB+ENLJM1vU1pPgQ4ZcYe6FDSRWwdSpY_dLq0tGqr+tnQ@mail.gmail.com> <20220127005447.143a840e9b0f67d894b8c54a@kernel.org>
In-Reply-To: <20220127005447.143a840e9b0f67d894b8c54a@kernel.org>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Sun, 30 Jan 2022 10:37:28 +0800
Message-ID: <CAEr6+EBywRqWL-LSoH6Fx6tbkG6zFRMAAavoNVL79zdJuz5EBw@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] trace: Introduce objtrace trigger to trace the
 kernel object
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Wed, Jan 26, 2022 at 11:54 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi Jeff,
>
> On Wed, 19 Jan 2022 10:32:49 +0800
> Jeff Xie <xiehuan09@gmail.com> wrote:
>
> > > > Note: when change to use the ftrace_test_recursion_trylock, all the functions
> > > > will call the copy_from_kernel_nofault, I don't know where this is the problem now,
> > > > maybe should fall back to the usage in v6.
> > > >
> > > > for example:
> > > >
> > > > cat-118     [000] ...1.     1.458998: __bio_add_page <-bio_add_page object:0xffff88811a12e9e8 value:0x0
> > > > cat-118     [000] ...2.     1.458998: copy_from_kernel_nofault <-trace_object_events_call object:0xffff88811a12e9e8 value:0x1000
> > > > cat-118     [000] ...2.     1.458998: copy_from_kernel_nofault_allowed <-copy_from_kernel_nofault object:0xffff88811a12e9e8 value:0x1000
> > > > cat-118     [000] ...1.     1.458998: __rcu_read_lock <-xa_load object:0xffff88811a12e9e8 value:0x1000
> > > > cat-118     [000] ...2.     1.458998: copy_from_kernel_nofault <-trace_object_events_call object:0xffff88811a12e9e8 value:0x1000
> > > > cat-118     [000] ...2.     1.458998: copy_from_kernel_nofault_allowed <-copy_from_kernel_nofault object:0xffff88811a12e9e8 value:0x1000
> > > > cat-118     [000] ...1.     1.458998: __rcu_read_unlock <-xa_load object:0xffff88811a12e9e8 value:0x1000
> > > > cat-118     [000] ...3.     1.458998: copy_from_kernel_nofault <-trace_object_events_call object:0xffff88811a12e9e8 value:0x1000
> > > > cat-118     [000] ...3.     1.458998: copy_from_kernel_nofault_allowed <-copy_from_kernel_nofault object:0xffff88811a12e9e8 value:0x1000
> > > > ....
> > >
> > > Hmm, this is strange, but I got it is the expected behavior, since the
> > > ftrace_test_recursion_trylock() accepts one stage recursion for the
> > > first event in the interrupt as transition event.
>
> I think you should revert that change and back to your own per-cpu recursion
> flag instead of using ftrace_test_recursion_trylock().

Thanks, I will revert it.

> Thank you,
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>

---
JeffXie
