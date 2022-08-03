Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C09658916F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238250AbiHCRbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238162AbiHCRa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:30:56 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA4325EC;
        Wed,  3 Aug 2022 10:30:56 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-31f445bd486so178247607b3.13;
        Wed, 03 Aug 2022 10:30:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=WBeF1S+AVOd3VzbsyVxd4ccPoTYFwU9F03mP/z22PLU=;
        b=w9skiEMXIHQ81SL+xIStyCjehKHLdiauzCqYMv+QNmagKOEQ7CgbARqdqF8bRiY4aG
         RheY9vNOGJQ4yzq1ixbiO40FdN0HdUzdPqJhwGAj0gRHVzyC28uzst4WGTBS97zVcbmh
         ttLTevAR7dph/pUeQeVJgY5xPu3nsPMkpBaDT3nk3Rl0vmPWH9GHjzc/0UwLfuaVxccd
         458RcyYZ4D1SB/bpuWmDDNpUU2GsVGCqw7MORcItjQh80NaGAr4H7Ld7dcHIctT9kWck
         yyw9FKmS4kNRWB2bBU+tqjeQt/1XgrfRwu5v56W6AeAe7murAP38TRiRmxSHEXkIV8+G
         JykQ==
X-Gm-Message-State: ACgBeo1hZ5XHfzvb6cXFSSLjUMnMOkrrU/h7yhUrDGupcfqhbkT0M0OF
        QPjYuf4fCl0fWgKrbfKr5vtPrvqguMJ8hdy5rDk=
X-Google-Smtp-Source: AA6agR7q/E/CJqX7dlIHMLTWPoza3UNEO+B1zjDcw9UgOSdDI5vLwI6sgfgNw+5i9EWA8M4Jicn6dvapmTIp6HLDSGI=
X-Received: by 2002:a0d:d694:0:b0:325:1881:6a52 with SMTP id
 y142-20020a0dd694000000b0032518816a52mr13318774ywd.149.1659547855256; Wed, 03
 Aug 2022 10:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220725173755.2993805-1-f.fainelli@gmail.com>
 <CAJZ5v0hL46vdr=f8YiAPnRmmehZs51n+tkgoY7PMTVyJD0cpEA@mail.gmail.com> <1c129750-4ac0-e4aa-f3b1-80ca1d35e23c@linaro.org>
In-Reply-To: <1c129750-4ac0-e4aa-f3b1-80ca1d35e23c@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Aug 2022 19:30:44 +0200
Message-ID: <CAJZ5v0jOzpZSHPdTp2Qzh-oQP7aa=LtgXr2k6W3DevBV0Zw5uA@mail.gmail.com>
Subject: Re: [PATCH] tools/thermal: Fix possible path truncations
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 3, 2022 at 7:19 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 03/08/2022 19:07, Rafael J. Wysocki wrote:
> > On Mon, Jul 25, 2022 at 7:38 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>
> >> A build with -D_FORTIFY_SOURCE=2 enabled will produce the following warnings:
> >>
> >> sysfs.c:63:30: warning: '%s' directive output may be truncated writing up to 255 bytes into a region of size between 0 and 255 [-Wformat-truncation=]
> >>    snprintf(filepath, 256, "%s/%s", path, filename);
> >>                                ^~
> >> Bump up the buffer to PATH_MAX which is the limit and account for all of
> >> the possible NUL and separators that could lead to exceeding the
> >> allocated buffer sizes.
> >>
> >> Fixes: 94f69966faf8 ("tools/thermal: Introduce tmon, a tool for thermal subsystem")
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >
> > Daniel, are you going to pick up this one or should I?
>
> Yes, you can pick it

Done.

> > There is also a tmon patch from Florian that seems to be pending.
> > Should I take care of it?
>
> I'm not sure which patch you are referring but if it is the pthread
> compilation issue, it should be already applied for v5.20-rc1 from the
> thermal pull request
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/diff/tools/thermal/tmon/tmon.h?id=c1dbe9a1c86da098a29dcdca1a67b65e2de7ec3a

Yes, it was this one.

OK, we're good.
