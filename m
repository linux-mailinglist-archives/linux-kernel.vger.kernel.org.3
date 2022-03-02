Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7EF4C9F04
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240044AbiCBIRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbiCBIRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:17:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDDAB7C4D;
        Wed,  2 Mar 2022 00:16:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28C64B81F21;
        Wed,  2 Mar 2022 08:16:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFD3C004E1;
        Wed,  2 Mar 2022 08:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646209009;
        bh=j/M+KM/hpKriMRzOM0YFytccklDLw/uBr/iU+aPoPNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X928t27XR5ga6kw7vwiJbm3wCrhyqGlxAa9AbnfGXol1barx7MvmNwxIsEJDpM5Zd
         gPQSh7EqPlTkgLi/6Oe8+YxtjJG/JMSltB1LCX2+Q+946sSUOXROCfjESk9XrQ8mnl
         u+KqqYSylrRABlh+Rkxmti5Gpko+6dqYL8Wuy4AAbM7uuUB81pQVFszLvRFe20K5VA
         pKZC7GPqstWHFt6WdRYJz6ltJzEvAEK5Yz+P+/Dxv8J+kbIKEcIDDOwrW+72JoILsf
         0e65h+/j/YM4KFjSFckwXLXM4i/h5lHSpDszqzi1KLoOOA+WQQEUXHShe7irh9Xpu/
         zysa5Dj28Psug==
Date:   Wed, 2 Mar 2022 13:46:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Rob Herring <robh@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/8] dt-bindings: soc: grf: fix rk3568 usb definitions
Message-ID: <Yh8n7XiJbaT4pZGD@matsya>
References: <20220228135700.1089526-1-pgwipeout@gmail.com>
 <20220228135700.1089526-2-pgwipeout@gmail.com>
 <CAMdYzYqs=iRY6uNzVSkHrrhPYFixXdbZjtwSpPOjf-6f8TXutw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMdYzYqs=iRY6uNzVSkHrrhPYFixXdbZjtwSpPOjf-6f8TXutw@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-03-22, 09:52, Peter Geis wrote:
> Good Morning,
> 
> Would it be possible to pull this patch individually, to fix the
> current error reported by Rob?

This does not apply for me on phy-next. What was this based on..?

> 
> Thanks,
> Peter
> 
> On Mon, Feb 28, 2022 at 8:57 AM Peter Geis <pgwipeout@gmail.com> wrote:
> >
> > The rockchip,rk3568-pipe-grf and rockchip,rk3568-pipe-phy-grf
> > compatibles were incorrectly assigned to the syscon, simple-mfd
> > enumeration, vice only the syscon enumeration.
> > This leads a dtbs_check failure.
> >
> > Move these to the syscon enumeration.
> >
> > Fixes: b3df807e1fb0 ("dt-bindings: soc: grf: add naneng combo phy register compatible")
> >
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> > index 072318fcd57b..5079e9d24af6 100644
> > --- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> > +++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> > @@ -15,6 +15,8 @@ properties:
> >        - items:
> >            - enum:
> >                - rockchip,rk3288-sgrf
> > +              - rockchip,rk3568-pipe-grf
> > +              - rockchip,rk3568-pipe-phy-grf
> >                - rockchip,rk3568-usb2phy-grf
> >                - rockchip,rv1108-usbgrf
> >            - const: syscon
> > @@ -39,8 +41,6 @@ properties:
> >                - rockchip,rk3399-grf
> >                - rockchip,rk3399-pmugrf
> >                - rockchip,rk3568-grf
> > -              - rockchip,rk3568-pipe-grf
> > -              - rockchip,rk3568-pipe-phy-grf
> >                - rockchip,rk3568-pmugrf
> >                - rockchip,rv1108-grf
> >                - rockchip,rv1108-pmugrf
> > --
> > 2.25.1
> >

-- 
~Vinod
