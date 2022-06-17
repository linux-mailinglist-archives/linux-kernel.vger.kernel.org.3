Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F8454F757
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 14:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381937AbiFQMRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 08:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380126AbiFQMRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 08:17:08 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC7A3AA5F;
        Fri, 17 Jun 2022 05:17:07 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ej4so1991674edb.7;
        Fri, 17 Jun 2022 05:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nPItxiChc7ysnYILfXxzAEU8Pmf3UY2MwXEKt7e1ms0=;
        b=XQwZw5oiz6COgZEY10idLilDKnr8vfdSlTtJdrgz0z9ND1xkyXsod5lUJtQWtBpT7A
         kNLnW0SR9uovJskHM3YuG3W8InkRLl1L7f7hQStp9CiZ2ut8ZwfjhTGt4XmqvWv20X7n
         ofc0PczxBTD9zWlly0fUXFxQ3xXdN3k6JEi7FvnfDrUnfE+l4i+wtBK/WFsX0fJ6R9Z2
         Li/2Y8iuvQItAwULhPY4Zq4eKZfLmUep3jbog0QGpcBmfMkbZOH/OqjIUQ/uJkTueSiI
         +SFF1yI7TQIK9ZV6u5B//Zy6kpdyLMkOb0y4t24Rw9Q5rErzXM1UEEVpP2M074Mhrtbi
         9k/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nPItxiChc7ysnYILfXxzAEU8Pmf3UY2MwXEKt7e1ms0=;
        b=n2Re0kV2YocUASFhzO1gzs6OP3UrRmLTfnB4OEd2HHDHIm3k96w5HUqiY8JeGVkUGY
         miAMzZ/2AB0noO2OOdKe82aDfTkJz6thIVsH9OyEinFrqNcSMqnF6hdilZjVhg25rXGN
         lYQRTgyWntoRj+u9YAoFn2xoF3CPy44lvuAo7yRNqklCXG1UsZvdAHiJDd1p3+XJuKPV
         /uHxNl8BiuhHec7lu9vFTspk0hSrO6LQXxYPmXOBZcsYjSVdQBRmhBgjVNFO+AX1QGlS
         qrQYLP+DlTUoSKJgECDp/907An7p5YJYfHiSpjYJ/qdCIvCYEeZvG+tIff1QFQvdMfYI
         pefQ==
X-Gm-Message-State: AJIora/B1foMv/VwtBVVyy6w5phzA50JurCwh9wwKhrycQZgHa8ABK5r
        9NQdNlbUucAPsBu1OL12Rrc=
X-Google-Smtp-Source: AGRyM1uN2AslgOs2dopM2SjLxLqgoT2BmNIf4gs23Bvq9kLeJ3kg9kpPrg12q8uREWKdMvlYZiwUuA==
X-Received: by 2002:a05:6402:438a:b0:42e:985:4944 with SMTP id o10-20020a056402438a00b0042e09854944mr12028262edc.283.1655468225808;
        Fri, 17 Jun 2022 05:17:05 -0700 (PDT)
Received: from localhost (92.40.168.190.threembb.co.uk. [92.40.168.190])
        by smtp.gmail.com with ESMTPSA id la5-20020a170907780500b006f3ef214de7sm2125562ejc.77.2022.06.17.05.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 05:17:05 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     tsbogend@alpha.franken.de
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        paul@crapouillou.net, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] Fix missing TCU clock for X1000/X1830 SoCs
Date:   Fri, 17 Jun 2022 13:18:04 +0100
Message-Id: <20220617121805.738157-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a resend of one patch from v5 since it seems to have fallen off
the radar. I'd like to get it merged in 5.19 to complete the fix for the
bug mentioned in commit e98839fb56ea ("clk: ingenic-tcu: Fix missing TCU
clock for X1000 SoCs") which was patch 2/2.

Thanks and best regards,
Aidan

v6: drop patch 2/2 which was already merged upstream
v5: fix use of uninitialized variable reported by kernel test robot & Dan Carpenter
v4: resend of v3 with some minor changes
v3: https://lore.kernel.org/linux-mips/20220224150326.525707-1-aidanmacdonald.0x0@gmail.com/

Aidan MacDonald (1):
  mips: dts: ingenic: Add TCU clock to x1000/x1830 tcu device node

 arch/mips/boot/dts/ingenic/x1000.dtsi | 5 +++--
 arch/mips/boot/dts/ingenic/x1830.dtsi | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.35.1

