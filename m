Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904A55003EB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 04:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239597AbiDNCCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 22:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239659AbiDNCCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 22:02:40 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE25C240AA;
        Wed, 13 Apr 2022 19:00:17 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b15so4575736edn.4;
        Wed, 13 Apr 2022 19:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mzy8p6ylpz3ALptHB52idnlk+pntJDKWqrrnSPC71OY=;
        b=M6+6mBUbVIlnOhsmwOzRKzwEBhGLQK+jX4XzsmKSe9js9+BK+pqxc6SFObubuUN1jt
         iUdCyVDcVq+25A7FfkUpSApI5oB+fP5gf6SnRaqUceePHKcYyVGBLZbuVqO57UuthDmx
         oX4HwinZUGlGszx+0WOveBIxvc3S8NzoDHpk28QT6Vby+t/oiVtkaqFDaFEpivGarcs7
         XGlFr67hwn8hsW6j2oQ4KobytRYnYEI4Y8rLwE2EN9RPtNkKM1M5aGQ8xVu4DHFJHiJB
         gx7rQH3/Nt3OhgBBIBFrw3MgtTekC7a97JJl5eDrCdKAZIDOKD6chafhWktTbW5YQ0uP
         LM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mzy8p6ylpz3ALptHB52idnlk+pntJDKWqrrnSPC71OY=;
        b=sD+XBCsnSUzmufpAalf4LwGJub1/k1wR9z7nZo6Hch+JYcN4/dFT2fRrZuMYH0iTd5
         bfXEU7cCZZDaP4Rsjw6CYzBKZVcJu6Fw3XNFSq5Sdw0kbAGdjEf/+jX0RK+V/g2/iQ2l
         TBpIFmWinuzrLD0IrSx8i97kfISxBzZ09Npe1kMOpnFuOnsu7ciI8RIwgMhlp3XmJJ61
         vaFtIC+4VQ9QyWb2x73JHa8ImB3dmiGYiJQZFYSau20T/nk1xAVmgbHFf+De3RtHWj0I
         rNEekc/Sut4on2c75AmMeAiOi3GmXDAsjkfDO5VqeN2KJXnedM8a6seRDH0GXtsGZpPE
         I56g==
X-Gm-Message-State: AOAM531rKNHOH8JElMh0n+bwywKWscU/9tTvjUOuyMZPF4VXR8yAXLDb
        tx7+CuaBm4UFiGno0kbwb1VxkHC4u1RQKieAi+A=
X-Google-Smtp-Source: ABdhPJw+ZS14ItYl7dJ+hSPbTDwNRId8Xa6zYNQ/DihmEtkSckWz46njBRgo5b6TeK1YE4uQ7vhlE8PU//PG/6515wM=
X-Received: by 2002:a05:6402:11cf:b0:41c:dbc7:79d2 with SMTP id
 j15-20020a05640211cf00b0041cdbc779d2mr539193edw.50.1649901616569; Wed, 13 Apr
 2022 19:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220412110155.21427-1-ming.qian@nxp.com> <CAOMZO5DmvVJuBU-PzrJ+ru1C3sJPtHshmtxmcAZPTu-p56SAKg@mail.gmail.com>
 <AM6PR04MB6341E52AF70FD61EC96DB58AE7EF9@AM6PR04MB6341.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB6341E52AF70FD61EC96DB58AE7EF9@AM6PR04MB6341.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 13 Apr 2022 23:00:05 -0300
Message-ID: <CAOMZO5BUPbmsBDf1yx3QnoexbyW4=vb2HNE733F0Xb1P7-VTHg@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2] media: amphion: fix decoder's interlaced field
To:     Ming Qian <ming.qian@nxp.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
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

On Wed, Apr 13, 2022 at 10:52 PM Ming Qian <ming.qian@nxp.com> wrote:

> Hi Fabio,
>     I'm sorry I missed it, and would you please give an example of the fixes tag?

You should add the following line above your Signed-off-by line:

Fixes: 6de8d628df6e ("media: amphion: add v4l2 m2m vpu decoder stateful driver")
Signed-off-by: Ming Qian <ming.qian@nxp.com>

The Fixes line should be in a single line, not splitter in two lines.
