Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95A255CD27
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbiF0N0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbiF0N0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:26:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4F2063D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656336360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=naeqYXHlGAllaeUBiv2eXRj7Ab0soUVGYGMw5VF+feE=;
        b=Hxj0vkRyCE5YuH02QfbsYqhYZ0Z1+yW58IzlY43GCV9b7ahHsp8a9/ptO5UBlOTlS/t3zE
        dxQFQEJuodXBfGDc84CEu4a0t+YVX9OFxMqAzHrT62eG0YB05+vcFXsFDrA0yYPoj7w8+E
        o3Uqn6UGpg5iA77t06MNr85LqpO+TMQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-ms0AQoCiMEW_P8SRgRceKQ-1; Mon, 27 Jun 2022 09:25:57 -0400
X-MC-Unique: ms0AQoCiMEW_P8SRgRceKQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 690A93C11060;
        Mon, 27 Jun 2022 13:25:56 +0000 (UTC)
Received: from [10.22.10.125] (unknown [10.22.10.125])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 742B82166B29;
        Mon, 27 Jun 2022 13:25:55 +0000 (UTC)
Message-ID: <14a3278e-0299-8138-ff73-654d0208bdfa@redhat.com>
Date:   Mon, 27 Jun 2022 09:25:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] x86/paravirt: useless assignment instructions cause
 Unixbench full core performance degradation
Content-Language: en-US
To:     Guo Hui <guohui@uniontech.com>, peterz@infradead.org
Cc:     jgross@suse.com, srivatsa@csail.mit.edu, amakhalov@vmware.com,
        pv-drivers@vmware.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, will@kernel.org, boqun.feng@gmail.com,
        virtualization@lists.linux-foundation.org,
        wangxiaohua@uniontech.com, linux-kernel@vger.kernel.org
References: <f6b68466-968c-4a91-655a-23970280a072@redhat.com>
 <20220627021350.25714-1-guohui@uniontech.com>
 <e57ab7f6-09e0-9189-8b08-4d68be76f518@redhat.com>
 <62b94621.1c69fb81.3a378.57ccSMTPIN_ADDED_BROKEN@mx.google.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <62b94621.1c69fb81.3a378.57ccSMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/22 01:54, Guo Hui wrote:
> Thank you very much Longman, my patch is as you said, only disable 
> node_cpu on X86, enable node_cpu on arm64, powerpc, s390 architectures;
> the code is in file arch/x86/kernel/paravirt-spinlocks.c:
>     DECLARE_STATIC_KEY_FALSE(preemted_key);
>     static_branch_enable(&preemted_key);
>
> the default value of preemted_key is false and the if conditional 
> statement is reversed,
> the code is in file kernel/locking/osq_lock.c:
>     DEFINE_STATIC_KEY_FALSE(preemted_key);
>
>     static inline int node_cpu(struct optimistic_spin_node *node)
>     {
>         int cpu = 0;
>
>         if (!static_branch_unlikely(&preemted_key))
>             cpu = node->cpu - 1;
>
>         return cpu;
>   }
>
> In this way, only one nop instruction is added to architectures arm64, 
> powerpc and s390, including virtual machines, without any other changes.

You are right. I am probably too tired last night to read the patch more 
carefully.

Cheers,
Longman

