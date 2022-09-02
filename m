Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2455AB98F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 22:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiIBUoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 16:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiIBUn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 16:43:57 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F31FC305
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 13:43:56 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id c24so2891305pgg.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 13:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=sZPJfqcD09tvFWjEDYBYtlverxsHoy9T0oKZRLJUCZw=;
        b=RcxxWZ8vJO7OOe7TRyJWIB8EKufFUt/BANSI6FckcuAJSqV+5BqTwmzhzUmZEEr266
         3ob18RJkj9OgboGXczxe2uro/5hu89u/onO4cqjWVwJzFGaQa+T8fVEvyIvoIAhgCWn2
         yJdpFXGizjAZqAwR2Ebb2vBxehrWn+t4C9Rag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=sZPJfqcD09tvFWjEDYBYtlverxsHoy9T0oKZRLJUCZw=;
        b=o/BM7UkTCF8hXI5eMOipm+brK96qXSweITPNj8G3bdAbufzdy2B8ezyS+2B0dSrj34
         ae9czS5t8k1JwhbtsT/DztEEELtWL+Mf4qvNvd7R2KYRwCKiVN8dKxP9BCsO7hcJtDhF
         gV+WbY6eqKp4yN03zt6nNbYzZjZEsaLLHnlJwHNwkEfX1ADXPSMGPl0qpS0E9eoFw7s4
         uCmj4xDby/9vhxD+zVHw+STCGwNeAZEfz1uNLkhA8N76TVNqH3YJIxwAfMpecqJjvInq
         3NpO1G275yAur6UXZcN9YIp9kHMrQt/FbnWlaGmLTlCiqwtofqtYB6kAEjeD+qiue2/r
         bC9A==
X-Gm-Message-State: ACgBeo3QKJIOQiUc2bSpTi0S7HmjIAnlGV69duKFmwlfhS5dYMWMgCax
        F3oyeIckcRpE754blwSGiOl9+w==
X-Google-Smtp-Source: AA6agR6nzUnv8s3tYa6U3qjvQ33SRYe9uYKj8nq7VQgVg32KbD23BCuTNZI27c470CsjPkNAaAa3Lg==
X-Received: by 2002:a05:6a02:10e:b0:42a:b42b:5692 with SMTP id bg14-20020a056a02010e00b0042ab42b5692mr31618973pgb.67.1662151434670;
        Fri, 02 Sep 2022 13:43:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k1-20020aa79981000000b005380bbac1ccsm2261184pfh.167.2022.09.02.13.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:43:53 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        David Gow <davidgow@google.com>,
        Yury Norov <yury.norov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sander Vanheule <sander@svanheule.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Eric Dumazet <edumazet@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eric Biggers <ebiggers@google.com>,
        Hannes Reinecke <hare@suse.de>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v2 0/3] Fix FORTIFY=y UBSAN_LOCAL_BOUNDS=y
Date:   Fri,  2 Sep 2022 13:43:48 -0700
Message-Id: <20220902204351.2521805-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1524; h=from:subject; bh=IYVjOR693wr8XRnktZsErNSDDWNwlRQ3EaApRtdh/Ps=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjEmsG2nNhyhGivRpgongJJqo/B6A2cCOPihZgYFON NG5cf02JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYxJrBgAKCRCJcvTf3G3AJiOpD/ 0TvgWPk2SjA9DTyp3AA0HHfWkPf/604NIKqre/iSAlX/cXFYeGXjO3+YiDA1lVKR+XrEHE6l0+Ux11 8AfFFoWv30iwq3A1CfgOdK2615+orGpMJ9SjFeh4kGndvKrUUQcbZ7edpo9WqTS3csverQhhb7Nklx tvH2nCRmX3lbTX095rDL2abW3MhDF2wciYNB/t7nNkWUAIrcUjRe1KvvC+uxxfNoF39BIk4W2iVkVH 7oKsv6Hpyc9kdIXR9NNk7gVywdKl5nAIc8vGc2U8ej0d+QA4bqwYLM0eY8/FhMKjnskTTjW5CWICBh cSqDPr8SK9tKuCF1c4iwlxHs0xnEbzi0nmBSkGwwJEawG+CX06IkJS5a15TBshfD/+e5LfvQQ0oG3v NlwYZtY19lhohbQq3xWg7UD+ex9ivYO9vryff8C5PpuwaDgjbgNxxZHC5vPHTjlBWcp6GapsCR9NAW CC71svMdDFe8Ibn2rlxvOvnvCL0ad6YIYedLojauVDwmYBpnMaz96i37hfkiVFAIvTjmz3N6iGvZXg HH+5gbwr9zA+InmMJNeIBb/r+X4PsMJGKNbWM9JOpJHSB+FO7WXr5QuaHYYFCtbFURg3WaU9p6bOh7 /VGKHEb2X4ZdRwds9X+uRRkWQLXXKYB16TLPBLXQZmFxEZonzvYP8bEfVidg==
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

With CONFIG_FORTIFY=y and CONFIG_UBSAN_LOCAL_BOUNDS=y enabled, we
observe a runtime panic while running Android's Compatibility Test
Suite's (CTS) android.hardware.input.cts.tests. This is stemming from a
strlen() call in hidinput_allocate().

__builtin_object_size(str, 0 or 1) has interesting behavior for C
strings when str is runtime dependent, and all possible values are known
at compile time; it evaluates to the maximum of those sizes. This causes
UBSAN_LOCAL_BOUNDS to insert faults for the smaller values, which we
trip at runtime.

Patch 1 is the actual fix, using a 0-index __builtin_constant_p() check
to short-circuit the runtime check.
Patch 2 is a KUnit test to validate this behavior going forward.
Patch 3 is is a cosmetic cleanup to use SIZE_MAX instead of (size_t)-1

-Kees

v2:
 - different solution
 - add KUnit test
 - expand scope of cosmetic cleanup
v1: https://lore.kernel.org/lkml/20220830205309.312864-1-ndesaulniers@google.com

Kees Cook (3):
  fortify: Fix __compiletime_strlen() under UBSAN_BOUNDS_LOCAL
  fortify: Add KUnit test for FORTIFY_SOURCE internals
  fortify: Use SIZE_MAX instead of (size_t)-1

 MAINTAINERS                    |  1 +
 include/linux/fortify-string.h | 29 ++++++-------
 lib/Kconfig.debug              |  9 ++++
 lib/Makefile                   |  1 +
 lib/fortify_kunit.c            | 77 ++++++++++++++++++++++++++++++++++
 5 files changed, 103 insertions(+), 14 deletions(-)
 create mode 100644 lib/fortify_kunit.c

-- 
2.34.1

