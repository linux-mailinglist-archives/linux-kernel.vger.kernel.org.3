Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016D648BAF9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 23:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346663AbiAKWus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 17:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiAKWup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 17:50:45 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5CEC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 14:50:44 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 30so2368540edv.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 14:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TNBXCYqAbCG8XGgF3AD41O6G3Tty70mhgtonG5svnYk=;
        b=gZ+5Z9WhOC5KegT72NE06b2KLiaiJYOyx2Gols4RTE51HmPMRsTzxlNgT5utxbbuRV
         vR2Wk0orG8dnZi1vnNvmSKq5uagt27ExpCsI1Ol9d0JEAML8GnSVKhYJq5crG/o/pnFk
         HMgjHNmxIVzcGQ7pmu1hROWoxzapDkky2vOpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TNBXCYqAbCG8XGgF3AD41O6G3Tty70mhgtonG5svnYk=;
        b=p2DguiwQLX3qJYt8Ab9J12xKmV9uoa5OE7lTzhQOtQrCoMMgKcDv8QgqM7jv9WSx67
         NRiBbkkJixeeHi/ZSBxDUT93xIzXDmYhtHZX66L1zRO8T/RnwO7fgNp9uJ87HpxJCRrM
         NxJ5kb1dLz/QPiVUYPazM/NWFi8+ZUlRIhBDQAMXQHpY8h01qfeeZyF5Jye0tH7NGTtx
         3VbY+ZSjw8IXObgeZ5bIjBFHK1cpOb1FU3xHyAL9PTpRh98aNWSCRmxNnTiUr0i6sZHk
         txtz3xjV3sCqmh0XMu4hTxrbfjwZTsasYll5hkF2YOAe98IhZgfIOJZWBWETYGipdBTU
         VEhQ==
X-Gm-Message-State: AOAM531tS5udAzZZeR64a4V/naAUgO1kxrqKU4rDCQUo906kxa2cSKdA
        czOeuZrUu1mE6pwQIjOr5PbNujHU6zezCaI87Zw=
X-Google-Smtp-Source: ABdhPJwndM5/e/xsOOYUkQmafaIHOiYTOui3apjYRqSLzK0YI67Xb4EvyOxsap/NxyYse/m6K8oZtg==
X-Received: by 2002:a17:907:3fa0:: with SMTP id hr32mr5539305ejc.196.1641941443335;
        Tue, 11 Jan 2022 14:50:43 -0800 (PST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id ky10sm3937203ejc.151.2022.01.11.14.50.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 14:50:42 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id h10so973586wrb.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 14:50:42 -0800 (PST)
X-Received: by 2002:a05:6000:14e:: with SMTP id r14mr97335wrx.442.1641941442441;
 Tue, 11 Jan 2022 14:50:42 -0800 (PST)
MIME-Version: 1.0
References: <20220111215431.GA2609427@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220111215431.GA2609427@paulmck-ThinkPad-P17-Gen-1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Jan 2022 14:50:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi9_UKV6Dkroz5O11+P-=sw+gu5z2RJTmdGuRE4bBxBGw@mail.gmail.com>
Message-ID: <CAHk-=wi9_UKV6Dkroz5O11+P-=sw+gu5z2RJTmdGuRE4bBxBGw@mail.gmail.com>
Subject: Re: [PATCH] drivers/pcmcia: Fix ifdef covering yenta_pm_ops
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        caihuoqing@baidu.com,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 1:54 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Currently, yenta_dev_suspend_noirq(), yenta_dev_resume_noirq(),
> and yenta_pm_ops are covered by "#ifdef CONFIG_PM", which results in
> compiler warnings in kernels built with CONFIG_PM_SLEEP=n and CONFIG_PM=y:

Hmm. Wasn't the pcmcia tree in -next? Or how did this get missed?

Anyway, applied directly. Thanks,

            Linus
