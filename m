Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4374A4AE507
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiBHWx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiBHWxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 17:53:54 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DE5C0613CA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 14:53:52 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id h14-20020a17090a130e00b001b88991a305so3330721pja.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 14:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i9+TXKUAkpTaSSFkDc82oY8i+zzLmeGGAoJvsbwdSmc=;
        b=DpHAirTaqreuTh3qO0clDbGWizOcXR8ahrX4F1ymRrFVbFS6CRYSM9SFmB6IAfTrk2
         xrQktak/8DfZMh4wzNznNm3R5p/8Bc+t3+mDTYX2OKBvEIMZ+v/xV+vflABKXocII+Wb
         +HSJfiymNB9IUaCaXTEuyVo4x/KSlYxBD2Yi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i9+TXKUAkpTaSSFkDc82oY8i+zzLmeGGAoJvsbwdSmc=;
        b=PlH2/8PC6deD9KzyvxVBqPZoM9lLCA5ClKt1JeantjTwhcUtUxBSLchkO8EQomzwdd
         L6pvjOwA23gvjC6nfC2lugSiJOVW2K14nEK7WF1I6GZ5BMofBCxeiDzp+knLdzpbDoRy
         WtRqeOxryuphqbWb4XWYrppcnq5PP0xXY2jZMFvChTNwXBHDBozUZaHdR1Po/43dDBNi
         fa7FJ2+iQnHTtCwa2YeShoB/E7as0Ya5Ktai3Zjo9lnWm3jRODA42iEIDj/vZ3QwS3EP
         jzMoEBvv1h6K3pLnVaryIZXw2seYrX+iezMLyNNggCphUfLjLk9TtybuD0KYFfxRj9gF
         T3+Q==
X-Gm-Message-State: AOAM531iHy/fC+qWoAVCeJf3p7wIiKUeTAlSfTD6vh9UTIzXwIiwI3N4
        JKbGWVd9eAN9l7X7wZNaBh1g0Q==
X-Google-Smtp-Source: ABdhPJxghJG0s80oPtx6cPs1tw9srhe66vxlFmTMitgk04CQTZOEHnGk8ydDSx5mkScbfCr5Zukeow==
X-Received: by 2002:a17:902:f70c:: with SMTP id h12mr6619293plo.53.1644360832442;
        Tue, 08 Feb 2022 14:53:52 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y8sm12371181pgs.31.2022.02.08.14.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 14:53:51 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        George Burgess IV <gbiv@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v7 0/8] fortify: Add Clang support
Date:   Tue,  8 Feb 2022 14:53:42 -0800
Message-Id: <20220208225350.1331628-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1778; h=from:subject; bh=VgPaboUfDiJcgnmAPga8l6bF+y6/pdp/kTPZknfOtHc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiAvR7gB2hyAJzJb1CAb7+XpPx3wUAMnqCrCC+4SiR pd9TJfqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYgL0ewAKCRCJcvTf3G3AJpsHD/ 9ZNIlnurQBvW2LVZrp41Dk0XSrYzoX0gMRlpSdXpfucgrtBfM+i/zQvvm9bPOetNqljg+r+iZDzJ47 TLF+5NQJCrAxw/JWpwAcDZZITYVnpP9deKRiRaeADTAgCgJEa1BPKBXOYv7zd+jqpA8ErZS7xqxCg9 zLlUkCWdcDpRhLOEsz8SiHXHUR5FBqI/HmKi8tAkCFQTyyeamXGWsHszvD7eclVjozTkwrt40aMpd/ Y2AXDv+RDe4BM9JHrwUkIYoKdgjtp4iwEe451T/Wn91ztzWg12zA2aqaw28KbgBK3lubqcOL7dn5qB g2TjOlEwdL1pTjhGx0grwPN/xydfSOMTevRogCBUPsbg0ap7dRpy6HvBIerAX7BCSE0AgTlkMQmoOL 80RX6u6JPMcKcDlbVCSSzcW6B7LlM3zrdBNHMpHWTUHHtvO9513WY2vtW450Gr4GegvoWK5IOlkegf a7fYyrFWAI9QGyEIpx51mWDl4eL+eo8Dk+LBRZRVWIZCw1xafO5roM29QfNZn2VJAtyybrmP5ooOGW h6iRUyHI4c42L3MKfMWTEp0Z2U8yaNZvhJGvFz49qNWW4wlP9+enwd4RyuwR7wOFgO70GNorYTGwKs YZ8a2RbFi0p9LY/IhQt6UU6+gG6M2U4Cqk8RxrBNSdWXQvuP/4pIkDzau3Jg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the updated series for getting Clang to work with
CONFIG_FORTIFY_SOURCE. We went around a few times since v6 on dealing
with -ffreestanding (thank you Nick for figuring out the root cause),
and are dropping X86_32 support until the associated Clang bug is fixed.

I also split up the last patch, since it was doing a bunch of separate
changes, which seemed better as separate patches.

Thanks!

-Kees

v1: https://lore.kernel.org/linux-hardening/20210727205855.411487-61-keescook@chromium.org/
v2: https://lore.kernel.org/linux-hardening/20210818060533.3569517-64-keescook@chromium.org/
v3: https://lore.kernel.org/linux-hardening/20211213223331.135412-18-keescook@chromium.org/
v4: https://lore.kernel.org/linux-hardening/20220130182204.420775-1-keescook@chromium.org/
v5: https://lore.kernel.org/linux-hardening/20220202003033.704951-1-keescook@chromium.org/
v6: https://lore.kernel.org/linux-hardening/20220203173307.1033257-1-keescook@chromium.org/
v7:
 - split last patch into separate logical change patches
 - drop X86_32 support for now


Kees Cook (8):
  fortify: Replace open-coded __gnu_inline attribute
  Compiler Attributes: Add __pass_object_size for Clang
  Compiler Attributes: Add __overloadable for Clang
  Compiler Attributes: Add __diagnose_as for Clang
  fortify: Make pointer arguments const
  fortify: Use __diagnose_as() for better diagnostic coverage
  fortify: Make sure strlen() may still be used as a constant expression
  fortify: Add Clang support

 include/linux/compiler_attributes.h | 39 +++++++++++++++++++
 include/linux/fortify-string.h      | 58 +++++++++++++++++++++--------
 security/Kconfig                    |  5 ++-
 3 files changed, 85 insertions(+), 17 deletions(-)

-- 
2.30.2

