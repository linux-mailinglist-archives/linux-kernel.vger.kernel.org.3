Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F145378C7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbiE3Jqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 05:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbiE3Jqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 05:46:53 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F719588
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 02:46:48 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id bo5so10149207pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 02:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UALvhWndaZ+8NVhyXVMTGWogK9BCZuA7nUC2dpZdhFc=;
        b=nfZTMfLpScX+7i5oxd+QZy4f+mKCKtr/6YCGg5q0/lgh99OiWWiF9Lhh/QN4IyB06x
         2moQEr4XBMjGQbiaC0VpfDMoopZq24/GbvNSsjxuZ6Wg5tXQqYnssMAXVLkV6IBTc1Uc
         I0W43D5oupX+ULjNU0O/Zy079+v15+Hpwi1Lwjcpw8s3TZPuPh46PHH6DRzVVX3YYFei
         voXdEcR5xXF1NbbXIQkCEHvN9PVS5Ua+/Xc5iO8BFurRxfgaDKxQLXF3xBUTYzFjATFp
         nRFunal+5Xm4EQwL9DrkIb+ItUSCfQcxQg4eVXGpxciSU5/WlY+xV84yfqm58TLrPcMt
         dOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UALvhWndaZ+8NVhyXVMTGWogK9BCZuA7nUC2dpZdhFc=;
        b=k2bYyGeNYwwOeZVv7Ums0l3kqLVh4SW3ynloWJYRwsxaRdLVJ5NdYtMppZ+2XRVzea
         GaOqMMhBd92MD6AQAU//iniTWKEluu285u6EJOvHlBHqFXNYVtgR28EykMh+NNsoKCeH
         Vj6HhtJqq/qzM3wHsWzOLU9TTn6gyltIrGIH3ZibT7UKQwWfMoaFEH2qw4+lmzOKXw1U
         cRzggRwUXUUK5jN/0d2yc/QLltpLAGirlxTqvQCSxplfFzLh6dnWr9TuZhcwmDKegRD+
         CxZNxWL/k+4q8yA2RRTT/uCRzRSfttfkCdVABfwkr5iLrhZINXjyZfYosQ2l6aMIAHfa
         Ax9A==
X-Gm-Message-State: AOAM532vqU+HaBWURvsu3gBmII4m3VURLhOAuG2XhYYIiPMU4vhoD3B2
        adeSNchRvDfrKw0TwIDyxJJl2Q==
X-Google-Smtp-Source: ABdhPJxqfWEVJFwZmG5yodoFspNLPE7pWMsnb8wZBPkQOCSd4+v8Lx2w85ya08P/2p5qJrj2pACptA==
X-Received: by 2002:a63:8243:0:b0:3f9:6c94:5112 with SMTP id w64-20020a638243000000b003f96c945112mr41340598pgd.173.1653904007740;
        Mon, 30 May 2022 02:46:47 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id j13-20020a17090a588d00b001d9927ef1desm6377266pji.34.2022.05.30.02.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 02:46:47 -0700 (PDT)
Date:   Mon, 30 May 2022 15:16:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com,
        Dietmar.Eggemann@arm.com,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1] cpufreq: CPPC: Fix unused-function warning
Message-ID: <20220530094645.wky42wwkbszfjjzs@vireshk-i7>
References: <20220530081236.40728-1-pierre.gondois@arm.com>
 <20220530082025.vqzk37dvyzxiq7dv@vireshk-i7>
 <3a26ce90-5d2d-0164-3799-85a9dc1abee6@arm.com>
 <20220530090738.7ycfr7g52b54jzj3@vireshk-i7>
 <2b2df076-f8fe-10f7-9bc4-3e1f3c1639d0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b2df076-f8fe-10f7-9bc4-3e1f3c1639d0@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-05-22, 11:42, Pierre Gondois wrote:
> Ok yes. Just to be sure and except if disagreed, I will use the
> following structure:
> #if CONFIG_ARM64
> #else
> #endif
> 
> #if defined(CONFIG_ARM64) && defined(CONFIG_ENERGY_MODEL)
> int populate_efficiency_class();
> #else
> int populate_efficiency_class();
> #endif
> 
> to avoid having multiple empty definitions of
> populate_efficiency_class() (for eg.) that we would have with:
> #if CONFIG_ARM64
> #if CONFIG_ENERGY_MODEL
> int populate_efficiency_class();
> #else // CONFIG_ENERGY_MODEL
> int populate_efficiency_class();
> #endif // CONFIG_ENERGY_MODEL
> #else // CONFIG_ARM64
> int populate_efficiency_class();
> #endif // CONFIG_ARM64

Look good.

-- 
viresh
