Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26024FB23B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 05:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244486AbiDKDUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 23:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241621AbiDKDUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 23:20:00 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44FB19034
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 20:17:47 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n18so12732026plg.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 20:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dc09Mr/cRd+6iXXPVvE/h653BCcb5B6zFZqdYQ/noeA=;
        b=rzMBqfjbH13GjkNd1tBmKo8aloT92MH7r8uQkdBA376vb9LAQ0PHIrhQbqJkYk5siW
         qETuqVGhOBNPDjVkS55FB1P6dcHmapNUBDi9MJ5mE/YdpnNxwZ08J93t2/I31LjcdVWz
         xapIz9qLKpPnsXJ/On+QC8ZN8VL2nCh6e11OcpggkVKa+4009UNF5LxyjOoz3XRfUZYM
         4A983aYwACy9/4W3EUdP4eHBa/bg/ElgS7VMWJhew/XQDk+HaTDb39opLgiHsajsHNLF
         287aoOu1OEIuevlxZKmCEafIbE+fMwRYw42aARJMeYcKbqIPKX/9u1i7CNns2cBkuHI9
         F51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dc09Mr/cRd+6iXXPVvE/h653BCcb5B6zFZqdYQ/noeA=;
        b=ZWS5auMuX+QarjAsWMY+6zi8TpyFwUWtwaDeLtotEAJ1TM1VgZQCLxr9zPPOeKoAe5
         krBWNQIL7ofRGtk8vuFwdGkoNo+PLLgjrH+/4rq4PXr2JdhQkdZbKfcdZVDtBb/kd1Dd
         mNbYL6UoWsW6XXQ0u08YiSWORVbLTb+CTR9wa5tXlAfG+H3qgGpiGVr/BQGdQh/1VNO2
         JB7rYGH70jdOjTlRWoXxEXxxCdgQ7SkJlsxVBaHqYcVqD8IhDHDE+MgjFrQqkupYWpS0
         MLSg3OZFmQQ+4hIO2kEA8l/LPp3zc7yfKchjDnMGzWHJngBTs9KvfsddyBCc5omnMdLS
         +a2Q==
X-Gm-Message-State: AOAM530JIO+4mPD5/ri73QPaLCxdKx3Q//fGjTo8wuGASntCvB9jT9pl
        0rfidvhDmjZ3ocmjZZpYKNgYQQ==
X-Google-Smtp-Source: ABdhPJyZOTvJy00/iB836UyFTnhof3BtvKwJ4OR28/djCJgk7YRRuAcgMOQaw3eMSXkioq1mIoheSA==
X-Received: by 2002:a17:903:41c9:b0:158:52e6:343d with SMTP id u9-20020a17090341c900b0015852e6343dmr5509730ple.146.1649647067276;
        Sun, 10 Apr 2022 20:17:47 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id p4-20020a637404000000b00375948e63d6sm27214717pgc.91.2022.04.10.20.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 20:17:46 -0700 (PDT)
Date:   Mon, 11 Apr 2022 08:47:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com,
        jia-wei.chang@mediatek.com, roger.lu@mediatek.com,
        hsinyi@google.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH V2 02/15] cpufreq: mediatek: Use module_init and add
 module_exit
Message-ID: <20220411031745.eumhltqjldryp6rb@vireshk-i7>
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
 <20220408045908.21671-3-rex-bc.chen@mediatek.com>
 <1e3338a6-d1db-6ae1-2cd2-d45a4babc844@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e3338a6-d1db-6ae1-2cd2-d45a4babc844@collabora.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-04-22, 15:36, AngeloGioacchino Del Regno wrote:
> Il 08/04/22 06:58, Rex-BC Chen ha scritto:
> > From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > 
> > - Use module_init instead of device_initcall.
> > - Add a function for module_exit to unregister driver.
> > 
> > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied. Thanks.

-- 
viresh
