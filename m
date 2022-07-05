Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFFE567837
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 22:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiGEUNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 16:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiGEUND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:13:03 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEE5193C0;
        Tue,  5 Jul 2022 13:12:59 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id h23so23484088ejj.12;
        Tue, 05 Jul 2022 13:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+4Rl23w/icZA1D45EvjNhKFOa2QN4S2mMkfghKH9T+w=;
        b=bokDxqmIAvNaE10/oTxRc+xeNaW52DY859KEXGdIQ9Miw2HatV/FJbH6I7G02PcPjN
         7XwKg8jK75qmfy0QBk8fJElDaseFAI1bsY0LxjeTlulhAp/twfDu95KTQ3pu+TFOkMGj
         /Ey7O2V4frtSaYtNZbW2ewMwfLK830sAScJlVSkGZp0bH3fkSQ/q2F8KeXDDXqkP+J20
         ggU0k8wL69pt8ReHZy65h6gJFNQrIaGWHRy/EhBD6OC74KPqDwh9ePQYLtbbIs1KRa//
         ZpmD608eNgmeyKKj1DB8bj2H4ryQumZE+ChuLFkVOcI9m5w+842X1WL96yHhuBk1jfWO
         dc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+4Rl23w/icZA1D45EvjNhKFOa2QN4S2mMkfghKH9T+w=;
        b=fn7fITbCm+PHTK7BgWhE3BY+NqIpWGA7WBbG/c4eRG1jnLbYevtswDT0EDPgbSJcTy
         72UHNmkeyBp0T0JtgLnQTtQQ9UTZAxHJhGST0V8WwN6VGj6vx47rG+on0RGPCV1vok88
         Y6WEHLQFSLbq4fLmtZiQsxPTeZzLnu1zioLYyOtsh0DEgft8EDqKZECi8O1t+v9ZnL5H
         otC2u0u7fJUsHJ22+0e3LpDCFgWR6ojmCjXGqW/m/GO7u6Bpqd1KOaB4QtQ+oKeWjEiH
         wG4sQ+CsrE66rgZ0DJnkJTCN6Burq30ANlcnyRHIrECGd4xITuP42NKqXtEb/6VnJ/vd
         f8mQ==
X-Gm-Message-State: AJIora8p7CXkrvGZC27gRK9VL1bmnO58fQAG/QwozSRBd5A8TxWv2xwX
        epZ+4ZwQYSwrvXvSZ4XBPW3cvp0GBA0ZQw==
X-Google-Smtp-Source: AGRyM1uxDY4QHvPbRs9gRTse8HNXy2XC7pEEwYoci795EVH18hYFZx0atz3AG4HsgJEPfforNDUfxA==
X-Received: by 2002:a17:907:1623:b0:722:ef86:e25c with SMTP id hb35-20020a170907162300b00722ef86e25cmr36283139ejc.461.1657051977854;
        Tue, 05 Jul 2022 13:12:57 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id t25-20020a056402241900b0043589eba83bsm13832022eda.58.2022.07.05.13.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 13:12:57 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     lgirdwood@gmail.com, samuel@sholland.org, wens@csie.org,
        Mark Brown <broonie@kernel.org>
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        perex@perex.cz, arnaud.ferraris@collabora.com,
        devicetree@vger.kernel.org, tiwai@suse.com,
        linux-sunxi@lists.linux.dev, mripard@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: Re: (subset) [PATCH v2 0/3] ASoC: sun50i-codec-analog: Internal bias support
Date:   Tue, 05 Jul 2022 22:12:56 +0200
Message-ID: <3139722.aV6nBDHxoP@kista>
In-Reply-To: <165636279016.4185952.318954133536578049.b4-ty@kernel.org>
References: <20220621035452.60272-1-samuel@sholland.org> <165636279016.4185952.318954133536578049.b4-ty@kernel.org>
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

Hi Mark!

Dne ponedeljek, 27. junij 2022 ob 22:46:30 CEST je Mark Brown napisal(a):
> On Mon, 20 Jun 2022 22:54:49 -0500, Samuel Holland wrote:
> > This series adds support for enabling the codec's internal microphone
> > bias, which is needed on at least some versions of the PinePhone.
> > 
> > Changes in v2:
> >  - Move register update from component probe to device probe
> > 
> > Arnaud Ferraris (2):
> >   ASoC: dt-bindings: sun50i-codec: Add binding for internal bias
> >   ASoC: sun50i-codec-analog: Add support for internal bias
> > 
> > [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
> for-next
> 
> Thanks!
> 
> [1/3] ASoC: dt-bindings: sun50i-codec: Add binding for internal bias
>       commit: 24e0b04dd42be34ec4b18dc1a1e139d66eb572a3
> [2/3] ASoC: sun50i-codec-analog: Add support for internal bias
>       commit: 25ae1a04da0d32c22db0b018e5668129b91fa104

Can you also take patch 3? You picked bindings change, so it's easiest if DT 
change goes through your tree too.

Best regards,
Jernej

> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark


