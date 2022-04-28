Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC01D513A47
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345680AbiD1Qtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbiD1Qtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:49:49 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145084AE2E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:46:34 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id h29so2406751lfj.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nUCMX2s+rfJjnCRjPBsqTrvIeHc/xB8tXJiukV/x6uw=;
        b=CFs7namgLcbBdzCbwOWn2HbPugYal+FkQVh5xTQTuNZ4X2cDs80Xv/mDS6+440fwDi
         CC2DbosLjDm+BxDHJcapajycT4b0+dLD2PsDJ3JXhK3ksFxCFasZN9PIAY59aQp8gteJ
         Xpt91Gtmx1ig/8drEurcSZU7ZSUfFnYJPjHFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nUCMX2s+rfJjnCRjPBsqTrvIeHc/xB8tXJiukV/x6uw=;
        b=osI4qx6eqkhwXTCSG0MSBp0Yifu59IFX9HyZaDn6OoRvM538leuRxpikpqO2obHbsv
         7OJJKZ3ZJD79d7o2cC8xmzXZnD3v33/betwkm+q6yfzjiivsritwgczfwxkK2NK6xcCa
         M6gOa/96fezZ7I0O6Xh/gAHuDgWQgEeaRAdACDynkedSsyW3uWM5Y10iBwmct8kV9akK
         jQrgz+xea+r+06NElVU78hxRo/NlYJa1ul+wb6YK/FXWGBTzRyFk5Ef7L/1+kM0Y+w8H
         vh6yGiKHS+RN27ZXfuK35k0wXC80LyO5UOI09rSKAE8d91GSrLetX//I+ZjpS69ScKxl
         K45w==
X-Gm-Message-State: AOAM531Hdw6stGef8g+r+q2e0NJyLHd1fsNnLbnbCnLwnuAxZmN3nJod
        uEdOz4T3OwdBt1xjqGPpus77kp+0SvoQ/ZuSZ/w=
X-Google-Smtp-Source: ABdhPJxFSt32ZXDzw+Iq2hduYQ7ksquI7n1Q3hw0lOIAA/uZvsU2yYNQEQZK+pxzJOIh8C2myO8aAA==
X-Received: by 2002:a05:6512:3b0f:b0:472:807:50c7 with SMTP id f15-20020a0565123b0f00b00472080750c7mr14628129lfv.395.1651164392004;
        Thu, 28 Apr 2022 09:46:32 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id g4-20020a19e044000000b0044abb73ada2sm43635lfj.139.2022.04.28.09.46.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 09:46:31 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id p12so9672966lfs.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:46:30 -0700 (PDT)
X-Received: by 2002:a05:6512:3c93:b0:44b:4ba:c334 with SMTP id
 h19-20020a0565123c9300b0044b04bac334mr24872519lfv.27.1651164390506; Thu, 28
 Apr 2022 09:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220428061921.GS1098723@dread.disaster.area>
In-Reply-To: <20220428061921.GS1098723@dread.disaster.area>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Apr 2022 09:46:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVgPPczqyLyOg8fmGYc1z+-ngPKkS_bCTwefcLXfp4CQ@mail.gmail.com>
Message-ID: <CAHk-=wiVgPPczqyLyOg8fmGYc1z+-ngPKkS_bCTwefcLXfp4CQ@mail.gmail.com>
Subject: Re: [GIT PULL] xfs: fixes for 5.18-rc5
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 11:19 PM Dave Chinner <david@fromorbit.com> wrote:
>
> It's all minor stuff;  a 5.18 build regession fix, a deadlock fix
> and an update to remove redundant fields from the XFS entry in the
> MAINTAINERS file.

Done.

I had to look twice at that patch going "why does it complain about
the xfs flags thing" until I realized it was due to XBF_UNMAPPED being
(1 <<31) and the compiler then seeing explicit negative values being
assigned.

We have a lot of "int flags" in various places, very much not just
xfs, and yeah, we should probably try to clean them up.

But 99% of the time it's just not worth the noise.

And xfs only hit it because you guys literally used up the whole 'int'
for it, normally the compiler won't make a peep about it.

Thanks,
                     Linus
