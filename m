Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29A75398CA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 23:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348020AbiEaVaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 17:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348042AbiEaVaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 17:30:05 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6069CF28;
        Tue, 31 May 2022 14:30:03 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n10so29153787ejk.5;
        Tue, 31 May 2022 14:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OdK+eE4TOLAxsJTNj+9orro+91ojVQC6MaYJmCCbeQE=;
        b=piTVTfroLPwR9dT+4Pxk3X3JiQOi8Rvd7xtOxQFx22lNbSupKGHOb6zriXv+TUGynk
         fX0z5+eNlfg9jIyx3P+oq8kLuA/g+0IJ41r4WwXAgBllyhENcpto9vfLhekqVuFVoe+v
         ZcNdT+zYtkLnjbb7PBkn+c211KiaN/Wl562tyGgJVXK89NJrMqZtT/Vg7QKP+pGhzcDf
         3pRWxtyXogxNnfGeWDYyCRcUtgBMfvaGiSQj+3egVqLwVmxiHNXEp4ADIAMmQCHJ7wQg
         hBFM69KE1ooA+Qqi5iIh0uEpykPCaCNtb98Ev52oHt7yi97C/zp2pHELNMgdvWzd4NXS
         ORVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OdK+eE4TOLAxsJTNj+9orro+91ojVQC6MaYJmCCbeQE=;
        b=q7r7/RddAkUiTZmcrQqAK6Q7jo7Y0ozRp3v/uDeN4pFV8XGX3eLkrZeSA8FcuzeBmd
         afsEGxrdJtoNi5wTHF2RyUNF2Njet0dcuPxpnyc5P7srfIKi3n9KTMe30FEpO15zRE3F
         id3IPBOeGdV4uwKkHFLq3xVk0gGoxV1/UgRJey5NnRTXb9OFfxgLI7kMZAu3EmTbgIT2
         ieJO1AEtZHZxobJAGIkVLjbVQtdQc28DOCjbwsjn6fobIB2M8CkGT+cdp0U6eVrOwBEw
         Stb3z9gpR/j279iEe0Gf3wwYRDq7EAxQf276Ff8D6tLaJRWK4Ih+tOWiOLfCcUdNkTUP
         gciw==
X-Gm-Message-State: AOAM530NqrsXcOVoNwPzBKNgM5qoi7v7hbuc06Njq9CR9d0gFfWv36Ix
        zfXXbw7YEu3Sa3Bnmf7ABhjhDEreIU4TO/JzlFg=
X-Google-Smtp-Source: ABdhPJyOPJ2fxBW5GtBabP3sWZr13JugYTG7IRGrl+fbQSib4tmjBMNQZI9rwETvFrK9H3lHfAOxdiHHf2/cp8zGX3k=
X-Received: by 2002:a17:907:1b19:b0:6f0:1022:1430 with SMTP id
 mp25-20020a1709071b1900b006f010221430mr55649654ejc.13.1654032602340; Tue, 31
 May 2022 14:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220531211842.71998-1-andriy.shevchenko@linux.intel.com> <20220531211842.71998-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220531211842.71998-2-andriy.shevchenko@linux.intel.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 31 May 2022 23:29:51 +0200
Message-ID: <CAFBinCCDyX-dncLWV-CEuQ2Ksauxg-Qm=ZO4jRtMvXNbMYuBCA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] iio: adc: meson_saradc: Use devm_clk_get_optional()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
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

On Tue, May 31, 2022 at 11:18 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Replace open coded variants of devm_clk_get_optional().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
