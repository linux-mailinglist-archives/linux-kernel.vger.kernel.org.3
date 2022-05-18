Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C7052C4AB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 22:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242692AbiERUrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 16:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242665AbiERUri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:47:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3048516F928;
        Wed, 18 May 2022 13:47:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA0F4B821A6;
        Wed, 18 May 2022 20:47:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89090C34113;
        Wed, 18 May 2022 20:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652906854;
        bh=SX18tJ/Q4djcifq3uNSbnVcMyMpSs0l93zGHYzet49A=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=OWayIlw1AFINnjxiTPrsIaVsWVg1kak/cOCUrQNTlKSq+V8JDFuPz1dWVt9GUYcRs
         m43tC67ugEGyy5zjzJibwtS21+8CTuCyTuUwo3rRLWf6hxsBBGWhjW/PlnrhOiSwwg
         6fMEG/r2jFunUh10vuVIsXSjUEZreq7rLvj9R3tCb10l4WbJ/m3YQay3NwJkzZbfFt
         t1gCVJ53JC76ArhzpYshlw1HzDoriJRypmBzyEXp2ztNh/BnTnVxHfdqo4hDmbWUZF
         0mjHUP4cwUQHAR0a7+qncuoT4gG4hl4GIcDCjkJRnQrF6DCUgYbCaiVnY8fils+KH2
         0mMVEd8KyjPFg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220412122750.279058-3-aidanmacdonald.0x0@gmail.com>
References: <20220412122750.279058-1-aidanmacdonald.0x0@gmail.com> <20220412122750.279058-3-aidanmacdonald.0x0@gmail.com>
Subject: Re: [PATCH v5 2/2] clk: ingenic-tcu: Fix missing TCU clock for X1000 SoCs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        dan.carpenter@oracle.com
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, krzk+dt@kernel.org,
        mturquette@baylibre.com, paul@crapouillou.net, robh+dt@kernel.org,
        tsbogend@alpha.franken.de
Date:   Wed, 18 May 2022 13:47:32 -0700
User-Agent: alot/0.10
Message-Id: <20220518204734.89090C34113@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Aidan MacDonald (2022-04-12 05:27:50)
> The TCU clock gate on X1000 wasn't requested by the driver and could
> be gated automatically later on in boot, which prevents timers from
> running and breaks PWM.
>=20
> Add a workaround to support old device trees that don't specify the
> "tcu" clock gate. In this case the kernel will print a warning and
> attempt to continue without the clock, which is wrong, but it could
> work if "clk_ignore_unused" is in the kernel arguments.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---

Can I take just this one patch through clk tree without the dts part?
dts snippets go through soc trees.
