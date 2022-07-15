Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B40576090
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 13:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbiGOLd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 07:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiGOLdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 07:33:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 084D513E0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 04:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657884831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rQi4pNFFtGsmo7OJ1+D/r9WOH6atgY6YVCw1qpLS0HE=;
        b=DFqbnCvJR53sQeXNmXEC3qGDTkHhyjG1HFu5Q5lckC1qLFI5+s+eliN7hOAqJxu0pYpr8f
        DIJIMIFKNYi1zTYQx5zqbRt6A9y/0c4jaobMaqIDb2jQihXHZQNyUM2l0sz0yVKymi9mpM
        DYV9nOmml2Kyqv/lAZ+L8BrVgbVHFYE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-466-ktlvYmVeMGCp-7eWtuBoVg-1; Fri, 15 Jul 2022 07:33:50 -0400
X-MC-Unique: ktlvYmVeMGCp-7eWtuBoVg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C181B3C0D865;
        Fri, 15 Jul 2022 11:33:49 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.32.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 893482026D64;
        Fri, 15 Jul 2022 11:33:49 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>, ikent@redhat.com,
        oleg@redhat.com
Subject: [PATCH 0/3] pid: replace idr api with xarray
Date:   Fri, 15 Jul 2022 07:33:46 -0400
Message-Id: <20220715113349.831370-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series is a few patches to switch struct pid management over from
the idr api to the xarray api. The underlying data structures are
already the same between both apis, but the idr relies on the old and
slightly customized radix-tree implementation to accomplish things like
efficient free id tracking, which xarray already supports directly.

This is all based on a prototype patch[1] from Willy that fell out from
discussion on a separate series to try and improve /proc readdir
performance using radix-tree tags (to be replaced with xarray marks).
I've basically split it up into a few smaller patches, made some minor
tweaks, and ran some tests on the result.

Willy,

Re: the above, I've included your s-o-b on each of the patches. I'm not
sure what your preference or the proper etiquette is here. Let me know
if you want me to change authorship or tags or whatever in any way..

Brian

[1] https://lore.kernel.org/linux-fsdevel/YqoJ+p83dLOcGfwX@casper.infradead.org/

Brian Foster (3):
  pid: replace pidmap_lock with xarray lock
  pid: split cyclic id allocation cursor from idr
  pid: switch pid_namespace from idr to xarray

 arch/powerpc/platforms/cell/spufs/sched.c |   2 +-
 fs/proc/loadavg.c                         |   2 +-
 include/linux/pid_namespace.h             |   9 +-
 include/linux/threads.h                   |   2 +-
 init/main.c                               |   3 +-
 kernel/pid.c                              | 133 +++++++++++-----------
 kernel/pid_namespace.c                    |  23 ++--
 7 files changed, 85 insertions(+), 89 deletions(-)

-- 
2.35.3

