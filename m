Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F81052A9F5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345143AbiEQSFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351895AbiEQSF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:05:26 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F67251582
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:04:31 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id p189so10866511wmp.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=EKSmnvJVRKuNiorxmh6RKpW9+C+oBWZuirhwngUpiFA=;
        b=d8XJLJsZpEXABv6ZORuvVlkZV/eZ0n5QWvVfV1Il8MFmUInxoYkMl3Kmq2wMRGnu/Y
         tGbJqIujPWUGCNgZ/tqGy1+5cJlA7oXSk+0oDV1jG1oZ7o9gkyVG9ATGIB0RjMTRhhL3
         OB76y7+GsffV/CyOU75jAwBwYjMFeWYOacizhtdmid6sisM4pzfceqYcyTq1aNYQkZ42
         XcUOTZerZ4FvdaSvcQx0+uErEOW1VaA0Js5mUP10jFw0gcH5pu2DuTZ4HlBZo/OWP7lq
         bUhyWznZSNRpzW/t/T6xXZf95iBXy/9wwFuCzKZcv/KtEhRZzwvHKypq/MhU7fck63m3
         Gdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EKSmnvJVRKuNiorxmh6RKpW9+C+oBWZuirhwngUpiFA=;
        b=2blnNmERAldlNgAf/dEtDb7YHJQOPDWqzmIMRhdK82Ld0IA1h3W0FfEco7ZdwMzbzc
         LfzzQM4dfm3+zeRUn75nP49DutBqkziMBG8+qyH8SQQD9xKjkifcJmrzX79qrNSLXtZ3
         nX3XhWP75qtWKxSmp17ZOhuhHHkgaejyCMfBHvwYHXxJhwWuYuCXx41eFizTxoBLiST6
         oan6lKFw8zjwKmFFbS8kQqJiWJpd/T8oFVbOnDiVDsLLS+Fr5oT1oe5kGnCGYxFTPdq6
         N0hyu6hEF12JNCv1Pn1sK2tf/XPTYQ586f8+L7v03mi3jzLE+ZDBvaOcsa77XPdkfZXD
         nprg==
X-Gm-Message-State: AOAM533B4OGkm0QIJOCqrPkvtyu0TsvkoSCUh30VmSgG9lmeKN6TBYqG
        wknBrswu16vM67BdEDk16Ym6JWGleJk=
X-Google-Smtp-Source: ABdhPJxvO8aJltdNydOcbp7B8L4owevPlqnxSW+KqTPFcqROlQBAyvV0Gb48z5sSt/DmKwKj8j4PqQ==
X-Received: by 2002:a05:600c:3caa:b0:394:8fb8:716 with SMTP id bg42-20020a05600c3caa00b003948fb80716mr32758904wmb.105.1652810670151;
        Tue, 17 May 2022 11:04:30 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id c3-20020adfc6c3000000b0020c5253d8dasm12978625wrh.38.2022.05.17.11.04.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 May 2022 11:04:29 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>
Subject: [RFC PATCH 0/2] Ability to allocate DMAable pages using unpopulated-alloc 
Date:   Tue, 17 May 2022 21:04:16 +0300
Message-Id: <1652810658-27810-1-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Hello all.

The purpose of this RFC patch series is to get feedback about supporting the allocation
of DMAable pages by Linux's unpopulated-alloc.

The unpopulated-alloc feature has been enabled on Arm since the extended-regions support
reached upstream. With that (if, of course, we run new Xen version and Xen was able to
allocate extended regions), we don't allocate the real RAM pages from host memory and balloon
them out (in order to obtain physical memory space to map the guest pages into) anymore, we use
the unpopulated pages instead. And it seems that all users I have played with on Arm (I mean,
Xen PV and virtio backends) are happy with the pages provided by xen_alloc_unpopulated_pages().
It is worth mentioning that these pages are not contiguous, but this wasn't an issue so far.

There is one place, where we still steal RAM pages if user-space Xen PV backend tries
to establish grant mapping with a need to be backed by a DMA buffer for the sake of zero-copy
(see dma_alloc*() usage in gnttab_dma_alloc_pages()).

And, if I am not mistaken (there might be pitfalls which I am not aware of), we could avoid
wasting real RAM pages in that particular case also by adding an ability to allocate
unpopulated DMAable pages (which are guaranteed to be contiguous in IPA).
The benefit is quite clear here:
1. Avoid wasting real RAM pages (reducing the amount of CMA memory usable) for allocating
   physical memory space to map the granted buffer into (which can be big enough if
   we deal with Xen PV Display driver using multiple Full HD buffers) 
2. Avoid superpage shattering in Xen P2M when establishing stage-2 mapping for that
   granted buffer
3. Avoid extra operations needed for the granted buffer to be properly mapped and
   unmapped such as ballooning in/out real RAM pages

Please note, there are several TODOs (described in corresponding commit subjects),
which I will try to eliminate in next versions if we find a common ground regarding
the approach.

Any feedback/help would be highly appreciated.

Oleksandr Tyshchenko (2):
  xen/unpopulated-alloc: Introduce helpers for DMA allocations
  xen/grant-table: Use unpopulated DMAable pages instead of real RAM
    ones

 drivers/xen/grant-table.c       |  27 +++++++
 drivers/xen/unpopulated-alloc.c | 167 ++++++++++++++++++++++++++++++++++++++++
 include/xen/xen.h               |  15 ++++
 3 files changed, 209 insertions(+)

-- 
2.7.4

