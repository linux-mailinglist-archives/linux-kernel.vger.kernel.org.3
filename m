Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B15855C380
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbiF0JaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiF0JaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:30:09 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D163718A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:30:08 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id o4so8182722wrh.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cd0dGlxS3lhXEywnR/6FkGKK1ogQZNR4Q8TNrLmu+N4=;
        b=GXXWOwmac4DoGtIkpAqyAR8KvIPiWKfClDuoGQKkauZpU1Gh1cIo3nYg1PvsGU16nA
         gxnNkgf8DDiHP9FwNbV65gvsTKz52FIdzrS1tB5NZwliU509YCUph9hRydj2Ed1VymEp
         hRRxAEaWcDxASuemfk1tdAdrU1ABkaRWzBIoJqnDqlyCwWE7TMa7TjHy8Stxx569hqU8
         Xw91uryUe0c69spzuDdIOQHQNA/EcQ4FD66lsT+g3lQ7hgk7yZql9yNLkEi7cUHYzwt5
         IgkV8YIuH1rKD4DqPEwRgwsGE7HTAGX3pOni9tPmlyaGQgYJ3sQYwhRFG+ima8Oe1FZE
         9LlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cd0dGlxS3lhXEywnR/6FkGKK1ogQZNR4Q8TNrLmu+N4=;
        b=72SeYP1K/fTZM0mHh0F2wJ4f9H62RjvDKd1tKuWPabbuWy2kAXEATife0QWRKdBTDS
         DLK8Wqch6zUXBzG6RxuFCq4XrFZAWycLWnCl4yss3pliyYRTN3NO/rYIVWwp7gHBsj3Y
         GSxOedQSY8G+JG0u0eDQUmbE+AkuK5bobADy6tMtLSO95lfDRpmdGZqqIhzOOIcrKjZD
         HfGwDEgtpKbE4OCvDPX6FN1e79FG8C7+2DyKIZxQ9hO4JaaJpQWNCfmR/tGs4Ntbtezb
         dMUVw6J6G+4+lP8l8rHjKVUovRPb4uhiqBYuridsXPzaLbF81NkJjHEzlsVb0YIC3Lgi
         xPyA==
X-Gm-Message-State: AJIora8y+SLWrl5fub7M36QhG4+DTYLyPI2+n+1baxxzSUprZHs6+IGf
        ifjN9G8DJpRDmyfp7R2FWLirQA==
X-Google-Smtp-Source: AGRyM1t91+8MZTKoH2nDlZBDD7AUAi9ckE5QNRxXAmU2VDI7I2qnhR0/WxRLoNA6o3J693aI7BafjQ==
X-Received: by 2002:a05:6000:1f08:b0:21b:ae8f:4f0a with SMTP id bv8-20020a0560001f0800b0021bae8f4f0amr11784449wrb.456.1656322207431;
        Mon, 27 Jun 2022 02:30:07 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id m12-20020adffe4c000000b0020d106c0386sm9747810wrs.89.2022.06.27.02.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 02:30:06 -0700 (PDT)
Date:   Mon, 27 Jun 2022 10:30:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 08/11] mfd: intel_soc_pmic_bxtwc: Use bits.h macros
 for all masks
Message-ID: <Yrl4nXfHs1oM2dpV@google.com>
References: <20220616165823.4919-1-andriy.shevchenko@linux.intel.com>
 <20220616165823.4919-8-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616165823.4919-8-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022, Andy Shevchenko wrote:
65;6800;1c
> Currently we are using BIT(), but GENMASK(). Make use of the latter one
> as well (far less error-prone, far more concise).
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_soc_pmic_bxtwc.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
