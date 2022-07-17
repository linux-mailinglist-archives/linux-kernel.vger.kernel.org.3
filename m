Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AD35773B2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 05:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbiGQD1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 23:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiGQD1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 23:27:37 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3FA14D20;
        Sat, 16 Jul 2022 20:27:36 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id j12so6325338plj.8;
        Sat, 16 Jul 2022 20:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=NBRPKTA2TVmxc9QPQeqKJ56d/+3FAMBPvBKl+2Xs87o=;
        b=aeXw4SZLmPAh+BWFYg7vSBTNkt+8maz/6V3+YAO+hcXWkEOJjpRfQJ3Q0juzXIuajq
         YD5nxyfB2HWlT4KxcYITS+Rg5HA6Qbj77YlkF2CF9+r2+fGBMQKXi0/YtHI69fKsjCJE
         0KiqAmash26aKDdg6NOltfT19D69Vl9ncSJviqoFAHsvuG1tSXx7aHSQfhJbDSSmfaoE
         gcX5sJgXry1gg6nlX/UJ6vuVjFT+pArs+WoybBE//rJhCPZK4X+Q807yujgtwQ7hrx/4
         SU8KNOC6StbEMkUWPRVACPWEcTP16gJfqzDdLq3LYZCBAiBK3wwuxpS91qFXsHleBZ1o
         KzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=NBRPKTA2TVmxc9QPQeqKJ56d/+3FAMBPvBKl+2Xs87o=;
        b=atgnSk3BE+TU+nbE4FDsayiVomWRW254a5o2dq1ZfPVDEaJ4srrx0y6YDLx7oEZ3GR
         Pq7C7S+sAzHpTJ9V3mU9254DqYH9twhPLcugqF+Cnjv+zzPOwgLN8wi1VYMQfg2Ef9n4
         Hze6J/K4Ppn64EL3aBtjvdFkKR4z+3njwvUAsYGWhnKFB7oBshqMxiUUU0bUzL9nGaxq
         b9PC5+OFXx3Fn1HGz0u3o8em680pLZbU2/7JUnyyz1S+QtHRqq4UKyaIh9Wn4oj2FI+5
         kUInSpCM4E9VsETdvUwQmPR1P2YVb9v3khJr0iD+taZpfp8TvzcE4q/hdUoWHh33Vrzj
         BVEA==
X-Gm-Message-State: AJIora/9G8wcUl1HcsLQMFNrMcvvVGHT4yHGjIJUDYn54GjLgXkRgcpY
        22iIKBNgbwno1rDIway2JxudkmaLaXI=
X-Google-Smtp-Source: AGRyM1uDCrblu7+K6IRjnfP1hNo16ztJa/KIdjyX64EOFy+HLILXk7X3BywAviUKC4BK9zFOCDJj+A==
X-Received: by 2002:a17:90b:3811:b0:1ef:d704:24cf with SMTP id mq17-20020a17090b381100b001efd70424cfmr24460035pjb.14.1658028455563;
        Sat, 16 Jul 2022 20:27:35 -0700 (PDT)
Received: from debian.me (subs09a-223-255-225-66.three.co.id. [223.255.225.66])
        by smtp.gmail.com with ESMTPSA id k6-20020aa79986000000b00528c22038f5sm6833189pfh.14.2022.07.16.20.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 20:27:35 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 5E20F10008F; Sun, 17 Jul 2022 10:27:30 +0700 (WIB)
Date:   Sun, 17 Jul 2022 10:27:30 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-next@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: next-20220715 build fail due to 579b9239c1f386 (powerpc,
 ps3_defconfig, GCC 12.1.0)
Message-ID: <YtOBoh6MEtJmJ+g5@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I built next-20220715 tree, using powerpc64-unknown-linux-gnu-gcc
(GCC 12.1.0) and ps3_defconfig. The build errored on W=1 build
(-Werror=missing-prototypes):

  CC      arch/powerpc/mm/book3s64/pgtable.o
  CC      arch/powerpc/kernel/process.o
arch/powerpc/mm/book3s64/pgtable.c:478:5: error: no previous prototype for 'pmd_move_must_withdraw' [-Werror=missing-prototypes]
  478 | int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
      |     ^~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

The errored line is introduced by commit 579b9239c1f386 ("powerpc/radix: Fix
kernel crash with mremap()")

Looking at the commit, it seems like GCC didn't see the prototype which had
already been given, or am I missing something?

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
