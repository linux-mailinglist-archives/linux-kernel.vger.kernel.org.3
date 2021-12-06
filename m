Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEDFA46921E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 10:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240136AbhLFJQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 04:16:57 -0500
Received: from out0.migadu.com ([94.23.1.103]:49821 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240118AbhLFJQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 04:16:57 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1638782007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xTcIvTRl3PV4xNRIqhyup0Qxe07AZpLNGYobYj8/W9k=;
        b=RenzKR/IeaLC+GFvxdEspGUm+KLNjej2BPqcRbTvd39An7t9mqHNVUQd3d30rL4lkHOoZ7
        WsS2L9sMPSGKmPVGG4Uv40cQXxwBK3cxOakqgVHzodSFk9Wojnpt8QyMXUmFtMxs2dLCky
        eC5PP6BtpjFfwPELBIF6oKyxlhtlAsc=
Date:   Mon, 06 Dec 2021 09:13:27 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   yajun.deng@linux.dev
Message-ID: <0a2496c3503ba85205a5da0d8e61ea78@linux.dev>
Subject: Re: [PATCH] completion: introduce complete_put() helper function
To:     "Peter Zijlstra" <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <Ya3LFV2W05TZzMnC@hirez.programming.kicks-ass.net>
References: <Ya3LFV2W05TZzMnC@hirez.programming.kicks-ass.net>
 <20211206040319.7063-1-yajun.deng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

December 6, 2021 4:34 PM, "Peter Zijlstra" <peterz@infradead.org> wrote:=
=0A=0A> On Mon, Dec 06, 2021 at 12:03:19PM +0800, Yajun Deng wrote:=0A> =
=0A>> There are many cases where it is necessary to decrease refcount and=
 test,=0A>> then called complete(). So introduce complete_put() helper fu=
nction.=0A>> =0A>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>=0A>> =
---=0A>> kernel/sched/completion.c | 7 +++++++=0A>> 1 file changed, 7 ins=
ertions(+)=0A>> =0A>> diff --git a/kernel/sched/completion.c b/kernel/sch=
ed/completion.c=0A>> index a778554f9dad..dcb737f1edc2 100644=0A>> --- a/k=
ernel/sched/completion.c=0A>> +++ b/kernel/sched/completion.c=0A>> @@ -38=
,6 +38,13 @@ void complete(struct completion *x)=0A>> }=0A>> EXPORT_SYMBO=
L(complete);=0A>> =0A>> +void complete_put(refcount_t *r, struct completi=
on *x)=0A>> +{=0A>> + if (refcount_dec_and_test(r))=0A>> + complete(x);=
=0A>> +}=0A>> +EXPORT_SYMBOL(complete_put);=0A> =0A> Please submit such t=
hings as part of the series that makes use of them.=0A=0AHere is a typica=
l use case=EF=BC=9A       vim drivers/infiniband/core/device.c +101=0Asta=
tic void ib_client_put(struct ib_client *client)=0A{=0A        if (refcou=
nt_dec_and_test(&client->uses))=0A                complete(&client->uses_=
zero);=0A}=0A=0AEach driver needs to define a xxx_put() function if they =
want to use it, we can add this helper function for them.
