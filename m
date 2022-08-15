Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED811592D32
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240068AbiHOI6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiHOI6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:58:03 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1715A20BF4;
        Mon, 15 Aug 2022 01:58:03 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id n21so5108008qkk.3;
        Mon, 15 Aug 2022 01:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=nk5EGLhK+gdgPOYsEk+ZMf81tiZAjsJWcHtjJMPh2io=;
        b=MO7rx/gRV4nEILHUy9iNkAnnBJ6aqHvt8BC3qpDT9rL5OuIc9Dsyc19HabPdVk1cZs
         fI2sKVvG68ZUkpN6sEcHAHGLRwy6sBnXww6VD9uiKNnA2mz78mQjX4+NspD9DXu0EYlU
         8vxVjClUYbXy16HKwP9oCXLuHZN8EuZHzOXOXvlRuRbeEglgFXwKdX77ikxCoI06WjnH
         akrHGPhA4XNr8Caxah/8KfU6wf5ucUwS+NaoiTdbVdls0VEy76hAksxlZvCp6mXpMnrK
         aAPvER8ZDc8IUf1GGMh3l5e88dihdu1hJB9RiQPuOwF1nGxCxp6SfOubc7YBoldY646i
         SRVA==
X-Gm-Message-State: ACgBeo3rvokVXW+arBD+pdWEgmiTbNv4PkqL5JAOUcQ+PfkzzTPWpT1v
        bzEUNv8qxP7pfsSC/mpFaAxFECOHZVsGS2jt
X-Google-Smtp-Source: AA6agR54M2VFI2yoALTW89h0106r0/WF2JlQaFEmA3tTNXq22yXy2SAB2Xa4wf5irbR4I4kHsuMsLg==
X-Received: by 2002:a37:9344:0:b0:6b9:b91a:1634 with SMTP id v65-20020a379344000000b006b9b91a1634mr10739071qkd.75.1660553882048;
        Mon, 15 Aug 2022 01:58:02 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id u11-20020a05620a430b00b006b99b78751csm8802718qko.112.2022.08.15.01.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 01:58:01 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 64so8369737ybl.9;
        Mon, 15 Aug 2022 01:58:01 -0700 (PDT)
X-Received: by 2002:a25:2d4:0:b0:674:b112:4f37 with SMTP id
 203-20020a2502d4000000b00674b1124f37mr11285966ybc.202.1660553881297; Mon, 15
 Aug 2022 01:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220805230736.1562801-1-f.fainelli@gmail.com>
In-Reply-To: <20220805230736.1562801-1-f.fainelli@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 15 Aug 2022 10:57:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVgqqnhg2TeznSP49sqVN8Hs=D0LKkne+evJkqT9U-LqQ@mail.gmail.com>
Message-ID: <CAMuHMdVgqqnhg2TeznSP49sqVN8Hs=D0LKkne+evJkqT9U-LqQ@mail.gmail.com>
Subject: Re: [PATCH] arch_topology: Silence early cacheinfo errors when non-existent
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Sat, Aug 6, 2022 at 1:10 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
> Architectures which do not have cacheinfo such as ARM 32-bit would spit
> out the following during boot:
>
>  Early cacheinfo failed, ret = -2
>
> Treat -ENOENT specifically to silence this error since it means that the
> platform does not support reporting its cache information.
>
> Fixes: 3fcbf1c77d08 ("arch_topology: Fix cache attributes detection in the CPU hotplug path")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Thank you, this fixes the issue seen with v6.0-rc1 on e.g. R-Car Gen2.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
