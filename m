Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF09248CB3E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 19:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356498AbiALSrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 13:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356481AbiALSrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 13:47:31 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3954FC061756
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 10:47:31 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 59-20020a17090a09c100b001b34a13745eso13913151pjo.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 10:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ej6+dzQXYBNYBghW2L5wnTD1qTCyFwEQze4u8PLMM8c=;
        b=k9T3MzlCu7qh8lbrZMe83Xi2hfmMkadDB+O1cBHpL7WOorRnSxHeHwXL9Ssk3f0wmd
         hS+rh67RzV4VyThVS7uI3PzlZ5Y2TQ+CssEiAKxtGvTQP1rpm7OeHzduw3rRGnB8GzcO
         cxzrrXYYYTYI32kxY3ywU9+MVbZP2M5NSd0pnY/1X3so+evKJxUfw6oBj1V+eYOEhofk
         bWDDeZHW1s5meAJywrAU407L/RM6zu81HK8CzU6LdABFlX1qZXRAK6S9mG5Nx2t8cu9l
         CLf772yfZwKv6neNpkSbSCyYLzTdrIAOv9dH8ag8PZiISwSSi6PU6uWLR1JH0y3xmxjM
         0rHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ej6+dzQXYBNYBghW2L5wnTD1qTCyFwEQze4u8PLMM8c=;
        b=flUw7HJiy+CtZetqM80cgtmCEsu9KisNJGLvhbK8nFtQBNb1YIvwsrCnT5PMXe2KXM
         hfSox8ylFp43yBoyObEMFY4jDDfS5q8IiTMY/Ue7qkcVOtTd0GZmwnG8fogO23rw6ap9
         8l+qxZQzy2OwvC0RhBH1TLuISTylyah1RQTnxUpACZxhckGEGf25MoezQN9WYUWVY1mQ
         6gzcSHcUIeNME0sUG+aB5g0MTTk6B3Z7yS2y3xSQ3qF3JXCKAdghgwfjXB9rrMdV+raT
         P6xdyS9HZcsx8zLPR92gLdyXFx95CqVo/C8merJrjU9n2/s9a26bm+VeIjqO1Sqccr5k
         2iag==
X-Gm-Message-State: AOAM531pvhqziReMwGjq5YM6cTFiOf6iN7rJT8A/54U3PtgtdmDZSwcv
        j9MPEjzJzli0/2zX4e998N6V5g==
X-Google-Smtp-Source: ABdhPJzFpL8XksOuR6w6J5ddL6p8mmeC1OPP8IFYeXebroqx48h3ogwBFXpq6MS1gdcueN+4pULAKA==
X-Received: by 2002:a17:90b:3910:: with SMTP id ob16mr10314729pjb.181.1642013250654;
        Wed, 12 Jan 2022 10:47:30 -0800 (PST)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id gt22sm367722pjb.35.2022.01.12.10.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 10:47:30 -0800 (PST)
Message-ID: <3c2eeee7-0d3e-8000-67ad-3054f229cbe0@linaro.org>
Date:   Wed, 12 Jan 2022 10:47:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 1/2] tpm: Fix error handling in async work
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Tadeusz Struk <tstruk@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220111055228.1830-1-tstruk@gmail.com> <Yd8fY/wixkXhXEFH@iki.fi>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
In-Reply-To: <Yd8fY/wixkXhXEFH@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/22 10:35, Jarkko Sakkinen wrote:
> These look good to me! Thank you. I'm in process of compiling a test
> kernel.

Thanks Jarkko,
You can run the new test before and after applying the change and see
how it behaves. Also just noticed a mistake in the comment, sorry but
it was quite late when I sent it.

+	/*
+	 * If ret is > 0 then tpm_dev_transmit returned the size of the
+	 * response. If ret is < 0 then tpm_dev_transmit failed and
+	 * returned a return code.
+	 */

In the above could you please replace:

s/returned a return code/returned an error code/

before applying the patch. I would appreciate that.

-- 
Thanks,
Tadeusz
