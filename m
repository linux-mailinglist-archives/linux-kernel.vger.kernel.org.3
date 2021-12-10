Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDDB46F8E5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 03:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbhLJCF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 21:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhLJCF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 21:05:26 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717DEC061746;
        Thu,  9 Dec 2021 18:01:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 975D7CE2832;
        Fri, 10 Dec 2021 02:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2EA6C004DD;
        Fri, 10 Dec 2021 02:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639101708;
        bh=0/QEsc6oFsMgq2zkSyb2IGxgS1BlU/Yso8DEj/Z4yno=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=XI3DioNwF432jswb1OPdH2Ws8xHqwfgQpGXtXN73lv6JVM9SfiTBe3Tda/esQ9Z0Z
         bqEGgoK/h0pgU8RTpuprrzN0p4xMXDCk9Tf7ginICuiT94M/IQi5VQPRslNAfFjLrO
         9r1dgUAMdp3ozCvCK5jnn59fSq5h97zxVGh34xS/W5Z6C/yKPerOy5F3mrdvi8PWCX
         lselrF5WVsUZhVp5105CFZLqxZWOesR9PNNB6STJMz1mYjLGYPL7Ag64+6GgsLBu0e
         fhh4w9QMKlOQ5t3hSZXgEscwM+nvnsu4gZin7avmpnpICalOimojlD0hM2Y5fKbI+G
         fslSRNRX2/mIA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Ya9K/sF1YDCYCp2Y@matsya>
References: <20211201072718.3969011-1-vkoul@kernel.org> <20211202230624.C05F3C00446@smtp.kernel.org> <9161450a-40e0-c84f-f529-c903d6f1d722@quicinc.com> <20211203031323.211E5C00446@smtp.kernel.org> <1fb0553b-eca5-a537-4dc3-77437feffc69@quicinc.com> <Ya9K/sF1YDCYCp2Y@matsya>
Subject: Re: [PATCH] spmi: pmic-arb: Add support for PMIC v7
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>
To:     David Collins <quic_collinsd@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>
Date:   Thu, 09 Dec 2021 18:01:47 -0800
User-Agent: alot/0.9.1
Message-Id: <20211210020148.B2EA6C004DD@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2021-12-07 03:52:30)
> On 03-12-21, 16:45, David Collins wrote:
> > On 12/2/21 7:13 PM, Stephen Boyd wrote:
> > > Quoting David Collins (2021-12-02 15:51:18)
> > >> On 12/2/21 3:06 PM, Stephen Boyd wrote:
> > >>> Quoting Vinod Koul (2021-11-30 23:27:18)
>=20
> > > It feels like we should make a parent node that holds the core, chnls,
> > > obsrvr reg properties with a new compatible string and then have two
> > > child nodes for each bus. Then the various PMICs can hang off those t=
wo
> > > different bus nodes. Of course, it needs DT review to make sure nothi=
ng
> > > else goes wrong.
> >=20
> > We considered this alternative DT layout when implementing PMIC arbiter
> > v7 support downstream.  The benefit is allowing common register ranges
> > to be specified once instead of in both SPMI bus nodes.  However, this
> > approach has several downsides.
> >=20
> > It results in substantially more complex device tree binding
> > documentation that requires a different layout for SPMI buses for PMIC
> > arbiter v7 (and above) vs early versions even though support can be
> > provided with only a minimal modification (i.e. "qcom,bus-id").
> > Complexity is also increased inside of the spmi-pmic-arb driver.  There,
> > special data structures and logic would be needed to handle the shared
> > vs independent register addresses and data.
> >=20
> > The SPMI framework currently uses a one-to-one mapping between SPMI
> > buses and struct device pointers.  This would not work if the new
> > top-level node represents the true struct device and the per-bus
> > subnodes are not true devices.  Also, platform_get_resource_byname()
> > (used in the spmi-pmic-arb probe function) needs a struct
> > platform_device pointer to read address ranges using "reg" +
> > "reg-names".  That wouldn't work for the subnodes.
> >=20
> > I suppose that "compatible" could be specified for the top-level node
> > and the per bus subnodes so that all three get probed as struct devices.
> >  However, that makes things even more complicated and convoluted in the
> > driver (and DT).
> >=20
> > I would prefer to stay with the approach of the two bus instances being
> > specified independently in DT.

The driver is already pretty hard to read because it combines so many
generations of spmi arbiter hardware from qcom into one file. It would
probably be better to start over and simplify the new version of the
driver, possibly sharing code between the two files if possible, but
otherwise dropping lots of cruft along the way and simplifying review
burden.

>=20
> Steve, David,
>=20
> Is this the way we are recommending for this to be move forward with?
>=20

Please send the yamlification or update to the yamlification of the
binding.
