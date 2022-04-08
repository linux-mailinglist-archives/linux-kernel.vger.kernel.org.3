Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E147F4F9EFA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 23:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239777AbiDHVMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 17:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239766AbiDHVMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 17:12:52 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC61A181D8B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 14:10:47 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r66so8804674pgr.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 14:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=NGL7uIJYy64vRyv+WyTds0iR2sbu1H6xVYp+rBwYsq0=;
        b=0goe0SNyqeqNy9wKzBOTFC+7DmniXqC3vl6B6Ja5dbVTVTC/BZKzxTot9QUgRHj3YF
         TX9uws+8EDjls/VkPD49zygJEFl3fLPDh7wOGrUaQQ8Yi9manuILnBLXpKiJbDtK6wkd
         GBiXXLaiaTeyvR6B0bEboiCWp+bmK6fpIW/N2D87y5kKLuBdCDygGdepx6sOGFnlnlPU
         f25f1FkaVYI5MTYGDfi/LHNLH7gGp3EbDDCmm+zhZ3uyTsz7D43liONM+N5RJmkiJYTt
         63QBbMSvZi3/thOx0tR9I1AIZtqdN8wPSiaDxF/GgO4azda9Ys9eZDXwB5bc14UwGZJd
         PrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=NGL7uIJYy64vRyv+WyTds0iR2sbu1H6xVYp+rBwYsq0=;
        b=jJtgu94P4ITf3hZV0McBkUvHAxJRO82ZUjzbwHNH387IDlhY9h2bZlsS2Pkv+8PRB7
         fVV6Br4pSeUCgb7yBmeGhVJU8PlEt7zjUKRMguoLlvefeRMxz71u8OboA2fautsiqjKT
         VeqrBE2EXl+BkBxfRiXfdcMyBG1AAjMHSVV1Fh6oKbm5Qb35Vr93eLdCqLp3/e9nhrbG
         5Yml46g5A0hdy/0eCG+kxZKZUckw+DVMMrVbvTZwPXnQ/J/NXvohcCoWQ0JtPnkXpSuL
         yViOXJWOKyri82jLEhAUjcxjNEa5CZ1nvOPsf0/DYK81gUfDb4JQE14n+hf6aCplYJa3
         qs6A==
X-Gm-Message-State: AOAM532fEQjnM72rtzU5AKn3CvWsZJpY3D3z9lS1QAyZ5dpyf9GkrIVP
        GZWJVXC6OGgEwftZXbNHzJPzRZx6mlqWeQ==
X-Google-Smtp-Source: ABdhPJw5mutMPEroFwzVQlx6BF6zMMQsdO7eg6KiAaxV8KEQBMyUxgjwuUVnLSqBovjUXQR6fpGbkw==
X-Received: by 2002:a63:4f0d:0:b0:399:5115:ff48 with SMTP id d13-20020a634f0d000000b003995115ff48mr17296204pgb.235.1649452247397;
        Fri, 08 Apr 2022 14:10:47 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id v4-20020a17090a00c400b001cb4f242c92sm2330393pjd.26.2022.04.08.14.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 14:10:47 -0700 (PDT)
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
Subject: Re: [PATCH V2 14/15] cpufreq: mediatek: Add support for MT8186
In-Reply-To: <20220408045908.21671-15-rex-bc.chen@mediatek.com>
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
 <20220408045908.21671-15-rex-bc.chen@mediatek.com>
Date:   Fri, 08 Apr 2022 14:10:46 -0700
Message-ID: <7h8rsf5lih.fsf@baylibre.com>
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

> From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
>
> The platform data of MT8186 is different from previous MediaTek SoCs,
> so we add a new compatible and platform data for it.
>
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

There's no upstream DT for MT8186, so I"m curious how this was
tested/valiated with upstream?

Kevin
