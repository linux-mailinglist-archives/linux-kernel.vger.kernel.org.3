Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE3E58A03B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239799AbiHDSHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239823AbiHDSHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:07:20 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D016BD7B;
        Thu,  4 Aug 2022 11:07:19 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id l5so405811qtv.4;
        Thu, 04 Aug 2022 11:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=+vQp3BtrygaK70boenAHrb8GYemOYqywOi5ReMT//m8=;
        b=irqwbDBouxZACuMIyoeOu1nr6jHu8Dany+G84g0C14kLdZcP3UqtC/+D5rDAaPRe6k
         v3/FHnx/whA096fc/rmX80ZMGHawN6DZ2GSjV2nQEd551QjToDyaj9KwVSdlsfFrVHJg
         SckynyUuVcGenm4gf8TLyuIUWMT/B8RPpK5IDblUuMUpsgTTpGFldgYWD7lVbtW5BUCG
         d1tpyn0LDJ3y20eHPlwzw8moKdhndo2jWpF/io1aLUX9C82KgZKoWbf/npR/y3LPY87h
         KsabM4t5hB0qIs0FUISRxmZhAIn5a0NVnqrtTrZwVsPsAWY5FkPpkKOzWdpWJm8rcvNZ
         D8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=+vQp3BtrygaK70boenAHrb8GYemOYqywOi5ReMT//m8=;
        b=sp2MnDVYf2tQSi4r99O+QYyrSaC1vreIDy5jHhMQx1bspQwsJnidEBlfKrQKKZkd4y
         MuynSJbcQnfa0eFreSm5PW1cE/IfHx2zuJr7dtbUEKbElxAc6GrSFVaqMBPiM2UfhUn0
         NOWADSQZJ/PCrF/I61w5mjBtqX0e+9skPOt49S2FWFg3/3baK5I/+rHkDuGXZt7a90ld
         G6bbwxPJiqebENWDdj7nz0L0KOMRZdT64r576OJgN1RFTzdE/lMHeakZ6OSRHTeFdk2O
         SBethfQjygzFTwCzw1mT9TfRDmxz+h3dorxY/fq2PmNEXjpnfkVQmJaXM9p5wX3V6Toz
         QnJQ==
X-Gm-Message-State: ACgBeo1knAJfbCxVVfeKWaacUDU5p4S7HOPm8OwDR7J+vV1azBOJWitB
        xfFsJCZLso5zntYnJ/SOiQDpXrADCa4=
X-Google-Smtp-Source: AA6agR44Ps97I27zTFX8JstqFCOMVunEQOSEbPliCu99AkV0zSoFJ3qNVrBqMIth2M0VyoaLHzZs6w==
X-Received: by 2002:ac8:58d1:0:b0:31f:70c:aee7 with SMTP id u17-20020ac858d1000000b0031f070caee7mr2638653qta.367.1659636438099;
        Thu, 04 Aug 2022 11:07:18 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 71-20020a37054a000000b006b53fe19c41sm1072381qkf.14.2022.08.04.11.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 11:07:16 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     kursad.oney@broadcom.com, dan.beygelman@broadcom.com,
        anand.gore@broadcom.com, joel.peshkin@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ARM: dts: bcmbca: bcm6846: fix interrupt controller node
Date:   Thu,  4 Aug 2022 11:07:14 -0700
Message-Id: <20220804180714.1339563-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220801194647.29437-3-william.zhang@broadcom.com>
References: <20220801194647.29437-1-william.zhang@broadcom.com> <20220801194647.29437-3-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Aug 2022 12:46:47 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Add the missing gic registers and interrupts property to the gic node.
> 
> Fixes: de1a99ac0b64 ("ARM: dts: Add DTS files for bcmbca SoC BCM6846")
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> 
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/fixes, thanks!
--
Florian
