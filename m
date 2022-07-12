Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF093571076
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 04:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiGLCr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 22:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiGLCr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 22:47:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E552B5A2DA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 19:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657594075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=12wGSW3GBIcCSvXMpbrL7TAhlYbxIoDoPrgWaf/PtnE=;
        b=eiR7kZW9n1KT4sSYE28Lgr2t4TGZIjw16Xks+Fw/KMfAeV0JstMX/qxrp6HFCFzmCF2Stm
        ZQdg/CloX4fr4ao3Ut44mWwWOcVOAtEEj75aO3qHv6hhTFhZPhnLG8XCWtllWPqj41WVaN
        farACVJy6anIe26KauRI/vQ0hIQF+h4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-6piqHaa4OMa_kqmEWLGK-w-1; Mon, 11 Jul 2022 22:47:48 -0400
X-MC-Unique: 6piqHaa4OMa_kqmEWLGK-w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5BCF9803520;
        Tue, 12 Jul 2022 02:47:48 +0000 (UTC)
Received: from localhost (ovpn-12-173.pek2.redhat.com [10.72.12.173])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3857240B40C8;
        Tue, 12 Jul 2022 02:47:46 +0000 (UTC)
Date:   Tue, 12 Jul 2022 10:47:43 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     kexec@lists.infradead.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        akpm@linux-foundation.org
Subject: Re: [PATCH v4 0/2] kexec, panic: Making crash_kexec() NMI safe
Message-ID: <Yszgzwnk2Y+4ki58@MiWiFi-R3L-srv>
References: <20220630223258.4144112-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630223258.4144112-1-vschneid@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/30/22 at 11:32pm, Valentin Schneider wrote:
> Hi folks,
> 
> Here's ~v3~ v4 where we now completely get rid of kexec_mutex.
> 
> o Patch 1 makes sure all kexec_mutex acquisitions are trylocks. This prevents
>   having to add any while(atomic_cmpxchg()) loops which I'd really hate to see
>   here. If that can't be done then I think we're better off with the combined
>   mutex+atomic var approach.
> o Patch 2 does the mutex -> atomic var switch.

This series looks good, has it been taken into any tree?

Thanks
Baoquan

> 
> Revisions
> =========
> 
> v3 -> v4
> ++++++++
> 
> o Someone forgot to Cc LKML on v3...
> 
> v2 -> v3
> ++++++++
> 
> o Dropped kexec_mutex entirely and made the atomic variable the one true lock
>   for kexec (Eric)
> 
> v1 -> v2
> ++++++++
> 
> o Changed from Peterson-like synchronization to simpler atomic_cmpxchg
>   (Petr)
> o Slightly reworded changelog
> o Added Fixes: tag. Technically should be up to since kexec can happen
>   in an NMI, but that isn't such a clear target
> 
> Cheers,
> Valentin
> 
> Valentin Schneider (2):
>   kexec: Turn all kexec_mutex acquisitions into trylocks
>   panic, kexec: Make __crash_kexec() NMI safe
> 
>  include/linux/kexec.h   |  2 +-
>  kernel/kexec.c          | 11 ++++-------
>  kernel/kexec_core.c     | 28 ++++++++++++++++------------
>  kernel/kexec_file.c     |  4 ++--
>  kernel/kexec_internal.h | 15 ++++++++++++++-
>  kernel/ksysfs.c         |  7 ++++++-
>  6 files changed, 43 insertions(+), 24 deletions(-)
> 
> --
> 2.31.1
> 

