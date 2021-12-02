Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6023466977
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 18:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376483AbhLBR6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 12:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376421AbhLBR6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:58:08 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D37C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 09:54:45 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id i63so1266539lji.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 09:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z/5CaB/JOnj2/PdHRvEBg8gddLmclzjwsO9uOQPQZ8w=;
        b=aepYSYgZOghDLfIMvYjbSFwP5Ikh1Fd3AfTMr697r/nMkcCt6o95aRullAhBTEy/M1
         vbg7dqznfFdf/L3qP/YpxJj4H1Am27WlEswYXePYXMYonpnIb3cvfBcr/3EeCTIjYcwC
         yqI8p8g5hf8vqRnEsFnWE6pyV32OwxQoX/iwN6zFF9OIXt/QnT5kZr151ueZwjuiEkxc
         nKchis7J53AqjYnbI51dLyamTdv6OZ4Mh0cd2ZYU4UCNw5atsZole3MTz4hxTm4CP6Hd
         obfm56QA78ttGrq3+Lq351Z+CjoyqC8IUfONSCZWv89iENpBtvVolJjFKFKxj7tMvjIy
         g9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z/5CaB/JOnj2/PdHRvEBg8gddLmclzjwsO9uOQPQZ8w=;
        b=eTnrgOcDq+4XAlZHv4AOdvqda9rpWhpREm1lr4IImst6zYuxNpZZLGUag6L7bsDpZ9
         bymJZkORtK8cmGDCsnXJ+Y3/2YiJXdcEjTpKy0L+iRGp4WjFWzhzvRZ3pskZi344nN89
         dc4VEXizfSxiRlvaakWKo/mmPA8KIk8QgaAxBXguzUhf6pZMCdUuRBLPwcyVeJ8D/bT5
         dp+vm25eTuxzKlxqfX6mS1hL34sG+YkAf7xgHBViFtHfmwD5ej9aKrgjJZkjtuSOTDue
         CvH5FIqmf02K7c9htrM41zTgbdPYr6f9V+EttfTNIAk2KJloj0zOOOw87AwlE4+P1sPs
         0xqg==
X-Gm-Message-State: AOAM5335IkucPGCVNV8KXgFcwcT4iXAnvHD3p1nLR0l8swm3nuiT9xr/
        WX+X9tYm0aB3xavE89DmYN0eJNOZ/QsMaEDYI3smWQ==
X-Google-Smtp-Source: ABdhPJwtm1Em6Qxewazf3czKyIw8Z9a4Mnz3R3PHy25qBUYQxrTVQxrDhLo9ANTlZBfxw0YVO/uuMZjSPZZ1M/kN+O4=
X-Received: by 2002:a05:651c:545:: with SMTP id q5mr12755493ljp.202.1638467683082;
 Thu, 02 Dec 2021 09:54:43 -0800 (PST)
MIME-Version: 1.0
References: <1638442253-1591-1-git-send-email-quic_charante@quicinc.com>
In-Reply-To: <1638442253-1591-1-git-send-email-quic_charante@quicinc.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 2 Dec 2021 09:54:31 -0800
Message-ID: <CALvZod6fSkdV6oSyxsv0+gcRfZ=H9Uaw=7=t902U85fWJStuzA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED for shmem
To:     Charan Teja Reddy <quic_charante@quicinc.com>
Cc:     hughd@google.com, akpm@linux-foundation.org, vbabka@suse.cz,
        rientjes@google.com, david@redhat.com, mhocko@suse.com,
        surenb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Charan Teja Reddy <charante@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 2, 2021 at 2:51 AM Charan Teja Reddy
<quic_charante@quicinc.com> wrote:
>
> From: Charan Teja Reddy <charante@codeaurora.org>
>
> Currently fadvise(2) is supported only for the files that doesn't
> associated with noop_backing_dev_info thus for the files, like shmem,
> fadvise results into NOP. But then there is file_operations->fadvise()
> that lets the file systems to implement their own fadvise
> implementation. Use this support to implement some of the POSIX_FADV_XXX
> functionality for shmem files.
>
> This patch aims to implement POSIX_FADV_WILLNEED and POSIX_FADV_DONTNEED
> advices to shmem files which can be helpful for the drivers who may want
> to manage the shmem pages of the files that are created through
> shmem_file_setup[_with_mnt]().  An example usecase may be like, driver
> can create the shmem file of the size equal to its requirements and
> map the pages for DMA and then pass the fd to user. The user who knows
> well about the usage of these pages can now decide when these pages are
> not required push them to swap through DONTNEED thus free up memory well
> in advance rather than relying on the reclaim and use WILLNEED when it
> decide that they are useful in the near future. IOW, it lets the clients
> to free up/read the memory when it wants to. Another usecase is that GEM
> objets which are currenlty allocated and managed through shmem files can
> use vfs_fadvise(DONT|WILLNEED) on shmem fd when the driver comes to
> know(like through some hints from user space) that GEM objects are not
> going to use/will need in the near future.

The proposed semantics of POSIX_FADV_DONTNEED is actually similar to
MADV_PAGEOUT and different from MADV_DONTNEED. This is a user facing
API and this difference will cause confusion.
