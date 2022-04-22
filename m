Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB4C50C36B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbiDVW0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbiDVW0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:26:14 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BEE2A9762
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 14:18:16 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x80so9121516pfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 14:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GJN7pqwSFWH2QRKzOW4bd6lA22LtPL1PTreBiKtpWvM=;
        b=VhBO642l/1fg+vm7aCCDs2IUAQZCJeVPVqrrgM+dFx5zwAC/8nbEvoWlswYLlt9TA/
         Qm5s9DP6neK2KnqF+Ync1o7C8RuzXWhTAoDSYO2y3C0St3lqDXnplakVPiXaCd/O87z5
         wcubYhhjpih5z9LkqjvT2kF1i/XIK1OZtNkS6hnFBZoWK/h8OMPHrZhujCsz5NGA780R
         Om2xubc0+WiORFsW374iDfUzzMrX1diLlYf1c0wx+Ta7qrBuf8qjLehHz1q7dQeP7DkX
         KBdV3lWh1Iosh8J3dKjUPaZc0ahTfdq/fcJopti9hmFuAxf1uCd+JTxx96C47tIprMJW
         7c9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GJN7pqwSFWH2QRKzOW4bd6lA22LtPL1PTreBiKtpWvM=;
        b=mtww9qzL1IefoOUjQJLnAnrI4DV0Up1ETsCczJo6BDjuC5Ejq1Qp2Sw9K//o7zmyc2
         6Ww6/TB5gaE/dNtZGDf0Fp7xvxFCH1pdujSbIWnF6SXASiCDstj70hbVOxn5Mwgg2tcj
         rwrso60H30hGrywUF4RsVgj1/mQYCy7Nz5ZQDkCUDPuYtilfkaFb7BTN/8ul/VUof9zW
         E4RZlxvNB9VZ44CBl0xscmHEbCDOQSFPevelHxHmdEpw3JUxrCyI6QUaje1pRYFyCj5S
         1K9HKEB8Mdxzeo+ukD38cYRsmxCXkCsiZJ3TAvuUf9swQoVy7BbyBUPi2u9vWie3VJx5
         DvZg==
X-Gm-Message-State: AOAM530qfl53ufRzHZ9ZPSzcMdgGWwoUzErGyaYCPykKMenvclOhcARi
        cT2t9Uw8nj4CMcMz3s4Oc1g=
X-Google-Smtp-Source: ABdhPJz4vCQn/hlgj0tNUaLnILIEbmyl5MxdtngCeyIdSq9CT/j/46Sf0x+1L8G5s/GH2Vu0yWcAwQ==
X-Received: by 2002:a63:c00e:0:b0:398:a2b7:be6 with SMTP id h14-20020a63c00e000000b00398a2b70be6mr5628214pgg.214.1650662296127;
        Fri, 22 Apr 2022 14:18:16 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id gd7-20020a17090b0fc700b001d0ec9c93fesm7154627pjb.12.2022.04.22.14.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:18:15 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Kursad Oney <kursad.oney@broadcom.com>,
        Joel Peshkin <joel.peshkin@broadcom.com>,
        Anand Gore <anand.gore@broadcom.com>,
        Dan Beygelman <dan.beygelman@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Russell King <linux@armlinux.org.uk>,
        Scott Branden <sbranden@broadcom.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] arm: bcmbca: add arch bcmbca machine entry
Date:   Fri, 22 Apr 2022 14:18:13 -0700
Message-Id: <20220422211813.2029604-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413192645.7067-3-william.zhang@broadcom.com>
References: <20220413192645.7067-1-william.zhang@broadcom.com> <20220413192645.7067-3-william.zhang@broadcom.com>
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

On Wed, 13 Apr 2022 12:26:42 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Update mach-bcm Kconfig to add ARCH_BCMBCA config and select the
> required configs for Broadcom Broadband SoC chipsets
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/soc/next, thanks!
--
Florian
