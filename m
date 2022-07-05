Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242E0566E79
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 14:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239614AbiGEMhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 08:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239442AbiGEMal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:30:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0BC1F63B;
        Tue,  5 Jul 2022 05:22:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92BC7B816A4;
        Tue,  5 Jul 2022 12:22:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C6BC341C8;
        Tue,  5 Jul 2022 12:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657023761;
        bh=Hl6oQo9fBaw8lhEcoZN8z4oGgTIORkI///LPXaadh+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SGQ+VMDCiVJPI4dlqjm6Uv2sKZm0+joTht54YfW3He8Z4TXCbeHtiJKZdcs1VujQB
         XAA2SxR6GNjQtjJKLXg7y0JYM5Pz/vsfXtRkhyGy6LKLQqz3Np79+MNzF60ClPJoQ2
         ooyBc3m5oTtSEMv4OJbpNAiQA7yu3QQxnc+nMB3uvPwmV563psN5lrHm3fRSrJPqe9
         vWttuvEoEvZ8wLAsrNvAc7KAS4SfQC4GJa9ZKpY7Vcf86/dBvakGk9dyVc6ouR9k69
         XLfGDOgNuwErrygPnknj+3tPXCpXiczR2VNMUTBkvimKnSi34NCzhkDHzteL5aOhsu
         Z/fKTCx/OnzZg==
Received: by pali.im (Postfix)
        id 3564ACBF; Tue,  5 Jul 2022 14:22:38 +0200 (CEST)
Date:   Tue, 5 Jul 2022 14:22:38 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] leds: Add support for Turris 1.x LEDs
Message-ID: <20220705122238.ul3cctrxkkttge3m@pali>
References: <20220705000448.14337-1-pali@kernel.org>
 <20220705000448.14337-2-pali@kernel.org>
 <20220705123705.0a9caead@thinkpad>
 <20220705105609.cpabhrwozyeejwqe@pali>
 <20220705135227.6380d6d5@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220705135227.6380d6d5@thinkpad>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 July 2022 13:52:27 Marek Behún wrote:
> On Tue, 5 Jul 2022 12:56:09 +0200
> Pali Rohár <pali@kernel.org> wrote:
> 
> > > 
> > > I don't consider this a problem  
> > 
> > I think it is a problem, to ensure that 'cat multi_intensity' for every
> 
> Misunderstanding. I meant that I don't consider the eventual
> inconsistency a problem, i.e. I agree with your code.
> 
> > > Or maybe just write the value?
> > > Is the register write expensive on the CPLD or why are you trying to
> > > avoid it if unnecessary?  
> > 
> > I just do not see any reason to do unnecessary writes.
> 
> But now you do an unnecessary check.

I think that testing if some bit is set in 32-bit general purpose
processor register is something which really does not play role here.

Note that readb() is always needed to do because it is required to
modify just one bit and this cannot be done without read-modify-write
operations.

> Unless the writeb() is slower than
> that check. Since this isn't i2c, I am wondering how fast that writeb()
> is... But this is just me wondering, we can keep it the way you wrote
> it...
> 
> > > 
> > > Hmm. Wouldn't it make more sense to simply have the global brightness
> > > accept values from 0 to 7, instead of mapping it to 256 values? And
> > > call it something like selected_brightness_index?  
> > 
> > All other drivers have brightness entry which operates on monotone
> > brightness property.
> > Brightness levels do not have to be monotone and by default are
> > decreasing: 0 = brightness with higher intensity; 7 = no intensity (off)
> 
> What do you mean all other drivers? AFAIK only one driver does this
> global brightness thing, and that is Omnia. The global brightness is
> something different from LED cdev brightness property, the same names
> are just coincidental (in fact it caused confusion when Pavel was
> first reviewing Turris Omnia driver). Maybe it should have been called
> global_intensity, to avoid the confusion...

Ok. I thought "brightness" == "brightness" too.

Anyway, as Omnia has this API it makes sense to use same API for other
devices, this allows userspace software to be compatible with more
devices.

> > I cannot image who would like or prefer usage of such API.
> 
> One file that represents the index of the selected global intensity (as
> is stored internally in the CPLD) and another file that represents the
> configured intensities between which the button switches makes sense,
> IMO.

And this is the issue. If you want to get current brightness, you need
to read two files and then do non-trivial logic to derive current
brightness.

> > Just stick with existing APIs. "brightness" entry takes intensity value
> > which is monotone, 0 the lowest, MAX (=255) the highest.
> 
> Again, the name "brightness" does not imply that it is the same thing
> as "brightness" of a LED cdev. And since it even doesn't live in
> /sys/class/<led>/ directory, we are proposing new API and can use
> whatever makes sense.
> 
> I am not saying that the way you did it doesn't make sense. I am just
> wondering if it wouldn't make more sense to be able to read the index
> of what the user selected by button pressing.
> 
> Marek

So what about exporting another sysfs file which controls current level (0-7)?
