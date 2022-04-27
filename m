Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B0C5122F8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbiD0ToL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235306AbiD0Tn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:43:56 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6144ECEC;
        Wed, 27 Apr 2022 12:38:19 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id e23so3115029eda.11;
        Wed, 27 Apr 2022 12:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hCum5bNhYi9+IQxe4PY50XCxjy3o4DC0Fuh+dehJ7+Y=;
        b=VBJik5g8AFV/dNWkrBZafQjns54j0x12F4VUdilD5H71dLF7idgPBxQJWUlIrgjanv
         Y2+lRpmUVfupTGVSDjK0M/xb0OYBqOR2/pAvowIALbkckDOZtxDOvKxAZgswa774Wln2
         BmneOU7/CaP42D22iEjWNGXNO3eCAgnNtLuwol6aPIx+V91QBG2pH3CCJ+w8fow6yvcE
         XcdYoOAyywJdgKE/yzDswZE/8W5axQzTuxb9UQTDgoX542p1QePG/FmiqADEwkdyvHMz
         C2RpKh4W7123+jZwN9gFwVrGGiY3GKwNTn8ZiRAM/ZjRgpTf5WV73xaN433HgDmbNbgG
         mIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hCum5bNhYi9+IQxe4PY50XCxjy3o4DC0Fuh+dehJ7+Y=;
        b=ASpFnWkSA2WI1UiwMyn8y8IbbaeMwLXosiSn8TN+I5HIW0Kyoq5K0X21IlWnhLfnEe
         UxvxalR248vbqeiH5gYw0aS3xgMpnGlCTsXa3VlT9Ezuck03Lj91C/zCrD9i+qJPgShT
         6fGRwQNsy8A2VIlDUTu50xEyQ0cc64qWzrPzbKdejDKSSK3dQYJ7OQ4G53LOxMmbx+JU
         XGLUF+SQILQqVoxg3U7DGPCHWXQq+fqjPOQLcxBrKQD6bCnPwM+m9loN8wTOR0bAhoVQ
         uQVDcPNbWAdDcfk1vtto76UGnQ+shqSvi2lmYD5ulJO3MBPKHnmmDRO2WnFFk2GZ7ZDO
         /kxw==
X-Gm-Message-State: AOAM530FrJD+M6j/lNV+Ol9mnsGu5KT9VGVSPKMNqBZ/wV70YDxtFvvs
        cOQqFL0m4jmhG03+NQSdicqoirTskiGsoQ==
X-Google-Smtp-Source: ABdhPJyJXe0Qcf2siNZx1NPTseSHA6cbjBTLZ1B+Ru14MQx3/wAkrvCOCledm0fwE69ujzJ4h+F56Q==
X-Received: by 2002:a50:a454:0:b0:425:e94b:2f1a with SMTP id v20-20020a50a454000000b00425e94b2f1amr17837938edb.330.1651088297951;
        Wed, 27 Apr 2022 12:38:17 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id r23-20020a056402019700b0042617ba637bsm83896edv.5.2022.04.27.12.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 12:38:17 -0700 (PDT)
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
Subject: Re: [PATCH v4 31/45] media: sun6i-csi: Introduce capture format structure, list and helper
Date:   Wed, 27 Apr 2022 21:38:16 +0200
Message-ID: <2109482.Icojqenx9y@jernej-laptop>
In-Reply-To: <20220415152811.636419-32-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com> <20220415152811.636419-32-paul.kocialkowski@bootlin.com>
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

Dne petek, 15. april 2022 ob 17:27:57 CEST je Paul Kocialkowski napisal(a):
> Add a table that describes each pixel format and associated output
> register configuration with necessary tweaks. It will be used later on
> to configure the hardware.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


