Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08A558146A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238848AbiGZNqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237702AbiGZNqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:46:08 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C451E3D2;
        Tue, 26 Jul 2022 06:46:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 96DFACE177F;
        Tue, 26 Jul 2022 13:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C306CC433C1;
        Tue, 26 Jul 2022 13:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658843164;
        bh=+UhYb0dzvKjOkG0VYJ/1cx3N8s82SPJh0+o97Kdk5JE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mHUcOIVOuKh+EeAM9Mz6bKpuq8nSEuyUF6Nm9A8TxlIMpH12o9/KW2RaPsHbQklRc
         pk7+Ul1XExL+oOJdxkpfe3oYlsUs1VlZ/xWrVZuKt0JtlxbHPQJfVnhlKDDkmqR2HY
         wD1uSwHvKoR58Frak5G5NE598XrszZECTirSSud/ocEKnjpDgUDRPLVu4zq7aq/N8S
         hEnJx1kRwH+zM9xemdKcqEQ3XGPUl427GGSV6GSxpfwnghzMcI1KPnKaXdT2oUHIWt
         T/7c2bIgJ8G6PvuoV7uj5oubbOcenLJlgdb873cnE5PE7Y+8V87Z8Z2cHMjkvGWZhm
         MMkWaJEq37JGw==
Date:   Tue, 26 Jul 2022 15:45:58 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: armada_37xx_wdt: Fix .set_timeout callback
Message-ID: <20220726154558.6571a452@dellmb>
In-Reply-To: <20220726085612.10672-1-pali@kernel.org>
References: <20220726085612.10672-1-pali@kernel.org>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 10:56:12 +0200
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> ioctl(WDIOC_SETTIMEOUT) calls .set_timeout and .ping callbacks and it is
> expected that it changes current watchdog timeout.
>=20
> armada_37xx_wdt's .ping callback just reping counter 0 and does not touch
> counter 1 used for timeout. So it is needed to set counter 1 to the new
> value in .set_timeout callback to ensure ioctl(WDIOC_SETTIMEOUT)
> functionality. Fix it.
>=20
> Fixes: 54e3d9b518c8 ("watchdog: Add support for Armada 37xx CPU watchdog")
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>

Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>
