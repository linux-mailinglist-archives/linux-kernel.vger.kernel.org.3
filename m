Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D135986CF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344080AbiHRPFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344082AbiHRPFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:05:34 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A0167159
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 08:05:31 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id 2so1771621pll.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 08:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=EFkAYh0z8p6dDchXCdKyOPkHI5qUVRlY/OH0x2X9QdU=;
        b=lec1BDhYxL+pL38T2Y4JdIZswIOD+NJoiCwMh0jT2NXvKlAkc5z/C8EBJYeylt+bUk
         /mMxEPRzZzS4IQa9JHyb/zALhhF4S/8B99PtQ+hrkYCn8DVD/1NKnyV7GXAUvwM/w1Rb
         Lv+UdBX7PhKlNKUYO8rQpBfUEaUJ+JSObhjOxiXKlTQLLWaPUqLgsiBvPHlIm1AqC82i
         8gXdUCEQQTWuxbobNi3XNYzlkk12nFAVu58q8HhBNa5slr2CE+SF/VmU7y1Sl1/ToQL5
         AjJxyQV2saNsRcKSit5rDkstL47OuwRytJ3CpXtGM0/OFG9oY/Ir1d83fxvFViNLIVNY
         DvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=EFkAYh0z8p6dDchXCdKyOPkHI5qUVRlY/OH0x2X9QdU=;
        b=szNgkjTnAeUOcu2NZNpUubOAhjLI4iyHcEJXS19uMYPcbxkA++iReEDyLKheSuvuCb
         +IChnrHaHzdsrVP5waVgLx9Y3QwiLkFsIcWtd61QH0hS5QSGUuuJ6q9lbLP059sZaiYJ
         QaXncR4Zmko1zLzutlmWrEmKRafzuEyDT6XQ44ui07MXZJ9EBJUTZZm8p6mCwc8bcgz/
         +pPguT9m42//NaSpneDn/2IW6wKy7uToQxJv51lBrsX7rrz+B5oY52IBLOA2wMWNYW6o
         LKuclHRx9DWXdkdfbTjz52VhxYvnFJmnIU9cJwCrBZsiV9Z4j7ZErfh+AO0jCQOW9lpC
         yKHQ==
X-Gm-Message-State: ACgBeo24mnPWUTyWJvFXrunW2FadtJeGRN5HkMXhXKKyE8vrOIcVe2fm
        bYyF15e1U2BhzjCKCw2EgErGp5JQi6ckELz+gjg=
X-Google-Smtp-Source: AA6agR4ZTw9MlJSQnno2jpOdyO4JbHpLah8MTH+Yxl+U5wXTyF4gPB4pr+d2yhn26LBII+UCjwdg2vUuIOxaEEUFV6o=
X-Received: by 2002:a17:903:189:b0:16f:24e4:1614 with SMTP id
 z9-20020a170903018900b0016f24e41614mr3018679plg.103.1660835131185; Thu, 18
 Aug 2022 08:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220628145552.349839-1-xiehuan09@gmail.com> <CAEr6+EDVhMwF1cok1StkYPSd_AMdMsn9Kw9U+Bt5p9i7CYZG4A@mail.gmail.com>
 <20220705134946.01cff121@rorschach.local.home>
In-Reply-To: <20220705134946.01cff121@rorschach.local.home>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Thu, 18 Aug 2022 23:05:19 +0800
Message-ID: <CAEr6+ECutZuYZNYzv-oD7Ss5nfg8eFAdwDG75E5NhM3UtkmH1A@mail.gmail.com>
Subject: Re: [PATCH v14 0/4] trace: Introduce objtrace trigger to trace the
 kernel object
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
        Song Chen <chensong_2000@189.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi steve,

I would like to ask whether this patch set may be merged into v6.1  ;-)
The kernel development is indeed very different from what I originally imagined.
I originally thought that objtrace would soon enter the kernel
community, but I know
it may take one to two years, or longer or discarded, I have slowly
come to accept this reality ;-)


On Wed, Jul 6, 2022 at 1:49 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 5 Jul 2022 23:30:46 +0800
> Jeff Xie <xiehuan09@gmail.com> wrote:
>
> > Hi Steve,
> >
> > I'm curious if you have any comments on this patchset ;-)
>
> Hi Jeff,
>
> I haven't forgotten you. You're still in the queue (which is finally
> moving forward). I have a few other patch sets ahead of yours that I
> need to go over. Yes, those patches have been waiting longer :-p
>
> -- Steve

-- 
Thanks,
JeffXie
