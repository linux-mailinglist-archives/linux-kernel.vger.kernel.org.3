Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11674A8C5C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 20:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353742AbiBCTTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 14:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbiBCTTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 14:19:54 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF23C06173B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 11:19:54 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id p7so8022593edc.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 11:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7cSZa6DBBFDOxX2GW/qnTrsYZ3zoJ+ZjemRz7cnhpqE=;
        b=fCNr7CPXFLdcVd8PjZvoiasGZnLEu8KQ/XZwbGLm+yV2wWLdo8/zz6Gwya8F4pMZH2
         9PrtXR7djkoDFL0VDJIh2cWDBzJnLY6/s1O7jndQ40X6X4ZFDpwZUZloZr6Vh92pTMZI
         G9LaPnBdpVo9UTRwk6KpYQEb8gnycoM8Dr+wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7cSZa6DBBFDOxX2GW/qnTrsYZ3zoJ+ZjemRz7cnhpqE=;
        b=4nhOnMECma3YP0E1rU5UilulZ+vu7/jDP7ECqBcR7aomEhaN4pg61AZfuZM8zW6VZz
         W9bs7bKtiuQqwxkOUcJjH1/pFaQuM/uVQGGSw0sQ78oSUYUTGU2ga5ebrU0yLP1Pwt4O
         sLP+4cL0R6F2SKPdDwDaffaCX4iURyEPN8y7DtZJcLYgxxhponlc+4Fzc1GvESQLhulq
         NCFgOGVrkshVdsTmA0e1bs1y9Nxq5cgBlkeEjHcTHng7W/dep0vRzLy9ZToFBEUrpVmf
         8ag5aMi82OSwVlGWaSGr5kkQvv5Y1RRNa0tFIdDxAYiSi4mGfMn3lM8YzPX7SD3N5Zvr
         KF1Q==
X-Gm-Message-State: AOAM533h8GapS/So1d9QFgnTRS0+Bc7phaChJb+1cClTs77DxvD9CePn
        8UlzZRsJTYI7IObatdvBRqo1HNVO+++qidDz
X-Google-Smtp-Source: ABdhPJyZ1JTEyo9QHKKYgGuknfCnCBrHbp42+IuJGTMU6QYWeIGWtKLz/Azy7T2av0HXfroY7sBdFg==
X-Received: by 2002:a05:6402:2807:: with SMTP id h7mr37491004ede.402.1643915992707;
        Thu, 03 Feb 2022 11:19:52 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id y5sm23328201edw.45.2022.02.03.11.19.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 11:19:51 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id w11so6981210wra.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 11:19:51 -0800 (PST)
X-Received: by 2002:adf:f90c:: with SMTP id b12mr29879801wrr.97.1643915991226;
 Thu, 03 Feb 2022 11:19:51 -0800 (PST)
MIME-Version: 1.0
References: <20220127233953.2185045-1-ipylypiv@google.com> <YflxP28HlVrrNBU2@slm.duckdns.org>
 <Yfly0P4e84373mGF@slm.duckdns.org>
In-Reply-To: <Yfly0P4e84373mGF@slm.duckdns.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Feb 2022 11:19:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg4Tk-cV=nQ2Xrj7P9wN-TxVCR5hjtW3iDpNyjW4x3fzw@mail.gmail.com>
Message-ID: <CAHk-=wg4Tk-cV=nQ2Xrj7P9wN-TxVCR5hjtW3iDpNyjW4x3fzw@mail.gmail.com>
Subject: Re: [PATCH] Revert "module, async: async_synchronize_full() on module
 init iff async is used"
To:     Tejun Heo <tj@kernel.org>
Cc:     Igor Pylypiv <ipylypiv@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 9:50 AM Tejun Heo <tj@kernel.org> wrote:
>
> BTW, I can route this through workqueue tree but -mm or going to Linus's
> tree directly might be a better option. Any opinions?

I'll take it directly. Hopefully nobody notices anything at all - but
if it causes unexpected serialization and somebody screams we'll know
more at that point..

           Linus
