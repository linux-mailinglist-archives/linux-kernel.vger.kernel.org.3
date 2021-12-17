Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A5147941E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 19:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240362AbhLQSaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 13:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbhLQSaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 13:30:05 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FE9C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 10:30:04 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id l22so6403031lfg.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 10:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wxXVzxqOXHO0GTZOA2F1N2zm7EwxOGpKK5L0bY+lCw4=;
        b=pv5OwX8mx+aYyldb68pjQaQhirbixvjs0iMtR/nhjscND/EtX+K8O83urDWzSxv5AK
         sptuTexsonESZEeBXHb68tzX9vGtydkr7WeEZmkDZH9oa9Csyj0rHF1zZLi/VivQv37V
         bdkO8D+M/zSaaeOwKpVb1wHe3QPLRP9gOrTDC5tQDOaf4WQFmp74nLG0Aaccknb1K69C
         u8EBq1mVmRiKZvYC/9MmS97LQNhJ5rJKy9yurgBEW1MWYD6QSEqH3M9BMJXkGNjnSUkq
         +XVlZlVyKqN53EIRhe6KNgtHr0qYQ0iGwn4NDo/biilJjEPNYbuOl7fDOVQiLafD7QZy
         0yTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wxXVzxqOXHO0GTZOA2F1N2zm7EwxOGpKK5L0bY+lCw4=;
        b=T+IcBCakGjq01XikM45UejxVNXTgr7SC1BINZYCQTldrTLkV/ODB49BfWwrFIBI4ew
         uJEUu6h4ilOyN4glutRatcI7nB3UrYR6r2GlzKkDnu4tuPW09HdN5XZ2Kro7a9L7VZVS
         RW3GzbbS0ep76VJf/0L+baYgU6vsmNQenvOqPS6hmjBComkd4V18I8ZENwIzp9tH8p76
         iENKMPDaqDzxmcGW++MkzDNyTc3HUvw8K0eB4lZ0IPx3HhHLKyxgsqeVtVMJsC9ImWEm
         i1f5ApckFnlKn29pFcT2hdo2yIEAaXQFseVqIj/+7ljBSgroYLDm8zZmokPSIGfSxCgw
         VwXg==
X-Gm-Message-State: AOAM533+4gpaE826n38DwHbQNgjX9s9v4IeAQ31ohRXMT2C8iABalO7H
        DaNV66qPsmugPr5qGMtRnzD2kVRQxH4=
X-Google-Smtp-Source: ABdhPJzbGU8crklOmLnrxvq1KCEJ4OuBOfBC3sKTdYT4Mhmq8ooiz0BWn/2Ley+qvOsLVy1ssS3+aA==
X-Received: by 2002:a05:6512:12c9:: with SMTP id p9mr3968091lfg.43.1639765802914;
        Fri, 17 Dec 2021 10:30:02 -0800 (PST)
Received: from [192.168.2.145] (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.googlemail.com with ESMTPSA id bq36sm1175931lfb.42.2021.12.17.10.30.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 10:30:02 -0800 (PST)
Subject: Re: [PATCH v2] mfd: rk808: add reboot support to rk808.c
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211217145544.341617-1-pgwipeout@gmail.com>
 <2bebe0ae-27df-f75d-97d6-2e4d2dd032b0@gmail.com>
 <CAMdYzYq=2G1bvu9M_DR0vdQDtcvVBhQFRPTNKo1ySFrMZOk=jg@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4d24cb08-0475-3a9d-1b73-24e465f34701@gmail.com>
Date:   Fri, 17 Dec 2021 21:30:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAMdYzYq=2G1bvu9M_DR0vdQDtcvVBhQFRPTNKo1ySFrMZOk=jg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.12.2021 21:16, Peter Geis пишет:
>>> +                     break;
>>> +             default:
>>> +                     dev_info(&client->dev, "pmic controlled board reset not supported\n");

I'd change this dev_info to dev_dbg to not clutter KMSG.

>> I'd set ret=0 explicitly here. Later on somebody may change the code and
>> ret won't be zero anymore, this is not an uncommon trouble in kernel.
> It took me a moment to see the logic here, but I understand it now.
> 

Could be even better to place the error message simply right after the
register_restart_handler().
