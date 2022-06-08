Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39723542990
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiFHIfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiFHIch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:32:37 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1F51D08A6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 00:53:59 -0700 (PDT)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8F6E53F19F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1654674824;
        bh=Vg4qwAHVWngxhO+NcKoiKt+xyqhFoSxezJOs33bH8X8=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=JUp3sJwqQvqWZIDsDZqcAnYU6w6nGLL5m4K9g5sJLBJCapy8QY42Kz44CPSCHSZaV
         8fVNLszX8LFIDonApt0CCAlEmQfUzh4DzCopzllAyn4cVJoCL8Etu+gCcAiTp189Wu
         ubL4ijUyvxCbB5hIZBiz7Fgqm4GayuMdE7B1tW6V4PVItKuWTTBJOy4qk/Up1edsbk
         NpQulnG2HTI9PN1cnuTbB8dxXYoHgCSYjf/CyrG3dQiXdxQo/TwjjImQAK5YqxXc5u
         cZrqrL3wy/apHswUNGngkv3pDTX28KTutBn+28+2OplIVlNfYNCCCiE3Tbo68xxsF2
         geKad9nO3idZw==
Received: by mail-wr1-f69.google.com with SMTP id p10-20020adfaa0a000000b0020c4829af5fso4510628wrd.16
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 00:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vg4qwAHVWngxhO+NcKoiKt+xyqhFoSxezJOs33bH8X8=;
        b=mDsCTKGgQPnFyhNzyC7TXLJZdeo12SKE5dAPYaBFUWEBJM2kHNuwwcucvEOSIBaQxn
         Sdng5HOSETT06diVzKM9FDEhOk7PBk0+07OWpijjtw+AQjM9+W3E+13CNMk/pnTSSlz5
         NgIQpeLCZAMeP6XM12e+0OzUHu1R5E8XYH07Qz8YKirJo3mG74bx4ivof6Elc6zRFTc0
         ClRElJHtV1Jk842zkfycvFDXItQiC6D43uTmGSaDa7L/X2NdLQUPJUjEcXVS03gOBRyR
         y94XM0axtIeN5CLPMj3r++f3ILjupcr/Ha/6X0r+oV2pK7rXMND7lKEXUHG85IrP9JSR
         CyeA==
X-Gm-Message-State: AOAM532YaodvYzXu9Xr+5Ahojqrz4zlm/neCZE3Ankf0hDk0brl6ZGqr
        La9BvfYfmkWIoXsaL5amxFl0SJk3bNUD/9+lru+EFQ04oab2gSWpI+us2ACFTElvPgYzUv9eta7
        KnYuLRd4NksvoFfSoPgTf4mQ01O+Pu67xYI1gwZpih9hUCWNn8ZhmaqvzAQ==
X-Received: by 2002:a5d:6790:0:b0:217:1567:d319 with SMTP id v16-20020a5d6790000000b002171567d319mr19865794wru.16.1654674823972;
        Wed, 08 Jun 2022 00:53:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxf7YVGkv76qA2GcyuIyqsdWfvW8bxj9SujV8l1BvFPdrXYuRdPB9zB1XoIk6WYCABfrZfQVzpmNeyk7eTJsww=
X-Received: by 2002:a5d:6790:0:b0:217:1567:d319 with SMTP id
 v16-20020a5d6790000000b002171567d319mr19865762wru.16.1654674823636; Wed, 08
 Jun 2022 00:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220608070527.14824-1-huangwenhuia@uniontech.com> <87wndrboja.wl-tiwai@suse.de>
In-Reply-To: <87wndrboja.wl-tiwai@suse.de>
From:   Jeremy Szu <jeremy.szu@canonical.com>
Date:   Wed, 8 Jun 2022 15:53:32 +0800
Message-ID: <CAKzWQkySkKccnmSx_2fKT9QvPfwBOV36Mc-pt3KQR0NO1QkQ2w@mail.gmail.com>
Subject: Re: [PATCH v3] ALSA: hda/realtek - Add HW8326 support
To:     Takashi Iwai <tiwai@suse.de>
Cc:     huangwenhui <huangwenhuia@uniontech.com>, tiwai@suse.com,
        perex@perex.cz, alsa-devel@alsa-project.org, kailang@realtek.com,
        tanureal@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        wse@tuxedocomputers.com, hui.wang@canonical.com, sami@loone.fi,
        cam@neo-zeon.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

and better to follow the order to easy to find the codec once the list
growing next time, e.g.

@@ -651,6 +651,7 @@ static const struct hda_vendor_id hda_vendor_ids[] = {
        { 0x1095, "Silicon Image" },
        { 0x10de, "Nvidia" },
        { 0x10ec, "Realtek" },
+       { 0x19e5, "Huawei" },
        { 0x1102, "Creative" },
        { 0x1106, "VIA" },
        { 0x111d, "IDT" },

to

       { 0x14f1, "Conexant" },
        { 0x17e8, "Chrontel" },
        { 0x1854, "LG" },
+       { 0x19e5, "Huawei" },
        { 0x1aec, "Wolfson Microelectronics" },
        { 0x1af4, "QEMU" },

and so on.


On Wed, Jun 8, 2022 at 3:30 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Wed, 08 Jun 2022 09:05:27 +0200,
> huangwenhui wrote:
> >
> > Added the support of new Huawei codec HW8326. The HW8326 is developed
> > by Huawei with Realtek's IP Core, and it's compatible with ALC256.
> >
> > Signed-off-by: huangwenhui <huangwenhuia@uniontech.com>
>
> Thanks, applied now.
>
>
> Takashi



-- 
Sincerely,
Jeremy Su
