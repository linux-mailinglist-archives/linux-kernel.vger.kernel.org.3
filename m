Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B555C58CC0E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243982AbiHHQXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236048AbiHHQXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:23:47 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFC114009
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 09:23:44 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1659975820; bh=XjThV4rj1Nh3GCLFRepWBhK3akKLDUOxgagEgZfGkBo=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=bz3u7r7W0i2JsYPYwf4vglkvFsht2OVepruISNFBI6ZjSIBIDrwIoICd2o+w0W5yG
         AfXCTtEdC9HNWuZnIz6I082tJHcMv3FRucwiv77PMq9UMOiEZF5wjEGx5126LdMJVM
         zp5nWmmGvXEvV7EBIpkfZXQ3BmJH96bJtYSygvcw=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH 4/4] ASoC: tas2770: Fix handling of mute/unmute
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <20220808141246.5749-5-povik+lin@cutebit.org>
Date:   Mon, 8 Aug 2022 18:23:39 +0200
Cc:     Stephen Kitt <steve@sk2.org>,
        Frank Shi <shifu0704@thundersoft.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        asahi@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <906CDD19-1894-4106-959D-B2444036168E@cutebit.org>
References: <20220808141246.5749-1-povik+lin@cutebit.org>
 <20220808141246.5749-5-povik+lin@cutebit.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 8. 8. 2022, at 16:12, Martin Povi=C5=A1er <povik+lin@cutebit.org> =
wrote:
>=20
> Because the PWR_CTRL field is modeled as the power state of the DAC
> widget, and at the same time it is used to implement mute/unmute, we
> need some additional book-keeping to have the right end result no =
matter
> the sequence of calls. Without this fix, one can mute an ongoing =
stream
> by toggling a speaker pin control.
>=20
> Fixes: 1a476abc723e ("tas2770: add tas2770 smart PA kernel driver")
> Signed-off-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>

Ah, should have written the end of the commit message clearer...
What I meant is, if you toggle the speaker pin, you mute the
stream permanently until it's restarted, since toggling the
speaker pin back won't recover the PWR_CTRL_ACTIVE value set in
mute_stream at unmute.

Martin

