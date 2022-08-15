Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F77593385
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiHOQus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiHOQu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:50:28 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A203F60C6;
        Mon, 15 Aug 2022 09:50:27 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id s11so5870315qtx.6;
        Mon, 15 Aug 2022 09:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=872ysycXiBBBtnAOZC3AeLP8Fp8sH0X3DkOilTdN2P0=;
        b=b+KyyUVncaYLfusxP2awoCphMv2gDjV+ajQvCZG0lU/wtbW5imU3SQVkbF1V1b82Zw
         oDw7Kb7G0UzdmFXtl3pNPOIcfF6+rWpF87L+hsW1tUTC2iDMk8jCRV/zF6OxsFKJcq6L
         /LS2tEm6bca2vXVIW9vB8kwjQIdH6G2tYSxWs52DGYUaBrhJf5VVva64/Mlb2cYf+iQ4
         LF108C3sx/y928SrG3kTgyT9YyMMI+UKhm9i5+IndsUCbp+asjJ+aWFb/qVzqCVr4EPO
         QjrLfRcAA8qEKEFjL8LHl9Kq4pSCbN/ymrvy+6zk2Pb3yL2BohiBc+m6VJq7O1L4D7pa
         CPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=872ysycXiBBBtnAOZC3AeLP8Fp8sH0X3DkOilTdN2P0=;
        b=kTumOQJcIPGeaCFJCgy32qtDDUSKN0EdWwPfJFToF7TASy29yfMY4C1LM5QXEc0E8U
         1kHj0yHDlzkBnx2Bfi4KYoQDL2b9SnuU2zuKm7xITqqMBAEi9CfsAcQIJCKJaq6hKbl1
         lKBWhUXgvktKRVVaMlXsKOW9e7dKKVjGIJhUDanwEOGRQ1S0YuZ98FbxVnButRFugINg
         aF8QMkAdDJ3dhoxMQDrOm4hErZdXOKL2qaoOOwgmy68+Ajo8HB1a+HTEFU5msFY4e4Cy
         YnVcySwciAd1uIm5ZEeIR+YFBNIerRFwlTDZJgDEjemBLA81pt9xZW65q0UAHj+XQ1sv
         nPeA==
X-Gm-Message-State: ACgBeo3XRI85xbPViixejOSpBJuKn0Fi/528lnxM5X2zpx1uIodoKAfX
        xSXCPr9Innzn/b+i6fn1hQ0paElRiCA=
X-Google-Smtp-Source: AA6agR6ec3SPzBCkvGW3qCJqaUBoRsH0Sc5QERgJg6SNVYVuLo4yHZspWn04tjjvs04P7cQoioZ6ig==
X-Received: by 2002:ac8:7f0e:0:b0:31f:402f:1b89 with SMTP id f14-20020ac87f0e000000b0031f402f1b89mr15052379qtk.590.1660582226763;
        Mon, 15 Aug 2022 09:50:26 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l1-20020a05620a28c100b006b958c34bf1sm50759qkp.10.2022.08.15.09.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 09:50:25 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        krzysztof.kozlowski@linaro.org, rafal@milecki.pl,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/9] arm64: dts: bcmbca: update BCM4908 board dts files
Date:   Mon, 15 Aug 2022 09:50:23 -0700
Message-Id: <20220815165023.2500696-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803175455.47638-4-william.zhang@broadcom.com>
References: <20220803175455.47638-1-william.zhang@broadcom.com> <20220803175455.47638-4-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Wed,  3 Aug 2022 10:54:49 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Append "brcm,bcmbca" to compatible strings based on the new bcmbca
> binding rule for BCM4908 family based boards.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Acked-by: Rafał Miłecki <rafal@milecki.pl>
> 
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
