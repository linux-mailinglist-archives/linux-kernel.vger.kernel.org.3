Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409505320FF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbiEXCam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiEXCai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:30:38 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFEE69734
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 19:30:37 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2fee010f509so167641807b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 19:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CycpGwBiJBgwi+f73aOw3lbD15pFJaKBVQ5aiRu4tBA=;
        b=UbkAxVp5yJKwJ35iqqfZqbtkOuKY1nUlkOgUvQD8gv7Ls47I3zWM0m4494cI7jFBwv
         pcekFt6ugKgTlrLNTuPtSZuvDYan1rYXvRPRpRU/maLiz8YoxwTC+BieUIHjY2EhI/GS
         S/g3WWDdosXsfuHPQQRly2pZ/WO0myQZxub1lE2iw40Rb0jUKs+fwPswRhk+VXuakcXe
         CpgcWMLWliLwQXzXnankOMpSLlOvAzN55gmBkAcYEYNh+1NveXhPo5o+MpOWm8Hw2AFy
         7iMj5O2ZR9ldoVHAGw6qZeuMhT/gMqvQAp+xgh2xSv8pI8IkKPunQnC6N1QVwVMGjgTy
         n+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CycpGwBiJBgwi+f73aOw3lbD15pFJaKBVQ5aiRu4tBA=;
        b=ji+AwluoegGi63CZW5nkKIxSv5TZJWfIaIRNQ1PoXyNf5tNvslp1esLMzl+DxjbDjY
         URj5dee0kRjn2TJOTtP6VGJ8mioWfo0ZPOs4qThGdItN43waQkAMjSIiJkQSn2RLxTck
         tx0NTE2EnYHiK7+oBaPxUTSIpN7bfxy3XHf6D5sJn5LzjthRHyxnXqXIIXF6EtH4dZr9
         C+WwrFWPFui59iUxOdeBmBIidKdDjPEJi2kHKhxp1EKgi8PZ/Uc6U/dgf1/U3ZRZ5nl6
         sZsxFV2xnquHwuvFfxPfkxPFCBZxXrPRigoHdCQxUoWbLMo5It4BeLXXD77LAgTXLpUb
         glgg==
X-Gm-Message-State: AOAM531DyMsE9KdGb5R93r2X1cNp0//+W3ju/puY3yzZNyV5j8QfyuSI
        AmnHPtld/tJFK7kYyBMP8sH6xU+EQN7U8Gv7UhHL/g==
X-Google-Smtp-Source: ABdhPJyHIll+0+i+XcuEqGsuD6J7hoPoe2z5uPVqircx+9g+baHLz+0K93AOYBD9aOc8xFpEGsw4TxihcI/H8AzH/gI=
X-Received: by 2002:a81:1f84:0:b0:2f8:6138:de59 with SMTP id
 f126-20020a811f84000000b002f86138de59mr25946046ywf.31.1653359437183; Mon, 23
 May 2022 19:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220522052624.21493-1-songmuchun@bytedance.com> <YovECEBVeCZl79fi@bombadil.infradead.org>
In-Reply-To: <YovECEBVeCZl79fi@bombadil.infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 24 May 2022 10:30:01 +0800
Message-ID: <CAMZfGtWfD62CRTPSesqKJALvcBLEOVWj7DyXrv05x+99seKTgA@mail.gmail.com>
Subject: Re: [PATCH v2] sysctl: handle table->maxlen properly for proc_dobool
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 1:27 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Sun, May 22, 2022 at 01:26:24PM +0800, Muchun Song wrote:
> > Setting ->proc_handler to proc_dobool at the same time setting ->maxlen
> > to sizeof(int) is counter-intuitive, it is easy to make mistakes.  For
> > robustness, fix it by reimplementing proc_dobool() properly.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Iurii Zaikin <yzaikin@google.com>
> > ---
>
> Thanks for your patch Muchun!
>
> Does this fix an actualy issue? Because the comit log suggest so.

Thanks for taking a look.

I think it is an improvement not a real bug fix. When I first use
proc_dobool in my driver, I assign sizeof(variable) to table->maxlen.
Then I found it was wrong, it should be sizeof(int) which was
counter-intuitive. So it is very easy to make mistakes. Should I add
those into the commit log?

Thanks.

> If so is there a bug which is known or a reproducer which can be
> implemented to showcase that bug?
>
> The reason I ask is that we have automatic scrapers for bug fixes,
> and I tend to prefer to avoid giving those automatic scrapers
> the idea that a patch is a fix for a kernel bug when it it is not.
> If what you are change is an optimization then your commit log should
> clarify that.
>
> If you are fixing something then you must be clear about about the
> details I mentioned. And then, if it does fix an issue, how long
> has the issue been know, what are the consequences of it? And up
> to what kernel is this issue present for?
>
>   Luis
