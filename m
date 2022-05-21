Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3CB52F8D1
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 07:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354569AbiEUFB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 01:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354536AbiEUFBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 01:01:50 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7917B5C350
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 22:01:49 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id n10so18875848ejk.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 22:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+JP7eb9X89dzmMi77NTEFpsoLT6OioYPHTkokdTxBHc=;
        b=cQzbMTyiE3pGwpfX4bEhpbYVQq+AvZNw60MIRF7N3gv42F9YVuqaF8j3RZf5Kc2Zx7
         yIFe8S3IfJm4FOgTmmlvYMn2RZTN3K23qkz2gZv8lX4lFoRTrFCZs4AUUAouLsXxSkd3
         dDYwffr2dYvPunf5WQ66AzJlIoyBw7YtXbuUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+JP7eb9X89dzmMi77NTEFpsoLT6OioYPHTkokdTxBHc=;
        b=mC0DuwvBflBCMUCr6gCJvCBqD9y9/4BLpJRNdZEsuWA/8CqUYhKv2jiX6pofMhLNtP
         z1siTDRCjg45Sq1hLSqL4Ih5DhxWWHf01Zs8o1JA2ZLrl5ZpEGOKyMkEOKLh/tfY9rB/
         ZXFyvFg7l7JQiTZ62Z5Vd/HJLByriJ0nNfUmPINomMOPliShLR3eQJQ3lu/u22BqQ4Yi
         xuEYqJVVQYG0Jhxylk1WRViXeNxBFtHSlagSEcz2x3inx/eUPBEnYP7hgwVpykRgoCp/
         SLBBHrRSxcXCseKejNZTu8UezXCz84/4HoseWGR98bercqJ5dJGEgQcn4txwltql3LfD
         dbYw==
X-Gm-Message-State: AOAM530ywlt2KGyt1/5YNgTGsEFc25lT2njGf+VFSQujjlOnVVCuKjSp
        xqe7G7v5bKUujGavZzkVtfJC1SNjEi+uBsRr
X-Google-Smtp-Source: ABdhPJzj5mWDJv3O6+T/dJ24WmPYTB75dUDNvBLEDJGTnInJ1x+G6LjU8eNIsbRyVpsPINyzbqYg1w==
X-Received: by 2002:a17:906:c142:b0:6f5:2632:adb7 with SMTP id dp2-20020a170906c14200b006f52632adb7mr11551003ejc.637.1653109307863;
        Fri, 20 May 2022 22:01:47 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id er8-20020a170907738800b006f3ef214e45sm3837329ejc.171.2022.05.20.22.01.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 22:01:46 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id v191-20020a1cacc8000000b00397001398c0so7820638wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 22:01:45 -0700 (PDT)
X-Received: by 2002:a05:600c:4f06:b0:394:836b:1552 with SMTP id
 l6-20020a05600c4f0600b00394836b1552mr11323806wmq.145.1653109305450; Fri, 20
 May 2022 22:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wi0vqZQUAS67tBsJQW+dtt89m+dqA-Z4bOs8CH-mm8u2w@mail.gmail.com>
 <165209064657.193515.10163777181547077546@leemhuis.info> <CAHk-=wj0gHsG6iw3D8ufptm9a_dvTSqrrOFY9WopObbYbyuwnA@mail.gmail.com>
 <54664f6a-b046-1330-e794-cb533e942a94@redhat.com> <04f2e08c-4c39-16d3-d785-f36494c6256c@redhat.com>
 <063d7fdb-2d4c-5798-773b-d82b4f0e918a@redhat.com>
In-Reply-To: <063d7fdb-2d4c-5798-773b-d82b4f0e918a@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 May 2022 19:01:29 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjKtV3mT3S=vxgqe__MUzxRrZ7=fopKQtTKOeQJAVyoUQ@mail.gmail.com>
Message-ID: <CAHk-=wjKtV3mT3S=vxgqe__MUzxRrZ7=fopKQtTKOeQJAVyoUQ@mail.gmail.com>
Subject: Re: Linux regressions report for mainline [2022-05-09] (was: Linux 5.18-rc6)
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
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

On Thu, May 19, 2022 at 6:10 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Note this is not part of any pending drm-fixes* pull-reqs yet though.

It has now hit my tree as part of Dave's drm pull today.

Will go out after the usual basic build test.

               Linus
