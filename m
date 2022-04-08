Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1524A4F8ECF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbiDHFpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 01:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbiDHFpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 01:45:01 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CA1198507
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 22:42:57 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id bx37so10106668ljb.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 22:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R+HXRFmonCLAOKu7Tx1l0IgtdhflHf7kEkD9u893yPQ=;
        b=gVIdhhP4ICXLdTOfdrNFbOA+Jr/YPS4zvSK1bSFU5CR6vxifk/0LBMAXt4iCloTQVH
         0sGrq4tKJ5z2d/0OqWbmPvp1I4RhBoWno9HgRgIYg/PFnPfeUuUI5XJd53FSZPqVMA0x
         A+3kUSdSMSVb1XBETA29zYZxNikCFwkKpRWM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R+HXRFmonCLAOKu7Tx1l0IgtdhflHf7kEkD9u893yPQ=;
        b=htcgvmn4RIGcxcrHD7Wv3rD1jBMtvnmLXDvgYdSk24rdJ/7q4KQOd0ZKp0J2cvaTZ6
         6Yi0Kwam94SuAkPZjET5vC/ND9uvS6jtv+b7QnrudNjMHP77PRUg7YbPe1T6lUN3lqma
         y6LEvDzAvzkGqzItkwHnqwL6XNkpQ5qLdxkzUTbAfzHVxyfbd9+gZZfVpmaQDxuWMS37
         hRElEscmOsTEhvpPihevSP+iqBEFvUF4ymVOqTBSKAnq5ktPJlQDl7hw96fvRbQIEW7U
         NCGJS6tNzdqLvDEBJzZBrhw3QNPZjQew2iyGeYsqlgadqFVEO7vW7uCVaktC5YrPnaSR
         73Gg==
X-Gm-Message-State: AOAM533ocS0ix/Iyq8I0Oai/3v5lER6IdDbyt81R3In27TR/DwMe1LW+
        uyPwgppy+JhgvoJLzr6nhKM+An7nlVi/jnnv
X-Google-Smtp-Source: ABdhPJzcgcAXTU3Y5OLvrcQPUdUphPY6ezUuNsHrivhXZBs2N05Z3g2CxAB1RcyS3bCWuO3cEeA6ng==
X-Received: by 2002:a2e:b008:0:b0:24b:4ff2:5e09 with SMTP id y8-20020a2eb008000000b0024b4ff25e09mr963927ljk.28.1649396575570;
        Thu, 07 Apr 2022 22:42:55 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id t2-20020a2e2d02000000b00244dc8ba5absm2140973ljt.117.2022.04.07.22.42.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 22:42:54 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id bx37so10106598ljb.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 22:42:54 -0700 (PDT)
X-Received: by 2002:a05:651c:b07:b0:24b:4af9:828 with SMTP id
 b7-20020a05651c0b0700b0024b4af90828mr2474847ljr.506.1649396573727; Thu, 07
 Apr 2022 22:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tx5F2iOY6S4o2Rjk3uZG_M5Tso+=j3_gyQk-p3vj8tqew@mail.gmail.com>
In-Reply-To: <CAPM=9tx5F2iOY6S4o2Rjk3uZG_M5Tso+=j3_gyQk-p3vj8tqew@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Apr 2022 19:42:37 -1000
X-Gmail-Original-Message-ID: <CAHk-=wj_=LwGgPVfnOdEJF5O2rt2NEXCK5155v88eDHdGkWOWg@mail.gmail.com>
Message-ID: <CAHk-=wj_=LwGgPVfnOdEJF5O2rt2NEXCK5155v88eDHdGkWOWg@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 5.18-rc2
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 7, 2022 at 2:20 PM Dave Airlie <airlied@gmail.com> wrote:
>
> I think this should fix the amdgpu splat you have been seeing since rc1.

Not the machine I'm currently traveling with, but I'll double-check
when I'm back home.

Thanks,
                Linus
