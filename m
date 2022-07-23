Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B4E57F1CB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 23:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbiGWVpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 17:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGWVpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 17:45:43 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DF4DFDB
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 14:45:41 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id m10so5845646qvu.4
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 14:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jcVZzfJ+oVu0k1iEEQRl2mGHqBWa1nplvzjefXrRdLM=;
        b=OPmBQpai3vdx4jYuouzIhgDeqIEDHLQVcEvh+SKKQwx0sGPPIlTTfANxYu9MHF8uH4
         1QKh4pARNf3ZANSP7V6NO8RPkWJj424PmSYMPEUV750OUipqQkO+gtJQe3qf6B6co6Ky
         3FgBlOtDfRtEFfeb48sXKby4xCShDTuIg5gEWNvuPMTNVV1dh1XgygKx6tqqGLjeivTt
         6yoFyaISjTnWk9QRnbZrYb0xetqYE4/JHo+V6H1IurDBNUp9NjJzrijjoz74bbd5uGF8
         /d8UCL4gXkfVvck+ZV+0xpxnxhg2AW86fzGxIcjZryPk/TVeukljQVYMi/DNycDfulnu
         J41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jcVZzfJ+oVu0k1iEEQRl2mGHqBWa1nplvzjefXrRdLM=;
        b=jzROaiczBbhhnZmv52mu3EDOS+iOxVzngo/J+sxWP30qMet/Sntih4B7OUhJYLVjpK
         i1l+4eSDjJ5Qb9IHUM8H1DB4rOzhdQxf5NuZvzpz8nZN00aF2XatOy1p0/oWnSVqjrIf
         8G4FiRHVlzKA/BUh9DM23XovmmsBJw0ymPyaAPIPobV+zlz/xBSAuSh/DWxpOoE9GFqb
         /0MwabbynWw4FHJH3694BhjC9XypqbfV9ZrM4h9Gc2bIEmw6ytxAZ6UQa2bOK74Hj/6k
         6fZDtvLnbWXW4U8b0pC+oy1TSBEoCdrCM/Wb05btxQv/QY2DcWEfwSYe92+beOSuZxMN
         llTg==
X-Gm-Message-State: AJIora/9eDmQ3lOt8p5wckSUzRNFa5zI0MkoZvlqeeTZLwMGHKip1kSH
        H4RbMfZYk7UVc3VlQKI/MNZAJDJT76w=
X-Google-Smtp-Source: AGRyM1txzng5Pp4Y8H5Znxrrl1B8N010dErCoy1b89zNXR7dHZFuYAWpbWXl4mufK333Qf+M0FCPqQ==
X-Received: by 2002:ad4:594d:0:b0:474:4159:5551 with SMTP id eo13-20020ad4594d000000b0047441595551mr422603qvb.117.1658612740179;
        Sat, 23 Jul 2022 14:45:40 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:6235:40e3:a1d2:6281])
        by smtp.gmail.com with ESMTPSA id m6-20020a05620a290600b006b5c492aafesm6263257qkp.86.2022.07.23.14.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 14:45:39 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 0/2] lib/nodemask: inline wrappers around bitmap
Date:   Sat, 23 Jul 2022 14:45:35 -0700
Message-Id: <20220723214537.2054208-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On top of git@github.com:/norov/linux.git bitmap-for-next.

There are just 2 functions in nodemask.c, both are thin wrappers around
bitmap API. 1st patch of this series drops dependency on <asm/machdep.h
for powerpc, which prevents from inlining those nodemask functions, and
2nd patch inlines them and drops nodemask.c.

Yury Norov (2):
  powerpc: drop dependency on <asm/machdep.h> in archrandom.h
  lib/nodemask: inline next_node_in() and node_random()

 MAINTAINERS                           |  1 -
 arch/powerpc/include/asm/archrandom.h |  9 +-------
 arch/powerpc/kernel/setup-common.c    | 11 ++++++++++
 include/linux/nodemask.h              | 27 +++++++++++++++++++-----
 lib/Makefile                          |  2 +-
 lib/nodemask.c                        | 30 ---------------------------
 6 files changed, 35 insertions(+), 45 deletions(-)
 delete mode 100644 lib/nodemask.c

-- 
2.34.1

