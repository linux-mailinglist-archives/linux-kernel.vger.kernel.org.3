Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021F7478A3E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 12:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235624AbhLQLk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 06:40:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47601 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233856AbhLQLk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 06:40:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639741255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X0AgJWYtCde0wRE4G15AOz/150w1GAh7NwKm3oYeCMg=;
        b=X/8C3YaiLZQUBJ7Xl8A9oEa7xCxc88woSjhAR8TLM17CQ6QAYildtHOH2hzYSfHSJLKy8F
        tnYIcj0V8miDosAnL7C1nEJf/jZoWU1EvsVR/K0PnuCwxkj2ijyhe6ct07h7TW1mErW3/K
        nulOH7A1S9nXkNpogT1bQy4QOlw9Z+U=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-HtHtT5zVOwa-EhoynN2tTA-1; Fri, 17 Dec 2021 06:40:54 -0500
X-MC-Unique: HtHtT5zVOwa-EhoynN2tTA-1
Received: by mail-ed1-f70.google.com with SMTP id b15-20020aa7c6cf000000b003e7cf0f73daso1654021eds.22
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 03:40:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X0AgJWYtCde0wRE4G15AOz/150w1GAh7NwKm3oYeCMg=;
        b=AnjrBjXJuAFFvYsNju6aB+F8s2ltWkBgmU/rU8RJuN2ZGJo5j/JP4S/r6o0Qv9+h6P
         qzFogm3gHZemG9srXZPDBGWiKgDLKmQhzN32g6qhGEMdsAx+//XwcORnBuSuSGSGfoex
         AjyLjobdDdJYWKGSy+yHG+L+/oB3eOhGdHR35qZBKHXjwMMM7UQn7uZDPvh8DeQc1QDn
         lGWcYKTcBs9UK1hqCtNZaFbCHSE5fGPMvgxJ2lKSqC2zPe3qrehaU2dm9Q8ug1oz5d6C
         hYD2heRyS+rwI2DhuOVldsfXkseiQItdTOWcKhlU7YBMABxCvibhWvaIFZ24sqmPZfUz
         4lsg==
X-Gm-Message-State: AOAM532+A/R/ev8oW8291VNR7Bf1C81HDe0JFwBFM+0BK3wFXmVQxgg5
        kx66ZIFGGlB0E4AeTHHY72eNgUq2birsjY7dGltOajitCIefKJ1HMqzb1esHqW8gMX6xfXE0K01
        8ZhtXaBvXrLhQ4pJYhQob5ImofmURyBOru+qFFydb
X-Received: by 2002:a05:6402:2072:: with SMTP id bd18mr2460856edb.280.1639741252702;
        Fri, 17 Dec 2021 03:40:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw45eK5HN9dZm9QJ6dhYB1cvicXLS3gMkFP24LvySJqi+UXSYhuRxoj/ScWxBQet1UoE0pILvIvnvdEhfqcN8s=
X-Received: by 2002:a05:6402:2072:: with SMTP id bd18mr2460843edb.280.1639741252580;
 Fri, 17 Dec 2021 03:40:52 -0800 (PST)
MIME-Version: 1.0
References: <20211217113507.76f852f2@canb.auug.org.au>
In-Reply-To: <20211217113507.76f852f2@canb.auug.org.au>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Fri, 17 Dec 2021 06:40:16 -0500
Message-ID: <CALF+zO=zDrRzPkpgjRQNYbxQ8j3qNVJjo9Ub=tCqFtT32sr-KQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the nfs-anna tree with the fscache tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@gmail.com>,
        NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 7:35 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the nfs-anna tree got conflicts in:
>
>   fs/nfs/fscache.c
>   fs/nfs/fscache.h
>   fs/nfs/fscache-index.c
>
> between commit:
>
>   882ff66585ec ("nfs: Convert to new fscache volume/cookie API")
>
> from the fscache tree and commits:
>
>   e89edabcb3d4 ("NFS: Remove remaining usages of NFSDBG_FSCACHE")
>   0d20bd7faac9 ("NFS: Cleanup usage of nfs_inode in fscache interface and handle i_size properly")
>   4a0574909596 ("NFS: Rename fscache read and write pages functions")
>   3b779545aa01 ("NFS: Convert NFS fscache enable/disable dfprintks to tracepoints")
>   b9077ca60a13 ("NFS: Replace dfprintks with tracepoints in fscache read and write page functions")
>   416de7e7eeb6 ("NFS: Remove remaining dfprintks related to fscache cookies")
>   fcb692b98976 ("NFS: Use nfs_i_fscache() consistently within NFS fscache code")
>
Anna, feel free to drop these from your tree to avoid the conflicts
with the rest of your tree and dhowells fscache-rewrite patchset.



> from the nfs-anna tree.
>
> I had no idea how to fix this all up, so I just dropped the nfs-anna
> tree for today.   Please get together and coordinate thses changes.
>
> --
> Cheers,
> Stephen Rothwell

