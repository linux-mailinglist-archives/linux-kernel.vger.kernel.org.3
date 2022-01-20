Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D3B495334
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiATR21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiATR2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:28:23 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0245C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 09:28:22 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id k31so18308529ybj.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 09:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K5kxtJVtF3SaErQNcU0YF44etjr8OoNxVIxLQIcs0s0=;
        b=PqgBMyGno5bkuq6yS2SgRqsITa8SCLYe4Y5r0Vvpk6N0GVUDx378Qh6zJ+XMuu0p/J
         xrttC/Os1WjFxmLCu7yZlJJnB6lHStZZUpn7gEt38OqH6gjFOXVZurCH1NDI0hEqVrFw
         CuupxOwqVW4nJRlwXNWFZyX6e9InGSxlBKlMeafU7nROV0gR1Ie+3wEMZeSnaIcTeG6+
         6QU2AqJf1FzaMnA5xIL8mYhMn5eJ4Dvo+/SqB6xxggTEHkVsVIaG9ri03qlTlO+Uvm1P
         K5yLyGAimi4vtEUNbLdkfbFqdK+HXIEeEZ0t3n8VI9e1XC4qO3qkV/LvEBoGeRUTA05a
         YEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K5kxtJVtF3SaErQNcU0YF44etjr8OoNxVIxLQIcs0s0=;
        b=a04RJnzucmw0gAzJxPvD9Z9Lo/rFHroBqIwl/zelnas5BrhJKH3TS7NICLrGp2sj0F
         fIKKfUA4YFFM6mPlVLQk/eb7TwIsGkHomsMarXQxV7rtb84NklrRc4o3ZztDdRIVjj0S
         LwzJxHEXsyY2yHPTItPpTfUqUmmAkvFb93DLa3bLjFCEI2r0s4+eJTVw/Y9dy209KeEW
         3KTY7aKm8+bzWhufsdhL9b20FjO7IUPwKv8fNUXY6of2E9WmQ427l7jc7IV47ebuiRFm
         c61lVs8KBcn4dMsTkynObDWlWlVrXeNSnXIhUxDA/QlRzWRSAX7s1m6VZ8dPZgSDUw0L
         CpHQ==
X-Gm-Message-State: AOAM530LUD9l3ED5WN+vKQx4brd3iDcs6P0xPYu1ZBswvsC8MR3GmMGU
        Oy1Bsla/0bzftFU0TfaNe8WYjl7vhwnPOc6o6bpNhA==
X-Google-Smtp-Source: ABdhPJyD12OQXWkGBGGACFai7X0br9OE/lh2j7Qt7WZjZ5D5U/g1rx+DHWdM+e3BCxhnNjNy2UhhzYVERrQ2OiRL5YM=
X-Received: by 2002:a25:550b:: with SMTP id j11mr102282ybb.440.1642699701974;
 Thu, 20 Jan 2022 09:28:21 -0800 (PST)
MIME-Version: 1.0
References: <20220120155517.066795336@infradead.org>
In-Reply-To: <20220120155517.066795336@infradead.org>
From:   Peter Oskolkov <posk@google.com>
Date:   Thu, 20 Jan 2022 09:28:11 -0800
Message-ID: <CAPNVh5eSZHkTXUHwao1RAgdqxLJD=92A=2CDE6AN1GUgJPJvWw@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 0/5] sched: User Managed Concurrency Groups
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, avagin@google.com, jannh@google.com,
        tdelisle@uwaterloo.ca, mark.rutland@arm.com, posk@posk.io
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 8:09 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Latest version, many changes since last time, still under heavy discussion.

Thanks! I'll work on testing/integrating this patchset. I'll also
assume that my changes that added blocked worker list
(https://lore.kernel.org/lkml/20220113233940.3608440-5-posk@google.com/)
and server kicking
(https://lore.kernel.org/lkml/20220113233940.3608440-6-posk@google.com/)
are acceptable.

[...]
