Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F306D5A3A02
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 22:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbiH0Ukj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 16:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiH0Ukg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 16:40:36 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CA513F65;
        Sat, 27 Aug 2022 13:40:34 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-33da3a391d8so113308517b3.2;
        Sat, 27 Aug 2022 13:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=a43bxgCVH3rA1FTnedAN3yus3ZoDoZPFWJOVyvSBDyo=;
        b=U7D7wNpxLoHE3MMbr+rI8SpJ5EBQd8lJ2Qj+mIFKdbfeOdxnXoDeLwUbl2b4QUe+S3
         6qeGAtj9bzKy66OVlDB64sVwXIkovbAiv68z7+HKvQv52WzbTME5yv/aL8KjAfMcnarw
         tCIExGvqCdJ9Hm7RC6RgV7AL1K41VL9Lp7Go4XDdarhrxlPOn803lG6AUoha5fz09s+X
         ndB0akjXH+LF1mCdO9NvI2ubHbre/7rbvrExPB916v2FiTQvY+hLaUGrQb7zGncLDZuy
         plUlRbv61ClFMYaFx09nRMqWdx6X5DJOWkiazYNCuHvxsqDFL8eDACvdkpHpy16YP2E9
         aMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=a43bxgCVH3rA1FTnedAN3yus3ZoDoZPFWJOVyvSBDyo=;
        b=34JoI6DyYmZSisjOWDaQAVwkMGj9U0GXj1KuGY3q+wMhq/TPVTQeivYMJP/acIH2Bg
         47Za8CXpDhdgDSfNVesvA9Yy1KBGfG38QSANAYknMYif+GU+3uykpJLR1CxfueDLzvTH
         snNPE1SyJLQgCL9f55F51whukGEDxlATchL9Vo47TStIisKNM7DCapDyNgX8hPT5iEQI
         g4Q7Aa+w6RaVE5bSATKUX+Jk1RNZJlj84Ggfn/EeDAZz1ULnoTMQmvmlopXRv8sOlCh0
         ZQ6SS3R+CHdvNUbym17Xnyu5Zzbsm8f8NbQ/kLXYwnDCle5T2o688UqdcIoIPUwvdmCx
         nyew==
X-Gm-Message-State: ACgBeo0p4cVFXI2DrLyBWjVYm496NaF1lp/3k4a4nVH0pI1PgVqwEoX5
        bi6UO0SRJxtOLgh5S9X/edh9Hsn/MxvQvgswex4=
X-Google-Smtp-Source: AA6agR5W9bwOSWdZq6cApJvjXHDjxg1Q8AUtHvo++rxzP731ZIP5KAqE0qiM2Zw5UhXJ8VrNApYaMwOgM6p3G7fCHNo=
X-Received: by 2002:a81:d543:0:b0:325:2240:ce5 with SMTP id
 l3-20020a81d543000000b0032522400ce5mr4751398ywj.210.1661632833757; Sat, 27
 Aug 2022 13:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220825074008.33349-1-jinpu.wang@ionos.com> <20220825074008.33349-2-jinpu.wang@ionos.com>
In-Reply-To: <20220825074008.33349-2-jinpu.wang@ionos.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 27 Aug 2022 22:40:23 +0200
Message-ID: <CAFBinCBZkGZcrR5Aue5N+=zTM2MAj3w=ox1Vu1+Od5BK39PGTw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: meson-mx-sdhc: Fix error check for dma_map_sg
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 9:40 AM Jack Wang <jinpu.wang@ionos.com> wrote:
>
> dma_map_sg return 0 on error, also change the type for dma_len
> from int to unsigned int.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-amlogic@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Thank you for this patch! It's:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Best regards,
Martin
