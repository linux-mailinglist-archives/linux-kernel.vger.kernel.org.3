Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3C95336C1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 08:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244127AbiEYG20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 02:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238669AbiEYG2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 02:28:24 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33C313D70
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 23:28:23 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id v26so6306972ybd.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 23:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lGPxsnKdnKsfY2/ly0XOA1mv5n8j0KZZRTBIc9ftnt0=;
        b=4MNdBYX+XgIEIqG6nn6cOEabHclXZtPvf3LN6UtsP24WXdn7mgPh7l9HU8hd2XBoDt
         x+yQh8ZWnHWHzrGiY+diy4pQ0hUV/Ozdoi2m2d38glFhgU3MLAcIUAx9L8iZjzZOuqz7
         RsL5P250YCFBuAxpC6JsWZ762SmqcoCOtmlKyAnF32d6sZg+uZfDlczb/kaiiG2rakKf
         cNUPYZzj3EIYKPX/TEenSHTrFVmz6IXAwvmwssFWDbjkoPsXY8YAl3mGJge5cgaOqME6
         EW9xxQPABuvCph73DOtlEe3iAjHua+1IvoT/EJWkaxPONptUUYDE+o+w8ZotdbK/k3m5
         3KmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lGPxsnKdnKsfY2/ly0XOA1mv5n8j0KZZRTBIc9ftnt0=;
        b=bMRQF9rDLuMQ+3tfXKspEBS5lm5zpRtsKdDd+YMEBC3hetsH7n3B2V5FBKsIzGSvR5
         d1WLreSL1lgm9SXYgT6pYgQkVK7I4xFJ3h1OCd/nH9o+lozFVXH+vVG5cvYgFtXCVsp2
         U5tHQJsbPDWjIyRNa2mOeUJvhS4fFGBdQkTF1XOhTjm+IrBgk/I4xaeBMoLukzKNk7cJ
         irYcOov4PQo75/ZUHbR/RvFiCAOdESPBwUKxCPvpFUgg+LM0SsKKpKRzg/g5ulC1fFik
         otGQ1hgjiPeLtgI8PLZDoRSHzwIbRraNn1bWa3QUIQv1ysA+FdNQ81AZzapStcNiVVop
         6O8Q==
X-Gm-Message-State: AOAM533U89S/XUUTK4ae8r9arCzEWGlgJ4piL0J/J+OPJz5kke2tstvM
        o2yESxyqIl9ha7ONSv90qA3G339zwbulFUQO8b8/uA==
X-Google-Smtp-Source: ABdhPJzXiwwgY0XYGH+cOKpgqmsNyUray2UOAxL4wDZv4UaWEpaVgm4xIvQ11DAUpooHwUp44RKPV+eUdGzssfZ4wMU=
X-Received: by 2002:a5b:dcd:0:b0:64e:2365:69a8 with SMTP id
 t13-20020a5b0dcd000000b0064e236569a8mr28474573ybr.254.1653460102896; Tue, 24
 May 2022 23:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220522052624.21493-1-songmuchun@bytedance.com>
 <YovECEBVeCZl79fi@bombadil.infradead.org> <CAMZfGtWfD62CRTPSesqKJALvcBLEOVWj7DyXrv05x+99seKTgA@mail.gmail.com>
 <Yo0FzkTJj2TrLtTO@bombadil.infradead.org>
In-Reply-To: <Yo0FzkTJj2TrLtTO@bombadil.infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 25 May 2022 14:27:46 +0800
Message-ID: <CAMZfGtX530m=gNSNe0BoWiFnAHrm5+85iMcTUthxFveL100qPg@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 12:20 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Tue, May 24, 2022 at 10:30:01AM +0800, Muchun Song wrote:
> > On Tue, May 24, 2022 at 1:27 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > On Sun, May 22, 2022 at 01:26:24PM +0800, Muchun Song wrote:
> > > > Setting ->proc_handler to proc_dobool at the same time setting ->maxlen
> > > > to sizeof(int) is counter-intuitive, it is easy to make mistakes.  For
> > > > robustness, fix it by reimplementing proc_dobool() properly.
> > > >
> > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > > > Cc: Kees Cook <keescook@chromium.org>
> > > > Cc: Iurii Zaikin <yzaikin@google.com>
> > > > ---
> > >
> > > Thanks for your patch Muchun!
> > >
> > > Does this fix an actualy issue? Because the comit log suggest so.
> >
> > Thanks for taking a look.
> >
> > I think it is an improvement not a real bug fix.
>
> Then please adjust the commit log accordingly.
>
> > When I first use
> > proc_dobool in my driver, I assign sizeof(variable) to table->maxlen.
> > Then I found it was wrong, it should be sizeof(int) which was
> > counter-intuitive. So it is very easy to make mistakes. Should I add
> > those into the commit log?
>
> Yes that is useful information when doing patch review as well.
>

Thanks. I'll update in v3.
