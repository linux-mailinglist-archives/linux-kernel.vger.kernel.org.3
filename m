Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C21E4E98DA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 16:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243564AbiC1OBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 10:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239631AbiC1OBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:01:50 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6511929CB0;
        Mon, 28 Mar 2022 07:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1648476009; x=1680012009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ayM215iKfS3RVxHHf6+6kiEWl9gC2cMSZOj/C1/hktk=;
  b=U8/IvxCtevfYoGYrmAhmdvhsaSlpF29tUqtt73uDLA1mNqIdn9gAh5Px
   LS3s2pIN8sFmOrO/atdnDsCnOk2QBkaCZTV5pGjo+XhXYYarAiIIzXbCI
   KuAYCgpNsw2miPHYKSwBDdywOVa9743uWj5iGnEiCOVJIgtcJbuIArtuB
   FiU0E0VJSlejFS+KsPWvPv6sxjL5m10MlkFYv8diGYs+wI7oYwi9BScOm
   b1YQukNL5OvfmlbFPT95RwnRBykJWQqZ02S/dtSs24P6pyjcRpe4glG6y
   b8YQyedffRPaJTs0VmLXut/QlvD30JS5tFylRtBCgwTcQfY5ZDcCWeQ0m
   A==;
X-IronPort-AV: E=Sophos;i="5.90,217,1643670000"; 
   d="scan'208";a="22935295"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 28 Mar 2022 16:00:05 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 28 Mar 2022 16:00:05 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 28 Mar 2022 16:00:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1648476005; x=1680012005;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ayM215iKfS3RVxHHf6+6kiEWl9gC2cMSZOj/C1/hktk=;
  b=WuV252Nu+GZzN74VzCmlspBKd0dca8X2+xSzsUDOC+VBkSdAcRJKkpz9
   V6ZhUvtyzJXo40EU/KoKsnsMA+udDgpFrmJjA0OOrI8Du6AE/IqQXvbD0
   l7/oi3cIclt6kdqSsBk62dD3jTXzpYH4IITmDIWCq1j5VlQdR/7ht0rkB
   UzXa+gf9sB2fMmE9Y4BJg30hxvVMBs2s+cV3pKJsYN741b+m12/z4LAVK
   Ghd0BfGmPSMkfRYy9LlDPSTztxPRWJXf02LYJ3AALa7lqL+bNoPBea5QD
   q3OLZ+wYdDSKr/JtyC5EC84xkLnc6lGkLWsLSzPCKdl/McKEhN7OLwWQj
   g==;
X-IronPort-AV: E=Sophos;i="5.90,217,1643670000"; 
   d="scan'208";a="22935294"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 28 Mar 2022 16:00:05 +0200
Received: from steina-w.localnet (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 20160280065;
        Mon, 28 Mar 2022 16:00:04 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Jonathan =?ISO-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-omap@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-aspeed@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        kernel@dh-electronics.com, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-tegra@vger.kernel.org,
        linux-oxnas@groups.io, linux-arm-msm@vger.kernel.org,
        linux-unisoc@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-realtek-soc@lists.infradead.org
Subject: Re: (EXT) Re: [RFC PATCH 0/1] Categorize ARM dts directory
Date:   Mon, 28 Mar 2022 16:00:02 +0200
Message-ID: <2100132.irdbgypaU6@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <YkG2RPrtPaBNXb7a@latitude>
References: <20220328000915.15041-1-ansuelsmth@gmail.com> <YkG2RPrtPaBNXb7a@latitude>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE,WEIRD_QUOTING autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 28. M=E4rz 2022, 15:21:08 CEST schrieb Jonathan Neusch=E4fer:
> * PGP Signed by an unknown key
>=20
> On Mon, Mar 28, 2022 at 02:09:14AM +0200, Ansuel Smith wrote:
> > Hi,
> > as the title say, the intention of this ""series"" is to finally
> > categorize
> > the ARM dts directory in subdirectory for each oem.
>=20
> [...]
>=20
> > [1] https://gist.github.com/Ansuel/47c49925ee7ef4b1dd035afc74679ab5
> > [2] https://gist.github.com/Ansuel/19f61f1e583c49407ce35c10e770fbe0
>=20
> Nice idea, thank you!
>=20
> A few notes on categorization below.
> [...]
> >  create mode 100644 arch/arm/boot/dts/freescale/Makefile
>=20
> Freescale has been part of NXP for a while, so it might make sense to
> merge the freescale and nxp directories. I can't speak for
> NXP-the-company, so that's just my view as a bystander.

Please don't mix the names for arm and arm64. It's very confusing if the=20
vendor directory is named differently for each architecture.

>[...]
> >  create mode 120000 arch/arm/boot/dts/nxp/armv7-m.dtsi
>=20
> armv7-m.dtsi is a bit confusing, because it contains a few devices at
> fixed addresses, so it looks vendor-specific at a first glance into the
> file. However, if it is actually as vendor-neutral as the name implies,
> I think it should live dts/ directly, rather than in vendor
> subdirectories.

This seems to be some generic devices common for all ARMv7M CPUs used in=20
Cortex-M CPUs. It's also used by some stm32 .dtsi.

Best regards,
Alexander



