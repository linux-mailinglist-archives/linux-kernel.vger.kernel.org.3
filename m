Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB974E8897
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 17:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbiC0P6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 11:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiC0P6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 11:58:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB60B37BF8;
        Sun, 27 Mar 2022 08:56:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A234B80C6A;
        Sun, 27 Mar 2022 15:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99535C340EC;
        Sun, 27 Mar 2022 15:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648396589;
        bh=99XWUGNcYcXgLJNtg4593P83O+3v/mcb8SoYcQTDK04=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E25RRXF5xyKXcRW0nslSs4qvLNi1K9ARcpeNh8Blk56am5K74pwRi+hFlup14k3ph
         DCR3BofUcwt/5Mqt/xB4QgGWdpl/OjgCToBfUFC7xaXXqpgo51n83Hd6lqjOuG8fxx
         GdNAnvD44iAdanpZXCOkTdiheOP77vrOqUpixh7m0l49NuQAB+X4SmcKNOzpLUZiuv
         pakJa5Qyn9ODPk6Xw7teTTPQKTtuoOQUVNbDt77LPJyBhVXrgHUplRKPh1zAr/aoPe
         ryjS0Yb+a3GqSUXj6Itlu9LJiYP6Y5C4gGuW8KsBu3JIlHt8MG3Ozi08FoA+4Yvo33
         dPFq1K5nsJI5Q==
Date:   Sun, 27 Mar 2022 17:04:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 1/4] iio:frequency:admv1014: add support for ADMV1014
Message-ID: <20220327170401.3ca0d228@jic23-huawei>
In-Reply-To: <CAHp75VdWPBNeX4=7ZzozodLR2A9=YxfKLpey=fhKhmW+y2HAPw@mail.gmail.com>
References: <20220215081216.67706-1-antoniu.miclaus@analog.com>
        <20220220121414.48d7a3b6@jic23-huawei>
        <CAHp75VdWPBNeX4=7ZzozodLR2A9=YxfKLpey=fhKhmW+y2HAPw@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Mar 2022 13:57:26 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Feb 20, 2022 at 11:55 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Tue, 15 Feb 2022 10:12:13 +0200
> > Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> >  
> > > The ADMV1014 is a silicon germanium (SiGe), wideband,
> > > microwave downconverter optimized for point to point microwave
> > > radio designs operating in the 24 GHz to 44 GHz frequency range.
> > >
> > > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADMV1014.pdf
> > > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>  
> >
> > Hi Antoniu.
> >
> > One really trivial point inline that I noticed whilst having 'one last look'.
> >
> > I'll fix it up whilst applying but please check I didn't mess up!
> >
> > Series applied to the togreg branch of iio.git and initially pushed out as
> > testing to let 0-day poke at it an see if it can find anything we missed.  
> 
> On v5 I have given a few comments and the author didn't include me
> into the Cc list for the following series. It's not good. Not that I
> care too much about the series, but just to make the point for the
> future reactions on somebody's review.
> 

Noted. Thanks for the heads up.

Jonathan
