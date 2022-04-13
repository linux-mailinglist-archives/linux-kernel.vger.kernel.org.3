Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA564FFDEF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237731AbiDMSjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbiDMSjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:39:02 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC7250B1A;
        Wed, 13 Apr 2022 11:36:41 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id p15so5732307ejc.7;
        Wed, 13 Apr 2022 11:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J1PlCMZX7SWSpw/ifVTUvcRQYJHb8jUnJb9fn2d8Sok=;
        b=RgKwgNMRmVs/kO4s0aASXYevSF867Y1oXXKamgIFswYelSRwOmgv5eyt+QdGQa9tI/
         8w6t3tDI2haEbhbrjpVu+quFlOryMoEkDNTzA5xnOj3QU/pU3aE24k1QV91/h7xayU/f
         fe8vY4vbTlv4wiPhDWOA8x3vA5cE3RER6ybyearp6qlni029skORswFAVhkgyMHnIFDG
         3blqF2tPBdCXtxJqf973GeXkCPJEJu4NjY7nOI+l33iL8d+Y55qO0ktq9hGPVju0lzTp
         w/74kBC+ShcSyuljlZ3MG46KpYrfJy1i8/Gwg7lSaF/SwLU3Hrq1qWEUrlCev1c2zYtp
         o2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J1PlCMZX7SWSpw/ifVTUvcRQYJHb8jUnJb9fn2d8Sok=;
        b=kgTh3m8CVOyXX36GoBzPrcguoK+xUsF5MSYJuVWHfj4zQbpmsNw7uOn6iHDUsCZHa6
         iSXxO3B5ImUfVA5VAVcjOpK5jAnt/ZkDpo2cDHvROLy6v2VrV7oQ/qoRPyxv8rw5x3qc
         SxwsY44rKudPlp3wfhsJv8V+I85NqEbENitEsAhFct5zmb+0GQgpgPQosO6zibvIQ9JQ
         duXsX83KC8EvYMzE0Ip1M2jt4BJs/xPZL7ThmW2IEtSIbqRoe9xMw0w1tUtP/oAQCwd/
         GAYN8jXY+1cDt1X9u24K1jEOjbkvePa1EeKTdzzfZqv5/gm4irgmTqwUYKpb4n4t8xux
         6Ldw==
X-Gm-Message-State: AOAM530xwjiTHbQBK3NUWsqH39CgVHTYMOg6I4usfZOblYBdtshms1Qr
        Vmeyn97WSuifJsrVWe8gvxvIcu/JLNgceC5UPfSjluct
X-Google-Smtp-Source: ABdhPJyrF2Llbu8dDK87n061FBPyXJV9I1rpC9peCTkToZ8AjI+EhMFFMsFkYLpzd63/ttZmkNW5dfkAAymj//f5kpw=
X-Received: by 2002:a17:906:2646:b0:6d5:d889:c92b with SMTP id
 i6-20020a170906264600b006d5d889c92bmr41339455ejc.696.1649874999587; Wed, 13
 Apr 2022 11:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220412110155.21427-1-ming.qian@nxp.com>
In-Reply-To: <20220412110155.21427-1-ming.qian@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 13 Apr 2022 15:36:28 -0300
Message-ID: <CAOMZO5DmvVJuBU-PzrJ+ru1C3sJPtHshmtxmcAZPTu-p56SAKg@mail.gmail.com>
Subject: Re: [PATCH v2] media: amphion: fix decoder's interlaced field
To:     Ming Qian <ming.qian@nxp.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming,

On Tue, Apr 12, 2022 at 8:02 AM Ming Qian <ming.qian@nxp.com> wrote:
>
> For interlaced frame, the amphion vpu will store the
> two fields sequential into one buffer, top-bottom order
> so the field should be set to V4L2_FIELD_SEQ_TB.
> fix the previous bug that set it to V4L2_FIELD_SEQ_BT wrongly.
>
> Signed-off-by: Ming Qian <ming.qian@nxp.com>

Missing Fixes tag?
