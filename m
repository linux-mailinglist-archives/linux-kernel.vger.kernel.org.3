Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2124C3A76
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 01:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236102AbiBYArc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 19:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiBYArb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 19:47:31 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD5AB0D3E;
        Thu, 24 Feb 2022 16:47:00 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id m22so3472175pja.0;
        Thu, 24 Feb 2022 16:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F/A/cGaE9iJpO7MzsZwsfVpgVALQOLZDXv2Hta+qdjU=;
        b=CHQ3Pk/LkDlUBOs/imc1IqGIy9zfoRTtz3s2NbMWMAirnb+Af3fhbjzcJRzu6tkdDq
         YDC+e6toDyhrr3nsPnMaaF2uxuvD3kqAqLDX32rBLKc84mGa1NG/GV3QpIOfFT4TSJdH
         GsokHChScReEUxDg1uB4RQR0ljZan4tV6FWCPbyXppwDsqWDWC6Gi2QYxjosQ3h+ZTUc
         gc7f57sk2NhEWBbXOsQTWFbmT60URyT8h5+uvKO4YaZbUM9aH8KL/EXkcwRtDnTZGyhn
         2ep6Mf6TLmMbqWOHYPt0R5VG0dTRXwdYTxxWY3c94GWMIMo3snQ/rLBKveuUQrrzeiUq
         jpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F/A/cGaE9iJpO7MzsZwsfVpgVALQOLZDXv2Hta+qdjU=;
        b=i+PeN0mnR+pASDS++ul3VZv6sLkksFzMcNkoi0AHTmCUvvlv9FXO5Ct7Qhp183boCL
         eUAeO7x5SsOhHlAtPGWRXJjqbVchJEjIuPgUl4dJ+74fNbXdiLtj2I6uZQiBDjprPp+n
         ghCqSAISkNUssG79yzYg6WRslkvbiTK8nkqW4lAjEmLrRrJKVqWTnzOptGEO31ElvmPG
         17TWC+J4+eE1YEMpBCD0DuIm0UQOGhllvHa1Qfqu4ELEOeFDgL0hAExFN/jTMRCNqGVL
         wZxRPJsjUfXXGtLfZ9FDw5925YcMDR2UpLiTuGp6qtwyaykAdEnOQqnb1Bni1VURt5hU
         jUHg==
X-Gm-Message-State: AOAM530NRWs75VY/bzUyMB56C2iWeFVuREd30vSWwwVAdRYtcr60OZjh
        6qm+YnAumkBzZ/+jZPkOTk4=
X-Google-Smtp-Source: ABdhPJwofCBBB09soCCRYTJK4a+6u+7lORLUI4juxBEiyRkcqmsy4s3p1KVmcsoTwsSfuzkIIHH5jQ==
X-Received: by 2002:a17:903:408d:b0:14f:b4c0:2ad2 with SMTP id z13-20020a170903408d00b0014fb4c02ad2mr4899229plc.162.1645750020208;
        Thu, 24 Feb 2022 16:47:00 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f16-20020a623810000000b004e1b132bc9esm711235pfa.149.2022.02.24.16.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 16:46:59 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Matthew Hagan <mnhagan88@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESUBMIT 1/2] ARM: dts: NSP: MX6X: get mac-address from eeprom
Date:   Thu, 24 Feb 2022 16:46:57 -0800
Message-Id: <20220225004657.1106499-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220223235041.2542331-1-mnhagan88@gmail.com>
References: <20220223235041.2542331-1-mnhagan88@gmail.com>
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

On Wed, 23 Feb 2022 23:50:39 +0000, Matthew Hagan <mnhagan88@gmail.com> wrote:
> The MAC address on the MX64/MX65 series is located on the AT24 EEPROM.
> This is the same as other Meraki devices such as the MR32 [1].
> 
> [1] https://lore.kernel.org/linux-arm-kernel/fa8271d02ef74a687f365cebe5c55ec846963ab7.1631986106.git.chunkeey@gmail.com/
> 
> Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
