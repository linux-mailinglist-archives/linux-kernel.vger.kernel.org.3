Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2272D4C5412
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 07:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiBZGBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 01:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiBZGA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 01:00:58 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76572B3242;
        Fri, 25 Feb 2022 22:00:25 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id j10-20020a17090a94ca00b001bc2a9596f6so6723641pjw.5;
        Fri, 25 Feb 2022 22:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oDT98PrOTAZMh1f0FQTgJlvh+w4WkNvtBzSfLHQ9opk=;
        b=dTADfc2oH8Zx04x5ieJgdOyEhVFw2wdfSMBg4MLa58q13O/vuIHpEI9jx64lE5L2Se
         60L8NzAOLCsDD6JY+cxZCgI0ASyFQ1kT69byCMiZ7d8DxHLWbdF17sKML6aOyA1ZeDNE
         4/kt0ihfaB0sGcWQgZP9WjSzQGEd3Ena4r9lOiOidJc8gDXS+UFVudmRx/181cNI0YzO
         o4nF5sODl8PvOvxSs42RByt3gX4k6UwKOSFea9yeHN0HMDZ10kWakOOrrv+AZuZOC9CP
         ayfsGNYJV0gb041bBzUAxZvowqJ6jHHSzufmZF/ddtrWWDlEkP1YFuZhMAysDrITwXpN
         w3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oDT98PrOTAZMh1f0FQTgJlvh+w4WkNvtBzSfLHQ9opk=;
        b=lNogqG1a/CtJpsBHqUVD3ZQ4i/SXVDoE46TCzJLLW8LSxUsXcsyQMn4x4zwRbscCop
         3zd+Zgxk9jK8r6JeozCQ8adsP1nYEjUHvKmRbfuAA83rqZQC+g6OavMizHGayQu1Tr+h
         zBbVlml4EOVsVTkj14SyQpPi8IHDcFWgjDGOLg/ROuX74ZhJ/mbSU+nrHnAKydUcMpLa
         J6gU3ZAKyr4YokrLxtycER3qeDdqrGKViqYo4LyQTe4rOlSoj+wG+E7Yy+/G0ctLf1iI
         cmaIGDrIUloPit2ZbrSGzrz7GnMh1nPObcVcDk6bjeqgqeQFXhXBvniyt8Qxp12EpNie
         exPw==
X-Gm-Message-State: AOAM5336LX0kcazgTaj6ZfLQK88Oe4m/S42p4s8VjcG2aApCU7CqnIO1
        5XxlkCjiL64vJk5GW7SHLEIkC/4lfpg=
X-Google-Smtp-Source: ABdhPJzKNufD8mPotVAi9pDdAKSmsNVT2NFskNOQ9zAG3731IwcZlA1jN9XiPo4h7e01fAVbTYZfog==
X-Received: by 2002:a17:90a:5794:b0:1b9:8932:d475 with SMTP id g20-20020a17090a579400b001b98932d475mr6564400pji.24.1645855224931;
        Fri, 25 Feb 2022 22:00:24 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a91a:1bbf:dba0:d0eb])
        by smtp.gmail.com with ESMTPSA id d14-20020a056a0024ce00b004f3c87df62bsm5375472pfv.81.2022.02.25.22.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 22:00:23 -0800 (PST)
Date:   Fri, 25 Feb 2022 22:00:21 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Sean O'Brien <seobrien@chromium.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: vivaldi: fix sysfs attributes leak
Message-ID: <YhnB9ajOyThI37H7@google.com>
References: <YhmAAjNeTjiNoLlJ@google.com>
 <CAE-0n53tHSswXFKabHEZymn3-sObFU_7n51wRkR0xk9g05SBCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n53tHSswXFKabHEZymn3-sObFU_7n51wRkR0xk9g05SBCw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 08:55:26PM -0800, Stephen Boyd wrote:
> Quoting Dmitry Torokhov (2022-02-25 17:18:58)
> > The driver creates the top row map sysfs attribute in input_configured()
> > method; unfortunately we do not have a callback that is executed when HID
> > interface is unbound, thus we are leaking these sysfs attributes, for
> > example when device is disconnected.
> >
> > To fix it let's switch to managed version of adding sysfs attributes which
> > will ensure that they are destroyed when the driver is unbound.
> >
> > Fixes: 14c9c014babe ("HID: add vivaldi HID driver")
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> 
> Makes sense
> 
> Tested-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> 
> will you make a similar change for the hid-google-hammer driver?

Yeah, I was taking a closer look at your series and that was the result
of it.

Thanks.

-- 
Dmitry
