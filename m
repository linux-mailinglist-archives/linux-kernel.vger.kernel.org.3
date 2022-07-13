Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C46573DBB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 22:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbiGMUXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 16:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbiGMUXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 16:23:04 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8012C30F56
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 13:23:03 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id j22so21860505ejs.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 13:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d1P5rX72RXyRvGR7JCZ4qVZh1CiP/TKW9UtB14PFhaQ=;
        b=hp43ldtRziA5PUHZyd4RJvKAVLE41k/JKMzhpS//B1rETg03AmLcMxtVsSmgdzCMlb
         t44JOsl9PL+s6wYOQEJPZD0NHxYo63Bm3DBi/uPpvJFGrf3vZkmlu45wXZNa4Qj4zXqW
         mz1WdEdTJ8v9A+xQt4LlwhRS6fDVV8/nYc5Hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d1P5rX72RXyRvGR7JCZ4qVZh1CiP/TKW9UtB14PFhaQ=;
        b=37we87Zg80bBZdJ3hL4t1uhn1CFXYxy6eblho4UvT4bRbQINVNkcvHTglzZRqm9be9
         GKKWJSS1kQaZz0pmMeJKuWkpGmZPAsXlYFX/g/Cufxv1XtFbrTgwHrNu16fFzUOwtV7R
         55jwzW5oIT2WOwfc8erU6/GnHBpkHM6+sCMrQA+yBVUeK0wy/GpNRnVo0PGcKhHFM/bl
         T3EN2cdRwMyH3nbQY76NbcMg8KuWzq+Rt1i6zicBUQa8R5ecC46HmJMXhnGsI/n8Ui84
         vUnF42YtYMDCSxQmXn9PBLMvNaGMR6C6ZSOj4pUmoCiqtkau8CSHvOJCew474jyc2zm8
         7Gdg==
X-Gm-Message-State: AJIora/lHTodZscZa6TWJAn3NEDryCslnykN3dP4rft2jHstUE4tk+bW
        M5HyNQUf3SnOIEfIhjMpgKV6mrwdFSi/44dfs1w=
X-Google-Smtp-Source: AGRyM1sF1KZFH4veBYr4QY+Y+w/iPaMRwmqf8QbTcYDZ1ccVg3a5zexrPHg/WpAtZsSpNw3etzIVKw==
X-Received: by 2002:a17:907:97d3:b0:726:a5db:3a3a with SMTP id js19-20020a17090797d300b00726a5db3a3amr5286527ejc.654.1657743781842;
        Wed, 13 Jul 2022 13:23:01 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id f17-20020a17090631d100b0072b6d93b9afsm2917494ejf.210.2022.07.13.13.22.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 13:23:00 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id o19-20020a05600c511300b003a2de48b4bbso1856936wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 13:22:59 -0700 (PDT)
X-Received: by 2002:a7b:cd97:0:b0:3a2:dfcf:dd2d with SMTP id
 y23-20020a7bcd97000000b003a2dfcfdd2dmr11342692wmj.68.1657743779568; Wed, 13
 Jul 2022 13:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net> <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <CADnq5_Ma2oe-6+WG4ZRAm97G7TyS0Nuhdxt=7oqdNLcMP5nKeg@mail.gmail.com>
In-Reply-To: <CADnq5_Ma2oe-6+WG4ZRAm97G7TyS0Nuhdxt=7oqdNLcMP5nKeg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Jul 2022 13:22:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgW-g5jAMmKjnG0_mhqtEKzbKxs=Lo8DDv1D2wZvhL-8Q@mail.gmail.com>
Message-ID: <CAHk-=wgW-g5jAMmKjnG0_mhqtEKzbKxs=Lo8DDv1D2wZvhL-8Q@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
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

On Wed, Jul 13, 2022 at 12:53 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Does this patch fix it?
> https://patchwork.freedesktop.org/patch/493799/

Guenter? Willing to check this one too for your setup, and we can
hopefully close down both issues?

                 Linus
