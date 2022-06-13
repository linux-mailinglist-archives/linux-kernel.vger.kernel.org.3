Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF1B549DB8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350191AbiFMT37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351709AbiFMT3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:29:38 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62AE3DA4A;
        Mon, 13 Jun 2022 10:54:09 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id w13so3578342qts.6;
        Mon, 13 Jun 2022 10:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MQ6Gm6rEcKWgPoZvxj3NUFNwBirG2CnGEdL2DutlzIQ=;
        b=joXD2Wtj8NaDaXR+5hJSdoaWOTNyBxtsLmkoFylc/33cizkqdQKRxkzKf0UlQE15bI
         PRppazDhC0xj+Fe3DTGn8ewe8fG68LGzK+KBD2WymPPh/j3bnBzaIH+U+GGL66l/mYfl
         KfVassBVNwh6ezplUxVW5IONWCdB1nF3F3ol0d82gdC/VBSEL2ER7AVQcXgYZOnsvAw7
         rcsUcDX7vEmTBL/Q9Av1o/ma3mLnwZjiRxuueKeOw1xDCp0gN4VluDjxe4+sr7GazoXo
         Bkir+7pgIgzWMzLymH5/p1naiiJRcJZQWIjygscbj0eDMlS7WFd5EPbZQzvR1IDiY8Y7
         GnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MQ6Gm6rEcKWgPoZvxj3NUFNwBirG2CnGEdL2DutlzIQ=;
        b=sm4Clh/HYABiCRpFO0G3FXIvqyoaWyPKZ0tQiTGEP+7RuMf7jbBrgMXtPdsU9mkGHy
         1Qf8XKb0Vu84/JSczfG9dhj9795bXSuzjPzRhVDKb/4SSGICXyyKPEdyBdCSKwlibD0b
         XsRp5lBVgR1BxVJRs/Z8mAmsGttpoaRVhI6CxPczgRfgJlHShJh8VC0Q5AmNqVfd4AxE
         /cKDGkuIoJ7hIeR3mtJtFqpH21B1H1JkE/fZ5VFeEa9L2bl4lRE1xjUbh6yUr5unqBnZ
         HLf+h4FlrCKvw0vviFbV8i8csgTx9ahgM2COJq4smhCcdiVF0GXF1HEZ/A1l8S0EaO+U
         dZlQ==
X-Gm-Message-State: AOAM5321o9l4xNui3sna5xGLmAhAGhDPwWFAWw8zqJNMBLNys+aHV0A9
        7JsPK2F89Idn/w7oAIzB8ffvsOJP04I=
X-Google-Smtp-Source: ABdhPJx0sAHi+4PMHwNszPdJysQo5Oh8DBgyF1D4IUtP45fNmpWG58yU8cVLYzW6xN4NldgDgnPlkw==
X-Received: by 2002:a05:622a:287:b0:305:150:a73d with SMTP id z7-20020a05622a028700b003050150a73dmr834462qtw.570.1655142848901;
        Mon, 13 Jun 2022 10:54:08 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id o18-20020a05620a2a1200b006a370031c3esm7400298qkp.106.2022.06.13.10.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 10:54:08 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/48] ARM: dts: broadcom: align gpio-key node names with dtschema
Date:   Mon, 13 Jun 2022 10:54:05 -0700
Message-Id: <20220613175405.244712-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220609113938.380466-2-krzysztof.kozlowski@linaro.org>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org> <20220609113938.380466-2-krzysztof.kozlowski@linaro.org>
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

On Thu,  9 Jun 2022 13:39:30 +0200, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> The node names should be generic and DT schema expects certain pattern
> (e.g. with key/button/switch).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
