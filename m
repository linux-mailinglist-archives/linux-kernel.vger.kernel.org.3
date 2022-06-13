Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21B8549F17
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351172AbiFMUaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351428AbiFMU3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:29:01 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7AC31220;
        Mon, 13 Jun 2022 12:17:12 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id y13-20020a17090a154d00b001eaaa3b9b8dso4025033pja.2;
        Mon, 13 Jun 2022 12:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=lQOC14y4MZzJxPCQl/yXRuGSNmghINjCYKOzFd5gwho=;
        b=epjxtcjcwG/Snjgc00FI/wsGY9USfAOJiWuZ8JtSXPQbVNpuZdYsO/NTwH0yOessa5
         LEKAG8TNyliuOSRfzLb6gE0B9V07tvQ2is4QPX8QMJklOim3sw9UE/6mcepl0j/P2Iv6
         LSUSjqXhyTlIY9ZGS9bs/p7cgwHiGHx9Au3sY+yRNwyGxza5zJXJX6mkSTpCgpaivasv
         N/i+3JHgPhXeRg/78ilmc7YQCAbIHy+E5DWB2Tl7sUyTSNOFOmN34i45CL36haUQ7il9
         a35TWQO4WyeVWzlF1Q4kC5hmKHyM4IU2ClxbfSqualVPwxjYTSFhe7ihg/7FlINlgzzL
         lmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lQOC14y4MZzJxPCQl/yXRuGSNmghINjCYKOzFd5gwho=;
        b=SJb1Q1UFnUhzcjnhoRvjxQbNrJH1QfMM19s2PYrRn2Dk6qs6xmI//jHz0VUbXO0cOM
         nkHaOunGxV0d1FtepGqvmS8o2VAI7K7nIJrNUPoqrRYuk3CWUavFk6J6SGjSN76PMvMF
         YWzSS/a1Wr/kgWukgsFub2iXR9QIUYfmoBsliedNHGYrXMmxsVZCkErHSgBFCVm/5eko
         B+wgv9CWfxxHv1oweEMuyGl35YpJgvgtQSLJlYBpH8JUOvb4k9NZ5XvRzwabNC7KESff
         T36lRVMiLAwAmBfUzslOPz62FRSI0QF7zMxowv/e37cUxLfJqxUEudo5wFW1e0dzLem9
         wQgQ==
X-Gm-Message-State: AJIora8FGrn1xagGAmOM7WlkfGlUTsFAq4O0nYg9Hqc8hti4EfO3rjDD
        8eaa2Tk+uTGTqpG6unuqKrE=
X-Google-Smtp-Source: AGRyM1tOapWyhSzo/TkqUJjdozKyAxImRRTFlesS7pjKe2JM78uZfMkr7IDAd+ieuZ8q9BKICpMExg==
X-Received: by 2002:a17:902:e552:b0:163:6a5e:4e0d with SMTP id n18-20020a170902e55200b001636a5e4e0dmr630897plf.66.1655147831940;
        Mon, 13 Jun 2022 12:17:11 -0700 (PDT)
Received: from localhost.localdomain ([60.243.255.226])
        by smtp.gmail.com with ESMTPSA id x15-20020a17090abc8f00b001e310303275sm5567202pjr.54.2022.06.13.12.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 12:17:11 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] iio: Add single and double tap events support
Date:   Tue, 14 Jun 2022 00:47:04 +0530
Message-Id: <20220613191706.31239-1-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds new event type for tap called gesture and direction
is used to differentiate single and double tap. This series adds single
and double tap support for bma400 accelerometer device driver.

Changes since RFC
1. Corrected the "quite" typo to "quiet".
2. Added proper reference and name of the section from datasheet.
3. Changed the ABI documentation to make it more generic.
4. Added ABI documentation for double tap quiet period.
5. Added available list by registering new event attribute for tap
   threshold values and double tap quiet period values.
6. Sending both single and double tap events separately.
8. Removed checking for tap enabled while changing data rate.
9. Returning invalid with error message if the input data rate is not
   200Hz while enabling tap interrupts.
7. Added datasheet reference for interrupt engine overrun.

Jagath Jog J (2):
  iio: Add new event type gesture and use direction for single and
    double tap
  iio: accel: bma400: Add support for single and double tap events

 Documentation/ABI/testing/sysfs-bus-iio |  24 +++
 drivers/iio/accel/bma400.h              |  11 ++
 drivers/iio/accel/bma400_core.c         | 210 ++++++++++++++++++++++--
 drivers/iio/industrialio-event.c        |   5 +-
 include/uapi/linux/iio/types.h          |   3 +
 tools/iio/iio_event_monitor.c           |   8 +-
 6 files changed, 249 insertions(+), 12 deletions(-)


base-commit: 9c50b2e70d55e088400b828d441b42254eae94b4
-- 
2.17.1

