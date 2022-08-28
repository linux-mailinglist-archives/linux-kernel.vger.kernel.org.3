Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B1D5A3EC5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 19:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiH1RPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 13:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiH1RPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 13:15:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8677C2B1AE;
        Sun, 28 Aug 2022 10:15:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 428C3B80B79;
        Sun, 28 Aug 2022 17:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83814C433D6;
        Sun, 28 Aug 2022 17:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661706926;
        bh=7aE7DD8W4A9si1v1mNlnIRm5CgP9eo1ZiVhLiSoMX0E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BNoqo4S0pXoa85U/ArjY4MMOriIPmrnc6lNLGh587TFMcvYObs4UOObzegAFaB8Mu
         9AOkT3BX4qCC8Kp68lQJNZ3PyyeYOOb2a9agqcQmI0TCiYiN3dOrbrSkUUls0BVMQh
         dXO5K8mLT9G32p9TDez08ALgUKqpG0dW1FmQNGQWvG+2MYesiqxjkF+RENtWpG21s/
         PZHZyb3TJfIOt4DWBi05O/hrPCu+zJHaOqgA4tit9gKjB/Pk6/juKaOfn62eBZUcDs
         IXRzmZKrcfjdXYgFDyO6yKhsassWJFibkXrURoQUTUQDAJum1thh/9coB2ztERw1Ck
         YG2D3mPc7jAgA==
Date:   Sun, 28 Aug 2022 17:41:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio:accel:dmard06: Optimize when CONFIG_OF isn't set
Message-ID: <20220828174105.3ca1b523@jic23-huawei>
In-Reply-To: <CAHp75VfP-5-MPJs81denx9MT_MY_gi_QXkYqm63FY2sK+Kykcg@mail.gmail.com>
References: <20220825144012.24a33bb0@endymion.delvare>
        <CAHp75VeSgmO_=mXVR4uSpbQDO8MBGZu4O2vLEqunHYuoPfJbbQ@mail.gmail.com>
        <20220826124603.4a28a154@endymion.delvare>
        <CAHp75VcGopXaksmvXP_vMM-iGK0o_g5Fw_F5zvH+PXcCUx_cDQ@mail.gmail.com>
        <20220826180609.01262f0a@endymion.delvare>
        <CAHp75VfP-5-MPJs81denx9MT_MY_gi_QXkYqm63FY2sK+Kykcg@mail.gmail.com>
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

On Fri, 26 Aug 2022 19:10:33 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Aug 26, 2022 at 7:06 PM Jean Delvare <jdelvare@suse.de> wrote:
> > On Fri, 26 Aug 2022 18:18:20 +0300, Andy Shevchenko wrote:  
> > > On Fri, Aug 26, 2022 at 1:46 PM Jean Delvare <jdelvare@suse.de> wrote:  
> > > > therefore of_match_ptr() should be
> > > > removed from the kernel entirely?  
> > >
> > > (...) But for some cases it still
> > > makes sense: platform is known to never be non-OF, component is known
> > > to be used only on such platforms, etc.  
> >
> > Well, I can't see the value of of_match_ptr() in such case either. In
> > fact I've submitted a couple patches to remove such occurrences lately:
> >
> > https://patchwork.kernel.org/project/linux-mediatek/patch/20220730144833.0a0d9825@endymion.delvare/
> > https://patchwork.kernel.org/project/linux-pm/patch/20220804135938.7f69f5d9@endymion.delvare/  
> 
> They are different to what we are discussing here, but yes, in common
> denominator the of_match_ptr() is useless in almost 100% cases.
> 

Agreed. Ever since PRP0001 came in, it's made little to no sense to have
an of_match_ptr() but it's perhaps also not worth the noise of generally
removing 1588 cases of it!

As a side note, of_match_ptr() did make sense, then moving to trickery along the lines
of what was recently done for pm_ptr() to get rid of the need for __maybe_unused
would be good.

#define pm_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM), (_ptr))

I 'think' the same trick could be used to make the use of the array visible
to the compiler but still allow it to remove the array. Not actually tried
it though...

Jonathan

