Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A063532F7E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 19:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239900AbiEXRRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 13:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237636AbiEXRRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 13:17:23 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66536674D5
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 10:17:22 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id jx22so23257945ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 10:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cBTU2d6LGQrA5UpdUI+q3+50Xb8LpHmYsGQdgFJYs7M=;
        b=Uje0i8noryWRQJ71UJNPcNr9SvuycxHpNv/YSo1Ph76D8OFKHwqsfeSV0OGq1Q4Mp3
         Ov9LU7DAcbOfjlfOw97Yzx7lF1wOJbOjjlHPDLfdbXTnpUXOtmCO2tSxVqLjKVPugaS+
         S4MP2x6uEactrqw7yUUlMJvqyEuXmgMdMnPas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cBTU2d6LGQrA5UpdUI+q3+50Xb8LpHmYsGQdgFJYs7M=;
        b=xK221wIj0iGbNVri+6nQ+TPv0uQKfe39BQsDZ59RTgbZBHOq1aVp45WLjUmogmRoYf
         gVfwsUKKyTdtzH0YgYGJ6NsGbuXSv5E86CJl3XLLSkAw+TJtlidhOQ/JGToRliEPgLCh
         opzHxEKhQ79327tAXAzJ+t2hgfkJ7PIMa72IWN/7ft1Lyb90j/fQQLaFWRYCBhrDpWu7
         k/g7NB3cAHX+z2CRgm4mlIjcruvlCEIku9W7zevGQC0iuyrFUv8sfDndZcloKbBYrnVj
         5cGqkPMHSkEl3egbVSNSxQFv/aZ7cn/4NviOTg/9y/BE5Smp6p3Fbx1OPrU5EVcQHTWD
         P4Xg==
X-Gm-Message-State: AOAM531LXjU/jfDeVHW/6yZimhIvaAYAEup5UPsZkY6MGxyROgeYGmnK
        0K6zIXfFSUKBb+x8PRgsT530TQp6doLCFUaw
X-Google-Smtp-Source: ABdhPJwCbnYGjHaixSVkUWc1lcgFAbhG+YlpeIdxeQn6zTJsIptaJkdAlykRx56/bhYICXTcdDvgQw==
X-Received: by 2002:a17:907:a088:b0:6f4:f661:f77a with SMTP id hu8-20020a170907a08800b006f4f661f77amr25358121ejc.77.1653412640611;
        Tue, 24 May 2022 10:17:20 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id 14-20020a17090601ce00b006f3ef214db6sm7317893ejj.28.2022.05.24.10.17.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 10:17:20 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id j25so2222993wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 10:17:19 -0700 (PDT)
X-Received: by 2002:a5d:59ac:0:b0:20e:6fd6:88c1 with SMTP id
 p12-20020a5d59ac000000b0020e6fd688c1mr21668342wrr.442.1653412639620; Tue, 24
 May 2022 10:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <13e61c61-0d4b-5f48-6373-f056bf8b603f@redhat.com>
 <CAHk-=wgV8zqiLi5p-SNZ2zSi95CkkFXqPZJjtneVXeobgAohJg@mail.gmail.com> <f39aa9c0-b4e6-1f5d-f556-643442fcbcc5@redhat.com>
In-Reply-To: <f39aa9c0-b4e6-1f5d-f556-643442fcbcc5@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 May 2022 10:17:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgNP+Dziv=4MDEf-wAW-U_0ZNNsL0gMDs7A46+CACgD4w@mail.gmail.com>
Message-ID: <CAHk-=wgNP+Dziv=4MDEf-wAW-U_0ZNNsL0gMDs7A46+CACgD4w@mail.gmail.com>
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.19-1
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
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

On Mon, May 23, 2022 at 11:47 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> I did do a "git remote update origin" recently (recent-ish), but
> AFAIK that does not help.

Hmm. Did you pass in 'origin' to git request-pull too?

> I did read somewhere that in cases like this some maintainers
> create a branch with a merge of their for-next branch [..]

No, that's only necessary for when the branch has merges and can have
multiple merge bases as a result - that will make 'git diff' unable to
find an unambiguous place to start the diff from (see
Documentation/maintainer/messy-diffstat.rst for the details).

But your tree doesn't have that issue, and you can also see the old
commits in your shortlog (and the "messy diffstat" is _only_ about the
diff, not about the commit list). And you can see the same effect in
the shortlog, ie I merged your earlier fixes pull request  in commit
9be9ed2612b5 ("Merge tag 'platform-drivers-x86-v5.18-4' of
git://..."), and it already had

    * tag 'platform-drivers-x86-v5.18-4' of
git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/pla>
      platform/surface: aggregator: Fix initialization order when
compiling as builtin module
      platform/surface: gpe: Add support for Surface Pro 8
      platform/x86/intel: Fix 'rmmod pmt_telemetry' panic
      platform/x86: thinkpad_acpi: Correct dual fan probe
      platform/x86: thinkpad_acpi: Add a s2idle resume quirk for a
number of laptops
      platform/x86: thinkpad_acpi: Convert btusb DMI list to quirks

but notice how your pll request had those commits listed again (ie it
had, for example:

  Maximilian Luz (2):
        platform/surface: gpe: Add support for Surface Pro 8
        platform/surface: aggregator: Fix initialization order when
compiling as builtin module

in there).

And while merges can confuse the diffstat, the actual commit list
doesn't care: it does a proper set operation, and having multiple
merge bases doesn't matter.

This all is not a huge deal - I figured out what was going on, so it
wasn't a problem.

I just mentioned it because that whole "Linus figures it out" does
take some time and effort, and I'm really really lazy and much prefer
to just do the pull and look at the result and go "Yeah, looks good"
and go on to the next one...

Thanks,
                 Linus
