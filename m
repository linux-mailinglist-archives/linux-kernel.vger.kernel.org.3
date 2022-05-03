Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997AA518AE4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 19:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240197AbiECRU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 13:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240182AbiECRUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 13:20:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B56F1EEC4
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 10:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651598206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SoCHmrpEReTmBMh3qbjSmyUuidlh7Y/bS7wiCUtZZ8w=;
        b=MSFRzD/tSAcyVlh2KGYF0KZT6aacbc89GmySGe3FDCsRRicf8gGdsxN7ZGmQNTxGZrVvBM
        5GbsOtTMsA0QNggIFSU4M8fHD6v76kfBVRszOFPaxCfBvc4MsbOZSIodq7B3b1YY8EUVsQ
        DoD2uXBgZDFwKWdhZ9A+eqW5oaRABFI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-73-zWGZ4ZawPOemnFyJ6EWBfA-1; Tue, 03 May 2022 13:16:20 -0400
X-MC-Unique: zWGZ4ZawPOemnFyJ6EWBfA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B701BE0003;
        Tue,  3 May 2022 17:16:19 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.10.175])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D29CC07F5D;
        Tue,  3 May 2022 17:16:19 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH 1/2] audit: add call argument to socketcall auditing
Date:   Tue, 03 May 2022 13:16:18 -0400
Message-ID: <4396517.LvFx2qVVIh@x2>
Organization: Red Hat
In-Reply-To: <20220503090212.1322050-1-svens@linux.ibm.com>
References: <20220503090212.1322050-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tuesday, May 3, 2022 5:02:11 AM EDT Sven Schnelle wrote:
> socketcall auditing misses the call argument:
> 
> type=SOCKETCALL msg=audit: nargs=3 a0=10 a1=3 a2=c
> 
> which renders socketcall auditing (almost) useless. Add the call
> argument so it is possible to decode the actual syscall from the
> audit log:
> 
> type=SOCKETCALL msg=audit: call=1 nargs=3 a0=10 a1=3 a2=c

The call argument is in arg0 in the syscall record

type=PROCTITLE msg=audit(1651597634.301:1034): proctitle="./test"
type=SOCKADDR msg=audit(1651597634.301:1034): 
saddr=020000357F0000013030303030303030
type=SOCKETCALL msg=audit(1651597634.301:1034): nargs=3 a0=3 a1=fff47510 
a2=10
type=SYSCALL msg=audit(1651597634.301:1034): arch=40000003 syscall=102 
success=no exit=-111 a0=3 a1=fff47520 a2=f7f306cb a3=35000002 items=0 
ppid=10425 pid=10428 auid=325 uid=1325 gid=1325 euid=1325 suid=1325 
fsuid=1325 egid=1325 sgid=1325 fsgid=1325 tty=pts2 ses=3 comm="test" exe="/
home/socketcall/test" subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 
key="32bit-abi"

which user space translates into:

type=PROCTITLE msg=audit(05/03/2022 13:07:14.301:1034) : proctitle=./test 
type=SOCKADDR msg=audit(05/03/2022 13:07:14.301:1034) : saddr={ 
saddr_fam=inet laddr=127.0.0.1 lport=53 } 
type=SOCKETCALL msg=audit(05/03/2022 13:07:14.301:1034) : nargs=3 a0=0x3 
a1=0xfff47510 a2=0x10 
type=SYSCALL msg=audit(05/03/2022 13:07:14.301:1034) : arch=i386 
syscall=socketcall(connect) success=no exit=ECONNREFUSED(Connection refused) 
a0=connect a1=0xfff47520 a2=0xf7f306cb a3=0x35000002 items=0 ppid=10425 
pid=10428 auid=sgrubb uid=sgrubb gid=sgrubb euid=sgrubb suid=sgrubb 
fsuid=sgrubb egid=sgrubb sgid=sgrubb fsgid=sgrubb tty=pts2 ses=3 comm=test 
exe=/home/test/socketcall/test subj=unconfined_u:unconfined_r:unconfined_t:s0-
s0:c0.c1023 key=32bit-abi

Nothing is missing.

-Steve


