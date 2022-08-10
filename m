Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F7058E97C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 11:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbiHJJWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 05:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiHJJWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:22:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AFAF6B160
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660123356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZyYOF0GqU38qgLQvjOSadjxAJ6Z77rN0GOf9JNRiT94=;
        b=bCEEaHfNAawByGIdyZ9PYd1+i3rv9m7pajxuMWcDLhZj7mW96FPbyc6H1cRz/YMZJofsF0
        cauIbvWZYKS9U5Jazh0+WaEZLvzVGnvGMkigN2euCwR0M1skUy4hlr24BBtu4hNac0GsuF
        Up965eifYt0C/ubeor/P0U/lZHmTvB4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-J9531uqBNTm5SbCyI24uUQ-1; Wed, 10 Aug 2022 05:22:22 -0400
X-MC-Unique: J9531uqBNTm5SbCyI24uUQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0EE008039A2;
        Wed, 10 Aug 2022 09:22:20 +0000 (UTC)
Received: from [10.43.17.48] (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 78D029457F;
        Wed, 10 Aug 2022 09:22:19 +0000 (UTC)
Message-ID: <f0dd80b2-97e1-c320-8517-7ebdb027f58a@redhat.com>
Date:   Wed, 10 Aug 2022 11:22:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: i915: crash with 5.19-rc2
Content-Language: en-US
From:   Zdenek Kabelac <zkabelac@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     intel-gfx@lists.freedesktop.org, chris@chris-wilson.co.uk
References: <584ae788-05e3-5824-8c85-cbb833677850@redhat.com>
In-Reply-To: <584ae788-05e3-5824-8c85-cbb833677850@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 22. 06. 22 v 13:18 Zdenek Kabelac napsal(a):
> Hello
>
> While somewhat oldish hw (T61, 4G, C2D) - I've now witnessed new crash with 
> Xorg:
>
> (happened while reopening iconified Firefox window  - running 'standard' 
> rawhide -nodebug kernel 5.19.0-0.rc2.21.fc37.x86_64)
>

Hello


Ok, I think I now know what is behind this BUG/crash of intel graphics  -  
interestingly it took me a few weeks to realize this.

So I've actually installed with some Rawhide update 'zram-generator' package 
to use  zram swap to help with memory of Firefox & Thunderbird a bit with this 
4G RAM laptop. All worked fine. However side effect of usage of ZRAM swapping 
became actually this occasional  kernel BUG hitting.

When I've stopped using  Zram swap  -  it now runs for 2 weeks without a 
single deadlock - with single or dual screen monitor setup with many suspends 
& resumes in between.

So I'm likely 100% sure that   ZRAM usage is triggering this issue.   While I 
know this laptop is old and likely with low memory and so on - no sure if it's 
worth to solve it - maybe good enough solution is to issue a warning user 
should no comibine this old piece with ZRAM - but I'm all open to do some 
testing for fix - although I still don't have a simple triggering path for 
this issue to happen within short period of time.

Maybe driver is missing tomark some pages as pined into memory so ZRAM can't 
swap them out ?.


>  page:00000000577758b3 refcount:0 mapcount:0 mapping:0000000000000000 
> index:0x1 pfn:0x1192cc
>  flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
>  raw: 0017ffffc0000000 ffffe683c47171c8 ffff8fa3f79377a8 0000000000000000
>  raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
>  page dumped because: VM_BUG_ON_FOLIO(!folio_test_locked(folio))
>  ------------[ cut here ]------------
>  kernel BUG at mm/shmem.c:708!
>  invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>  CPU: 1 PID: 42896 Comm: Xorg Not tainted 5.19.0-0.rc2.21.fc37.x86_64 #1
>  Hardware name: LENOVO 6464CTO/6464CTO, BIOS 7LETC9WW (2.29 ) 03/18/2011
>  RIP: 0010:shmem_add_to_page_cache+0x48e/0x500
>  Code: 01 0f 84 0a fc ff ff 48 8d 4a ff 31 d2 48 39 cb 0f 85 ff fb ff ff e9 
> f6 fb ff ff 48 c7 c6 70 01 64 bb 48 89 df e8 f2 99 01 00 <0f> 0b 48 c7 c6 a0 
> 1b 64 bb 48 89 df e8 e1 99 01 00 0f 0b 48 8b 13
>  RSP: 0018:ffff9ce7c047f6b0 EFLAGS: 00010286
>  RAX: 000000000000003f RBX: ffffe683c464b300 RCX: 0000000000000000
>  RDX: 0000000000000001 RSI: ffffffffbb67b8e8 RDI: 00000000ffffffff
>  RBP: 0000000000023f97 R08: ffffffffbca122a0 R09: 64656b636f6c5f74
>  R10: 747365745f6f696c R11: 6f6621284f494c4f R12: 00000000001120d4
>  R13: ffff8fa2c6ae7890 R14: ffffe683c464b300 R15: 0000000000000001
>  FS:  00007fc1cea31380(0000) GS:ffff8fa3f7900000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007f6972e228c8 CR3: 0000000104ba8000 CR4: 00000000000006e0
>  Call Trace:
>  <TASK>
>  shmem_swapin_folio+0x274/0x980
>  shmem_getpage_gfp+0x234/0x990
>  shmem_read_mapping_page_gfp+0x36/0xf0
>  shmem_sg_alloc_table+0x11b/0x250 [i915]



Regards


Zdenek


