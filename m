Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3C452AB1F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352345AbiEQSpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352344AbiEQSpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:45:01 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331FB39B88;
        Tue, 17 May 2022 11:45:00 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id o190so20224379iof.10;
        Tue, 17 May 2022 11:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lUy238nMpvEvl2v9xc46uFLuB5rlBp2vt6Z0ncfv3Tw=;
        b=aVneSFLGS7/Q8IaZfkmVSttswtaMa2DLaZkPa4XoOJuViF8qAfnBMkjYzWsFeGmfz9
         lulSPpYiL26gk/PFUmjw0zG4RISx3yr1pDsPG6uiCtvHRn3/n2P2rPJ3JT/dYUyz42/B
         sgd6yPsrYf70CRN/yoir0ULfwxD6IWlqFK/5BzaeBucPH6XAOIZQ+DtKF8DrpJA63uce
         iGHaGUZHvgxeB8W3L4PNYTKVFpdE/HePmgWqOb0IvgDKkPwK8/+0+F6ZMt02u/hYzzjz
         ti9Rqu7rcSSc8ipZXJwzOhaBjbK10bIGzJQO8NcgXqO9f4Be+KIV5lUlm9eaOCm0wA9G
         L3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lUy238nMpvEvl2v9xc46uFLuB5rlBp2vt6Z0ncfv3Tw=;
        b=b5ZCtMIQZXtbk1136Xc19eA6tpQtk63+nyRtf9gQRFxfSeAWDTrlfOcGGDR6IcFwAB
         vtRm4/FQtEnO/CmvYYiCsdWuBqb4s0AfQ49Dug8utz+5hs74dthEpHOYgbutyjVH574q
         F/BcYTp24J/bBlKIYanYdcuSXCbsmVpV2u4v6V1B5hf5OZi3vZ/8JL1vcb/HiFenevfq
         A2Ws4VA6t0ahJIOTb+tKJIe3CoNWKKgh/IgjVCzPaiyMMCh8vdnOiJLzugH9yz5vyLrv
         P7r82F6TJg1EeS7onOpgNcb2IzjpMhPzvNFP271LDYTXJ/IR7MmxA3wNlPnJu2B3c9rx
         Aqww==
X-Gm-Message-State: AOAM530I0spvx0H5Hm3jGFzadi18YcdohMyt1RAFAKOrI1DrkQ1u2jGS
        TAo4/1S8X9/+mgPPXACGSayUEb6Fg91e60U93rkPMMJoILZyog==
X-Google-Smtp-Source: ABdhPJxcEi8IfxZ+n4SRU+Iwu6eEWoqsslvZEj71yr2eye9dJlr/0+Re5dKgpg702TTUVuMBPEI3rCC/jpJ1JRzFqcU=
X-Received: by 2002:a05:6638:3589:b0:32b:858c:6cc3 with SMTP id
 v9-20020a056638358900b0032b858c6cc3mr12843978jal.229.1652813099592; Tue, 17
 May 2022 11:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220515064126.1424-1-linux.amoon@gmail.com> <20220515064126.1424-6-linux.amoon@gmail.com>
 <2a8e9301-5da6-46b0-850f-f3f12447d400@linaro.org>
In-Reply-To: <2a8e9301-5da6-46b0-850f-f3f12447d400@linaro.org>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 18 May 2022 00:14:45 +0530
Message-ID: <CANAwSgS7-907hR+2zB1Y+koZQunZ=9va3T5rmXSQswngVVpMhA@mail.gmail.com>
Subject: Re: [PATCHv2 5/6] thermal: exynos: Switch from CONFIG_PM_SLEEP guards
 to pm_sleep_ptr()
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

On Sun, 15 May 2022 at 15:17, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 15/05/2022 08:41, Anand Moon wrote:
> > Use the newlly introduced pm_sleep_ptr() macro, and mark the
>
> s/newlly/newly/
>
Ok, I will fix this next version.

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Best regards,
> Krzysztof

Thanks & Regards

-Anand
