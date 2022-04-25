Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C42150E456
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242937AbiDYP2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242933AbiDYP2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:28:02 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0890EE1CD7;
        Mon, 25 Apr 2022 08:24:57 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id m11so6681538oib.11;
        Mon, 25 Apr 2022 08:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HlA2P5BWRWn9hkwakxCdZMtiE0l4ySDlpjLRIi/llRo=;
        b=QlA0T1cs4nFfilxv0dlBZKar6zmilFCddvi70J39T2EfHSBjI2Je1RSE6z0jbMqCmq
         em58sN0W2O57akqWSs8wtB+ncZ+Uae8LzeFjqUSktdXxMnj9cQCFwfgd2BU5s9xJ85z0
         kzQMkW+lbnhnoWAyAXbdPNYqU5Ed6m6wGIZkRLSHZe20Hs73yymFAj1yLY2t5/OUpf3T
         Ke+fEKTrVwVUM6aue7cHBbuDh0lhfMIe6i+c4KsL10E7R57/8yHmh9tRUblw1R6+3UGA
         YWGwAzQQYzHP5cSDRgoHkufb22S7DaCjmg/yHtJ+/qaAAspbCeCbkr9854HdeAlCSs08
         EEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=HlA2P5BWRWn9hkwakxCdZMtiE0l4ySDlpjLRIi/llRo=;
        b=bRwfHFkTW6YxnplmjCcPOqb5FSppY5voVT7M2RpUwlBCLQV81aII1xYGAfrHE9bRpW
         U+nXjHWoRMkJ7FkG3Q3zHTB71+iY5sEEBavIZNLsaOTVGqouBgq9MTi3wE1I/JleZjAs
         2l2k4eoEmAsWL07mBS2LnsLUE1IfzxJyFGcW2xzJwV4LcHe6oJEJ4tLsgVSIuwGJXHCX
         IlHhRQ18K5N/mDF55zdY3KIKmcblEj7qESE1C6L13TaQZlI1uMO/Ew5w4HwzokLtWIlA
         31o7rCABJs5FcayqD4N3n8QKmzfni8Hmp7XqBYcsgEj8dDtv1Ve5TTkEq2yyGaVc0k1M
         UkTw==
X-Gm-Message-State: AOAM53384KR9ppGCoO6Fd1Gp5VfUv4EKGh3kCVOh32BmBjdwHCEdOGj4
        mJZHTD96ZjKQUmifoO8MMEg=
X-Google-Smtp-Source: ABdhPJxKDk7xpkbepDWFgElAjkEPtEeTgll3N7aydUR7QtcYNBdcBTcqhVHo9xwRv960Bt/zB/uizw==
X-Received: by 2002:a05:6808:190d:b0:323:2813:57e7 with SMTP id bf13-20020a056808190d00b00323281357e7mr8161144oib.169.1650900296360;
        Mon, 25 Apr 2022 08:24:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b14-20020a056870160e00b000e67f5bd9b9sm3470763oae.45.2022.04.25.08.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 08:24:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 25 Apr 2022 08:24:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Renze Nicolai <renze@rnplus.nl>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] hwmon: (nct6775) Convert register access to
 regmap API
Message-ID: <20220425152453.GA4166687@roeck-us.net>
References: <20220309005047.5107-1-zev@bewilderbeest.net>
 <20220309005047.5107-3-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309005047.5107-3-zev@bewilderbeest.net>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 04:50:43PM -0800, Zev Weiss wrote:
> This replaces the nct6775_data->{read,write}_value function pointers
> with a regmap.
> 
> The major difference is that the regmap access functions may fail, and
> hence require checking at each call site.  While the existing WMI
> register-access code had potential failure paths, they were masked by
> the fact that the read_value() function returned the register value
> directly, and hence squashed errors undetectably by simply returning
> zero, and while the write_value() functions were capable of reporting
> errors, all callers ignored them.
> 
> This improves the robustness of the existing code, and also prepares
> the driver for an i2c version to be added soon, for which register
> accesses are much more likely to actually fail.
> 
> The conversion of the register-access call sites is largely mechanical
> (reading a register now returns the value via an out-param pointer,
> and returned errors must be checked for and propagated to callers),
> though the nct6775_write_fan_div() function is refactored slightly to
> avoid duplicating nearly identical (and now lengthier) code in each
> switch case.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  drivers/hwmon/nct6775.c | 977 +++++++++++++++++++++++++++-------------

Needs "select REGMAP" in Kconfig.

Guenter
