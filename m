Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B4F4ACDA5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239612AbiBHBIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344071AbiBHAjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 19:39:05 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD6FC0612A4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 16:39:03 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id s18so19132884ioa.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 16:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rmp3DZvzS68gv+rXD5CE3qBfGpBWdIc/bhA+tLCOLDg=;
        b=fBoqNIp/YvvhfJD30/p2ZYWnSdqGqBGC99xKMZMAu+6e/kZWOB75g8Sn4kpEicBVkt
         Q0dvlAhHgaHK9umzmHDV+y+t1r3Hjv8Jo0ssmhOBbhiTJSaBx/K2POlTdjf+H7CGmaK4
         s61Nzp5bo3IuUD9qfIZusrS0XvyvyK2VK8ICM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rmp3DZvzS68gv+rXD5CE3qBfGpBWdIc/bhA+tLCOLDg=;
        b=uyU70G7Gu2Fv1W0R9TA+NIIQmIpYQ7tvXjRxuoyGrl2SmHBd9F02lOGpCfzyO5Q+0g
         rPFDE4JnzJieAbglt+tdOp60Mz2Fc6oSSQYy/J0yHJEy1TS6X0HSmNh+NItNrdNUoqpg
         Tva8uWkGjM7oTX6twjmSYaWWrLo5Z705sP193CSuGkcv7eLbMG54GwVozMU/ioOms5xE
         6lOeKtw8joeR53AL1ykH2amRaFutowzEHmp9PkbOjC1WarawmrmL5u6qpJ+EnK8+fNkA
         To7mFUdmJygD66lVl/SyzdvluogaTLKsrECUBrLSgOzIXhFxNHaA8xfrspZq2XQeBW8z
         wD1g==
X-Gm-Message-State: AOAM530JKjyMqO6I88/P3P0QGEMvXJrYrXs5BqkZ7RIX4982UK7r6cz/
        hUoqNAO4234JeBDaDqDA2YlGDqnokUzQhw==
X-Google-Smtp-Source: ABdhPJx64mZN0F6b1XBlcj4hJ8xlzjAAoFz12xNvyjo7ub9HLt8hxvheqgxc320XHNZ8Fdd/LZLO3A==
X-Received: by 2002:a05:6638:2506:: with SMTP id v6mr1066256jat.94.1644280742746;
        Mon, 07 Feb 2022 16:39:02 -0800 (PST)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com. [209.85.166.173])
        by smtp.gmail.com with ESMTPSA id q16sm6992614ion.27.2022.02.07.16.39.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 16:39:01 -0800 (PST)
Received: by mail-il1-f173.google.com with SMTP id h11so4469490ilq.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 16:39:00 -0800 (PST)
X-Received: by 2002:a92:ca4d:: with SMTP id q13mr902121ilo.165.1644280740496;
 Mon, 07 Feb 2022 16:39:00 -0800 (PST)
MIME-Version: 1.0
References: <20220119204345.3769662-1-mka@chromium.org> <20220119124327.v20.2.Ie1de382686d61909e17fa8def2b83899256e8f5d@changeid>
 <YekPTh/G1IkvpSiI@infradead.org> <YekTFMnXK87MNMh3@kroah.com>
 <Yel+0DrtWm5I9JrL@google.com> <YemBkNhvfPukCB6C@kroah.com>
In-Reply-To: <YemBkNhvfPukCB6C@kroah.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 7 Feb 2022 16:38:49 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WUSo+knj7E9KYDnw5fTv__fdpg72f_N2p1ra7Gtyt8Dg@mail.gmail.com>
Message-ID: <CAD=FV=WUSo+knj7E9KYDnw5fTv__fdpg72f_N2p1ra7Gtyt8Dg@mail.gmail.com>
Subject: Re: [PATCH v20 2/5] driver core: Export device_is_bound()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Christoph Hellwig <hch@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Chen <peter.chen@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 20, 2022 at 7:36 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jan 20, 2022 at 07:25:04AM -0800, Matthias Kaehlcke wrote:
> > On Thu, Jan 20, 2022 at 08:45:24AM +0100, Greg Kroah-Hartman wrote:
> > > On Wed, Jan 19, 2022 at 11:29:18PM -0800, Christoph Hellwig wrote:
> > > > On Wed, Jan 19, 2022 at 12:43:42PM -0800, Matthias Kaehlcke wrote:
> > > > > Export device_is_bound() to enable its use by drivers that are
> > > > > built as modules.
> > > > >
> > > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > > > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > > > > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > > >
> > > > Didn't Greg clearly NAK this the last few times it came up?
> > >
> > > Yes, which is why this series is _WAY_ on the bottom of my list for
> > > reviews...
> >
> > I wasn't aware of that prior discussion, it would have helped to know
> > that this is a major concern for you ...
>
> Sorry, that was on a different thread for a different feature, I thought
> it was this one.  Too many reviews at times.
>
> >
> > If using device_is_bound() is a no-go then _find_onboard_hub() of
> > the onboard_hub driver could make it's decision based on the
> > presence (or absence) of drvdata, which is what the function ultimately
> > returns.
>
> That suffers from the same problem.  I'll take a look at this later
> after -rc1 is out and see what can be done here...

Did you have any suggestions or pointers to places to further research
what you're looking for? I think at this point both Stephen Boyd and I
have given the patch series a fairly thorough review. If the only
problem left is the export of device_is_bound() then we should find a
better solution to the problem so the series can move forward.

Thanks!

-Doug
