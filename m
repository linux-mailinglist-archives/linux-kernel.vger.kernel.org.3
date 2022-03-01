Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3CB4C97C8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 22:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238213AbiCAVaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 16:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiCAVaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 16:30:14 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9BB7F6FA;
        Tue,  1 Mar 2022 13:29:33 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id cp23-20020a17090afb9700b001bbfe0fbe94so3389196pjb.3;
        Tue, 01 Mar 2022 13:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DGIwCRJ08COyw7PR1rsiNp32WL6MSW0ZZqWA6FpVwow=;
        b=ar0Fs4LovpkwmRH7wMMcKkiU9qubdM3wbK724HpGT0TYhxpkKaQ9Ezh4uEaSKL/T8c
         OMl/yAWSESYv4eMLqxPfdVGvU0QrihF4jWM8ITHxwy0QllCLJWY8KmdImGDHtGf+8PkR
         jSOE9kU8RvlpEvb7wsySFldURbexKbgNO7V23WlcspUYJyC7lHIjo1R7yLXPeHLxMvRP
         xkQ7VzCIf9tY+eXuo309VImD1zKNM7OFrHPzC/V7aDlmCKBtOfwwTxjeX7DmeIVefqTu
         l2034rt6zAnsuh3/EbUBeYUS5Aa61dS4kqGp0oy0BBarrAwckfvO6Whal7Igg6qmiK3X
         0wMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DGIwCRJ08COyw7PR1rsiNp32WL6MSW0ZZqWA6FpVwow=;
        b=8Ax47fSFK0yCFdVuypy4M/j+jxQMaslPTSPktjMY2RBcL+sD7R3DM0CsyTdfgcO6i4
         uz4Rn0YECYn1YMjd+wdc4j6CaX2R4hsZ5HRAzpZxsZBIg37oY+yVpAqTg31J/+zMZwCM
         HjQ4C4lWiSXLgTGyIIgUFDdrLEzp/8dIZSbMoH5hnD0NkLuex6PYIqJCulwG4cybVN8g
         wPyeoDgmtJoaLrvlBRhCABrqIRVui3Vo1IvWYtrTq88nP7G/pjcwtgbzUrLkE3pisTgT
         J0JFiXm8tgtM1LPADaQjgacVcxVY/tIQi84oD4pWPWjah3y0gUP0eWyj8vMZUdUvN0eT
         hQPQ==
X-Gm-Message-State: AOAM530meqKfCU5x9iQOMwnprskZzrxh/TgfS2++gR6o+fFFyxQAjEuY
        wHGjomW9uha8njBTAcbekbs=
X-Google-Smtp-Source: ABdhPJy0Q5dgrns/oIZkTNckMxvWJETNvP8GrishcqTCfiX+I3jtP+pr2rAYyQWHuH9xh1cox5pglA==
X-Received: by 2002:a17:902:7083:b0:14f:bb5c:bc0f with SMTP id z3-20020a170902708300b0014fbb5cbc0fmr27462796plk.77.1646170172570;
        Tue, 01 Mar 2022 13:29:32 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y191-20020a6264c8000000b004e1bf2f580csm17600136pfb.78.2022.03.01.13.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 13:29:31 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Frank Wunderlich <linux@fw-web.de>, devicetree@vger.kernel.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH v4 2/5] arm64: dts: broadcom: Fix sata nodename
Date:   Tue,  1 Mar 2022 13:29:29 -0800
Message-Id: <20220301212929.2017324-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220301152421.57281-3-linux@fw-web.de>
References: <20220301152421.57281-1-linux@fw-web.de> <20220301152421.57281-3-linux@fw-web.de>
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

On Tue,  1 Mar 2022 16:24:18 +0100, Frank Wunderlich <linux@fw-web.de> wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> After converting ahci-platform txt binding to yaml nodename is reported
> as not matching the standard:
> 
> arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dt.yaml:
> ahci@663f2000: $nodename:0: 'ahci@663f2000' does not match '^sata(@.*)?$'
> 
> Fix it to match binding.
> 
> Fixes: ac9aae00f0fc ("arm64: dts: Add SATA3 AHCI and SATA3 PHY DT nodes for NS2")
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!
--
Florian
