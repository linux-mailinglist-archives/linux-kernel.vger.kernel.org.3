Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D234BA490
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiBQPjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:39:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242590AbiBQPjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:39:19 -0500
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824ED2B2E2A;
        Thu, 17 Feb 2022 07:39:04 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id e26so6711679vso.3;
        Thu, 17 Feb 2022 07:39:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=RvXVlkDBm3gXJbfAMT6226p4FYJW+m6weZOm2mU0XTM=;
        b=eahcXwFdiKEEWJoByt1F1s7WSxVLAAhI48ek5bywTN2wFo8i/ygYx1dDmlcjCr66nx
         9cb2xxHBF6FEl+jaG+XSrlO+Fv/BaGi53KfQoGof/fiIS/nuUB6NW3iTfZB94d1vtY1H
         nhrmXLPo2e+df7k2rI/54xHue61HrL7P3uDDccf+Y2DVNRFfTa9wrD36/iaGn10hAdL6
         e3dVqP+Yy6LP6KHRmF482BiFBYjIsmwRoalFjAxNvZqOnC6cY5HXANmmbeNGbe/8Hv+e
         rPoBRHUwNpHS61NanEKdQM1SCoWNe7vNwFu6Y2bkewo9VSeXOHFAG2MinpKPbT7HjDYp
         W1KQ==
X-Gm-Message-State: AOAM530hSTVHFCLAGRM6/X+m7pXt4nbezgbdeB+OuZrbYhIk6Ht7cwKD
        na/fXNT5IS8+XS3+K9ksUYV0Cchep1Tb+w==
X-Google-Smtp-Source: ABdhPJwPcwkTiemGq33UeEIqiHyVSTZrLOLPHtWDxF/lBFovcbbMSDX5NL4RNLV2Cn/y+HU8f2oFIA==
X-Received: by 2002:a67:b00e:0:b0:30d:dc98:6024 with SMTP id z14-20020a67b00e000000b0030ddc986024mr1524168vse.57.1645112343497;
        Thu, 17 Feb 2022 07:39:03 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id b23sm111154uam.3.2022.02.17.07.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 07:39:03 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id e5so6653956vsg.12;
        Thu, 17 Feb 2022 07:39:02 -0800 (PST)
X-Received: by 2002:a67:f1d1:0:b0:31a:952e:77aa with SMTP id
 v17-20020a67f1d1000000b0031a952e77aamr1614262vsm.42.1645112342758; Thu, 17
 Feb 2022 07:39:02 -0800 (PST)
MIME-Version: 1.0
References: <20220217131737.10931-1-mans@mansr.com>
In-Reply-To: <20220217131737.10931-1-mans@mansr.com>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 17 Feb 2022 23:38:50 +0800
X-Gmail-Original-Message-ID: <CAGb2v66ngHoxgW9O_BU3Dr+nChiN6QcVgbDsncou9vpkgnStNA@mail.gmail.com>
Message-ID: <CAGb2v66ngHoxgW9O_BU3Dr+nChiN6QcVgbDsncou9vpkgnStNA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sunxi: do not print error message for EPROBE_DEFER
To:     Mans Rullgard <mans@mansr.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 9:19 PM Mans Rullgard <mans@mansr.com> wrote:
>
> Avoid printing an error message if getting a regulator fails with
> EPROBE_DEFER.  This can happen if, for example, a regulator supplying
> one of the main banks is controlled by a PL pin.
>
> Signed-off-by: Mans Rullgard <mans@mansr.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
