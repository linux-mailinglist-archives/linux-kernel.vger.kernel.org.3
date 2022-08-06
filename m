Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4EC58B69C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 17:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbiHFPww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 11:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiHFPwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 11:52:50 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CC8E0C0
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 08:52:49 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id gb36so9647818ejc.10
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 08:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=QI4nVmo88D9y2AQfbOi9LlzYyMkoECnXcEDf4ZSrBUI=;
        b=DOSNkhHQ1PXO+nS1LzxQgiw2Mu9z0kXswux4xGpzUM7EZooJF7LAmvDbQHUQxSnTAC
         QF8dwZpzhE3o3vAiix/dzfxCpumaTWfNfVet7ltlyI3XW4wN4v1OS90sEyx4u/rKgP+J
         nVEHhPzQePMI8J/NCxB7aHwAfwS4THIHYBRjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=QI4nVmo88D9y2AQfbOi9LlzYyMkoECnXcEDf4ZSrBUI=;
        b=tUR2wM8YGV8pSFS+QhhHH4yPtyKP/iwunyQZ6ArjlWBbsuPmzqlcXxIStTunBPI6iI
         psjDmPZJaaXge/dtno0SEdKJtgLXhMovGiQqArtbSiVJWiA/h+ZaJdCk4vsu5K1Ny+4k
         STk5HmRAC6r5mfOzeMdK4qS/XZcGL9HtZaB8CllPTECl9IW1J+/+t+5luIn6DRRZJxRA
         Wcro4j4HHUCuBlOVNZNlTQmvuR4ur7Gu/QVX9s7zOFEpFix/PvFWERLw6od8wK23UlEN
         PIXPqhqgLO6GEm/7Mi4rswZejaUq+Rvl3lzv/ipHjBzUgzpE1spB6gv5C0pilOktD5tl
         wbhg==
X-Gm-Message-State: ACgBeo0QINo4nu6ECVk03Vro2ReKYUweLLPcUAODJGtCRAn1TGLIHQAJ
        sRkpzd1QPg1OI7JkUMqibhWvigjLm3dyOjlU
X-Google-Smtp-Source: AA6agR5C3R+mgsaOvfG+DhcGHJHRWV5xn6O1X6cJsAAJvjqDnt/lv5nCROGX2Xo1PXi5LqwFPzLhqw==
X-Received: by 2002:a17:907:75d6:b0:730:7000:6061 with SMTP id jl22-20020a17090775d600b0073070006061mr8720989ejc.234.1659801167273;
        Sat, 06 Aug 2022 08:52:47 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id m4-20020aa7d344000000b0043b7917b1a4sm1637041edr.43.2022.08.06.08.52.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Aug 2022 08:52:46 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id v5so2709638wmj.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 08:52:46 -0700 (PDT)
X-Received: by 2002:a1c:f603:0:b0:3a5:23ca:3e7c with SMTP id
 w3-20020a1cf603000000b003a523ca3e7cmr3576938wmc.38.1659801166018; Sat, 06 Aug
 2022 08:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220803104936.7df810fd@gandalf.local.home> <CAHk-=wh+e1qcCnEYJ3JRDVLNCYbJ=0u+Ts5bOYZnY3mX_k-hFA@mail.gmail.com>
 <20220805124701.4b44195d@gandalf.local.home> <12638499-5079-95b0-7861-fb06ef3d2522@kernel.org>
In-Reply-To: <12638499-5079-95b0-7861-fb06ef3d2522@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 Aug 2022 08:52:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj3zXDnXUHb-EKAkk74GUixO8ojUZMt-rkTsXSxALpi_g@mail.gmail.com>
Message-ID: <CAHk-=wj3zXDnXUHb-EKAkk74GUixO8ojUZMt-rkTsXSxALpi_g@mail.gmail.com>
Subject: Re: [GIT PULL] rtla: Updates for 5.20/6.0
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@suse.de>,
        jianchunfu <jianchunfu@cmss.chinamobile.com>
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

On Sat, Aug 6, 2022 at 6:01 AM Daniel Bristot de Oliveira
<bristot@kernel.org> wrote:
>
> Yes, I will do that. I will also do minimal fedora install and cross-check this further.

For extra bonus points, if you can state all missing packages in one
go (instead of "oops you don't have Xyz" followed by install of Xyz,
followed by "Oops, now you don't have Abc") that would be nice too.

But at this point the fundamental problem with incomprehensible error
messages is long gone, so it's not a big deal and not worth lots of
effort. More of a "if it's easy enough.."

                Linus
