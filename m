Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04434D1B06
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 15:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347648AbiCHOyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 09:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbiCHOyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:54:20 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AFC1276D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 06:53:22 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id h13so12676022ede.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 06:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=XoO8zLUTv+cM6BwEk+1Jo0X1DFvUiXaxYAUtrqwgI4U=;
        b=AZvpWPgbJyvXhvAQNiuMdtLVy/K8nTmV+CiW76oTtPW5n4tWR2OIljpmgscrugyv2I
         UL6ao2ozUI9lrBo/+vTmwZVWJAKzfmkrbAzwAmz7hIsLTZ4+3FMRCiJ+Pbe8uYtOcPk6
         wX5tva+WDKmZMjsRM67WP/G17V53WgFV4Pt8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=XoO8zLUTv+cM6BwEk+1Jo0X1DFvUiXaxYAUtrqwgI4U=;
        b=326QTtnhhjRlOe9HmvNsa13m1TERQ6aueKKAX1MG8n6Q8LQv6sMHrzzSOPm8WlAD9F
         I3d5wJ58Veq8jIzi34YaJEavdAUqbfk8G4PdEuSfKOoFd0glyZSPHqvLHcDbqbpHl5Rz
         +WQH0TLn1ygVi1jkrbMTl0yWKtww+kRefEIu5dCTU4Ak3ZHrG+xRhLRA+IGBLBFvhk1C
         GqMSGiNnI08qMNZ0JxShu4m4INejmb1E75gDsGcfdgiz9V10oDYIUhIk/R8tHbxjf6gz
         F2CvmdSJLkOcbkUOo64LvWNVpd3elkNAjjPlLboK4upDk1KT5Mpt1R8Xz1OLqnaP2WGu
         bhUQ==
X-Gm-Message-State: AOAM533gsCNiXYUYUiy5qIjOZNgeBd/9lXIJxhLF21jLWEP1Dni36Cgx
        wSNENUzMEgzE6WFiJpWfPaRKPB/1Az0R4w==
X-Google-Smtp-Source: ABdhPJz8LnWuSkpe+EPUTLsS2xcxj+A3WdKibZ3AUchF7ce3n523bn5mXkoGmvq4RRql0CqDEFr9sg==
X-Received: by 2002:a50:d498:0:b0:416:2b00:532 with SMTP id s24-20020a50d498000000b004162b000532mr14816924edi.396.1646751200751;
        Tue, 08 Mar 2022 06:53:20 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-178-48-189-3.catv.fixed.vodafone.hu. [178.48.189.3])
        by smtp.gmail.com with ESMTPSA id h20-20020a1709060f5400b006d6d54b9203sm5931349ejj.38.2022.03.08.06.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 06:53:19 -0800 (PST)
Date:   Tue, 8 Mar 2022 15:53:17 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse fixes for 5.17-rc8
Message-ID: <Yidt3VEGFzuZwe1g@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.17-rc8

- Fix an issue with splice on the fuse device

- Fix a regression in the fileattr API conversion

- Add a small userspace API improvement

Thanks,
Miklos

----------------------------------------------------------------
Jeff Layton (1):
      fuse: move FUSE_SUPER_MAGIC definition to magic.h

Miklos Szeredi (2):
      fuse: fix fileattr op failure
      fuse: fix pipe buffer lifetime for direct_io

---
 fs/fuse/dev.c              | 12 +++++++++++-
 fs/fuse/file.c             |  1 +
 fs/fuse/fuse_i.h           |  1 +
 fs/fuse/inode.c            |  3 +--
 fs/fuse/ioctl.c            |  9 ++++++---
 include/uapi/linux/magic.h |  1 +
 6 files changed, 21 insertions(+), 6 deletions(-)
