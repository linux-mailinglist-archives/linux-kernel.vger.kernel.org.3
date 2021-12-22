Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B5347D3AA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 15:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241294AbhLVO1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 09:27:44 -0500
Received: from mail1.kuutio.org ([54.37.79.207]:42894 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237162AbhLVO1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 09:27:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 16D5A1FE00;
        Wed, 22 Dec 2021 15:27:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        content-language:content-transfer-encoding:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:from:from:references:subject:subject:received
        :received; s=dkim; t=1640183258; x=1642775259; bh=xrQekw5SeZXuxH
        AolB6PPyS1XVaI2aV1dGkHDgvq+IE=; b=Hj2Q/deTUrADEDW/bG8EcrlXd14uZs
        8eSSm486Cc2/pa+hzzDYXSiQfdJcBSnJWLBpSwJNCNB/WHQcoO/F+DV8esCEHPJ7
        tloOrx26hY/i/L5yEjgLEw+XAYp+bdstdXAzYm+Ej381wrhZkqvoJC/BXnC9Ctf3
        1jrNjeKcSy/Uw8V2FD1U8xuKo0o+M+8524mW6zl5KR2/GpeP/j2NMMZUjRTevEw7
        nnBaKcwLiKu8uiqbpSR0qDi9Y8yFR2EOQm2U6nXSVOByVqq+F9E/SzeS0OswRDp/
        X4WXGrgbGzFTmyiokcfeoNuZhz+cY4oLn/GRqcNdJDT95SRZnX54vFCgWWt/egUU
        BXLB1PaYdp+f8TmMHOfTgrMKfydFjh/x2slyn9QN/KPPOREMBDgcV9eXNA1eH15a
        rZsdnJef2lLO8jwMxOUVgIQ+izMB1is07wQ+/gws3ORuBYOnygXDrZ2Bo4RvT7iX
        cC+pSyc3UdyvOML+d84Ep/PkRXlNb6fWLiHQB1B4GpGCoUKaBDam64s6OTKOOBYR
        0Aiubd5nM0yZx4cVlw0Ca1ZIyVG/OTmTiD5RKx8DAHAqKkoBd9gH5i1wG1xtHcDu
        r927luAQEcDk2kuqQAysDV/+IZhDWOYg5l8acmRfXKjwQnElcFWPKxdESBYu6oeQ
        jWUrPCkYYW8uo=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id kThwQP-psZ3c; Wed, 22 Dec 2021 15:27:38 +0100 (CET)
Received: from [IPv6:2001:998:13:e1::beee] (unknown [IPv6:2001:998:13:e1::beee])
        by mail1.kuutio.org (Postfix) with ESMTPSA id AE65E1FD6F;
        Wed, 22 Dec 2021 15:27:38 +0100 (CET)
Subject: Re: [PATCH 1/2] spi: ar934x: fix transfer size
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211222055958.1383233-1-oskari@lemmela.net>
 <20211222055958.1383233-2-oskari@lemmela.net>
 <YcMa1TIg3x3oBKBl@sirena.org.uk>
From:   =?UTF-8?Q?Oskari_Lemmel=c3=a4?= <oskari@lemmela.net>
Message-ID: <98a574a2-45c3-5d7c-6405-0cd279a81816@lemmela.net>
Date:   Wed, 22 Dec 2021 16:27:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YcMa1TIg3x3oBKBl@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22.12.2021 14.32, Mark Brown wrote:
> On Wed, Dec 22, 2021 at 07:59:57AM +0200, Oskari Lemmela wrote:
>> If bits_per_word is configured, transfer only word amount
>> of data per iteration.
> Does this actually materially affect what the hardware does?  How much
> data is transferred in an internal loop in the driver is completely
> immaterial, bits per word only matters for formatting of the transferred
> data.
I don't have logic analyzator to verify what hardware actual does.
I tested this with transferring 32bits to ATSAMD20J15 slave.
Running loop in 8bits or 16bits, transfer is done correctly without
any errors. When running loop in 24bits or 32bits directly I got
error from spi_sync_transfer.

Oskari
