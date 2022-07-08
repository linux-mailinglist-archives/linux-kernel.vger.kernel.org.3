Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A4356C451
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239768AbiGHTc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238583AbiGHTc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:32:58 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01487313B9;
        Fri,  8 Jul 2022 12:32:56 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bu42so18051820lfb.0;
        Fri, 08 Jul 2022 12:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fE3puKa/6Hokm/etuKQc2OOXjCp/6oW39+ul+1LQBqQ=;
        b=LaaKfBoOuaiqwms2ZKW+xXleA0IKWCHLtlQSRtgDfOAArnWufiUOEjWJYv+GyimtAx
         yUKHzKif6MFcfIjhChE9LBOoteKGdALEacDjVlmzxjuZFwy3lH3PC1JKhVlpoCOR/AE9
         MGQp0THGQy2wEUXIKHxeKDE2Y48898R+HvE/lAgqTHIjgppZ1CDQeq7o/tTxSYxdg8U/
         Waf5gqnTr4ozJ0HM9hPkJaPYqL9O5b3wcb0SmxFjl6Z6g76IWGewDWKUs6QzlQxlLlKE
         9DLZD/8hFZjr/QzD2IpKM5NqYJxO19Nlkai76bAgmGpnwbkxW51j9HpdMPNy8UyRRP2e
         wx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fE3puKa/6Hokm/etuKQc2OOXjCp/6oW39+ul+1LQBqQ=;
        b=AgCpvMDX1vz2Du7Zv8P1jKUBIXl3kqA+J+wLwT4MncTHlyq1y0VP/yIPJGBd8tUVe/
         l9NgqORLfBf5s23JWmyW1l37bk3xEsciPSDwidSqnf/NV2mjn1psknXp8Y4iDBMDKZE3
         RQRfjoJT72sydYKBpDMHwDEDuESuNQVNgz7Z256cFBoJMAPd01oTuMjGr2+exQGEoZgW
         L+0e5lXWjFFWfQBJpoQIxYlyx0JRE0y4I3Mi2FXqvzuFc6uk70SuJ/h0BXjss8fJoQzI
         ZLfkG58VXKsgCSsvO2iQz1oJxsQOMC5a3q/8tObHZdgsC3tUgdJdnG8L05FTeUMPvxlW
         ZNdw==
X-Gm-Message-State: AJIora/NwBQVMYru0OiPfy9PhANRXQB3zFCKQpSvuudUlFbugBtsyZ2L
        gsW1NyLluuq0jojHoDxh/jo=
X-Google-Smtp-Source: AGRyM1t/1vwERfeNaf48d5AaxQ7IN5DluX+1Y1MiFAvLw861pgrGbpSkmX1rwMywN+uCcbtUrJJSGw==
X-Received: by 2002:a05:6512:39d4:b0:489:698a:a36e with SMTP id k20-20020a05651239d400b00489698aa36emr3229762lfu.10.1657308775209;
        Fri, 08 Jul 2022 12:32:55 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id q16-20020a056512211000b0047da5e98e66sm676134lfr.1.2022.07.08.12.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 12:32:54 -0700 (PDT)
Date:   Fri, 8 Jul 2022 22:32:52 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 6/8] clk: baikal-t1: Move reset-controls code
 into a dedicated module
Message-ID: <20220708193252.y3on6tqkqcvxa6tq@mobilestation>
References: <20220624141853.7417-1-Sergey.Semin@baikalelectronics.ru>
 <20220624141853.7417-7-Sergey.Semin@baikalelectronics.ru>
 <e0869ae1b10ec19eaf87dc5fa53498f82e7deaac.camel@pengutronix.de>
 <20220705220757.dwzmrx34t2nsxfzl@mobilestation>
 <f28de0c61c06396e36756f2d4f3379fab26abdbf.camel@pengutronix.de>
 <20220706221018.3swtmotaqggww4xu@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706221018.3swtmotaqggww4xu@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp

On Thu, Jul 07, 2022 at 01:10:18AM +0300, Serge Semin wrote:
> On Wed, Jul 06, 2022 at 11:16:34AM +0200, Philipp Zabel wrote:
> > Hi Serge,
> > 
> > On Mi, 2022-07-06 at 01:07 +0300, Serge Semin wrote:
> > [...]
> > > > What is the reason for separating ccu-rst.c and clk-ccu-rst.c?
> > > > 
> > > > I expect implementing the reset ops and registering the reset
> > > > controller in the same compilation unit would be easier.
> > > 
> > > From the very beginning of the Baikal-T1 driver live the Clock/Reset functionality
> > > has been split up into two parts:
> > > 1. ccu-{div,pll}.c - Clock/Reset operations implementation.
> > > 2. clk-ccu-{div,pll}.c - Clock/Reset kernel interface implementation.
> > > At least for the clk-part it has made the driver much easier to read.
> > > Code in 1. provides the interface methods like
> > > ccu_{div,pll}_hw_register() to register a clock provider corresponding
> > > to the CCU divider/PLL of the particular type. Code in 2. uses these
> > > methods to create the CCU Dividers/PLL clock descriptors and register
> > > the of-based clocks in the system. The reset functionality was
> > > redistributed in the same manner in the framework of the ccu-div.c and
> > > clk-ccu-div.c modules.
> > > 
> > > A similar approach I was trying to utilize in the framework of the
> > > separate CCU Resets implementation. Although it turned out to be not as
> > > handy as it was for the clock-part due to the different clock and
> > > reset subsystems API (clock subsystem provides a single clock
> > > source based API, while the reset subsystem expects to have the whole
> > > resets controller described). Anyway I've decided to preserve as much
> > > similarities as possible for the sake of the code unification and
> > > better readability/maintainability. Thus the reset lines control
> > > methods have been placed in the ccu-rst.c object file, while the reset
> > > control registration has been implemented in the clk-ccu-rst.c module.
> > 
> > Thank you for the detailed explanation. I think that splitting doesn't
> > help readability much in this case, but I realize that may just be a
> > matter of preference.
> > 
> > [...]
> > > > I don't think this is necessary, see my comments below. Since the reset
> > > > ids are contiguous, just setting nr_resets and using the default
> > > > .of_xlate should be enough to make sure this is never called with an
> > > > invalid id.
> > > 
> > > Using non-contiguous !Clock! IDs turned to be unexpectedly handy. Due to
> > > that design I was able to add the internal clock providers hidden from
> > > the DTS users but still visible in the clocks hierarchy. It has made the
> > > clocks implementation as detailed as possible and protected from the
> > > improper clocks usage. It also simplified a new clock providers adding
> > > in future (though there won't be clock sources left undefined in the
> > > SoC after this patchset is applied).
> > > 
> > > All of that made me thinking that the same approach can be useful in
> > > the framework of the CCU reset controls implementation too at the very
> > > least for the code unification. Although after the next patch in the
> > > series is applied there won't be resets left undefined in the
> > > Baikal-T1 SoC. So from another side you might be partly right on
> > > suggesting to drop the independent reset IDs/descriptors design and
> > > just assume the IDs contiguousness.
> > > 
> > > So could you please confirm that you still insists on dropping it?
> > 
> 

> > Please drop it, then. I don't think there is value in carrying this
> > complexity just because it makes the code more similar to the
> > neighboring clk code.
> > 
> > I'd prefer to keep the reset ids contiguous, so future hardware should
> > just get a different set of contiguous IDs, or new IDs appended
> > contiguously as you do in patch 7.
> 
> Agreed then. I'll update the patches and resend the series shortly.
> Thank you very much for review.

The series has been updated the way you asked. Please review:

Link: https://lore.kernel.org/linux-clk/20220708192725.9501-1-Sergey.Semin@baikalelectronics.ru/

-Sergey

> 
> -Sergey
> 
> > 
> > [...]
> > > > 
> > > > 
> > > > 
> > > > I would fold this into ccu_rst_hw_unregister().
> > > 
> > > I disagree in this part. Splitting up the interface methods in a set
> > > of the small coherent methods like protagonists and respective
> > > antagonists makes the code much easier to read and maintain. So I
> > > will insist on having the ccu_rst_free_data() method even if it is
> > > left with only a single kfree() function invocation.
> > [...]
> > > I have to disagree for the same reason as I would preserve the
> > > ccu_rst_free_data() method here. Please see my comment above.
> > 
> > I'm fine with that.
> > 
> > > 
> > regards
> > Philipp
