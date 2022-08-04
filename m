Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E83958A02C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238559AbiHDSFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239661AbiHDSFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:05:35 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8291B11809;
        Thu,  4 Aug 2022 11:05:34 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id m7so177304qkk.6;
        Thu, 04 Aug 2022 11:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=y7GHYHDTz7l37bBfrS3qC04MROO33/NUwdBDx0ZvXU8=;
        b=mIpR9X3geDgmpo3XGhs8yCUc5LGJqlMQRONwoC/cKce3P+3hcUW0TZ37SpNlKikz3c
         XisFL8+Hs0vVIzk5SXauiL1uXQcyj/AgNDYY26xQzBXOgUcrOVZ9kAKGBXISdcPcUPjp
         1cE+AIhuzAbFCnRyctkZxVgbTvWbKqmbZKVuuha2rdcXDkgXypnY9qGX9E12JCObrzwn
         6H3QePoAbLmG+FRju0cBiDouTAD7acu+fXfE/a1viA03/vFSwwn7+SLzZHHg5Pab23qE
         JtPhB9VZ2q5tBYwRiJ1tW6WgQl5oC5FImv9bUHbF48mVnMeXk17Bmx9x84DQUMVBASqd
         NfzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=y7GHYHDTz7l37bBfrS3qC04MROO33/NUwdBDx0ZvXU8=;
        b=HUh4Pd33LJW4jYIGw5Zz1+Y0SnKqzRtkR9r8NUUOnIh6cxZqhQ8rcSUyfViFo2ehuC
         le0HBFd2AZHe+bKfJ2yEhRAlhPSMZbICA8rUdRK3COU+5YKJjNVT6ivI7mXfO2ukrbdH
         /OCKUn89zVRaSL66YWonmLjtQS11/EatykMyqGv/HutAgJ6desdDhD6X6k2/u0uj++J1
         FICU99y+M20UDOa96p/EHwuy3KI4BWGVxxIgzQYVrkVPffH9uTtwqDM7q+58NRslidVj
         ymVCiqHUH6cyvgfB8b86SQlUppcQL8PeTuV/E4iAEchqTOK0gzLbLAc4rOhi3nsAuC+J
         o1dA==
X-Gm-Message-State: ACgBeo2LAX0PZ7jYVdWxlnO66tFNhTbT22uWMp6cFQHzXOl+5np8RUa1
        TruSPmFKoTdXPdUezSem4Z4=
X-Google-Smtp-Source: AA6agR6+k1CqeAtlKIoEMcblNgdSY1XncWgDSuo+6DMVZ8HycRX5FH//Vfs5+8egv8FrH2DwV2WTWw==
X-Received: by 2002:a05:620a:c01:b0:6b6:1aaf:bade with SMTP id l1-20020a05620a0c0100b006b61aafbademr2312795qki.524.1659636333584;
        Thu, 04 Aug 2022 11:05:33 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id o14-20020ac8428e000000b0031ece8b6666sm1106040qtl.43.2022.08.04.11.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 11:05:32 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        joel.peshkin@broadcom.com, kursad.oney@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] ARM: dts: bcmbca: bcm63178: clean up psci node
Date:   Thu,  4 Aug 2022 11:05:30 -0700
Message-Id: <20220804180530.1338924-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220801194448.29363-2-william.zhang@broadcom.com>
References: <20220801194448.29363-1-william.zhang@broadcom.com> <20220801194448.29363-2-william.zhang@broadcom.com>
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

On Mon,  1 Aug 2022 12:44:46 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Remove unnecessary cpu_on and cpu_off properties from psci
> node as they are only needed for psci version prior to 0.2.
> 
> Fixes: fc85b7e64acb ("ARM: dts: add dts files for bcmbca soc 63178")
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/fixes, thanks!
--
Florian
