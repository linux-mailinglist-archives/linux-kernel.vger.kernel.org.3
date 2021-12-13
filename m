Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561A1472094
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 06:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhLMFh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 00:37:26 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:51158
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231920AbhLMFhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 00:37:25 -0500
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6C3573F1B3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 05:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639373842;
        bh=BTBk9dEKx4lsyGES5D0AWCC8FmlvHup2ORFi//c8U3I=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ajb1se9XHwhEITRRgr1I3NFRt1en42nDUQu/gKgfebC53PmTN7Vqnbd52u/R9GxLi
         Z7lJB8nm6qFTxD5Fl8aiZ/Zj5S4xxVSqbyaaoJWiyYqCSykv4R0/3bUbmYjVHZrdAv
         78jVjc1ETe2yPUbXZq52jQhCoxS3HKfaDXMuae5uY9waF0NGYNw2+Y7osNhPyPL0ms
         iazXXG3qSrd9/Z9ym7yNgNcaDK9W9TYSLbgp6I4Uv9sUP3TsNtfJln/Z2FgYR8v8DT
         HzQ253q0Jcd8pKQoHfzVGOWaYdqCp9kbcoZ6AXM1ne4Hd7xAQa2U4pPjV+IOQr2Zwd
         MQ8tgVEUdGliA==
Received: by mail-oi1-f200.google.com with SMTP id t26-20020a056808159a00b002bce1f1c045so10261308oiw.16
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 21:37:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BTBk9dEKx4lsyGES5D0AWCC8FmlvHup2ORFi//c8U3I=;
        b=Kuo8kahVYDuEhW0kpYrBipKOiMwks8IaoJI/gAE1EsIGXC6FKF8DGqy++8UDXBhaLH
         6NnIAcKC0WhyMQ6WZA/p4Rlx9tZ8vkfWxyJDv6nGMgTN6gYaERhbQeuqEJ7uXpDe4tFt
         VQMQFThWf+JyuLgtQDfnqV0bw0QOe0K4nGWv2LCHbzciGomW5705u4d0fB28cmY+O3Ck
         4dUpCn0FNg56MrbQTj64bHDTxIArWzdAv9pKtTDXtG5ywcHlrLcGnjTqBkgLO0NFveZW
         6Rn+9pO6P3eGayEaHk7VY3eM0kA+Et08+ckKFWNbgA/3BpRJgzc9hqn1EDgI5kMKJQhX
         5U2A==
X-Gm-Message-State: AOAM533UQFB8WpzLk0uxwgc6DBGQWjUG4oljeMLzDq4+Z5EV+BcKr0Ts
        cco51XbOy1RYQfk68HTgdmiGRqMu3R2n5L2iqu0msxHfrb7oWhfr+qb1yovESaP21oGkKPP69b8
        WiknkevbwAz82eZ7SSdsBUY6SOPTlpQrH7l6z6O53z6SicYTWzMovoTp0Mw==
X-Received: by 2002:a05:6830:1d87:: with SMTP id y7mr23284225oti.269.1639373841214;
        Sun, 12 Dec 2021 21:37:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz0gMZe7FqEweerkKFacyay+ZXeFoWuDsh59se0eLq9GFoawu1euY5InfMW8iXVW0OueUClIPO70bCV4BO6Ass=
X-Received: by 2002:a05:6830:1d87:: with SMTP id y7mr23284205oti.269.1639373840973;
 Sun, 12 Dec 2021 21:37:20 -0800 (PST)
MIME-Version: 1.0
References: <CABTNMG0zcoCqVue8-3cJQ+iTPkJAgjxEN4FB6_ASX2rgXbWunw@mail.gmail.com>
In-Reply-To: <CABTNMG0zcoCqVue8-3cJQ+iTPkJAgjxEN4FB6_ASX2rgXbWunw@mail.gmail.com>
From:   Chris Chiu <chris.chiu@canonical.com>
Date:   Mon, 13 Dec 2021 13:37:10 +0800
Message-ID: <CABTNMG1-ZzoKr024G1beGdZyNONbRp0_1mpeTRnDXcEuE_VNkA@mail.gmail.com>
Subject: Re: Discrete Thunderbold Controller 8086:1137 throws DMAR and
 thunderbolt fails to work
To:     andreas.noever@gmail.com, michael.jamet@intel.com,
        mika.westerberg@linux.intel.com, YehezkelShB@gmail.com
Cc:     linux-usb@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021 at 5:39 PM Chris Chiu <chris.chiu@canonical.com> wrote:
>
> Hi,
>     We created a ticket
> https://bugzilla.kernel.org/show_bug.cgi?id=215265 that is pretty
> similar to https://bugzilla.kernel.org/show_bug.cgi?id=214259. So I
> tried the patch on https://lkml.org/lkml/2020/6/17/751 but it doesn't
> fix the issue. I also tried to boot with the kernel parameter
> `pci=nocrs` but it changed nothing either. I attached the kernel log
> with thunderbolt dynamic debug on and lspci output on the ticket. Also
> tried to disable the intel_iommu, the DMAR failure seems to go away
> but thunderbolt still fails to work. Can anyone suggest what kind of
> information is required to help identify the cause of the problem?
> Thanks
>
> Chris

Gentle ping. Mika, could you give some advice on this? Thanks
