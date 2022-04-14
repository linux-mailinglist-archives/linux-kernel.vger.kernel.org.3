Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E135017B6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359425AbiDNPpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357074AbiDNPZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:25:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F414BF47DF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649948944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=MPkow1+wr5sf4f/3lFwncjcNEF8/q5vpLbYJtsNR8Tg=;
        b=ebtgyX6Acke4kH72s3VFf57DDuxeeNG/lfjAIi+qweAvNFOG7loOq2XPdYFkh8vkqRXOnb
        BXif2ubNQ1xw4pdDsbOofjyYCfYT18uMDuDAcDeMUlt/9xqizu+19sbpHUqTP3vbducMYf
        k0fE2RP5JnskcpCXbn5Bp3txtV+8HZI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-8F_wPC6sNVeyl2ebj3YDyQ-1; Thu, 14 Apr 2022 11:08:59 -0400
X-MC-Unique: 8F_wPC6sNVeyl2ebj3YDyQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6729296A614;
        Thu, 14 Apr 2022 15:08:58 +0000 (UTC)
Received: from turbo.dinechin (unknown [10.39.192.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C9EDC07F51;
        Thu, 14 Apr 2022 15:08:55 +0000 (UTC)
From:   Christophe de Dinechin <dinechin@redhat.com>
To:     trivial@kernel.org
Cc:     Ben Segall <bsegall@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/3] trivial: Fix several compilation errors/warnings with GCC12
Date:   Thu, 14 Apr 2022 17:08:52 +0200
Message-Id: <20220414150855.2407137-1-dinechin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling with GCC 12 using defconfig generates a number of build errors=0D
due to new warnings, notably array-bounds checks. Some of these warnings ap=
pear=0D
legitimate and relatively easy to fix.=0D
=0D
Note that this series is not sufficient for a clean build yet. There are=0D
in particular a number of warnings reported by the array-bounds check=0D
that appear bogus, like:=0D
=0D
| In function =E2=80=98__native_read_cr3=E2=80=99,=0D
|     inlined from =E2=80=98__read_cr3=E2=80=99=0D
|         at ./arch/x86/include/asm/special_insns.h:169:9,=0D
|     inlined from =E2=80=98read_cr3_pa=E2=80=99=0D
|         at ./arch/x86/include/asm/processor.h:252:9,=0D
|     inlined from =E2=80=98relocate_restore_code=E2=80=99=0D
|         at arch/x86/power/hibernate.c:165:17:=0D
| ./arch/x86/include/asm/special_insns.h:48:9: error:=0D
|    array subscript 0 is outside array bounds of =E2=80=98unsigned int[0]=
=E2=80=99=0D
|    [-Werror=3Darray-bounds]=0D
|    48 | asm volatile("mov %%cr3,%0\n\t" : "=3Dr" (val) : __FORCE_ORDER);=
=0D
|       | ^~~=0D
| cc1: all warnings being treated as errors=0D
=0D
The error above is for an instruction that does not obviously address any=0D
C array, in particular since the asm constraint is "=3Dr" and not "=3Drm".=
=0D
=0D
Consequently, the series here only addresses a few low hanging fruits that=
=0D
appear legitimate and relatively easy to fix.=0D
=0D
Christophe de Dinechin (3):=0D
  sched/headers: Fix compilation error with GCC 12=0D
  nodemask.h: Fix compilation error with GCC12=0D
  virtio-pci: Use cpumask_available to fix compilation error=0D
=0D
 drivers/virtio/virtio_pci_common.c |  2 +-=0D
 include/linux/nodemask.h           | 13 ++++++-------=0D
 kernel/sched/sched.h               | 11 +++++++++--=0D
 3 files changed, 16 insertions(+), 10 deletions(-)=0D
=0D
-- =0D
2.35.1=0D
=0D

