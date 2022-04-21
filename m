Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F1650A5B6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiDUQeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390606AbiDUQdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:33:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF2EA42EF0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650558511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=eVfjbYyGjHysMK6Af8/RxkKhPETa0NVn4VTURbils4Y=;
        b=UzR1Q+SIltIwF0w5BeTRgwjPF4sLkQ7y65xHIOk6cqZUSBdlUQZ7cATI+ol/vI0NGw8JcM
        jOG1RJElvoWWZSuV39LIsjnrle6MqBe51i2GcJbAED01EpHtCnAaePsar+NTVKpFGW/HtN
        +5Gk18QC8ZIPFO/dM0o5TCRAEHxly8A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-416-zVVwBhWkP_6KKgZXihp8sQ-1; Thu, 21 Apr 2022 12:28:25 -0400
X-MC-Unique: zVVwBhWkP_6KKgZXihp8sQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 779BC185A7B2;
        Thu, 21 Apr 2022 16:28:25 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 52921145BA53;
        Thu, 21 Apr 2022 16:28:25 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     peterx@redhat.com, seanjc@google.com
Subject: [PATCH 0/2] kvm: selftests: cleanup PTE definitions
Date:   Thu, 21 Apr 2022 12:28:23 -0400
Message-Id: <20220421162825.1412792-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The width of operations on bit fields greater than 32-bit is
implementation defined, and differs between GCC (which uses the bitfield
precision) and clang (which uses 64-bit arithmetic), so this is a
minefield that is already causing bugs (see patch 1).  Remove the bit
fields and using manual masking instead.

Mostly the same as yesterday's patch, but with constants moved to
processor.h and extended to include common idioms such as PAGE_MASK
and PAGE_SIZE.

Paolo

Supersedes: <20220420103624.1143824-1-pbonzini@redhat.com>

Paolo Bonzini (2):
  kvm: selftests: do not use bitfields larger than 32-bits for PTEs
  kvm: selftests: introduce and use more page size-related constants

 .../selftests/kvm/include/x86_64/processor.h  |  17 ++
 .../selftests/kvm/lib/x86_64/processor.c      | 202 +++++++-----------
 tools/testing/selftests/kvm/x86_64/amx_test.c |   1 -
 .../kvm/x86_64/emulator_error_test.c          |   1 -
 tools/testing/selftests/kvm/x86_64/smm_test.c |   2 -
 .../kvm/x86_64/vmx_tsc_adjust_test.c          |   1 -
 .../selftests/kvm/x86_64/xen_shinfo_test.c    |   1 -
 .../selftests/kvm/x86_64/xen_vmcall_test.c    |   1 -
 8 files changed, 99 insertions(+), 127 deletions(-)

-- 
2.31.1

