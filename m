Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087F158046A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 21:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236214AbiGYTUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 15:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiGYTUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 15:20:18 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792235FB7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 12:20:16 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id o13so304816edc.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 12:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XVDIZFYcquyDU30LBhCPD/PXD8V3Ex6g+/4Jt+pCRG0=;
        b=AzQOEmHT1inFFysvEynnDtRbqEeUYeR3B2ZfONqWXZGdpODf9tTWJBIMwQvdfinCE6
         8EN+GqBKJQTMGcSZ9cYlGyaoEZMlReop1K92FAHZ1Kc+VjrcDKpUg8JJP71bsnkzKbs3
         mRPrDdQCmFJwtfI+xqu7XqXj1zo3TG0h/Dd74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XVDIZFYcquyDU30LBhCPD/PXD8V3Ex6g+/4Jt+pCRG0=;
        b=CHxOrNLWBmasWz6AE/ABJ4cr/OFZpZRyuNdEUVooLS1BoZpPsaaM3MCpWPXezvF2Tq
         K3T/qWTNIhKcbEHOcX2mcVko35OJ1BsX3I1L4hY2ReJvqBleGecGpMtfEn3GscyVz3x8
         KTRyS1uqx3z/cAp0SQ3TzrOzZZUi6Z/9PcZUq6IENSdknn1AUML3BX5FD47uX6XNn1mt
         /51iWgHRvp8TXAjhJtZrEAdUDMsCtRnpc+apiCfD3zlnAz8asztarGwidCanD9jndofz
         Rz8Ikgx3TEH4DeUmxzuSDjIhg8mGtGNLhM7DlH/uAJAPULcav8B5nXT+zvFp1jfMw2E+
         8BLQ==
X-Gm-Message-State: AJIora+D7cpjORlcD8xrAZkanm3RVQrd9Zo1g5tNzRfzLZEhmRoP9Cyu
        7Eg8ItCS3oEy/5JLZzX20nwKZEieXtUsERY/
X-Google-Smtp-Source: AGRyM1sDvlwHrIqnJ0u0pCxE4l2MgrsW5Hj9qRH5eIKCpj7x8YwW6JEJ38pNVlbu2OoFiTXbGghXJQ==
X-Received: by 2002:a05:6402:280b:b0:43b:5d75:fcfa with SMTP id h11-20020a056402280b00b0043b5d75fcfamr14810093ede.114.1658776814376;
        Mon, 25 Jul 2022 12:20:14 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id t3-20020a05640203c300b0043a45dc7158sm7409738edw.72.2022.07.25.12.20.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 12:20:13 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id v13so9586069wru.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 12:20:13 -0700 (PDT)
X-Received: by 2002:a05:6000:180f:b0:21d:68f8:c4ac with SMTP id
 m15-20020a056000180f00b0021d68f8c4acmr8625583wrh.193.1658776813045; Mon, 25
 Jul 2022 12:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220725123918.1903255-1-mpe@ellerman.id.au>
In-Reply-To: <20220725123918.1903255-1-mpe@ellerman.id.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Jul 2022 12:19:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wihON4Ytte5zLHWNQtTapUvCpkToxY06OjX-_2B+Gq6Gg@mail.gmail.com>
Message-ID: <CAHk-=wihON4Ytte5zLHWNQtTapUvCpkToxY06OjX-_2B+Gq6Gg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Re-enable DCN for 64-bit powerpc
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, alexdeucher@gmail.com,
        amd-gfx@lists.freedesktop.org, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, dan@danny.cz,
        tpearson@raptorengineering.com
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

On Mon, Jul 25, 2022 at 5:39 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Further digging shows that the build failures only occur with compilers
> that default to 64-bit long double.

Where the heck do we have 'long double' things anywhere in the kernel?

I tried to grep for it, and failed miserably. I found some constants
that would qualify, but they were in the v4l colorspaces-details.rst
doc file.

Strange.

             Linus
