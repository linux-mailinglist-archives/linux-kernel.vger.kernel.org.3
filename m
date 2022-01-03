Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D01483547
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 18:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbiACRDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 12:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiACRDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 12:03:20 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7705C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 09:03:19 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id a1so30972944qtx.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 09:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=yJU9zhwni6o3+iZvN5P4ezbbFlptXIDjM38WRcxQ32E=;
        b=noF8JJJJnvfKFqf33bkEgTwyL+UX4F10QJG8qoWpz1rTM/BAcfM4zuoGJ5do4kszrw
         Rg1fvwEhmb0g1xcJ4QtLZ1GUD/qFfGjcMmExVedWogSh8dR7+QqHd43hlZUUyqpWqjtf
         P8BBZZfluylu1FRF7Wof6nn/wMnS8IsuTaMctpLt1gDi/Vat8TpxY47OneRsgqRxA6pK
         k5/XMUE1tLNtJWH7ZVCftAu8fdOstJOPt8ndDb7RMAsm/7oJ2uogNGMkhbEs3ckVXngJ
         fqTFEDvCw60xJ4NKEcx3U+nXrKXjnef5GibvxoAGc/Umf3E3n/qk18l4By+fUUDALHG7
         5+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=yJU9zhwni6o3+iZvN5P4ezbbFlptXIDjM38WRcxQ32E=;
        b=V68EEvXm1TW+obneMYrI+mQAu4546DsPCKpIqOaqPRK2JkbjXeAmlUo4cT+c+0qLyQ
         yWm60JOHm54aKAa8JTsu5Lx+8Z7/YOl9kbBPIc0i/V33vPX+J3/DKrKukYPJoAk/CSUb
         JNHIurW2nj2IK7luFvHeuCroFXslSqLe0kQ85I/JXCWTCX/U+vE4ovW7jF7OfKtlXMwQ
         J0N2omrXlkleVNiTc21l/ciqeDU2xMlsRVA9wbWFfGPDwGOULf23FBFBtCvGnOm60tNU
         TIZOGTnXFB8NWB6dNWN6J0rhg/14U8TrsuE77GOaKrQcdoFbks7hWHT5FRHxb1ds0YyO
         DM6w==
X-Gm-Message-State: AOAM532apq0cKcYqJyw8OajyIoM2DN65iRpFd17YCHChNLkmFBZ6XgAY
        HTRB+hGVSZQIem2YzOIAVf6CtA==
X-Google-Smtp-Source: ABdhPJzA/SHPa7IwwpIDS2Ewwxk0uyuQatuwrlI5IDc0c1N8Iu658RAeumEbJlcYI0R9FitBZ7/n2A==
X-Received: by 2002:ac8:7fc5:: with SMTP id b5mr40500137qtk.351.1641229399112;
        Mon, 03 Jan 2022 09:03:19 -0800 (PST)
Received: from xanadu.home (modemcable108.170-21-96.mc.videotron.ca. [96.21.170.108])
        by smtp.gmail.com with ESMTPSA id f12sm27848315qkh.22.2022.01.03.09.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 09:03:18 -0800 (PST)
Date:   Mon, 3 Jan 2022 12:03:18 -0500 (EST)
From:   Nicolas Pitre <npitre@baylibre.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i3c@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c/master/mipi-i3c-hci: correct the config reference
 for endianness
In-Reply-To: <20220103094504.3602-1-lukas.bulwahn@gmail.com>
Message-ID: <3p9691n5-3qs-7s3q-pp9-389621935prr@onlyvoer.pbz>
References: <20220103094504.3602-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2022, Lukas Bulwahn wrote:

> The referred config BIG_ENDIAN does not exist. The config for the
> endianness of the CPU architecture is called CPU_BIG_ENDIAN.
> 
> Correct the config name to the existing config for the endianness.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Acked-by: Nicolas Pitre <npitre@baylibre.com>

> ---
>  drivers/i3c/master/mipi-i3c-hci/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
> index 1b73647cc3b1..8c01123dc4ed 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/core.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/core.c
> @@ -662,7 +662,7 @@ static int i3c_hci_init(struct i3c_hci *hci)
>  
>  	/* Make sure our data ordering fits the host's */
>  	regval = reg_read(HC_CONTROL);
> -	if (IS_ENABLED(CONFIG_BIG_ENDIAN)) {
> +	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) {
>  		if (!(regval & HC_CONTROL_DATA_BIG_ENDIAN)) {
>  			regval |= HC_CONTROL_DATA_BIG_ENDIAN;
>  			reg_write(HC_CONTROL, regval);
> -- 
> 2.17.1
> 
> 
