Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8752353DF10
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 02:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348752AbiFFAPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 20:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345690AbiFFAPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 20:15:33 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D51C218F
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 17:15:32 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id y19so25971827ejq.6
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 17:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a86dFrA2K8KFLQGTOqTrUMlYEox+AOFVEanULuwTYkA=;
        b=H92tXX1FUoCLFBrmhsASqAgtqal0q1BaHokM3sJhfBHKRTtIA6zm7vNvUXqJYIYszz
         QYCmMnnWVY/A/Mw5Cadr2i1+wyEGoXqNUkwTYx9MSqx5+kqqOEBDy90ozhzh61WPWz1+
         xcGKG9JO77zeS3ExHkqTeW7PDE31kM2sA01qY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a86dFrA2K8KFLQGTOqTrUMlYEox+AOFVEanULuwTYkA=;
        b=cTThRUxaUrG8+U6T0AlDW9KpghZpfpoL95JEbbumEkIjsyWNQ3y5dt0bNx3Tq1xX8w
         jK4Irbe1u2dFcPyjbFIqEMmi/a2XtwGTTKsaxh/PwFh2nhz/ZuVAgP5XbyJbI+9/V/zl
         ae6dC57eduo64Zit4qPkZD5l6bVxa2qdy8AJeI27JWhv0qS+tSmP9a877531yw6Y/Rwm
         ANTbUDD+skJc29OHDDrV8as7HxYQntXtQl/8KRjQrEbSl3rNocq3SfOSd2hfy9zr/3SB
         MuebdkpoPz22I1rEWT7pNL05laUS5HnI0KWSJOZiFJaoG7tlxQt6UVaRcnf5H5WXynVS
         P5Mw==
X-Gm-Message-State: AOAM5307elDHygY/xWPrIk206+VKaXA11T8JXLKr0poAtPB5FL7Cch41
        D+fC0b8l4+yNGFfE1CAVdga5J8WkeJnLUP5FdjI=
X-Google-Smtp-Source: ABdhPJzMRIRna0h2P2x50TPDwU4Wqhv7y/oNcG4MATqKmI827QROaYeiHWTDW6MhoQziEPwnQp7opA==
X-Received: by 2002:a17:906:d54b:b0:6f4:cea3:843b with SMTP id cr11-20020a170906d54b00b006f4cea3843bmr18290767ejc.40.1654474530534;
        Sun, 05 Jun 2022 17:15:30 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id y21-20020a056402135500b0042aa5a74598sm7948433edw.52.2022.06.05.17.15.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jun 2022 17:15:30 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id h5so17813062wrb.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 17:15:29 -0700 (PDT)
X-Received: by 2002:a5d:414d:0:b0:213:be00:a35 with SMTP id
 c13-20020a5d414d000000b00213be000a35mr13202054wrq.97.1654474529482; Sun, 05
 Jun 2022 17:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <Yp0AamPDLOK6mTIn@zeniv-ca.linux.org.uk>
In-Reply-To: <Yp0AamPDLOK6mTIn@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Jun 2022 17:15:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgj8Lg30YpGPK4D45VndfdU4a=8f3uf0EiXtHDSb5o0bw@mail.gmail.com>
Message-ID: <CAHk-=wgj8Lg30YpGPK4D45VndfdU4a=8f3uf0EiXtHDSb5o0bw@mail.gmail.com>
Subject: Re: [git pull] work.fd fix
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Sun, Jun 5, 2022 at 12:13 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> [BTW, what conventions are generally used for pull tag names?]

I don't think we have conventions.

There's a few common patterns, where the tag-name might be the
subsystem name, followed by the version number, followed by a possible
sequential tag number. So "acpi-5.17-rc1-3" or "powerpc-5.16-1" or
"net-5.15-rc8" or "mtd/fixes-for-5.14-rc7".

But another common pattern is to just re-use the same tag-name over
and over again, just updating the tag: "arm64-fixes" or
"clk-fixes-for-linus" or whatever.

In fact, the most common tag-name is just some variation of
"for-linus" (variations: "fixes-for-linus", "for_linus",
"hwmon-for-linus" etc etc)

It really doesn't matter, and your "pull-work.fd-fixes" name is fine.

                  Linus
