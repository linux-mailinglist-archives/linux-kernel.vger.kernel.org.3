Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9755728A3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 23:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbiGLV3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 17:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiGLV3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 17:29:00 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C56C9125;
        Tue, 12 Jul 2022 14:28:58 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id b11so16563943eju.10;
        Tue, 12 Jul 2022 14:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BknaE/Kld0FnjC1aUofNUzwSa+QGAFkBMskakzse0z8=;
        b=oN5XoqcVxMnycuXA07RCPGjZGDbKv2XzrtoJdpEJqM+T/yQqztcOiBEJz+KqUqqJga
         kw+SX/a38LI8HrpIyvN00Sbql19iG/4qDMO5R7dVKWLrNZjZ/E32SM4Ct8/1sjlnQEvY
         jgrD6Usb1wE4swF5y3adFtdK17D5h5AYUAjgGh/JcsuDFRQPGc3krlBvRWHgeV2FqwN6
         xxHG4wI1ZSJHbHvfA9ksmdK3ND3XVYsJVUcmpkbzGs8o0eU+i+pf2oTxtDfcO2p+SzWu
         BcSKR36gyCkwm6wLNXFThR7tMjPOh084ssJxilJ4bp2NcqjfmpdRq5ufZU69xOQ4AF9a
         EjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BknaE/Kld0FnjC1aUofNUzwSa+QGAFkBMskakzse0z8=;
        b=bqG07SDVtPeK/s3LHrGLIzma6XioLSiy+aEe2tEDGsIX1DUmTgYbmDoSVXBebtGKwV
         HOgcKfxWvVIEfxjOqdykPHPeE/+LsSkGayPcrVYaied3z1ykqmAV/95POAVFoKYWuMtM
         WmCYMlCrX1uXoWZsNUV12HLAbS9bW6jJ/LrWRn8W/t6EeOdDnbZDmjwDS8udtHGzZKwW
         Lm4XI/aNSmma0R5ZVsSeMKzSKTav9+HtXQfL21Jq+ushgT6icEIyYdOLcQfzbTU+xyn/
         XlC+iGtLDbj+fkoNZT4RG7DPORc2Kh7LhYTb3leWySEYndiCQuOSgM748E+nqnk4cXSI
         MpKw==
X-Gm-Message-State: AJIora/fQGACKRJJSoxgWC/mb5sLpKBbg1sDVMXHtWvBC58x3MH+LoJS
        5Zdg5QHR0+wguGEHlqrVVqa8N2kTkK/YmA==
X-Google-Smtp-Source: AGRyM1ty94Bi/kThUyYCtcONkfQEatSMxB4zQNDcet6s1fIeNCkp6cZN9Ip6+R4/UZLfNCXrGMqLvg==
X-Received: by 2002:a17:907:d18:b0:726:3172:2266 with SMTP id gn24-20020a1709070d1800b0072631722266mr129773ejc.476.1657661337442;
        Tue, 12 Jul 2022 14:28:57 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id c17-20020a056402121100b00437e08d319csm6572339edw.61.2022.07.12.14.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 14:28:56 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        samuel@sholland.org
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] media: cedrus: h265: Implement tiles support
Date:   Tue, 12 Jul 2022 23:28:55 +0200
Message-ID: <12371972.VsHLxoZxqI@kista>
In-Reply-To: <20220620175517.648767-1-jernej.skrabec@gmail.com>
References: <20220620175517.648767-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 20. junij 2022 ob 19:55:10 CEST je Jernej Skrabec napisal(a):
> Now that we have full and stable HEVC uAPI, let's implement last big
> missing piece of HEVC in Cedrus - tiles support. This is done in
> last patch. Before that, there are bug fixes (patch 1 & 2, previously
> submitted separately in [1]), error handling improvements (patch 3, 4)
> and added helper for dealing with dynamic arrays (patch 5).
> 
> These patches are based on top of [2].
> 
> Final fluster score with this series is 125/147. 11 bitstreams are
> MAIN10, which is not yet properly supported. 5 bitstreams need better
> memory management with auxiliary buffers (wip patches exists). 4 are
> too big and 2 probably fails due to ffmpeg implementation.
> 
> Used ffmpeg source is in [3].
> 
> Note - Cedrus driver currently supports only one slice per request since
> HW takes data for 1 slice only. This can be improved by loading data for
> next slice automatically after HW signalled end of decoding. Something
> for later.
> 
> Please take a look.
> 
> Best regards,
> Jernej
> 
> [1] https://patchwork.linuxtv.org/project/linux-media/list/?series=8187
> [2] https://patchwork.linuxtv.org/project/linux-media/list/?series=8208
> [3] https://github.com/jernejsk/FFmpeg/commits/hevc-mainline
> 
> Jernej Skrabec (7):
>   media: cedrus: h265: Fix flag name
>   media: cedrus: h265: Fix logic for not low delay flag
>   media: cedrus: Improve error messages for controls
>   media: cedrus: Add error handling for failed setup
>   media: cedrus: h265: Add a couple of error checks
>   media: cedrus: Add helper for determining number of elements
>   media: cedrus: h265: Implement support for tiles

Hi Hans,

do you mind picking patch 6 and 7? They are reviewed and don't depend on patch 
5.

Best regards,
Jernej




