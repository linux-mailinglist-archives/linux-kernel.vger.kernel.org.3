Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6774976D3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 02:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240686AbiAXBCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 20:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbiAXBCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 20:02:41 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF07C06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 17:02:41 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id y17so970334ilm.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 17:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hp2+Bc+7lBobJvQ77LxVZGDxpdgdNERerPYGvuDrr/U=;
        b=Dt74wb+wtVXoKWbJ1AcDyLCOwuhefJnDKItBPvLZqPd72Cha5NEvIqs72g7/PUpinH
         qyuyYeOlSWxoC08Tg5cfN+EV35LdtsDIji6ToM+xW7w9TUK40Z9QVdE7ktWKUa4mHg6S
         Zl5rZMHJS1jEYFZ3/yLsd3SPm0tLNnWJ9GkCNTGbJDGmAOJYbl1WoQA+797dvZWEFa0V
         bYZNlMw+KPQ9rmofy53ChK0fF9zlSNNhWqNWnH0zKwp5jq8IFfqxvne3i6K21Pa/m4aL
         dDZHbW6XtKhmCUhmQ9baNNcQUIS3rPw+qph60EmNCY9PkS4w4jdPDGuK9MwOPsbSvfXY
         l+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hp2+Bc+7lBobJvQ77LxVZGDxpdgdNERerPYGvuDrr/U=;
        b=P/rQ5qVOdxysgrP7cr1Qdcf6nKCiEaleWHYWiPbaUhwq9Zj7EoeLpbM2yTswJZhL7h
         Fi3Rcz3nWUCozOYGgD3oi8ev0St43b+GYQy3niUGyZIAzQ905RztaE34JACFHA8BlPmX
         +AYzXmqA0UUbJ4VIE8JcOaTVLJLfzKRwNZs8KxEY++73owv98C64h4CjPt9KPcsy2NJ3
         J0GmIV62fcNILLHwJF7cju9GnhMypONbxuw+baehVKiY9NnPBubDSNBCYjW6gD5Y45B0
         iTs34B8gxkkpHcyqPQOLis759gPzO1Ilh4735efI2H5WjLKVegbCCfP13R52XaY4iLrv
         fcxA==
X-Gm-Message-State: AOAM532fkn6ysUNmm3f6uwXXg1DEBn4B4/6HLhMujFO8ZnFJzrHlF/wQ
        VXrXRw/h4Qz87CrciNP0e6BiDjfGh0b4a1KvKQ==
X-Google-Smtp-Source: ABdhPJxvTpFee6TtGTJYIa34pLKJQ/RHZqDMFfA8xdwmX8H0lIF2OVGg5HAHdvd8XQBo8H1+awFAzT/I6NKfZK3v3nw=
X-Received: by 2002:a05:6e02:1a44:: with SMTP id u4mr7204847ilv.259.1642986160747;
 Sun, 23 Jan 2022 17:02:40 -0800 (PST)
MIME-Version: 1.0
References: <20211014024155.15253-1-kernelfans@gmail.com> <20220117101910.14999-1-lecopzer.chen@mediatek.com>
In-Reply-To: <20220117101910.14999-1-lecopzer.chen@mediatek.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Mon, 24 Jan 2022 09:02:29 +0800
Message-ID: <CAFgQCTtBXWd_+13-AR8LWjLbWq9rX6kAjFmMCC=WpkzmtD-3Og@mail.gmail.com>
Subject: Re: [PATCHv3 0/4] watchdog_hld cleanup and async model for arm64
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Wang Qing <wangqing@vivo.com>, Will Deacon <will@kernel.org>,
        yj.chiang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 6:19 PM Lecopzer Chen
<lecopzer.chen@mediatek.com> wrote:
>
> Hi Pingfan,
>
> Is this thread sill in progress?

No, I am working on other topic at present, and this is not in my
queue in near future.
> We are looking for the upstream solution for ARM64 Hardlockup detector.
>
> I'd appreciate it if someone keep working on it,
> if not, I can take over it.
>
Be my guest, and hope you have great work. We badly wants hardlock up
detector on arm64

Best Regards,

Pingfan
