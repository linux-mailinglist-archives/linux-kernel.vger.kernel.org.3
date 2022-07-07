Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3FB569D84
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbiGGIgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiGGIgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:36:38 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682D6326D5;
        Thu,  7 Jul 2022 01:36:37 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id n12so18048894pfq.0;
        Thu, 07 Jul 2022 01:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bbHqYuBn99/DfkRvYwDANfs5Ue+qL8CDS8Gq1N/QC3c=;
        b=leOp8aP0C+gnUlK1n50j+dt/zeX94akVOP7HCvSF7uKiLRlBDKC8JD44AhMsxPkOag
         7mhMjYytI56DhkOlGXsCGPzPuMHP47+mSNCCRT9iG092+bi2RXYSG+8H8XcseOI7764V
         M8PfOG7qMjX8I9jlOwShgIpkeY/xKNzN7OEymVF02nCU81dduZW8p8fYAjcaeN2NEDUg
         yBIc7Ah+XhQ2g4trwoiwk2aUdBYceTnW4WXLYRDk4hKfRKzhOYPCVVhnlE1oGkbdWpGO
         GJT/zb+i3dMRr/0HjEnoJFTvT0skB9ckysIGehN4SZya5dZ2ANYB+lkaZj1nBHsAehP2
         Jw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bbHqYuBn99/DfkRvYwDANfs5Ue+qL8CDS8Gq1N/QC3c=;
        b=TaKAqDWRlm6dBXAK0fw/uU3v8L1D8dOib2SX6lsd3mp5vMpf/htSSCF7vY/yyAYch/
         TBYMtYa9BOxLYpdmLuIiw3J9U69mbesppdSl/gG3+MqPtrn2xBBvUYAfLEucqt5T0w40
         UG77kH8f9MNWHPzK9IKHnRFjqu/dnW2QhACBV9kZjXq355j/mYDUTkaEZmryLAVoTpSV
         tPXeKorcLzM3G70h43eq25QN/Y1sIP9pRKezy6T5/XAIm57QaZ/azlIZqsZ4+HfH9Mij
         CkrpeZ5K6eiPH1PF6ndA/9lPrdwHDdf1jsieQhFdPKw0zLukxTklWGZzRgJzUkbxYCkO
         aTRA==
X-Gm-Message-State: AJIora+JrMLslzjaCW81VegBflv80GBaJW7ECz9bvqx2dsj2j5Xj9EvG
        s3aEK0I0BUYjCjhzlSzCTTHOfUFqO9mDfqhMmZk=
X-Google-Smtp-Source: AGRyM1tzr0TRNmLKst9jt5mDGNc1x7oAlPI16O1qUxNPaloXnP2iRsJ/o8KTnvlOzFFCcsmtajTjvbdhutypTbYn2N4=
X-Received: by 2002:a17:902:7807:b0:16b:e3d5:b2ce with SMTP id
 p7-20020a170902780700b0016be3d5b2cemr20794908pll.18.1657182996863; Thu, 07
 Jul 2022 01:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220623103543.4138-1-yongsuyoo0215@gmail.com>
 <CANXPkT49g7_YaL3rABY5Uhohz=EPgPqOL2tb6K4SHsWmshtysw@mail.gmail.com> <a3d44193-68f1-81a6-6baa-19e8403c5cd6@selasky.org>
In-Reply-To: <a3d44193-68f1-81a6-6baa-19e8403c5cd6@selasky.org>
From:   =?UTF-8?B?7Jyg7Jqp7IiY?= <yongsuyoo0215@gmail.com>
Date:   Thu, 7 Jul 2022 17:36:27 +0900
Message-ID: <CANXPkT6cffk3uQm6fRiPpe2rvHzzvDKgwhYnQh+TVcBo_Dw=uQ@mail.gmail.com>
Subject: Re: [PATCH] media: dvb_ringbuffer : Fix a bug in dvb_ringbuffer.c
To:     Hans Petter Selasky <hps@selasky.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     =?UTF-8?B?7Jyg7Jqp7IiY?= <yongsuyoo0215@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Hans Petter Selasky
Thank you for your response and good advice and informations

Dear All
How is this patch going ?
Is there anyone who can share the current status ?

2022=EB=85=84 6=EC=9B=94 30=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 10:42, =
Hans Petter Selasky <hps@selasky.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 6/26/22 23:11, =EC=9C=A0=EC=9A=A9=EC=88=98 wrote:
> > Hi ~
> >
> > How is this patch going ?
> > Can you share current status ?
> >
> > Thank you
> >
>
> Hi Yongsu,
>
> Linux guys can sometimes take a long time to include patches speaking
> weeks and months. For now I've added your patch to multimedia/webcamd
> (v5.17.1.1) which runs under FreeBSD 13.1 (not Linux).
>
> https://github.com/hselasky/webcamd/commit/0e4d4959a2aea2e6a88d316eb94359=
2fe0b23d09
>
> --HPS
