Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3BD593383
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiHOQuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiHOQuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:50:01 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568E617057;
        Mon, 15 Aug 2022 09:50:00 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id y4so4810889qvr.7;
        Mon, 15 Aug 2022 09:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=qbpycFOA5ZxE6UqoCtnEc/uhTmSfLD+U+JZcoccbpng=;
        b=BhzcvjNk6HSrWIlnhuMS5kUZLpdDD+4BVE35VpdcjNy3ePVUOY38kSzaCK7XsPgmMP
         6q0BPTeDbraRqP8BClBT1/cfHQJymKq5uKZQk2rJMh/FHj4lHC6nK346g2SxI0gxr68T
         c8RtPldLg5SM8Q2QAesBn40N68x/IBYPzVD6pkkVAkxfFu54nEPVCRnWC3YrdbVbT0tH
         glbm0UeRqKAK5ynPe7eRGpH6OI2PZVUpTkiSzP5YzzcfREAlJV5AIqpG2pjxidrDh2gf
         XYh3ozyIeyv+EZpFRuTGYoMY10xaEx+hoOf0cvP8SilIUituUhRQG9PWsi9gL7US+aNv
         W9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=qbpycFOA5ZxE6UqoCtnEc/uhTmSfLD+U+JZcoccbpng=;
        b=DicD2z1NpUBUdYiA/ccH+gJ//pFAH4sCj/7SMX4VlIUZ3p3sLHLZUGtKQ72eSlxvQ4
         xR6yc7M7Lip/hFB/pFDu4KasaDZciUCljEMYw+E5vxoovCS3rY361DAmNfyl48Xn4f2l
         lvWJDvoWi7shWZ7AozN62a7X5WaPyRzN/76ZkIVbg86U0tGTjj5qlbnRXkrIZILx4Yp7
         X784NpEo9vKfcjvRbxJmCxwrkzOyvu2m1Ta6ptsL+HxQ41O+4rfYbt6tYRlpUUyUfcC+
         Y2FdRZwtgTwShgD1ME8T3FzAx6QVkELV/rlZg7YIOtRUheHDPOJEhDjaC09TwvOoj+Ki
         swRA==
X-Gm-Message-State: ACgBeo3IJI2dk6t0bXoWVxZnRBjf3Ina06ti+VNpzRUJblYrvlBm97qI
        RanP8uTg+wfv1v9DSgvnLXw=
X-Google-Smtp-Source: AA6agR7oY0Gaz+s7T8d1flEplPjqkgBRWVgsUTCcDUdiyXnIBqfetQSJ9/8OAhN7Z0u7HJAtzP6zng==
X-Received: by 2002:a05:6214:2a82:b0:476:ae61:e61d with SMTP id jr2-20020a0562142a8200b00476ae61e61dmr14526897qvb.72.1660582199406;
        Mon, 15 Aug 2022 09:49:59 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e11-20020ac845cb000000b0031f36cd1958sm8417359qto.81.2022.08.15.09.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 09:49:58 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        krzysztof.kozlowski@linaro.org, rafal@milecki.pl,
        Rob Herring <robh@kernel.org>,
        Anand Gore <anand.gore@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/9] dt-bindings: arm64: bcmbca: Update BCM4908 description
Date:   Mon, 15 Aug 2022 09:49:55 -0700
Message-Id: <20220815164955.2500568-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803175455.47638-3-william.zhang@broadcom.com>
References: <20220803175455.47638-1-william.zhang@broadcom.com> <20220803175455.47638-3-william.zhang@broadcom.com>
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

On Wed,  3 Aug 2022 10:54:48 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Append "brcm,bcmbca" to BCM4908 chip family compatible strings to
> follow the convention of BCMBCA chip and help identifying chip family.
> 
> Also add a bare bone generic 4908 board compatbile string to support any
> 4908 based board. This is useful for board bring-up test and kernel test
> with CPU and memory related change.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Acked-by: Rafał Miłecki <rafal@milecki.pl>
> Acked-by: Rob Herring <robh@kernel.org>
> 
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
