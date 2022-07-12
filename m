Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213C557134A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 09:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbiGLHly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 03:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiGLHlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:41:49 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9959B9C5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:41:48 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id b11so12782901eju.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NSrNMqUgWaYuH+mTVW1bDRg+I5uODANEes06ggGuCQ8=;
        b=hSinwd2+o7s7Z5GqAva/JbWo3c3bbU31+fz4J9bmDcla74i63981XKzdYwltOdOu1s
         2jTGjN6+qb5wlVV+hkl0h60UYgDH8kFDFL2aVikT8YCXbwim0ernZtNOJWgcZbcLbb2i
         PdZr11THsg6zAbwfwDrRoSIduA+KV9lUAknSTADM1h0faJPFYZo/mf86nSUbWkClq5Mp
         52rUpSHWGHvwV/UJ1DbTRI/iEgEA0ZuaV0I/zwH8xzq5VaxPhbdIqHoWScSbZ4olJSPO
         CfUTV8fs2HWp92EhfeTstC8tbHSSCX/trZxM0SQybm5vscnXl8h0QEebFp1UHZlMj3zm
         xCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NSrNMqUgWaYuH+mTVW1bDRg+I5uODANEes06ggGuCQ8=;
        b=O336idSVP6qiAelHRB16jGff57gZ4e1BtUpspQnm+2Dp11IxAF/dQ20G9UniYb/BWo
         NihC77NUdJi99bIGk8N+I12WqPg/R6jgUCWbdhqskAfHHtwCR5t4pjseMinNTU1bYDqW
         N+9/jPjry+yel3T8bOdDSWx+haJ+RUU9NDlFbKvSr4edKwc9WBfqVkf/JDqoA2WzeI4+
         OcOkkUwew6YzxU21bi8DN5Z3UAqQqFBjGFzMCRseVJavVncUUndL8UFSsdmUelYtZiQl
         6WM88CN6ZTjoghbmuSnn5dqmKQkTW7/VcV0tNq3c1jbU8XDckqEshf9JW4fI1VU2sDCg
         J75w==
X-Gm-Message-State: AJIora/AV1723u1YSG6OUJ0VqBFeKx3sqocxwMfqzcSF8b0J/h6G4De9
        UlzCA75oholsta0BskVOdLzxQcXiRXKQw4ho8deK+w==
X-Google-Smtp-Source: AGRyM1t1jqeS/pkiVbY2dvEmVvi4l4xwSga9AY8LFBsQiNHxBtdvWIBVEBlrrfH6Dh4ib0IVtklOMMyO9OTHI3qY87c=
X-Received: by 2002:a17:907:cc14:b0:726:3555:ac63 with SMTP id
 uo20-20020a170907cc1400b007263555ac63mr21853308ejc.697.1657611706834; Tue, 12
 Jul 2022 00:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220711173418.91709-1-brgl@bgdev.pl> <20220712023714.GA9406@sol>
In-Reply-To: <20220712023714.GA9406@sol>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 12 Jul 2022 09:41:36 +0200
Message-ID: <CAMRc=McJjcOo2_xcU0CgoQMO9PJH3t_dWeSyS8QX3wYaxeufhA@mail.gmail.com>
Subject: Re: [PATCH] gpio: sim: fix the chip_name configfs item
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 4:37 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> On Mon, Jul 11, 2022 at 07:34:18PM +0200, Bartosz Golaszewski wrote:
> > The chip_name configs attribute always displays the device name of the
> > first GPIO bank because the logic of the relevant function is simply
> > wrong.
> >
> > Fix it by correctly comparing the bank's swnode against the GPIO
> > device's children.
> >
>
> That works for me, so thanks for that.
>
> Not totally convinced by Andy's suggestion to rename swnode to fwnode.
> Variables should be named for what they represent, not their type, and
> you use swnode extensively elsewhere in the module, so either change it
> everywhere or not at all, and such a sweeping change is beyond the scope
> this patch.
>
> Though it may make his other suggestion to use device_match_fwnode()
> read a little better.  No issue with that suggestion.
>
> Cheers,
> Kent.

I agree on device_match_fwnode() and disagree on the swnode rename. v2 sent out.

Bart
