Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678CE46698E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 19:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376522AbhLBSEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 13:04:46 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:33489 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376514AbhLBSEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 13:04:45 -0500
Received: by mail-oi1-f182.google.com with SMTP id q25so859864oiw.0;
        Thu, 02 Dec 2021 10:01:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hFCPIg/xGM/GVnTJqr/HEg9x+TXzGuXlSKO7QjE6Gp0=;
        b=qByzMQnhgv6bESOoj0tl2ULKgt0KuQ/rhAFe/wxiXvz/oHL2eI13ArF2B3o6qbOimE
         2C6LmwBeVd+V5AZ/YP0B2b/8x65BzUQr93TGhe8dpryJZt6gGcQaJ/uqHP66DHDAcDoO
         aVERtyPpUShiULrDZDDoTQyzwMXfYUKpU3Sh3Rds3tVcNxzx0n9yfowoFGSWZIMvixZh
         m8fMrcLbXmgSdB7S7zHCn1qE0FLs9CuHCN6eezD57I+saSmeEhAo4GguQmuSrdrN8y8q
         7JRR1LxBU40tDqyyRtCuVzsgjT1ekp8yF2+Z+Sv31oRq6FP/P16oUjyjE3C5NzCxs4Ua
         9Q3Q==
X-Gm-Message-State: AOAM532mwvRi0gpxGKnUjlG8+qwnF74+zVPuXg6t3n4AFY0TS9ZXlk7O
        VDT7rtbSmB4Jp3EuVKK94RJ7zZfUwcEFrNp9vmY=
X-Google-Smtp-Source: ABdhPJzrmY2mcVARlurFg/AAnPH3ur2sfN9v5UIbgEa7JWQwtaXrEV09f39q7XktsJREi44rJE2a8OD8baKHOdZiXDA=
X-Received: by 2002:a05:6808:14c2:: with SMTP id f2mr5577443oiw.154.1638468082533;
 Thu, 02 Dec 2021 10:01:22 -0800 (PST)
MIME-Version: 1.0
References: <20211026222626.39222-1-ulf.hansson@linaro.org>
 <CAPDyKFrFdt_U7By_bqk4DBHxCBLpDe00aRb6P6BmwR4MYM2OmQ@mail.gmail.com>
 <CAJZ5v0i6WPVCf4pf9uTx5vjutw0cbD+omL_FNtw6DrxYDhyYEA@mail.gmail.com>
 <5794197.lOV4Wx5bFT@kreacher> <CAPDyKFrPC=8cAKGWQ4cDEcD934gi-012CWXu+uh-B_pqX+0RYQ@mail.gmail.com>
 <CAJZ5v0ijRK0sYoJ6_WyqrhQfYKxEf4jCSjK4T5CbQsYPXaB=Nw@mail.gmail.com> <Yaj5Vur0fTFXvhwE@rowland.harvard.edu>
In-Reply-To: <Yaj5Vur0fTFXvhwE@rowland.harvard.edu>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 2 Dec 2021 19:01:11 +0100
Message-ID: <CAJZ5v0ix2Xi0Tnt=ZgCLT4Q0K=1+kqey2QKNDR3y7=uVsFf-nA@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Allow rpm_resume() to succeed when runtime
 PM is disabled
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 2, 2021 at 5:50 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Thu, Dec 02, 2021 at 05:18:26PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Dec 2, 2021 at 12:29 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > Alright, this sounds reasonable to me. I have also looked at the code
> > > below and it looks good to me.
> > >
> > > Do you intend to post a formal patch? In any case, feel free to add my
> > > reviewed-by tag.
> >
> > I will, thank you!
>
> Don't forget to check for spelling errors (I noticed one in the first version of
> the patch you posted).  And please include a documentation update.

I will.

> On the whole, the idea seems like a good improvement.

Thanks!
