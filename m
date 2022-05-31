Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8DA5395A4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 19:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346697AbiEaRy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 13:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346709AbiEaRyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 13:54:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE13678EF9
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 10:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654019692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4CTeMGpnmFy2AIcAqh2t9B9146mxAOy+N2664s7TYyY=;
        b=XI7c1iLyTcOYrLM2rtbY7Q2k8K/Xg4PuZby66QQurqVYVHS+kvy649zFiqWo0IZjQgdcX6
        xmJA0pCmjyfztqUMzXS4LUx21JVTWmJ4veji+B6DzPYv3KroHq1MkdjRjyn+oYra4fr3ab
        M/1l9ixwQbTmC3+vSovbl8q4J4pvH0Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-6_ISWZgJPdiQ6_sMLGiveA-1; Tue, 31 May 2022 13:54:51 -0400
X-MC-Unique: 6_ISWZgJPdiQ6_sMLGiveA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0C02801E80;
        Tue, 31 May 2022 17:54:50 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C3C07C15E72;
        Tue, 31 May 2022 17:54:50 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     likexu@tencent.com
Subject: [PATCH 0/2] KVM: vmx, pmu: respect KVM_GET_MSR_INDEX_LIST/KVM_SET_MSR contracts
Date:   Tue, 31 May 2022 13:54:48 -0400
Message-Id: <20220531175450.295552-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whenever an MSR is part of KVM_GET_MSR_INDEX_LIST, it has to be always
settable with KVM_SET_MSR.  Right now MSR_IA32_DS_AREA, MSR_ARCH_LBR_DEPTH
and MSR_ARCH_LBR_CTL are not fulfilling this, resulting in selftests
failures on <=Skylake processors.

Fix this, and in general allow host-initiated writes of a default
value for all PMU MSRs

Paolo Bonzini (2):
  KVM: vmx, pmu: accept 0 for absent MSRs when host-initiated
  KVM: x86: always allow host-initiated writes to PMU MSRs

 arch/x86/kvm/pmu.c           |  4 ++--
 arch/x86/kvm/pmu.h           |  4 ++--
 arch/x86/kvm/svm/pmu.c       |  2 +-
 arch/x86/kvm/vmx/pmu_intel.c | 42 +++++++++++++++++++++++++-----------
 arch/x86/kvm/x86.c           | 10 ++++-----
 5 files changed, 39 insertions(+), 23 deletions(-)

-- 
2.31.1

