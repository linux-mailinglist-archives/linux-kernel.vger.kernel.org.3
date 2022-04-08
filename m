Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9B04F9EEE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 23:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239780AbiDHVNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 17:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238128AbiDHVNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 17:13:33 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4376F187B9B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 14:11:29 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y8so4289099pfw.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 14:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=yJoHVgCYASD8LnGD6yxNNYWY7QMbfJ8fAJgs8FOfIBo=;
        b=PPblHVCYNoTcYVGEDB9f3y8lb6kGlK/DpqflWVJ48wuqmbEKlX2Am4/NlbakXY8uK+
         yyv8n3dHilgLjLb/sdCT3X4JJW7BI9ZFFJUfwjVLdZozHe+ZlbNR+pgWNf1nmzPQ0iDM
         euXaJWoaJfy7oqug4JTuNadUjl3uBhsQwIlkwp9tRv71F9NHh5qbOn8ecKngNrh4k/cP
         8osiIySWZ7z/RFLqEFdUQxS5j9ehgEoZEOiViRACJUDNZWaMZB2/1E/EXGHLValnxRtb
         j9nA+i/kOfJTxme/3eo7B+pinZ0T5nwBfOD6ubx2YL4L0qZaTRlh7McDg+y50L5+d4ea
         jQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=yJoHVgCYASD8LnGD6yxNNYWY7QMbfJ8fAJgs8FOfIBo=;
        b=WRG3DVzTLPQ6gdZvQxmnz04tDHJBkHQAqQL0fN1dx6t8Zxrs157tR5Vv70cpUh+hfb
         56SxePaLFghYzAAircOKHHVwk/c6tIKVP0u1q+HfvboN8g28g7cgwrQIPQ49b3O/cvXv
         BLsl+AKf65BFXccJEShqm4aMITZxzAGHYA3VFaKQ/6UgkBgUzc5lvnc2Pgk0f+gNclpl
         05zQ9sDk/LNlMKUCfgs5S9vfixvFwgcfLzlkK6TallV7V3aghI1TsoBACmOhID9hy/uO
         OPghTV2MuxF0JYl1Zp83rXOaZncGH2QNbeFxGB3nt7H1enObOyf+IzJWxjOSFsanbI5F
         L7uw==
X-Gm-Message-State: AOAM531gO71WC0YFMfucTpuGpQknG+PjYrG4eB4ifc0c8cuJYzkJR/3l
        3kU/RR0sJKvAwC6azEWTD+J4IQ==
X-Google-Smtp-Source: ABdhPJwz6J42A+7QBRIWB9Mr2szuhxRCqq/9FHbuGOK9KLJKIYDpU9wSFNCxsthrDdcpshIsu1yBbA==
X-Received: by 2002:a05:6a00:1152:b0:4be:ab79:fcfa with SMTP id b18-20020a056a00115200b004beab79fcfamr21713713pfm.3.1649452288648;
        Fri, 08 Apr 2022 14:11:28 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id l18-20020a056a00141200b004f75395b2cesm26668230pfu.150.2022.04.08.14.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 14:11:28 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     matthias.bgg@gmail.com, jia-wei.chang@mediatek.com,
        roger.lu@mediatek.com, hsinyi@google.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: Re: [PATCH V2 00/15] cpufreq: mediatek: Cleanup and support MT8183
 and MT8186
In-Reply-To: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
Date:   Fri, 08 Apr 2022 14:11:27 -0700
Message-ID: <7h5ynj5lhc.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rex-BC Chen <rex-bc.chen@mediatek.com> writes:

> Cpufreq is a DVFS driver used for power saving to scale the clock frequency
> and supply the voltage for CPUs. This series do some cleanup for MediaTek
> cpufreq drivers and add support for MediaTek SVS[2] and MediaTek CCI
> devfreq[3] which are supported in MT8183 and MT8186.

There's no upstream DT for MT8186 and there are no OPPs defined in the
upstream DT for MT8183.

In order to test this on mainline, could you provide a patch for MT8183
that adds OPPs to the DT so this can be tested with mainline?

Thanks,

Kevin
