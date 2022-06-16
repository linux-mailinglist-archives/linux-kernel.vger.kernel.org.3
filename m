Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE86254DFF1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 13:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376787AbiFPLY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 07:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiFPLYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 07:24:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C185C5251E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 04:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655378693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YNFibKj3gf/eijxgCi7qw0c7bBrSPK5mswMMdYMTenE=;
        b=DBB80WcUCSNfjl87q5KnG18DBB0/Kg1oIvWF3/y4yfazl1FvUKv9/v2ZHwxQqma96HumqS
        ka8RVkePo+vGTqNlg/5NgVO9n9a8vutbeTZTCBCBclZcYYO2Lqt9ZSYthT74jtnZqinPqj
        PJHXnZCU097Upe0uyh7YDet/ZbjJ70g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-r82OFgTuOuWWwMFtiqJihg-1; Thu, 16 Jun 2022 07:24:52 -0400
X-MC-Unique: r82OFgTuOuWWwMFtiqJihg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0AF5C95B48A;
        Thu, 16 Jun 2022 11:24:52 +0000 (UTC)
Received: from pick.home.annexia.org (unknown [10.39.192.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95D3F1121314;
        Thu, 16 Jun 2022 11:24:50 +0000 (UTC)
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     josef@toxicpanda.com
Cc:     axboe@kernel.dk, prasanna.kalever@redhat.com, xiubli@redhat.com,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        eblake@redhat.com
Subject: [PATCH] nbd: Permit nbd-client to set minimum and optimal I/O sizes
Date:   Thu, 16 Jun 2022 12:24:48 +0100
Message-Id: <20220616112449.3222664-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a small change to the nbd kernel driver which allows the
client to set minimum_io_size and optimal_io_size hints for the NBD
device.

There is an accompanying patch for nbd-client (userspace tool) which I
will send separately.

Rich.


