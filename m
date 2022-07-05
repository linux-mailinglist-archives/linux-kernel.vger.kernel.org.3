Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326D75660D5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 03:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbiGEB5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 21:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiGEB5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 21:57:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FE82101F5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 18:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656986223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0NC/eC1lPxFvKCJBfy26CWHeOBX1P9jbiKqcYaXCqrA=;
        b=DU32cKgJAREXB4FTg6diRVnjKNTpMlP3l7wTvxrxjkuC+jITN/uRlIgtnyg68hjCD+vmVh
        pOPcph0Jjb79cAzwSc/umgvdYZsmmGFND9OskojCR4uc8jmUGNwKKBu4nd6dhPMD3DjO0k
        uiR2qxDu9r0dgduHD52b70MT8HeKf/o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-uRHuuSnmMVexQhT7n8YAwA-1; Mon, 04 Jul 2022 21:57:00 -0400
X-MC-Unique: uRHuuSnmMVexQhT7n8YAwA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32BFA1C05148;
        Tue,  5 Jul 2022 01:57:00 +0000 (UTC)
Received: from localhost (ovpn-13-74.pek2.redhat.com [10.72.13.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 788822166B26;
        Tue,  5 Jul 2022 01:56:59 +0000 (UTC)
Date:   Tue, 5 Jul 2022 09:56:55 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Kaihao Bai <carlo.bai@linux.alibaba.com>
Cc:     ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com
Subject: Re: [PATCH 0/2] kexec: accumulate and release the size of crashkernel
Message-ID: <YsOaZ/IETqnWO2uI@MiWiFi-R3L-srv>
References: <1656934895-12334-1-git-send-email-carlo.bai@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1656934895-12334-1-git-send-email-carlo.bai@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/22 at 07:41pm, Kaihao Bai wrote:
> Currently x86 and arm64 support to reserve low memory range for
> crashkernel. When crashkernel=Y,low is defined, the main kernel would
> reserve another memblock (instead of crashkernel=X,high, which stored
> in crashk_res) for crashkernel and store it in crashk_low_res.
> 
> The implementations of get_crash_size and crash_shrink_size do not
> consider the extra reserved memory range if it exists. Thus, firstly
> accumulate this range on the size of crashkernel and export the size 
> by /sys/kernel/kexec_crash_size.
> 
> If getting the input of /sys/kernel/kexec_crash_size, both reserved ranges
> might be released if the new size is smaller than current size. The order
> of release is (crashk_res -> crashk_low_res). Only if the new size defined
> by the user is smaller than the size of low memory range, continue to 
> release the reserved low memory range after completely releasing the high 
> memory range.

Sorry, I don't like this patchset.

I bet you don't encounter a real problem in your product environment.
Regarding crashkernel=,high|low, the ,low memory is for DMA and
requirement from memory under lower range. The ,high meomry is for
kernel/initrd loading, kernel data, user space program running. When
you configure crashkernel= in your system, you need evaluate what
value is suitable. /sys/kernel/kexec_crash_size is an interface you
can make use of to tune the memory usage. People are not suggested to
free all crashkernel reservation via the interface. 

So, please leave this as is, unless you have a real case where this
change is needed.

Thanks
Baoquan

