Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314A84709DD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343516AbhLJTMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242008AbhLJTMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:12:13 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541CAC0617A1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 11:08:37 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id r11so32315764edd.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 11:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bKOECJk1jJ3q3aRaws2R1fCsqMsAZmC2N+Te1qpydV4=;
        b=mDEzqB9Sg8juoMedsC+gYoJ5lqfbPR8C4O4rmAFDd3oS06s3XyXeVFZDtRfrYiz16J
         RllaDd1KeHYH4DFtZAFwBo4+uMZfqur3JCaExyZ566eASnR1MP/5kSq0qzdUDdDEkcZH
         UC4/iLsrJ7Nf8dVFJGP09ZSyYpJTIuHMxtrRJSlzxg/DM9KR3m4WH4syrEWc39r6gNnd
         XxkPsqsP+N8mWtdur+T+kLrPK/kIYYZEKounapx055i5AGVQhjabPWlVRczSuP+VsAyY
         v/6I7yIzAxFSRKXBarNaezMooUSXR3HfAt/j2DkAC9E88PnRdb6AZJ+eMUi0mnkoxBvM
         hO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bKOECJk1jJ3q3aRaws2R1fCsqMsAZmC2N+Te1qpydV4=;
        b=1DXedqpuwdHtZC2E7i6wYcNI8knF0d/UicTzSvknxb3XysqDJpCS5AgSlFNKK3NSW8
         zk5exJ0RAPjbQsRP7HpfWVRIC5xeysQgjd/zz1ckAT17fVCiOeA6ABImRMz9e/oOSCgT
         ECLvhcSmpqIa8b6aNxw//T9F8gveeDUDGbpGZZzdLhq/wxi1+IfkoUjTXg7DuY8IWkJO
         n8260DyDlCMjgvJ38Q6AJ6R21egKgIyhFkvr0hhAIHkK2h08pQJhSOp9fSfE9CTX2wjZ
         ICs/s82Y3qFRd4YLRDnEDC2DMAWlSdfG5XyX4xUjh3rBxDQrr2K0Q3oSXGr6eOq+H4Iv
         84bw==
X-Gm-Message-State: AOAM53123ro6rMHCwpzaUTos/vFXNuB/LVFX0BQDnOnh8mcn3TPr3JJ6
        aD2ElW2NLzrHKs7Os+TjgqoH8t86YHsLw0t24VtERA==
X-Google-Smtp-Source: ABdhPJw1SRLISQYRwwyBY3erFu+/gnRJ2m2KPpYCCCuCP8JLBXNiDB+A9B+7x9Sa6HLf+xzOxL+VyrgFwaKoWoUrN+8=
X-Received: by 2002:a17:907:9847:: with SMTP id jj7mr25438164ejc.508.1639163315880;
 Fri, 10 Dec 2021 11:08:35 -0800 (PST)
MIME-Version: 1.0
References: <20211207093412.27833-1-brgl@bgdev.pl> <CACRpkdbAs+ZpU_uQziXmz2inPG7VHD=746MmjmR8iY3szfy9+w@mail.gmail.com>
In-Reply-To: <CACRpkdbAs+ZpU_uQziXmz2inPG7VHD=746MmjmR8iY3szfy9+w@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 10 Dec 2021 20:08:25 +0100
Message-ID: <CAMRc=MfWv5bpudpfc2L8Y2HdS+nkXGToSgn6Oovxo4NXxHzHmQ@mail.gmail.com>
Subject: Re: [PATCH v13 0/7] gpio-sim: configfs-based GPIO simulator
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021 at 1:54 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Dec 7, 2021 at 10:34 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> > Hopefully this will be the last iteration of this series. Just some
> > minor changes requested by Andy in this one.
> >
> > Tested both with configfs as well as device-tree.
>
> This patch set:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Thanks for your perseverance!!
>
> Yours,
> Linus Walleij

Thanks, if there are no objections, I'll queue this series on Monday
to give it some time in next.

Bart
