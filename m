Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B73B47C805
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 21:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhLUUFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 15:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhLUUFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 15:05:45 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08ADC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 12:05:45 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id j185so445361oif.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 12:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g-ucla-edu.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=IcADycjv4yaHDZIrNz3/g6/K92NSo28ivScn2Hoaips=;
        b=KE6BRSmeed4aet7tJt+tntAEF2WCocmzh4qz+oO1k5Jb3rxneBgNNAu3x2N6RWUd8i
         jSHhM2s0j1RlLFSCYEfX6qOEy1YtOtYP42BDoRZ/WO8v5KWPs9eGJrrJSziIdvdeqjIn
         tGjS4OaUuNHhB5V7QnZvwOWtDhvjUsF+hUS1JgQq6kkr76coQaZ1aFB/M/g1qdy+gusS
         glUPd3EsTkU9u45wefkmm5hwKL53ULTz9HCJNnpCliPK6wHy6Q69yKnJHq1HfNstNVYr
         rCGOoyIRabs6cpYY5+RxkQquv4wS6DR1MSXGXsOsjSn+6JBNUhuE12XKbEGHtuw8h5s3
         mhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IcADycjv4yaHDZIrNz3/g6/K92NSo28ivScn2Hoaips=;
        b=RX9QzrxDipnYiRC11OhfJFZIxkq9NNWy823NHa7884NqYAUr/Dj2FT0Q/Hm1dyfV/w
         A2fnwKS8v2moIf45YuAW3MIFMSysrnXmKWoyltUDgWV1fDXBgjKzb/vYgFpTuWeZHpOo
         aHH7fP+72Cps21bMKb5kR86QomlyMO9AqFugQgcNMltrX7SeIXiafAMaqdFrgB6sdbDI
         OO61Yhpg4kovSKRKoXDV0Rai8RYFH6OaT2t44PZWfunNIK0XsT7v9qXdGRGvII5MbbWO
         nnKIm4DOGYsgtA0h/Cz1Z3QsqsoqzdATF0lVq8PpdUXR5NkAEBWtKC+BPW4rUWhQHuBq
         Sg0A==
X-Gm-Message-State: AOAM530Ya/VxexU4+ucm2sWyAJg7cSrQZWI+fmeLe/e/rMvTDaFxUYPI
        vi1ogTlMi/z4KrJFso0UlayFsoJk6hvbIdirjv5uxNYXU0kJnA==
X-Google-Smtp-Source: ABdhPJyeD5V6/OnR497g9OxxinW/ztLBE91/PBJha4mQPstqXNRpNaqF+gEpWbKwxeI/iCNK+Pd8qLPLBhY12fGZJiw=
X-Received: by 2002:aca:efc4:: with SMTP id n187mr57328oih.114.1640117144908;
 Tue, 21 Dec 2021 12:05:44 -0800 (PST)
MIME-Version: 1.0
From:   BOTONG OU <richard97@g.ucla.edu>
Date:   Tue, 21 Dec 2021 15:05:34 -0500
Message-ID: <CACCnfy8-+29ZOOBFmbhUb4KKhm73zUXL9VaOXM6+-cfR9f5ekw@mail.gmail.com>
Subject: Linux kernel page table creation for X86_64 system
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am recently learning how the Linux kernel page table is created for
the X86_64 system. Here are some questions I have:
1. When the actual initial kernel page table is created which is
init_top_pgt, there are some entries of it that are initialized. As
far as I know, kernel mapping area (map to kernel image), direct
mapping (0-1GB), vmemmap, ioremap, and vmalloc area in the initial
kernel page table are initialized and mapped to physical memory. Is
this correct? Is there any other area I am missing?
2. In order to handle the 128TB kernel physical memory, more page
tables have to be created to map to the physical memory. However, I
can't find in the kernel where are the extra page tables being
created. Does the kernel create the extra page tables using, for
example, pgd_alloc interface? or other interfaces.
Thanks for answering my questions.

Best,
Botong
