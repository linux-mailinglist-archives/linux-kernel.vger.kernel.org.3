Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB74575815
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 01:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbiGNXdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 19:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiGNXdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 19:33:32 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374DE2CCAA
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 16:33:31 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id h62so5829733ybb.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 16:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MsubRRKvtCvadBkw96fGeeoDLGGa+ZYhx93FS0ltR/w=;
        b=YvP8snpox2PWYptEwSl8ESwv+ZgXeFv4nLXFKppj9+dpUFX4rNfGFLgC01KC601zFa
         y+Twc5L9b2BcH4RXMv8NPmHkOsB/ZrDM7JqwUa2nFZHxZncB+PRZNaXOaWDbKFkA0NGR
         TfWI4WNLDs5wDhRkg/kje3SepMY7lCRvi9Q6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MsubRRKvtCvadBkw96fGeeoDLGGa+ZYhx93FS0ltR/w=;
        b=6UzEnIWCJN1C2od+skBfvwByfmvIfVJHe8JXmQjec5tNvyxXnYZ4ewR2+8uN7NUKfR
         Lj81rm+SihNhzXMCpX34uzdO+JXGrPj++R4Wc7u/9hFtUL33FY9JmgIi9K0sx8vQ8EjR
         vXKiT9igTuDteVR8bNFw7+1O4LbhU/VlAFdkesCWLyyGT1KdOCsy6paNbyqEXu1g0ra4
         eqcVT+uMDOBKb+y2BkRYAvTlKJdtke9hrBTpqznjbL0QXd82hWsG6H2PscmK5ivgHVFB
         lL2nc9k1y2Efr543tqPHSsuW3aLkUrdXBeQf7l9n3+ntgoXg0AfY23zZHq+OC+yRav0a
         0Djw==
X-Gm-Message-State: AJIora9t62MmmIPFbRLXhfEQUT8az35Ww/GO31VUuVIbyc9h8vIAejeK
        UUiYfrVg7SECHe3g7GQgZWYY+7Do+3dtC33zyrsfqA==
X-Google-Smtp-Source: AGRyM1vqqsxFwTXVXspgL8oYku3WBLf9OeC8nVz3gPHoLorwgfbUZF5B9XSgQ50NtnwQVC6nk/r/qvZLoTfmXBkKJhw=
X-Received: by 2002:a25:6913:0:b0:66e:3700:4235 with SMTP id
 e19-20020a256913000000b0066e37004235mr11796546ybc.240.1657841610409; Thu, 14
 Jul 2022 16:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220706205136.v2.1.Ic7a7c81f880ab31533652e0928aa6e687bb268b5@changeid>
 <CACeCKadV=k5J1ZSG+p8M5iBnX5nXrn-XnK62Nq_op2kJ68+-9w@mail.gmail.com>
 <CANkg5ewRc5zhBtxLhazo8Wsfa3Srj32AwZD9mD=W=Qqpqi7zJQ@mail.gmail.com>
 <CACeCKaer_hacWmLDDMJSK-KFjxqiXV8S1-ydCWGT3mkQVeN-rg@mail.gmail.com> <CANkg5exPZH7LXV93SbAbNPsX2M-kE1yHqDhfk-cB0ywS15pOPQ@mail.gmail.com>
In-Reply-To: <CANkg5exPZH7LXV93SbAbNPsX2M-kE1yHqDhfk-cB0ywS15pOPQ@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 14 Jul 2022 16:33:19 -0700
Message-ID: <CACeCKafvVATzEqOnkT3-QPyfaTV8baHNKbLy8069-K+P+RPeMg@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: cros_ec: Send host event for prepare/complete
To:     Tim Van Patten <timvp@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, rrangel@chromium.org,
        robbarnes@google.com, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 3:17 PM Tim Van Patten <timvp@google.com> wrote:
>
> Hi,
>
> > Calling such a theoretical new EC host command from the userspace power manager
> > would probably accomplish the same thing.
>
> We investigated something like that internally initially:
> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/3646238)
>
> We decided to take this simpler approach instead, since it
> accomplishes the same goal without requiring new host commands.

- That link discusses updating the existing host command and the EC
implementations;
have you investigated adding a command for logging needs and calling it from
power_manager/powerd directly?
- That link addresses several busses (UART, SPI etc.) whereas this patch only
touches LPC. Is this intentional?

>
> > From the kernel documentation[2], "The prepare phase is meant to
> > prevent races by preventing new devices from being registered; the PM core
> > would never know that all the children of a device had been suspended if new
> > children could be registered at will." and "The method may also prepare the
> > device or driver in some way for the upcoming system power transition, but
> > it should not put the device into a low-power state."
> >
> > So it seems like an incorrect usage of this callback.
>
> Why is this usage incorrect?
>
> Sending the message to the EC is the preparation for the AP to enter
> the system power transition. For example, it allows the EC to begin
> watchdogging the AP once the suspend begins and stop once the resume
> completes. This allows the EC to watchdog the entire process, without
> any gaps - a beneficial side effect of this change.

OK. Is that all it does? Does this not allow the EC itself to enter a
deep sleep state,
or put connected peripherals and/or state machines in a low power state??

If you're still set on this approach, please update the function names;
setting the .prepare()/.complete() function pointers to
cros_ec_lpc_suspend/resume()
is inconsistent, if those functions aren't being used elsewhere in the file.

BR,

-Prashant
