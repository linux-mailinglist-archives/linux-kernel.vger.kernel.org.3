Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398E34CE785
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 00:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiCEXDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 18:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiCEXDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 18:03:09 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8F933E15;
        Sat,  5 Mar 2022 15:02:18 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id g1so10668685pfv.1;
        Sat, 05 Mar 2022 15:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H61iKhkd64ivVWZs4ogkCt+4zOe3n7k0C4BO+obH/mo=;
        b=oVpS998rFH1VqSDBjKnjKcPMllHyCS3K3Ph9n50E+XyAod2UbvQwteRIATesRUC9im
         ds3k6fjaX2eKog4QA+B5EDlqdTNUhRwLy+dtd1vXdKdW0rIdz+oX6QczEAK9Gl2fqHmD
         6XgzpgYhSvPC9k1CQvtObhojOyAexTBM0gx9cCndbxaCAdiDWQzDgHDBUvrbojJCvXcC
         4QaTbaw4ppPQm9lG+Trr4ZAjXjm2wRJmmbAsTpQjDg/imJf4x6yi3/MhmK9+aTuBc+lt
         QcxndxHVv3oN0NUppe+Plsj1ESaCgwWpplH4cVm2dNvXKyH944snuvVyfnu2U4b7kfwU
         Ht+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H61iKhkd64ivVWZs4ogkCt+4zOe3n7k0C4BO+obH/mo=;
        b=tpCvZj4UsJcwR29f7nuuJlRaEypm08TyV3PChRY8Q63sgnP2OFvQHv7oAhfRM9mlXO
         b7o5MJCuxsB86xfD/FzvR5TB9aOcPXBc79m43GA4iTpabfQx2PY87xwdQNdN+IcAuaJF
         uONv5nZlXQ4TwUWnoKCdDsU0dEJUAvwLTp2tk3pPrzpAZHZGTitpNDXN9oTErRJTll5V
         HyJu5xCRM+D/1JtaOlSjcLmK91guRot4BnYtDSDnW2nfcWnhNbYVlvBgScPnQZWF71NV
         cErOLTE42KCtTR35EKfFbbOh8Ykuw0KUUW6+BuigREKCCEwA+EoeQiDATNdP0tX+wmBP
         L/Yg==
X-Gm-Message-State: AOAM5321s03pqJFVMmzzf4K330oMRY7GjMNM5KaO4SankVi/Pe0XaZAY
        vfrk4vK9OUC19NKtIU8VKPY=
X-Google-Smtp-Source: ABdhPJy1m1vQ4DLxM3tBBx4rnn38jnYJj6bd6yxYjnKZJ93DMvmYDLcwYcjrcnlLo6Xtt/8vsRbTXQ==
X-Received: by 2002:a62:55c4:0:b0:4f6:b396:9caa with SMTP id j187-20020a6255c4000000b004f6b3969caamr5998502pfb.19.1646521337975;
        Sat, 05 Mar 2022 15:02:17 -0800 (PST)
Received: from google.com ([2620:15c:202:201:15af:5d15:3044:acb9])
        by smtp.gmail.com with ESMTPSA id v7-20020a637a07000000b0037c9268a310sm5335983pgc.3.2022.03.05.15.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 15:02:16 -0800 (PST)
Date:   Sat, 5 Mar 2022 15:02:13 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fengping Yu <fengping.yu@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v21 1/3] dt-bindings: input: Add bindings for Mediatek
 matrix keypad
Message-ID: <YiPr9Zt+VA3NbI+Q@google.com>
References: <20220303154302.252041-1-mkorpershoek@baylibre.com>
 <20220303154302.252041-2-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303154302.252041-2-mkorpershoek@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 04:43:00PM +0100, Mattijs Korpershoek wrote:
> From: "fengping.yu" <fengping.yu@mediatek.com>
> 
> This patch add devicetree bindings for Mediatek matrix keypad driver.
> 
> Signed-off-by: fengping.yu <fengping.yu@mediatek.com>
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied, thank you.

-- 
Dmitry
