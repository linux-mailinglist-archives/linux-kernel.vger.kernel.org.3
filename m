Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343485244E1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 07:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbiELF1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 01:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349919AbiELF1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 01:27:37 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365CB69493
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 22:27:36 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d25so3802140pfo.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 22:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gRX0Ygzn0dg0e+70kr3m3IwBrYrMdQ1DQ/I+WXCJSvg=;
        b=qJ4KiVHH2rMmMzxaLh80DfGXnszrMQ43AKcvzJ4sxmCmOQHxbuHKloqpOXBMA2gFzq
         JctWdsEodVTpAPAmqX2PujOnIsHVmElZ3U5bWU7FgIFINRyDDriwR843JzqXV3BggJnj
         8cabiBskEd25W/8zfQbOVn4F2Wd88kW8sWZrOn3KWTaaIu12aPfYUTjjKLpkwb/I6dzk
         3RRViu4JGHvu7cHbr7Lgf9d0RDAuBuI7WGhc2/p5n/34xtfhGROPg81entmzf/nT2Fl6
         rNrwqIKxIX9rA0NZhJKABgxnVS09ra14kvAN1JeZD4CA/xUHw7LjlxgyQogLAWb/QF8G
         9dNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gRX0Ygzn0dg0e+70kr3m3IwBrYrMdQ1DQ/I+WXCJSvg=;
        b=iNeODDd8fjJolVwDAZKggdICSzxdOU+MzwRm0CXXg6Zj/9qhsujHckbJBS+Al6uKnH
         NaMTThdN3xVswMJI0zfJppIDMVWX1wmA4HoxK6x2U6xoBn/9n5Vdlhqvkbn/K6OeUKmM
         AONyQCQz+A/NU50pGUJcBsNJxja9BT/BPhmVgL1DXSpspEfWJZXlux8TQrSbu4LcGChI
         F7HmvtlwW0qHt4KY8rHuBFQyyP5XpsF5KfkLUXxr4NDKp64IrYjU114oP7LulrRe9wYZ
         YY59J3TsoD0RfCUnN4BZImtH3GSHqTU1xXXpSKq2j5ab9+WXYLgs5ukv61Zp35etFWKp
         hgBg==
X-Gm-Message-State: AOAM533VuGMdZjOn8t9oZuhWJASFiZNDzByeT3Yf9IZbvojjgHLhnHH5
        owgaAE4QlNfecaUdBPdSip1dVQ==
X-Google-Smtp-Source: ABdhPJwH8eYDeF7eTsAmzfIYKUwyKfpVinxgHer5RNdfSqN+NQK5HaJzocJuaIgksr1FKM5eMoFmCQ==
X-Received: by 2002:a63:3144:0:b0:3c1:457c:bc18 with SMTP id x65-20020a633144000000b003c1457cbc18mr23993540pgx.582.1652333255605;
        Wed, 11 May 2022 22:27:35 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id p6-20020a17090a930600b001cd4989fed3sm862658pjo.31.2022.05.11.22.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 22:27:34 -0700 (PDT)
Date:   Thu, 12 May 2022 10:57:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     rafael@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com, jia-wei.chang@mediatek.com,
        roger.lu@mediatek.com, hsinyi@google.com, khilman@baylibre.com,
        angelogioacchino.delregno@collabora.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v6 00/10] cpufreq: mediatek: Cleanup and support MT8183
 and MT8186
Message-ID: <20220512052732.iqphgpveoyrqjlqg@vireshk-i7>
References: <20220505115226.20130-1-rex-bc.chen@mediatek.com>
 <20220506042004.hqzpb66shak4y7rz@vireshk-i7>
 <86851bd03128cc61082d516ebff929d3637063cb.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86851bd03128cc61082d516ebff929d3637063cb.camel@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-05-22, 14:32, Rex-BC Chen wrote:
> As for rest patch:
> The cci series [1] is still under reviewing and it depends on chanwoo's
> series [2].
> Therefore, I think it won't be so quick to be acked for these patches
> in my series.

I have applied 1, 6-7 now. I hope it is safe to apply them ? What about other
three, can you get them acked now ?

-- 
viresh
