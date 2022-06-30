Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6F8561D08
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 16:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbiF3OOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 10:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237068AbiF3ONz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 10:13:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0273C419BA
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656597589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LxaOFylJkQ/MdwV5aA3pa1YtRMsbn1Q4ucnowsYMktM=;
        b=DRAhkEY0dSatwJD6dgJpwAtsd8jnPseTOO92u/SXfSOzMOb+LZeWsYPT2LqwhNqDsCYtWY
        OiKz9F5FMkrrYJV3c7i3FaxFMdlNuvgjdVfMbA3CIVIcx6GSqPUxpb2kjji7nYiQ0zb0Kg
        0GC+cKjekqEH0RiyrDWNIYRIqRo72ig=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-m3lxOeKDO0qqQtyjyl8G3A-1; Thu, 30 Jun 2022 09:59:45 -0400
X-MC-Unique: m3lxOeKDO0qqQtyjyl8G3A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8982F1019C83;
        Thu, 30 Jun 2022 13:59:44 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D18018EAD;
        Thu, 30 Jun 2022 13:59:43 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     will@kernel.org
Cc:     peterz@infradead.org, boqun.feng@gmail.com, mark.rutland@arm.com,
        thunder.leizhen@huawei.com, jacob.e.keller@intel.com,
        akpm@linux-foundation.org, linux-sparse@vger.kernel.org,
        cluster-devel@redhat.com, luc.vanoostenryck@gmail.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        aahringo@redhat.com
Subject: [RFC 0/2] refcount: attempt to avoid imbalance warnings
Date:   Thu, 30 Jun 2022 09:59:32 -0400
Message-Id: <20220630135934.1799248-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch tries to avoid some sparse warnings related to
refcount_dec_and_lock() and kref_put_lock().

I send this patch series as RFC because it was necessary to do a kref
change after adding __cond_lock() to refcount_dec_and_lock()
functionality.

For me it looks like we do a lot of acrobatics to avoid sparse warnings
here and I really don't know if it's worth the offer. However this is
what I have now...

- Alex

Alexander Aring (2):
  refcount: add __cond_lock() for conditional lock refcount API
  kref: move kref_put_lock() callback to caller

 include/linux/kref.h     | 24 ++++++++----------------
 include/linux/refcount.h | 21 ++++++++++++++++-----
 lib/refcount.c           | 23 ++++++++++++-----------
 3 files changed, 36 insertions(+), 32 deletions(-)

-- 
2.31.1

