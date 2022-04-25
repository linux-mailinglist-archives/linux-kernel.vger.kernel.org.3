Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6976650D8B1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 07:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241201AbiDYFPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 01:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237644AbiDYFPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 01:15:37 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BA3DA
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 22:12:32 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id a11so2547625pff.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 22:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6+nWr4Y0lknbWn2i7wUGZGpJdQiqZVDrE2sy90jRX2k=;
        b=TXnE9l6fWX6RBgCxLzk7kJDu38m1Gt9aaNpsNNgU9ILQkJTaVwa+/01ZW5jCf/zhO1
         5kmzX/Q6sBx0Q85L0rbArtyCUpQRGsqYnBDPpn8xpYXs8th8ZSHpO63MnEjY/ds7MWaf
         QqnyzXzICuDDntnHLWdiYr58fUo5i7Cqgl6GY/xAqG2Sz568Q4KuEKSBEsbtg8qdaYEp
         Ry7cHmRM1GaUy97JxFeyxHG0s8Ur+1jj4hxVon48ACVFOixNnCHML76Sjn3z21lNnAV6
         IT7DRyM693oRuXOgQULXMJi+QFycj9ko6Hk86E8B4mUR2x9V95K++1qEpK81XfD1VD2I
         GRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6+nWr4Y0lknbWn2i7wUGZGpJdQiqZVDrE2sy90jRX2k=;
        b=1ACsHirVlgSUO1U5qs+7HDuaNAuAbKTYcds/avJHk7LJpo0F2tLAj5K/vzoy5WMNJs
         0doWMbhoOn04n9enQECEMz4b0c/LnlorzKaObEuSow6M0AtFrxURYiIZEmHnGZIbCYad
         xtjxLxJ6+4IhaOPQlnNmjHzAelhH6xDPtfKeDUA7SfyPYMLfdhHAfPE/cE1pvtaVB0py
         eFHgaAiq//z6uJn4BjhRJXs/QG+rIz6Pqi9nKxCPPVqla1pgCvXGfNl2au2/6yMw0+o8
         MCTHH2+Q+Bctrb14bRUgyaAr82AMQpRRS992f1rMBLky9g4v0CotE5SHltTVK5WlTlSk
         8Mlw==
X-Gm-Message-State: AOAM530mq/OOtUObv2MiNx9qBe3GR0c2iH+FmlIRzibNQyjylH1B9W1+
        l1RyeLtHJALXzDoS4PcEOfTX8w==
X-Google-Smtp-Source: ABdhPJxoAdqqZYNLUfEPEATeFhzguNqLrENazm9zPZWZ0M/HzCefiyvBIFHsjvJu5u3knhJllQPxAw==
X-Received: by 2002:a63:5b53:0:b0:39c:c6b8:d53b with SMTP id l19-20020a635b53000000b0039cc6b8d53bmr13467754pgm.166.1650863552491;
        Sun, 24 Apr 2022 22:12:32 -0700 (PDT)
Received: from localhost ([122.171.250.232])
        by smtp.gmail.com with ESMTPSA id j2-20020a17090ae60200b001d96bc27a57sm2575040pjy.54.2022.04.24.22.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 22:12:32 -0700 (PDT)
Date:   Mon, 25 Apr 2022 10:42:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com,
        jia-wei.chang@mediatek.com, roger.lu@mediatek.com,
        hsinyi@google.com, khilman@baylibre.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "Andrew-sh . Cheng" <andrew-sh.cheng@mediatek.com>
Subject: Re: [PATCH V4 04/14] cpufreq: mediatek: Record previous target vproc
 value
Message-ID: <20220425051230.74gqbqgwi5afmyby@vireshk-i7>
References: <20220422075239.16437-1-rex-bc.chen@mediatek.com>
 <20220422075239.16437-5-rex-bc.chen@mediatek.com>
 <f8f9bfa4-8591-0399-73a9-6e4b7261df07@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8f9bfa4-8591-0399-73a9-6e4b7261df07@collabora.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-04-22, 10:21, AngeloGioacchino Del Regno wrote:
> Il 22/04/22 09:52, Rex-BC Chen ha scritto:
> > From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > 
> > We found the buck voltage may not be exactly the same with what we set
> > because CPU may share the same buck with other module.
> > Therefore, we need to record the previous desired value instead of reading
> > it from regulators.
> > 
> > Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied. Thanks.

-- 
viresh
