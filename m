Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D534507997
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 21:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355574AbiDSTBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 15:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbiDSTBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 15:01:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FEC33EF35
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650394745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1Xn3VBNfqVoZpqlEAv8Lt1eOjrtvSt1OpgR+GTkFimg=;
        b=NJ24ueH+KERf/ekTh7Q0aCRbDALtmWdTPBc/W8TkHLLVReh2QNvG8neOit7vu0zSUuozaf
        unkMGQwY84yXaPFwJhKvdB0aep5anZ13Ufe8VcVfiKEU9b4541E3YZQ+1MKkmbRkABXg/+
        bMj0NoPF9YNeHesKI0pJyEn6G++06eE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-vkUjr2fJOkaznqu2sMRH9Q-1; Tue, 19 Apr 2022 14:59:04 -0400
X-MC-Unique: vkUjr2fJOkaznqu2sMRH9Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFEAD804199;
        Tue, 19 Apr 2022 18:59:03 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E94157232E;
        Tue, 19 Apr 2022 18:59:00 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH v2 0/4] KVM: s390: selftests: Provide TAP output in tests
Date:   Tue, 19 Apr 2022 20:58:53 +0200
Message-Id: <20220419185857.128351-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is motivated by Shuah's suggestion here:

 https://lore.kernel.org/kvm/d576d8f7-980f-3bc6-87ad-5a6ae45609b8@linuxfoundation.org/

Many s390x KVM selftests do not output any information about which
tests have been run, so it's hard to say whether a test binary
contains a certain sub-test or not. To improve this situation let's
add some TAP output via the kselftest.h interface to these tests,
so that it easier to understand what has been executed or not.

v2:
 - Reworked the extension checking in the first patch
 - Make sure to always print the TAP 13 header in the second patch
 - Reworked the SKIP printing in the third patch

Thomas Huth (4):
  KVM: s390: selftests: Use TAP interface in the memop test
  KVM: s390: selftests: Use TAP interface in the sync_regs test
  KVM: s390: selftests: Use TAP interface in the tprot test
  KVM: s390: selftests: Use TAP interface in the reset test

 tools/testing/selftests/kvm/s390x/memop.c     | 90 +++++++++++++++----
 tools/testing/selftests/kvm/s390x/resets.c    | 38 ++++++--
 .../selftests/kvm/s390x/sync_regs_test.c      | 87 +++++++++++++-----
 tools/testing/selftests/kvm/s390x/tprot.c     | 28 ++++--
 4 files changed, 192 insertions(+), 51 deletions(-)

-- 
2.27.0

