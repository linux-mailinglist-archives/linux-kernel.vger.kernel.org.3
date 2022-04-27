Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2006851230A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbiD0Ts1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbiD0TsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:48:05 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCE4167F7;
        Wed, 27 Apr 2022 12:43:18 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z99so3141819ede.5;
        Wed, 27 Apr 2022 12:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fRTSf3OFUO3Ov2OG6//9Y/Zs5QkYiUMty4PfzS6Pw88=;
        b=MbJJ2/fQkmJqHxuDnh1idvE1Rq6/Wyuwo26T19/A1gPUL95TQBO8nvJbRgNJCbx8ye
         nwoLM/9YwrkHRQ+CeJsokv5qyB2AWbBogJbe5rO6XMIFkNkcPDnzoctxoaHxh0tOPHWt
         4Pg7zYg3BFHEDTflbH0rC34Y4hNFNcwr+hIfxFJ/U/BZBxKX7F0B1jQzus4/ri2wSM2x
         8pjfI4LbRdPJvuD54/yGXY9N+DPyOswi31zzrezV8N8l7ofcgHBYFJgV1LaBrHaMup35
         uxsoTnH4/gZv2In0XiibN5EIACWiS8MExzNRuiFWcBIXAZL5P8FyJogdS1DhJOvlYFPH
         5wnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fRTSf3OFUO3Ov2OG6//9Y/Zs5QkYiUMty4PfzS6Pw88=;
        b=IYx1o2WgxyySbbb0a4IwDuU5cg2ocU7IEwlDdjCXMrCbTKHfuStzyNog+bZEM1p1s0
         iqpE3EFuxEIli7qp7ZjXbW/Hf+vTeo8HhOKPjyyNQ+veAN8hhTl2LOpXEpP3tTcpL/VM
         Sg+8yYiHmuBNY+dqZFokIhptpdmNEtTAwjFeUnaLMOAvjlHBwSRtkO4pNLzSVbAG8uQB
         gGmGbC7YTXPaWkNLcEoGGiH3rKdVsd6XGL2pPd0DM/07SZvxXefMnnlMZEUEUVYwmf0o
         tZFApcOapIfm9uSVV3EqaQ6Wzsz181P/gHL6WSwbAghSZ8hJkvN5XrOCLca9rAYVY9K6
         eHOg==
X-Gm-Message-State: AOAM530GZg+b5tCcWbaC2F1uNqp7tmiI2k3nrCqL2ALBaPK4nKD+Ufkz
        PIY17AQHp0IsacRLPnYqCRKI2yJLB/+J8A==
X-Google-Smtp-Source: ABdhPJzqbBDGj6C5ws1Cy8I7RurUGngUK7z1A4LZt31ljvQP/9oRlPak4EVQ7x7QZ5L5AVPo2HLFrw==
X-Received: by 2002:a50:f69b:0:b0:425:e693:5d1f with SMTP id d27-20020a50f69b000000b00425e6935d1fmr18850662edn.272.1651088597073;
        Wed, 27 Apr 2022 12:43:17 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id la10-20020a170907780a00b006e889ee7741sm7229248ejc.75.2022.04.27.12.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 12:43:16 -0700 (PDT)
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
Subject: Re: [PATCH v4 33/45] media: sun6i-csi: Introduce format match structure, list and helper
Date:   Wed, 27 Apr 2022 21:43:15 +0200
Message-ID: <825545110.0ifERbkFSE@jernej-laptop>
In-Reply-To: <20220415152811.636419-34-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com> <20220415152811.636419-34-paul.kocialkowski@bootlin.com>
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

Dne petek, 15. april 2022 ob 17:27:59 CEST je Paul Kocialkowski napisal(a):
> Introduce a list of mbus/pixel format combinations that need an exact
> match between the two sides. This is the case when using raw input
> configuration. The list will be used to replace the
> sun6i_csi_is_format_supported combinatory helper.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


