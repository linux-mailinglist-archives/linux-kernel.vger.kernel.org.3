Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603464E83FE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 21:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbiCZUE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 16:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbiCZUE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 16:04:56 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1198818B7AE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 13:03:20 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id d5so18627979lfj.9
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 13:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RdtkPgU1voLQTS9FCim5FFJxxR81mf9841pxK7k3myQ=;
        b=HKBnL7ySerUq68vRo6aQmLshwvFK/rcXIzSMmhlBaamj7BLtH40huPt2ygtyf+Zj+k
         mxfE9j4GpdJ7DBWLyGYLOEN0Yi8Fz6e5YaKsaIVKZK/WwB80kUT2vmwX9GNOHswu5+0u
         5rGv+yW+pbAV+aEzUUH71wFh5tUI3w7e3856s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RdtkPgU1voLQTS9FCim5FFJxxR81mf9841pxK7k3myQ=;
        b=AMzakrDuF6IW0sI6fuZx0tPsmvtiNLVnwiXlXNHUsBhfbuzToYVjXcTB/Db9XKP7oO
         l9g2eBlwnVEWZDT+oU3YwicPHtmdKkN8RcS634QUH6Fm7VYnhM0HeAgB5z/oDtzeUsn1
         AFK74+cDiEXVKw7M3UXHHU5Ec7voR4693DqwLhw06EnxmyIhkATifMKjOlltboKn5WAx
         H7VG2eV83cTiz1wBPJueJs9Gmr7XB32ELBd2aXv+JLWvsMxiu/571TAJgvS5QJt6ZkOT
         I1wGuMHTAHER04bEzaY4nzz2maFJsxiksBXwewENV1NE3MUEJvm0pAECC6emd5boCpRk
         KTEg==
X-Gm-Message-State: AOAM5311Euzi0F9NOMz76Kn9fYsBcbm46pmfIGFEDPP4eHlaFvN7DwBi
        eer3PO5f6QticW1qvdU8NW/h8azWXSzOjm4Vdj0=
X-Google-Smtp-Source: ABdhPJylrkldWAX1I+/69ovDX4yBjqoanEXzR0XoG88mMUL9il6DNuiuuXumOaLIiX7TxSRm9kmUZw==
X-Received: by 2002:a19:5e07:0:b0:44a:48f8:b495 with SMTP id s7-20020a195e07000000b0044a48f8b495mr13377351lfb.512.1648324998139;
        Sat, 26 Mar 2022 13:03:18 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id p17-20020a056512313100b0044a34f4b4b5sm1152492lfd.268.2022.03.26.13.03.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Mar 2022 13:03:17 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id bq24so2689946lfb.5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 13:03:17 -0700 (PDT)
X-Received: by 2002:ac2:4f92:0:b0:448:7eab:c004 with SMTP id
 z18-20020ac24f92000000b004487eabc004mr13322047lfs.27.1648324996731; Sat, 26
 Mar 2022 13:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <87wnghd78t.fsf@meer.lwn.net>
In-Reply-To: <87wnghd78t.fsf@meer.lwn.net>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Sat, 26 Mar 2022 13:03:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=whhSE3eaA55qfuT+3hVik2hbixEd=1OY=e66p4hia5Hrw@mail.gmail.com>
Message-ID: <CAHk-=whhSE3eaA55qfuT+3hVik2hbixEd=1OY=e66p4hia5Hrw@mail.gmail.com>
Subject: Re: [PATCH] docs: Add a document on how to fix a messy diffstat
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 2:58 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> [If this passes muster I'll likely toss a version onto LWN as well]

Thanks for doing this, but I think the target audience, not me, should
answer that question.

That said, I think that second link in the commit description is
corrupt somehow, I get "Not found".

Oddly, it seems to be correct in the doc itself. I did not sit down
and compare the random noise in the links side-by-side, though.

            Linus
