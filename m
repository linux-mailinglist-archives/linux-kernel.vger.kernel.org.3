Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03784FF8C1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbiDMOTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbiDMOTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:19:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5921606D2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649859404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CP0hKdNBKFA3C6vNpQyMC9BfObsY0/nex9TqHmZbQhw=;
        b=OzV3hlmHct3OHFWaeJa7jpXtek+bQ84Q1vtmTQrPgK/JVpRNbfkp9jrMFFF8LzXuEeWrtw
        pWiNVKMIVux1FDTZ0PqmQL9aAeN6kDcM5PLSmEB/tpl49L3q4IRBD5KBHHJmlWugHzF172
        AYaPAVaNfpekMNHUcSVDaM1EwpcDKSA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-_MI3sLHiNyq4HSXbyiFXuw-1; Wed, 13 Apr 2022 10:16:40 -0400
X-MC-Unique: _MI3sLHiNyq4HSXbyiFXuw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3EB2086B8A1;
        Wed, 13 Apr 2022 14:16:39 +0000 (UTC)
Received: from rules.brq.redhat.com (unknown [10.40.208.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E77339E63;
        Wed, 13 Apr 2022 14:16:33 +0000 (UTC)
From:   Vladis Dronov <vdronov@redhat.com>
To:     vdronov@redhat.com, Sunil Goutham <sgoutham@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Joseph Longever <jlongever@marvell.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] hwrng: cn10k - Optimize random number generator driver
Date:   Wed, 13 Apr 2022 16:16:04 +0200
Message-Id: <20220413141606.8261-1-vdronov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm suggesting couple of tweaks and fixes for the CN10K Random Number Generator
driver. Main points are: fix a logic, optimize a loop and make an error message
more informative.

Vladis Dronov (2):
  hwrng: cn10k - Optimize cn10k_rng_read()
  hwrng: cn10k - Make check_rng_health() return an error code

 drivers/char/hw_random/cn10k-rng.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

