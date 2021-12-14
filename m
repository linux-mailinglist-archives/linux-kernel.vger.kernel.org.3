Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E530474D72
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 23:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237855AbhLNV74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 16:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbhLNV7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 16:59:54 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63B8C06173E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 13:59:54 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id n15-20020a17090a394f00b001b0f6d6468eso2015420pjf.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 13:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JAkKZ0pCEv3Q9dRQXCjR7WNBgstwuomwVPeTmZilwdM=;
        b=epmDaQAc1Tnwv/IqFpqD04GLSyKU6BZbRqsIkeNJZcqg8WxloFt6JKmVeqBKdC0pag
         E22DDY/KsAzsEmsWSPx5BZMBORoXV4VkcxBapDIX4cNgg4WuRmZVF0KNopwFudymk6la
         IvUAMnvcgh+bSTs/bG/Mw8VdleyLabbH26g/whmruU4cWRPWYd2g10LH63B11fbZKdZV
         cGzQoL99bDBFnmTN8w3fchmmzGHIp6sWH5TuoM1OHHamPubuPFgPbAAMwM/Iy5J0qUVl
         p7jJpWi76iLCA8nsQEoE+f9zhf7oiYSu98mZka6NMjHBoP/3QVxds490wNJQGMHsrSHE
         5baQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JAkKZ0pCEv3Q9dRQXCjR7WNBgstwuomwVPeTmZilwdM=;
        b=eNUWd5f0s49u9aGGoJ2I57h50ABN3Of5P2srtl+E1tHruLqiNV9xNeW9hIAxpnmCp3
         8kjDpXWTiBp8AUlzADGiWq0ZZFU5j8yuFRUoW7o3G6PZlv2eo/idxGtuJkrW+BPts94i
         dfcdw1vd0/k2wBtZYXYKAr+9v3CzVciE7iXbMoUlfq83ERK8cN4LELkU8aZXVruHSzQJ
         LPzmlpAEUFLRQWPq2Wo+EFiemOWPc5W+u8smgASDMcKBAtOUbUGSqQdhxPRWv5Y4afgd
         i+NJi++K+cJ8TB5M+v9CVy/sJGlNyRb6xGf4T8l2vL09uVUkP9CcuFKIIh/kEyg/w+fr
         LXYw==
X-Gm-Message-State: AOAM531qxTg2h4VRzhPqH1+LLQuYyO7wrGA655FGxlitcXCX0Ch2GBkF
        YrQ1nMwNQ441PKZUMqX2892YWIn6VrXYtvAtN5Hbnw==
X-Google-Smtp-Source: ABdhPJyGUK0h6Wh7VqiiPsQQSvFrmSYbhLazhyAfbwYN1OyASyPfqefhfdfkam9JmIVbNzvh7towBLS3cbQ1rLNDV/g=
X-Received: by 2002:a17:903:1ce:b0:148:a2e8:2774 with SMTP id
 e14-20020a17090301ce00b00148a2e82774mr1443271plh.123.1639519193933; Tue, 14
 Dec 2021 13:59:53 -0800 (PST)
MIME-Version: 1.0
References: <20211212033229.527955-1-davidgow@google.com>
In-Reply-To: <20211212033229.527955-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 14 Dec 2021 16:59:42 -0500
Message-ID: <CAFd5g44t5zxuLQ1jLVz7iQ1jKzm017W+hKWTt1Fzx-izAbdeJA@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: tool: Default --jobs to number of CPUs
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2021 at 10:32 PM David Gow <davidgow@google.com> wrote:
>
> The --jobs parameter for kunit_tool currently defaults to 8 CPUs,
> regardless of the number available. For systems with significantly more
> (or less), this is not as efficient. Instead, default --jobs to the
> number of CPUs available to the process: while there are as many
> superstitions as to exactly what the ideal jobs:CPU ratio is, this seems
> sufficiently sensible to me.
>
> A new helper function to get the default number of jobs is added:
> get_default_jobs() -- this is used in kunit_tool_test instead of a
> hardcoded value, or an explicit call to len(os.sched_getaffinity()), so
> should be more flexible if this needs to change in the future.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
