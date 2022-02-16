Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0A04B9272
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 21:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbiBPUet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 15:34:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbiBPUeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 15:34:46 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221F22A39EE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:34:32 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id x11so2873478pll.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lM3wWhDpKhtMoYgQLKWR7U8Z6MzzZFEnmP4Z5wjzN+8=;
        b=lSRFGSANbEVrOokV4rWf6cpxepU41iwsUUTXoSNcl2ejVHK5f3qVLMrkCqiUNeL7fC
         ph9ue3IvWkoIU0dtUp1mjNvMcUUYIu76J3wkAg1kURrPRP0UfYvqGRFtT/0b0gK3Wfc/
         7vueckZkR33wj5J2jPADjtx7SJWKqJh/4jmgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lM3wWhDpKhtMoYgQLKWR7U8Z6MzzZFEnmP4Z5wjzN+8=;
        b=pDd84iiPp7EIn/MGLSrp4Hg6G+j80V08xwc4YwNaJpzQ6z/eQPuMVvAQ9CBul29Mug
         gxuYvVORjjC6G28WSmzBI0w70XUw5twdePZV/DH6LRCXW/R0MuRA0egxq4GIQJR+tMPS
         AwTpZOF8xtia4C+jiwnIyhFNcq3biNKH+80N9OfnnwDAuA4yeLjxC6xPvqkPdDTkRg93
         wrV5NHKvBjHDL1OFJSwG8gdjzqZteg2pwkGrMwPQ2HcUMGq+c9uw0tnhbKoFv90Aao/o
         CgUHoFoKZ4RnAnWRRGRBGCwSEivuoiTuapFNw4eBPhAS1mUHVvIyqYJ26ngAEPH6BZOs
         bULA==
X-Gm-Message-State: AOAM531tIHs12OvSXtbUlDv8qqkEhts/qttLX3TPy6X72iBIgsZlTYdq
        J2m1bX0/KcVXB+ZD6+m7z/gLLw==
X-Google-Smtp-Source: ABdhPJxmluPD0ktYlysj8vNbzpWnhJoArECRiPqpwQ+ZHzWuD6DCMhi9X2HkGTk1xwUIt7vrE8Ms6A==
X-Received: by 2002:a17:90a:9b16:b0:1b9:fda3:2a8 with SMTP id f22-20020a17090a9b1600b001b9fda302a8mr3754878pjp.198.1645043671691;
        Wed, 16 Feb 2022 12:34:31 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x1sm5796970pga.40.2022.02.16.12.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 12:34:31 -0800 (PST)
Date:   Wed, 16 Feb 2022 12:34:30 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ath6kl: Replace zero-length arrays with
 flexible-array members
Message-ID: <202202161234.035ED44@keescook>
References: <20220216194857.GA904059@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220216194857.GA904059@embeddedor>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 01:48:57PM -0600, Gustavo A. R. Silva wrote:
> There is a regular need in the kernel to provide a way to declare
> having a dynamically sized set of trailing elements in a structure.
> Kernel code should always use “flexible array members”[1] for these
> cases. The older style of one-element or zero-length arrays should
> no longer be used[2].
> 
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Link: https://github.com/KSPP/linux/issues/78
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
