Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B64594E7E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 04:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbiHPCJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 22:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbiHPCIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 22:08:47 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816D211523B
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 15:04:12 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id s23so4401395wmj.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 15:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=DScyr7zPgAT1My12tB2sc7eXpGm1MaYAl6gmOsXWGKM=;
        b=EFX2ZpZxXNlQ+0y+akoxxEz26KyvWVXp6freMq27U8K1Yf7BiioBwUiYOUtWfHYF+d
         R//fuRSqmVCQ8rQnm5oZ/fM6Uy283inBkDUSIYMoD4mhu0DBg+Px95K2A3ngfIVyEeJp
         Z4v8zHSNa8GLdF0wcm5sgBeW/jcjHBpj3U0Bk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=DScyr7zPgAT1My12tB2sc7eXpGm1MaYAl6gmOsXWGKM=;
        b=HAew1xYAMBOXwqG94JtP9iTS3l5wrvYYX1J6G5NowwlG4f9mP7eZM6RZQtKRiA47vf
         xit+gYIiwrkWyuona4tV8q3N3EkVe1nlzn6VzSbGOZ0zYw7QHr2EqUdi14qkTqE0isjV
         pAPq8HZtZTpPV/VrvPvt0ElU6kgqGCETAapOle9wNoxmrs+ajn4/OHfKr7/MUr8xo2Ga
         8wFnxYxpccEw9XJ0nXPSBWxUW76r4dUOJiSAsbbzxAGUWl/RhcltozU/CygjrQf3alHD
         KutoGrLV3k2fKRXNWJ7c+Zkbo/+JCdnA59rU8MtF5tEAvJxGwmbIXbhBw41ukDm1CK2z
         FQ0g==
X-Gm-Message-State: ACgBeo1BWKyTYs4/3hE4iz1/ZafqepUL3u/6ZocRaH1cbpRGC6FLYXqD
        vmXERr0EYJFPdcANI4nDn+n3oOk3GxIJPyyBNFCu2g==
X-Google-Smtp-Source: AA6agR57CeIcH1AYt48OOWPHb+xVD/XdmU+1myzuZqcB4oiegyEYpMK+k3/rHxtaQmWmSMuGEi5y4iaCvGN/RhcGL00=
X-Received: by 2002:a1c:f209:0:b0:3a4:f42c:9ffb with SMTP id
 s9-20020a1cf209000000b003a4f42c9ffbmr17599965wmc.62.1660601050918; Mon, 15
 Aug 2022 15:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220806204857.3276448-1-jrosenth@chromium.org>
 <CAE-0n53gc=1vwZbhGUaF2EyXotMPjqoQixUMJDidcs7vLmNORQ@mail.gmail.com> <YvqyM3n48Q/0i9XZ@chromium.org>
In-Reply-To: <YvqyM3n48Q/0i9XZ@chromium.org>
From:   Julius Werner <jwerner@chromium.org>
Date:   Mon, 15 Aug 2022 15:03:58 -0700
Message-ID: <CAODwPW-B80WBvhOvQ96PGwoCSa=fpnYbHv+DM3EMEzTr+1v1sg@mail.gmail.com>
Subject: Re: [PATCH v8] firmware: google: Implement cbmem in sysfs driver
To:     Jack Rosenthal <jrosenth@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        chrome-platform@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Are all entries supposed to be writeable? Are there entries that are
> > read-only?
>
> The idea here was that we could use crossystem to update the cbmem entry
> when it makes changes, however, I do see this as an odd usage of the
> ABI, and in v9, I removed writing entirely and all entries are now
> read-only.
>
> If tools like crossystem need to maintain changes to this buffer, they
> should either maintain that copy themselves in /run or something, or
> daemonize and keep it in their process' memory.

Sorry, but I really don't like that approach, I feel like this is
swinging too far in the other direction for no good reason. There
should only be one source of truth for these things, not every process
for themselves.

If people are worried about allowing (access-controlled) writes to all
CBMEM buffers, we could restrict this to just a hardcoded allowlist of
CBMEM IDs. It would only need to be the vboot workbuffer for now, and
if we ever find another use case it would be easy to add (unlikely
that this would happen often). Or if you really don't want this at all
then ditch the `mem` node completely and just have crossystem use
/dev/mem on that address and size (although this would run into the
memory type uncertainties again that Stephen mentioned). But we
shouldn't keep a dozen redundant caches of the same thing.
