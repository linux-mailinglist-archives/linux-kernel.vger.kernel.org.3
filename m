Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A14955C8F1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbiF0NGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234977AbiF0NFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:05:53 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697501180B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:05:14 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id s1so12959788wra.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/nXNvkObVFaJtoS16BTHyMD36MTjQ5lvQoZmZqQxyi0=;
        b=XQ22KoClhyYrzKh5uFCkropattdkQXqSucvojCPr2HnEmRvS+hciTb+ngMN3YyWWgs
         67jpag3puIha4MvWR2+HzpPL6wIw+Z/BHJWIu3wkpteHrTgP8zONXeXC1VKa5HZCirnc
         IYbl8ZJwbnFZ6Ym65MffImYfI1tp1ewBcTIBBZcNXj2IZhmCTRKc9PylFfJeNvwVBNmd
         w8RMJhydCyLM0h8mmV5ICgDrwydfTOYfDwHOwqtVFdIdLrijftprUaahI4It149jNZ1r
         XUtL2or1eNLm2YE/I4e+rSDHEGyvkxJ/GSqe3F+7v1M+MJ4yVUvcF8cdAZeHRXx2WIV2
         X+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/nXNvkObVFaJtoS16BTHyMD36MTjQ5lvQoZmZqQxyi0=;
        b=WQg+UbyrRBYbHhEProui4h8n6fiQv6DvtWd1DgWOE/dJlpU6FFUljrcz9C+0qwzpqe
         mXNBMUE/dgPlNiXjqlvnsh8VmCOow51Ba3KHTwEl7Lb47BacJ/CdaQQnQX2g1t0K+osN
         jybXSS6RP8wEAjp9Jilu2FAScX6i7gr0VGiKzy7svkB7lR1T/vsHG/omvLA2ezAcodfo
         rwTIHe/pWKx91xdpNsx3kqZdaBFe+vCcDAiDIlZw4GNVE6RzAWzNbZGyFZ4nWoLQ6keL
         ts9C0pzcDBnfBh39ry+o9bNN85BSWEUCfnVkHDGfUZM8LXXNuzCwrc8QCKv1jAvVxuX+
         wliw==
X-Gm-Message-State: AJIora+Dmk+Z45jCTvDQuXgdtV4x0lqKNEcRID8v5JshJLLMxjANquWb
        CnPX10FtJYeuQ0WQe4I6Ri3cbg==
X-Google-Smtp-Source: AGRyM1vzXlnOdlAVmUlBr6/NsfKo237Y+IllEK1vyvuEiucaGQ81GNuB4UJptIrzZZc4X5PGb+UxNg==
X-Received: by 2002:a5d:4205:0:b0:21b:89ea:b5e3 with SMTP id n5-20020a5d4205000000b0021b89eab5e3mr11644772wrq.103.1656335112960;
        Mon, 27 Jun 2022 06:05:12 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id x10-20020a5d54ca000000b0021b85664636sm10336057wrv.16.2022.06.27.06.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 06:05:12 -0700 (PDT)
Date:   Mon, 27 Jun 2022 14:05:10 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/2] mfd: intel_soc_pmic_chtwc: Use dev_err_probe()
Message-ID: <YrmrBoKbAaEq0X6r@google.com>
References: <20220616171009.43524-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616171009.43524-1-andriy.shevchenko@linux.intel.com>
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

> Simplify the mux error path a bit by using dev_err_probe().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_soc_pmic_chtwc.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
