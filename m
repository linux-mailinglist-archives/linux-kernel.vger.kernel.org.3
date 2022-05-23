Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059EC531B12
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238984AbiEWQ7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238987AbiEWQ7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:59:06 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D554532E9;
        Mon, 23 May 2022 09:58:55 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id w2-20020a17090ac98200b001e0519fe5a8so2731902pjt.4;
        Mon, 23 May 2022 09:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7fn1yFxpVe/lx6SRRrqC5pO9JkynA3lVXz/276E/sVY=;
        b=TB6j1syu19Pk/CRBokAkVCLwh7Iroqg0r+rDrmviHL6ABD5eyvFuq6vkskf9zoALSs
         sx1A2nXlNkXcVooRfOGLcCwnl+VN7klMGiBUF9H42qvSyhtuUfH6+rPSCWrCF6hsNTqf
         Udb/2iWCSBABW3XSyQxjUhTl+R1MOR0Vnkd70/vimfTObURvmQKM7kZBE1HzjZNR6W4Y
         OGyR5BhoeBkzdPTTzorbEQTMeiuyHSzSvhUHhm+mOBQkWprm0leXizNCer2mZ/HL8ZQV
         taTmv+ORGQrCQj8jkoLTkmPROBfTd9oJ3gRxegQt8IdCSd8C/GWTPMQf0tBOiG9r9GSd
         G7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7fn1yFxpVe/lx6SRRrqC5pO9JkynA3lVXz/276E/sVY=;
        b=L24li8gNwER2tT3fgzi7ElY3tGhQ1izY5XA97lC7RPpanX6TLEkLqt83W2BGhNWMFc
         Ilt7cLBTSfOBiFOBMGzVqf+piIWOBUwFfL5ZqSmNOHyUttJ6e9zAbn0FPtoo/ny4OyWU
         wjbSDKxKrnk1OPn8/uhc5+ElW9ERf0sWEZ0fUSIWzndQxMOl9hDuhj75JH1NbYbx1In/
         ZuycQ+JdXaX6SicQxlPWb2DbnkdmXAV7ONfZ2SIPhdca/u4n3J3QkyEuuWURzfQMZB3w
         SPD8uO9pQ2RlcWh9ydXHXAkNx5j7tGNIHInJtE958M+NRi9VxPiOujyriR1viEzPAjyC
         e2bA==
X-Gm-Message-State: AOAM531ANCkHwsh1KHxlSMo7Edrxu0o8rED2snq6yY2Nqvvr4bZCHWRX
        bFO5OMz3n5791CgcZKiq0Uo=
X-Google-Smtp-Source: ABdhPJxv14G1AbpX6lfKccE6QIH5Vd/dtw1/hAcDrvzUHWqyTEAxRWPl8ZFaeBLEMUyFLdFoUur0pg==
X-Received: by 2002:a17:902:7597:b0:15e:b5d3:267d with SMTP id j23-20020a170902759700b0015eb5d3267dmr24016528pll.55.1653325134120;
        Mon, 23 May 2022 09:58:54 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:d84e:5dcd:9d68:ebbf])
        by smtp.gmail.com with ESMTPSA id 23-20020aa79217000000b0050dc76281bfsm7422375pfo.153.2022.05.23.09.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 09:58:53 -0700 (PDT)
Date:   Mon, 23 May 2022 09:58:50 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, mkorpershoek@baylibre.com,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] Input: mtk-pmic-keys - Use regmap_{set,clear}_bits
 where possible
Message-ID: <You9SjGt4UjJk17/@google.com>
References: <20220520125132.229191-1-angelogioacchino.delregno@collabora.com>
 <20220520125132.229191-3-angelogioacchino.delregno@collabora.com>
 <YosS0ZvAovyl8cF5@google.com>
 <926ce818-4f42-898d-aca8-185b5c7434ba@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <926ce818-4f42-898d-aca8-185b5c7434ba@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 10:58:47AM +0200, AngeloGioacchino Del Regno wrote:
> Il 23/05/22 06:51, Dmitry Torokhov ha scritto:
> > On Fri, May 20, 2022 at 02:51:29PM +0200, AngeloGioacchino Del Regno wrote:
> > > Instead of always using regmap_update_bits(), let's go for the shorter
> > > regmap_set_bits() and regmap_clear_bits() where possible.
> > > 
> > > No functional change.
> > > 
> > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > > ---
> > >   drivers/input/keyboard/mtk-pmic-keys.c | 24 ++++++------------------
> > >   1 file changed, 6 insertions(+), 18 deletions(-)
> > > 
> > > diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> > > index 8e4fa7cd16e6..83d0b90cc8cb 100644
> > > --- a/drivers/input/keyboard/mtk-pmic-keys.c
> > > +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> > > @@ -157,28 +157,16 @@ static void mtk_pmic_keys_lp_reset_setup(struct mtk_pmic_keys *keys,
> > >   	switch (long_press_mode) {
> > >   	case LP_ONEKEY:
> > > -		regmap_update_bits(keys->regmap, pmic_rst_reg,
> > > -				   MTK_PMIC_PWRKEY_RST,
> > > -				   MTK_PMIC_PWRKEY_RST);
> > > -		regmap_update_bits(keys->regmap, pmic_rst_reg,
> > > -				   MTK_PMIC_HOMEKEY_RST,
> > > -				   0);
> > > +		regmap_set_bits(keys->regmap, pmic_rst_reg, MTK_PMIC_PWRKEY_RST);
> > > +		regmap_clear_bits(keys->regmap, pmic_rst_reg, MTK_PMIC_HOMEKEY_RST);
> > 
> > Why not combine this into a single update instead? I.e. assuming
> > 
> 
> All downstream kernels (at least, I checked 4 different kernel versions for 4
> different SoCs) are doing these updates one-at-a-time, never combining them.

It is not like drivers in these downstream kernels were developed
separately and each of them discovered this as a requirement. It was
written once by someone and then either copied as is, or maybe
additional key handling was added later.

> 
> Even though I agree with you about one single update being simply more logical,
> I am afraid that (on some SoCs) the IP will not like that so - since I don't have
> any *clear* documentation saying that this is possible, or that this is not, I
> would leave it like that.

If we go with that we will never be able to touch any of the hardware
interfaces, as I do not recall when spec would explicitly document every
register and call out that individual bits can be changed together in
one write.

Thanks.

-- 
Dmitry
