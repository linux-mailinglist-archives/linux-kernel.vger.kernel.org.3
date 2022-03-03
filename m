Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321C54CB437
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 02:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiCCBTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 20:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiCCBTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 20:19:41 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3377A292
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 17:18:57 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id y5so2821311ill.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 17:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cI9hnRkRgND1nAn9UCiZL4IHWAfS5xa6p9XyZVM0jIQ=;
        b=hwlCxjRFrjuY6CElpPLmzyx2+rkFQxN6FCSIvipOMLIbFKmfNA0vyxtM0sRtdcPmrm
         xdrnBECeuTyeOr4Rle0SwrrjWs+7xiSzukDOZHsQ9EsLRUJ0q8Np7nEPqVAeXRRXVhKb
         F15CfwFvFjREoS4ezN9q856jY0vv+XxMRkFa9/Symq3qcTFoQ91rCN2DzODYaXbVt2QO
         GKXVm++Dr2v4nh+6nBhnrJPKFhd10EqROj129MUEKBM4G7IpdR7+RhZcbSR8c8imZIy3
         sd0sZwnRPnKGmX+Mt+OGBs6yEUQAY4XH4gUFHJi+Fp4HBVGMRgI93wax8mMs2VYRm3tA
         pCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cI9hnRkRgND1nAn9UCiZL4IHWAfS5xa6p9XyZVM0jIQ=;
        b=fd43RW7IlCpmFjAXbkcKSmo8SaCg9yEpRkf2ekQQ9DWapuDEOQUW7KQyP8OuH8nKI/
         nGVTSrZL6oa41QRaC3bOhUQuPt7589unh9cjlPWFRyRaOnD34aita2SPYsgkq5Czc0Zc
         XcNNRToyGA71XEiDobIOIUhKmCvaNItFYq6mnKp6CZ+OphNddgkLddHWv0a/zrJOwIih
         qDqwM33iR07ZR9n44e/xqzlnvjXtpOJJxy47M2Yna2OVDK2PSB19mgxx1bBiICwh45c9
         FYYUSXk+220p8peiSSBjdBX3dOUNFSPM3nx3tu3PuVdVQhd3h1esbnJDnqnAvF9JoXhG
         MyBg==
X-Gm-Message-State: AOAM533hyM+PjjLxEZufJK9CTUHO91tQOj8lzYQMcCLxLQK2OqkGT1h3
        iSsPpuUlPFBhmPVXhg1PJtOC86VKuzhOg+6EHnosbC+f
X-Google-Smtp-Source: ABdhPJw6UF/NDC1bO/sl+wOqPz+B9k9ja352maEzhVypMkHFt9AhB41okw1311jL/bHmdUY8zi3z7s8FeAKfIUWW+fc=
X-Received: by 2002:a05:6e02:1bc5:b0:2c2:7bc9:8e8f with SMTP id
 x5-20020a056e021bc500b002c27bc98e8fmr29704192ilv.5.1646270336576; Wed, 02 Mar
 2022 17:18:56 -0800 (PST)
MIME-Version: 1.0
References: <20220223154718.83500-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220223154718.83500-1-andriy.shevchenko@linux.intel.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 3 Mar 2022 02:18:45 +0100
Message-ID: <CANiq72kNXwo7hpc0+XX_UsyT_3D9o=o0eVjqN-QtDd46kjdd6g@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] auxdisplay: lcd2s: Fix lcd2s_redefine_char() feature
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Lars Poeschel <poeschel@lemonage.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 4:47 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> It seems that the lcd2s_redefine_char() has never been properly
> tested. The buffer is filled by DEF_CUSTOM_CHAR command followed
> by the character number (from 0 to 7), but immediately after that
> these bytes are got rewritten by the decoded hex stream.
>
> Fix the index to fill the buffer after the command and number.

Thanks Andy, queued.

Cheers,
Miguel
