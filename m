Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8A648C8BE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355326AbiALQrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239986AbiALQrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:47:32 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D62C06173F;
        Wed, 12 Jan 2022 08:47:32 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 60-20020a9d0142000000b0059103eb18d4so3197217otu.2;
        Wed, 12 Jan 2022 08:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lN/J8rputKQp3jJ7yCi1FIi8yjN6Bxzqjn/tTbNlKC8=;
        b=IaxXXiu/sSqOIbs17E4K1xWDLeO9OnsqekmORdGbRanZkzPucA4pKniqCg9mWUYPQl
         gZYDrwOMh3Dl6FmG4VjWF0brODaxM2rvP6DlJy8YTKKhBkjCf9mTJwN8xLtnpC9pouwy
         z545yuEIJEA+nJMGgo3+bekW2HR2x2+T9BSB1wfRvB7aFrm/gs2CXgC4kAzWNzAIP++o
         tit59RPKDB0AlEnqw/kqVTT1mvK5ViQAhTTQ15n2A4JgKB4hdrDiXohbcjgxikcp7W3D
         lJwcHjlgIknQcNZoTbV7E7s/MBibysZeOg8wXW/kle/pVBclV54x4CQRwg5+LpAaBvBh
         lAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=lN/J8rputKQp3jJ7yCi1FIi8yjN6Bxzqjn/tTbNlKC8=;
        b=yT2Xcz/bOmc3YCSfYF5fnWUFrYtvfSPsDhEjHsaP2ILWrlM8UuBh46LkEYITo3Z3UB
         aWnbCsfpP6y8xz2jX+5Lspf88158Ro5Zf4OCMQzRvoKVSsukeajVZQIh4CcATVjFAy2G
         KxQO/NOPNqdSww7BSDC+quer3ZlLA82WGiu151Td2F+shZoknQ1qABE7PMRc/TR1Q0O8
         nzG34e8gu1661Iqr8dMf4HaZaHzBoUJJw9gRAbLSf3vfCmCLhVa5AbpUsdwQJinVpE6h
         TkUDOsaie6f+aHAm5FzeuP+t5g4FrX+sjmXBSUpF8ZdmdeJIT113Wxnvgou8FhMZlxY+
         /KDQ==
X-Gm-Message-State: AOAM530+iWcKWRIkOxUPGI8sV2NSZG8fSkgrpwGXTns4Nlq+Z1iZlCN0
        JNvCPfPRf2ViZQWwSY/dl4s=
X-Google-Smtp-Source: ABdhPJyFV+79hmv6ZxS5TVvuE33S7LnADsy1BbPzkzxadGkmDiXNyNSamsxAPv2oM+oyKeUyVGBamQ==
X-Received: by 2002:a05:6830:1649:: with SMTP id h9mr436149otr.135.1642006051555;
        Wed, 12 Jan 2022 08:47:31 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j6sm53018ots.53.2022.01.12.08.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 08:47:30 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 12 Jan 2022 08:47:29 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        linux-kernel@vger.kernel.org, Renze Nicolai <renze@rnplus.nl>
Subject: Re: [PATCH v3] hwmon: (nct6775) add support for TSI temperature
 registers
Message-ID: <20220112164729.GA399472@roeck-us.net>
References: <20220112034824.3467-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112034824.3467-1-zev@bewilderbeest.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 07:48:24PM -0800, Zev Weiss wrote:
> These registers report CPU temperatures (and, depending on the system,
> sometimes chipset temperatures) via the TSI interface on AMD systems.
> They're distinct from most of the other Super-IO temperature readings
> (CPUTIN, SYSTIN, etc.) in that they're not a selectable source for
> monitoring and are in a different (higher resolution) format, but can
> still provide useful temperature data.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> Tested-by: Renze Nicolai <renze@rnplus.nl>
> ---
> 
[ ... ]

> +		switch (data->kind) {
> +		case nct6791:
> +		case nct6792:
> +		case nct6793:
> +			data->REG_TSI_TEMP = NCT6776_REG_TSI_TEMP;
> +			num_reg_tsi_temp = ARRAY_SIZE(NCT6776_REG_TSI_TEMP);
> +			break;
> +		case nct6795:
> +		case nct6796:
> +		case nct6797:
> +		case nct6798:
> +			data->REG_TSI_TEMP = NCT6796_REG_TSI_TEMP;
> +			num_reg_tsi_temp = ARRAY_SIZE(NCT6796_REG_TSI_TEMP);
> +			break;
> +		default:
> +			dev_warn(dev, "unknown number of TSI temp registers for %s\n", data->name);
> +			num_reg_tsi_temp = 0;
> +			break;

Please drop the message. This is new functionality which should not
suddenly produce a warning for chips which possibly do not support those
registers in the first place. For users with those chips the warning
is just confusing.

Guenter
