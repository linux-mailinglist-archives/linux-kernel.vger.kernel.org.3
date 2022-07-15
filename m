Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24036575EB3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 11:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbiGOJgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 05:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiGOJgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 05:36:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 275687E005
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 02:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657877778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ACiNeAnHVNnJ/W4OhZCGTMGcHGRaYtsznETVX9y3dVs=;
        b=Ps4BUfzbjG6ub3ZpU77Wdz1ZDNSp+aOlveWnmkxbNISB2KM6Fbye0d7Hx5IfIEl2sPwq2t
        p95pTsNRZYEjQ0YqKf/cI6M2N4SJaIV/hn6rHdqV2yyb11FG/usHq+k7SNbZHDkifXGexh
        NF9NsigwXWKeMy/CbPGiFxHBMc5rdAg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-57-XWPPcm9EMiaQDKivgu1NyA-1; Fri, 15 Jul 2022 05:36:12 -0400
X-MC-Unique: XWPPcm9EMiaQDKivgu1NyA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 795CB85A585;
        Fri, 15 Jul 2022 09:36:12 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6ACF12026D64;
        Fri, 15 Jul 2022 09:36:12 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 26F9aCks005568;
        Fri, 15 Jul 2022 05:36:12 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 26F9aCSN005565;
        Fri, 15 Jul 2022 05:36:12 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 15 Jul 2022 05:36:12 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Daniil Lunev <dlunev@chromium.org>
cc:     Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Brian Geffon <bgeffon@google.com>,
        Alasdair Kergon <agk@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [dm-devel] [PATCH 1/1] dm: add message command to disallow device
 open
In-Reply-To: <CAONX=-dEG121RQ6L-4fPMXrLXb3JeYNVNiPzHXNaRLbwRzb3bw@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.2207150528170.5197@file01.intranet.prod.int.rdu2.redhat.com>
References: <20220704000225.345536-1-dlunev@chromium.org> <20220704100221.1.I15b3f7a84ba5a97fde9276648e391b54957103ff@changeid> <YtB45Lte5UhlEE6y@redhat.com> <CAONX=-dEG121RQ6L-4fPMXrLXb3JeYNVNiPzHXNaRLbwRzb3bw@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Jul 2022, Daniil Lunev wrote:

> Hi Mike,
> Thank you for your response. I should have probably added more context
> to the commit message that I specified in the cover letter. The idea is to
> prohibit access of all userspace, including the root. The main concern here
> is potential system applications' vulnerabilities that can trick the system to
> operate on non-intended files with elevated permissions. While those could
> also be exploited to get more access to the regular file systems, those firstly
> has to be useable by userspace for normal system operation (e.g. to store
> user data), secondly, never contain plain text secrets. Swap content is a
> different story - access to it can leak very sensitive information, which
> otherwise is never available as plaintext on any persistent media - e.g. raw
> user secrets, raw disk encryption keys etc, other security related tokens.
> Thus we propose a mechanism to enable such a lockdown after necessary
> configuration has been done to the device at boot time.
> --Daniil

If someone gains root, he can do anything on the system.

I'm quite skeptical about these attempts; protecting the system from the 
root user is never-ending whack-a-mole game.

Mikulas

