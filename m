Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FDC51230E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbiD0Ttv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235948AbiD0TtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:49:08 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A3538783;
        Wed, 27 Apr 2022 12:45:48 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id p18so3140041edr.7;
        Wed, 27 Apr 2022 12:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8e+gCPJvlqdywwhA1AiT5TrxJd32pqWYt1z80gAJ+xM=;
        b=gQSTxR+FkHDwSfdSoMVdPbYiA/I52gYBxfczdKmcnbT+vpqS2RFF+v9UTumHA+kbmu
         MF47cCY2Tx4TasuAzmdefd+xoUsQgkUIs1MB99epjEFhH/zkUZ68HVxFcAnIn93reRiU
         Vf0k+AoOLk66G0LsLek8C0Mm1rdlk74bnNZMb1JdTvuqWfBizlx95z/Wtih/XzEB882T
         8oBoeM6n0co8JTo7AIm8AnSOJYKIedsfdGw1bjYuT29dtJ8LZK3zY6WfOKcbfT0wYKJt
         PgvgGl3VQXW9qVLNjnvmhKzSCvlMESRCTAjosVVQlRtw4lero8iwz4Eq92f41KaO5QE6
         V7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8e+gCPJvlqdywwhA1AiT5TrxJd32pqWYt1z80gAJ+xM=;
        b=Nfq3ugVOuHrV429WzEDH1fkn8iDxYT6JE3I6gZybjaEZGszvMcnmekHQBEnCnQEoJS
         LGZn80SHhW3hr8vKb9UL+n5cPxyhrGCyOcqqU0fWFXGWV6d7p6QgzgUn8Gw9ECtf0j+N
         o411k1yo9yPgiDLC9E4xz5J6XFaruIgtqJnSXe/UInRdtU3S8XTK61TAJhX7ISaiFV1L
         K8YG1RDpa3cP93cgf5aSfwzbhK0DhQfTIi5IcEikRiskt+lcixrArhjl5UFfxsXUVaAf
         lFM2ZGBzWQLDvkBh53ima1mL4hzgxj/UXj1EJWTVIrL+bqlViWP/Hr3QrlYemzDvUpOK
         P5mg==
X-Gm-Message-State: AOAM532aS/Z7j+S7agphwGyN800jMGl9O9G53QrMbX/g/xdmwYgoDP0f
        bcCaavbSmEwzlES3CE0GtwqJK26rc4cTSA==
X-Google-Smtp-Source: ABdhPJxzTho5+ipBALlWmPR6C/hsFq1JakfMu9tREjJxQW21SluLo2O/IrFXuFFKwPy/erdVkUD7dg==
X-Received: by 2002:a05:6402:4247:b0:426:1ebc:3aaa with SMTP id g7-20020a056402424700b004261ebc3aaamr2532223edb.314.1651088747055;
        Wed, 27 Apr 2022 12:45:47 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id gk20-20020a17090790d400b006f3a85db71csm3518413ejb.49.2022.04.27.12.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 12:45:46 -0700 (PDT)
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
Subject: Re: [PATCH v4 34/45] media: sun6i-csi: Implement capture link validation with logic
Date:   Wed, 27 Apr 2022 21:45:45 +0200
Message-ID: <1900800.yKVeVyVuyW@jernej-laptop>
In-Reply-To: <20220415152811.636419-35-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com> <20220415152811.636419-35-paul.kocialkowski@bootlin.com>
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

Dne petek, 15. april 2022 ob 17:28:00 CEST je Paul Kocialkowski napisal(a):
> Rework the capture link validate implementation with actual logic that
> reflects the possibilities of the device instead of the combinatory
> helper functions, using the match list when needed.
> Remove the previous dedicated helper.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


