Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E7350E7A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240981AbiDYSCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiDYSCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:02:45 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D6D2458D;
        Mon, 25 Apr 2022 10:59:40 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bv19so31152397ejb.6;
        Mon, 25 Apr 2022 10:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TtgZ9hhhM4u37jsTuLZNpiEojGjDtunmh77jaqRuyTQ=;
        b=Z4guqvZ1DmvBpFabB1XWYbAjbioMhUlKBS9dG6i3rc6ljtSqq1aV39L5YsbAbrMIqU
         dVigS191k+K5O711V4uWIdpI6CB/75y22CLZml6p4Hfv0TKF1Ga8tsaXt7fVglHSgtr7
         dM6gVArOUOlZk6VDrG9RL3cmF/AcVTflft/tnR4Mrr7uBPOGL8zBF+S9yIlWy04nR9hE
         2EymrYGUwA+2DYX3iegcO1njjYDVm7to9pnz5eq7jMaYxadCux9aKQnVi6PgTmjvLYvr
         I/9sEt39ou7PEEjajbQtGkEyDAppODxySeUDq5l2B5mflpUp62/5T78j2ha4CXy4wHiD
         GrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TtgZ9hhhM4u37jsTuLZNpiEojGjDtunmh77jaqRuyTQ=;
        b=iGiv/EPHPQOn5wy48px2pEk2wOJa18u/sx9J7FALgIWd8AuEjbEFg9/D163SU71g6Y
         Wb4KMeUw7jIvgXwpwYy42T1qUwV1/tY89sxdB7dxSASfJcHlmkNxgzbJV6uBILQoSxzU
         eukC7S52bWA/oK2XMbt+Hp0tVfLcuv+NCLIzBMpIQXXi7S2WzeAHYzzrwO9dXd0K8/lV
         u3nUKgkYMpWemP67znTXftoN9PS4DtdI1W6MCLvnvp0e5vBVhXb0+YttVl48J+P52YWK
         DgUCFBnfD8T40Th5uYYxlL5SYQIW4ndrQsKqVcHoxDS1dKWOm5t4VNOMsNnIxd4Nwvcq
         2Pag==
X-Gm-Message-State: AOAM533Kb8OH8XvQpQ2HKQwetmdruxkzh/6F2DvSRypACgBQs4Y8w3mE
        YyE4mNDcHP6fBe3DbaEfN+k=
X-Google-Smtp-Source: ABdhPJzYYWBWzPgmXZIuANGBFazqlekbk38HKp1EanXlXkro9F+u0aIvfoRGlTvJnkHEgdkYjebayw==
X-Received: by 2002:a17:907:3e1d:b0:6d7:1031:7e0 with SMTP id hp29-20020a1709073e1d00b006d7103107e0mr17169875ejc.580.1650909579477;
        Mon, 25 Apr 2022 10:59:39 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id u18-20020a17090626d200b006efdd9b95c8sm3867949ejc.47.2022.04.25.10.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 10:59:39 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Cc:     wens@csie.org, maxime@cerno.tech
Subject: Re: Re: [PATCH] clk: sunxi: sun9i-mmc: check return value after calling platform_get_resource()
Date:   Mon, 25 Apr 2022 19:59:37 +0200
Message-ID: <2976854.CbtlEUcBR6@kista>
In-Reply-To: <9ebabc53-72de-bbec-895c-fa3760ed5374@sholland.org>
References: <20220421134308.2885094-1-yangyingliang@huawei.com> <9ebabc53-72de-bbec-895c-fa3760ed5374@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 23. april 2022 ob 21:45:05 CEST je Samuel Holland napisal(a):
> On 4/21/22 8:43 AM, Yang Yingliang wrote:
> > It will cause null-ptr-deref if platform_get_resource() returns NULL,
> > we need check the return value.
> > 
> > Fixes: 7a6fca879f59 ("clk: sunxi: Add driver for A80 MMC config clocks/
resets")
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> 
> Reviewed-by: Samuel Holland <samuel@sholland.org>
> 
> 

Applied to sunxi/clk-fixes-for-5.18, thanks!

Best regards,
Jernej


