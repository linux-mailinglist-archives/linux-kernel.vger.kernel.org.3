Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EBA50AD31
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 03:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443048AbiDVB1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 21:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236892AbiDVB13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 21:27:29 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29EC4992C;
        Thu, 21 Apr 2022 18:24:37 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g20so8652912edw.6;
        Thu, 21 Apr 2022 18:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z+C/2AStLHsKVWG8m2926trugTpWytbc7cU4gGlc+LI=;
        b=J9unFYaqkndh/YrV1vvDKlXNLbnuqjdkfLJyUGdk1nSNKrZ9wV0xkQj0ong3i/zGEE
         z3Y9RYs+tFqYJCYtlVG3eko7T5TCtnPCw5JUKluDPILArlFJS+LL58ajPd1Tt3lKtoR2
         IBDm/igTtHHWtDjCRGpFt+5uPUt7TjAye2MRqokuoZk7/smCjWKqsgwwfglSO9YwLhN0
         XUSuR023vsH12d+/e9rnXMBhRP7R7aGL3OZCwXlIu7F+JcSkpIuGpDeDBHPTysbwkizR
         plK9QaAYHQgZ1w6ktM+Aq52CUOUgxwOYNo/13JpejfjW5WZKxbulJJsAos0x2EgQgrCt
         kKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z+C/2AStLHsKVWG8m2926trugTpWytbc7cU4gGlc+LI=;
        b=DSH4gAlIIHssptGSBYaFV0H9rvuaITGq2lVB0d3QpMDikC/Gav0iI8xzknjZSiVA9P
         /t1ebajBt8sjR3ylh3+KpNCLu+4VT0Wbe2ZbH/Pdi/eMbHVlAhhFHQ42bFHYxa4GOlQk
         ghYuN13Wrnbhgx5i0i7e3GIX9jOBi2Gn3+5tSLePZnuNd/YYP6J1xSYV1t1SmkUZMuIn
         ID5WvgkCYp/oGkhb7G0WMjH+F51Yt08AZCgnMvHeJ7oMy7fX1JxwkKTzqNdWGBYkH5DI
         BEuL2bYh6ShCc+PsHODLHrdr03htgcxTnSOvSvO4D/o/LoA2ojJuN8659OtjYzu360MU
         pNog==
X-Gm-Message-State: AOAM530sa2Ns2n9mHE/zKGeRoA+bKwbxLON07aKGd5588RJQRXeEgPdD
        kETQGQRyX44HKrcBH5VwFGQDUbIkDIcohpFOy4Lkd4PI
X-Google-Smtp-Source: ABdhPJwnKTdqgytHtYBxF762VhE0kB7qKCIgfao+yz90RtkDLABN5ZhqTls2zAs8/kDo1ghGylLHc2TtqPSv2RphUIw=
X-Received: by 2002:a05:6402:35cd:b0:423:daf3:f7a3 with SMTP id
 z13-20020a05640235cd00b00423daf3f7a3mr2379762edc.77.1650590676509; Thu, 21
 Apr 2022 18:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220422012133.23079-1-ming.qian@nxp.com>
In-Reply-To: <20220422012133.23079-1-ming.qian@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 21 Apr 2022 22:24:25 -0300
Message-ID: <CAOMZO5BsBqyOHb0_iCsm3nWx33a=xuk3xpha4c26Pv6=VC8_Mg@mail.gmail.com>
Subject: Re: [PATCH v2] media: imx-jpeg: Encoder support to set jpeg quality
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

On Thu, Apr 21, 2022 at 10:22 PM Ming Qian <ming.qian@nxp.com> wrote:
>
> Implement V4L2_CID_JPEG_COMPRESSION_QUALITY
> to set jpeg quality
>
> v2
> - free ctrl handler if error is set and return error

Please put this v2 information below the --- line.
