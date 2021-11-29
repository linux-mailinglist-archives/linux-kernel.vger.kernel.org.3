Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69275461717
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241225AbhK2N5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbhK2Nzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:55:35 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538EAC061D6B;
        Mon, 29 Nov 2021 04:36:48 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bu18so44326104lfb.0;
        Mon, 29 Nov 2021 04:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5f8rs3P5t+tmNGptNIlOroYdBkc13Kd4GTegNLYCc1o=;
        b=HbldwAKLdYYtC0aBM1KVSmfjA5Xp3NPo6Kjqjeto7mLYqjGyZyTxrBi3Cr9BJTfkT3
         nBTB20w/QbolhVTRZl6RYyTnGGFdYKCEP/S2pu5a8dA7BJPk3CkmoBlWzQ2Wx19bU0rK
         Cxn1kn5tTw4gND8s41hjgaMcCtd8Wn9lKuCvZCFauIZVOyxUr5sSrjJLYUWJdqJZaFMe
         355kmDLWqJIoqRosP/HqMesC+dlssuTCStFGfVd6VbGFoyZNuUEka/MyRPxZhDAFxfqk
         zioS8Xdhh4aXJxzhixkd9QbJ1tFatJoI++weOXpvrYdbX6V1eAIO+4VCmr6ZIQGLkQ40
         0GwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5f8rs3P5t+tmNGptNIlOroYdBkc13Kd4GTegNLYCc1o=;
        b=polvikOhdfeInhKXSeU0GjztYDu2whQGIRX8aU5Y6gG86+JCokj0qZvLAhQw3uCIlh
         YENvdy/Y6rMCGQbqwcYCgtJJEt3g86qpQEfEKOrrwB0Fd0baLJMhETKzIZ4ay+uk07eD
         t8xjvq2HdqubLBPGwp5CpkdHHe0KrnYLjY5is2iKe+6P8/XlylXglExOmxNU1D+usCx0
         RcC+MBNXikKuciCwJsm2zkeb/yO7++yW+y5/Hsh6Wt5wY5wW4383n2hTPR0Ig2L4tvSN
         huMmcjjUlVYOMST4xn55GMlKWpio/8tMwyCvRMpmjr3HQWS/i99o79KhXrhFiVp1xfYy
         CQYA==
X-Gm-Message-State: AOAM531jzWKyqgze0EXqMdKoEOB5z7A4Okuo44v8PYr0lFymE+u/0x5a
        rj7dFPhX7JnRDEzvNlQGU+mC7FD832w=
X-Google-Smtp-Source: ABdhPJzcEgdTo8f0OK3vDIhV2lwVutgwJ+zC8V0ffHUepqF7z30kB0NiEbJ9AUZtpQcUNzCSOp3pmw==
X-Received: by 2002:a05:6512:34c6:: with SMTP id w6mr46105024lfr.527.1638189406465;
        Mon, 29 Nov 2021 04:36:46 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id q13sm1320569lfe.121.2021.11.29.04.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 04:36:46 -0800 (PST)
Subject: Re: [PATCH] serial: tegra: Fixes lower tolerance baud rate limit for
 older tegra chips introduced by d781ec21bae6
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Patrik John <patrik.john@u-blox.com>, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, ldewangan@nvidia.com,
        thierry.reding@gmail.com, jonathan@nvidia.com,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org
References: <sig.096060f39c.20211122124425.74031-1-patrik.john@u-blox.com>
 <0165046b-c8bc-ec8e-05c7-bf9aea14339b@gmail.com>
Message-ID: <727044f2-12d4-0de4-f6b8-ef3ee75d3630@gmail.com>
Date:   Mon, 29 Nov 2021 15:36:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <0165046b-c8bc-ec8e-05c7-bf9aea14339b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

29.11.2021 15:32, Dmitry Osipenko пишет:
> 3. Use "Link" tag and put all http links here, before the Signed-off-by
> tag, like this:
> 
> Link:
> https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git/commit/drivers/tty/serial/serial-tegra.c?h=for-next&id=d781ec21bae6ff8f9e07682e8947a654484611f5
> Link:
> https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git/tree/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi?h=for-next
> Link:
> https://www.kernel.org/doc/Documentation/devicetree/bindings/serial/nvidia%2Ctegra20-hsuart.txt

Actually, it should be like this:

Link: https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git/commit/drivers/tty/serial/serial-tegra.c?h=for-next&id=d781ec21bae6ff8f9e07682e8947a654484611f5
Link: https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git/tree/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi?h=for-next
Link: https://www.kernel.org/doc/Documentation/devicetree/bindings/serial/nvidia%2Ctegra20-hsuart.txt

I turned off line wrapping for this email.
