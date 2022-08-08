Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6C258BE90
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 02:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiHHAuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 20:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbiHHAuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 20:50:08 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600DDAE78
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 17:50:07 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id k26so13852137ejx.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 17:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=El0w/hoMnzSDGmU5ibq9FY56geqHKQRee2RsPSw/7eQ=;
        b=QTviwmgkNUM25+yyvspcdnCRYWB8gHVlkTZCk0NUatTKsxl4CSLP+CyjDf9urgUtYR
         gf6KN1x/0Cj/wVY4CYxS4ZUx/dOpRGVnKs6kIa24azs6dGm2xGfb353JAOVh199XZvy/
         jsK6k0KK2d6JOuMOERPP7hvjO5KNW9O3lD9TA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=El0w/hoMnzSDGmU5ibq9FY56geqHKQRee2RsPSw/7eQ=;
        b=l0f/K/1WrlhEvIp+Dk3mozGnn5h29n2rGUUiuY1acGvy+61SjYUHXlUfIwraBixLGk
         YHiom6msA7cOcdDZKM0k5b87AjQsgVLcycJGOpJLbx9goLbIsJbeNcjFLWvxVCVSjZTZ
         wtRYa0hZGaA2WICpfSIpAbZxjyrjRfSAdEq50L/oOeXrHpQDdif5JQ789jz26B1sWnXO
         oIVQrlmxNFm7ZAf2wfQA42dScM6XQqRLNIWrVZpd6laPDoxNbecZJ2R9Uc5FVK4MAdiA
         ykUHtpQmqyJM4RucrMzR+jEOQpJeprlXo2BgkytElXci7xZX8QvhdjDPT7qxIPv1nqHQ
         tgEQ==
X-Gm-Message-State: ACgBeo2QPPcA9J/BFnBs2ffQXqycpA9vnUXUxuRqWOVKE6ChgAhFAAlS
        L8t+36zzu6Uzcok0TwuynMlRppiuqZdcf5Y6
X-Google-Smtp-Source: AA6agR71th2T4fjXQJ3ODMI7lTNwdPuPGdYDyPB2JPbA6e2dQVJjRoiDGeQm1F8ieA490SSpDv6RBw==
X-Received: by 2002:a17:907:1361:b0:730:8f59:6434 with SMTP id yo1-20020a170907136100b007308f596434mr12419815ejb.745.1659919805641;
        Sun, 07 Aug 2022 17:50:05 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id w3-20020a1709067c8300b0073093b588besm4403888ejo.170.2022.08.07.17.50.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Aug 2022 17:50:05 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id z12so9195051wrs.9
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 17:50:04 -0700 (PDT)
X-Received: by 2002:a05:6000:178d:b0:222:c7ad:2d9a with SMTP id
 e13-20020a056000178d00b00222c7ad2d9amr2821440wrg.274.1659919803908; Sun, 07
 Aug 2022 17:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220805022940.1637978-1-yury.norov@gmail.com> <87edxtaol6.fsf@mpe.ellerman.id.au>
In-Reply-To: <87edxtaol6.fsf@mpe.ellerman.id.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 7 Aug 2022 17:49:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=whsgbpbVC_+V-dxuPbQCPV1eFQG00TrQvJcjYAXVHdswA@mail.gmail.com>
Message-ID: <CAHk-=whsgbpbVC_+V-dxuPbQCPV1eFQG00TrQvJcjYAXVHdswA@mail.gmail.com>
Subject: Re: [GIT PULL] Bitmap patches for v6.0-rc1
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
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

On Fri, Aug 5, 2022 at 11:11 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> This pull request has a conflict with the random tree in some powerpc
> code.

I noticed.

And I tried to do a cross-compile, but with my update to F36 the
powerpc64 cross-tools seems to be very broken. I get lots of strange
errors like

    Cannot find symbol for section 11: .text.kgdb_arch_pc.

and I have no idea why.  I used to have a working cross-build
environment at one point, but now it just gives me lots of errors.

The gcc plugin situation also seems broken, and I assume it's just
more of the same breakage.

End result: I tried to make sense of the merge conflicts as best I
could, but I might have completely screwed it up and wasn't really
able to even do a test build of it.

           Linus
