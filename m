Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8020750CA47
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 15:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbiDWNFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 09:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiDWNFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 09:05:01 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64071F0376
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 06:02:04 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id j8so16712304pll.11
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 06:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Khre4woLYilT8tveAUDnxLgWCfWTYawAOp3Qw6Vbe6w=;
        b=V9B10p01ZGdq6LHGd5D4HGD+iyqdznu0HGruOf1N7UZPXyWqsy0LXMoG/Yr2YbtaMc
         EteTED3+dCmSwdcv/PsrgGOjdnRXVW9AyJc6VIojI5ep/Bah9ux0KsDeGC0Ez/OzGDzn
         kG8X3i41cXyGQqGCgP68ng3B1loFsR4UtEmztopu+6lUpEbqJvK/j/rrikO3ik1OMdos
         llATQJV/2kieUYFKiU8joaeklWV4LKFTjdXviv2CddbTIsjermdNGUtvq+NzZjOfeIWR
         7Dm3ohEF3778sPxoi//GR+YxWYmgNHrWBZwDuGdM7WmOCsRss+ctWHXkWRoOzZioELpK
         ru+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Khre4woLYilT8tveAUDnxLgWCfWTYawAOp3Qw6Vbe6w=;
        b=YHDPwHUUEKKMRK/WCjTXVB2+zT4fQa1j+CxBiGdYYH0CzwK8HhJWCC4+qvcyg7XQRB
         9ehGF8Cg8Z9mMPC5HmkBiQNKyj1BZ1NUoGqCo0+gtA523XbY6a6AKdbOg2taoq4+U7Eo
         zwD+b+Sm/LTi6/b7AW3QNDO9AfIgF0nj8WeSN3sqZx1ZYAzPzLVyQcVmkIj9UTrANOWO
         RuZ4VuBRbgvfw6chmr2QuvLbPVFMCSOiloIJYxN3mbSDbtZMBny3hZYVlxIB9AI5QRu2
         wxhtNqqlosGPmpO8OHcHasj4nO9eXZIFzuL1aWR8FORdi6zwiihSZyUdcAfKE16dgKQ7
         mP+Q==
X-Gm-Message-State: AOAM533V89bfwapW+s3eZC8pA1+ihjHDNr0ihhBzvN+Qq6aHvnzKZseb
        wgqnoU32Fbqqzx8mEzD+RqA=
X-Google-Smtp-Source: ABdhPJzS05PktvkR89kpKI4KkRwHVRekET8JQTKfNTda4WRK6RBwU5X9P9yt02vDuGSNw6Fb2fy/DA==
X-Received: by 2002:a17:90b:4a8a:b0:1d2:bff4:b44f with SMTP id lp10-20020a17090b4a8a00b001d2bff4b44fmr21460356pjb.118.1650718924248;
        Sat, 23 Apr 2022 06:02:04 -0700 (PDT)
Received: from localhost.localdomain ([14.100.36.163])
        by smtp.gmail.com with ESMTPSA id c139-20020a624e91000000b005060cdff4ffsm5808994pfb.129.2022.04.23.06.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 06:02:03 -0700 (PDT)
From:   Solomon Tan <wjsota@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: [PATCH 0/7] staging: rtl8192e: Remove unnecessary u8 and u16 casts
Date:   Sat, 23 Apr 2022 21:01:43 +0800
Message-Id: <20220423130150.161903-1-wjsota@gmail.com>
X-Mailer: git-send-email 2.36.0
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

Hi,

This series of patches removes unnecessary explicit u8 and u16 type
casts. They are broken down into 7 patches as follows:

Patch 1 removes u8 casts in assignment statements of u8 variables.
Patch 2 removes u8 casts in u8 arguments to function calls.
Patch 3 removes u8 casts in comparison expressions.
Patch 4 removes u16 casts in assignment statements.
Patch 5 removes the u16 cast in the u16 argument to a function call.
Patch 6 removes the u16 cast because the function parameter is u32.
Patch 7 removes the u16 cast from a function return statement.

Justification is found in the respective changelogs.

Cheers,
Solomon


