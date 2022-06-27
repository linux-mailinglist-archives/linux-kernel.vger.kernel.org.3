Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E97055C4F7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbiF0JQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbiF0JQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:16:13 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78BF2BC6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:16:12 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id eo8so12106790edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8AGcZ+2eVzx8CQxwRFiOnjpZff3Qrmt80tq4f3m10qA=;
        b=EY/FsAZ9MUqu2tmQKlrqeL3MQtb2qow9UjGy1oQFy8Ta6/pKLVDbLWlmTHHd95AjkL
         Cdg0ah3rIYh43TJ+gAD77PcoH5lx2rltLT3rN30TRcIoCwz+HRC6Oj0lhGTjm1sfJjw7
         ffjJjtHr5+1Cv3JduMVi5Zxy7Mp+Q4j1d/iA3btcPuJ5oKsfTtOEcFof2aUXP5DxCYGs
         hRcbf//f1v7Lsr0U3tSL0qtLmsBesAVhhY2Gog4mOVs3HLRYYSbYs/cH1uIbhklNnMIn
         WmT8AMjh+D/HIsCDlexjRJTBEGYFl1ZEB3YAOoRxbO2LT8v62XF7+p2mSMyYb3C0aHd0
         +Alw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8AGcZ+2eVzx8CQxwRFiOnjpZff3Qrmt80tq4f3m10qA=;
        b=MPKmBauMTzGSPblEXMmFtf0igtyd6OtGYYmhoUerltcAj/RFxsGo86U4ylpGifUW6G
         DR2USFjRQPQxNUPVkSFKUCxEygqVKAPVCVPjzKDtp7ENcU/UwHAKvpUY3xQC6aebp4JL
         zX/tWPNDPVFn3ojn1P5gZdy/7dSRdd+T5n/oTm+8zICCbhgFjUCGTV6hCmiHSVi7JtFK
         fkANv5S9eWlG9KE4WxSHHh84ArqNjtEceMCGR/egM/+THC3unTBXx9al+kes9lO8XMt0
         2BCG62yu0uJlHi4bEaBWEhf8rUvmJ0oOZj/IZjKzac0OtgqaqCzelbI/qmtwUj+gPlU8
         qD+A==
X-Gm-Message-State: AJIora/uKrFzAM3V+3VfK4jas836JBIuC4u6RE2R+nkZORYSCMUF49Be
        HXHUS/E+gQtboXiFc2pvvhZdRw==
X-Google-Smtp-Source: AGRyM1vwOzRQhpL/5CfLml8f3UY+LuxdyTcYTCwppkE/+TVpqVtwXJLrxAGV0NEPNB+mvswe6ACKJA==
X-Received: by 2002:a05:6402:1941:b0:435:5972:7811 with SMTP id f1-20020a056402194100b0043559727811mr15053978edz.234.1656321372321;
        Mon, 27 Jun 2022 02:16:12 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gy10-20020a170906f24a00b006f3ef214e2csm4805395ejb.146.2022.06.27.02.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 02:16:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     gregory.clement@bootlin.com, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, andrew@lunn.ch,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Arnd Bergmann <arnd@arndb.de>,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        arm@kernel.org, sebastian.hesselbarth@gmail.com,
        robh+dt@kernel.org, olof@lixom.net
Subject: Re: (subset) [PATCH v3 11/40] arm64: dts: marvell: align gpio-key node names with dtschema
Date:   Mon, 27 Jun 2022 11:15:47 +0200
Message-Id: <165632135505.81841.15489151456935534847.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616005333.18491-11-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org> <20220616005333.18491-11-krzysztof.kozlowski@linaro.org>
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

On Wed, 15 Jun 2022 17:53:04 -0700, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects certain pattern
> (e.g. with key/button/switch).
> 
> 

Applied, thanks!

[11/40] arm64: dts: marvell: align gpio-key node names with dtschema
        https://git.kernel.org/krzk/linux/c/ebb8ba54950a1c6382647e573ab597e2b7b4af1b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
