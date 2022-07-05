Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEBB5662EF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 08:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiGEGFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 02:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiGEGFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 02:05:43 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B8D26F2;
        Mon,  4 Jul 2022 23:05:42 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 64so10786129ybt.12;
        Mon, 04 Jul 2022 23:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nbyECK3263/RIOlKgtKBVow3c3mI3lDCcZ6/fs9YY58=;
        b=hUSvlWnsXGp49fhdQXPLiewzuIeH3gUpLWCml+qlfxHOvACIfZbvr6lsB201e8WSAi
         UwQK+Vci+BYYv853VVQkXU9pAUe0ry/wra4/twDbkFodaD0MJG5p1zycPrsb02IVaDG1
         PltFpOtfltb8XEvhn2NpnzTl1L+FL4ar9AGsv5jOxuZr49jIIoTrOFApr24g6KeUtlPV
         Kuj//wE/SJvvy2O8C5iYWp6exCPJtHyzjqWu64AC8zUKFgtF/v3Eenfbx7AKxOMd4PZS
         GGRE0QOXBl9n5PulF+SV69GscIEdlSK2m6BXA4INmNHptkmH3zKXQQdPpj8EISkbbOFk
         hBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nbyECK3263/RIOlKgtKBVow3c3mI3lDCcZ6/fs9YY58=;
        b=1W+sxwSrUAq/z5qnddTdspSOp9rf5ovE6HbZBNrOC5j4s/7rnrELs05yULJ96l9IPg
         Ng4XWqc/y8SVVc7M09qeOa6Sptro/ryPo6En5jJAArJJEdzju7kgJIhl8zNuJe9lo2r0
         JzBRFliisps48666eVlQrTZz3y7nQretzC9AviGcyT74uf0cCSG+O76ein85X76ijPuE
         Ig6nuHEq7y0Ha6BapBE9yFyQqNpprJCkxl9QXB6lR7cGsjiSDxhS/Ess9mntQTFP1Zg/
         foi4oZ74swy+CWmtKVJKm9MchJ9/Fsg/uTs8DXoI4VpZpW7mL74LxkMRubzLvJ5GnP8l
         CbTQ==
X-Gm-Message-State: AJIora+YgNbdYWQ4j2kfUIVY8ItQ0lZBF7lNVWcOACuRCiOYQa9MHpEj
        jYenIzgzNXzrLanFFf2XwxruLugvFX/QD0c0Bv0=
X-Google-Smtp-Source: AGRyM1sDgPankvWElsMSV8lRoPFYUbJgM7WBumAixEKK/3jPU65pIsxYEOanVPial5z8nYD2qd/+j1eVDIfJ/ncUvow=
X-Received: by 2002:a25:8d8d:0:b0:66d:e087:4f2c with SMTP id
 o13-20020a258d8d000000b0066de0874f2cmr22896512ybl.389.1657001141710; Mon, 04
 Jul 2022 23:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220704092605.19604-1-lukas.bulwahn@gmail.com> <YsMVuVBoCVWUawsq@linux.ibm.com>
In-Reply-To: <YsMVuVBoCVWUawsq@linux.ibm.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 5 Jul 2022 08:05:31 +0200
Message-ID: <CAKXUXMwzKQxw7sbUaZ924PFwMjxZo5HrN4HetiL8ww6r5_OObQ@mail.gmail.com>
Subject: Re: [PATCH] secretmem: drop unneeded initialization in secretmem_file_create()
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 4, 2022 at 6:30 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> Hi Lukas,
>
> On Mon, Jul 04, 2022 at 11:26:05AM +0200, Lukas Bulwahn wrote:
> > Drop the unneeded initialization of the local variable file in function
> > secretmem_file_create().
> >
> > No functional change and no change in the resulting object code.
> >
> > This unneeded initialization was already introduced with the introduction
> > of secretmem in commit 1507f51255c9 ("mm: introduce memfd_secret system
> > call to create "secret" memory areas"). This minor code-stylistic issue
> > was discovered as a dead store with clang-analyzer.
>
> You are right and in the current code the initialization is unneeded, but
> there's a pending patch that relies of this initialization:
>
> https://lore.kernel.org/all/Yr1jKwz2+SGxjcuW@kernel.org/
>
> Let's wait and see how that fix develops.
>

Agree. I will continue tracking the evolution of this function and
resend my patch if this patch above does not land in the next six
months. For now, this clean-up patch here can be ignored.

Lukas
