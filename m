Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEC65928CD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiHOEat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240751AbiHOEar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:30:47 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF8BA198
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 21:30:45 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-324ec5a9e97so57082047b3.7
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 21:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=pS/J563nsROKwWCcFt312kEX1dX32IScrFxHX9cd9mE=;
        b=oDAqe7WvWsUaLZzZ1mQI9J/25o3q3Z/c7gFUwL40I9vndOqvwbHhqwUbtzmVQt6Auh
         bhaYRN2yJgjzDtgXnVu1JSLUi/lF+48CZPPhGu6cpq6tG03AbR2hdQ5blAbFVFmuQIrV
         EBpJM1qcpRfTpRoklUZeQtbfZrisGryTJspCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=pS/J563nsROKwWCcFt312kEX1dX32IScrFxHX9cd9mE=;
        b=dJlj1kwu/DDVLIIlK0XZASkG6GKhdjb+0g1UHQzZRY45ZvQ2Wl3Yy/hKMiDYeX5H5d
         eBUsMCCA5YuxnmFVFWH3UOJQWNWTiueDbwdk3LvRAZWpiND/vZVjtIyAWRpxSMbCP+lv
         zp9I34IyNUx5ofmJ03nfph3VOcDtHEOEFgoNmBj3/wqrNTgFkaUAuvDCzYu9xM9slVxc
         rPPLSHaN0hn0ITiLFSN3WZRxS3KtDDia5vhop3h7AB+FDxnMvw+T3yP3tFhrQHoxV/na
         yC8hb74nzf6Y1z0qj61/zQ+/Vg3WLWozRTZt7vQSOLntgs3Jyv3mIZvWtZMqjR96+Bc5
         RWXA==
X-Gm-Message-State: ACgBeo2FUMYIx7pfVDIE+fsKj1w8aidyGZHlX3kJHT5YgzzPIS2W2GIK
        /fR2PfFQDyc05LYYzfOlAR85ft0gO5vDjMiHp/pTBA==
X-Google-Smtp-Source: AA6agR6W/M9L7L4eD8jOBXjP/OWE0JpOBHM+bLbd7tMKbs8AZ+hlwifAEBSwzuC0AYJ2vsNzoqQwmlO3CeXXoICSoqg=
X-Received: by 2002:a81:7c54:0:b0:31f:61f9:f2fb with SMTP id
 x81-20020a817c54000000b0031f61f9f2fbmr11659697ywc.260.1660537844837; Sun, 14
 Aug 2022 21:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220815030740.28899-1-yongqiang.niu@mediatek.com>
In-Reply-To: <20220815030740.28899-1-yongqiang.niu@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 15 Aug 2022 12:30:18 +0800
Message-ID: <CAJMQK-hfWM-o+MsA90PCqZyOxvXT1Tc6jrxSvgFPAqAkU9C4+Q@mail.gmail.com>
Subject: Re: [PATCH v1, 0/1] fix gce timeout issue
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 11:07 AM Yongqiang Niu
<yongqiang.niu@mediatek.com> wrote:
>
> base linux v5.17-rc1
Can you base it on newer version?

>
> Yongqiang Niu (1):
>   mailbox: mtk-cmdq: fix gce timeout issue
>
>  drivers/mailbox/mtk-cmdq-mailbox.c | 57 ++++++++++++++++++++++++++----
>  1 file changed, 51 insertions(+), 6 deletions(-)
>
> --
> 2.25.1
>
