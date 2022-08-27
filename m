Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE605A37F1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 15:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbiH0Njp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 09:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbiH0Njn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 09:39:43 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B85A32B8B;
        Sat, 27 Aug 2022 06:39:42 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-324ec5a9e97so97616477b3.7;
        Sat, 27 Aug 2022 06:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=T9+HQLzrIDsU5QNLiDsdH0Nj22g6zUGsbNi5IX8RcwI=;
        b=Se5GnqpTvBjyz9oIvoRndFD1C3n7/c0XCFtnIbBeOdeLveBavA5mBwY6z4Pmfsaj61
         3zkA9kK1wYWILQB2H+FVzgg0YGR2mPBQ3IQlH8XJaYgG5IoOuePlaIEUuBAcLZQYfe3F
         adPNbwuzre/QCYIe5Utll1o/icVK7dDkhy+t5QPLRRk1X3RRlBQXNhgeTFHOdjJ6VBTs
         0US7PdgzTgxJKsuoYjQ1cubrHTA9L0UtIt9axnGMKcNxuwcaSTOgrdFa1Rm0xxpVSaVe
         6HFqB1jIK+YsFNzdYbmlBiTYGiB1Vy65GjnWVZNnylc2VCgHDZRH5JvK44tcK+WIhf0n
         tLSw==
X-Gm-Message-State: ACgBeo1sRg+nkl0YvWFDhSD0wNi+8wLTXlNneZWmSJUigq+4GIqLBF5L
        J7XxFAyjR8U03gUX9nEBSTWcuUu7gONzXrwGj1zOn4QuRrM=
X-Google-Smtp-Source: AA6agR4C3JqsjNNgvmr1O21r2/DRaP9kFjIBCFfCT6ks1nzzdB+ieQj/ePX2+0pmF+Bv2YBU4ZkH98pBUqJ+58dLhAU=
X-Received: by 2002:a0d:c841:0:b0:33d:bf96:f823 with SMTP id
 k62-20020a0dc841000000b0033dbf96f823mr3717177ywd.326.1661607581213; Sat, 27
 Aug 2022 06:39:41 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 27 Aug 2022 15:39:30 +0200
Message-ID: <CAJZ5v0jnkSjtMff7uEKTCHLENMJYDd26BEjjZ3XK7fZMxHtd=Q@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.0-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.0-rc3

with top-most commit 2413a85200ee9cbed40d12c6e3b856752b089790

 Merge branch 'acpi-processor' into acpi

on top of commit 1c23f9e627a7b412978b4e852793c5e3c3efc555

 Linux 6.0-rc2

to receive ACPI fixes for 6.0-rc3.

These fix issues introduced by recent changes related to the handling of
ACPI device properties and a coding mistake in the exit path of the ACPI
processor driver.

Specifics:

 - Prevent acpi_thermal_cpufreq_exit() from attempting to remove
   the same frequency QoS request for multiple times (Riwen Lu).

 - Fix type detection for integer ACPI device properties (Stefan
   Binding).

 - Avoid emitting false-positive warnings when processing ACPI
   device properties and drop the useless default case from the
   acpi_copy_property_array_uint() macro (Sakari Ailus).

Thanks!


---------------

Riwen Lu (1):
      ACPI: processor: Remove freq Qos request for all CPUs

Sakari Ailus (2):
      ACPI: property: Ignore already existing data node tags
      ACPI: property: Remove default association from integer maximum values

Stefan Binding (1):
      ACPI: property: Fix type detection of unified integer reading functions

---------------

 drivers/acpi/processor_thermal.c |  2 +-
 drivers/acpi/property.c          | 11 +++++------
 2 files changed, 6 insertions(+), 7 deletions(-)
