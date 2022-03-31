Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FB04EDB8A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237421AbiCaOSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiCaOS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:18:29 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FEB21C701
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 07:16:41 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r23so28367919edb.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 07:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RZY1I0gGM56CYEYUCvZVOQWZgbjY8lJqjXjcYcc3yMY=;
        b=x6SkBhGDI4SvIL7CQYSlCsTx/jcSajyH4EEyBsBZZG3MI0hJvseEbM9bqCtOybSSoL
         uAdPVGa4cCr5omd9tLrluDMfsoRMzzkV58rU6BhbynEj312PybhPIQejKd9sEUnV0HEZ
         fsMyjPU7gQxfZsZLuruQoL6+Ey70vMX7HMQ3ktRlf8FhYrCQU5bc7iNW7e8GIoEHQ1dn
         pp9Zi5cE4EOc/muKNCzs01NNi/Elmp9yhP8EMOb8va9cHrIx8zZeZRe0Ac7P/4/l/gfA
         Zn1o1hl5YLj5mryKk1ArUUAzNHGfcwDK/msoWWmVoVSu0PcZlHhclrDbQLIM2DPqJ2BA
         fwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RZY1I0gGM56CYEYUCvZVOQWZgbjY8lJqjXjcYcc3yMY=;
        b=r790hloaxaCoLqo2Y1DL5QgTI5VtFeqdHTz5R+hclmZXCLxKd2A2kITnh+hRbPcuc9
         PW/3Zh89UB1o/IeY+EanpEEBhIi37dMsZMiAwjU+xH2CPlnr0cffzc6DXvUKad9U6L1L
         viAQxDzU3WaET7sg4ZtDOWt9+0UOyJ9Y6shyioAwLuQcu2A4MsXQVecl/Zrw62HfAE/n
         Sfj5jTetjhOf766/K2QMkp2cEk4LZBUvjCx8GhEReJP/Ccs+Sd0PHZnMztYJPIJU/Cda
         cJPwHgiVdCfMhtCVqn2bn9X3PqL/viRJNPNi3pyrJvDJ4x4oXacrCuG9bMopzdtqeVKq
         pD2w==
X-Gm-Message-State: AOAM532oK3OZdwYAsVQBX/Aque4ywX0/r5y7yWyn1ppeU+0DNl/VMWZW
        qf/hED+9ON6ZxmXwijdC62KUoV8SsgszvUDnjhxb
X-Google-Smtp-Source: ABdhPJxmg54p3fTmCYWUQ/7llbDi3aEO/T7SzudiEThToVmywlfQJD7U2YwHo9gV1vHcu2kQovw9xwWpohUDawwonVY=
X-Received: by 2002:a05:6402:35c5:b0:419:2c72:66c3 with SMTP id
 z5-20020a05640235c500b004192c7266c3mr16874437edc.343.1648736195233; Thu, 31
 Mar 2022 07:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220326094654.2361956-1-yang.yang29@zte.com.cn>
 <202203270449.WBYQF9X3-lkp@intel.com> <62426553.1c69fb81.bb808.345c@mx.google.com>
 <CAHC9VhRNuoPH6AySUbe6h2D6kghhezyVQtTAvm-t-fTpXH6XwQ@mail.gmail.com>
 <62427b5c.1c69fb81.fc2a7.d1af@mx.google.com> <CAHC9VhTLTQmHaka9tTyuu=rQOzpsn_K2NxfJ==7-6FSY3KnuFg@mail.gmail.com>
 <6243f1d7.1c69fb81.b19c7.7ec1@mx.google.com> <CAHC9VhTxACMG=V_J1OYy_7VjM3LjuNJcwJSf6om1eO8esCDAbg@mail.gmail.com>
 <6245121e.1c69fb81.ea0ab.0c2e@mx.google.com>
In-Reply-To: <6245121e.1c69fb81.ea0ab.0c2e@mx.google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 31 Mar 2022 10:16:23 -0400
Message-ID: <CAHC9VhTaCNqfTOi8X5G3AheBFzTYCzGnt_-=fNFc5Z1o8gPm9Q@mail.gmail.com>
Subject: Re: [PATCH] audit: do a quick exit when syscall number is invalid
To:     CGEL <cgel.zte@gmail.com>
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        eparis@redhat.com, linux-audit@redhat.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, guo.xiaofeng@zte.com.cn,
        huang.junhua@zte.com.cn, dai.shixin@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 10:29 PM CGEL <cgel.zte@gmail.com> wrote:
> On Wed, Mar 30, 2022 at 10:48:12AM -0400, Paul Moore wrote:
> >
> > If audit is not generating SYSCALL records, even for invalid/ENOSYS
> > syscalls, I would consider that a bug which should be fixed.
>
> If we fix this bug, do you think audit invalid/ENOSYS syscalls better
> be forcible or be a rule that can be configure? I think configure is
> better.

It isn't clear to me exactly what you are asking, but I would expect
the existing audit syscall filtering mechanism to work regardless if
the syscall is valid or not.  Beware that there are some limitations
to the audit syscall filter, which are unfortunately baked into the
current design/implementation, which may affect this to some extent.

-- 
paul-moore.com
