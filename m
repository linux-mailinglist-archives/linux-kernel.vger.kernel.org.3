Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3532352153E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241736AbiEJM15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241260AbiEJM1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:27:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DA5921E41F
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652185437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=7m17XESO0G49jDg02rMzQLZSx70dw+GOL5ZFcuicuDo=;
        b=TBBLy/alubZ89OqlFfHTKaoMvRccKoY7J9H9itFODM3llr8WVpAJyg7XWWEKf+f+xu427D
        jBlcgLyJbTYvUxBaBeaiLPBka7j2CwOKMa0A5loUBl1WPkJUgOqb/HmXYUUKAGfu2gzt+R
        0Rx4tdOmV1GqxEczDMmXynTU5LhgtQU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-ojv1mJgJOg-9cGrwZo1dbg-1; Tue, 10 May 2022 08:23:56 -0400
X-MC-Unique: ojv1mJgJOg-9cGrwZo1dbg-1
Received: by mail-wr1-f71.google.com with SMTP id s14-20020adfa28e000000b0020ac7532f08so6960045wra.15
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=7m17XESO0G49jDg02rMzQLZSx70dw+GOL5ZFcuicuDo=;
        b=r3bVWn8yudfFToRxMrafZjgyzW51vNS0XGxJMw19NS7J4FSOv3r4iq2TLoE70gYzGs
         F2nZhOZz12idChSI0INBlrkMEGYkqHTje7aH2hsgHrmDJjmHyxrChC7W9QjvQ9OnypDR
         XHSNTSVqKKuEzUip9XvBLlwgVkqfbK7wp1o/Gj63fqK0VU5eEkcGRLAHlU4JrHLGT3LR
         4MUTsUMsL7uCE2oGhVcEdl29GEG6x6rLG9cxt7CuViK7vi23Tvfps5pPGBOs6jkjmxWr
         J/zFqEtBV9RtKyL+BDD3Sg1G7WqrXa8TIza5mPUS/XISXWXhaRJvOAGv7vVuPIXERMzo
         092g==
X-Gm-Message-State: AOAM530TXKpvA//nul65YeCD2/tOYE/8t6kKMiqlPIvvs+FhIIYEh8tj
        NPHk41UwJzkjBFsJlRCbcozNmmDOifXZUDP0UIgAEGuLz2uhuikIkvPUXF2PcHZmd7cFcwoyAf+
        q27hxUwHudzsToNxUm7scFQRQ
X-Received: by 2002:a05:600c:1552:b0:394:52a9:e48a with SMTP id f18-20020a05600c155200b0039452a9e48amr27849863wmg.45.1652185434970;
        Tue, 10 May 2022 05:23:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsBADRFdiPYDIntIzaGZobSQWMrIRqRIfrtkXtgAgFq5t+PGvub34r/lKVUbvjx0CiBVRltA==
X-Received: by 2002:a05:600c:1552:b0:394:52a9:e48a with SMTP id f18-20020a05600c155200b0039452a9e48amr27849841wmg.45.1652185434656;
        Tue, 10 May 2022 05:23:54 -0700 (PDT)
Received: from redhat.com ([2.55.130.230])
        by smtp.gmail.com with ESMTPSA id n21-20020a1c7215000000b0039489e1bbd6sm2373609wmc.47.2022.05.10.05.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 05:23:54 -0700 (PDT)
Date:   Tue, 10 May 2022 08:23:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        mie@igel.co.jp, mst@redhat.com
Subject: [GIT PULL] virtio: last minute fixup
Message-ID: <20220510082351-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1c80cf031e0204fde471558ee40183695773ce13:

  vdpa: mlx5: synchronize driver status with CVQ (2022-03-30 04:18:14 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 7ff960a6fe399fdcbca6159063684671ae57eee9:

  virtio: fix virtio transitional ids (2022-05-10 07:22:28 -0400)

----------------------------------------------------------------
virtio: last minute fixup

A last minute fixup of the transitional ID numbers.
Important to get these right - if users start to depend on the
wrong ones they are very hard to fix.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Shunsuke Mie (1):
      virtio: fix virtio transitional ids

 include/uapi/linux/virtio_ids.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

