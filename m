Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04A05995CF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346905AbiHSHPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 03:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346773AbiHSHPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:15:32 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7993E2C54
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 00:15:29 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660893328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b1qeRk/32x90/7Q9jzvtl8MH8XALoGSR86o+wJItTaA=;
        b=LIAap0zKuJPmQ5a6XaTr/0NnOKCHkwQf+8iDTSx+miGzAs40oAaPPw9Oe3FqaVuXjML/PL
        NKSBGlhmrmn7PX6qp/mYagYFlt0Slr0ANkJKGPcvcTOJ+4iRQxXqoEr30M0tUiaFXfrGO4
        FJz0Gj161L8YeOXiPK6st5D7xc6e2vU=
MIME-Version: 1.0
Subject: Re: [PATCH] mm: hugetlb: simplify per-node sysfs creation and removal
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <Yv809bLzdI2f6cl1@kroah.com>
Date:   Fri, 19 Aug 2022 15:15:13 +0800
Cc:     Muchun Song <songmuchun@bytedance.com>, rafael@kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        lee.schermerhorn@hp.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <8451D3B9-281E-4FEC-B1B3-A231FE65EC3B@linux.dev>
References: <20220819052137.7985-1-songmuchun@bytedance.com>
 <Yv8umgIXfbpMFukB@kroah.com> <A0353CE2-D014-4B35-95F1-40345D1B66E6@linux.dev>
 <Yv809bLzdI2f6cl1@kroah.com>
To:     Greg KH <gregkh@linuxfoundation.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 19, 2022, at 15:00, Greg KH <gregkh@linuxfoundation.org> wrote:
>=20
> On Fri, Aug 19, 2022 at 02:44:13PM +0800, Muchun Song wrote:
>>=20
>>=20
>>> On Aug 19, 2022, at 14:32, Greg KH <gregkh@linuxfoundation.org> =
wrote:
>>>=20
>>> On Fri, Aug 19, 2022 at 01:21:37PM +0800, Muchun Song wrote:
>>>> The following commit offload per-node sysfs creation and removal to =
a kworker and
>>>> did not say why it is needed.  And it also said "I don't know that =
this is
>>>> absolutely required".  It seems like the author was not sure as =
well.  Since it
>>>> only complicates the code, this patch will revert the changes to =
simplify the code.
>>>>=20
>>>> 39da08cb074c ("hugetlb: offload per node attribute registrations")
>>>=20
>>> Any specific reason why you did not cc: the original author of this
>>> commit, or anyone else on the patch?
>>=20
>> OK. Cc Lee Schermerhorn.
>=20
> He can't see the patch here, so there is no context.  Please resend =
the

Unluckily, his email is out of date, I cannot resend it to him.

> whole thing.  You also didn't copy the people who signed off on it =
(i.e.
> Andi), any reason why?

I can resend this to Andi. Why I didn=E2=80=99t send to them this time =
is because
I just follow the output of scripts/get_maintainer.pl. I will resend a =
new
one.

>=20
>>>> We could use memory hotplug notifier to do per-node sysfs creation =
and removal
>>>> instead of inserting those operations to node registration and =
unregistration.
>>>> Then, it can reduce the code coupling between node.c and hugetlb.c. =
 Also, it can
>>>> simplify the code.
>>>=20
>>> I do not think we had memory hotplug notifier back in 2009 when this
>>> commit was first written.
>>=20
>> Maybe not. Commit 39da08cb074c is merger in 2009. However, hotplug =
notifier mechanism
>> is merged in 2006. The document is updated in 2007 (see commit =
10020ca246c5).
>>=20
>>>=20
>>> How did you test this?  Did you use a HUGETLBFS system and verify =
that
>>> everything still works properly?  You are deleting a lot of code =
(always
>>> nice), but making sure everything is still operating the same is a =
good
>>> thing.
>>=20
>> I really did the test (through a VM), it works properly.
>=20
> How about on real hardware?  On a HUGE system with real hardware?  On =
a
> small system?

I have test a VM with 128 GB memory, it works properly. I cannot test it =
on
a real hardware since I didn=E2=80=99t have a real hardware with hotplug =
memory. I
am not sure if there is some ways to emulate a hotplug memory node.

Thanks.

>=20
> thanks,
>=20
> greg k-h

