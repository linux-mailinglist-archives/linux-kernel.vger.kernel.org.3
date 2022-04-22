Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7E950AD6D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 03:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443178AbiDVByT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 21:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443166AbiDVByI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 21:54:08 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB7445AE4;
        Thu, 21 Apr 2022 18:51:16 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id y10so13444012ejw.8;
        Thu, 21 Apr 2022 18:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TFQlpl9deOkAkOVT5XU767DOfmRsCkmcpCKpj/FM00o=;
        b=HtBLJDrnKZkLHSTtcZMK/w1B2Ojgs/l6YjOmt2N70g0hqIQTKWaoDKPVBbTFdsptFQ
         Kwqlxhz5lPC0dyk+9gexfsCau5lIgZ3qnNbRFSL90uSR6W4uSicgwAwK5D6P2pd0Ar7R
         CU5R7f1nheff4tVq21PfQY6mnea/IEb+bz/fB7UleDT2v5XDVxKtvl6mTMOgmu618woP
         z+waPKj4HvLG6q3wyIRFsGQbLK++X+BNkbTVQKsLOjfpS1tgniCclQWzdsruf88yWOEk
         /h3RhqXW4fEO2gClG0Gpt9izqdkdPe/ZoNQHNlOH94dc2X1gGxra2p1TC4pp5JNNVPDC
         pFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TFQlpl9deOkAkOVT5XU767DOfmRsCkmcpCKpj/FM00o=;
        b=76uEY52Fsl+cOHaJVtDFK553pQSLYJVeKj55TYs5Et7LTHeURufEURyBEDmM/gvIKt
         5uXaHR9cttrpreVxQvOqaNEAh5lgnDCrIjEcIA4PXc8LrIswUGKQaDbnCiLkYByfVtnF
         kay1T+q//aITaqfbGhrITtAtNRjfcj+QSHjU1t8cJsnCzyZdoBQhHcBxqLxfw8kPpJ24
         Gr+eaYo8DHHgCx4v5dK7V6XP48UJGNiFNIdnCzzys4gLZd/3sb+AEi+0uE/y6QegPcDi
         EofLTw2k/RKVgE9J/rHG26SVa0R2qEJpVmqw70Lg8Ys3VIlVD2V31Ol/EfXHPBzkufrs
         Ekiw==
X-Gm-Message-State: AOAM533whIkp2b4ik6OgXdOolZMvX2d//+yKt4YCEHvjYnCG4ktLgLZU
        Yr7MptgXpZS1ybHiHNRs1yVr7U/GrE/F+mp/VbM=
X-Google-Smtp-Source: ABdhPJxrPqlVsehwWxOIpbFwe297dm/XIP093ZxcMHxVDqzgceV1CkPOkLoE/eBShwquZ+pV0Iq1Ihzu7nuNZpxoGYw=
X-Received: by 2002:a17:907:2ce4:b0:6ef:f141:406d with SMTP id
 hz4-20020a1709072ce400b006eff141406dmr1974782ejc.214.1650592275157; Thu, 21
 Apr 2022 18:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220422014157.8200-1-ming.qian@nxp.com>
In-Reply-To: <20220422014157.8200-1-ming.qian@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 21 Apr 2022 22:51:04 -0300
Message-ID: <CAOMZO5BPjU0WCU4CMKH5wfbWrqJQS-5AcNZyUpuEpOp6gr=R6A@mail.gmail.com>
Subject: Re: [PATCH v3] media: imx-jpeg: Encoder support to set jpeg quality
To:     Ming Qian <ming.qian@nxp.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        mirela.rabulea@oss.nxp.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 10:42 PM Ming Qian <ming.qian@nxp.com> wrote:
>
> Implement V4L2_CID_JPEG_COMPRESSION_QUALITY
> to set jpeg quality
>
> ---
> v3
> - put this v3 information below the --- line
>
> v2
> - free ctrl handler if error is set and return error

Wrong placement.

>
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---

It is after the Signed-off-by and this --- line that you should put
the version history.
