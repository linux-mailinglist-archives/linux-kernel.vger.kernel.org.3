Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CCA54ACA9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242134AbiFNI7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242103AbiFNI7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:59:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61BFA25E81
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655197188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IwpnFeqpjQPPhi0b6JCKQ8hffeOUpqZ7wRTwt/30kI4=;
        b=QX4maYfUKW4wwSjJ8+RIXZW3y0QxvUNzl+D+n/ezKE0SEzX0Fz9qyMVxqygsIeYiCwlkHe
        7zSUhMJwKQR9CllEEjHvEFGBRNLPDpL89wilhhG6+4G8FQnDCkmzOB2w7lABiIZJGNrhgq
        S6md13VCNjJ+HtQrrMoJ48FhNrNaBoA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-446-RPgRlXCcOtWiDZIyFmGO1w-1; Tue, 14 Jun 2022 04:59:39 -0400
X-MC-Unique: RPgRlXCcOtWiDZIyFmGO1w-1
Received: by mail-qk1-f199.google.com with SMTP id bm2-20020a05620a198200b006a5dac37fa2so6975075qkb.16
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=IwpnFeqpjQPPhi0b6JCKQ8hffeOUpqZ7wRTwt/30kI4=;
        b=zE7nBjapdgpm/C+mgsHcYaiwCPAoPX3QvEcjT72EDl/tyfZuZz1jwUoVFop/LMHxPj
         HgI1eRuMvBOvefD8gdGX2DHIoehhsFzY1KGR95fYPhEjuaSJy9uwB4YQNEvuCisC5yd9
         2iUupUdYvOIT3eonFMldAiY6IM0AdXmSy+1Y5ACLWX6COTLUWoF3E/3k6kMIQsAtd2dU
         HGpCtxh9pf5zkAfjjkriMYtuoNCmQkwUXPvQrrV++3cKkf9GldFT1dMC4Rm4XmRB5AGy
         w6vxXEvibqGUJANx74kWD0PxsVqZOxfK2wDGg3brI0E0TPXbAJxfULqrncTa6AxPNpCj
         cW+Q==
X-Gm-Message-State: AOAM532FPjLeliqrmYCQTKCf0tF23atZHMTg2UAUb9wywnC8BAf0vB9P
        FF/HEnetn5WNrF+B7zEsK8/PHxAerFAyCvPuVXZ5G4Bxcru2ZUwZ1IB4n6cGXLR8/5lbaaTNJdG
        Y4DZWky1k+3UlcIugJmXYX4eW
X-Received: by 2002:a05:620a:1094:b0:6a7:1861:66e7 with SMTP id g20-20020a05620a109400b006a7186166e7mr3049290qkk.323.1655197179446;
        Tue, 14 Jun 2022 01:59:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyc/79DVoJuW2vdiVgQb+wK/7pfp+CMdc4B6TqbLHAn5s1EiYdEl+m3b7Q0MbmEaN07zu+uQ==
X-Received: by 2002:a05:620a:1094:b0:6a7:1861:66e7 with SMTP id g20-20020a05620a109400b006a7186166e7mr3049287qkk.323.1655197179157;
        Tue, 14 Jun 2022 01:59:39 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-113-202.dyn.eolo.it. [146.241.113.202])
        by smtp.gmail.com with ESMTPSA id f19-20020a05620a409300b006a6278a2b31sm9311562qko.75.2022.06.14.01.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 01:59:38 -0700 (PDT)
Message-ID: <cdcd1de63ff8fd6ce5fb23f38669ee9092ceb45a.camel@redhat.com>
Subject: Re: [PATCH net v4] net: ax25: Fix deadlock caused by
 skb_recv_datagram in ax25_recvmsg
From:   Paolo Abeni <pabeni@redhat.com>
To:     Duoming Zhou <duoming@zju.edu.cn>, linux-kernel@vger.kernel.org
Cc:     jreuter@yaina.de, ralf@linux-mips.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
        linux-hams@vger.kernel.org, thomas@osterried.de
Date:   Tue, 14 Jun 2022 10:59:35 +0200
In-Reply-To: <20220610123319.32118-1-duoming@zju.edu.cn>
References: <20220610123319.32118-1-duoming@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-06-10 at 20:33 +0800, Duoming Zhou wrote:
> The skb_recv_datagram() in ax25_recvmsg() will hold lock_sock
> and block until it receives a packet from the remote. If the client
> doesn`t connect to server and calls read() directly, it will not
> receive any packets forever. As a result, the deadlock will happen.
> 
> The fail log caused by deadlock is shown below:
> 
> [  369.606973] INFO: task ax25_deadlock:157 blocked for more than 245 seconds.
> [  369.608919] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  369.613058] Call Trace:
> [  369.613315]  <TASK>
> [  369.614072]  __schedule+0x2f9/0xb20
> [  369.615029]  schedule+0x49/0xb0
> [  369.615734]  __lock_sock+0x92/0x100
> [  369.616763]  ? destroy_sched_domains_rcu+0x20/0x20
> [  369.617941]  lock_sock_nested+0x6e/0x70
> [  369.618809]  ax25_bind+0xaa/0x210
> [  369.619736]  __sys_bind+0xca/0xf0
> [  369.620039]  ? do_futex+0xae/0x1b0
> [  369.620387]  ? __x64_sys_futex+0x7c/0x1c0
> [  369.620601]  ? fpregs_assert_state_consistent+0x19/0x40
> [  369.620613]  __x64_sys_bind+0x11/0x20
> [  369.621791]  do_syscall_64+0x3b/0x90
> [  369.622423]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [  369.623319] RIP: 0033:0x7f43c8aa8af7
> [  369.624301] RSP: 002b:00007f43c8197ef8 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
> [  369.625756] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f43c8aa8af7
> [  369.626724] RDX: 0000000000000010 RSI: 000055768e2021d0 RDI: 0000000000000005
> [  369.628569] RBP: 00007f43c8197f00 R08: 0000000000000011 R09: 00007f43c8198700
> [  369.630208] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff845e6afe
> [  369.632240] R13: 00007fff845e6aff R14: 00007f43c8197fc0 R15: 00007f43c8198700
> 
> This patch replaces skb_recv_datagram() with an open-coded variant of it
> releasing the socket lock before the __skb_wait_for_more_packets() call
> and re-acquiring it after such call in order that other functions that
> need socket lock could be executed.
> 
> what's more, the socket lock will be released only when recvmsg() will
> block and that should produce nicer overall behavior.
> 
> Fixes: 40d0a923f55a ("Implement locking of internal data for NET/ROM and ROSE.")

The correct tag is actually: 

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

We don't pick hashes from historicaly repository, as they would confuse
most/all users. Please re-post with the correct tag. Note that you can
check patchwork yourself for this kind of formal errors.

The patch LGTM, when you repost you can append:

Acked-by: Paolo Abeni <pabeni@redhat.com>

Thanks,

Paolo

