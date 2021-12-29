Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E20F481456
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 16:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240489AbhL2PJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 10:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240478AbhL2PJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 10:09:19 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022E3C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 07:09:18 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id az37so16916442uab.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 07:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T059ASJ4RtNlK+2+zqkQwGDitt3VLEMv58+0Dyd15tw=;
        b=k/sZSVfO2n1ewqdP+M5u1L3MSFLlvIBg5huso4GeRPgYVk/13h3TBvjAIbky4yh7oE
         jywLqi03y5KEO7QCuYfxLH/b70MVzikaIJ8Do4kw6+RYOgK9QZDAFUCGU9Rfkwc/xHpa
         GHHyjbXswHSkIwHOrDwRgSmEa3V1pPuWcRNARraptp4toJFYWNRrGW9POPNArwXKyOGY
         vMO2ent+W69IwXGQQleUsR6CSfpQh35jE4dQ8hMyM4trJzg4ToOsZKWB9iXXUZJYDhqt
         EBPVGpG+ME9qSWV4NTJlB9uoTeaqbclEGC1mAX7GRZkx4wUny7+tjf4r/ChBf8fzRPXL
         N6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T059ASJ4RtNlK+2+zqkQwGDitt3VLEMv58+0Dyd15tw=;
        b=BfygiOTyUa4Se216DBX3+yOmUNgPHGvB3K+QPGWtYkk2BAPnavcxXSTsy3p6x7S3Dq
         cknVyVexDTOdfJVHiAjJ/AKpmEAFsF/eIipX0nfgVE/lWutdaiTf+IDcwHx5t15B9kUw
         AiHcarI3413vYGc/c3T/h8IXTuVfdu2Xqm38P3V5g80XmBvUYS38qDpCrZvSv276axuX
         LxGPNkT7yrUUtKLhLDlgy13doZpz9Z6KgmKyVD0iCuqABUiwnoWAuVn8p7VvsQs+6bnO
         xcUUWRASAfQ2tN2Hv2XnTcDs1lf7ApTgi6OUWIx3WNZTCLAO8JhnYMjzUhE7WodwA2mp
         1mDA==
X-Gm-Message-State: AOAM5336PzdmB0B0+oPAO7afGrGLSQasZwwKIQAa6D/V6b/fLOSZgufr
        wvEka/3sQX7nGQEmquAjUkky3AnI+Gc=
X-Google-Smtp-Source: ABdhPJyrOCUbJpEBkCqBlvZ5dswXJ8StBAcesf6GsUx/gWUrpL/le2VDLjEqRuZUXawr8PUbW+qCQA==
X-Received: by 2002:a67:e1c3:: with SMTP id p3mr7396148vsl.23.1640790557997;
        Wed, 29 Dec 2021 07:09:17 -0800 (PST)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id u137sm194832vku.42.2021.12.29.07.09.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 07:09:17 -0800 (PST)
Received: by mail-vk1-f178.google.com with SMTP id u198so12178098vkb.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 07:09:17 -0800 (PST)
X-Received: by 2002:a05:6122:2086:: with SMTP id i6mr8428405vkd.2.1640790556954;
 Wed, 29 Dec 2021 07:09:16 -0800 (PST)
MIME-Version: 1.0
References: <CAJ-ks9kd6wWi1S8GSCf1f=vJER=_35BGZzLnXwz36xDQPacyRw@mail.gmail.com>
 <CAJ-ks9=41PuzGkXmi0-aZPEWicWJ5s2gW2zL+jSHuDjaJ5Lhsg@mail.gmail.com> <20211228155433.3b1c71e5@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <20211228155433.3b1c71e5@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 29 Dec 2021 10:08:40 -0500
X-Gmail-Original-Message-ID: <CA+FuTSeDTJxbPvN6hkXFMaBspVHwL+crOxzC2ukWRzxvKma9bA@mail.gmail.com>
Message-ID: <CA+FuTSeDTJxbPvN6hkXFMaBspVHwL+crOxzC2ukWRzxvKma9bA@mail.gmail.com>
Subject: Re: [PATCH] net: check passed optlen before reading
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Tamir Duberstein <tamird@gmail.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 6:54 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Tue, 28 Dec 2021 16:02:29 -0500 Tamir Duberstein wrote:
> > Errant brace in the earlier version.
> >
> > From 8586be4d72c6c583b1085d2239076987e1b7c43a Mon Sep 17 00:00:00 2001
> > From: Tamir Duberstein <tamird@gmail.com>
> > Date: Tue, 28 Dec 2021 15:09:11 -0500
> > Subject: [PATCH v2] net: check passed optlen before reading
> >
> > Add a check that the user-provided option is at least as long as the
> > number of bytes we intend to read. Before this patch we would blindly
> > read sizeof(int) bytes even in cases where the user passed
> > optlen<sizeof(int), which would potentially read garbage or fault.
> >
> > Discovered by new tests in https://github.com/google/gvisor/pull/6957 .
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>
> Your patches are corrupted by your email client.
>
> Can you try sending the latest version with git send-email?

Then perhaps also update the subject line to make it more clear where
this applies: "ipv6: raw: check passed optlen before reading".
