Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB11512220
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbiD0TIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiD0TIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:08:30 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11EA5E74A;
        Wed, 27 Apr 2022 11:56:20 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z19so2991972edx.9;
        Wed, 27 Apr 2022 11:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PGkwWEjyWvKRW2O+JMoK5c9PRxZb7sH+10wE3z+JiIw=;
        b=KAyndCUS9j1d4aGm9ZJ8hiN3w49IUU6ob02Q40ZurUboPGdiQalxReIebrGp4n676h
         KIgYCl5khrMpcaju3uDjxuUk6DOqq8EEN+GVyTKxSgK565D6b9h/L0kwFZX2N0XJeuxi
         hAye0xmxA7kiTsAbdVZJO16B0A2F6ZIRAKAZzsPI0tTDiMGmtUAlvoFCJ06zb4dSF+Mk
         eNejV24fIB3jAJjwiABj5N3Cawujfcq8lXh9oEXfrNuJpevtDHUj9iWjRhWjG6gD8Srp
         Fe9h99wTLiUzY0PGtZkW6hi2gyAtJGvCsrX2k0ruPkfw0Q74ea5BUtQqaDySPO+S4kZp
         Wc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PGkwWEjyWvKRW2O+JMoK5c9PRxZb7sH+10wE3z+JiIw=;
        b=UQRFOaw3WkmTwmFy9BvRL/Y3jjlqUlBRbIKkoPGpwysVET0NSWvn19QQkZksujC6kA
         mjEn9HJ2K9YzFiPgsbKGyrqVsORK3lbNjSj9BXAeKGBsWD6QChzY7gTR+/qL1+eqvWEw
         5ufMH5tv5t0bdST6h3cZupxA4T/mOOzndL6VGb6S5L4M29Bge/hxawwxd/wVgkLx4ky5
         EAA29SMRvP4xftDVACLfZVpEEqTgIOYqg0kdqVcbua1N4FBYgtgm7DjOpXzC6LXefYUa
         udTWlZQBMaDchv1TloIKJqiNjlMsLUNLLXzGwrTMpgZAJEuMR9IlM2E3qLKXra2kZjnj
         X8Hw==
X-Gm-Message-State: AOAM533sOa4RlB7I7pzY6VdUeJFuO6ojfNgsP+r34S7eX7qEk6VLbDZG
        EcS8QhsXO/NnXXDZOpkh5Q6KXeaafyj1HA==
X-Google-Smtp-Source: ABdhPJxtFVFa6l9WLPFiWILsrg4OhGHFwUCILpExl+2lcnet9HJ6Dt2nUBQ0SzHCGFFKWJsPTjxAJA==
X-Received: by 2002:a50:d707:0:b0:425:e37d:4ef3 with SMTP id t7-20020a50d707000000b00425e37d4ef3mr19733146edi.167.1651085779494;
        Wed, 27 Apr 2022 11:56:19 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id c2-20020a170906924200b006f3d1141693sm912219ejx.44.2022.04.27.11.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:56:18 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 19/45] media: sun6i-csi: Rework register definitions, invert misleading fields
Date:   Wed, 27 Apr 2022 20:56:17 +0200
Message-ID: <3163812.aeNJFYEL58@jernej-laptop>
In-Reply-To: <20220415152811.636419-20-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com> <20220415152811.636419-20-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 15. april 2022 ob 17:27:45 CEST je Paul Kocialkowski napisal(a):
> This cleans up the register definitions a bit, adds a prefix, remove masks.
> Registers are now fully defined, some additional fields were added when
> needed. New format definitions are added for future use.
> 
> Some fields are wrongly defined (inverted) in Allwinner litterature

s/litterature/literature/

Otherwise,
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> (e.g. field vs frame prefixes), which is quite misleading. They are
> now corrected to reflect their actual behavior.
> 
> This should only be a cosmetic commit. No functional change intended.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>



