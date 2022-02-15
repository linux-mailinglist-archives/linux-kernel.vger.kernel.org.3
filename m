Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3411C4B79ED
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 22:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242516AbiBOVtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 16:49:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240529AbiBOVtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 16:49:33 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597B1D0079
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 13:49:22 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id p15so115607ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 13:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FBEgLM+wt/N2x1IHh68kag6ZJDXafwurcKEa4xbiiRA=;
        b=dUtcnX+ydVohJxF8J4PuoFN32Pe8FmdtubeCsxRfg8qkWn4EMw9G9vnkVxUNaGUVkg
         E9BgdA1lrPfISHBNOyCI8u0tCWhVKPIQ1qcgRaH2Pk3dxk+3Uc9Q1Bbgl3dZomps4wIY
         H7897feys9nrxvVY8GbtBNNUBkjvNjrCZOqfEoexuQ4/d/DJZ1sxU6Zn+8gkCQClik0A
         wIn0U5WZfF9CwPRA5yQ/dz0RzyXVdJ7FOp3vgSTul01tcryuOxCjJFQAwciR4JslB9G9
         xtj++3faySz8JloNf8tPJ9Qne8vpG7R+G/P7Pq0sJpPazi+wgbKvarov+9KQ3Ee3vS/x
         C1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FBEgLM+wt/N2x1IHh68kag6ZJDXafwurcKEa4xbiiRA=;
        b=m/2Oeok+qLQFxwBWD726jTRsV9Ra8VJqmllUNuJTkVUiuh9LAm8wKmy+YdWm3WsDIm
         C+chHOuzYNKja1nS4SXaSZgWogJQ8g/7A+VVNeHbcKOVj9xVCn6zd9JTtUClgR3KRP11
         +LDPMIjqoFKC9y+f65bpQ++v2Ibo9IiMLOvGVhecreZJwKYvrQsIIXX3EOIl2mAP3Ex6
         HXoB4O/bWO1XKRnM0lkthKMc9SFAPsSfwU0j6KlV8W+mN+/Iq1Lqc3N3ig/D8D/IFYRP
         Oglm+HjYziOvqg9b+b/xuL/WE28Hz1bAXsDOzdQapTLQHT58l00VaIGTZszZm6veFyKD
         tHPw==
X-Gm-Message-State: AOAM531DUFF20Lf3r8tGOCxu14vpZ6ygFop/vi52n8xpOK/SO99VtlAE
        yX+gL8zbe1OuFBGXB9I3f7z2YxPIwaHOuR/4sG8c6A==
X-Google-Smtp-Source: ABdhPJxdQIHhEEivGAPujZ1vWMw46zjqTY9aKwpZWDECFJzPHpSiSqzoRatNCn8X77SyeKutNCcfytdvXXepJ8uF+Wo=
X-Received: by 2002:a17:906:91c8:b0:6c5:76a6:688b with SMTP id
 b8-20020a17090691c800b006c576a6688bmr35287ejx.174.1644961760744; Tue, 15 Feb
 2022 13:49:20 -0800 (PST)
MIME-Version: 1.0
References: <543efc25-9b99-53cd-e305-d8b4d917b64b@intel.com>
 <20220215192233.8717-1-bgeffon@google.com> <YgwCuGcg6adXAXIz@kroah.com>
 <CADyq12wByWhsHNOnokrSwCDeEhPdyO6WNJNjpHE1ORgKwwwXgg@mail.gmail.com> <066c9f4b-b0a3-9343-9db9-1c1c7303da6f@intel.com>
In-Reply-To: <066c9f4b-b0a3-9343-9db9-1c1c7303da6f@intel.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Tue, 15 Feb 2022 16:48:44 -0500
Message-ID: <CADyq12w=oLp4a5CV6nCyrpijDQTeji5reE+w_F4Ha=qCJEsBGQ@mail.gmail.com>
Subject: Re: [PATCH stable 5.4,5.10] x86/fpu: Correct pkru/xstate inconsistency
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Willis Kung <williskung@google.com>,
        Guenter Roeck <groeck@google.com>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        "# v4 . 10+" <stable@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 4:42 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 2/15/22 13:32, Brian Geffon wrote:
> >> How was this tested, and what do the maintainers of this subsystem
> >> think?  And will you be around to fix the bugs in this when they are
> >> found?
> > This has been trivial to reproduce, I've used a small repro which I've
> > put here: https://gist.github.com/bgaff/9f8cbfc8dd22e60f9492e4f0aff8f04f
> > , I also was able to reproduce this using the protection_keys self
> > tests on a 11th Gen Core i5-1135G7.
>
> I've got an i7-1165G7, but I'm not seeing any failures on a
> 5.11 distro kernel.
>
> How long does this take for you to reproduce?

It reproduces for me in just a few seconds. I'm not sure what could be
different about my setup, I've tested on a vanilla 5.10 kernel and it
reproduced the same way.

Brian
