Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1134448989E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 13:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245499AbiAJMag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 07:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245516AbiAJMaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:30:14 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A505FC06175A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 04:30:11 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id x7so43683288lfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 04:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ERdhzlGj5n7W53NA5ZHL1EZzDm1yvgjGqMwmNTd2nSQ=;
        b=8UWqefwsAsoD31AsKJvObTqoqcfHFEFPE/lHFGSfucFhG1stf/mzw+sdO2HclKD13/
         DzMv58YL2wLBKBCKHY7AINtUmCIjgVC48aT2JZrgSiUrlw/7e66urrV6m/j/2okHUu1L
         asNdtgobYjrSd6Jmbey7vTs1tDund4tII5tDeYTkI+C2ZH7YCM4ypBLWJ+8XowP4X6Uo
         tkW8xd/qF9hW1KooWkvshiAXhPusOea5M6R9VsmWwKif7Gh0LryY+oKLF0+oCw3Pqh3f
         De3YK63j2ExmEz/U6HS/N10kIeTF+LI9BYuj2yKOt8NVbF97nvzOg5rj+rKe+UbE1Y/p
         8HAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ERdhzlGj5n7W53NA5ZHL1EZzDm1yvgjGqMwmNTd2nSQ=;
        b=7baw8UJHp1/2sgx2eK0nKg56qbVqR8zZ30qAXVrWfOZCjhoc/NPdge59c2XqjcmWeF
         gFZpctqnrmyJNDcwEbg+E5BlVtE3LlJfAHrgbzvkAPHLeifxbx0cZR07IstDD64dq5S4
         IRKGw0recguPyBRHfiYNj8R4UVcfdh4VyIoRpkgrekS9/DmH/4FvCzb211EqAwv06psO
         H4b9NtqXmOKeGrFDDUEhCJ3MzJ5QXMM58pHJcMzr6+efqk/TXSuzm5wpsLEMtGjrQwkg
         Ch7wBUqmYuR5pVKyo5X5efglB7eVphpX+iIi9cUjrDOxRSilEpmLo3MCy5Garqo+mpAl
         LPSQ==
X-Gm-Message-State: AOAM532gf9PDG3y594OX6Uw4jlckbCl4yssU81giz9xp69j74agw2qbT
        W9X626oEj55NgE0VGbe1KDWppA==
X-Google-Smtp-Source: ABdhPJwpASJDFfamJdAOgz96wkX8glcvjboHtyxuU4vg8ml3vdQs+qgwQ/Ly0GuTFU6EdIOgmzirEg==
X-Received: by 2002:a05:6512:686:: with SMTP id t6mr61846176lfe.135.1641817809970;
        Mon, 10 Jan 2022 04:30:09 -0800 (PST)
Received: from [192.168.112.17] (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id s3sm1047128ljc.135.2022.01.10.04.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 04:30:09 -0800 (PST)
Message-ID: <13907dd6-2a30-c6b1-fb71-e88dba98f5ca@cogentembedded.com>
Date:   Mon, 10 Jan 2022 15:30:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2] iio: stm: don't always auto-enable I2C and SPI
 interface drivers
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Cai Huoqing <caihuoqing@baidu.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220109124326.3696775-1-nikita.yoush@cogentembedded.com>
 <Ydwlsr8WjdsSWvoZ@smile.fi.intel.com>
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <Ydwlsr8WjdsSWvoZ@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Just noticed, what stm supposed to mean? `git log` against those drivers
> suggests something else.

I copied it from git log, can't remember from where exactly.
Perhaps 'st_sensors' is better.
