Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B6559AD75
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 13:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345030AbiHTL1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 07:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241503AbiHTL1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 07:27:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58DE220C2;
        Sat, 20 Aug 2022 04:27:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65FF6B80B8E;
        Sat, 20 Aug 2022 11:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6ABC433C1;
        Sat, 20 Aug 2022 11:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660994849;
        bh=2x0Gsy+of145puKe++xz+vCM/2yS9d9yxU3kwmjgqz4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EETcnA+jD97hRAAmnT6LpnuOKiKz0cf2ZhDX152jOU+0vhd5JKKmDBWc6rU1ohN2X
         HTJ+dGrH/kfKv/MI3DnWCuyHfW3ewXakq+65Qzzk1dLkfG/JmzIQRNIAeY+4qmv0Xg
         un6NwC6pu458ZeCnSat1dDLnRUy0H+aBuSusBy71bCUW9IosftGlSn/I5RXQQD/D1Q
         hI0OAK2T3DLQ3t/335ckA5T54Z96c5yYHnvyKEu23D0A2vhd9yhbf4Wx6ET7lSEszQ
         YoNfp51NDCuN9a9oTLkNsjCWpJMoHbxLgqsQFQYEzmI+N9UMxFl6ZLeaxAmSdmU7GJ
         8DRlVGzwMNc5g==
Date:   Sat, 20 Aug 2022 12:38:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Miaoqian Lin <linmq006@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 08/14] iio: bmg160_core: Simplify using
 devm_regulator_*get_enable()
Message-ID: <20220820123707.7f075381@jic23-huawei>
In-Reply-To: <795d16f2-4dee-7492-4a87-e928020efebe@fi.rohmeurope.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
        <3fd11489356b1c73a3d7b4bd9dec7e12c9fe8788.1660934107.git.mazziesaccount@gmail.com>
        <CAHp75VePr790pXZ5AiRnrPmxkOgZ3YKRTbABE6dvk+udQYrXGA@mail.gmail.com>
        <795d16f2-4dee-7492-4a87-e928020efebe@fi.rohmeurope.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Sat, 20 Aug 2022 06:19:00 +0000
"Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com> wrote:

> Thanks for the review Andy
> 
> On 8/20/22 02:30, Andy Shevchenko wrote:
> > On Fri, Aug 19, 2022 at 10:21 PM Matti Vaittinen
> > <mazziesaccount@gmail.com> wrote:  
> >>
> >> Use devm_regulator_bulk_get_enable() instead of open coded bulk-get,
> >> bulk-enable, add-action-to-disable-at-detach - pattern.  
> > 
> > ...
> >   
> >>   int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
> >>                        const char *name)
> >>   {
> >>          struct bmg160_data *data;
> >>          struct iio_dev *indio_dev;
> >>          int ret;
> >> +       static const char * const regulators[] = {"vdd", "vddio"};  
> > 
> > Please, keep this following the "longest line first" rule. Note, in  
> 
> This was not following the (IMO slightly silly) rule even prior my 
> patch. I can for sure move my line up - but that won't give you the 
> "reverse X-mas tree".
> 
> I don't have any real objections on changing the styling though - I 
> don't expect this to be merged before the dependency is in rc1 - so I 
> guess I will anyways need to respin this for next cycle. I can do the 
> styling then.
I was a bit surprised Mark didn't do an immutable branch for this, but
indeed looks like it's going to be a multiple cycle thing - so we'll
probably have a bunch of new cases introduced in the meantime that
we need to tidy up.  Ah well.

> 
> > this case you even can move it out of the function, so we will see
> > clearly that this is (not a hidden) global variable.  
> 
> Here I do disagree with you. Moving the array out of the function makes 
> it _much_ less obvious it is not used outside this function. Reason for 
> making is "static const" is to allow the data be placed in read-only 
> area (thanks to Guenter who originally gave me this tip).
> 
> > P.S. Same applies for the rest of the similar places in your series.
> >   
> 
> Br,
> 	-- Matti
> 

