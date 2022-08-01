Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78CC586CB3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiHAOS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiHAOS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:18:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B364E22BF6;
        Mon,  1 Aug 2022 07:18:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 263EC1FB;
        Mon,  1 Aug 2022 07:18:56 -0700 (PDT)
Received: from bogus (unknown [10.57.11.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BE433F73B;
        Mon,  1 Aug 2022 07:18:53 -0700 (PDT)
Date:   Mon, 1 Aug 2022 15:18:50 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jassi Brar <jaswinder.singh@linaro.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mailbox: arm,mhu: Make secure interrupt
 optional
Message-ID: <20220801141850.yqa4kal5gyc4l7pj@bogus>
References: <20220728190810.1290857-1-robh@kernel.org>
 <CABb+yY2jV7c8oX7=F=nocfvGrOMHJAYov7zS2nT0=qFoNyoxJQ@mail.gmail.com>
 <CABb+yY0JzztBB+giBu+RCt-dzgwYWF32sCR3WKKP9U5K9UvhxA@mail.gmail.com>
 <20220729111051.5me4vklrzskvsj4w@bogus>
 <CABb+yY1=cppy9QAN=cLWmhvmYrQ5QpY5adE+nRev1rVrtp-QUw@mail.gmail.com>
 <20220801102309.efvmde2ackh3vyg4@bogus>
 <CAJe_ZhdCJ7ba26cGY6-kJC0mCUXU+ACBW1k1VNmXS9gZcLi16Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJe_ZhdCJ7ba26cGY6-kJC0mCUXU+ACBW1k1VNmXS9gZcLi16Q@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 08:57:52AM -0500, Jassi Brar wrote:
> On Mon, 1 Aug 2022 at 05:23, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > On Fri, Jul 29, 2022 at 10:18:04AM -0500, Jassi Brar wrote:
> >
> > > > Anyways I can insert a module that requests this channel and bring down
> > > > the system as accessing anything configure secure from non-secure side
> > > > on Juno results in system hang/error.
> > > >
> > > Why go to those lengths? These are already simpler options available  ;-)
> > > 1)   while (1) ;      // preferably in some atomic context
> > > 2)   *((int *) 0) = 0;   // you might want to iterate over offset for
> > > guaranteed results
> > > 3) Slightly more work, but you also have the opportunity to erase your
> > > storage device
> >
> > I know these simple methods but can I hinder secure side services with
> > these ?
> >
> Ideally, no. And neither if we enumerate the secure-channel in dt and driver.
> 
> See, even if you remove support for the secure channel in the kernel,
> a doped super-user could always insmod a module that attempts to
> access the secure address space that you want to "hide".
>

True, generally they should have put this in a separate page/range so
TZ could program accordingly and prohibit any access 🙁.

--
Regards,
Sudeep
