Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5F546C7C5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 23:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242271AbhLGW4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 17:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbhLGW4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:56:49 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B44C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 14:53:18 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id n8so274841plf.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 14:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FwDgJnKJalwt8LVW8wK99qzWzGdP063/zKEOOgpHy2A=;
        b=hV61umr33rMnbgSKPPAnOLIJhq5MdWqYSrZKKoi1d17nv4RwxuCwFACovwlCy2fUHh
         8Og2GwmGMM/LCqDoamJ5/Nw8NjXnllzWCM34Uz/hb+smr9hXxHUhv2V49FYbIVNVwbH4
         zjRnQlyqfT4yLn3+XUgM2QNj4p3WWKpa3Vm08zRuP//rR0PQgXlVBYPbqYGt8VFJpYf1
         lZ5U8s5G3DDHZujVoe2Tjl737TpG/bRNPDzJzL7cBCFBK4VIWxBlvaMnEIzXx089QuQA
         39v+/IoyQ2odQ883DhehFURFHM/s0fIVwydsbiHBM04Xnko2+K+nfddnyHGEaNTeqv1c
         Fw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FwDgJnKJalwt8LVW8wK99qzWzGdP063/zKEOOgpHy2A=;
        b=TsV0/98CdFavODvRoXUTLnDiVIUzN8TYEoJ8dW/QHOBZbk+AAOWK1tPAZ8SI1Fvs3r
         7Cke1FtKmaayJPfUJWyLCoQ1XH1hCPt/v1ob23pl6xpaVWK+C23h3t2r3hKwPy6u469/
         7YOGZ0+K988pqdk9mZa98VpJ8uGFXxMTcdeTVlaXM8KBGIsXQLnbN/QwFfr5MrkEc0SG
         3bhRAUa6+KpOVj9pK89M99e1HvoQX3dZeKcGdiOvZVua8xByUmCRCwo5WNjdFnj9SzSR
         jpjbR/kAKstqAoPZsfXuJBKwycOlkqIuCh/X9Hc70ovM25b5kOjcXofAaeK+Im05BRmR
         fTVA==
X-Gm-Message-State: AOAM531zAzDeDEvYIE0Ea0rIlIXbV+Yl8cMcihNJx+JBB0u7hG/IgJUk
        8EQK4y+yXbGgBghfHJQ8bOiM6MT1XowwSmdROywgyg==
X-Google-Smtp-Source: ABdhPJw4GHO9GUATVuIUdeL+x4R9vXgelcanfQA1sHCfXcQJIdcgXLxQe6j0lJOd7ZVXvbiC5eDUWK44kGAawhin/BY=
X-Received: by 2002:a17:902:cb8a:b0:141:f601:d5f1 with SMTP id
 d10-20020a170902cb8a00b00141f601d5f1mr55452553ply.77.1638917597643; Tue, 07
 Dec 2021 14:53:17 -0800 (PST)
MIME-Version: 1.0
References: <20211111183356.4073001-1-dlatypov@google.com>
In-Reply-To: <20211111183356.4073001-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 7 Dec 2021 17:53:06 -0500
Message-ID: <CAFd5g45RxVE-BAoM00KY-5VFNvu=StYQg0p5+GFRD-JOHFezUw@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: revamp message for invalid kunitconfig
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 1:34 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> The current error message is precise, but not very clear if you don't
> already know what it's talking about, e.g.
>
> > $ make ARCH=um olddefconfig O=.kunit
> > ERROR:root:Provided Kconfig is not contained in validated .config. Following fields found in kunitconfig, but not in .config: CONFIG_DRM=y
>
> Try to reword the error message so that it's
> * your missing options usually have unsatisified dependencies
> * if you're on UML, that might be the cause (it is, in this example)
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
