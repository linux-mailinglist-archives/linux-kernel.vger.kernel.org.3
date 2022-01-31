Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B3F4A50AA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 21:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355106AbiAaU51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 15:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbiAaU5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 15:57:23 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D746C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:57:23 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id v74so13949924pfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gstzU0bj6KddOf5BDKU1yj4Y0aVVZgiewlIw85mf+SI=;
        b=k1jkQqQNapjNCrjM/Ab59GAX5IPG/8cjsJGEZj1uexggp7BLW70ptilYfTQMD9j3Qo
         ePBWYpGn3YQb+0nTBBH9HdSFoOoQ+Y7EI3STKKSmPEhr+DVLXckG5v39g58FRMlRzao5
         pPeDvRQQn+kPb88qnpqsR8VWLPJDJu/UUdXEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gstzU0bj6KddOf5BDKU1yj4Y0aVVZgiewlIw85mf+SI=;
        b=JPZf79qRxgfKIwvjNbPu9TPejMtfMGSL/+ZJB42J54c/g+BaocEjbugb2WzAaa4Vek
         DMc4FPhUApGKCObjAdixsMbxy6lGdZvXofUzgZb5e7LKEjoz3VC8vgSeG0NVGPM4XjjT
         pAG1TrBBndZJd47rVT2hxal+qJtIn+x6LxAlZPLz3rrubEoUUrfooPO1YBfSJrFwV6dH
         kcqa90s+tHR/bG2PH2IRVee26Wvg637MFHCaf7ypWusvJA5CavCQr2Beg3ZKizvuUTuu
         ABEZHYvpxE/L9NG/EEMECFhgKSHrkmhtUmg45gTOrZYQ3eYOC9M2iWVB46l0pEx76lw9
         rq9g==
X-Gm-Message-State: AOAM532Nm4mwKvFT7MN47rkP/e7TXfW9ich57QUyN8/NrPCKQR/RvP29
        48zn3wKae32Hkv6KCM6XZfVUcw==
X-Google-Smtp-Source: ABdhPJwTMWbSKOMmdktu9Rz31dt3kwG6ZIs0z4aHy0ehwoBEANLWhjrdNa0A81yQZtKG5ToXfvGlLQ==
X-Received: by 2002:aa7:9a45:: with SMTP id x5mr22217916pfj.57.1643662643196;
        Mon, 31 Jan 2022 12:57:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bj7sm216273pjb.9.2022.01.31.12.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 12:57:22 -0800 (PST)
Date:   Mon, 31 Jan 2022 12:57:22 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Jann Horn <jannh@google.com>, Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Denys Vlasenko <vda.linux@googlemail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <liam.howlett@oracle.com>
Subject: Re: [PATCH 0/5] Fix fill_files_note
Message-ID: <202201311257.79B1041@keescook>
References: <20220131153740.2396974-1-willy@infradead.org>
 <871r0nriy4.fsf@email.froward.int.ebiederm.org>
 <YfgKw5z2uswzMVRQ@casper.infradead.org>
 <877dafq3bw.fsf@email.froward.int.ebiederm.org>
 <YfgPwPvopO1aqcVC@casper.infradead.org>
 <CAG48ez3MCs8d8hjBfRSQxwUTW3o64iaSwxF=UEVtk+SEme0chQ@mail.gmail.com>
 <87bkzroica.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkzroica.fsf_-_@email.froward.int.ebiederm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 12:44:53PM -0600, Eric W. Biederman wrote:
> 
> Matthew Wilcox has reported that a missing mmap_lock in file_files_note,
> which could cause trouble.
> 
> Refactor the code and clean it up so that the vma snapshot makes
> it to fill_files_note, and then use the vma snapshot in fill_files_note.
> 
> Folks please review this as this looks correct to me but I haven't done
> anything beyond compile testing this yet.
> 
> Eric W. Biederman (5):
>       coredump: Move definition of struct coredump_params into coredump.h
>       coredump: Snapshot the vmas in do_coredump
>       coredump: Remove the WARN_ON in dump_vma_snapshot
>       coredump/elf: Pass coredump_params into fill_note_info
>       coredump: Use the vma snapshot in fill_files_note
> 
>  fs/binfmt_elf.c          | 61 ++++++++++++++++++++++--------------------------
>  fs/binfmt_elf_fdpic.c    | 18 +++++---------
>  fs/coredump.c            | 55 +++++++++++++++++++++++++++++--------------
>  include/linux/binfmts.h  | 13 +----------
>  include/linux/coredump.h | 20 ++++++++++++----
>  5 files changed, 88 insertions(+), 79 deletions(-)
> 
> 
> Eric

This looks like a good clean-up to me. For the series:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
