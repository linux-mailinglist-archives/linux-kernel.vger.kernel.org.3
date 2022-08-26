Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02D35A30CB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 23:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiHZVG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 17:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiHZVG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 17:06:26 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECECDD76C
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 14:06:25 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id kk26so5301640ejc.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 14:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5PwylQXedxDhkWafpzB4KIy3NiEnlvim/yfJsbpjDbQ=;
        b=Yf9PjWlfL1r7eT/c/0AIKUjx+BKquW/wJnHvOD5xraOs6Zq6+qgnX0MvaVZZirGA29
         MiCEjgTCWVH6qERy3ErADS+pQlFu0JZM6MMkgMyDzjmYTl7pzcjuduPfCeYXe62wir+R
         F/0AJRGshM9LobezTNYiztGwD4ALx554BVYmphaKX7b/HqjkDb7yE0CapdGKprLHC+uD
         NVhp5BNbj7GtIsj4wHzXNKBXu/nBCo5/+AtMQFMoQTJGxpubM3Nl1C2nlDuiKCFTD0OA
         rUPDJDe2Jk6Y9NkE7s0OgIZFirU9LpSK8tGo9v+OA4I+pXOc2aqEI54hnwrbByRa3Csa
         4lMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5PwylQXedxDhkWafpzB4KIy3NiEnlvim/yfJsbpjDbQ=;
        b=lJ5DhZBEYsiKdSW+girlhObvHlt7w1LW7lwQjOk88ndq70VvRjNAh8vxZHJFIIRxZx
         MG9ltD9htmsCW09suOtReseq7AezSe4luhlMACLfRuYoJC/gpnupCn/w0xPHJfKJNuOQ
         RfxxOfALnbe8tsmfuKPZl5akN6oTIs/EjNo/j4sN+F6gpOwIZBZckHzFwEyUfxTHK2C5
         GZvvRjGHjP8tDEIEbKaRSODaHfu9ZULBwlb+RBT5zequkMo65mhzCAdR3qXP0GJnFd5S
         sJMf8t7xygB6Os6k7NDT76PqiK0GywQv1JdL2PAiJbncbp4MT6ukoLAXJR4kFlyWKvOz
         N++Q==
X-Gm-Message-State: ACgBeo0RVJl8rzoFAotCkWN+AfL77amS95AbZ5Cts48YCdQdRAhLBcLc
        ngXe7lkAdiEHf7XPqTTkMVFlSp0TukXImTtydmzD9tqA5Q==
X-Google-Smtp-Source: AA6agR6Ncxwh8sZisapap17QKB0vCPLvZPFGD64SjhSRwQj5pNJD2743vRLKzk92RbbdMrcFnobg9pLitg0Rbm61fT0=
X-Received: by 2002:a17:907:6096:b0:73d:9d12:4b04 with SMTP id
 ht22-20020a170907609600b0073d9d124b04mr6717363ejc.745.1661547983987; Fri, 26
 Aug 2022 14:06:23 -0700 (PDT)
MIME-Version: 1.0
References: <1661502678-19336-3-git-send-email-kaixuxia@tencent.com> <20220826171629.50210-1-sj@kernel.org>
In-Reply-To: <20220826171629.50210-1-sj@kernel.org>
From:   Kaixu Xia <xiakaixu1987@gmail.com>
Date:   Sat, 27 Aug 2022 05:06:12 +0800
Message-ID: <CAGjdHunJ4bRbzm6gGKaZONTa1sY8macitByxattRSbwJZR5J2g@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/damon/vaddr: remove comparison between mm and
 last_mm when checking region accesses
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Kaixu Xia <kaixuxia@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2022 at 1:16 AM SeongJae Park <sj@kernel.org> wrote:
>
> Hi Kaixu,
>
> On Fri, 26 Aug 2022 16:31:18 +0800 xiakaixu1987@gmail.com wrote:
>
> > From: Kaixu Xia <kaixuxia@tencent.com>
> >
> > The damon regions that belong to the same damon target have the same
> > 'struct mm_struct *mm', so it's unnecessary to compare the mm and last_mm
> > objects among the damon regions in one damon target when checking accesses.
>
> There could be multiple targets, and 'damon_va_check_accesses()' calls
> '__damon_va_check_accesses()' for all the targets.  However,
> 'damon_va_check_accesses()' doesn't note if '__damon_va_check_accesses()' is
> called with a target that same to the target it was called with for the last
> time.  Hence the check is necessary.

There could be many regions(1000 max limit) in one target and the mm
is same within
the target, maybe we don't need to maintain the 'last_mm' and do the
check every time
when the target is same.
But yes, the check is necessary when the target changed in
'__damon_va_check_accesses()',
this RFC patch missed this case :)  will fix it.

>
> If I'm missing something, please let me know.
>
>
> Thanks,
> SJ
>
> [...]
