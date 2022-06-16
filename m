Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112BD54EB89
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378910AbiFPUsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378462AbiFPUrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:47:55 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167A613E98
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:47:55 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so2817985pjl.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=H3IvboHf38i6HZkRkaNcEgr3K0OlHtdvqj+xHZNFWKk=;
        b=s8dRTkQll2ouCaDOt4qHPnV+g5FPoWRgRqeRidtDzh75los4/KvHRrAODd2C4Plgb+
         seaxS9R11G5kceo0LN4LVhfa8Cps2/68SF0wLs3V2ujH7/nYG3VRrllYmFIVTX3VDolZ
         9h6+E3mHk1PgApVDfLVBC3WhFUbYyMHg1D+wqxHZ1nCQE0HfRM4lj7CmUdHXbnI3Yaa5
         Y4RDA/KUigNwxWEajgDHE2BgN6uSsRdXLNAS9eU2qqBupws17QLELGPFlZZf9Z16HL+E
         xZETLAbCAFviIHpGzVf/5ruKgMgVJ/wUXNsDZCFMOkRqW87VsnoqR98xdCgybGtTcEkS
         YgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H3IvboHf38i6HZkRkaNcEgr3K0OlHtdvqj+xHZNFWKk=;
        b=43Qrwygtnw9TSfTxwxda2gXYGlMMB7zC/69YywTcpJDQFVoBkNHL5chUSMm+wvD/9X
         jQflInzdbZieW7zA4LvQRahmmwP2a7NiAefhs5SMEjUfyd+eKVZJTyb/Gy94pwDHcS93
         4YLCmfEA5o3F1RPzTeZzmfzrAVZiTZEfqTcDp/KFtvtB74a83HvpX6nh5Q6sgFIqBKXn
         HoZ8MQcik2CP0adBTmFO4n2GqvCkCjOl5LaKOMKAE2m4sl4fGd7NX8pUIcZatOLzeIRA
         zouBjBcnRZ2Pld9wwO5yWFl4UR3pzLIgKm3xSAJ52DHfjgmzIDt7GhQr/yh3RvbF6GqI
         4czQ==
X-Gm-Message-State: AJIora+w/lDEl2EHJmf5rpxlseYq6hVIwmIWvqPI49qVDvMTMUIXCmUf
        qGrUiBKGo1X/3eVeR/tZVexgcQ==
X-Google-Smtp-Source: AGRyM1tjNHe6Zd5hMRjZ6qbal0JT6KMhXb985PadpJU8U8gKDmMZcGJ8B3+eDI44F5vbng2gUEi5Lg==
X-Received: by 2002:a17:90b:20d4:b0:1e2:fadf:3f09 with SMTP id ju20-20020a17090b20d400b001e2fadf3f09mr6842838pjb.236.1655412474812;
        Thu, 16 Jun 2022 13:47:54 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id 203-20020a6218d4000000b0051ba0ee30cbsm2165453pfy.128.2022.06.16.13.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 13:47:54 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Antoine Tenart <atenart@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: alpine: adjust whitespace around '='
Date:   Thu, 16 Jun 2022 13:47:15 -0700
Message-Id: <165541242280.9040.2430009003607445561.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220526203810.831352-1-krzysztof.kozlowski@linaro.org>
References: <20220526203810.831352-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 May 2022 22:38:10 +0200, Krzysztof Kozlowski wrote:
> Fix whitespace coding style: use single space instead of tabs or
> multiple spaces around '=' sign in property assignment.  No functional
> changes (same DTB).
> 
> 

Applied, thanks!

[1/1] ARM: dts: alpine: adjust whitespace around '='
      https://git.kernel.org/krzk/linux/c/b3b0f459c2490e63106a86a3dfd3610d16184bfa

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
