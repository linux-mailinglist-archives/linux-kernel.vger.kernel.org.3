Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF7547AF11
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239323AbhLTPI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240065AbhLTPGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:06:30 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89081C0613B5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 06:53:26 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id a37so16353883ljq.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 06:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KkU1bsAofLPS+mp8FievzE25/EmplJ7+cysz+vbgjSY=;
        b=oyOXtiMXVCSqQnGo42RS7sg+FkByQov34gijMOE9Bbz9aNJO+3lnkjorTyMuwiX5A0
         GUYExv12m2nv1xN37NKA06cjnwqLw0HMCtQ2legOegubnWnEJpPOKzuR5y7x6CWX6Q8+
         ZtdXJKCxC8aDGp0IMgscW4U0sUfdJVmqrP2d2zpAWoduxOLLeq8b2HaE3m2Ak6ieoyWk
         oJXTpEv29XQys/4qy+MAhGPATZfb5DNa4ZZvUi4R4PHItok5oAzV62qeZJjA9exi9obB
         2hzYZ6ZyQyRPkLA1IfOCS2O/uYcCinEC7R29T4/UZwZlA33N4dqb0WsxPBikgDbQa9Zt
         s8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KkU1bsAofLPS+mp8FievzE25/EmplJ7+cysz+vbgjSY=;
        b=3/G4N7KruKRyzGFj5XJ9FMvBi3EbOEPlTx5/S7rMzCCD92JpV/rA4gDvCwveXDSm9F
         B42muSx/bPU7p/hA17zYK3zvpE6lxPbzjdvHrKNLYGceESOfm8+jex9SmjmYWVKJddCx
         ZchQbInqEBkBOj6YjWmiqrwtRP01wptNbPD+azFGfl2HIyAdupKTr2WydBrnNvCZhsrC
         ZcDM47dFh5Org4DIJ4kzJ1nJG+Wtv+AxWUhHjzECMzQDq/HzZUuSgopwo2fn8Ml/5xtm
         QGd/wkOH7Y/hau6unOoQVicLx5te9cBdRt3ktJlGI619MiaQHSwSslso/TKI1AugJ7d7
         XpKQ==
X-Gm-Message-State: AOAM531bdkn9ZJ7i3sC2pxxXtyQ3I+HBmmlO/LyZs0w6+3l9+Fz9jUBX
        J7IS++KXphDSR9d/xwx6yVO8cjzcmzE=
X-Google-Smtp-Source: ABdhPJwaD1Pe3ClH9yjQltppD2TGjKsIpwJHPO/Jle41COkkKIAbTkWC5F/480DufJNcEeCJvViVTw==
X-Received: by 2002:a2e:a785:: with SMTP id c5mr14397856ljf.384.1640012004748;
        Mon, 20 Dec 2021 06:53:24 -0800 (PST)
Received: from [192.168.2.145] (46-138-43-24.dynamic.spd-mgts.ru. [46.138.43.24])
        by smtp.googlemail.com with ESMTPSA id i23sm844450lfv.261.2021.12.20.06.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 06:53:24 -0800 (PST)
Subject: Re: [PATCH v3] mfd: rk808: add reboot support to rk808.c
To:     Peter Geis <pgwipeout@gmail.com>, Lee Jones <lee.jones@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        linux-kernel@vger.kernel.org
References: <20211220144654.926112-1-pgwipeout@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <67131f4a-2544-0365-1a92-261983cdd979@gmail.com>
Date:   Mon, 20 Dec 2021 17:53:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211220144654.926112-1-pgwipeout@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.12.2021 17:46, Peter Geis пишет:
> +static int rk808_restart_notify(struct notifier_block *this, unsigned long mode, void *cmd)
> +{
> +	int ret;
> +	unsigned int reg, bit;
> +	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);

Such code usually should be written in a form of reverse Xmas tree in
kernel, but no need to respin just because of it. The patch looks good
to me, thank you.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
