Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054E4579028
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 03:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbiGSB4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 21:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbiGSB4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 21:56:00 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C712D205D6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 18:55:59 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 75so24126008ybf.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 18:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wuk/OrWyj29IoQDFQT7AD1mY7KZhXXM3ZlNUl93ihu4=;
        b=iikN/Axlm8JDKbiz8Wd0AwK31mkN8xXj3UipQxeHvWF6bptpwYBpg9opf+F1o7jmmO
         gmfBxXwP+I31zeUJCewcvMNpYC7L+VwkdJppG4RHgKB9ahm1S5o2YM6qRppyAllk34qR
         fFhNv4LaUTkMfC6SRf0kBlqb6SJohO40vBhWjX1guyMNbDrVCSWQVGaWJDvDRBG1ud9R
         Zwn/NWGEroeLah+8aoUmkJAJ4pGN1Z9krFDF+WeEmHe3CcN3Z6bKHm5bypZguJL/Isa6
         jEFyFqqItABbfYDX1IdD21fprB+NOeCfffD++NfxaaAQsnubj54Xazt04mztlfP4y326
         8AIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wuk/OrWyj29IoQDFQT7AD1mY7KZhXXM3ZlNUl93ihu4=;
        b=FkRji2lvqHK0OaxMvPuYNwH9r2MxxH+taB4b5R0EEo9WnAL4GsMtii5YHONnrFBGja
         2vb8DPT4/JaIUy+VbAQ6qs1EswesaEt4g7JXMsh9SZbR/5wT+2BclF085oWoxovXIM6t
         QWxxkq3oGICXUkC0I+wboQ4C1nILHIVM2EUNbvFiGT5rAmUabV/hZhVTmLUus87RHRpB
         34ajC+l8HdXxgTtdGQa7tbSuf8A1dRhgfddmb8NiOa8uMaJb/dx3IgXXLyqfUF6QAU8i
         csRHpknflulBtUFCv9U8MfLlwHAsEa02g6Mfk75YbT3g/tN+1lR+y1aCevfiy+LImcNa
         s0/Q==
X-Gm-Message-State: AJIora9zNAkHH3Tz83MZn+XLVheAdEjO+djIe4pktc2NGAgDtGuIs2lG
        B2C4mI8h8XRUwqE4rvd1X8YT5SvrturTubMiWLUTXg==
X-Google-Smtp-Source: AGRyM1ueWDg96EK5tkDjz/uDFR3xNoF3zJOdMXS3wbWKBejKWbsTrsrKh7ydRXXXAVz49kg/B9creCpAU4HfO02WHSE=
X-Received: by 2002:a25:9947:0:b0:663:ec43:61eb with SMTP id
 n7-20020a259947000000b00663ec4361ebmr30337760ybo.115.1658195758889; Mon, 18
 Jul 2022 18:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220705083944eucas1p23419f52b9529c79c03c8cc23e2aaf4c5@eucas1p2.samsung.com>
 <20220705083934.3974140-1-saravanak@google.com> <7482d3af-4b02-4c1d-0386-b0a4ddf529da@samsung.com>
 <8a04332e-e7b1-8bc3-d569-5052427bcb13@samsung.com> <CAGETcx93rWqt-Cyz_8JZ4mxcLpJruzSM1QOAgpkPSM-G1sBXWg@mail.gmail.com>
 <20220713145827.yxeoqj6vmkzhrrpv@bogus>
In-Reply-To: <20220713145827.yxeoqj6vmkzhrrpv@bogus>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 18 Jul 2022 18:55:23 -0700
Message-ID: <CAGETcx_V9qxeO+vks8kwpwWZth+fys_TTt=JwV2JkvUNHvTtvA@mail.gmail.com>
Subject: Re: [PATCH v4] amba: Remove deferred device addition
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 7:58 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Tue, Jul 12, 2022 at 12:38:33PM -0700, Saravana Kannan wrote:
> > Sudeep,
> >
> > This makes me think the issue you are seeing is related to your
> > hardware drivers. Can you look into those please? I'm leaning towards
> > merging this amba clean up and adding delays (say 1ms) to your
> > clock/power domain drivers to avoid the crash you are seeing. And then
> > you can figure out the actual delays needed and update it.
>
> I haven't got a chance to debug the issue on Juno much further. One thing
> about the platform is that we can't turn off the debug power domain that
> most of the coresight devices share.
>
> One thing I also observed with -next+this patch is that with a little log
> it can access the registers while adding first few devices and then crash
> which doesn't align with platform behaviour as we can't turn off the domain
> though we attached and turn on in amba_read_periphid and then turn off and
> detach the power domain. Ideally if first device amba_read_periphid was
> successful, it must be the case for all, but I see different behaviour.
>
> I need to check again to confirm if it is issue with platform power domain
> driver. It is based on SCMI so there is some role played by the f/w as well.

Yeah, this log timing based behavior is what makes me suspect it's not
a problem with this patch itself.

However, just to rule it out, can you try making this change on top of
v4 and give it a shot? This is related to the issue Marek reported,
but those are more about permanent probe failures. Not a crash.

+++ b/drivers/amba/bus.c
@@ -219,7 +219,7 @@ static int amba_match(struct device *dev, struct
device_driver *drv)
                 * none of the drivers match.
                 */
                if (ret)
-                       return ret == -EPROBE_DEFER ? ret : 0;
+                       return -EPROBE_DEFER;
                dev_set_uevent_suppress(dev, false);
                kobject_uevent(&dev->kobj, KOBJ_ADD);
        }

-Saravana
