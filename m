Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BF15B29D5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 01:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiIHXBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 19:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIHXB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 19:01:26 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0028249B5D;
        Thu,  8 Sep 2022 16:01:25 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id q81so122478iod.9;
        Thu, 08 Sep 2022 16:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=1y2e9iN7w2CyRTkufQ1s+f9MtJ/dLudTGMJOd2zKm6I=;
        b=dkEYxaehlSzxOxVTsSCbldg36x3XgOgSFt/tfwD+z8qaiMVwoiyLz3rwP5eyLFVB9z
         bm2uldl/mDBwAEhzwbXuzlUHlBgaq7gEmnYa0VMtYuY5LzH21yTQXsGPqkc/+Z+KRii0
         6zmBw6HWbCfgBZX1aSAsqunYAdHF5bNOG6eG3ev1AoV2EOKKl5PvINHAAToJWOyy1n2d
         N2+Asrf3X2NDYe311COqOehaMPqAb+KvoNeDp9e9bpuQkXmFvTJLEtqrejaEiRJNyGDT
         s5DFgfK0ZsZATCuqnuwe2vtQM8iPPRSHP3zFLOi9GR+TuLax/IwtPIIFillnfS25D3m+
         Mjcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1y2e9iN7w2CyRTkufQ1s+f9MtJ/dLudTGMJOd2zKm6I=;
        b=01WV2MXOiRGfo/F5umQnqyuE6DudCa/vkJFMQXseuZQCVhj054+mS7I5C4PR5XbnDe
         ErzCOzX7MnyusA7fYxSSHJKcCig6a5Sk1XJo8tjfMj4V9PFyFzg1IGYllfX/XRI06sWt
         z9pHB63i0EoTKHDYpyJnE8VDth+6JLtySzKBK/g5QRjHFulqthLu2rui/4+2TeHkkSh+
         j3GsdoA+Xql0hs7ip5sWUXun4Mn+5rUwMuEgSZTfKSNMn5CPiHiJ2DQwc3G7khZdNxYn
         ApSY7E2/1sEge+dh+lPnzFR2zfMwY20cGWETix/PZCpSxabJkuDhHN3FzFkklYezz+eg
         j0eA==
X-Gm-Message-State: ACgBeo2coNQpFkCBi3I74m1pueoNix4qJr4UVzCBLhdr6AElwLx7SN6U
        SGEcWaEpjtLZr4dEIbQMXh7ImbRIdes=
X-Google-Smtp-Source: AA6agR5Sbzk1Yo6gHEM1GZPcwoQLGeNQoXVoBNTGWBPOk4lCBtMgwHD4Von82/zgNF+mYxzfcxqAjQ==
X-Received: by 2002:a05:6638:3892:b0:342:8aa5:a050 with SMTP id b18-20020a056638389200b003428aa5a050mr6342260jav.145.1662678085389;
        Thu, 08 Sep 2022 16:01:25 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::6f2a])
        by smtp.gmail.com with UTF8SMTPSA id c34-20020a029625000000b0034d90222997sm112390jai.66.2022.09.08.16.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 16:01:24 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tdas@codeaurora.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, caleb@connolly.tech,
        jo@jsfamily.in, Richard Acayan <mailingradian@gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: gcc-sdm845: add sdm670 global clocks
Date:   Thu,  8 Sep 2022 19:01:01 -0400
Message-Id: <20220908230102.207682-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <2d4de63a-c536-669d-b90d-21f60bc6b6fb@linaro.org>
References: <2d4de63a-c536-669d-b90d-21f60bc6b6fb@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +        clock-names:
> > +          items:
> > +            - const: bi_tcxo
> > +            - const: bi_tcxo_ao
> > +            - const: sleep_clk
> > +            - const: pcie_0_pipe_clk
> > +            - const: pcie_1_pipe_clk
> 
> Blank line here.
> 
> With this:
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks for reviewing. While I'm at it, I might as well swap sdm670 and
sdm845 if statements so they're at least in the same order as in the enum
(I don't know what order to put them in).
