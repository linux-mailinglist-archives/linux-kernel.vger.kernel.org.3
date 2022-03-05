Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0CC4CE789
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 00:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbiCEXFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 18:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiCEXFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 18:05:50 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17E82BB1D;
        Sat,  5 Mar 2022 15:04:59 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 15-20020a17090a098f00b001bef0376d5cso10995866pjo.5;
        Sat, 05 Mar 2022 15:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZubhIdZTeko7cYjTeoqS5K64c7OG8apxg678QISjqVw=;
        b=M4vlbWoHyEUiJdWodFBETTpRkW8Lia1ewznQNG5VLa+9O7xIeMV27xIc1kD7ofPyCv
         cut6Ps5wBEp1MKOBdN3VlAa8PUB4htLCUK+bdkjeYGvzTYeNRHMUb65YqdK3yxoOPczh
         lUC47inGFXLqvdcLidBQrGI81UsuDGgrETkdXLw5jB9DT7Nshtx4/dFVBndGqGxSA8Rc
         SIcbFBg3udsK19BHylIszEkQzicgnumtj+Er+eYyGUCwlEYKC+AEBySniyUBRLGOFG2B
         SdkB8++j9FakmxulCZ0xT1F7L4CP74kSw7AWBNE/WG92g1Xmg7ya8WvsyAL2iG+5+Qr+
         TZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZubhIdZTeko7cYjTeoqS5K64c7OG8apxg678QISjqVw=;
        b=BdI3yLkB6u9Tko5F7vEesVEnvdjsXF272NNbtdJGNcxmtWQzJrY9Qwl+nYzieySoAR
         ha9Kk1hdwX2FiPhT/J3/wfCpBlZDiel9Rm8nk5+uv6Vu3Qget4BaE1GZn7v8+roRdFVQ
         s6O31U6mlj6AfTZTXq1Q99L1w9CbuunyxoqxsxKLPOWA4gFZO4szZB9bTSR+ViFjchaU
         F07o21kdRYlaGNyWYrzdDrGj9fAJffoKW1XMtwai4F5N9hE2nrUOoVucAcqaMK2E0MNJ
         ZFzpEr8pCMfX40P7hN1PXD/FrIYvwx9oiVGzT6ISplMgDh4nG22g1dU9KFKHSiOzUtfM
         cyag==
X-Gm-Message-State: AOAM531iSs7DyZtcxi2OWa24pLiIcbZBCmu+v8F/jHeClOAPJ8p73MAi
        N7dWvaoWQpPmIigD8Lciurta+vp77WU=
X-Google-Smtp-Source: ABdhPJzS7Zrz9TMo4WrLSBC+Wf80rAguG99nRWBRJmBaAMn9RulsBBVDVLRBgHNWBxkrenhhT/Wo5w==
X-Received: by 2002:a17:90b:1648:b0:1bd:28ac:859d with SMTP id il8-20020a17090b164800b001bd28ac859dmr17660118pjb.59.1646521499026;
        Sat, 05 Mar 2022 15:04:59 -0800 (PST)
Received: from google.com ([2620:15c:202:201:15af:5d15:3044:acb9])
        by smtp.gmail.com with ESMTPSA id h3-20020a056a00170300b004f104c635e4sm10739527pfc.99.2022.03.05.15.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 15:04:58 -0800 (PST)
Date:   Sat, 5 Mar 2022 15:04:55 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fengping Yu <fengping.yu@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v21 2/3] Input: mt6779-keypad - Add MediaTek keypad driver
Message-ID: <YiPsl41Sawjlc2E+@google.com>
References: <20220303154302.252041-1-mkorpershoek@baylibre.com>
 <20220303154302.252041-3-mkorpershoek@baylibre.com>
 <300114e2-6794-db3c-a51c-3f900b6476f9@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <300114e2-6794-db3c-a51c-3f900b6476f9@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 11:31:38AM +0100, AngeloGioacchino Del Regno wrote:
> Il 03/03/22 16:43, Mattijs Korpershoek ha scritto:
> > From: "fengping.yu" <fengping.yu@mediatek.com>
> > +
> > +static const struct regmap_config mt6779_keypad_regmap_cfg = {
> > +	.reg_bits = 32,
> > +	.val_bits = 32,
> > +	.reg_stride = sizeof(u32),
> > +	.max_register = 36,
> 
> Are you sure that you can't use .fast_io = true?
> 
> Another version for the same question:
> Are you sure that you need to lock with a mutex here, and not with a spinlock?
> 
> Since you're performing reads over a MMIO, I think that there's a very good
> chance that you can use fast_io.

I think there are good ideas here, but they are not critical (this is a
keypad we are dealing with) and so can be investigated at a later time.

I added reporting of EV_MSC/MSC_SCAN as it is customary for
keyboard/keypad drivers, and applied the patch.

Thank you.

-- 
Dmitry
