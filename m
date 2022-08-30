Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C055A6EB0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 22:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiH3Ux3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 16:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiH3UxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 16:53:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3735E85FA9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 13:53:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p12-20020a259e8c000000b006958480b858so625114ybq.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 13:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc;
        bh=y+bRnMssrUj/6kbuuva6fXkHo2MrxrsD3o5Kbak+NiU=;
        b=eZwlVRJt892OWPFcvi3mSbbvEI013rOlwJ8QFYrdL6uKjYm2rCWX6K68pF3YCAeqiZ
         qgvPewGSY4+Gp/tXYr2XcFTkyewTDkv/8WPDwyCYAD678FgT1G45MEEmFFJsHyGNo9li
         M170u06nyQlYu659TVabIgtvqCDsqX5PyIVvdS8qYxzp8EvC5H38brNE3E2jYm5bePYx
         6UFwdh9z2Trb+JL9+RtcuaWjK7YLGRcbursv/mRBHLd5869bB7MYcP01QIc+7YNKXGp/
         2sr6/L9MsXDF55j4skMQAOaraXUefeIGVU7QPhKNyLAlR6x3dVZnNX+Bl2b88eQw/2FQ
         FaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc;
        bh=y+bRnMssrUj/6kbuuva6fXkHo2MrxrsD3o5Kbak+NiU=;
        b=yDIiyBHsUzbNhydAflf+zJeKs07NzY5xpFeptDg/GLgai1yUdbyuqphGBPzOxIme0/
         dUFzqN1/QxpADM93B8iAUKHWmuXeD9aKPT1rguCcZtf98kiWuKK+2yXqDyZ6WFZAzPwT
         MUDe/IzSXUbWdipFrWizVkEQrwqGmGZ7hAKX8taaE7DlEtO4dkktHSwVlR/71/x/GPxJ
         t0isoc1A6tHfUW4Ueaw6lH50b1zxw66r/LYDA3EqPLWNLeQZs2iRKCdXi7aD399gh7bu
         DWocA0wgGvqK3OmKxTNlU1jaFZSiI8neC1YgB5nUBatJ4zyaIxBOQZRIiy71BkjNgHl9
         V89w==
X-Gm-Message-State: ACgBeo2zhVPA4hdzorL/RhfYBx3lFIGaj/wvd3Jm3CTB1+LxvWoeYIDz
        TUw7arHy1LPywPJWnczaq8IlEXYS6WBuuQinlKc=
X-Google-Smtp-Source: AA6agR6LzzDTJp8/LLgR2tYJHvqNLA1ncTKB/GwiQ/kK5y2JZRXJnpE70VKmyZAmXfDvIzDo4To3MyuHVPeXGdtOKfg=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:0:100e:712:422b:cadb:302a:7901])
 (user=ndesaulniers job=sendgmr) by 2002:a25:7cc2:0:b0:677:5a84:9f79 with SMTP
 id x185-20020a257cc2000000b006775a849f79mr13577501ybc.518.1661892802516; Tue,
 30 Aug 2022 13:53:22 -0700 (PDT)
Date:   Tue, 30 Aug 2022 13:53:06 -0700
Mime-Version: 1.0
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1661892789; l=1211;
 i=ndesaulniers@google.com; s=20211004; h=from:subject; bh=zURt4cRkM9uRF4OuY2wV5cBpIhomPe0G2hadM5Q8amw=;
 b=bLH7JZthL0TsoZymjEI/Nxr8slOa9cg2x+NNHCAC3iV2z7Bk+diYAGjVVEJBHUWsrjvF7VXLCwc/
 a59b5uZjDMXpquiHqECzSVTdCS/k6DqsZi5T4Q7d/+nLj6TzLaa5
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220830205309.312864-1-ndesaulniers@google.com>
Subject: [PATCH 0/3] Fix FORTIFY=y UBSAN_LOCAL_BOUNDS=y
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_FORTIFY=y and CONFIG_UBSAN_LOCAL_BOUNDS=y enabled, we
observe a runtime panic while running Android's Compatibility Test
Suite's (CTS) android.hardware.input.cts.tests.  This is stemming from a
strlen() call in hidinput_allocate().

__builtin_object_size(str, 0 or 1) has interesting behavior for C
strings when str is runtime dependent, and all possible values are known
at compile time; it evaluates to the maximum of those sizes. This causes
UBSAN_LOCAL_BOUNDS to insert faults for the smaller values, which we
trip at runtime.

Patch 1 adds a KCONFIG version check for __builtin_dynamic_object_size,
and uses that in __compiletime_strlen rather than __builtin_object_size.
Patch 2 and 3 are cosmetic cleanups, they're not as important to me as
patch 1 is.

Nick Desaulniers (3):
  fortify: use __builtin_dynamic_object_size in __compiletime_strlen
  fortify: cosmetic cleanups to __compiletime_strlen
  HID: avoid runtime call to strlen

 drivers/hid/hid-input.c        | 13 ++++++++++++-
 include/linux/fortify-string.h | 15 ++++++++++-----
 init/Kconfig                   |  3 +++
 3 files changed, 25 insertions(+), 6 deletions(-)

-- 
2.37.2.672.g94769d06f0-goog

