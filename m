Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E3546BD54
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237644AbhLGOPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbhLGOPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:15:04 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3387EC061574;
        Tue,  7 Dec 2021 06:11:34 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id u22so27625727lju.7;
        Tue, 07 Dec 2021 06:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=pWSGmOrMwfws0Ucq14Q1XoroBza19gcrEAP48UdsgDM=;
        b=YYhDl2izG2LKie5W2Be936oRPf21p/xzlvvb6ALY7NhApzL8N7H1F+Pn1xLxQM0TVO
         y5Y1NYbR1YiAW3T9AHGlHpU2HlSE6d22SJoEfvIV3+aqRp5wJY9qO4ZFZjdyIWlpTgJd
         pTFGsMgUZnkE9vMaA3Q5DW7Imc7daZGOZ6wHJpKWk0rdCGn6uZPHXkgw6c3htI1nbCF6
         LCMTJctNf+B+cwzzdPDrvUmW1u8dhbmdvxXtEJqC//Bj3jZ1Pccps1hsRdoXDqlqL4OD
         G0TxRXOLxoe+gz1fB9guNAxBVfIWUVCrd9eNTZcOGeB37YDWP/VWJeUBprhvRvikv9LR
         /hqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pWSGmOrMwfws0Ucq14Q1XoroBza19gcrEAP48UdsgDM=;
        b=C5SObyk2xYurOjZ5Y1EPK4s4i8gnan+qt10JCfWFqMrdkA4Cb2UDq1RZLKEK7J3cLE
         oq+ecL5h0eEoXGFrCJdi5T9tpemTepB7nyn+KtaTPvf6Bmq6cGcHziqzsSXnEncBEUgB
         gKqElbZ+FN0wo2YySiPhTyKu0+efKMrN6DOUHdG5Tf+Uhjf+GZNSJbxh1pEgCy4lQBq/
         HC4ZvA6ujF9x13roFs1o4YjxlSlYn8PXssWnZWxpFKZ9dkMzwuKAqxA5fWwbpVH4qdns
         R25avl+t2nwmnKtjIJmSh9MxNzs9Tk3NWHPwmqg06bKJgfL2Shd2tX75DxZISu0IXzx4
         1B9A==
X-Gm-Message-State: AOAM533uXGxy6kP6XQa8y0sG+farK7Y48xpjdCO1u10yNU7DkA14FVm/
        h1SRStWJvbKA2dZI/22ue6by6zasB/4=
X-Google-Smtp-Source: ABdhPJwmGorNge5TIowflQGYy3HlJeLfrQsqkkf7E3IJwgP7ow7mRYgrNVfYMEHsxjh+2+0qxs2NuA==
X-Received: by 2002:a2e:a78c:: with SMTP id c12mr41978220ljf.418.1638886291839;
        Tue, 07 Dec 2021 06:11:31 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id i24sm1813605ljm.135.2021.12.07.06.11.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 06:11:31 -0800 (PST)
Subject: Re: [PATCH] usb: phy: add missing put_device() call in
 tegra_usb_phy_parse_pmc()
To:     Qing Wang <wangqing@vivo.com>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1638881794-3361-1-git-send-email-wangqing@vivo.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <768ced18-9e47-df7d-786e-dced5f06b0e7@gmail.com>
Date:   Tue, 7 Dec 2021 17:11:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1638881794-3361-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.12.2021 15:56, Qing Wang пишет:
> From: Wang Qing <wangqing@vivo.com>
> 
> of_find_device_by_node() takes a reference to the embedded struct device 
> which needs to be dropped when error return.
> 
> Add a jump target to fix the exception handling for this 
> function implementation.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  drivers/usb/phy/phy-tegra-usb.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
> index 68cd4b6..5678b7f
> --- a/drivers/usb/phy/phy-tegra-usb.c
> +++ b/drivers/usb/phy/phy-tegra-usb.c
> @@ -1300,18 +1300,26 @@ static int tegra_usb_phy_parse_pmc(struct device *dev,
>  	err = devm_add_action_or_reset(dev, tegra_usb_phy_put_pmc_device,
>  				       &pmc_pdev->dev);

This devm_add_action_or_reset() takes care of dropping the reference.
This patch is incorrect.
