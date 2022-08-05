Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0140458AF12
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 19:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241527AbiHERoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 13:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241234AbiHERoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 13:44:20 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DC24C635
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 10:44:19 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id w10so3278556plq.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 10:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2eaK3KgfipnKY/OWHEdalzk6mEi1l+gMKFJA3MM1ZFE=;
        b=WfZg71YKv4vm6Az2hcnnJuM+wKapIbQyhrMtLOhzbsNtTwsjcUuzc2mrmFJvfT8V6P
         JM1YT8kFLX/5ILe4hjCNGtNXBC3+9crsJuHktS8t5HsX55pbH8d6oVvwvDSolVv/NzZF
         pfm4d96h/8lygHDyDpMePWg/W4Kf3SRoRB29I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2eaK3KgfipnKY/OWHEdalzk6mEi1l+gMKFJA3MM1ZFE=;
        b=33shA6fey6K6VSAZfUSSaCRQAsdrD5E2/X+RqfeXKSfqYXictLCtY1cPhw7LtIOwD3
         FtcxUHZ3XQFa3NXXY7Jz+V14PQBdDTGK3Vr/GygIldc0qDeRw8AFrsJSAUf0LbWT9UaC
         xK4V7WWC5O6YuAEPxnvwChHgJ2ZNKNfREqQQbeMwT8zmr0bLe52QX56h9FHTPFXV10ek
         jrRYgAR4gAkXzBBb0vo36944466ctqS29PDganJksbFwxRJnR+aDqoWJqYoYdNYvm5ZX
         USFB/9i/90peAIAsNZlJOssk8cpbsd+fY/v7nvrGGK8hE7Oen4dvvw+nt3Jj9OOmioNJ
         UyAg==
X-Gm-Message-State: ACgBeo3FGBX36yo0LLhpKv3jtX+V4D7LHbozR8z3MQmM/kYCvblrPJPc
        TQJOciVa2LGMYM/5Ltoc/L0rSOSafvFsVQ==
X-Google-Smtp-Source: AA6agR7Oj3KxFb6Nbzcd5ohAtzIb8h9mrZErAM0SXSnWBVCaARohwFSAB0KwTQwNY+4u3F5p4pXyDQ==
X-Received: by 2002:a17:90b:1a8d:b0:1f5:31f6:fb9a with SMTP id ng13-20020a17090b1a8d00b001f531f6fb9amr17372529pjb.245.1659721459043;
        Fri, 05 Aug 2022 10:44:19 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:c59c:1680:614c:3338])
        by smtp.gmail.com with UTF8SMTPSA id y1-20020a655a01000000b0041a5e8dedaasm1700114pgs.92.2022.08.05.10.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 10:44:18 -0700 (PDT)
Date:   Fri, 5 Aug 2022 10:44:17 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: dwc3: qcom: only parse 'maximum-speed' once
Message-ID: <Yu1W8RROdi44sELd@google.com>
References: <20220805074500.21469-1-johan+linaro@kernel.org>
 <20220805074500.21469-2-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220805074500.21469-2-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 09:44:59AM +0200, Johan Hovold wrote:
> Add a temporary variable to the interconnect-initialisation helper to
> avoid parsing and decoding the 'maximum-speed' devicetree property
> twice.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
