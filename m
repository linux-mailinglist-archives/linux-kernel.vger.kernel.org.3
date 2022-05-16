Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A669528BE6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 19:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344217AbiEPRYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 13:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiEPRYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 13:24:32 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A253CFD;
        Mon, 16 May 2022 10:24:31 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id a10so16672930ioe.9;
        Mon, 16 May 2022 10:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2wAYu2uKH1Cw5UNyH5zvPvYLZDZ32pNC+FO1fFW9pfo=;
        b=e/4TVY/KWkFI6cX4qIc7ipAGN9a+zUQPqWSycSt3C9o03Y9lsvuHlGK1dz7ZIbLi5b
         RuU7aaezIyLfZ9U8LO921EJw/91oUgbVEEjRbhcXP48hI/YYNQgfc8k2n0JgpIpK/DUy
         SrRTWpSY99ZEkDX3vHrC4GlvVX5HQJVA3puOHWjYaBkNqyZ18ZQMnNmQ0iMGbghm/GTp
         UPo/ML+BecnTehtiCCjT+f/sea5WNs6PHhUmheRN6W7H7wOgQuME/OnY/ccdsB/WAS80
         HDcJpCmbqz2kKEHFLcm3wwkFYXbsvELxB3qDKqmzE+kgbh+IY6hyVTaDk++bVcdnSg+2
         C+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2wAYu2uKH1Cw5UNyH5zvPvYLZDZ32pNC+FO1fFW9pfo=;
        b=4BpZ1c1s28uFSRWg4zV0GxZP0cFLQwnPrC8WkLwACREXl8XNV9hvqDTbddVw+Cw9BR
         Kop+QusptQ51Qj623VtvST5NyYGXSqDo1yMGdXxzfR0gFiveRo+Fggx2md/zApt7c+v5
         iNpwnzinRIIgcP3hXUpui+FS0uE6DITDn6ZnemZYJNPK+45z16qt/eWEceizGnjnP0vV
         8Ltk7J3xAnfBOg00hDGRcgL0yVE+5GYu168H9EWDn63tZ9In2nR+jXZ+ZU/d+uckpZ/R
         7Tl7pyDVv2nyJz5yahtmwm6yGRsp2A1OD7K96r+qO4i/2bIM8G6dFDFWOkb0Lg5ZwCwf
         jBxA==
X-Gm-Message-State: AOAM531LpE/TAAsHcFjagmIyc2VUogY4yJt7+CG/IwgXKgB/0zs8ipk1
        I++RIWcimgeuGqEBVcoDewwVBpE6kI0zNBR0TE4=
X-Google-Smtp-Source: ABdhPJyFR/umtgJKRUSv51+WVw81Kc2tPqXdzoudkhCNHSDjq1Rr4MmO4tPXGYb8tykdZi4x7hhz/CuPeiMBWRXPqDU=
X-Received: by 2002:a05:6638:16cf:b0:32b:6ee7:8d7d with SMTP id
 g15-20020a05663816cf00b0032b6ee78d7dmr9660446jat.256.1652721870607; Mon, 16
 May 2022 10:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220516100401.7639-1-ojeda@kernel.org> <YoKCUfSw2SPJXS04@kroah.com>
In-Reply-To: <YoKCUfSw2SPJXS04@kroah.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 16 May 2022 19:24:19 +0200
Message-ID: <CANiq72mAPxK=-GnMFMHhRoYbA7y34-5Qiprwv6-ZhK6Xzd_GiQ@mail.gmail.com>
Subject: Re: [PATCH v1] binder: convert `BINDER_*` ioctl `#define`s into an `enum`
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Li Li <dualli@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>
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

On Mon, May 16, 2022 at 6:56 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Yes, this does not apply to my char-misc.git tree in the char-misc-next
> branch on git.kernel.org as I think we have added some new binder ioctls
> recently.

Yeah, exactly, I thought you might want the other base to avoid the
conflicts -- sending it in a bit!

Cheers,
Miguel
