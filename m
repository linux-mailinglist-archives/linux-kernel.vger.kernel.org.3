Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB595854DD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 20:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238512AbiG2SBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 14:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238498AbiG2SBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 14:01:02 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13A33CBF4;
        Fri, 29 Jul 2022 11:00:59 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id sz17so9825804ejc.9;
        Fri, 29 Jul 2022 11:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=dkyNFKwAIzKazQRhw8FwKZF2MPV+YOonGzJk/uNvBtU=;
        b=YqwyjahSRQnOMWaZ+ntOUwAXMBHw+G0SrfSUMIvnSv55FbcGex4ajMQumoHDcHHGVR
         ymd85ytmGQvUwOhtpRSo8foOa7fF6I1TyHc/l8mcmg8DAN3TcbUcqcPnHS2ghPhl8+uc
         yaYZfdJdQoMWIddt0mwe/wDtz13T92xJRYAYdJ0AMXHS5pBuuZTlB2l8FbU/WRrZB8Gg
         4C435Qzfcs4AkJN/OJDq0ogN3S8u5QpiRsGQccK5Q1UBIV1YrFXGuEKNjM4htemBZRfb
         cbJ2vbWw2PY3Elw56GVN/zCAKC+A4paF3xgfb5xD0GK0Q+LP+bt5ML2HSre/HqUQXVDl
         My2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=dkyNFKwAIzKazQRhw8FwKZF2MPV+YOonGzJk/uNvBtU=;
        b=z4+/HtN79Jr0e4gJlviQXvPQ9R8vsgEbSneVbqRHEIf75e8R0op653KwbNhcXA7Eqp
         mrnAz3lXidI/HvQdWk6rtFnvcKX/HNG9GIk3W/DpM98s0pLIwkvikspIiWOPFwpIogaq
         /x2Pk/ZanxEjShCzs5i5PqG/Qds+9k9ISA0GdzjYnxYES6Wrmp7yfH8ffberzV0Za1KM
         p5618LCy39C9NFhWlert3pqgXSTbv+nRxqSDwPfnoQk+vh17Ji5WtFqyv+O6GtqZRn5z
         h2ClpbfUuLHhuU0yQY8LUg6PNhOj1/6phjtbaijrUNpKcciyErtfIll9AQXNTMNe/my5
         piSQ==
X-Gm-Message-State: AJIora96nG5drWakUGQxYSlvkNWKTyrHUXzxSrB22BTc4IeE+1B/Si4A
        yVDmBybVg+foEMx/37BAf88SIxj8bRylk3FbU+c=
X-Google-Smtp-Source: AGRyM1tMbrZmFlSWJiSeVLHoOcVgck5TivbsVn6ZGgBeJ3wmOdwFWLLkAJUcr93tbxBVy7y4xJ6RtHVbnZqyyBeiMOc=
X-Received: by 2002:a17:907:9706:b0:72b:4b0d:86a2 with SMTP id
 jg6-20020a170907970600b0072b4b0d86a2mr3643600ejc.242.1659117658496; Fri, 29
 Jul 2022 11:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220728125435.3336618-1-potin.lai.pt@gmail.com>
 <20220728125435.3336618-2-potin.lai.pt@gmail.com> <CAHp75Vf+4Ew2eaccPb3sQY4wAjjsqR7o_uyTUb7eguY=JeDtQA@mail.gmail.com>
 <d5f6a7e0-60e7-5afe-30c7-8ba76ab12a5c@gmail.com>
In-Reply-To: <d5f6a7e0-60e7-5afe-30c7-8ba76ab12a5c@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 29 Jul 2022 20:00:22 +0200
Message-ID: <CAHp75VfEksu-yG=6cFpDNLYzsg98KJ2Jf_G8zYiQvQch9yeMzQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] iio: humidity: hdc100x: switch to probe_new callback
To:     Potin Lai <potin.lai.pt@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 2:45 AM Potin Lai <potin.lai.pt@gmail.com> wrote:
> On 7/29/22 04:41, Andy Shevchenko wrote:
> > On Thu, Jul 28, 2022 at 3:32 PM Potin Lai <potin.lai.pt@gmail.com> wrote:
> >> Switch to probe_new callback due to probe is deprecated soon.
> > Just noticed that commit message is a bit not okay in a few ways:
> > 1) we refer to the callbacks like ->probe_new();

> > 2) we don't know when we deprecate it, the point here is not that, but
> > unused id parameter in the current code.

^^^ read this again and follow below.

> Thanks for point it out, is it OK leave the message as it is? or you prefer to submit another version to fix it?
> If new version required, I will also add another patch for struct device pointer you mentioned in the other reply.
>
> Just want to confirm that is the new message looks OK?
> New message:
> Switch ->porbe() to new callback ->probe_new()

You need to answer the question "why?" you are doing this and that.
The above is just saying "what?". See above.

-- 
With Best Regards,
Andy Shevchenko
