Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4142059958F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346679AbiHSG5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243277AbiHSG5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:57:06 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CB6DF09E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:57:05 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660892223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lBNrmYPXLIF8oIJg0s80Rs9VguA7/xNAIlxn0aNwRaA=;
        b=uj8IRehRCxlFt3hWOSyoL+4qmy0+X4f2zuMmfMQsfF9LW5pwGRGbHb6NAwcL9wN29VqTD+
        N8Wpimjow1Mg9JqR2jo6hcikZg3pvt5XK2Dn9BjlzhVs5DEEgC9zRjvDWUqFcxxf3fbC+s
        Ua4qfLEvSeV/e6BJugXcPENsPw3/5tw=
MIME-Version: 1.0
Subject: Re: [PATCH] mm: hugetlb: simplify per-node sysfs creation and removal
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <A0353CE2-D014-4B35-95F1-40345D1B66E6@linux.dev>
Date:   Fri, 19 Aug 2022 14:56:56 +0800
Cc:     Muchun Song <songmuchun@bytedance.com>, rafael@kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, Linux MM <linux-mm@kvack.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0F3FE8B0-9ADB-423D-A2FE-2AF1A3A6E619@linux.dev>
References: <20220819052137.7985-1-songmuchun@bytedance.com>
 <Yv8umgIXfbpMFukB@kroah.com> <A0353CE2-D014-4B35-95F1-40345D1B66E6@linux.dev>
To:     Greg KH <gregkh@linuxfoundation.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 19, 2022, at 14:44, Muchun Song <muchun.song@linux.dev> wrote:
>=20
>=20
>=20
>> On Aug 19, 2022, at 14:32, Greg KH <gregkh@linuxfoundation.org> =
wrote:
>>=20
>> On Fri, Aug 19, 2022 at 01:21:37PM +0800, Muchun Song wrote:
>>> The following commit offload per-node sysfs creation and removal to =
a kworker and
>>> did not say why it is needed.  And it also said "I don't know that =
this is
>>> absolutely required".  It seems like the author was not sure as =
well.  Since it
>>> only complicates the code, this patch will revert the changes to =
simplify the code.
>>>=20
>>> 39da08cb074c ("hugetlb: offload per node attribute registrations")
>>=20
>> Any specific reason why you did not cc: the original author of this
>> commit, or anyone else on the patch?
>=20
> OK. Cc Lee Schermerhorn.

Unluckily, I guess the email address is out of date since I just got =
bounced mail
(Undelivered Mail Returned to Sender). Remove lee.schermerhorn@hp.com =
from the
Cc list.

>=20
>>=20
>>> We could use memory hotplug notifier to do per-node sysfs creation =
and removal
>>> instead of inserting those operations to node registration and =
unregistration.
>>> Then, it can reduce the code coupling between node.c and hugetlb.c.  =
Also, it can
>>> simplify the code.
>>=20
>> I do not think we had memory hotplug notifier back in 2009 when this
>> commit was first written.
>=20
> Maybe not. Commit 39da08cb074c is merger in 2009. However, hotplug =
notifier mechanism
> is merged in 2006. The document is updated in 2007 (see commit =
10020ca246c5).
>=20
>>=20
>> How did you test this?  Did you use a HUGETLBFS system and verify =
that
>> everything still works properly?  You are deleting a lot of code =
(always
>> nice), but making sure everything is still operating the same is a =
good
>> thing.
>=20
> I really did the test (through a VM), it works properly.
>=20
> Thanks.
>=20
>>=20
>> thanks,
>>=20
>> greg k-h

