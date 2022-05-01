Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436BE5167BF
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 22:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354352AbiEAU3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 16:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239469AbiEAU3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 16:29:02 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9A03A728
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 13:25:33 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id y3so24483073ejo.12
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 13:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=DvUXFRCJIqFc9YeD+6DOXUW8ZXQvEyCkX7qLIzxFXSQ=;
        b=c6/Z01NmZ2pcbUbcH4akZAUFxcwPNhF+dqta3z6Vx/ymhZng2oCQPHJl8D7I9pWRdd
         aXZecfL/mx+JcFNWVMTFcda6PuKshb2sqVaGoXIScNqGUeqmSFSAsDktsk5SJRh+sZ1k
         9Z6M2BFFZgHHnqnej5YeeLLAfquyVN8gHAAxTn8hegRq2Z1uWmkFZgR3txvKfRAflmFH
         BNKB1ykOCk+92o4MumQhLfJfCOseBeOMkJLRXsgO34v/6EzlgxYgBgB5mf+tRT+GSZiX
         kEoE940U0cHEWNt9O7Y3jrzkqWwdtJJCWMNjdPU3cRfaysYkldj2RD1eGBZeXTCUnL5w
         uIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=DvUXFRCJIqFc9YeD+6DOXUW8ZXQvEyCkX7qLIzxFXSQ=;
        b=abu+is6maFFc5z4z78su9oFJu/uvKXhrkdJc5+tv0tjP+IxVusAzxg1Ia7uzwse/MU
         IBB7MisBCs7mcgFENuEpU828s9+gxdI+gAGnglNnuo7DSmn49wofzarLEcdNTxZ/2xrr
         ClOBbQufyU9EBKIzkZkNgjVPnYoeXdwKxEV2YeTXO3xQbmnZYG2SvKdYrZMeFDntzweH
         jlFEwnvHBk0q5G2+6LenLK0x6rirjIapzHHT6OpGkPEanVdnpsNMHJbJNncxxDzHn9Bv
         EhC+gDbI0gCJ7ZmCe/M7/a2+8sIgFZMVfmk45CZ+JXMNylL+mQCMJCrIdfbDFh7tMA4P
         ADOA==
X-Gm-Message-State: AOAM531VNpdXeEjyTpYKXJ9kKDqnwAbn6ApUmoEXe9/6X66r62avtkJI
        JtoF4tg8Mc29S0ZvzZJVNEA=
X-Google-Smtp-Source: ABdhPJzbG/n5nZ+7htjtIi7CYIoPN9Ye3uz+miHrtt9nEMd+TB3Eao3PpmIgeQspdKJJWdyCmIe4qg==
X-Received: by 2002:a17:906:2991:b0:6cc:fc18:f10c with SMTP id x17-20020a170906299100b006ccfc18f10cmr8460862eje.744.1651436732353;
        Sun, 01 May 2022 13:25:32 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id e28-20020a170906845c00b006f3ef214debsm2879018ejy.81.2022.05.01.13.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 13:25:31 -0700 (PDT)
Date:   Sun, 1 May 2022 22:25:29 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] staging: vt6655: Fix name and return value of
 CARDbGetCurrentTSF
Message-ID: <cover.1651435890.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix name of the function that uses CamelCase which
is not accepted by checkpatch.pl

Replace unused return value.

Tested with vt6655 on mini PCI Module
Transferred this patch over wlan connection of vt6655

V1 -> V2: Changed function name to include driver name
          Updated this patch series from changes of previous one
          - Corrected patch: "Added missing BE support in CARDbGetCurrentTSF"
            from #ifdef __BIG_ENDIAN to le64_to_cpu()

Philipp Hortmann (2):
  staging: vt6655: Rename function CARDbGetCurrentTSF
  staging vt6655: Replace unused return value of vt6655_get_current_tsf

 drivers/staging/vt6655/card.c        | 20 +++++++++-----------
 drivers/staging/vt6655/card.h        |  2 +-
 drivers/staging/vt6655/device_main.c |  2 +-
 3 files changed, 11 insertions(+), 13 deletions(-)

-- 
2.25.1

