Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32F24753C8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 08:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240626AbhLOHg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 02:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbhLOHg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 02:36:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34A7C061574;
        Tue, 14 Dec 2021 23:36:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 340F76182A;
        Wed, 15 Dec 2021 07:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800E9C34600;
        Wed, 15 Dec 2021 07:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639553787;
        bh=DJ2GHnN3+A6IaBsHIRn0E837VrFieLJ7mGwRff2GO5U=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=K42zGEXQtbBUT2bBp6+lbHjYkNzFd6JkJbMuJ91E+Nz7cRsIzzkvNgi6kSRaeoVXA
         kb6lglDpOdMVGikSLoyotjYyH3ieyB3VUCeABR/exa+uMUJ1+8q43SLUwrQkByNEab
         +HJziIRWI19gF3NTBajou068WHrZujke73cH96PHZlyRksrZvXmC3gT4HCHNTenVFe
         q68NCbL0sWxBa5+fxMnYVjam9VBfI8oRv+HA7k3vgpYsHilxdEL4breAyJIypCHtfJ
         7ZNf1jeAKp84iCIAnCtHx/o9+L3E55fuQ77GWx1vVgeYaJJ2YJInBKfb+O3L6wSOtY
         lFz9CBLy42htg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YbTqPfs7026l6LFE@builder.lan>
References: <20211207114003.100693-1-vkoul@kernel.org> <20211207114003.100693-3-vkoul@kernel.org> <20211209082537.1AF6CC341C8@smtp.kernel.org> <YbTqPfs7026l6LFE@builder.lan>
Subject: Re: [PATCH v2 2/2] clk: qcom: Add clock driver for SM8450
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vamsi Krishna Lanka <quic_vamslank@quicinc.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Tue, 14 Dec 2021 23:36:26 -0800
User-Agent: alot/0.9.1
Message-Id: <20211215073627.800E9C34600@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-12-11 10:13:17)
> On Thu 09 Dec 02:25 CST 2021, Stephen Boyd wrote:
>=20
> > Maybe you want to drop these strings and use the dt index directly? That
> > may actually be faster because we don't do as many string comparisons
> > and the code may be smaller if we don't have to store bi_tcxo. I suppose
> > to make it more readable we could have #defines for each DT index like
> >=20
> >  #define DT_BI_TCXO   0
> >  #define DT_SLEEP_CLK 1
> >=20
> > Blaze a new trail!
> >=20
>=20
> I like the idea, and iiuc it's just a matter of replacing .fw_name with
> .index?

Yes.

>=20
> I am however worried that people will get the order wrong as they are
> hacking on their dts/drivers, because (at least in my view) the order of
> clocks & clock-names has been seen as "a dt binding requirement" up
> until such change. But if we replace the names with indices such enum
> would have to be kept in sync with the DT binding and there's no way to
> validate it.

That's lame, but I see your point. The order is definitely part of the
binding but I'm not sure what we can do about folks deciding to reorder
the clocks property. The checker has a blind spot here.

>=20
> If we do this we should force the driver and dts-writers to rely on the
> binding document by omitting clock-names from the binding (and hence
> dts). Otherwise people will (I will) assume that the clock-names are
> still what matters...
>=20

I guess so. It still leaves everything exposed to the clocks property
getting jumbled and then everything falling apart. Sigh.

I'm not sure how much worse this is than today where the clock-names
property could be wrong and doesn't match the order of the clocks
property. We don't catch that either with the checker, so it's about the
same risk from my perspective. Why not take the risk and save on image
size?
