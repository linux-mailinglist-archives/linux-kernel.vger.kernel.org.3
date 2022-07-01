Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FBA5633C4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiGAMyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbiGAMyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:54:37 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9728E3A1B7;
        Fri,  1 Jul 2022 05:54:35 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id q16so315977qtn.5;
        Fri, 01 Jul 2022 05:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cB0N8Sfsl7ydrt89ELVtEtpHxTBOqHu1NNNG72ZHfPI=;
        b=kyTff5FBVAJW0oklQUk+p2vs026FoEBJ4rpHQGRsno8WbiGN6MLahpAiecizK+qTWS
         5cptyI+RlnUe9RA+nwpOh+Ln5oSOtEdZstsazskajbVuyLTtm5ov5qFpRf70c48/4aFt
         mHbL/Dz44aS+DbU5DAxStuy6be4PRynPjDcB+4OOkUjuLp5WkWGwerIXokvOyu3nX+Dh
         m0qouNYexpo32TD17Yf2wsuaRb/Kg3GkeI8h07NfkGn/Nj5g79ifwMGhLyUmvRY62tk5
         BouCf3qSges6BOL/8ba//ds3L3tdvV//VOQMWfFNfkdTLGXdVmUYcYKFok30W+5lkQb/
         gBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cB0N8Sfsl7ydrt89ELVtEtpHxTBOqHu1NNNG72ZHfPI=;
        b=AuoIZ0Z5EfycJ7FCNIwvD3y2QuXEs+IM4nTMBJKXm1KFGstJdnhAo5B25H1hZzp8uO
         Ca3gFR7mF8JSVsa15RsnlcryOc6ocGZaIiVB+i0ki0wT/FsKRoKh+j91AtLJs8KNHEjs
         YgetD+6aLg21F4vtVGIHhVvk93kZl+zZXma/JN370+YA1fA8k93IfUhffmpbnaWgbgsG
         xVv13Z55BH2d4HAlqlr8B6I1yaVp5av9oAAJW4ChOqHnOZfS8LV6j7kVxSTHLAslDSe4
         Hvwlfx310dR9Ohjdpzbf1Qv5npxzhH7I37dSohY7TEVqV3DLk+kbO86FyD7uRKD1nA6f
         gcvg==
X-Gm-Message-State: AJIora82anUZB9cqXg67tOYU+eBi6mxLpzSIZpCvM3m6jE2eM1gqbMms
        4WCKLErUWZrsgvIFfic1OQgeO02Iw3g=
X-Google-Smtp-Source: AGRyM1vgpEU2SWOmHoiPTLl71LpcpYpHpmt7pAvqDIR6NabZC84wEX8F6AAvp7S/yxeLcr2lAHBtMQ==
X-Received: by 2002:ac8:578d:0:b0:31a:e1d7:952a with SMTP id v13-20020ac8578d000000b0031ae1d7952amr12367208qta.103.1656680074516;
        Fri, 01 Jul 2022 05:54:34 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:f902:9816:653f:2f66])
        by smtp.gmail.com with ESMTPSA id ay4-20020a05622a228400b002f39b99f69csm14026933qtb.54.2022.07.01.05.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 05:54:34 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 0/8] lib: cleanup bitmap-related headers
Date:   Fri,  1 Jul 2022 05:54:22 -0700
Message-Id: <20220701125430.2907638-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This series unifies declarations of bitmap-related functions and aligns
return types with values that actually returned. Also, it moves one-liner
wrappers around cpumask functions into headers, so that compiler has a
chance to optimize better.

With this series, GCC 11.2 for ARM64 with kernel v5.19-rc4:
add/remove: 15/7 grow/shrink: 461/164 up/down: 14844/-4580 (10264)

This +10K didn't surprize me because  modern compilers are more agressive
in inlining, loop unrolling, and other techniques that increase size of
the image.

Yury Norov (8):
  arm: align find_bit defs with generic kernel
  lib/bitmap: change return values to bool where appropriate
  lib/bitmap: change type of bitmap_weight to unsigned int
  cpumask: change return types to bool where appropriate
  lib/cpumask: change return types to unsigned
  lib/cpumask: move one-line wrappers around find_bit to the header
  mm: split include/linux/gfp.h
  lib/cpumask: move some one-line wrappers to header file

 Documentation/core-api/mm-api.rst |   8 +-
 MAINTAINERS                       |   1 +
 arch/arm/include/asm/bitops.h     |  20 +-
 include/linux/bitmap.h            |  10 +-
 include/linux/cpumask.h           | 125 +++++++++--
 include/linux/gfp.h               | 334 +----------------------------
 include/linux/gfp_flags.h         | 338 ++++++++++++++++++++++++++++++
 lib/bitmap.c                      |   9 +-
 lib/cpumask.c                     |  97 +--------
 tools/include/linux/bitmap.h      |  12 +-
 tools/lib/bitmap.c                |   6 +-
 11 files changed, 483 insertions(+), 477 deletions(-)
 create mode 100644 include/linux/gfp_flags.h

-- 
2.34.1

