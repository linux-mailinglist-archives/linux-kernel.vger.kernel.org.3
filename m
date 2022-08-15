Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1340C59338C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbiHOQv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbiHOQvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:51:44 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112E315FF8;
        Mon, 15 Aug 2022 09:51:44 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id w18so950409qki.8;
        Mon, 15 Aug 2022 09:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=z9mz2+wlNE6dlfNxd0zn3pzsSl/tx6YmF8ngabpo1pQ=;
        b=kP0ekwtTUAra8jUuLiPKcJkLXBMllgqLgA34PhQPiLL3JtVzphw4kc87T8/V0vQ3pB
         P3WsKUCs4mVvAI4nezCdcazLAVK6jh3MFoDip7MYLpLP1GZrbeuAHSeaTAE+r5pqN1zX
         gemMQ5ZpDKCsy+nOND/trEcvWN+AoT28hT8qbNAEWebitvZJRSZ7N/TeSCV3AyIs4ZHQ
         zynpBsg4La+kHuHrAjQaJO1MpVl26SA+fGy7p1Wzk2t9K7M0TGNPqOlWsp5tg5Lctly4
         RNy/SnCPL8msiRKwxS4LBU/I+2CF05Y80cku/ydRVEQZb4GARTWxtt8nuMGl27+NwelW
         /2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=z9mz2+wlNE6dlfNxd0zn3pzsSl/tx6YmF8ngabpo1pQ=;
        b=jWHHL6pQUcOVtHiJG3+bQjBJYD+D7PrM6A1vIwRxnjvTZrkf8wRNfzt2pmCBaO2o+K
         MX+OJsxpFbJIJu5q9Hs8cIQCaaDULk2j9WXhBZ6znc9iJt6OwgE4IAsxaq6c8Pex56kZ
         v67y3mgqwomPct7xd9hfefc4AqMPWw184wVlhCBhCgCKrjdZLBY1CqSdCegRzgiSgYX0
         Qj7BRn3PRV0VeWLTa72XS35yOSLA+cl3VLzi4OSoCZP67mQQ9Ro2hk3zBpE2En88OsvC
         SmbZ1ss7Yubr6b6BH7JchYLSXjNwFwTUSDT0faK5D4xsFY4oA5gCwHBwZiJ1oaFuetXO
         E0Ig==
X-Gm-Message-State: ACgBeo1IWU2Ocoq0VuaM7PquAp9kZxFZ06jJrEyEObJ8RMjsWmsf1yt+
        t2hkWaCB2T7mliTAV72dGBQ=
X-Google-Smtp-Source: AA6agR6ZQxGkDO5pcRVX2aabSFEGDB5GrDg841Olcp3vUjlLJV0zreqAR3OcF3kXOrsn46euV829Bw==
X-Received: by 2002:a05:620a:c:b0:6bb:107c:36ea with SMTP id j12-20020a05620a000c00b006bb107c36eamr5802037qki.738.1660582303025;
        Mon, 15 Aug 2022 09:51:43 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h17-20020ac85e11000000b003430589dd34sm8780596qtx.57.2022.08.15.09.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 09:51:42 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        krzysztof.kozlowski@linaro.org, rafal@milecki.pl,
        Anand Gore <anand.gore@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/9] arm64: dts: Move BCM4908 dts to bcmbca folder
Date:   Mon, 15 Aug 2022 09:51:39 -0700
Message-Id: <20220815165139.2500877-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803175455.47638-5-william.zhang@broadcom.com>
References: <20220803175455.47638-1-william.zhang@broadcom.com> <20220803175455.47638-5-william.zhang@broadcom.com>
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

On Wed,  3 Aug 2022 10:54:50 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> As part of ARCH_BCM4908 to ARCH_BCMBCA migration, move the BCM4908 dts
> files to bcmbca folder and use CONFIG_ARCH_BCMBCA to build all the
> BCM4908 board dts. Delete bcm4908 folder and its makefile as well.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
