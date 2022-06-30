Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E562562508
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 23:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236923AbiF3VVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 17:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbiF3VVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 17:21:25 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A9445784;
        Thu, 30 Jun 2022 14:21:24 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id cf14so508945edb.8;
        Thu, 30 Jun 2022 14:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JvEmS573WtzHWbcGOvT17+hD+87aEucA/wMYfrgCnxk=;
        b=AkFnQPyoQmyTszElQEVSp6ZkLHytc3c9fKaMamz+MuPD20M6XKNEugaE/uptM5tcEt
         p0HFwXON5Mg0R/lbI+OrUQimZgzUIx5NkO0ijFKpvunwGimyCyd2dKWR5MbQPyJknqj9
         YqkHUM7lVVkaiiq5EDf+VMEJXiaa3mxxPnW8Kfc5R1a6mXmEOh3q2T68U1LnbYcve1G/
         /W8sdkCHSP2aRYNe5PudSHnm8yahNm6g3IlztcDJTYz8QEdRJNTovwp8VPro3XolTq6y
         sRCurHz+vteGKdPrwaGZNNaNfHDPg7KwCspIXkBMbpabCw/vLaCAb9RHR5GZu3XxF/Ac
         AFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JvEmS573WtzHWbcGOvT17+hD+87aEucA/wMYfrgCnxk=;
        b=Bfs/ABSYpw9pFThDtWgMz1pqPkfMNxDLQtE94Lzw/rL7++a/0vRawSDy5ZD29XalMY
         uU1HcbWGMFuC+RvhbHzOtCpj6jJtqopRCrdLROahn7wStllnzRz9mHJ3t3HFXIsXysTa
         sHDmd1EABUks8n0hOR5awrACzK6HVDr60Jb7yfIzuP3tgmtZCV1zo9ZhpigTHQmib5nB
         SlYDUB8oytiJi9c1Sa7AdO+j9YanVLpNTm5qAzQzkFhcpA3fBf+ac7SY3eUn7xo6qrhZ
         wLPWJ24drkffOdpWDMe6ggeSJ85HnDRdV5m8J+/kDnAllgqGtszSVJn1bkVb2B7xmOMm
         1wOw==
X-Gm-Message-State: AJIora8mz4JUNX30sPk5ycZMOwMx7Extk460hBlxvVWKCcs23fCghuih
        d5oTKAbnMuaVurTeNl9Hap0=
X-Google-Smtp-Source: AGRyM1ug81mCuoXrU+iBpqEQJb+bE7jdeUTJnh5FAdYxMtSw7ODtg+Z5i+xNpaByRWHTOOXnpwF4vQ==
X-Received: by 2002:a05:6402:1e93:b0:435:7f3f:407f with SMTP id f19-20020a0564021e9300b004357f3f407fmr14405868edf.173.1656624082637;
        Thu, 30 Jun 2022 14:21:22 -0700 (PDT)
Received: from skbuf ([188.25.231.226])
        by smtp.gmail.com with ESMTPSA id p24-20020a170906615800b00709343c0017sm9780227ejl.98.2022.06.30.14.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:21:21 -0700 (PDT)
Date:   Fri, 1 Jul 2022 00:21:20 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Michael Walle <michael@walle.cc>
Cc:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fwnode_for_each_child_node() and OF backend discrepancy
Message-ID: <20220630212120.t3in6i7s7chaqacr@skbuf>
References: <3ab8afab-b6b7-46aa-06d4-6740cee422d7@linaro.org>
 <288f56ba9cfad46354203b7698babe91@walle.cc>
 <daaddbd5-1cd4-d3ce-869a-249bdd8aecb9@linaro.org>
 <96f40ae6abf76af3b643b1e1c60d1d9f@walle.cc>
 <f9eb6d94-c451-0c9f-f123-2f1324f68b68@linaro.org>
 <CAHp75VdWdUY-XyGBsQb3i9thCswmBo4UEAEaZCO5MC_HMW+fSQ@mail.gmail.com>
 <20220628205254.gnllvaz7w5jmpfe5@soft-dev3-1.localhost>
 <4782de1fc6692a98bd6c267c2714325f@walle.cc>
 <20220630201617.sqpihcevym7sxqng@soft-dev3-1.localhost>
 <b0e3cd1f6b210943030a1e7a355d1a7f@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0e3cd1f6b210943030a1e7a355d1a7f@walle.cc>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 11:00:37PM +0200, Michael Walle wrote:
> > > > It is not possible to have a defined for the MAX number of ports that
> > > > supported by lan966x. Which is 8. And assigned that define to
> > > > num_phys_ports instead of counting the entries in DT?
> > > 
> > > You mean also for the lan9662? I'm pretty sure that doesn't
> > > work. Have a look where num_phys_ports is used. One random
> > > example:
> > > https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/microchip/lan966x/lan966x_main.c#L874
> > > 
> > > So if your switch only has 4 ports, then I'd guess you'll
> > > access a non-existing register.
> > 
> > Underneath lan662 and lan668 is the same chip. The HW people disable
> > some ports/features on each platform but from what I know you will still
> > be able to access the registers.
> 
> I noticed that there are still 8 ports in the register description and
> assumed that it was wrong [1]. But ok, that makes sense in some way.
> OTOH that means, we cannot do the guesswork Vladimir proposed.
> 
> -michael
> 
> [1] https://microchip-ung.github.io/lan9662_reginfo/reginfo_LAN9662.html

Are you 100% positive that the default values for the flooding PGIDs are
GENMASK(8, 0) for a 4-port switch? And that the packet buffer has the
same size for a switch with half as many ports? Ok...

But in that case, what exactly is the problem if the port count of 8 is
a synthesis time constant for lan966x, and if the CPU port module is
always at index 8 in the analyzer (with a gap between indices 4 and 7)?
Just hardcode lan966x->num_phys_ports to 8 and work with that throughout.
Allocate lan966x->ports as an array of 8 pointers to struct lan966x_port
(which they are already), and the pointers themselves are populated as
being the netdev_priv of the interfaces that are actually present and
used. Literally the only thing you need to fix is that you need to
hardcode num_phys_ports to 8, problem solved. It means that lan9662 is
nothing but a lan9668 where the last 4 ports have 'status = "disabled"'
in the device tree.
