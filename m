Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312344A8A2C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345881AbiBCRdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352887AbiBCRdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:33:10 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBC3C061741
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 09:33:09 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 192so2814703pfz.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 09:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7h+kMvQchz+AoPV2FM/vL8Y/TYyKtPcf9ypfobGVKnY=;
        b=PHy4GgqKpjDxG02rHl/MQY3sUK0g6wb+yt12jn0BJL3wTgec8qbxCcOLpeY8npY3tJ
         f5bUpglH+1Lcih7Owe7h6mc+V2wgnaPXoxNzDSpJkjjPC8MpArsbk3zKcS5po8sZ/mqZ
         rhisk/Go7s/ywjgh9ORXvF2xjK2YnW6ewPR+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7h+kMvQchz+AoPV2FM/vL8Y/TYyKtPcf9ypfobGVKnY=;
        b=Wiswjm1Qf7uhnIGx0UZo1an22UB3OPVC8POyAW65uBEWDLdIsTXQw5VoUX4oFSikzC
         xLdVZWOc4TKLdtnNTf/UTVSezL+ofC/ziJOFfnR1gHc2Zu2bguxwpD1UN++Ugksr6OUF
         3E+YBAtPBWDQu65FUjfPSJhwL12euzUl05F2t8wDPrufuRSkKR91AimaNrAMPGE6+l2i
         FnNu8utPePCAc3TFYkxLm5lhZzRVUMkelehA+gHkHQ1O0KkRpJHerEtqKxcx6aO+y4B5
         lhuaMRprMowx1TGj7kqk0EI+lQ6WiruaDODZ8bECp+go5BjK1PPmzC9dZuJaRhfMQNMp
         UITw==
X-Gm-Message-State: AOAM530g9+CHZSswJsJ+VYdCzWIq4CK/mGcbFLDtazwi7uvamcyUG07C
        GkxNRqncO3PUGp32URybWxmwZQ==
X-Google-Smtp-Source: ABdhPJwNmj59YXqdNUHNYF4RM/G9wDOf8BdoHn/6oXxpaxjIRG7bKOmSHWfVPScDu5yKFlstKRswQQ==
X-Received: by 2002:a05:6a00:a92:: with SMTP id b18mr34480193pfl.3.1643909589411;
        Thu, 03 Feb 2022 09:33:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 16sm10408471pje.34.2022.02.03.09.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 09:33:08 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        George Burgess IV <gbiv@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH v6 0/4] fortify: Add Clang support
Date:   Thu,  3 Feb 2022 09:33:03 -0800
Message-Id: <20220203173307.1033257-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1239; h=from:subject; bh=6kU6WanqjoBPUumm/P0DvF5FKzthc4ynpCb/btOBAdk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh/BHRWQf7TUvbj1C/Ib0Gdow2yvtEVBucC0+3VRD2 B0yc7OqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYfwR0QAKCRCJcvTf3G3AJpdyD/ 4jg/g7Yj98s2up2vl0ZR7m+fFMN8uft6bejiXjvARJHiq1H2nxrebunUyFzS8StdQW1ArE2bFvmY0T 4UXLOHeE+/6H8khSaH6zVAfRUBdNMYv7RB3CMpEVwtXFMdP/TJ89AdjTSTbW4SGNVzr4ST7Az1KFs2 NNWYxlIbiiojEN5I8cXiGcQxeSgZbYnESgc98CwSMyB6p4eOEeB762wtdyLGlvJtSnBIzFj0MB8B1A u8feBDXEtB2OW+Ju/QJlGxPrCN0Fi8yxsDimOW9mlsN+VNBwMmeXHXfuHugOh2+Ra10HkwNEYbQgu1 sXq0h630uFPu88FyD+ZRTgW006NKoDKTXZcH7lYfgbVtdHaTck+PLoho/dbonKjAqtv2lX9A00oZb4 5oglVB8K9smuN6vOFDpthWwS2zYBr2276G9qYRGMTbceg7I7pBT9xGemd3Gza2tXJ55J9wnAI/dxxe t8wH+1VG7C5B2NmyjYsmkOmlNXy+46XDMj+JNICXVvdZIGxRi1Lpo0BXO6np9toxkt1wJxNzsaOIxa lmZ93r4GnD4jOsHW4HToMQbvhsxCP4QADD/TFsm98fOYEZu3bb31UgnUz8YRhOFD8iVD6qguoBa6sm GGLQn8DVHVt9VELW67gV7oNGwfsuCs9SAJHjVOEzjx9FXgYAJohdp43/ISEA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This has been updated from feedback on the v5 series. Builds correctly with Clang 12.0.1
too now. :)

Thanks!

v1: https://lore.kernel.org/linux-hardening/20210727205855.411487-61-keescook@chromium.org/
v2: https://lore.kernel.org/linux-hardening/20210818060533.3569517-64-keescook@chromium.org/
v3: https://lore.kernel.org/linux-hardening/20211213223331.135412-18-keescook@chromium.org/
v4: https://lore.kernel.org/linux-hardening/20220130182204.420775-1-keescook@chromium.org/
v5: https://lore.kernel.org/linux-hardening/20220202003033.704951-1-keescook@chromium.org/
v6:
 - clean up comments in attributes (ojeda)
 - moved const into pass_object_size macro
 - adjusted Clang version to 12.0.1 (ndesaulniers)
 - cleaned up Clang comments (ndesaulniers)

Kees Cook (4):
  Compiler Attributes: Add __pass_object_size for Clang
  Compiler Attributes: Add __overloadable for Clang
  Compiler Attributes: Add __diagnose_as for Clang
  fortify: Add Clang support

 include/linux/compiler_attributes.h | 39 +++++++++++++++++++
 include/linux/fortify-string.h      | 58 +++++++++++++++++++++--------
 security/Kconfig                    |  3 +-
 3 files changed, 83 insertions(+), 17 deletions(-)

-- 
2.30.2

