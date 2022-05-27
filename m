Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232425358C6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 07:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243110AbiE0FeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 01:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiE0FeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 01:34:13 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A081139;
        Thu, 26 May 2022 22:34:11 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gk22so3683466pjb.1;
        Thu, 26 May 2022 22:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mHsgR073nhQ7znBaXl9ZvXV9DZWPaFFSru830DQsQ0Y=;
        b=CkfNzIX8OnRfpWFXUOnAK2Y2udwIkn+RM//g1UjElnQfxTLLBc5IXRMhx+pU8BWMjc
         xjmVOlZ1LNnRpS+GBqKYJwfcswbsj/Nc6MOsxNBYvSKC5Pa0OeDiOj6Sj5MZO4UhAJ7a
         bqzHOY7gzlyaqgtyrM9UJbv35hXoEC6lXjl5fypxLahyTmc0ORExCulIbeIx/MpkSJ5n
         qvEIYQv2TBox4vgK08jFchhbhM3utHie9tHAwq8Y/pq0rpt5AzCLkCQ87Y1XniD9RRnz
         eQW5wfPuK2TZRP/WYe/lvISDHqd65pJPObSo730LllZDZpltyVC3SKKMayWBCIjhZku1
         gtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mHsgR073nhQ7znBaXl9ZvXV9DZWPaFFSru830DQsQ0Y=;
        b=yRMwNdt8yLhmYlNJwpeNcvD9nQnTq916LyMhyEtNvNrN0JacHscAewLdplpP7ZAcXN
         0E/P8osgwBKMWrGeCkkw8Q55ZGztFQlPMfavhSYN1s1F529yutnCOvFGvLklesMxZYFm
         jxzEXnjKxcp0nDH2jMRFqzENvvC+wcMFV9fYir9FMYV8O02d1PHsyCJJxr+0iG5432DV
         oRU9LZzFa3HQ+hUN9pyGHaicg/gPfYtHiHuE4OF/FHCPP5D9OFIJOYWUcWgT+JwPRkJZ
         JEM8kVX9vLToOuw5szUH3d9KKx8TpwhrQ/3rqIgkf4LVuhae1FI2RulRB2R/QRoiDG5X
         41yw==
X-Gm-Message-State: AOAM530cGAujfAn7YagZQZmGreFQ2HfFu5KiazHb14kBV9LlKmxfukE1
        eA5OeiBBJRTUDhachYPMFQE=
X-Google-Smtp-Source: ABdhPJwfAEUlQxnLazyMiIdYppZUmcBVdFsMafDQPnrug63PbYyjGGPsFKtKok9xhI7YJZ1jY+iD3g==
X-Received: by 2002:a17:902:a50f:b0:162:28c6:bfac with SMTP id s15-20020a170902a50f00b0016228c6bfacmr22440174plq.99.1653629651318;
        Thu, 26 May 2022 22:34:11 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:3206:ea0b:ce53:ea86])
        by smtp.gmail.com with ESMTPSA id fz6-20020a17090b024600b001dbe7ccdd4dsm629302pjb.10.2022.05.26.22.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 22:34:10 -0700 (PDT)
Date:   Thu, 26 May 2022 22:34:07 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, mkorpershoek@baylibre.com,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] Input: mtk-pmic-keys - Transfer per-key bit in
 mtk_pmic_keys_regs
Message-ID: <YpBiz7fGCgHaKqGs@google.com>
References: <20220524093505.85438-1-angelogioacchino.delregno@collabora.com>
 <20220524093505.85438-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524093505.85438-2-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 11:35:03AM +0200, AngeloGioacchino Del Regno wrote:
> Place the key bit in struct mtk_pmic_keys_regs to enhance this
> driver's flexibility, in preparation for adding support for more
> PMICs.
> 
> While at it, remove the definition of MTK_PMIC_RST_KEY_MASK as
> we are now dynamically setting the keymask relatively to the keys
> that are defined in the newly added rst_en_mask variable, on a
> per-key basis.
> 
> This commit brings no functional changes.

AngeloGioacchino,

Could you please tell me if these devices (currently supported by the
driver) have 2 fully independent reset settings for HOME and PWR keys,
or is there are actually 2 separate bits, one to enable/disable key
reset, and another controlling what keys will cause the reset - only PWR
or either PWR or HOME?

Thanks.

-- 
Dmitry
