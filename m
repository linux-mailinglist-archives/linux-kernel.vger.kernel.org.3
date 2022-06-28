Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEFC55DF77
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344893AbiF1MBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344633AbiF1MBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:01:47 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA1B26137;
        Tue, 28 Jun 2022 05:01:46 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id g4so10266123ybg.9;
        Tue, 28 Jun 2022 05:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0pniwHeX6vb5Ys8VLQ575NNjNqJoH9OkhJrizfKPi3c=;
        b=Tls115h5P1d6CAUhvXtiHLxV/QERJk2gH3l26P7Kg7hw63dHHmMMjRiHaz86jAmRSS
         +nBuxhzPS5AaUtD9m+OM1V4HzfwtdRhEPivY5DLooleF0N2JrvA5tDtzU92yvYyKgwbp
         Clbn1EDZH/q4Ew6lqskiUEQUHy8IqWY3JAwPUIRwnQKY56QlBFwUmUJ2H7no7OIdjgyH
         jWZ/u/GcaW2/0uI0qjwZ1uQkJeykbuLCrADKAVW7KNkrb5GN93y8O0j7HptVtpAfbU/Q
         4k6pzW11kB+Oa/u07vonquWPoB/MK0GkQdXx/gXZSWCyLY9Bd/WTlM+bDPxDKyvZDfm+
         NdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0pniwHeX6vb5Ys8VLQ575NNjNqJoH9OkhJrizfKPi3c=;
        b=MuWGe5qXwY33MpB2D8oNF4RKU00Ac0Vktk7yxNgwS+HDW38A7EpINiDtopE7j1Fztc
         HJbUcObOa9dbWeXzy2w4MEDecj++8mZQDgMgX8EbMvqNAK8FHYYTEe+ldgaUsnbR8FbP
         ZsdvEdhV/8yRkqtL3Y14QO0hZ67AkscnA8uplck9mqmGajvP9y4pcLmqkmv/kTwfd/ip
         93yodJPLRHGTPctJOF9aEom2tUCOU+u5xDnWg7TB2PxrmB4PfDLh5N3/f7jH3FlplEwr
         GmQ1dSqeJOPUlea1u9MBc6KG5lmdxrk6AUTf4y1zdT461XfxX9SZmCs9cayOBc2BZH0P
         Jd5Q==
X-Gm-Message-State: AJIora8Ek4Mz/VZvTwKBNvRkcDCc+2VKuqsZCB8fXhKTjEY5mj7qgiXr
        HqudIyB8wXzFAI9RqcJ8otVxFlDejoTDZD6WFV1XS7ZWML9v6g==
X-Google-Smtp-Source: AGRyM1tpFFYZ6IOqD7r/Q4SIXcc6hmpB1jS1eyL0YvIHX4qnjN2FurPx5b34iHQgxmyh4RHzzXGN5xkLVRIAOk0J75I=
X-Received: by 2002:a25:ca0a:0:b0:66b:4e6c:e094 with SMTP id
 a10-20020a25ca0a000000b0066b4e6ce094mr20644626ybg.296.1656417705669; Tue, 28
 Jun 2022 05:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220623170844.2189814-1-marcus.folkesson@gmail.com>
 <20220623170844.2189814-2-marcus.folkesson@gmail.com> <CAHp75VcYk9PjQ=3ZPB1f=uQ-1GYKnvV-wsu+-z1z81W_ZHCqrw@mail.gmail.com>
 <YrVZwAqmE0QmibQY@gmail.com> <20220625122429.14e98106@jic23-huawei>
In-Reply-To: <20220625122429.14e98106@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Jun 2022 14:01:08 +0200
Message-ID: <CAHp75Vdr87rXRAKHtxftkPEbS+2yAp8a+Cp1Jx0XnozL+WCKVw@mail.gmail.com>
Subject: Re: [PATCH 02/10] iio: adc: mcp3911: use resource-managed version of iio_device_register
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Sat, Jun 25, 2022 at 1:15 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 24 Jun 2022 08:29:20 +0200
> Marcus Folkesson <marcus.folkesson@gmail.com> wrote:
>
> > Thank you for your comments (all of them) Andy!
> >
> > On Thu, Jun 23, 2022 at 09:01:59PM +0200, Andy Shevchenko wrote:
> > > On Thu, Jun 23, 2022 at 7:40 PM Marcus Folkesson
> > > <marcus.folkesson@gmail.com> wrote:
> > > >
> > > > Keep using managed resources as much as possible.
> > >
> > > You may not mix devm_ and non-devm_ API calls like this.
> > > So, you rule of thumb that goto is most of the time wrong after devm_ call.
> >
> > Can you please confirm that clocks and regulators are disabled when the
> > resources are handed back?
> > I cannot see where when I'm trying to follow the code.
> Andy isn't arguing that the goto is wrong but rather that you cannot
> in general safely use devm_* calls if their failure leads to having to
> do any cleanup.  The reason is the ordering is hard to reason about. Sometimes
> it's safe, but often enough causes problems that we basically refuse to think
> hard enough to figure out if it is.  Hence basic rule is don't do it.
>
> The issue is this.
> probe() {
>
>         non_devm_call_1();
>         ret = devm_call_2()
>         if (ret)
>                 goto err;
>
>         return 0;
> err:
>         unwind_non_devm_call_1()
> }
>
> remove() {
>         unwind_non_devm_call_1()
> }
>
> remove or error path should unwind in opposite order of what happens in probe.
> On the rare occasion where that isn't the right choice, there should be very
> clear comments to say why.
>
> Order is
>
> remove() -> unwind_non_devm_call_1()
> devm_managed_cleanup() -> unwind_devm_call_2()
>
> Whereas should be
>
> remove()-> unwind_call_2() then unwind_call_1()
>
>
> There are two ways to solve this.  Either only use devm for those
> elements in probe() that happen before the first thing you need to
> unwind manually or make everything devm managed (it unwinds in reverse
> order of setup) devm_add_action_or_reset() allows you to use your
> own devm_ managed callbacks if there isn't a standard one available.

Thanks, Jonathan, that's exactly what I meant!

-- 
With Best Regards,
Andy Shevchenko
