Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A6A54A14E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351560AbiFMVYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352938AbiFMVYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:24:05 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D6422B38;
        Mon, 13 Jun 2022 14:11:21 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 3-20020a17090a174300b001e426a02ac5so9980392pjm.2;
        Mon, 13 Jun 2022 14:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rKlvQzY1N6oV6fS3jjhOgl0CZP8+wA2Hxxd5HHJVsxU=;
        b=ejobfMuzm2bhMmGi/kmrIz5vqGERa63OwdZYMjXrL46ooqXTC67Z1efwQ+fPtuzOsB
         kYGGuTXzXUFE/6saVvMtxnz7bYC9mJ19J676Uv8R8ZI5fVOt4q0RcH88OEm7fBJ8gTrd
         7icaexyTqc6jll8oEdUpyRH5P4miN2AhC8K9F8t2CXVqohBOW2bFIuLAto6H+Ik4SnOh
         qJ9W0YQHpzUyQmrcV5pWsp8v8sm203FSjjSEU+U5065yuhCgkGIY/erG8pXNvZg5zKKz
         3vc7D6KW0wu48WW6XT6gTmrVhTcI01fh5M7teVU7pd0R4T9mDPLeaQ5RkcXfVMYWflOL
         v5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rKlvQzY1N6oV6fS3jjhOgl0CZP8+wA2Hxxd5HHJVsxU=;
        b=5FUGKIOYQspdHS9oHLHs33eS1tnJHlm9MJuDxZNDxxbyJT8+LIpzscAi6slsfx6Z02
         mosznRtVa0jVTPMQPXFTtbvHPIcp+nBfrLRDDxoj4yntmOpfXcvJviv3s2SFz2LS+5pO
         LbAxtO67My2QXsnIza9VJ9jNdcCUEnz0HR2/vovgycl8+ZwgPty52FL5CxloQn0tIpzD
         g86k+etTIDtMlm2SNn86Wv8RRYFF8/ATrdbPyN8HjVJ1yWRnFHVpzudiapu7TcJ/VZEg
         9MiMLzX8/FO7AOHyf+z6MurVtAPHiGtDSrpZJgT7gNRgp+YYLnz/CEaLFYnT8Z/8hGhn
         e1oA==
X-Gm-Message-State: AJIora+1kH5LlwIxydA1/6sBN7/fljmB2kljUT+LaHDDANhhMzCfP70k
        9KuHR27z/bi/X8gIPiNBwWQ=
X-Google-Smtp-Source: AGRyM1tJtpkYyYsuZQlNlNk0OyUyERFtH2jh+t0jpemRVfcvkP1db1rF8KKR2vJo4Y69SxqJGJJSxg==
X-Received: by 2002:a17:902:900c:b0:168:dcbe:7c4a with SMTP id a12-20020a170902900c00b00168dcbe7c4amr1153165plp.165.1655154680891;
        Mon, 13 Jun 2022 14:11:20 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id m3-20020a17090a858300b001e307d66123sm5776023pjn.25.2022.06.13.14.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 14:11:20 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     samyon.furman@broadcom.com, tomer.yacoby@broadcom.com,
        philippe.reynes@softathome.com, joel.peshkin@broadcom.com,
        dan.beygelman@broadcom.com, kursad.oney@broadcom.com,
        anand.gore@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: arm64: Add BCM63146 SoC
Date:   Mon, 13 Jun 2022 14:11:18 -0700
Message-Id: <20220613211118.257694-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220608180100.31749-2-william.zhang@broadcom.com>
References: <20220608180100.31749-1-william.zhang@broadcom.com> <20220608180100.31749-2-william.zhang@broadcom.com>
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

On Wed,  8 Jun 2022 11:00:58 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Add BCM63146 SoC device tree description to bcmbca binding document.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
