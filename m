Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDD44CB412
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 02:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiCCAvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 19:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiCCAvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:51:52 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD6645AC9
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 16:51:07 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id u11so4678988lju.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 16:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WKFSF7MRn4RD8kJD0JeqBVCVJ3EJ3QGDTxIuE+JKKlc=;
        b=N4W/mHdUxMLhKDYm4EXBOpGR1LzgGEbDRtFg8Uw+7ULGn1zMR1qVw8F12LuDfSX7WM
         +UZpXxAH2RlpXEr1DSYOoRjl973nvFkn6xR3p4/F28kuztWFRkyXsWogbSguSXKA8Llw
         Gzv+NYJiwhY9x1qWLL/y5bct3E9P9S+LJO7/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WKFSF7MRn4RD8kJD0JeqBVCVJ3EJ3QGDTxIuE+JKKlc=;
        b=wN4COx4b5dAHSzAIuAfEL72Anrig1qERH7peDzEqJt/24me+aHEu5gjxaPQZKFavy1
         puMKPUZGu7iZczxRPofP4sr8joOCS6hswQWbtT63QhEIFtVAg69+QMEo1p7lLkq71/1U
         Eh2alTgbxaI/IvqVFWVFjkowwQDW2F03PwaTBROZZrYaBO8JMwzLsY9kYBZi5Hl41dQM
         Qa3Z0GZjP5JC24h1ZtwCDJ7ssEoFGcr451bktxdv00/fBSdMeND9c2JgmROvWIYa8cuu
         zaJk5JxkK+j+szYtkrrAo7Mt8rWUlkKQ72ztdaLTQ4fXW8EmJJwn9vjsHQmOSd7JtcoY
         uyoQ==
X-Gm-Message-State: AOAM53260HLor+G7YcGKIcIdsLDja/ZOaP02n9w+Jz2rRA1/hrPb0l7f
        eJZ/pdqHQVpegRNhgvwoNLDTnEbRclXshHNx9Bs=
X-Google-Smtp-Source: ABdhPJzZ4tnWWCivjhfti3Z8C+iB3Rjeoudor3IlRU/v3lCGHHDDkhl4IVooJQR5YqI8WIi6EP0Xaw==
X-Received: by 2002:a2e:8795:0:b0:246:485b:9a2f with SMTP id n21-20020a2e8795000000b00246485b9a2fmr22720665lji.283.1646268666099;
        Wed, 02 Mar 2022 16:51:06 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id o3-20020a2ebd83000000b002461808adbdsm102659ljq.106.2022.03.02.16.51.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 16:51:04 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id u20so5741557lff.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 16:51:04 -0800 (PST)
X-Received: by 2002:ac2:5313:0:b0:443:99c1:7e89 with SMTP id
 c19-20020ac25313000000b0044399c17e89mr19366064lfh.531.1646268663457; Wed, 02
 Mar 2022 16:51:03 -0800 (PST)
MIME-Version: 1.0
References: <CAJjP=Bt52AW_w2sKnM=MbckPkH1hevPMJVWm_Wf+wThmR72YTg@mail.gmail.com>
 <CAH2r5mt_2f==5reyc0HmMLvYJVmP4Enykwauo+LQoFGFbVFeRQ@mail.gmail.com>
 <CAJjP=BvNVOj3KRnhFgk6xiwnxVhxE-sN98-pr6e1Kzc5Xg5EvQ@mail.gmail.com>
 <CAH2r5mvsetx5G+c=8ePh+X8ng7FvMrnuM9+FJ4Sid4b3E+T41Q@mail.gmail.com>
 <CAJjP=BvqZUnJPq=C0OUKbXr=mbJd7a6YDSJC-sNY1j_33_e-uw@mail.gmail.com>
 <CAN05THSGwCKckQoeB6D91iBv0Sed+ethK7tde7GSc1UzS-0OYg@mail.gmail.com>
 <CAJjP=BvcWrF-k_sFxak1mgHAHVVS7_JZow+h_47XB1VzG2+Drw@mail.gmail.com>
 <ebf8c487-0377-834e-fbb7-725cceae1fbb@leemhuis.info> <CAN05THRJJj48ueb34t18Yj=JYuhiwZ8hTvOssX4D6XhNpjx-bg@mail.gmail.com>
 <f7eb4a3e-9799-3fe4-d464-d84dd9e64510@leemhuis.info> <CAJjP=Bus1_ce4vbHXpiou1WrSe8a61U1NzGm4XvN5fYCPGNikA@mail.gmail.com>
 <fe156bb6-c6d2-57da-7f62-57d2972bf1ae@leemhuis.info>
In-Reply-To: <fe156bb6-c6d2-57da-7f62-57d2972bf1ae@leemhuis.info>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Mar 2022 16:50:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjSBvRk-ksUBOiQzJd=e19UZKvOSZs1UHahK5U0QVh6RQ@mail.gmail.com>
Message-ID: <CAHk-=wjSBvRk-ksUBOiQzJd=e19UZKvOSZs1UHahK5U0QVh6RQ@mail.gmail.com>
Subject: Re: Possible regression: unable to mount CIFS 1.0 shares from older
 machines since 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Davyd McColl <davydm@gmail.com>, Steve French <smfrench@gmail.com>,
        ronnie sahlberg <ronniesahlberg@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 1, 2022 at 10:58 PM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> Thx for the update. I pointed Linus towards this thread two times now,
> but he didn't comment on it afaics. CCing him now, maybe that will to
> the trick.

So I have to admit that I think it's a 20+ year old legacy and
insecure protocol that nobody should be using.

When the maintainer can't really even test it, and it really has been
deprecated that long, I get the feeling that somebody who wants it to
be maintained will need to do that job himself.

This seems to be a _very_ niche thing, possibly legacy museum style
equipment, and maybe using an older kernel ends up being the answer if
nobody steps up and maintains it as an external patch.

             Linus
