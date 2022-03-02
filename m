Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C927B4CAD4F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 19:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236261AbiCBSQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 13:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242211AbiCBSQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 13:16:33 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967D7BD8BB
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 10:15:40 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id u28so583066qtc.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 10:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3OzRtoPBXkiAfy8YEZghchEvFFgdKSo2fA+Z61c4cFY=;
        b=JMnuS1C06Jl3OgIq59SU4T+8RZuEZ0QyddEZduLhKQvwCJwR9mf8+dZDenEyg1dQjA
         dngaF2VORflddaBD5L/IXSOXojG+4TkExjtq6cGKlzkrH/HJMALz8f0qeclONCWVP8b7
         rqBw+WXnmwk7NFWTWGLN0QqtPH0iwgs1WYp9Xyq/7UWDu/DYYWUGVfr614Vg6xh4bUTE
         HdldoJY20rcfqepFc0AxSvPmjXPYBtlvcGZg2p/TrS1YpeVNJcjI8AMDhFnDsMAhOsjz
         92FwCuDdkaC99CEUwxJEDmr1I+Jeams6bkb4ZBvTS8dapzGAG8hP2ky0zifp8Tk7PCAM
         vSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3OzRtoPBXkiAfy8YEZghchEvFFgdKSo2fA+Z61c4cFY=;
        b=FXgEROto/gdivmrd6hGqVT6mklzAt892xCLozgagB71eRR54hBVtLesT99Q5lzjaC/
         lqpITHreGd4HE1RlWgHbhqo0kqC2gMkBOWH80VyxagnGk2SWN5ChbnOTWUMXy+CIwA+P
         Mt48Cuio4Pb9Fy+maIpdZKVtmmsepEc64YsS6N9yLQYtJW95fOex1WXFm+yXfay0zGqA
         iwsrxBiWNV7FrFnbZT6IfaYciXFNIKAw5rUjcO5dYhAbinRhevsY3EJvDYrjHnBEV+bK
         fZpBUjwiiFUsFq7/AJVQewzsBu7cUM5H17v7Qw46OEhr8UcIiL/MtdFBgLEyO7gURg5q
         kh/w==
X-Gm-Message-State: AOAM533AGRA/mSPFjKrO0ztfvLVagT/paKLb2q2qnwF08XH0iqTjbcnr
        fpz5BlCDJQvFvAeObfpj4+RSZ/fJRVslcSHr6klPQA==
X-Google-Smtp-Source: ABdhPJxPZPO/xFg13groeF3YFh9yCJd6HA77KJJPB9M0YBKh4qpk5uaPouhOOLa2z2tvQXHhKhHvX0cK3eu96Q1QjxM=
X-Received: by 2002:a05:622a:40b:b0:2df:9e4d:a58b with SMTP id
 n11-20020a05622a040b00b002df9e4da58bmr19254017qtx.309.1646244939663; Wed, 02
 Mar 2022 10:15:39 -0800 (PST)
MIME-Version: 1.0
References: <1646242689-20744-1-git-send-email-vijayb@linux.microsoft.com>
In-Reply-To: <1646242689-20744-1-git-send-email-vijayb@linux.microsoft.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 2 Mar 2022 13:15:03 -0500
Message-ID: <CA+CK2bDbbx=8R=UthkMesWOST8eJMtOGJdfMRTFSwVmo0Vn0EA@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: Do not defer reserve_crashkernel() for
 platforms with no DMA memory zones
To:     Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vijay,

The patch looks good to me, just one nit below.

> -phys_addr_t arm64_dma_phys_limit __ro_after_init;
> +#if IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32)
> +phys_addr_t __ro_after_init arm64_dma_phys_limit;
> +#else
> +phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;

Since in this case arm64_dma_phys_limit is initialized during
declaration, it would make sense to use const instead of
__ro_after_init. Consider changing the above to this:
const phys_addr_t arm64_dma_phys_limit = PHYS_MASK + 1;

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Thank you,
Pasha
