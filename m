Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9894EE43F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 00:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242605AbiCaWjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 18:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242560AbiCaWjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 18:39:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC301FF406;
        Thu, 31 Mar 2022 15:38:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C4F5B8225B;
        Thu, 31 Mar 2022 22:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B12C340ED;
        Thu, 31 Mar 2022 22:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648766279;
        bh=0+cqxY3wgXl1ZxgBlYb2Pw1E+eA45qGlrrGxGV6BP4Q=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=KVubnGXunMJIF0ThNkEy70N0q5PMBLlBFHZtwDDlcF/LEM30o5NILdXywFFrb8Mfc
         ky7xDb6uCD4Uq5P+YIK0JXy/82QVa7PNArud3iXwsD5Iau9k1s91+EARvK9nB8dHpe
         4vBaeI10JPTgNi+n1jcuDoQHMUkhMO1DNZQG5u/KveYKZBPKI+qcrYKLHXt7clQOH3
         heENiVEo2e3zffwSV2wtufCT5wlmCKwc6wlvxoJs23Fa1vvMgHgyNR1B4RXf8/Z+St
         9/W6lO1dTqMP7gpPu7WhKM5soFhWTd+O3lsNeubAc0SwUOkZnQsP57x/LmzTDPgsww
         ohHY7YDlIt5UA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <bf438af8-5969-73e4-009d-cb7d93095a5e@kernel.org>
References: <20220324133229.24035-1-jbx6244@gmail.com> <f7493d93-6c8a-efa9-1f2c-a0003a6d43b2@kernel.org> <bf62ad40-6bcf-62ae-f56a-cdc8d17456ec@gmail.com> <20220325005130.C45A3C340EC@smtp.kernel.org> <bf438af8-5969-73e4-009d-cb7d93095a5e@kernel.org>
Subject: Re: [PATCH v1] dt-bindings: clock: convert rockchip,rk3188-cru.txt to YAML
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Johan Jonker <jbx6244@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, heiko@sntech.de
Date:   Thu, 31 Mar 2022 15:37:57 -0700
User-Agent: alot/0.10
Message-Id: <20220331223759.B8B12C340ED@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2022-03-25 00:31:25)
> On 25/03/2022 01:51, Stephen Boyd wrote:
> > Quoting Johan Jonker (2022-03-24 12:51:36)
> >> Hi Heiko, Krzysztof,
> >>
> >> Question for the Rockchip clock maintainer:
> >> What clock should be used here and other SoCs with several clock paren=
ts
> >> in the tree?
> >>
> >> The clock.yaml produces a lot off notifications like:
> >>
> >> /arch/arm/boot/dts/rk3036-evb.dtb: clock-controller@20000000: 'clocks'
> >> is a dependency of 'assigned-clocks'
> >=20
> > 'clocks' is not a dependency of 'assigned-clocks'. The dt-schema should
> > be fixed to remove that requirement.
>=20
> If the driver does not have any clock inputs ("clocks" property), why
> does it care about some clock frequencies and parents?

Because it's a clock provider itself. In this case I suspect because
this is a clock-controller node it was skipping describing some crystal
input though. Maybe it wants to configure the various PLLs in the
clock-controller for a particular board. I can imagine some node with
#clock-cells may want to configure the frequency of the clock outputs or
configure the clk parents for a certain board/SoC. In that case there
may not be any clocks property, but we still want to configure things.

>=20
> The clocks is the logical dependency of assigned-clocks, because
> otherwise hardware description is not complete.

Sure, but also #clock-cells indicating that this is a clock-controller
itself means something. The existing bindings are what they are so
forcing bindings to be updated to comply with having a 'clocks' property
doesn't seem very nice.

>=20
> What should be here for Rockhip? We had similar cases like this for many
> drivers, I was fixing some of Exynos as well. In my case usually the
> root/external clock was missing, so I supplied is as input clock to the
> clock controller.
>=20

Can the schema consider either #clock-cells or clocks? I think that will
work for most cases. It would also be good to have a comment in the
schema or more detail around the definition of assigned-clocks in
bindings/clock/clock-bindings.txt that clocks or #clock-cells are
required. It would be super cool if assigned-clocks only applied if
#clock-cells was present, otherwise clocks property applies, but I doubt
we can do that anymore given how long the binding has been around.
