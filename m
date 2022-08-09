Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11DA58D3A6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 08:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236842AbiHIGU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 02:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236727AbiHIGU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 02:20:26 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECDB1EEC1
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 23:20:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=guorui.yu@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VLommuG_1660026017;
Received: from 30.227.65.6(mailfrom:GuoRui.Yu@linux.alibaba.com fp:SMTPD_---0VLommuG_1660026017)
          by smtp.aliyun-inc.com;
          Tue, 09 Aug 2022 14:20:18 +0800
Message-ID: <a69faebb-11e8-b386-d591-dbd08330b008@linux.alibaba.com>
Date:   Tue, 9 Aug 2022 14:20:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
To:     dave.hansen@intel.com
Cc:     ak@linux.intel.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, isaku.yamahata@gmail.com, jun.nakajima@intel.com,
        kai.huang@intel.com, khalid.elmously@canonical.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        marcelo.cerri@canonical.com, mingo@redhat.com,
        philip.cox@canonical.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, tglx@linutronix.de,
        tim.gardner@canonical.com, tony.luck@intel.com, wander@redhat.com,
        x86@kernel.org
References: <7c09d15b-40bc-c6a0-3282-a94e9d9c36be@intel.com>
Subject: Re: [PATCH v8 5/5] x86/tdx: Add Quote generation support
From:   Guorui Yu <GuoRui.Yu@linux.alibaba.com>
In-Reply-To: <7c09d15b-40bc-c6a0-3282-a94e9d9c36be@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To my opinion, virtio-vsock is a wonderful way to achieve the 
comunication between the host and the guest under traditional scenario.

But from secuirty perspective, virtio-vsock itself may involve too much 
of components, which may lead to considerable attack surfaces. In order 
for virtio to work properly, the guest must maintain several vrings 
placed in shared memory, which in turn depends on swiotlb in current 
codebase. As this flow is NOT designed for confidential scenario, there 
are some on-going/existing works on virtio hardening [1] [2] [3].

 > Do we *REALLY* need specific driver functionality for this?  For
 > instance, is there no existing virtio device that can send blobs back
 > and forth?

And we may indeed have use cases where virtio is not used at all, such 
as when we consider Intel-TDX/AMD-SNP protected VMs as a SGX enclave 
replacement. In such use cases, end users may expect a smaller 
dependency on the GetQuote interface. It doesn't seem natural that the 
GetQuote interface cannot be used because virtio-vsock is disabled (via 
kernel compile options or the upcoming device-filter), since GetQuote 
doesn't inherently depend on it.

Thanks,
Guorui

[1] 
https://lore.kernel.org/lkml/20210603004133.4079390-1-ak@linux.intel.com/
[2] https://lore.kernel.org/lkml/20211012065227.9953-1-jasowang@redhat.com/
[3] 
https://lore.kernel.org/linux-iommu/d2ae0b1d-332b-42a1-87bf-7da2b749cac2@sect.tu-berlin.de/
