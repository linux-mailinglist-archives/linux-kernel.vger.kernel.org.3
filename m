Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934C253731C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 02:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbiE3AnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 20:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiE3Am6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 20:42:58 -0400
Received: from mail.boiledscript.com (unknown [192.151.158.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A068D1D0DD;
        Sun, 29 May 2022 17:42:54 -0700 (PDT)
Received: from localhost (unknown [192.168.203.1])
        by mail.boiledscript.com (Postfix) with ESMTP id 0BAE13008F7;
        Mon, 30 May 2022 00:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ultrarare.space;
        s=dkim; t=1653871366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yPIjYQQdsfuDIdFfxUyyO6NHvouvVSBJhHz9aU19hqg=;
        b=xdnh+ab0Ma67O31r6jonZ40k094uFi8Uo7m55DzuV58mIWAvjhK+lpPeUslc5XF0a66Ddk
        U2g8vqldtpZM2RlzJV4DNZq3urVmQaL3Ubfc7x5kzRB8Ostju986GBaeWgc+IoPSm++vPp
        qBaLT7ALyGQ3Xgs8LTAMKhX/OTViD7NFKyOgdCK6+rA3h2ZMrl+nq1QKmTVPGe7XZHl18v
        MXqk3CnzYrlZV7b83T2hv0kO1Sigf62fsPW9G2OL0sjOdWBpWrbJpKtDX8GU1KPx3PfkkN
        AtOm6vyjCrO6/vkZjQt1UMuHe55wp18CwAgsCZ+ZX8tmfpjBTTFdhoawPu1zXg==
Date:   Mon, 30 May 2022 08:42:32 +0800
From:   Hilton Chain <hako@ultrarare.space>
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     bryancain3@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: apple: Reset quirks when Fn key is not found
Message-ID: <20220530083752.1973a905@ultrarare.space>
In-Reply-To: <20220529182036.10226-1-jose.exposito89@gmail.com>
References: <20220529180230.17e9a0f9@ultrarare.space>
 <20220529182036.10226-1-jose.exposito89@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: +
Authentication-Results: mail.boiledscript.com;
        none
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jose,

> Reverting that commit will break battery reporting on the Magic
> Keyboards 2015 and 2021.
>
> When a keyboard has the APPLE_HAS_FN and another valid quirk, in this
> case APPLE_RDESC_BATTERY, setting asc->quirks =3D 0 (i.e., removing all
> quirks) also removes the valid ones.

Thanks for the explanation!

> My understanding of=C2=A0Bryan's patch (in cc) was that the new config op=
tion
> worked out of the box for Keychron and Apple keyboards and allowed for
> manual configuration where required.
>
> Could you explain a bit which bug is fixed by reverting these 2
> commits, please? I don't own a Keychron keyboard for testing, so it is
> not obvious to me why this change is required.

I own a GANSS keyboard which encounters this issue as well, related device
information given by `lsusb -v` below:

    idVendor           0x05ac Apple, Inc.
    idProduct          0x024f Aluminium Keyboard (ANSI)
    iManufacturer           1 SONiX
    iProduct                2 USB DEVICE

As I searching through, I found similar reports regarding another GANSS
model[1], and other brands like Varmilo[2] (a lot!) and Keychron. As a
common pattern, they mostly use 05ac:024f.

Currently I have two idea:

1. Modify Bryan's patch, so that fnmode default to 2 if device name not
starting with "Apple" (But I can't validate my assumption since I don't
own any Apple keyboards), I'll attach this patch in the next email.

2. Find out which quirk pattern solves this issue brute-forcely, I may
attach this patch later when I finally find a solution.

What's your opinion?

Stay boiled,
Hilton Chain

---
[1]: https://www.amazon.com/gp/customer-reviews/R1EV0B1FG21GGD
[2]: https://unix.stackexchange.com/questions/604791/keyboard-function-keys=
-always-trigger-media-shortcuts-regardless-of-whether-fn
