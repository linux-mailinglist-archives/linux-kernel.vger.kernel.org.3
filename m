Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C388452AB16
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352312AbiEQSn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349466AbiEQSn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:43:56 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E30D38BED;
        Tue, 17 May 2022 11:43:55 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id q203so4438259iod.0;
        Tue, 17 May 2022 11:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=24z2rIPOjspqLIvJA+pLlxRucFiWn677Oid4iweb0Dg=;
        b=RflgnTC/fSgfiQ7JPC4Vo6LtMqSVZUonqUxgiU+LpZ60b++1MC0YPHjrPGZE8Bc/0n
         kIZbEilYsDEsF2YjerI/J98vVcayeNomP5KpHNM8/y4ug8RJ+8i5iNQRqXxiZS1TlsRU
         Dvw7RoiBNXb8VC2A+MT2cOk4GVZZDi4DGrfxPRo3yy4lhzDvyI5WmLRLnGdQzRqZheX/
         cR+YGA40M59Q4mXzbzgJYMnmAw2NGOPMXDigu+yDXThTqKL98vcucZMW6V3YD64BmU96
         CmG6IB1VYw+hX5GVx5GEa+CjojTa+IyOVFKbflXrIL0DmvdTnxMbEcTKYJ934PqnI5Pn
         0/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=24z2rIPOjspqLIvJA+pLlxRucFiWn677Oid4iweb0Dg=;
        b=YKGZaE2oWAeS20+vLMZ/BsNzKEN7VlIYfCHmCPjaT8ZR2Oreb22HAFlaTP5lO3Z4ND
         tLERzhAZvt0QOIbiwUtLB1EDFDEyfulvdhzU2MxO/mDBEjWij5JDTnq3Vj2G1mBM89BL
         KLIGHlZj+t2mqng2Vr1HZU39qbaiA9+Ngwj8Mz62RbtIKd9t5aS+v/KD74Gh9rW8agRV
         37Gv7a7Z3oZAKoqE/Gds1eXTMZNigs+11opu46UNwlN8g2nwSXbng6hBgcb645NOWhk4
         RXVQ0Q7WbnDyhhX12S5UbrtvWV/fpnzsRgVznwunlYGfABbYqr5UAMvecKyT7rkbTtXv
         uh+g==
X-Gm-Message-State: AOAM531vXkPXxwuWmsq+ctJNR1344J2dXbj3+e+BFTxaM4FzjoAjN+dI
        sH8SYHxsuEJgeH68JC3tI7SytUQjyI1gEL0U5FM=
X-Google-Smtp-Source: ABdhPJy43gOA2vSTuvgpKh9zqiGfS8aX38Qop9gTMFY6BV4lVnFHg58wwQVqy0+5WdFrUYIB98sLszgM0jueiGM9FR8=
X-Received: by 2002:a05:6638:3b2:b0:32e:5fe5:d37e with SMTP id
 z18-20020a05663803b200b0032e5fe5d37emr1039074jap.252.1652813035053; Tue, 17
 May 2022 11:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220515064126.1424-1-linux.amoon@gmail.com> <20220515064126.1424-3-linux.amoon@gmail.com>
 <fab8d2b5-7c1f-4047-8b51-f78358a77d01@linaro.org>
In-Reply-To: <fab8d2b5-7c1f-4047-8b51-f78358a77d01@linaro.org>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 18 May 2022 00:13:40 +0530
Message-ID: <CANAwSgSmDZa7gnhr+RAFOn03C4WzYTav-ANGEi+mkNRcSuDeWA@mail.gmail.com>
Subject: Re: [PATCHv2 2/6] thermal: exynos: Reorder the gpu clock
 initialization for exynos5420 SoC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
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

Hi Krzysztof,

On Sun, 15 May 2022 at 15:20, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 15/05/2022 08:41, Anand Moon wrote:
> > Reorder the tmu_gpu clock initialization for exynos5422 SoC.
>
> Some more thoughts: where is the GPU here? This is a TMU driver... In
> subject you also describe GPU.
>

As per the Exynos 5422 clock driver,
CLK_TMU_GPU_APBIF  represents the clock for TMU_GPU
CLK_TMU_APBIF            represents the clock for TMU
hence the subject is GPU-related.

> My comments about unusual code order from [1] were not answered.
>
> https://lore.kernel.org/lkml/CANAwSgS=08fVsqn95WHzSF71WTTyD2-=K2C6-BEz0tY0t6A1-g@mail.gmail.com/T/#m3edd1fa357eb3e921e51eb09e2e32d68496332eb
>
> Please respond/address to all comments before resending.
>
OK, thanks, I have not touched that part of the code in this series
but now I have a better understanding of the TMU drivers.

> Best regards,
> Krzysztof

Thanks & Regards

-Anand
