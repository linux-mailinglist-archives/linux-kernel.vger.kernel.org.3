Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE065A2880
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 15:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344266AbiHZN0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 09:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiHZN0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 09:26:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940F3ABD68;
        Fri, 26 Aug 2022 06:26:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0758561CED;
        Fri, 26 Aug 2022 13:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607DCC433D6;
        Fri, 26 Aug 2022 13:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661520403;
        bh=RJu7liuWmzOWolUeo5PczxL4RZPU8wvRhMZ/JuQm9CI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G+O7UTevcpWB6Kd+btNL9zeLqivgsnayMYgE1brsz2WFZhfN7ukeHzONeFSxhV9wo
         LpB0IhSBGf7UTUvvGGMEPpEXDZ0pcXOnJdhaH1xLdgGz7m/0VvyqV1OcbWjvXyhZlC
         4cMN1eP2Y61Wj85P5xp3vgR2vrZjbIQFXn6ihq4Hctg2oixhpn90iWulT9OUSizBYn
         cHz9q5OiGCIC4I1BB9vY+s0ZotxQ0O7bAClUArDaWrezFnSIBG55mnQD10JeQ00mYK
         ouV2aF/QV8Cgjjv8ZmJuZZJNsiefCSL8TPXpaCndwJBYC5tKimQayl9ooDXVpUFETH
         YqnuZkp9BEvQA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oRZMJ-0002GC-GT; Fri, 26 Aug 2022 15:26:52 +0200
Date:   Fri, 26 Aug 2022 15:26:51 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 2/2] clk: qcom: gcc-sc7280: Keep USB GDSC power domains
 on when USB wakeup is enabled
Message-ID: <YwjKG83tmRT0Y6sj@hovoldconsulting.com>
References: <20220822115246.1.I45235b7c40997bc2abf813e4722b4dcdd6aecf6b@changeid>
 <20220822115246.2.If09027f73daa6e1ed95f5eab02326b543c67132e@changeid>
 <YwS3FCOqIeajMEgz@hovoldconsulting.com>
 <YwUDjaG6n95Ddij2@google.com>
 <YwXlsK3pjK/q1xwO@hovoldconsulting.com>
 <Ywf02oIXEL8G/Heo@google.com>
 <YwjFD9uHnSxoZHvT@google.com>
 <YwjGpSXOscDwbvQH@hovoldconsulting.com>
 <YwjIadKu0Wv2+VDk@google.com>
 <YwjJlRE1qRskZi/y@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwjJlRE1qRskZi/y@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 06:24:37AM -0700, Matthias Kaehlcke wrote:
> On Fri, Aug 26, 2022 at 06:19:37AM -0700, Matthias Kaehlcke wrote:
> > On Fri, Aug 26, 2022 at 03:12:05PM +0200, Johan Hovold wrote:
> > > On Fri, Aug 26, 2022 at 06:05:19AM -0700, Matthias Kaehlcke wrote:
> > > > On Thu, Aug 25, 2022 at 03:16:58PM -0700, Matthias Kaehlcke wrote:
> > > > > On Wed, Aug 24, 2022 at 10:47:44AM +0200, Johan Hovold wrote:
> > > 
> > > > > > The wakeup setting doesn't seem to have anything to do with the genpd
> > > > > > issues on sc8280xp and the controller doesn't resume properly regardless
> > > > > > of whether the PHYs have been disabled or not during suspend unless the
> > > > > > PD is left on.
> > > > > 
> > > > > I'm essentially seeing the same. USB is hosed after resume unless the PD
> > > > > is left on.
> > > > > 
> > > > > On Chrome OS we currently work around that with a version of commit
> > > > > d9be8d5c5b03 ("usb: dwc3: qcom: Keep power domain on to retain controller
> > > > > status") which was reverted upstream. I'm not sure whether USB worked after
> > > > > resume before we enabled wakeup support. I would have sworn it did, but we
> > > > > landed an old version of the wakeup patches a long time ago, so my
> > > > > memory might be failing me.
> > > > 
> > > > I need to remind myself that keeping the GDSC on is only needed when the PHYs
> > > > are kept on. The PHYs were always off before wakeup support was added, which
> > > > is why USB wasn't broken after suspend in the pre-wakeup days.
> > > 
> > > Ok, so to be clear: if you disable wakeup with my patches applied so
> > > that the PD is actually turned off, USB still resumes with only
> > > GENPD_FLAG_ACTIVE_WAKEUP set?
> 
> Actually without GENPD_FLAG_ACTIVE_WAKEUP

Sure, that only comes into play with wakeup enabled. I assume you still
need it for USB wakeup to work?

Johan
