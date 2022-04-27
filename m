Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C6F5122EF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbiD0Tl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbiD0Tj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:39:58 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64BC2199;
        Wed, 27 Apr 2022 12:36:45 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g23so3097398edy.13;
        Wed, 27 Apr 2022 12:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=laBiheI0U75LASrHjB6ZdZZMpe4PBQO0pkzvkJ7BACU=;
        b=TulO57A6xlTWM81rj8A7o39sFF9xM0Zptw/Ml8zYreU+dZwZRnR37mY8wfAX69Pl5x
         vevGv03GOgpcWWfNg0fkxu0LbIduDQWkoWknoefGIPQIhjj+ibdDYYBUMWuivk8jQAZX
         63/1XotXCRd9FMUS9yENF+Yj6l/RTcc18WXBPonnB1mzsuflpIGQJqC6NzguPgUC1iVT
         zI2JPYKmsWvUT+1ARi8HHaDwhTnuwvobYjADNWNrlJInIY+fXpZ0HWzbUY6FWdZYZXWE
         BWc1FXpF1vITNBJvc8DEQ1QuA4XRar+hl/GkfpGhxN1K8aeiEkJKXahYYfF5idA70JE9
         AsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=laBiheI0U75LASrHjB6ZdZZMpe4PBQO0pkzvkJ7BACU=;
        b=z1O+I2ne+RnfJZVdk4BjO9zPg8EzjyOcqJRJMlWeS20NCreOhG8Z/qjALzlWy1VPYD
         q+o+d5DcQ+Nq4FPO+kOUS8FIf35ZGdIqOjEUSsTEYPQU0aDabk/ccEeLEj3ksfvdzT7p
         ZQsdUvbc6ZbhzonQ9mxa/QcpgVFm9h3KGsTtFFNvi7iglYqbJHVpkKZ1nXROX3Y6TI4j
         WSkbnjM4I2IXwUn9LkQnZdrjg2Wwjkux47rIbRa546QZ56EbNYbbDuBjaiuiTa8yj+qQ
         JZuln9jk7YPdLDPghI73qusQkWGGFlWKkkgVTstYx4KUEPFm+d3/M6m7ITZr8erZgq8v
         Xkfw==
X-Gm-Message-State: AOAM530iB4MoMGjCLNqfg8/z5wZkH246PyWds3Vc76sRAigFRatwY5iT
        oLeSm/8Khyq2k1fmQVXVtxV9+1OpPuN2Ew==
X-Google-Smtp-Source: ABdhPJzUC30k74cycMu9f4Mp6MtRykBINJsEHSFD9PcJj5evGPN9Hbr/wtuK/7K6Ga/Tdb5i/Zq+ZQ==
X-Received: by 2002:a05:6402:d0a:b0:421:10e6:2ecc with SMTP id eb10-20020a0564020d0a00b0042110e62eccmr32710929edb.329.1651088203273;
        Wed, 27 Apr 2022 12:36:43 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id kj11-20020a170907764b00b006f3a41bbdeesm3811224ejc.38.2022.04.27.12.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 12:36:42 -0700 (PDT)
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
Subject: Re: [PATCH v4 30/45] media: sun6i-csi: Introduce bridge format structure, list and helper
Date:   Wed, 27 Apr 2022 21:36:41 +0200
Message-ID: <1787704.atdPhlSkOF@jernej-laptop>
In-Reply-To: <20220415152811.636419-31-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com> <20220415152811.636419-31-paul.kocialkowski@bootlin.com>
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

Dne petek, 15. april 2022 ob 17:27:56 CEST je Paul Kocialkowski napisal(a):
> Introduce a more informative format list for the bridge, with
> information about how to configure the input. This separation will
> later be useful when using the bridge standalone (without capture)
> for the isp workflow.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


