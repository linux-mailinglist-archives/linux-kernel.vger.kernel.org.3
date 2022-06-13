Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB47C549D1A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245278AbiFMTNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347918AbiFMTK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:10:59 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667494504C;
        Mon, 13 Jun 2022 10:10:24 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id h1so5588639plf.11;
        Mon, 13 Jun 2022 10:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+E0qOXmIaYGrgKKOxyXbseCzmUGGWWVHHHzfQyyHi4o=;
        b=cDomZjTb89wINr+qLZAISKobOH9y0iLu8+lPSo9XbgOKJ4MVHIl/lT2dQIYkZlmIxA
         qg0OwroWZx/DdS2nJxJJVCBQc4hQ+2+KZquTYii+v6839OayuLQpiy3vJUP8glSexjz6
         uexyVKw7EV/IHN4IzeNyNWoUyH6WjsGUTpNEvmneKUwyKSupG7CMUzMKuoV5Ys4rjnOV
         3xQVteThlCIhBYviJNm54arhLENUBBWGlNVY7W2IarsddL63ULIXhr4EINrLh1l5g4+0
         PS/q5YVb6Ig049TMJZhQ/8HUF2ud36QwNhvpQGUOkTrrEEY2Z69Al1t4yXSsH00osTHy
         6ZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+E0qOXmIaYGrgKKOxyXbseCzmUGGWWVHHHzfQyyHi4o=;
        b=PkfxUl9+RPGkvwVfwKpcMqNHt7j3sCKGirzqXF0m2bHZr6yfp4EQtxWqGYCusb/lBR
         hzwZ8Fw7f4vEKD845ktL7r5Iy3PbpoIcmKemhzqk6mX/VkyOh3Pj5oGi19y0wpktwJSl
         /KALItoRrdKEXB44P4Wr3T3uRG1UmxXg9J3goosF476IsdVBbids+Gv3gsNmZ1HnLSAO
         ST20xvzxuISiQIZtYt5ljlilBdNsczanqp6u221tDMBBFGj2wNONBqPSdCxMERpMtxf1
         f8Qr8GC+01J3a401WW1EP/KfIyJdtmD2SMN6olr5OKNpB+vhiflaNW0jpefcz6OuIvh9
         NrWA==
X-Gm-Message-State: AOAM532a9DgAAaiyVVsJ9Eq2fMz7Q5HLPrRFY3Z9NhHScvsagRhoOSbp
        YXss+yL4OsGxSSoeaFU8WII=
X-Google-Smtp-Source: ABdhPJz7sM+c99Vg7g5GR9Dl0h78U9tsv/R55WGSbYCXMBmLzwbLN7k6LwX1UuFBpJxcmI3tqmZSLg==
X-Received: by 2002:a17:90b:4ac8:b0:1e3:4f6a:2d04 with SMTP id mh8-20020a17090b4ac800b001e34f6a2d04mr16988528pjb.233.1655140223871;
        Mon, 13 Jun 2022 10:10:23 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n7-20020a63b447000000b00401afc3401esm5650775pgu.35.2022.06.13.10.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 10:10:23 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     tomer.yacoby@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, kursad.oney@broadcom.com,
        philippe.reynes@softathome.com, joel.peshkin@broadcom.com,
        samyon.furman@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: arm: add BCM6855 SoC
Date:   Mon, 13 Jun 2022 10:10:21 -0700
Message-Id: <20220613171021.238548-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220607172646.32369-2-william.zhang@broadcom.com>
References: <20220607172646.32369-1-william.zhang@broadcom.com> <20220607172646.32369-2-william.zhang@broadcom.com>
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

On Tue,  7 Jun 2022 10:26:44 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Add BCM6855 SoC device tree description to bcmbca binding document.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
