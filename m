Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DFF56C3CA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238512AbiGHVJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 17:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240053AbiGHVJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 17:09:25 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865087B348;
        Fri,  8 Jul 2022 14:09:24 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id o12so99681pfp.5;
        Fri, 08 Jul 2022 14:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9E/mZeimCA88giN6rs5vLbSeCJTF3k6+VjGGAIWcV/k=;
        b=H7vyoKXshYAaDuCXHzumSvPd0vSlH3129MGT4JypuLk4D5nZpLuwDSs36U3poOsiD2
         FU1NArC2BbIOa7agQMBZKUsReCbibYPtmKapbY+OoejaSXc9MXV6VnFijbRa8gOamfLn
         gt7A4XeD/X1Ktt0QSUc17tlRDoAFXx4TqOH1AKrkN2cRva4LRzRvIaw76QrYClPcrztf
         pz8whfX8uueDz7mez0k7DRv/YskMPQ4+eGsMx79REZhGKoUn60cvLaeyWYsnIxP0kaye
         VKtZ0d8ebrpBN6zew6qv0W8TNvu7vpY4E1DO0z+WKVQWscYVUN+y1RCDiji9w0pZvC4v
         n+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9E/mZeimCA88giN6rs5vLbSeCJTF3k6+VjGGAIWcV/k=;
        b=rl5eUSDhmQYSot4BGMYTsXpLVGwVHQF15Ob+PqUOD1nUESqPKpAgXOWhI5UQr9DCOh
         EvAwlX1TWMJnmdDO1C0yCvk1qnnLRw8ETeHq0adkuFbxdU9iVkjC/L7eBTkHSvmy8n/B
         wxZ+vPECU+QvZi/ZutPxXJVdJUDGBuQvkm4VStE0zvi+JbuqXwoXXU4nZbOXEbli8t5x
         T5nI9jaQUqC6M8g9LXYoH+4eBWp+gMfBfQZZ+AqegkuB8HFJa+fWFzjRvR5x9HPeu8fb
         49khswZ8iCuJlx0Ct6jjFzT+4bUp65QpsnwFWuBAO3XBGDKFrC8JEOEPzEizgLCFtF/0
         CT6Q==
X-Gm-Message-State: AJIora9twr7R+1sRxqw1FwrAQGBsi9O6pouPTWFJVlRdX1mHF7yKKVQm
        BpIw7eedV5+cOgOh1VAhREI=
X-Google-Smtp-Source: AGRyM1ugzG/hWta6GrNXvx8TwkDWRE+33xf7z7yDD3ABzTqFoJGGI3w37eb8VXs8f7UPN2v+VqSsyQ==
X-Received: by 2002:a63:d711:0:b0:415:c581:2aff with SMTP id d17-20020a63d711000000b00415c5812affmr1902658pgg.278.1657314563948;
        Fri, 08 Jul 2022 14:09:23 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id q4-20020a17090311c400b0016bfaee8244sm7402307plh.14.2022.07.08.14.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 14:09:23 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 2/8] ata: ahci_brcm: bcmbca: Replace ARCH_BCM_63XX with ARCH_BCMBCA
Date:   Fri,  8 Jul 2022 14:09:21 -0700
Message-Id: <20220708210921.2660714-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707065800.261269-2-william.zhang@broadcom.com>
References: <20220707065800.261269-1-william.zhang@broadcom.com> <20220707065800.261269-2-william.zhang@broadcom.com>
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

On Wed,  6 Jul 2022 23:57:53 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Prepare for the BCM63138 ARCH_BCM_63XX migration to ARCH_BCMBCA. Make
> AHCI_BRCM depending on ARCH_BCMBCA.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/drivers/next, thanks!
--
Florian
