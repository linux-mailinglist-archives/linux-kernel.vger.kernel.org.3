Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC30051C16D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380208AbiEEN4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380328AbiEENze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:55:34 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF6D57980;
        Thu,  5 May 2022 06:51:29 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id i27so8851864ejd.9;
        Thu, 05 May 2022 06:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=03jEfwhlWo+0F3QSErStBbhWJEDMANJVy/9rSPAUx1Y=;
        b=gDuWgen8Trv88IGdxznU7oSgtaGFD9MISOr5rrDibBMmmE7rdJ9qzu55Y8IjlM48TA
         Pj1rTM8nEBAfhGlUpxlZz+uzebwMmf42g21Mp/bNWSMUURl4OJqCXAnmVYIugg/zJqXT
         ggmCRFZethoWCe6B3tJRbgQBma3Yls8XMzFVPNfH0WvxIp9HrKG4u/eguY6/k8fugqHE
         bJjxcHaonBy5O2ss12U6jckTDgwk/iCRdtWve1Up6aZUc4pNKSBgsqkFdNhZzY3cKDhh
         KFbS/810r+VUh/Y9fB0WrcwyPhOsGgfsSz5wOM6HxTiz1Az1/oEyM5fW7fxc85E/BhNK
         H2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=03jEfwhlWo+0F3QSErStBbhWJEDMANJVy/9rSPAUx1Y=;
        b=JX7HkjnWrsBxF70znaiSanXFeElxOHdjmdLO09SG/x7/R8JkgcDO2Ex7Z+3ZWvSNl2
         NAURg2yEjLglOsTqr5v5Ey+fQqWQTUQ66i5qVS6R1yTKC2wbUZIaQ0KWjNjXOm43Ur1r
         K4ACQGlhO6kWipUAfo4rmSubKWvqSvDWXr4c2sgeFp7yLId4eEBnSB7gs6pjbYO9yJs7
         ZR6dvpT3BI/Gg1dpOdTfAktGqo6cg9GCmJphSjf8PZLxHt+LLeediJ/6PbH26/q7fLAr
         Dag5RSKQE+5P1K228pe6iu24gxRkLBWlFpysgwH8jtB5FAQMf+nO1P63x1mQjtPnCPGC
         X0sQ==
X-Gm-Message-State: AOAM531YYXor7wJCh9SZaPihYK8w71m5rcgtA9Aq9uoxzrGcBURzKDYo
        JPBshY5y8ZhTUvgl0VLHhek=
X-Google-Smtp-Source: ABdhPJxv3vaDNdwJi00++TLK8Ghuv5Ib+qTCOCEdX5gN/oc0y8OEOLbbC12VtWJ8ETtvXVM4x8Wt6w==
X-Received: by 2002:a17:907:6e8b:b0:6f4:7147:a6ac with SMTP id sh11-20020a1709076e8b00b006f47147a6acmr16897480ejc.187.1651758687576;
        Thu, 05 May 2022 06:51:27 -0700 (PDT)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id g3-20020a056402424300b0042617ba6387sm895632edb.17.2022.05.05.06.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 06:51:27 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        Jianqun Xu <jay.xu@rock-chips.com>, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCHv2 13/21] pinctrl/rockchip: add rk3588 support
Date:   Thu, 05 May 2022 15:51:25 +0200
Message-ID: <1792093.MYTQk1Oth5@archbook>
In-Reply-To: <20220504213251.264819-14-sebastian.reichel@collabora.com>
References: <20220504213251.264819-1-sebastian.reichel@collabora.com> <20220504213251.264819-14-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mittwoch, 4. Mai 2022 23:32:43 CEST Sebastian Reichel wrote:
> From: Jianqun Xu <jay.xu@rock-chips.com>
> 
> Add pinctrl support for RK3588.
> 
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> [merged in downstream fixes, simplified register lookup logic for better
> maintanence at the cost of a bit more static const memory and fixed some
> incorrect registers]
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Hi,

a heads up to the maintainer: this was already merged. The cover letter
states

>  * Dropped pinctrl and mmc binding patch (applied)

so I think this was included by accident.

Regards,
Nicolas Frattaroli


