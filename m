Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F4750E5B9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbiDYQ3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243527AbiDYQ1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:27:53 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F9311F95D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:24:49 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id a11so4030163pff.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fy4scNdR+gQe8khm9Rf8E41vItskGz3mg6jdYBjtzmk=;
        b=MAjwXVtS0TOSth3fYjCdTEttJJ5Dk25IYowuZJb4odyaSAWH+UPiIuqbb9ufRknlu3
         KbXXbzOG5/8YVBro2WrgjiRxZ1707r9gW13Jr6pxpFmEPVoo6nomoygPlXyEwCnF2KAA
         a813mlSQSL0uJ+Q33IarwNSLZm2mcPaeQfhavx7/bj5+eOhuuTx8m2MLaBkZRaQ+uEF1
         /Y6IzkWpvj9pXwUmT1X2C3rZUu+YKuu06hlk1Fj1IbgBDYzAhGK0rEqh2buOuUKDhKTS
         kc5H4g8dCAaCzwiM4MlE+o7aEdByk7yNeVleJj9LVZ0tJvFYiLx+PH7RNz5K06wbhHgR
         +DvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fy4scNdR+gQe8khm9Rf8E41vItskGz3mg6jdYBjtzmk=;
        b=AEaaByHAyP3aoU7mo3ZvmGBM7uikOULQS8UDBNB4YjAzJWjwaXlY4SHqaDizMdKGy5
         oqHN3tJUDkj8B/pjOLkK9qeN+HD5VrMMq+fgDZuDlaiYYBaKYY4U8Nl5cytBj+R6/gx/
         OgceYmIl85RqjjnLoSWzbJdUyLN4yqIAiFw93sa/t7tSJUF0waBd5SJgPcDewbA/7cLe
         CvuGMWss+Fa6Q0NYcr9PrN8LmNXjjsp0YPz8JbwnVUUHe04jvMIHsTdxmfBaPqTg+c7z
         ABpz/BTQH3HPgtZKabM8RF/M+woNVm7RLrnWJ3Fl4g7HfBnQEMDd+uD0e6h0ZvgjyGvE
         AP5w==
X-Gm-Message-State: AOAM533hilH4h2T9vSsHX1C0rNmdkHGORatWEQMtL6NFX5Ox+bJbeQ6/
        GDQde/naJz7hb43UhWwK5Kq7tQ==
X-Google-Smtp-Source: ABdhPJy3+eXGqclAEFMNVelhhNbF0vgEqU5TGB4C+yC8sRaVH5zFyeHk8OdGfj3X4QNhjN1GPpxDCw==
X-Received: by 2002:a63:a61:0:b0:39c:b654:b753 with SMTP id z33-20020a630a61000000b0039cb654b753mr15440285pgk.117.1650903889024;
        Mon, 25 Apr 2022 09:24:49 -0700 (PDT)
Received: from hermes.local (204-195-112-199.wavecable.com. [204.195.112.199])
        by smtp.gmail.com with ESMTPSA id u2-20020a62d442000000b0050d404f837fsm3822645pfl.156.2022.04.25.09.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 09:24:48 -0700 (PDT)
Date:   Mon, 25 Apr 2022 09:24:46 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Wells Lu <wellslutw@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, robh+dt@kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        pabeni@redhat.com, krzk+dt@kernel.org, roopa@nvidia.com,
        andrew@lunn.ch, edumazet@google.com, wells.lu@sunplus.com
Subject: Re: [PATCH net-next v9 2/2] net: ethernet: Add driver for Sunplus
 SP7021
Message-ID: <20220425092446.477bd8f5@hermes.local>
In-Reply-To: <1650882640-7106-3-git-send-email-wellslutw@gmail.com>
References: <1650882640-7106-1-git-send-email-wellslutw@gmail.com>
        <1650882640-7106-3-git-send-email-wellslutw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 18:30:40 +0800
Wells Lu <wellslutw@gmail.com> wrote:

> diff --git a/drivers/net/ethernet/sunplus/spl2sw_driver.h b/drivers/net/ethernet/sunplus/spl2sw_driver.h
> new file mode 100644
> index 000000000..5f177b3af
> --- /dev/null
> +++ b/drivers/net/ethernet/sunplus/spl2sw_driver.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright Sunplus Technology Co., Ltd.
> + *       All rights reserved.
> + */
> +
> +#ifndef __SPL2SW_DRIVER_H__
> +#define __SPL2SW_DRIVER_H__
> +
> +#define SPL2SW_RX_NAPI_WEIGHT	16
> +#define SPL2SW_TX_NAPI_WEIGHT	16

Why define your own? there is NAPI_POLL_WEIGHT already
defined in netdevice.h
