Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7B05A32E8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 02:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345115AbiH0AFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 20:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344716AbiH0AFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 20:05:52 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA20EC9265
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 17:05:51 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z8so3927466edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 17:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Mw13r/NEf88HLkO79A/I8TLHBHsGJ5L1+z1A/fwUkZU=;
        b=HXNmQQEsYibEClG/SsXww2ky1RfNOXWRhD3re/kBNX4EekQfiNPs6Zqmp5ExEyRuQu
         BZnaHAdPOByqFC9fSq3kQp8chfLErStT7s3Pdfrm0LFy4gY9kXlWaCajirTBBg7cErZD
         DTLB/4aHi4sGMSUHjM8BTbsUiYZP5zLmrP8G8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Mw13r/NEf88HLkO79A/I8TLHBHsGJ5L1+z1A/fwUkZU=;
        b=7vxGy1EbY4AfupMwIb5Km6SrA3bWMVyN/9yOodn5upl1riaxQWnt4soj2Vu4tbD+Wq
         ZThfQn91wIh/BVFcqydy2PcRhvFKkF44Rwn5dy9YHq2VwealHOHmjQr96N6u0AiT1S+Y
         GivoilBM6J4QTKPp/BsmEFcQGHmON68PzbBzlcjVCqXQ+tWslGY+m1JIGTT3eSAaYQai
         ewNRs3wpsJ+bFPGufJ1gsjg8Kw1++udBjOCz9GvzxC33QBl3zIfrQ0iceunnIztzWJjU
         1kay2nfph5FBHZfOn78bqbSYXBF3XaxX6HRSa8uyGgRXm2tA5xlXaNMD7fbp8l3uVF/Y
         gvOQ==
X-Gm-Message-State: ACgBeo1lpmeABsxwbtut1VfY2HVfrgtcDz87m9Lwibs/9bipofdkmT60
        vlGwDwMg/IJRraKz53GSC69FQf/zFJ+QCsC6
X-Google-Smtp-Source: AA6agR4zvI/zcxJjyfiICGckqBJR91DPOCPWRxdDDyvSHWJ/7gH6OYhdbieGchUJ9kXkiEfM3fHr4Q==
X-Received: by 2002:aa7:d7c1:0:b0:447:d3ec:69cb with SMTP id e1-20020aa7d7c1000000b00447d3ec69cbmr5294324eds.105.1661558750193;
        Fri, 26 Aug 2022 17:05:50 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id v17-20020a170906293100b0071cef6c53aesm1453451ejd.0.2022.08.26.17.05.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 17:05:49 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id z16so3491457wrh.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 17:05:49 -0700 (PDT)
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id
 b13-20020adff90d000000b0020cde324d35mr942817wrr.583.1661558749013; Fri, 26
 Aug 2022 17:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220826102513.1.If97ef7a7d84bcc2cf20e0479b3e00c4a8fb5a2fd@changeid>
 <20220826102513.2.If877318e8cb2a43e6a0ba3e9ab5b8d3a93467db1@changeid>
In-Reply-To: <20220826102513.2.If877318e8cb2a43e6a0ba3e9ab5b8d3a93467db1@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 26 Aug 2022 17:05:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ua+JLaOxUgecjeTzO-07itmkCaWcvW93ADkZ7qcfA3Qg@mail.gmail.com>
Message-ID: <CAD=FV=Ua+JLaOxUgecjeTzO-07itmkCaWcvW93ADkZ7qcfA3Qg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Add sc7180-pazquel360
To:     Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moragues <moragues@chromium.org>,
        Henry Sun <henrysun@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 26, 2022 at 3:27 AM Yunlong Jia
<yunlong.jia@ecs.corp-partner.google.com> wrote:
>
> +ap_ts_pen_1v8: &i2c4 {
> +       status = "okay";
> +       clock-frequency = <400000>;
> +       ap_ts: touchscreen@10 {
> +               compatible = "elan,ekth3500";

As per offline discussion, we're not 100% sure if we'll need a slight
variant on the touchscreen compatible. However, to me that feels like
it can be a followup patch.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
