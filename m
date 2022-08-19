Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470FA5999FD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 12:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348381AbiHSKhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 06:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348258AbiHSKhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 06:37:36 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2822FE8320;
        Fri, 19 Aug 2022 03:37:35 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id d1so3083145qvs.0;
        Fri, 19 Aug 2022 03:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=lokJF4O6M03HHXPKpndOhYyclhs0ThFtf9qgupdJTnM=;
        b=aZ2WH8DU2MA3OKLch6q/LsNYENx2QyqJfchwoSdSgbsMeDVL7bcXtvgC1uHp1BDs5j
         G4dA4QScIyV/GEsD8TKcw3FMn3fdh8kf2YOKukLkQ1ZA0Rv4v3A6+Qi6XuHPNTluTq6N
         u3bfmFBvEI1cbYKkW3Te8TCVGnNswIfV6tGKXIMIZj68DFpkvNnn6XvhjdwKvOesNa4g
         DeS8ysxrZrSh+fiVCYb2pIWJddDWQK6B7bWDV9WJuhdOSHoZiXj6kgFIuqWEP05m1gAM
         VZWrage/W1CoAyLdHw/fHi9vCOoPmOOi14hJQnT6tWQwTLGtoETq8onfsGy9oBnSYmfS
         0iDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=lokJF4O6M03HHXPKpndOhYyclhs0ThFtf9qgupdJTnM=;
        b=ChwcIYBgSYp/bL98ppFxrY8Yxmveu9MM1NMVB+RSWGiiSsv2iFMtcOb4O1LrRafOLI
         a5XOi7zhJwgeE0X5z7+9ImEQA400O/a+8KpyY1ecx2RSsyZ/X3ZuGY8luyaYmk3ffdGC
         H+K4+7nOucNDHpN+cHLj0OIpFcX1UXoR9SURktT78KQI1HbZi01nTbIQ+FbN7q+gYTWS
         qU8nnSdzvBEEtfU9USzs1ZPoj2G70yHCuK5G0aiGIB7ZPTEomaPjvClqQQNK/jkhAww1
         nbwk6VKg0thziVdoCPDsxlnwM/kql4HRBzqR8/+xvhWbGyISC3NlX9Y5bLGxYNadGr7X
         eHIg==
X-Gm-Message-State: ACgBeo31/hP4XoKWErdhBp1RkGoMuIruXYJ4nvNuwAsrlRBX8FogH5XT
        tmxpI0eUEy2fHuEuK1B9inNmwpIRFkhYnMhSc7tvUwvt02QG1w==
X-Google-Smtp-Source: AA6agR4e5cQaLdtNZcSqXXklHF5BWT0t12YU2fgBHGVeu1sDrzF+xh0mvpskwIYrouMRO4AkUQyDlmt9G2EgVP0PH5w=
X-Received: by 2002:a05:6214:202d:b0:496:cb8d:538f with SMTP id
 13-20020a056214202d00b00496cb8d538fmr48517qvf.97.1660905454209; Fri, 19 Aug
 2022 03:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220817105643.95710-1-contact@artur-rojek.eu>
 <20220817105643.95710-4-contact@artur-rojek.eu> <CAHp75VeierGKV7BqF+y-vxramA4nk24LOSPRxgmjots_amkg-w@mail.gmail.com>
 <a9b3f2b469e26d13f1c37a6f10373e24@artur-rojek.eu>
In-Reply-To: <a9b3f2b469e26d13f1c37a6f10373e24@artur-rojek.eu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Aug 2022 13:36:58 +0300
Message-ID: <CAHp75VcT3ZbMyeSS6cvV5NY2YYWvDVw-MNwFEDy-S=_6sdbswA@mail.gmail.com>
Subject: Re: [PATCH 3/4] iio: add helper function for reading channel offset
 in buffer
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
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

On Fri, Aug 19, 2022 at 1:33 PM Artur Rojek <contact@artur-rojek.eu> wrote:
> On 2022-08-19 10:17, Andy Shevchenko wrote:
> > On Wed, Aug 17, 2022 at 1:58 PM Artur Rojek <contact@artur-rojek.eu>
> > wrote:

...

> >> +       if (chan->scan_index < 0 ||
> >> +           !test_bit(chan->scan_index, buffer->scan_mask)) {
> >> +               return -EINVAL;
> >> +       }
> >
> > Have you run checkpatch? The {} are redundant. But personally I would
> > split this into two separate conditionals.
> I did run checkpatch on it - all patches were ready for submission.
> I don't find the {} redundant for multi-line statements, like this one,

This is a one-line conditional. So, *unlike* this one.

> and I personally prefer to check conditions that return the same error
> type together.

I see that the maintainer's input is needed here, because even if the
error code is the same, the semantics are different and I consider
that to prevail on the combining.

-- 
With Best Regards,
Andy Shevchenko
