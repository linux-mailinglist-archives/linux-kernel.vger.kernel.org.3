Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEE24FF859
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbiDMOFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiDMOFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:05:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97D4D58813
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649858566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tAfD3NhN7fayTDj+zqA64IJMnx8ZxzqbVRBoMThFMGA=;
        b=DpXmLyETWnY+UTtNVFfLoDQsbCtlVDvmXpz7H/kcYaiRwRjJ9Ea3VLmbhfnHp/Y8VS13W6
        IndVnyRCksUN7h7EQIMG3T+xDD4Jb6do5FXlxu1Z1nJ6LAVjNgwun5xpjY+KvgWbBbWvnv
        qcDScLvmEAZouIRU85eox+y9+OaHULI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-xzrjdR4XMWORsqlOI_ibHw-1; Wed, 13 Apr 2022 10:02:44 -0400
X-MC-Unique: xzrjdR4XMWORsqlOI_ibHw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D49A129DD987;
        Wed, 13 Apr 2022 14:02:35 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 569B4C28109;
        Wed, 13 Apr 2022 14:02:35 +0000 (UTC)
Message-ID: <06ed6ba2-00c4-ab38-4fcf-611133865615@redhat.com>
Date:   Wed, 13 Apr 2022 10:02:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 00/12] device-core: Enable device_lock() lockdep
 validation
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev
References: <164982968798.684294.15817853329823976469.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <164982968798.684294.15817853329823976469.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/22 02:01, Dan Williams wrote:
> Changes since v1 [1]:
> - Improve the clarity of the cover letter and changelogs of the
>    major patches (Patch2 and Patch12) (Pierre, Kevin, and Dave)
> - Fix device_lock_interruptible() false negative deadlock detection
>    (Kevin)
> - Fix off-by-one error in the device_set_lock_class() enable case (Kevin)
> - Spelling fixes in Patch2 changelog (Pierre)
> - Compilation fixes when both CONFIG_CXL_BUS=n and
>    CONFIG_LIBNVDIMM=n. (0day robot)
>
> [1]: https://lore.kernel.org/all/164610292916.2682974.12924748003366352335.stgit@dwillia2-desk3.amr.corp.intel.com/
>
> ---
>
> The device_lock() is why the lockdep_set_novalidate_class() API exists.
> The lock is taken in too many disparate contexts, and lockdep by design
> assumes that all device_lock() acquisitions are identical. The lack of
> lockdep coverage leads to deadlock scenarios landing upstream. To
> mitigate that problem the lockdep_mutex was added [2].
>
> The lockdep_mutex lets a subsystem mirror device_lock() acquisitions
> without lockdep_set_novalidate_class() to gain some limited lockdep
> coverage. The mirroring approach is limited to taking the device_lock()
> after-the-fact in a subsystem's 'struct bus_type' operations and fails
> to cover device_lock() acquisition in the driver-core. It also can only
> track the needs of one subsystem at a time so, for example the kernel
> needs to be recompiled between CONFIG_PROVE_NVDIMM_LOCKING and
> CONFIG_PROVE_CXL_LOCKING depending on which subsystem is being
> regression tested. Obviously that also means that intra-subsystem
> locking dependencies can not be validated.

Instead of using a fake lockdep_mutex, maybe you can just use a unique 
lockdep key for each subsystem and call lockdep_set_class() in the 
device_initialize() if such key is present or 
lockdep_set_novalidate_class() otherwise. The unique key can be passed 
either as a parameter to device_initialize() or as part of the device 
structure. It is certainly less cumbersome that having a fake 
lockdep_mutex array in the device structure.

Cheers,
Longman

