Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF2D50CF69
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 06:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238182AbiDXEh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 00:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238219AbiDXEhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 00:37:46 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBC1626A;
        Sat, 23 Apr 2022 21:34:46 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id i11-20020a9d4a8b000000b005cda3b9754aso8480683otf.12;
        Sat, 23 Apr 2022 21:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ErfZuYBRCWu7UGDAs1dgWCKIrnFFZmeMA+Cj0r+40SU=;
        b=lUfwRXGtyBiDQ/KJjl8mfPheqfWD/lxSpOqdh0u4Y0rdgWXiCaolq1aybg7oj/S5t7
         2BUf6rkj83r5T33gRL4SEHtnAS7UhnyncTe2ABd/mXKiTV0v+1pWC4ZR9iRMJHZCO1GK
         C8s/RTpvzT+JPam8T9gdUEjeHDgzqUN7xVC+rfisEmWXnfA8X9UqJC2EjYPo/CjDjoc4
         2coGCQxaY3QdJpq5mcyTCO96Y+d8fNu0aW7rj9OQC3+Jq6BBAisZAgEV1Bh+zmYqLDrF
         nCCbk1kgkwG9R8bk25G3pAnAGQKiyG2LlSvttmsGyuI1PxwFu0DRBxqcLe1husaj1Jo/
         zr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ErfZuYBRCWu7UGDAs1dgWCKIrnFFZmeMA+Cj0r+40SU=;
        b=qc1usehOyi8vZOtDwLG6qr+yYK0TzBZP2RfaXsBeE8J+QPFLO2W6pKQbGF4vh7KpoP
         BQgM8u0BtJ23g3CvgzdzBlpdojf3dwUC/k1hHC/mZEsW0uVv7Oq3u3RuRr6YzBstDSv/
         DfD+khysYSWqcKKsObFIKsTkTKwXLU7WxbTo4b4+kgZcqkKV6Lz+uqQo+NR/6mn5olh8
         A4wFcTZpKDXFgECWsaTfLMy1GhRtvli+G0bdNZoiS33J0SvaDVfvRbllSJnGLUt9OFaU
         VlovX9C42PXmpt3euKikntDRu+UVOYoCQYNdwFvhhUxCOvmb+cckZLnlp6JgMKS410j2
         XPnQ==
X-Gm-Message-State: AOAM533aa6YpnInIpfyEGSEN6Xrb5SQh2L2ipCWyiW99OvVg3AQZDMKm
        8CIY6MZ/Ggp6I/EsCcotnsnNAItYRE4=
X-Google-Smtp-Source: ABdhPJwGTURk0pp704LZTJ19hhlI95VpVZ+N8lWoeZk1qPGfXJW2fH5KInU8o9O+ALBI8WZTzaT+0w==
X-Received: by 2002:a9d:734c:0:b0:605:5cef:cdf5 with SMTP id l12-20020a9d734c000000b006055cefcdf5mr4581407otk.126.1650774886186;
        Sat, 23 Apr 2022 21:34:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ps8-20020a0568709e0800b000e910249ee3sm1468537oab.9.2022.04.23.21.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 21:34:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 23 Apr 2022 21:34:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Camel Guo <camel.guo@axis.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH v4 2/2] hwmon: (tmp401) Add support of three advanced
 features
Message-ID: <20220424043444.GA4001077@roeck-us.net>
References: <20220414075824.2634839-1-camel.guo@axis.com>
 <20220414075824.2634839-3-camel.guo@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414075824.2634839-3-camel.guo@axis.com>
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

On Thu, Apr 14, 2022 at 09:58:23AM +0200, Camel Guo wrote:
> tmp401 driver supports TMP401, TMP411 and TMP43X temperature sensors.
> According to their datasheet:
> - all of them support extended temperature range feature;
> - TMP411 and TPM43X support n-factor correction feature;
> - TMP43X support beta compensation feature.
> 
> In order to support setting them during bootup, this commit reads
> ti,extended-range-enable, ti,n-factor and ti,beta-compensation and set
> the corresponding registers during probing.
> 
> Signed-off-by: Camel Guo <camel.guo@axis.com>

Applied to hwmon-next.

Thanks,
Guenter
