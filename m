Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A0D462251
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 21:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbhK2Unm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 29 Nov 2021 15:43:42 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:24652 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229766AbhK2Ull (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 15:41:41 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-258-lM7yZ2ULPMyyCWsW7VrROA-1; Mon, 29 Nov 2021 15:38:19 -0500
X-MC-Unique: lM7yZ2ULPMyyCWsW7VrROA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9A571853028;
        Mon, 29 Nov 2021 20:38:18 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B5C410013D6;
        Mon, 29 Nov 2021 20:38:17 +0000 (UTC)
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>
Cc:     0day robot <lkp@intel.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>, lkp@lists.01.org
Subject: [PATCH v2 0/2] ucounts: Fix rlimit max values check
Date:   Mon, 29 Nov 2021 21:37:24 +0100
Message-Id: <cover.1638218242.git.legion@kernel.org>
In-Reply-To: <20211129074730.GB18483@xsang-OptiPlex-9020>
References: <20211129074730.GB18483@xsang-OptiPlex-9020>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=legion@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking the rlimit value specified in init_user_ns from the created userns does
not work properly. The issue is that the maximum value is taken by the same
rules as for ucounts. Because of this, we check the current rlimit counter value
with RLIM_INFINITY in init_user_ns.

v2:
- Fix a bug that was found by the lkp project.

--

Alexey Gladkov (2):
  ucounts: Fix rlimit max values check
  ucounts: Move rlimit max values from ucounts max

 include/linux/user_namespace.h | 17 ++++++++++++-----
 kernel/fork.c                  | 10 +++++-----
 kernel/ucount.c                | 19 +++++++++----------
 kernel/user_namespace.c        | 10 +++++-----
 4 files changed, 31 insertions(+), 25 deletions(-)

-- 
2.33.0

