Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC2A4DBA20
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 22:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243974AbiCPVcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 17:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358140AbiCPVcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 17:32:25 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C399F2611D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:31:09 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d726bd83a2so29157447b3.20
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ClWHWDT7CX049DHEiNtpDNX5IpgHCXZ+VwyNFz6LgH0=;
        b=BgQoxgdV5GOf73pfQ/WGP4djssW35zmCCWWBcMg3sKVKaKAWoOy478TcfMYceVJP8E
         d78fbbA0woG1yefDfcPn10hFACuxmUhkh7435xs2Fr5UspRjKPdK7tixH+jn45ffsUcW
         Ieiqv5l/vOMll5MF6qYxGRU4iZ1V7BmSQy82orwqmrP4m+BtsynWLXgmDzioTbJVAYTI
         P0errtDwv+j1WQKwZ6PHhWWsJAQnQ3rQif7rrpsb5LjvwkSzzI+6vrP1tDU60hF/Hg26
         tSilzYtb93Tb/PdVXivKjZRL4Il4/TF5yLm0xYleD3waElFNybR1oT+/CNSR5rs+NjoB
         MCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ClWHWDT7CX049DHEiNtpDNX5IpgHCXZ+VwyNFz6LgH0=;
        b=gyOvfEPL7LfHXRNh0hqDu2FXrJYCu4dkIxv32Vh2kq0gz4pBnHskiz7Rka3njnoVy+
         EqgJxC86O+KBSqBusEcU/A47axHNtO3wA7EYZcpM8z/2sBGuu5fEnMpggyNlmvJBEXjm
         05HFKC9oiQlAvYKhpitVjWfH3Yv6jFRN7N1qMBhIO94jeWFWqjrWd/lCHBb9GC6mBPKK
         Ws//KyyjwVAcUeg2VwAzS0X0hIDTVVxywzexZGzdpCbE0kvLAOzkBhtOtNPZf3iZZ+Id
         sw/5TjThR9jkpv9QP5tgQUFdlueSiexLhbNfLko6rXsNRntsR66UkVlhhbhtdFVAiZe4
         fHzQ==
X-Gm-Message-State: AOAM531r85iJjVTIvy2jhJ7QyKQDNSZj4EF+AthiDhHrWxbSFyBXpxgI
        Ji1w57gSYAf3dOqMHcSvvmSMX6su
X-Google-Smtp-Source: ABdhPJx/jiIIlpFV/7eSyVqL8KKvmkPZhl1KWSpn6H+MQ7NUic0LfWYxav/NY2cKUYF59mOTgJAKzHruOw==
X-Received: from fawn.svl.corp.google.com ([2620:15c:2cd:202:7dae:6503:2272:5cd1])
 (user=morbo job=sendgmr) by 2002:a81:6c97:0:b0:2e5:7aff:723d with SMTP id
 h145-20020a816c97000000b002e57aff723dmr2560658ywc.144.1647466269060; Wed, 16
 Mar 2022 14:31:09 -0700 (PDT)
Date:   Wed, 16 Mar 2022 14:31:04 -0700
Message-Id: <20220316213104.2351651-1-morbo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH] bnx2x: use correct format characters
From:   Bill Wendling <morbo@google.com>
To:     Ariel Elior <aelior@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling with -Wformat, clang emits the following warnings:

drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c:6181:40: warning: format
specifies type 'unsigned short' but the argument has type 'u32'
(aka 'unsigned int') [-Wformat]
        ret = scnprintf(str, *len, "%hx.%hx", num >> 16, num);
                                    ~~~       ^~~~~~~~~
                                    %x
drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c:6181:51: warning: format
specifies type 'unsigned short' but the argument has type 'u32'
(aka 'unsigned int') [-Wformat]
        ret = scnprintf(str, *len, "%hx.%hx", num >> 16, num);
                                        ~~~              ^~~
                                        %x
drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c:6196:47: warning: format
specifies type 'unsigned char' but the argument has type 'u32'
(aka 'unsigned int') [-Wformat]
        ret = scnprintf(str, *len, "%hhx.%hhx.%hhx", num >> 16, num >> 8, num);
                                    ~~~~             ^~~~~~~~~
                                    %x
drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c:6196:58: warning: format
specifies type 'unsigned char' but the argument has type 'u32'
(aka 'unsigned int') [-Wformat]
        ret = scnprintf(str, *len, "%hhx.%hhx.%hhx", num >> 16, num >> 8, num);
                                         ~~~~                   ^~~~~~~~
                                         %x
drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c:6196:68: warning: format
specifies type 'unsigned char' but the argument has type 'u32'
(aka 'unsigned int') [-Wformat]
        ret = scnprintf(str, *len, "%hhx.%hhx.%hhx", num >> 16, num >> 8, num);
                                              ~~~~                        ^~~
                                              %x

The types of these arguments are unconditionally defined, so this patch
updates the format character to the correct ones for ints and unsigned
ints.

Link: ClangBuiltLinux/linux#378
Signed-off-by: Bill Wendling <morbo@google.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
index 4e85e7dbc2be..bede16760388 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
@@ -6178,7 +6178,7 @@ static int bnx2x_format_ver(u32 num, u8 *str, u16 *len)
 		return -EINVAL;
 	}
 
-	ret = scnprintf(str, *len, "%hx.%hx", num >> 16, num);
+	ret = scnprintf(str, *len, "%x.%x", num >> 16, num);
 	*len -= ret;
 	return 0;
 }
@@ -6193,7 +6193,7 @@ static int bnx2x_3_seq_format_ver(u32 num, u8 *str, u16 *len)
 		return -EINVAL;
 	}
 
-	ret = scnprintf(str, *len, "%hhx.%hhx.%hhx", num >> 16, num >> 8, num);
+	ret = scnprintf(str, *len, "%x.%x.%x", num >> 16, num >> 8, num);
 	*len -= ret;
 	return 0;
 }
-- 
2.35.1.723.g4982287a31-goog

