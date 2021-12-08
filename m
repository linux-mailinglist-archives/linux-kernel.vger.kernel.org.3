Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF66B46DEF9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 00:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241115AbhLHXVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 18:21:37 -0500
Received: from linux.microsoft.com ([13.77.154.182]:56056 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235101AbhLHXVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 18:21:37 -0500
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id A971720B7179;
        Wed,  8 Dec 2021 15:18:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A971720B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1639005484;
        bh=phg/pXljnj81eIgtyw2wI2IJJBRwkKF0EKzr0UxFgHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lx9Oimo/YOc+kFVdqrZ1Fkvzrs3nj5Nbhtat1TZe/y0AFAbAAujhd/LQW+uuVlnzs
         gzIY9HeZ53FQUKeAuJ6foCxSIlNUBPQRcFgMy/LtRFy2oqPmwjgwy13FprmtG9E4AQ
         I9itPr5bBQpF2z7O2WA9c0wAexS2aAL4LVcNCWk4=
Date:   Wed, 8 Dec 2021 15:18:03 -0800
From:   Katherine Perez <kaperez@linux.microsoft.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v2 2/2] arm64: dts: sm8350: fix tlmm base address
Message-ID: <20211208231803.GA8413@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20211122190552.74073-1-kaperez@linux.microsoft.com>
 <20211122190552.74073-3-kaperez@linux.microsoft.com>
 <YZxoGp33Seaa2WEG@matsya>
 <Yabo0fGXC1rITmsM@builder.lan>
 <Ya9JhqZ/Hyj9HdRk@matsya>
 <20211208022103.GA15963@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <YbAZ/YHMWQZ27NrG@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbAZ/YHMWQZ27NrG@ripper>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 06:35:41PM -0800, Bjorn Andersson wrote:
> On Tue 07 Dec 18:21 PST 2021, Katherine Perez wrote:
> 
> > On Tue, Dec 07, 2021 at 05:16:14PM +0530, Vinod Koul wrote:
> > > On 30-11-21, 21:15, Bjorn Andersson wrote:
> > > > On Mon 22 Nov 22:03 CST 2021, Vinod Koul wrote:
> > > > 
> > > > > On 22-11-21, 11:05, Katherine Perez wrote:
> > > > > > TLMM controller base address is incorrect and will hang on some platforms.
> > > > > > Fix by giving the correct address.
> > > > > 
> > > > > Thanks, recheck the spec this looks correct. We should have tlmm reg
> > > > > space here and not tlmm base which also contains xpu region (thus hang)
> > > > > 
> > > > 
> > > > Aren't you reading the patch backwards?
> > > 
> > > I guess :(
> > > 
> > > > Afaict downstream the driver carries an offset of 0x100000, which we
> > > > dropped as we upstreamed the driver. As such changing reg to 0x0f000000
> > > > should cause most gpio register accesses to fall outside the actual
> > > > register window.
> > > > 
> > > > Or perhaps I'm missing something here?
> > > 
> > > I relooked and XPU is at 0xF000000 and Reg at 0xF100000
> > > So this patch should be dropped as such. The size mentioned in
> > > documentation is also correct
> > > 
> > > Katherine, can you elaborate more on the hang you have observed? Any
> > > specific pins you use which causes this?
> > 
> > Hi Vinod,
> > 
> > Yes, it seems to hang in msm_pinctrl_probe. Specifically, line 734 in
> > gpiolib.c: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpio/gpiolib.c#n734.
> > On i=4, it hangs on assign_bit and the system goes into a reboot loop.
> > When I set the TLMM address to f000000, I don't see this issue at all.
> > 
> 
> The cause for that is quite likely that gc->get_direction() will read
> the configuration from gpio<i>'s registers and gpio4 in your system is
> reserved for use by some trusted application.
> 
> When you change the TLMM address you avoid this problem by just reading
> random registers outside the region that contains protected registers.
> 
> 
> Adjust the gpio-reserved-ranges in your device's tlmm node to mark gpio4
> (probably 4 pins long) as "invalid", gpiolib will then not touch them.
> 
> Regards,
> Bjorn

Thanks, Bjorn. That makes sense. I'll resubmit with the changes to my
device's TLMM node and will drop this patch.

-Katherine
> 
> > > 
> > > 
> > > -- 
> > > ~Vinod
