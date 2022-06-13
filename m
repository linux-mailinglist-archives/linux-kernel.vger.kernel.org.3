Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5280B54A19A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242079AbiFMVh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiFMVhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:37:55 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE751E8D;
        Mon, 13 Jun 2022 14:37:54 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 187so6866144pfu.9;
        Mon, 13 Jun 2022 14:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tJuz9yMuGGksOUvKub3tRebZ2Fw5veeK+Cx/3ADZPqs=;
        b=kFvWcygyYfM80BvamEw4h/McUWui9JJOBZZz8kW4dtikLbvtO9TEDqhQI4WDq1QfbU
         IHrWQ8Q+RB8mAXAL8zv5YUwk5laiEREqJykNfoXGwUwCEJ56phppC+u57ecyeiOQDV9C
         28/bZX1V8vFkULKzLpSDZztWUPuM7Svd4sLDb1TopHi1btQCnw4+i7pQ1Mf8rt4VCP6G
         AW7CONpS7jzvTZe/I6VY6VqPUmq06uoyF+THoFpjNmjkd3Ngkpru1qk4pbNEoARFNlDJ
         bj7L23XvbkwxJTShOIkIFV6LTLxToMJx/V9nw19siXQKE0IJC6QwIj25edQ8uJKClcfN
         gYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tJuz9yMuGGksOUvKub3tRebZ2Fw5veeK+Cx/3ADZPqs=;
        b=ZjRRZn/YgiTr+ioyIxWh+1TFJmPXdIsi886EykwynEP9/c8HRuJ9V2WKmjsmg06jtf
         Sc/cA9HGdbA4Ncsm0hsIgw+GMFw7ma4P6SJ4xnnU5iGVyV65+NZrBX8aHN2EpXGA81wC
         7T+ajQqJZv/fGYyh4EySzVCyTl7FRTwE4Tf4Up9qCCynUgQriLmavrJJkg7YAMHTXo9f
         HYk+SbIZ+DVtx3bCbIH+MXvHcmnLiMG+e4suY3fHDBvrm8wfIkpDcid4aUJ5u6SRJh6K
         zBctpOTSCoZTbr8k8s0GIwL1KU0F3ET+QPsLEtGEYXlO4rn9hHbrkDK43H0jrCEbszBJ
         2kIA==
X-Gm-Message-State: AJIora+zP848JN3TEHPBCYsNoXeCGwwBWxC4hmQhe7GmnrlMzEpWtGd/
        IxBoWzChvKBky8QiNAuGatA=
X-Google-Smtp-Source: AGRyM1u329hcXoRkwsNq9U84BJFUtAmhlF0l5uLrFTGxePBB02dK+vjoxQwha4ug/5vzUBrmFiqNgw==
X-Received: by 2002:a05:6a00:2809:b0:51b:f239:d24d with SMTP id bl9-20020a056a00280900b0051bf239d24dmr945096pfb.73.1655156274363;
        Mon, 13 Jun 2022 14:37:54 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p3-20020a1709028a8300b00168adae4eb2sm5574917plo.262.2022.06.13.14.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 14:37:53 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        samyon.furman@broadcom.com, philippe.reynes@softathome.com,
        tomer.yacoby@broadcom.com, kursad.oney@broadcom.com,
        anand.gore@broadcom.com, Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, soc@kernel.org
Subject: Re: [PATCH 2/3] ARM: dts: Add DTS files for bcmbca SoC BCM63148
Date:   Mon, 13 Jun 2022 14:37:52 -0700
Message-Id: <20220613213752.268314-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220610002113.14483-3-william.zhang@broadcom.com>
References: <20220610002113.14483-1-william.zhang@broadcom.com> <20220610002113.14483-3-william.zhang@broadcom.com>
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

On Thu,  9 Jun 2022 17:21:12 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Add DTS for ARMv7 based broadband SoC BCM63148. bcm63148.dtsi is the SoC
> description DTS header and bcm963148.dts is a simple DTS file for
> Broadcom BCM963148 Reference board that only enable the UART port.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
