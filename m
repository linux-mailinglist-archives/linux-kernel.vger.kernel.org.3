Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20438474040
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 11:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbhLNKSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 05:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbhLNKSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 05:18:14 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8B9C061574;
        Tue, 14 Dec 2021 02:18:13 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id k4so13211124plx.8;
        Tue, 14 Dec 2021 02:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=92yYEvFNeXQBGVvIoSkyIjgYw0Oqz3137D6F4hZH+Rg=;
        b=D29J+HOYYRy51FfZDXuW6Pn/xW/GbTqEvAw3l9zPSLAi6xQuUoZ/Toleel3QrmskY9
         arTkNYFWXgaSqFWqOKy31wjsttH81Ase+jxl27crlnZ/4UQmHfJ9LVkC82FzFSAdBTD7
         4DJJnQ6/GkEuxzbNyL4mMxdgkyPTp1CA+DmG3GNit88exYDGM5zQ78pslBzxhI5PXX73
         aPUZ5qE9MXweg7YpEkmj13cDR3DrRRMMX594aolSZH+JbJfPvVUKIzv2CDrFnDU392+4
         FyD+bkK0FDr30TTej9hjYK8wwY4JH5rNAJWbmoYIy0AxS0q5wkJ7EdjMyP1/xTp2geRc
         BCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=92yYEvFNeXQBGVvIoSkyIjgYw0Oqz3137D6F4hZH+Rg=;
        b=qrPD0il2g3/YxGJVKcKi2rxvlKdGmCXnczmsUhgJ2QSct9is1pVlzTstsvUHYmQuTd
         sRoJpDgscYtJxu/YtBfjmWfuNHin3xtLSlygQ9jnquhTUPpw8sUPyGL/YcRuv0k36PzX
         j4cbcRS3MLBJhKJvPRSx8cmUR+tRa144uw9OBnt3SNP/TjuDQDHOx1zhrEA20PsnHRor
         U4a4tP9Byn2SUI9GD9SJaQ9Wohx4/uzkDXS9QwC8w/GwIBY7tzMzg6mGbbxLO8lB1Dgl
         B+7Yx9Uywh9rQac1VM5nqpy46h9lfAjjNRbVLgjJzfrgmbcpNaXDX4qquWQ9kI1dIzgL
         d+lw==
X-Gm-Message-State: AOAM531w9pmJH52ndTXcm7BMmPXyzeDXDqtonZMNYW0ZV5I1na+J6kqx
        HKgTOixzzJunq5NTJFP7OLo=
X-Google-Smtp-Source: ABdhPJy7Vj4Ab7OH+HG5s6Zw+akLI3sfqQUGYrwu/CBSTg5X7kdBg/K54B6pE1gANgdI8CDJ9FhHbA==
X-Received: by 2002:a17:902:c94a:b0:141:fdaa:59ac with SMTP id i10-20020a170902c94a00b00141fdaa59acmr4753664pla.37.1639477093554;
        Tue, 14 Dec 2021 02:18:13 -0800 (PST)
Received: from postoffice.intern (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id mg12sm2016244pjb.10.2021.12.14.02.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 02:18:13 -0800 (PST)
Date:   Tue, 14 Dec 2021 18:17:56 +0800
From:   David Yang <davidcomponentone@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] pyh: qcom: fix the application of sizeof to pointer
Message-ID: <YbhvVFTz+KwNtgo7@postoffice.intern>
References: <8d75af8e322a7e5839d2dd4320b696ee09ec0843.1639100549.git.yang.guang5@zte.com.cn>
 <YbhjS2Nb8yrT9Nzq@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbhjS2Nb8yrT9Nzq@matsya>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry about that. Thank you for your advice.

On Tue, Dec 14, 2021 at 02:56:35PM +0530, Vinod Koul wrote:
> On 10-12-21, 14:21, davidcomponentone@gmail.com wrote:
> > From: Yang Guang <yang.guang5@zte.com.cn>
> > 
> > The coccinelle check report:
> > ./drivers/phy/qualcomm/phy-qcom-edp.c:574:31-37:
> > ERROR: application of sizeof to pointer
> 
> - this should be tagged v2
> - You should always note the changes done in v2 (after the --- line)
> - subsystem name is 'phy' and not pyh
> - I have already applied fix e87f13c33e126ab2c72f9acb5ae98fbb93ddfd32
> 
> -- 
> ~Vinod
