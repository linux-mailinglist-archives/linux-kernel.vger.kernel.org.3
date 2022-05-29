Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F4A537226
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 20:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbiE2SUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 14:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiE2SUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 14:20:44 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F7987A1B;
        Sun, 29 May 2022 11:20:43 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t13so11992045wrg.9;
        Sun, 29 May 2022 11:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dETdSOArCU+5FN9i/BrakKPTVrpDILWrp20SIYBDv9E=;
        b=TbwUQTPzAb3Lr0IWqpvEJ5+Mt+akHr5pndIvEbNihpWf7LqfQYTy/x6nzVlTpLK/Of
         Iu4MtNoJiM2yMn2q86Sx9RCH1XO10AvkOq+hZu7FXzEQBLC5XGljHaxlNFuVLWANygdZ
         Iw0qKy4ndmxE3omfr7B+tsiXUcnk/yl4+pH79DL3N5QynhQEzvmt2VZmj368l7gSz2uK
         Zj1UOYCImpeEUtadw+EpEgMM8Dfc2MvoiU8oFLMttbOvdMsHV0SdPPw69nfxmN6vLEPx
         GBUBrCJXmhpstzpxLqQXkDPjxqIhgDA2OSmOcfTOHbIjp1dzysharcBZqn1X5DWHx/Gq
         Y0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dETdSOArCU+5FN9i/BrakKPTVrpDILWrp20SIYBDv9E=;
        b=4kLmvq/SlU/ct1E074OOE+CsioIo09Lwt7xfv5IirXWUDaQL4P4K9//kM0XBX12IUo
         oUfYXOf2y1tV6sKnTQzPOn1E+C0eBOGtopEzcW/KtKWkXIOmb1Mw9QLPpZ9UsW7OrcjR
         5b3+o166CswKG5GRqxrQxqr5AMmH0q+1jzLdnZPrr4RU4aiS4RHoEy2jeYe8+0KEVArd
         DwD+X0OoPDLGOENdNm50ql1/pXx16eTK1ZoYSMercM9vSdWxO6+3AEa68h0wKHOcjsLN
         jtmL4dhdnuOT4Hm73H4pnqFBdZP0HaCe6s+tn8uTTb5TcVpfyFzCFVSx7UlfrHwXgfPa
         ZS9w==
X-Gm-Message-State: AOAM533BAe1t9wQwgdNAJQYrWHfybRXHNezXg56nL1MKjgo4oGLoPxGx
        e63OxhXWE6sAa4caIJOI6RY=
X-Google-Smtp-Source: ABdhPJxPBVUIlXtbCps8h1CCo+Oe/o8oSeH0MKpapqQoGZLd9CgYKy9lRSsm/k7wbMfH9wYH9I0gDQ==
X-Received: by 2002:a05:6000:1815:b0:210:dd9:a9c2 with SMTP id m21-20020a056000181500b002100dd9a9c2mr13761145wrh.385.1653848441505;
        Sun, 29 May 2022 11:20:41 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003942a244f2esm8650415wmq.7.2022.05.29.11.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 11:20:41 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     hako@ultrarare.space
Cc:     bryancain3@gmail.com, benjamin.tissoires@redhat.com,
        jikos@kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: apple: Reset quirks when Fn key is not found
Date:   Sun, 29 May 2022 20:20:36 +0200
Message-Id: <20220529182036.10226-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220529180230.17e9a0f9@ultrarare.space>
References: <20220529180230.17e9a0f9@ultrarare.space>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hilton,

> Commit a5fe7864d8ad ("HID: apple: Do not reset quirks when the Fn key
> is not found") re-involves the fnmode issue fixed in commit
> a5d81646fa29 ("HID: apple: Disable Fn-key key-re-mapping on clone
> keyboards"), as linked below.

Reverting that commit will break battery reporting on the Magic
Keyboards 2015 and 2021.

When a keyboard has the APPLE_HAS_FN and another valid quirk, in this
case APPLE_RDESC_BATTERY, setting asc->quirks = 0 (i.e., removing all
quirks) also removes the valid ones.

> To make things work again, this commit reverts a5fe7864d8ad ("HID: apple:
> Do not reset quirks when the Fn key is not found")  and the recent
> workaround fa33382c7f74 ("HID: apple: Properly handle function keys on
> Keychron keyboards")

My understanding of Bryan's patch (in cc) was that the new config option
worked out of the box for Keychron and Apple keyboards and allowed for
manual configuration where required.

Could you explain a bit which bug is fixed by reverting these 2
commits, please? I don't own a Keychron keyboard for testing, so it is
not obvious to me why this change is required.

Thanks,Jose

> Link: https://lore.kernel.org/linux-input/f82dd7a1-a5c6-b651-846c-29f6df9436af@redhat.com/
> Fixes: a5fe7864d8ad ("HID: apple: Do not reset quirks when the Fn key is not found")
> Signed-off-by: Hilton Chain <hako@ultrarare.space>

