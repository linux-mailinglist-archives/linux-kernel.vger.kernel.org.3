Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6024B56D2E6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 04:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiGKCLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 22:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiGKCLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 22:11:48 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DBA18356;
        Sun, 10 Jul 2022 19:11:47 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id v7so1569174pfb.0;
        Sun, 10 Jul 2022 19:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fg/qHRNXMxe+gT3ycrSYdh4h9WIANO2zwYVb05Tuhzo=;
        b=lm++BYNr9rzPF5mZkjS61x35IUNX3RVIjwpniPWD5fDy4FKgi2QS1TUHJzax+vLe56
         znJcYBwaM4KZujOVWHwhBLzd/zsmUAzOiY3aKp34loOyoMVRlKwgK77a/4+3ieIKGfIS
         vu01IoXe+6lIzYXW0EW0g+igLJStKuHXb+/A7DnU9fk+zOltWZX9asNXIv4UTqZ60s7v
         9sPQ6XzKydOUTFfRrvJMeMlFbHjPggUNriT+GChhjX4/FiHiKqfCd15haiJM0BcqUur1
         MQ1/Ue6Ne52UBH83hfiSQLgBcSoRSFnd0EuooOwPgoHNRlDoaDk1OMHT1Ed/lcxv5xNX
         ritA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fg/qHRNXMxe+gT3ycrSYdh4h9WIANO2zwYVb05Tuhzo=;
        b=pkoQFSooFyhfWLpDMvF8NE6Tdywf/CsgC+NYzebsKgd93G80x/pBIVlaj/bgS2Xioa
         9MGxS+mfECW7CIG2JLlDmAvJwsekolZwFmXHx4yAIPzsuRU1E8ET0hxPtyXOww6qoUDx
         2Da1THyt+BZQ8ietAeKEw+RIg/KNCgAJcEFobD/mH6D8QAx9ECEHLUcK2Jkrr8ljTSh+
         5S+cDyeu8D5hJscSnJPVirf2d4rO1Brb0F6ZI5durRQ1v7rWN4mWb7XbxXQQvdmjeJ16
         VLNZh6aCd+I8GmHDTLRiPOuGJI7zdInGhn7cgMClo9V46cmUXo+itlcuKYlP+7zOb0YT
         5QVA==
X-Gm-Message-State: AJIora8KVVDnqmUP+WC4xBdgWrPCrxoMQ0Ndo98KQU7MmP8R7p+hY1lk
        G4FpKkLxP3Z6cL1KvquZe3SFRrDFwgg=
X-Google-Smtp-Source: AGRyM1ucsikHjeV4WP/+TNKBvcVRmH3rEJfxMAjcaAe49ZC+CqSf8tJc1ACUvrpEhod8pPXShIyotg==
X-Received: by 2002:a63:c056:0:b0:411:b3d3:ae4c with SMTP id z22-20020a63c056000000b00411b3d3ae4cmr13792289pgi.102.1657505506976;
        Sun, 10 Jul 2022 19:11:46 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p1-20020a17090a348100b001ef7bcb7e61sm5647636pjb.47.2022.07.10.19.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 19:11:46 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [RESEND PATCH 8/8] tty: serial: bcm63xx: bcmbca: Replace ARCH_BCM_63XX with ARCH_BCMBCA
Date:   Sun, 10 Jul 2022 19:11:44 -0700
Message-Id: <20220711021144.3289992-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707065800.261269-8-william.zhang@broadcom.com>
References: <20220707065800.261269-1-william.zhang@broadcom.com> <20220707065800.261269-8-william.zhang@broadcom.com>
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

On Wed,  6 Jul 2022 23:57:59 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Prepare for the BCM63138 ARCH_BCM_63XX migration to ARCH_BCMBCA. Make
> SERIAL_BCM63XX depending on ARCH_BCMBCA.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> 
> ---

Applied to https://github.com/Broadcom/stblinux/commits/drivers/next, thanks!
--
Florian
