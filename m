Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990675392F9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 16:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345005AbiEaOLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 10:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345171AbiEaOLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 10:11:30 -0400
Received: from mail.boiledscript.com (unknown [192.151.158.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B1367D14;
        Tue, 31 May 2022 07:11:28 -0700 (PDT)
Received: from localhost (unknown [192.168.203.1])
        by mail.boiledscript.com (Postfix) with ESMTP id BCA323009A2;
        Tue, 31 May 2022 14:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ultrarare.space;
        s=dkim; t=1654006279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fbHeenntSSPdq2EgFZACo8JZZW7jBXIXIadxCJAgUrY=;
        b=xuage0qiYOSk4R/3XKJmjg6hqpwS0qB04L8sTBmZ6FpUbyehtyb98eXDoJzwidrBzGRSUd
        5F5e8t2sn7+XI2UmGWvxInQTJF3bBc+ojRXe9vb0tPUmEEfx5E48GLw33ByUbY12OtnrJK
        0bpDcWGeBZFXyje2mC3pcwC/tHt+Bmh80x5nSv8XDFsj18OBPcy0X9hGc+XV2qycdkno2c
        lT1r3yvpoy1nAB5Gluh3A9btWNL2O5q/0+/dvJl6Z7mCnaqhFEgAekxGu6kJU2aUgDRYpE
        DJjJ6VeUK1WpiS1pIsx6swtoFB/lHN8XpEQsARVUSrS+0FIerquq9XQUf4O5+Q==
Date:   Tue, 31 May 2022 22:11:02 +0800
From:   Hilton Chain <hako@ultrarare.space>
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     bryancain3@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: apple: Reset quirks when Fn key is not found
Message-ID: <20220531221102.7bd7da7d@ultrarare.space>
In-Reply-To: <20220530061812.GA10391@elementary>
References: <20220529180230.17e9a0f9@ultrarare.space>
        <20220529182036.10226-1-jose.exposito89@gmail.com>
        <20220530083752.1973a905@ultrarare.space>
        <20220530061812.GA10391@elementary>
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

On Mon, 30 May 2022 08:18:12 +0200 Jos=C3=A9 Exp=C3=B3sito wrote:
> That could be problematic because Apple keyboards can be renamed after
> connecting=C2=A0them to a Mac.
>
> For example, the name of my keyboard is: "Jos=C3=A9 Exp=C3=B3sito=E2=80=
=99s Keyboard".

Well, editable name. I have a bad feeling about this...

> I think it'd be safer to assume that the device is an Apple keyboard
> and create exceptions for know non-Apple keyboards  because the
> majority of the devices handled by this driver are Apple keyboards and
> because there is already a config option available (real_fnmode) to fix
> the problematic devices in the meanwhile.
>
> In my opinion, creating a function like "apple_is_non_apple_keyboard"
> (or similar) containing all the rules to identify devices from
> Keychron, GANSS, etc could do the trick. Something similar to:
>
>   if (apple_is_non_apple_keyboard(hdev)) {
>           hid_info(hdev, "Non-apple keyboard detected; function keys will=
 default to fnmode=3D2 behavior\n");
>           asc->quirks |=3D APPLE_IS_NON_APPLE;
>   }

Done. However I couldn't figure out corresponding names from other known
bug reports, so that the initial array only contains two devices.

> Unfortunately, I can't think of a generic way to detect those devices
> as they have the same vendor and product as the Apple ones :S

T^T

Stay boiled,
Chain
