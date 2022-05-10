Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3886C521064
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238509AbiEJJQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238488AbiEJJQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:16:11 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8C82DD57
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 02:12:14 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 202so14135438pgc.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 02:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h0/eXylGNAueAU7FrP3IwXCzMzPqW0qtEOPvWEn2U/M=;
        b=DDh5nMeA6yw8EpZ5Xio66OeElfarNGX6D3MwNsbrwQg5KDtHnLf8dfABDTPQsu9zEC
         d6mUPKf8S7KYg4No/NGrHavkomljB+a98GUyKTMe1GjOHPmhd8T3QoWTAWPbvQ2eV3Ld
         D1HtbikX8cG1Ws2uTs6IfbDhldPnMvNYS8sAyw+HhD0nNJOSRJpF8BipKmQvNFqjjXkS
         9pOECntNvD8itxByuRh6+Z+CoP6fh9eB4taXrK990uU+Vgjei3K5uoJE33MakXUlkHJT
         WFyy6slKYGwxAPF2bNMusmbTv33ZC5iZq90anRHt7AoQleiwNtcSjiM0CPIiBHGWoseq
         MWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h0/eXylGNAueAU7FrP3IwXCzMzPqW0qtEOPvWEn2U/M=;
        b=T8byCpvhohAnlAPeDegcTjd5tzmxtJIZ1xwNh0YZhgu5hcs2VE6uaat1Xn9kAL0zPy
         VuXeopwLfYQDL0aLoQD3TARD49C/JZml58qLGS2Y1xiTzK2vP6wHaYwusVUVpo7EAWP9
         GlPIl7gPzjyBA6JNcIiYfVQbnoQuwEBh0u//fXNCTtOxtr/aKjZ4wzw1ZGhfKnbXwaZG
         HUQehgtjkPOz+jEFzPl3MuZFK/r7sqtQ3i7tiThrI3BGz9hm7N/xEuutdwv+fqwV3l4R
         4enaOt84w4x4Cj5TpFNXWlJh5i1lnZjx0jLtfxmSsS/uIbCo//Rg8q02+d8XFed2WgqG
         3aBQ==
X-Gm-Message-State: AOAM532OVyr8rAin0pilTsHTTpfAcKEJPFGaaVjqnlBQP6fs2/0TjGIa
        GpaJuQLT1fJYytOCY5aYVfj82Q==
X-Google-Smtp-Source: ABdhPJx78FuXlWndkKECQOsIhgGXq9UcykG/wSe+ro44JBVrYFG0rAyOoZd3XA5plb4FlldILbDgPA==
X-Received: by 2002:a63:7450:0:b0:3c6:234f:e70a with SMTP id e16-20020a637450000000b003c6234fe70amr16398793pgn.619.1652173934523;
        Tue, 10 May 2022 02:12:14 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id ob12-20020a17090b390c00b001d95c09f877sm1289808pjb.35.2022.05.10.02.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 02:12:14 -0700 (PDT)
Date:   Tue, 10 May 2022 14:42:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jia-Wei Chang <jia-wei.chang@mediatek.com>,
        "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] cpufreq: mediatek: Fix potential deadlock problem in
 mtk_cpufreq_set_target
Message-ID: <20220510091212.olrvvjlx4jtm7zw2@vireshk-i7>
References: <20220510090531.12438-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510090531.12438-1-wanjiabing@vivo.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-05-22, 17:05, Wan Jiabing wrote:
> Fix following coccichek error:
> ./drivers/cpufreq/mediatek-cpufreq.c:199:2-8: preceding lock on line
> ./drivers/cpufreq/mediatek-cpufreq.c:208:2-8: preceding lock on line
> 
> mutex_lock is acquired but not released before return.
> Use 'goto out' to help releasing the mutex_lock.
> 
> Fixes: c210063b40ac ("cpufreq: mediatek: Add opp notification support")
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

You should have added the review tag you received.

Applied. Thanks.

-- 
viresh
