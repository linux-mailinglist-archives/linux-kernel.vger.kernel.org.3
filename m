Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F79B5214F1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241590AbiEJMSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241585AbiEJMSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:18:09 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839DC2421B2;
        Tue, 10 May 2022 05:14:12 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id n10so32528004ejk.5;
        Tue, 10 May 2022 05:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3DHfQee1FgnEF+vaa8nYqSHYuVptCO+zq1xhJ9uO+pQ=;
        b=QI3BFw+2sW0JRUhIFIKfjnflD5LhQDlHouAtiiGZfxRgWcRrTAYE3Ng8yxz9Je1vKY
         V9mJC216aH6R5T2sf9EMwo86SbzSKZhlf1vkjs2xGii+ZO4B1wYPAAOnE/xVw++PMwWZ
         8spc82MRdTbWdlgTlIUt4mqkVM+zIxEKrQc+/cqwNugWN+zuJxrzOAmb0BSxc/1lqXxc
         9i3xRpoZPmUDSG1S6gtc9iGEnt1inIOw0xQkq84G3b2lEuttAbK+ieVAP9Uxc4QjEKge
         4HiCcrHqPvB+TFYtCcoMzn2cNdGiKXqJbhw0+E/zqeH7EuDr31sZKZhEAa5GPwucye3Q
         QNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3DHfQee1FgnEF+vaa8nYqSHYuVptCO+zq1xhJ9uO+pQ=;
        b=E+IP5BdoMAp3n4c+C7lfKChNmfvp7u4vQDj1esUV9grna4Ohz9Z5SBXUGBKIeTx1iR
         lvYVSlx5lnDR4T+fzhVoGEGI4l4jasLN1N8XgzFgqPCp4P6IpXQpo89wD5M2ihvWvzf5
         RXd/7GKMB5mo3I3BxGJHfNKBWWzOH14eFKR/xwjog9iGCsJnnNnLBmpMt435k3TRbYvz
         N/hhPx35tlFS6etUFH+7U8LpyJ82SJwood0Ho9vxve6tFtcxmB4kLNqiUucPlYehJMNa
         /0r4H2pxT82Is5BdsevKNFFQ/2W2rN0B17vPkO9CRgznZVynoWI5duPQMGGn/4/AHVn1
         5/JQ==
X-Gm-Message-State: AOAM532hPZOGTA/RCKQHUqHeNdx7MrIMSPMtMDn3RMOJ2W+Wxhv+YXee
        SRkruQCZiw/2LrVzUEv93IeUNQ1zZkVEIJ2/E3E=
X-Google-Smtp-Source: ABdhPJxE0zUBLjBNRBx+4TpN44L3WrWob8qpWF7jjgTEFE1G+HfFGd9CpNfeeaibfYOyXF6/5S0JiV/5/ZlwIvCMolY=
X-Received: by 2002:a17:907:628e:b0:6d9:c6fa:6168 with SMTP id
 nd14-20020a170907628e00b006d9c6fa6168mr19089503ejc.132.1652184850904; Tue, 10
 May 2022 05:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220510105038.1351743-1-chi.minghao@zte.com.cn>
In-Reply-To: <20220510105038.1351743-1-chi.minghao@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 10 May 2022 14:13:34 +0200
Message-ID: <CAHp75Vc+G1JNkxBcpyXge9qsGpT0m4erBV1aEi4bMHDYfE-JOw@mail.gmail.com>
Subject: Re: [PATCH] samsung-laptop: use kobj_to_dev()
To:     cgel.zte@gmail.com
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
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

On Tue, May 10, 2022 at 1:34 PM <cgel.zte@gmail.com> wrote:
>
> From: Minghao Chi <chi.minghao@zte.com.cn>
>
> Use kobj_to_dev() instead of open-coding it.

> Reported-by: Zeal Robot <zealci@zte.com.cn>

Is it a bug? If yes, we need a Fixes tag, if no, Reported-by has a little sense.

-- 
With Best Regards,
Andy Shevchenko
