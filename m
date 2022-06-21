Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06DD5533B1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 15:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351775AbiFUNhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 09:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351745AbiFUNge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 09:36:34 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15A42C653;
        Tue, 21 Jun 2022 06:35:23 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id w20so22379473lfa.11;
        Tue, 21 Jun 2022 06:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pdZHMaX5g8pSHRD00mVKf06kitbS5gJvV25hf8xmhcY=;
        b=KGdPBiADkqwDO4ovi6DPmn8ovwwpLdf559Qi1yyeLnI9/Y6NK7ikUSHZlcJOjVJ9Y4
         /PusDag0pBT/sNjF3UP5Qi2Bori9lo5Mp04jAtCg6r4hrdueDc8yL9DxRFszbLrRZOM4
         fu1tYDFLntWtwkI0n7pjFsTOkrnZmYQx7U/wNFXy5gmM36i8Qr7bjIdz+d67Ngr0FwjX
         TBu0ev8ryJIY1HWFrI6XBh3Cs2fZ9Qbt2ZGgkIdYZqe18qeLqBNZ48mihxOyoYzMfSRE
         R9Q+PBLOBDu1vTRwsj4t4/HOpq1Brk5usnVOjZhZhjUZ84jwQH1ETdr30TFkJh0UohMP
         rP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pdZHMaX5g8pSHRD00mVKf06kitbS5gJvV25hf8xmhcY=;
        b=ZLUcw5KRMTULX4DmeMRfjNfwb5ypp9enR2+UoN0LffXVoph2VOsSvQZBxQLGKNTXLA
         uK3ngVYpHBOPwV6fXiVEuMINoRuYJ+gVvBWzFDjlRxrxrOltzy877mX+8rnXOW5YdmJO
         kvUtRHLGxMcshVhtfktJdfYdq1q1ezmRIO4xB4txl6nGzoW/htAhkCCrXhuXRM2+sfTJ
         9EBcvt8iGdvsDAgQy0/qy6qS/ZRfV0zsdgJTq2rWEaxgdyZdZSXfDV2j/a3ehKaHCJVE
         ACY68wq9EbTl/cHSVcEVCEEZAfN9NY2mC+Ciii1gZu0qubSPLhx7lTi0bh/OxifJvOIv
         Up/g==
X-Gm-Message-State: AJIora9C9DDA0NwxJmY95zOwmtUKYx26LT9c34WieubN7QZcwAbOetZ2
        AsmFK5MyghdvInKD9Ylqx/Ti2FidY11WJ2j7
X-Google-Smtp-Source: AGRyM1vopnSAwZFPl55nQmKYmC1s2dCSyHZwZPrBjYQvxnkp9vIeFmAFt3gcVBU0zS2nPjXmygRWlA==
X-Received: by 2002:a19:f207:0:b0:47f:6890:60b0 with SMTP id q7-20020a19f207000000b0047f689060b0mr7500033lfh.327.1655818522123;
        Tue, 21 Jun 2022 06:35:22 -0700 (PDT)
Received: from sakura.myxoz.lan (2-248-181-228-no2390.tbcn.telia.com. [2.248.181.228])
        by smtp.gmail.com with ESMTPSA id a16-20020a19ca10000000b00478a8b7ab1csm347142lfg.150.2022.06.21.06.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 06:35:21 -0700 (PDT)
From:   Miko Larsson <mikoxyzzz@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Miko Larsson <mikoxyzzz@gmail.com>, linux-kbuild@vger.kernel.org,
        x86@kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sean Christopherson <seanjc@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Chris Down <chris@chrisdown.name>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Oleksandr Natalenko <oleksandr@redhat.com>
Subject: [PATCH 0/2] Kconfig: -O3 enablement 
Date:   Tue, 21 Jun 2022 15:35:24 +0200
Message-Id: <20220621133526.29662-1-mikoxyzzz@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Hi,

This very small series allows -O3 to be used for all architectures. The
first patch marks -O3 as experimental, with the reasoning being that it
might expose unwanted regressions to users, and the second patch
actually allows -O3 by removing the "depend on ARC" string.

The reasoning behind this series is to open up -O3 so that bugs related
to it (both compiler-related and kernel-related) can be discovered by
eyeballs wanting to improve the "-O3 experience," as that might be
beneficial to both compilers and the kernel. This has been attempted
before [1], but unfortunately nothing ever came of it.

[1] https://lore.kernel.org/lkml/20191211104619.114557-1-oleksandr@redhat.com/

Cc: linux-kbuild@vger.kernel.org
Cc: x86@kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sean Christopherson <seanjc@google.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Chris Down <chris@chrisdown.name>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Elliot Berman <quic_eberman@quicinc.com>
Cc: Oleksandr Natalenko <oleksandr@redhat.com>

Miko Larsson (2):
  Kconfig: Mark -O3 as experimental
  Kconfig: Allow -O3 for all architectures

 init/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.36.1

