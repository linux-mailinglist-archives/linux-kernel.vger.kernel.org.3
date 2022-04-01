Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212EC4EFC4C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 23:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352918AbiDAVnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 17:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349348AbiDAVnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 17:43:37 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3778C266B66
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 14:41:46 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 5so7257224lfp.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 14:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MT/2MfbqPGvZ30GWatbUy2aJHfFDnuIQO2CEVbrFW6g=;
        b=aPw5tP3eS+RHs6l5QtI/rS6qiFIMGaSJgRjH2u+dbnLr8G3AwOcbqSEeycd3dk6vUK
         DIHf6/HV4Ap4xd1LzTzzGje2odmr9e+hYLQv0MgEFOe4NRpB/Z0JKJ+f+zaANr9KHs2v
         C6SW2Y+tIGz2xtDUqP9+06PDqrtHKH1zqDyMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MT/2MfbqPGvZ30GWatbUy2aJHfFDnuIQO2CEVbrFW6g=;
        b=EQ+EJqdoTsLNm7QYwRHhEJiMh0JSb03xnuQ3YN+488G1BlddVdBYmJ4zyVAUMdyVqr
         kP3KrgdiZlCcUTQPXQ5WrA1PeVEVLQkoCdSVqV/mU58uSJ4eXozj3qSfb/br47n85hzT
         Nd5U2hGky84AcyKauc9OBoQE7wmJ7oV7uytwjIXp7NBGlC4W0ALhnFnegrTYr7k4Qgsk
         T5pReuJfD/b8Ld03pCLbbS7kLYgqdGF7RXfKq7z28KbT+t9LRIjby3IHRBinDhEMczmJ
         4nkOUfU5nqWOsR01GzBF3qNMaS7ME2aAHG9boFRrteKkwoTihPiePB2NXkdOIlvhuJU7
         ntfg==
X-Gm-Message-State: AOAM532nJ/vBcJX76Ga76JV5Bwt/KCuIrE4fUXUtSDhluw1lNkunYvSo
        NVxc7X1OPYOcm/r0pokP+MHfDQQ7lTtwMQo2mtY=
X-Google-Smtp-Source: ABdhPJzbnSovymBX8KXbvFQfaPu49iOr7oVn5FbxytS7jS5DIzHTVzJS9jmXRk1gXaN+CSev++sqHg==
X-Received: by 2002:a05:6512:3da8:b0:44a:73a4:3371 with SMTP id k40-20020a0565123da800b0044a73a43371mr15911355lfv.72.1648849304962;
        Fri, 01 Apr 2022 14:41:44 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id i16-20020a198c50000000b0044a2580a2d3sm349433lfj.156.2022.04.01.14.41.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 14:41:43 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id q5so5529719ljb.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 14:41:43 -0700 (PDT)
X-Received: by 2002:a05:651c:1213:b0:247:e2d9:cdda with SMTP id
 i19-20020a05651c121300b00247e2d9cddamr14876542lja.443.1648849303035; Fri, 01
 Apr 2022 14:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mvE6YuhkO0AaPtmzA4V22T_T-bz7ttKbvgtqo0My68Kgg@mail.gmail.com>
In-Reply-To: <CAH2r5mvE6YuhkO0AaPtmzA4V22T_T-bz7ttKbvgtqo0My68Kgg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Apr 2022 14:41:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg8snck485CvOK9CTXbTto3Lmf2eCRaoH5pGk6-1mCkVg@mail.gmail.com>
Message-ID: <CAHk-=wg8snck485CvOK9CTXbTto3Lmf2eCRaoH5pGk6-1mCkVg@mail.gmail.com>
Subject: Re: [GIT PULL] ksmbd server fixes
To:     Steve French <smfrench@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
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

On Fri, Apr 1, 2022 at 11:40 AM Steve French <smfrench@gmail.com> wrote:
>
> six ksmbd SMB3 server fixes
>
> - three cleanup fixes
> - shorten module load warning
> - two documentation fixes
>
> Does not include the dentry race related changes which
> are being reworked by Namjae.

Thanks. An updated diffstat would still have been nice, though...

But I've pulled it, no worries.

            Linus
