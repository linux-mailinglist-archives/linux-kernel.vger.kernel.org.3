Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537AC553137
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 13:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349944AbiFULmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 07:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349870AbiFULmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 07:42:39 -0400
X-Greylist: delayed 1936 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Jun 2022 04:42:36 PDT
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF98DBE19
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 04:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Content-Transfer-Encoding:MIME-Version:Message-Id
        :Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=D6GD7v0OxoQRiN+PLWPk/I3LPeDqLQnzXNY1W/TtwTQ=; b=gZPlPh4bRTWAWM9vsyz7KyFwPl
        ZU9yrDlz4CFhbD36JLeX5/a659POUAmFVCZe+piXKe6F6j0nsYxdX1Mc2UEUX7XNq6YmTBdaVGRua
        /HgJPpEdArS0HD92yeO0ZYehtWRJxTuZuvqn+YlMQMT133b6PMIat7tVzdXw7ifof9YyxyKPp12K8
        9F7ZAaX/t2aU7m7rTDPXHS7iCPaNODfQlsj8RYYuhSKFH/P0IfNPSbf1Ch4t7/5WCq2IapIZs38zL
        yeozHzaIZIpqEJ3tbIK0uR+AAXn2DUpEEAdGVPtrv1568qARjisNNEPtbfT7KbzHRLOImRXJmjOuL
        6ea98NTA==;
Received: from [10.22.3.24] (helo=kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
        id 1o3blo-005hKr-Fd; Tue, 21 Jun 2022 13:10:08 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Subject: [PATCH 0/2] virtio_mmio: Fix suspend to disk (hibernation)
Date:   Tue, 21 Jun 2022 13:06:19 +0200
Message-Id: <20220621110621.3638025-1-stephan.gerhold@kernkonzept.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment suspend to disk (hibernation) works correctly when using
virtio_pci, but not when using virtio_mmio. This is because virtio_mmio
does not call the freeze/restore callbacks provided by most virtio
drivers.

Fix this by adding the missing PM calls to virtio_mmio and restore
the guest page size for the legacy version of virtio_mmio.

Stephan Gerhold (2):
  virtio_mmio: Add missing PM calls to freeze/restore
  virtio_mmio: Restore guest page size on resume

 drivers/virtio/virtio_mmio.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

-- 
2.30.2

