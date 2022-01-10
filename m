Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB9C489D5E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 17:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237247AbiAJQSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 11:18:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46376 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237046AbiAJQSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 11:18:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641831513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZD+LOj5cUuiivVEnNNCtusx2ZUVNWQVbTXyULr5z3N0=;
        b=Ufp+Jf4bYOdsKBFelxHDI7al5wrYq2rlaTqgyd/Pdd0cUdnl3cRxTTNWcG/7Yxc/FnZjQs
        MgQTHWY1OEZUx4Z+H7R6VQaaT2dviqSLTxQUJrNhE5+8b1P4/n/ILBUGLybQU9ToOFRq2W
        zbPs6Rh4/DvzFD5Sh4kDXowcWtLRE2k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-186-XXSAueLMOjm4oOkgxkxvaQ-1; Mon, 10 Jan 2022 11:18:29 -0500
X-MC-Unique: XXSAueLMOjm4oOkgxkxvaQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88810839A44;
        Mon, 10 Jan 2022 16:18:28 +0000 (UTC)
Received: from [10.22.11.34] (unknown [10.22.11.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 86B047E8C8;
        Mon, 10 Jan 2022 16:18:27 +0000 (UTC)
Message-ID: <a23a3226-95d9-9835-c1c7-2d13f4a1ee16@redhat.com>
Date:   Mon, 10 Jan 2022 11:18:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] f2fs: move f2fs to use reader-unfair rwsems
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Tim Murray <timmurray@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
References: <20220108164617.3130175-1-jaegeuk@kernel.org>
 <YdvoxkAAquI17UbX@infradead.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YdvoxkAAquI17UbX@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/10/22 03:05, Christoph Hellwig wrote:
> Adding the locking primitive maintainers to this patch adding open coded
> locking primitives..
>
> On Sat, Jan 08, 2022 at 08:46:17AM -0800, Jaegeuk Kim wrote:
>> From: Tim Murray <timmurray@google.com>
>>
>> f2fs rw_semaphores work better if writers can starve readers,
>> especially for the checkpoint thread, because writers are strictly
>> more important than reader threads. This prevents significant priority
>> inversion between low-priority readers that blocked while trying to
>> acquire the read lock and a second acquisition of the write lock that
>> might be blocking high priority work.
>>
>> Signed-off-by: Tim Murray <timmurray@google.com>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

We could certainly implement a down_read() variant (e.g. 
down_read_lowprio()) with its own slowpath function to do this within 
the rwsem code as long as there is a good use-case for this kind of 
functionality.

Cheers,
Longman

