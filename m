Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853075A5E74
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiH3IrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiH3IrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:47:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC21F17042
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661849220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tsLY5F5Ozz1AdHlAsgibfQkv7JMTI/b0jjcNGuI8VEA=;
        b=Jvr/QN/tV9yfv2vB38zvmu+6CpDXTddzawoyRmV8qwT54l76VkUWmLYqHWkueoMIi2hVlZ
        Cp+ZGqo/2h9hdehAlM5shmpxbIzXvqBodR4lNGvSnPDQgIyU1hUeXdFInR5WCg/zDYhWZ+
        Ib7ilX+ToxQLVVzICqrjWvid/mzjIcw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-529-4P5jwUmHM7KyShcoWHJFJQ-1; Tue, 30 Aug 2022 04:46:56 -0400
X-MC-Unique: 4P5jwUmHM7KyShcoWHJFJQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 427C180418F;
        Tue, 30 Aug 2022 08:46:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5881E2026D64;
        Tue, 30 Aug 2022 08:46:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAH2r5muT-nX+tgk6wm=L1qjWNhc2c5GDBaQXBGbrE-hNkPr3cw@mail.gmail.com>
References: <CAH2r5muT-nX+tgk6wm=L1qjWNhc2c5GDBaQXBGbrE-hNkPr3cw@mail.gmail.com>
To:     Steve French <smfrench@gmail.com>
Cc:     dhowells@redhat.com, CIFS <linux-cifs@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        ronnie sahlberg <ronniesahlberg@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>
Subject: Re: [PATCH v2][SMB3 client] smb3: use filemap_write_and_wait_range instead of filemap_write_and_wait
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1899334.1661849214.1@warthog.procyon.org.uk>
Date:   Tue, 30 Aug 2022 09:46:54 +0100
Message-ID: <1899335.1661849214@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steve French <smfrench@gmail.com> wrote:

> Subject: [PATCH] smb3: use filemap_write_and_wait_range instead of
>  filemap_write_and_wait
> 
> When doing insert range and collapse range we should be
> writing out the cached pages for the ranges affected but not
> the whole file.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Steve French <stfrench@microsoft.com>

Reviewed-by: David Howells <dhowells@redhat.com>

