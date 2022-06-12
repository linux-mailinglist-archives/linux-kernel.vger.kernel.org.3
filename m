Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D442547B71
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 20:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbiFLST3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 14:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiFLST1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 14:19:27 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88804550D
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 11:19:24 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u12so7135265eja.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 11:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aaWuX53My40+jJmZwcdQ+JP3bpinumZLKvCRFjTFyzo=;
        b=IOy8TEnjiQFMkQi+bgqWPXX0QSSEFNHwibJ6tgSccEECgCo9CPmf4rw1Mqimn1F2ju
         hhvzEhclpB4rmR+iSCH+yHmc0cnLKDrZm8tuu073KH66Ax1Eu8VnjryI4nC8dLIo/5zJ
         yZe7gZU3ZdUHnkFawpebDzZZwbvbd1E8W1890=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aaWuX53My40+jJmZwcdQ+JP3bpinumZLKvCRFjTFyzo=;
        b=RcUXPF7bOpS1E6QXRid882yQWpJ/qn8all+4tFIofyNgD+PuFn0dNDK+ng0LiLi9NM
         E+lwPtBl19Kg1uy5C/WqwCiRNbi0q+MrWHr3IcHjdJe+jZMR4Y7JnUZ3dNDju2nzHG5O
         gNg8IDBRkp50+6c66OXlmNXv1vw5M6HtXsssOEGeBhzuaMkBGjQLJqAI84J2URwPadU8
         K1+Bppoj1S3K69H0y3bQ8PkWahqPB+G4W+tlYZBER3AnaBwSgm1TqDiaouqvtRJRima0
         nct8JJprxk1Dof8EaIqrWSfHNSZE9mMZHYkb98xlrAqAOIn8q/7a5SgQpsl5d86Gy7A3
         vs3A==
X-Gm-Message-State: AOAM533IDMOXfTHrWGqO6GWkU9z9EJupxV+YZ18OyYKj2N6CBwfV6Xkr
        tr4Jrmkgzx+iF0yGj7UnrWa9gnfJhJ7utUz+
X-Google-Smtp-Source: ABdhPJyaGUbNPN9OU/zhD0QW+5JvTz/1CJ3QjjxBG/xc+oy6lcTt9rST+dWmSTGUWpn1/Qf7XS9N9A==
X-Received: by 2002:a17:906:b15:b0:715:bf2e:df92 with SMTP id u21-20020a1709060b1500b00715bf2edf92mr3124879ejg.576.1655057963232;
        Sun, 12 Jun 2022 11:19:23 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id ss19-20020a170907039300b006febde6d771sm2717761ejb.160.2022.06.12.11.19.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jun 2022 11:19:22 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so1974537wms.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 11:19:22 -0700 (PDT)
X-Received: by 2002:a05:600c:4982:b0:39c:3c0d:437c with SMTP id
 h2-20020a05600c498200b0039c3c0d437cmr10509032wmp.38.1655057962092; Sun, 12
 Jun 2022 11:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <YqUzUBjG4N9pKlsv@slm.duckdns.org>
In-Reply-To: <YqUzUBjG4N9pKlsv@slm.duckdns.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 Jun 2022 11:19:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZyO1CY77vfpJ1oCoKEC=oRvWgqqTfdv4jXiiM7wbjeQ@mail.gmail.com>
Message-ID: <CAHk-=wiZyO1CY77vfpJ1oCoKEC=oRvWgqqTfdv4jXiiM7wbjeQ@mail.gmail.com>
Subject: Re: [GIT PULL] wq fixes for v5.19-rc1
To:     Tejun Heo <tj@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2022 at 5:29 PM Tejun Heo <tj@kernel.org> wrote:
>
> First signed pull. Please let me know if anything doesn't look right.

Signed tag looks fine.

> Tetsuo's patch to trigger build warnings if system-wide wq's are flushed

Have all the regular causes been fixed now? Because if everybody gets
a warning, it's not useful.

              Linus
