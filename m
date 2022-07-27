Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB43F5827F6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbiG0NrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiG0NrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:47:19 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A401FCF4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:47:18 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l23so31606907ejr.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=pD0G6ny8EAD0fMDMtOYPnO+aHsM6w839YN2s9qtUO/w=;
        b=L1byLWBM5YH28gi4Bs1fGqwkapmLINXqI7aiicDL3mtTozi4QwNWR0oGxgjb+FDs5a
         yL+xGnAZOL73IGmyKARW8Sfna9lpTCMbrcGxV6mfKdqIV5qPb9ZAIq8/TxmN75omBmJC
         +B+ziwGdlhNOkP9Mtbqq5CA42dWBnPy2PKtqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=pD0G6ny8EAD0fMDMtOYPnO+aHsM6w839YN2s9qtUO/w=;
        b=RSQJbVm7YOG2EDMZj5+UoR67obYONsM/5Wvi/BU6GerxqvHjHIXq5Wx+gFow1CWekR
         MZKsrIHSU/AAG3ZNtAJuEur3U71Bh/GSSDCJfJaHrbCa4wnzuMNK/vyecMc2LEDRogQV
         wJGCw2k/9hsLLqMz4R/O9zmKzpUp6Iahicspxn+Ryjem5J8gFK0dlnS8RLIh+jB2NEfE
         ah79ItwgeOfvZgm8tsO1DVY2ZiRRwJHz4629zOhcSNiXSEFfT1h4oSO4AJhyfYLGEHsa
         rYsDm/WMGxuh06fYrq38FjMkaU9g11+e+1udwJtg752M3+1ZyYdYPHTJUcoDHCrz7ySq
         uzeQ==
X-Gm-Message-State: AJIora8qVi42zEhc1NA9vBz3XTM6lhx8AO24lVkR52CvDinfrzEfQ1uI
        jpbBlucpOvST0fqZJX8EkqO8LYr+wg3OY3cJ
X-Google-Smtp-Source: AGRyM1t2sV5HfGF+q2pNxstxROCG3lIGyCnBZ8WuNn+OcGfOq3sZ4Cionfd2MXJIPj/pRTo+3CyDaA==
X-Received: by 2002:a17:907:2710:b0:72b:7f52:75da with SMTP id w16-20020a170907271000b0072b7f5275damr18680750ejk.26.1658929636728;
        Wed, 27 Jul 2022 06:47:16 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id l1-20020a1709063d2100b00722e0b1fa8esm7517233ejf.164.2022.07.27.06.47.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 06:47:15 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id k11so23827440wrx.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:47:13 -0700 (PDT)
X-Received: by 2002:a05:6000:178f:b0:21e:98ee:f1e6 with SMTP id
 e15-20020a056000178f00b0021e98eef1e6mr6771624wrg.405.1658929632986; Wed, 27
 Jul 2022 06:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220726212354.1.I5b9006878bdabd6493b866b46dbd6149968d545b@changeid>
 <20220726212354.2.I7d57fb9c4806a8b3fe3501c766b64f4987c271ef@changeid>
In-Reply-To: <20220726212354.2.I7d57fb9c4806a8b3fe3501c766b64f4987c271ef@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 27 Jul 2022 06:47:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VrRXzdf7kA+ztGaxBgCVpeSRjC9MD4q2g5R6hJxStw5w@mail.gmail.com>
Message-ID: <CAD=FV=VrRXzdf7kA+ztGaxBgCVpeSRjC9MD4q2g5R6hJxStw5w@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc7280: Add support for zoglin
To:     Bob Moragues <moragues@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moragues <moragues@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 26, 2022 at 9:24 PM Bob Moragues <moragues@chromium.org> wrote:
>
> Zoglin is a Hoglin Chromebook with SPI Flash reduced from 64MB to 8MB.
> Zoglin is identical to Hoglin except for the SPI Flash.
> The actual SPI Flash is dynamically probed at and not specified in DTS.
>
> Signed-off-by: Bob Moragues <moragues@chromium.org>
> Signed-off-by: Bob Moragues <moragues@google.com>

Again, other than the extra Signed-off-by this looks right.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
