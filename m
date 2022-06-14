Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DC654B533
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243439AbiFNP7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237765AbiFNP7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:59:16 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0701CFE2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:59:15 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id gl15so18086499ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I6VKVhNV12BqYvdKkWEFx5TpD+CKWu2FsSp0oxzNzYM=;
        b=bzQjmrUKVWoxYAWPQ5h76mfm5RHFWv8cI6qKQmH7E4Pb2ldPY3oL6YwtE9UjNUnfBk
         418IbHs/cl3nHNmKkhRT/6F3yul9NFJOcMGmfLsU4gyx3sPxuvo60U/vREY090V5x+hQ
         H3v1DZzw6ULpZFnMJoEQpI8IRsrIzRwmuILaSVrlHFNjsZ3C+6Mfexj9tOsJJcHxjwrq
         SqJq9eRmGb+dDNnia+5bKELt32E2ufY7Er11maQ+Zv+pdh6H75kGMwhLcTxF7aDVXO3E
         76Cwtk/gZSmHctR44KqyGtbZmD8k7E8iAXJZ3U6WjeHtNBJIXa8ZFNx3KUB1e0dwyzX8
         rICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I6VKVhNV12BqYvdKkWEFx5TpD+CKWu2FsSp0oxzNzYM=;
        b=V9d7MlkP6WOPTEXz9GWaHcJCY/7MRu1aSLNkF7MjVjkYD54Bdm8Z6AwCYXlE7/C4y8
         k5MBoy+iZ+xLfA921QTkhPh5eAMeyhF4j4/zFBWJfNpn9J8RUPhh7GnwuYcHGvgBpZ5V
         HLYRuodRYoSJtyOwaUHqi+F3igpQXTTX/3DFDzQj/oIb/wwgvjKTEaMjKS4Tmxj3Xebx
         I2uzq0IjiuoUAEKiuo9Z5Wjj3Md/uKKF1JGRY4tEOA83rE6sN4THCvEpJBAuG2Cx+Gbf
         x6bs+D4QRcB7AOSAFY7s4/hyMCyWWrM9Tum/KyB9pDyoV2t011+cbS/LhPpHv2wHM1E2
         sZuQ==
X-Gm-Message-State: AJIora/2dPL4TajxixibLNVLUA8Vhn0A48sDnW3hhirwWgZEeUWeQVle
        XeJz0Jpodrn+ndD5+W/fGJ0=
X-Google-Smtp-Source: AGRyM1uTusRcT6pmrCq+uVZtoE2aMTyOt/RO0y80Vspavy1q0UAxwDlegDSgcbeQ+Lp048SvG8Mp0A==
X-Received: by 2002:a17:907:2cc5:b0:711:d50b:287a with SMTP id hg5-20020a1709072cc500b00711d50b287amr4896923ejc.47.1655222354125;
        Tue, 14 Jun 2022 08:59:14 -0700 (PDT)
Received: from nam-dell.fritz.box ([2a02:8109:afbf:ed88:c58b:f186:2720:bdac])
        by smtp.gmail.com with ESMTPSA id qk10-20020a170906d9ca00b006fed93bf71fsm5327928ejb.18.2022.06.14.08.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 08:59:13 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, namcaov@gmail.com,
        phil@philpotter.co.uk, Larry.Finger@lwfinger.net,
        paskripkin@gmail.com
Subject: [PATCH v3 0/2] get rid of confusing macros
Date:   Tue, 14 Jun 2022 17:58:43 +0200
Message-Id: <cover.1655220367.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YqhWIiXadDC3hzel@kroah.com>
References: <YqhWIiXadDC3hzel@kroah.com>
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

Replace some confusing macros with more explicit codes.

V3:
  - Get rid of GET_TX_REPORT_TYPE1_RERTY_0 and similar
V2:
  - Split into smaller commits so that it's easier to review

Nam Cao (2):
  staging: r8188eu: replace confusing macros
  staging: r8188eu: remove unused macros

 .../r8188eu/hal/Hal8188ERateAdaptive.c        | 12 +++----
 .../r8188eu/include/Hal8188ERateAdaptive.h    | 13 --------
 drivers/staging/r8188eu/include/basic_types.h | 31 -------------------
 3 files changed, 6 insertions(+), 50 deletions(-)

-- 
2.25.1

