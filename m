Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D013352C4C0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 22:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242844AbiERUwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 16:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242824AbiERUwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:52:30 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAA6703D7
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:52:29 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id ds11so3231935pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JdZIuTph6UyHc31PT+qjqiT2mFpJXzwSW3A0E2kkk14=;
        b=l6mXHPZ8kLkUr01yIVK7kTj9ucJerjGFd/bqcupBpvRXBwxOdeBzE5zT6RVMwd8u4E
         sC0/NglDQlS/lhU3q42plTVqpLXzUj3C+VZnvIfnkZHhA0WHHhVbnsO+8k/o1L0UHw3C
         kZNzqTvntvbqL3/Kndl6KwJ37HothSnV3Yjt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JdZIuTph6UyHc31PT+qjqiT2mFpJXzwSW3A0E2kkk14=;
        b=kss8crMElztKQmnbud6/9OHcbTYxR9T6Hi9U0LrTYheKeodR/2ps+FRiSEywb9j/7Q
         RUTzMBpN5CqoRmeH97dhmhhLD41JiRNgaEcfwgDcbA6dNuUrZ4fCrnP43LttYsmuEft3
         krJFFnsQiP3X0C1SizKpOmGT8UAWfV4Y0/9dkCd6rdzJZGZa1AqhvGhWzqKoxrMovJ8T
         EdRXR3Lbs+/5YFN20Zsi2u/7NtjzyAos7/ZAEDDAvpM6A2hiGfk12MvpoaApvzRdojxN
         oPdHuT1DwFnIpVpPtP374gJaSC1jGY5DXxujshSNJf2TpUP5NYzcDqHkHemzf7OpQCrP
         2QZQ==
X-Gm-Message-State: AOAM531roq8i00f9BHjb7FdGbQAkPDm316PfMpU+eNuVy/HqPEdfHtn4
        6ySOD5isQtC23WXHVmmr9ZV3IQ==
X-Google-Smtp-Source: ABdhPJyfbFurc2t5nNorjX8j4XvMSTJXoOkSFTxMmka5GQS12jpwqvlP573UO+U/alR1uyBkZJnLzQ==
X-Received: by 2002:a17:902:ab05:b0:15f:3aad:6269 with SMTP id ik5-20020a170902ab0500b0015f3aad6269mr1406840plb.23.1652907148568;
        Wed, 18 May 2022 13:52:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902684d00b001617caa6018sm2129295pln.25.2022.05.18.13.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 13:52:28 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3 0/2] bitmap: Fix return values to be unsigned
Date:   Wed, 18 May 2022 13:52:21 -0700
Message-Id: <20220518205223.2908736-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2115; h=from:subject; bh=R70ghsDwLBHQo1RRRo9DWKGhDdbuR9zdciwAOltQcnA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBihVyG48xTNUqEa/a4+0ugW4c/ps2zrLR217f3cGJJ ehgAUCGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYoVchgAKCRCJcvTf3G3AJmzCD/ 43KZtI5qRRC/cvoZhHofnH4as6tIBmLWw+Jdcw3p3oKnD7VyiSNF4lZT1+jFyqB58drt2mk3kc08+2 O+LtUQxAYT5exlzi70GL+KZNC199WiN6x/I/607llY6Zk7laiO9rzw6KYD6iF6fJrQ70KSphFbcQIh TvdCTapMzL7+wd3GSM4Cminbw6ShBcLZnaPk6R25olHHWmjQISr9HOg6pwx1trf6PnW/ckesIGWnBx /z7m4dJZgPAT+fN9A98vtaYEw/ivP2s9nCNSiYExVym6GBVsT5FwwZmMd6PTb1EW2IrLyK5Ft/vVaa 5f/bKJnDErY9P1xchVW8OzPrhbKVCAV/9zB8+qqTVdELYdLBoTcP4tQAWKBE4KbrWZfglTdjn8loQg i7EUTfJAWpJcGsMGxuDH9b/sZcH0vqOhe6QDxccJhqidD5dz+o6vroFdDkzKSYveba+nNZRhLthhQh jTrRScsC7poPlor+D9iJHtN6PJsukP394n/19Kvm2aGQYgDFHD3P5NuWLSJiy8RGkHJSFeCfDb1XTk pYDoO03S1k/GCtDjehodu5Z1Rb9AF7A64XHS5ZnONB/RzY6inLGaIyAmelZTnwaYwwi5E2DBq7IkiG UBq8qw5FYsK4CLqCzVAVBvENHmrztFaAuZ3Qs6zjIYlk2g2BukRBhCdxtsHA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

v1: https://lore.kernel.org/lkml/20220517035411.31144-1-keescook@chromium.org
v2: https://lore.kernel.org/lkml/20220517212234.868181-1-keescook@chromium.org
v3:
 - Update missed int variable to unsigned int
 - Update tools/ bitmaps code to match
 - Adjust whitespace a bit

Rationale repeated from the last patch:

Both nodemask and bitmap routines had mixed return values that provided
potentially signed results that could never happen. This was leading to
the compiler getting confusing about the range of possible return values
(it was thinking things could be negative where they could not be). Fix
all the nodemask and bitmap routines that should be returning unsigned
(or bool) values. Silences GCC 12 warnings:

 mm/swapfile.c: In function ‘setup_swap_info’:
 mm/swapfile.c:2291:47: error: array subscript -1 is below array bounds of ‘struct plist_node[]’ [-Werror=array-bounds]
  2291 |                                 p->avail_lists[i].prio = 1;
       |                                 ~~~~~~~~~~~~~~^~~
 In file included from mm/swapfile.c:16:
 ./include/linux/swap.h:292:27: note: while referencing ‘avail_lists’
   292 |         struct plist_node avail_lists[]; /*
       |                           ^~~~~~~~~~~


I note that Alexey and Rasmus have touched on this area in the past,
fixing up node ids to be unsigned:

ce0725f78a56 ("numa: make "nr_online_nodes" unsigned int")
b9726c26dc21 ("numa: make "nr_node_ids" unsigned int")
33c4fa8c6763 ("linux/nodemask.h: update bitmap wrappers to take unsigned int")

-Kees


Kees Cook (2):
  bitmap: Fix return values to be unsigned
  nodemask: Fix return values to be unsigned

 include/linux/bitmap.h       | 25 ++++++++++++------------
 include/linux/nodemask.h     | 38 ++++++++++++++++++------------------
 lib/bitmap.c                 | 30 ++++++++++++++--------------
 lib/nodemask.c               |  4 ++--
 tools/include/linux/bitmap.h | 17 ++++++++--------
 tools/lib/bitmap.c           | 20 +++++++++----------
 6 files changed, 68 insertions(+), 66 deletions(-)

-- 
2.32.0

