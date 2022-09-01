Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4B05A98F8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbiIANfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbiIANeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:34:37 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A882265D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:32:44 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id p16so31575161ejb.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 06:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=GkqcXxkxbiGAUS3mDZ9ZIlXaqo2ypwaG4SLF3IzWGD4=;
        b=tkpJ8P7txLgCLaajgTyWxraKpmNbXD2ahq6miX/0cQFc3LKU8YlP5w+LoFTWnFrfVO
         6yDZzgrZy/mlnubTM6WmNE3Gg8dIXrU0W62XZwsPa/TpuK7QzdU2JYGZIc43/FjL+W+C
         dIjx9ZRnVsHA3w8p0yKeS7RZ6UvAyLDq4bs6/WjQ0JaMb9a0nNuiyzMd0RpPCKfH7w88
         NcZ6N6GM+wioxWFJox4PZT/Bxgq/vErFeHY6dfOupzUPmXNSpR/2p9TkbVGWI5FeBoDd
         MBpx/zeJmfQBdUZZjgNw2H9/AeTHjWtmm4a5/x+RA9DkkH2CCDWDI62VorgsACZe7AOc
         6dKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=GkqcXxkxbiGAUS3mDZ9ZIlXaqo2ypwaG4SLF3IzWGD4=;
        b=nQZ781UcEPL1nCeMd+gLB31anEODaV184gWclOCYb5t1vq8x72tNw4RO4eCU1Fgf7N
         H5DRhytAq11JdqINFHbk45bCPmonLXIDV1TlNLQ1B3HpKKYO7Hk/YkXrLXA+eDAbVJFZ
         yHDuYb08EMcpX1Xv7i70X37jNLsyRMArrRQDEJoSkqRDauZP31sIDtIoQcSsGdM4CXqG
         CTaEi/xR5O4+xu8BOsLzIEUp5uzN5P+dkeAGS0POf6Aiftuh79W4IHI9hOxhsg59+jbN
         6AoPHqrkOAAvlVv38HZjQ5m1JSZ8ZYJNHT8CPdRL+l8AxjskK2SEDS8UTBPcQ0L3h0Lo
         Hu2A==
X-Gm-Message-State: ACgBeo2UZ/zcsPTjIbk2hAlxQRn45CDvIETdj6ys5i0M7A2qu6iOUVb5
        0Q5jvTGr3szT7xJKsgUzIx7jFNeYG2UDw1vd7/2QUQ==
X-Google-Smtp-Source: AA6agR7EMbR1VhzyEbx3KwgyWcAgNnqnpvQizf8d4bjXBqesyVusbdQz6O0joQ2RKwf/Kfu2EXgvGVOlU4GQMZ6WMtQ=
X-Received: by 2002:a17:906:58c8:b0:6fe:91d5:18d2 with SMTP id
 e8-20020a17090658c800b006fe91d518d2mr24160316ejs.190.1662039163171; Thu, 01
 Sep 2022 06:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <SA0PR15MB3919F42FFE3C2FBF09D08026997B9@SA0PR15MB3919.namprd15.prod.outlook.com>
In-Reply-To: <SA0PR15MB3919F42FFE3C2FBF09D08026997B9@SA0PR15MB3919.namprd15.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 1 Sep 2022 15:32:31 +0200
Message-ID: <CACRpkdZd17c-0h=LLep71LEtLtc9iqv54kEMF+TbXx-K5tPcQw@mail.gmail.com>
Subject: Re: [PATCH] RDMA/siw: Solve the error of compiling the 32BIT mips
 kernel when enable CONFIG_RDMA_SIW
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     jianghaoran <jianghaoran@kylinos.cn>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 1, 2022 at 9:05 AM Bernard Metzler <BMT@zurich.ibm.com> wrote:

> We discussed same thing a few days ago - see PATCH from Linus:
> '[PATCH] RDMA/siw: Pass a pointer to virt_to_page()'
(...)
> Could one of you two re-send?

I updated and resent my patch now!

Yours,
Linus Walleij
