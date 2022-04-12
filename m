Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9574FDEDB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347139AbiDLMBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbiDLMAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:00:44 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACCB1F601;
        Tue, 12 Apr 2022 03:55:42 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u15so17878789ejf.11;
        Tue, 12 Apr 2022 03:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fn29cqYC0atrXC2HZopuyzaHKcIU2fvMbZuEnf/kPAQ=;
        b=JRCyF4ex8TlJnTmlTsb3ulZNbME5xBlE5+4wzZYj+RLEjBItexYJpMLbBLDrropR4z
         trvINKtGO2Car7nMpEZa+vKp9VhZ5UNhxMm/lQK1Ah9+ZbL+bhYy6fxPGEuv3M6/dP1l
         +kKn2Y60WYmiBNRk6Pj6PStGdCxXYHRUUwVZU+0Sx/6WaIMU8tMlSp2eqXW5e2Po2rPe
         EqDEJmP4NdvTP+uPgiPLXMzqQI+XE7hNEq82Py3M4RZ10EwZcNFuPV2Es/rcfmTVeOEs
         wdhNuA5woLJpeNvuPkeNoTkc1PFsc38pp4gqxprNhB7AQTgyT/DfRYj4YCzz2JKz4G6v
         WQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fn29cqYC0atrXC2HZopuyzaHKcIU2fvMbZuEnf/kPAQ=;
        b=g0tASio+t26OhhBO0zUIujOPBH8+vN2Vddwwmbr9Y/MpmAlqXiXFY3EQC0I1kkY2iL
         SMTsgeDRZR0Kc3Kryk1GBg7kTloDeld0K2wGiJbp1QsJimQCsm/J929csrON81YCwioP
         +/mr7SpdyNc8SvOjEq03rIr5E0q/zMRkOzhjm58llb3hGEMowGRQK0bgnU0WLPk01l8w
         E67W6ATm6kSB+y/ecACDvmGwGNrXO81kV36sbZNSu+JTuJ05Otl8Gs7ZQgW/8xVJ3sm9
         CUEVTLX+wPBFeRZmrQRoWSZsdBGzAjn8ZivsQRoZq2Kvtbe0/p58R4LQ13jhs/3awOAc
         p4eQ==
X-Gm-Message-State: AOAM53335ROWo/oxxwM821fVjSojMvHkXznVMdUZFKpol9Z5/WKVd/7G
        mrgcOttBVUXlcJ9JOMMpUUezEOzGpKs8+XaoIkg=
X-Google-Smtp-Source: ABdhPJyjzvGqPY+gnwH4sveQoakTbAJ6h+sJUMWvfwHh4zKiONQJ4MlBbgXP8I9dUgSUd9HF5X043HO0zcdct3S0S50=
X-Received: by 2002:a17:906:2646:b0:6d5:d889:c92b with SMTP id
 i6-20020a170906264600b006d5d889c92bmr35177396ejc.696.1649760940868; Tue, 12
 Apr 2022 03:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220412105156.17091-1-ming.qian@nxp.com>
In-Reply-To: <20220412105156.17091-1-ming.qian@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 12 Apr 2022 07:55:28 -0300
Message-ID: <CAOMZO5DWPaSCmc9RivqmCQHu2QaiBs5Kirxjm7WezpnUSKwUag@mail.gmail.com>
Subject: Re: [PATCH] media: amphion: fix decoder's interlaced filed
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

In Subject: s/filed/field

On Tue, Apr 12, 2022 at 7:52 AM Ming Qian <ming.qian@nxp.com> wrote:
>
> For interlaced frame, the amphion vpu will store the
> two fileds sequential into one buffer, top-bottom order

s/fileds/fields

> so the filed should be set to V4L2_FIELD_SEQ_TB.

s/filed/field

> fix the previous bug that setting it to V4L2_FIELD_SEQ_BT wrongly.

s/setting/set

Do you need to pass a Fixes tag too?
