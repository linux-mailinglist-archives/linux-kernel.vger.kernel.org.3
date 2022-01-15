Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991D348F69C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 12:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiAOLu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 06:50:26 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35166 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiAOLuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 06:50:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE3B1B8016A;
        Sat, 15 Jan 2022 11:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608E7C36AE7;
        Sat, 15 Jan 2022 11:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642247422;
        bh=qvz8T8eq7lMx4dBZY0vynGOB+OrJI2dXUSsaC65bOm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NtUoGylvCRs6P5AnA8K3gSHE5KAksmfvPepltJNcGfyWTKv1WC0LXjdQfp260XQGJ
         YUDYtff7g9MnLZaH3bXOdDbLmyZ82hFr1NVEj1Kjiz3BF1ITiJg2JjsiTOdzuh1vf7
         U68D8NSYbOFm22M1BkG3gHk/KBBWmCTdxOZTCWN+Coog9dSG0g1Y1yUGzCa24woLr3
         IK1ad98HMh4+sKiOfrt9I7ApMx5THw5bhlM9naZhJVdJRCUyVq01zyPf6yFC27eK/h
         6BTUSoPZMy6aqC4XZyVm2cK2ZN9w3Yji8dnf1zWove01tx2dwUC+cgBF+gAXry6XiR
         ckDDk8X6Vp0vg==
Received: by pali.im (Postfix)
        id 0802386D; Sat, 15 Jan 2022 12:50:18 +0100 (CET)
Date:   Sat, 15 Jan 2022 12:50:18 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 3/6] dt-bindings: mvebu-uart: document DT bindings for
 marvell,armada-3700-uart-clock
Message-ID: <20220115115018.he4hnnhlvrb6kann@pali>
References: <20210930095838.28145-1-pali@kernel.org>
 <20210930095838.28145-4-pali@kernel.org>
 <163425678347.1688384.10695189000353676651@swboyd.mtv.corp.google.com>
 <20211015090937.gnt66hgugrhwnkei@pali>
 <20211015093701.pfvkighxsndj4ujg@pali>
 <163433494758.1688384.5994009027317282677@swboyd.mtv.corp.google.com>
 <20211016064210.7ahqfqcvf66wtt66@pali>
 <20220115080213.0CCAFC36AE3@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220115080213.0CCAFC36AE3@smtp.kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 January 2022 00:02:11 Stephen Boyd wrote:
> Quoting Pali Rohár (2021-10-15 23:42:10)
> > 
> > If I was designing this driver and DTS bindings I would have choose
> > something like this:
> > 
> > uart@0x12000 {
> 
> Drop the 0x
> 
> >     reg = <0x12000 0x18>, <0x12200 0x30>;
> >     clock-controller {
> >         ...
> >     };
> 
> Drop this node and put whatever properties are inside into the parent
> node.
> 
> >     serial1 {
> >         ...
> >         status = "disabled";
> >     };
> >     serial2 {
> >         ...
> >         status = "disabled";
> >     };
> > };
> > 
> > Meaning that 0x12000 node would be 3 subnodes and all registers would be
> > defined in top level nodes and would be handled by one driver.
> > 
> > This is really how hardware block looks like. But it is not backward
> > compatible...
> 
> Sounds good to me. I presume we need the serial child nodes so we can
> reference them from the stdout-path?

Yes, exactly, separate nodes for serial1 and serial2 are still required.

But dropping clock controller is not possible as for higher baudrates we
need to use and configure uart clock controller. Without it we just get
comparable feature support which is already present in driver.

But, I do not fully understand now, why to change this DTS bindings in
this incompatible way? What it brings? Because for me now it looks like
that this change does not bring anything useful, only breaks current DTS
bindings.

Driver changes would still look in the similar / same way like it is in
current patch series because bindings already contains separate nodes,
just they are children of top level node which represents in internal
registers.
