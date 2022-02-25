Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DF24C44AE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbiBYMik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiBYMii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:38:38 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A8318C7A9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:38:05 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 739F03F1D9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 12:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645792684;
        bh=9eC16w0KRE+2yvJrpb1nSJBb3vk6hCAAmoSgEiZhoQs=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=bVAKmNCFQPrlzxaUrZE/yp7dl3KJnOkv3p1ufOS4L+d0oEft2gs8qDuYHn+rI/odm
         q6+8StBwX/Eq1NJ74W5d+GQ4UWLysnZMJmepVmKExvTLZj/LseM3+rSL1LlRWMZPPk
         YArept7AI8OhhC5tVIakP1nK7iYIkuwETz53wXatzyeGSvg0roFUeQE91F/BItPYcf
         amTgu3JK8GGooePiNX2K1ePAM2NU0xyc7ujR1J0pA2mDUesnhiOak87921IKQCGn3T
         V+e6SHlFIVoJ4RUB9ZpFdP2whyCacxaHjGKXRQ6/4OKSN7x0I88xDkm8ko57GpY+EA
         R396WGxsIhd+g==
Received: by mail-ed1-f69.google.com with SMTP id l24-20020a056402231800b00410f19a3103so2279251eda.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:38:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9eC16w0KRE+2yvJrpb1nSJBb3vk6hCAAmoSgEiZhoQs=;
        b=DqZ06QOPkIPTdSI+qQQDIzec7lhKaYUzWMy8enjzbXiedHw3wtsmTYhhWq69wDVIe4
         7YOo6PsE5ZBirIwpqEiD6NpEzi9r725hicW8bqyIvUZQjyQLCuvY837OoEpSS6htSjfb
         jV+COCRTQwWOtfjZn1a+RKpdm7mWX8F0H53OPRk0znm3hnLiBLQTRjKYo2BqEKE+5BR+
         8+kCAtf4DdlAoma3gGsNXVWpfH5p9ZEV/BMmB7/6T/ixsKYW3NQftKaUAfOa9/wJ0+bD
         iOxd7VtR52uYd9BrGXuFD5VKh2m0bNaNSp+YBqDwgYEzAKCZmTOQjZqTAT77UEwtIVyb
         AE8Q==
X-Gm-Message-State: AOAM531M0iMCKUbevDh5Rl9D1WQiisQqaM25tGumssTcR0s2mZSWMwKU
        GBOQCT67VvAOqirpA/RqG2FGtQULy/C0R7lFBaNd63QT8Y+fAhqNLY9+P3T20uTasB0blZCOL+v
        goye/dzoV7+k4fKW79IyBaCHpc1xmvTLynYWotXICuw==
X-Received: by 2002:a05:6402:5242:b0:40f:6a4f:ff33 with SMTP id t2-20020a056402524200b0040f6a4fff33mr7043599edd.30.1645792684181;
        Fri, 25 Feb 2022 04:38:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxmWM9zne9h4DES6Tv7ynAO/XZUfU2hSXW7BbeOG6cPsrvgRU72gLrcjZtXnDIhtiqtPgBpJg==
X-Received: by 2002:a05:6402:5242:b0:40f:6a4f:ff33 with SMTP id t2-20020a056402524200b0040f6a4fff33mr7043584edd.30.1645792684016;
        Fri, 25 Feb 2022 04:38:04 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id co19-20020a0564020c1300b00412879e4645sm1236911edb.55.2022.02.25.04.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 04:38:02 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Julius Werner <jwerner@chromium.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Update lpddr2 revision-id binding to match lpddr3
Date:   Fri, 25 Feb 2022 13:37:59 +0100
Message-Id: <164579264189.173354.7844029461278884866.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220224003421.3440124-1-jwerner@chromium.org>
References: <20220224003421.3440124-1-jwerner@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2022 16:34:18 -0800, Julius Werner wrote:
> This patch series updates the device tree binding for "jedec,lpddr2" to
> encode the revision ID (mode registers 6 and 7) in the same way as they
> were already done for the "jedec,lpddr3" binding, and deprecates the old
> way.
> 
> Julius Werner (3):
>   dt-bindings: memory: lpddr2: Adjust revision ID property to match
>     lpddr3
>   memory: Update of_memory lpddr2 revision-id binding
>   ARM: dts: Update jedec,lpddr2 revision-id binding
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: memory: lpddr2: Adjust revision ID property to match lpddr3
      commit: 80ce91730d3283f10810245db2605498d794fa29
[2/3] memory: Update of_memory lpddr2 revision-id binding
      commit: a06bf59d07f45a0a6ab4ab8ac69c1d708d3fadcb


Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
