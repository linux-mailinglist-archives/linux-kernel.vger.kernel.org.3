Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7414CB435
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 02:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiCCBUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 20:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiCCBUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 20:20:19 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15515D04B2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 17:19:36 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id c23so4101837ioi.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 17:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2BhmaRmYMwsDXMOGXqzs2oLmHsIhmCbTH9eQZva/pJw=;
        b=kNw3rAoqo+2XZvdIHomz64pvqIfkAMETqMITBZyL8OEtmLeMoNoVWNzVPLbBi0uhn5
         DuE/xYIl9e+9097UJrx+X8Xj7VPWKDmn+iOobdRNCxt4TqwU89WnizQsDjTJU0G3GxH6
         b7EfiQqrvhlnyVrniLpJLx9Pqm5Uv2o0ZBB1mEq07C7Jm7fH63tl++Mzmi+vPYHpU+mj
         c/pfp+wujPXvfwLHKW5nr6TbQSL43bk2FYA73c46W0OtUaMx/8qVXu+gf4u+zgI3YqoR
         Lk0CY3Lwrd/93y6/+ihkjO2dWXw2FfyFeql+ZWv1cKY3/hpgswFaNv9qinPGg87fi4TR
         RrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2BhmaRmYMwsDXMOGXqzs2oLmHsIhmCbTH9eQZva/pJw=;
        b=JHAWihW3nY81MxXIYdcasWUbvIX9TUr1Y4d0K+WcToRKvW2p6fR1nu596ANc4WXkWN
         O062UaeUD57ua+p5Lf11dnshB22jIZHcxz47RqnzpaPZtYvTQYGLm1OHGK/Irwfmoo+S
         UEwqQIFRb4xMLwnac0Lk39CeIxGoFCijLyBs3Qm+OpDgLfe4OQSW8ck8BkLZAiuUoXbA
         EZNw5S2zL+QGV4Zv1I8Ul+pi4MBiDfmSRBtxGobpcZcOOnfUFRfGMqVoh5h+HoFnBmW/
         JlvvPC+9jNtZgn4jkQbTGL4kXqnBjR+YTwxz/Qm/PRZh2ITozUfoodeqwm331TAW7Z2s
         KLDg==
X-Gm-Message-State: AOAM530dq3/4MDzojVdqP1fkERlOQtvkPTcLy4KFtRsqHBBVBRTFMsc9
        PdB8cZf/tzT02R1fukSFqukvbH3GyPujoT883+Bf8W2+fnM=
X-Google-Smtp-Source: ABdhPJzcwQ4PGFqO3cIk6IPiGPojtj10W5n1ah9y/D1T4iyI8Nw8gNbuJL47TYwmCjP5998JkHepATT0bRCcx/Eryw0=
X-Received: by 2002:a05:6638:328b:b0:315:3802:697 with SMTP id
 f11-20020a056638328b00b0031538020697mr27659220jav.308.1646270375499; Wed, 02
 Mar 2022 17:19:35 -0800 (PST)
MIME-Version: 1.0
References: <20220223154718.83500-1-andriy.shevchenko@linux.intel.com> <20220223154718.83500-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220223154718.83500-2-andriy.shevchenko@linux.intel.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 3 Mar 2022 02:19:24 +0100
Message-ID: <CANiq72mkmDYm1bxryS0Yknm9=j+nK7RhDKP9oGf1-6vVNp_rbQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] auxdisplay: lcd2s: Fix memory leak in ->remove()
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
> Once allocated the struct lcd2s_data is never freed.
> Fix the memory leak by switching to devm_kzalloc().
>
> Fixes: 8c9108d014c5 ("auxdisplay: add a driver for lcd2s character display")
> Cc: Lars Poeschel <poeschel@lemonage.de>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks Andy, queued.

Cheers,
Miguel
