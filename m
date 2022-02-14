Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081E04B4CE3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239323AbiBNKu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 05:50:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349373AbiBNKuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:50:03 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6FE652E1;
        Mon, 14 Feb 2022 02:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644833643;
        bh=NJguhNB55E9/WKFECmG7d2N9Rue9x0n0DNEEN++l5Nk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=PBq75XyjJzomQaVQCtYpr6NpWOhh4v+uoB5qNLGE8NK1q6PcgvesWNjionklyiJbP
         AANdOxtu/GYJzC9EcAMvjUxWqcZVLomXNeWWCjcaKlWds4OIJh69nFtwhsokzqHbRK
         dU04RtYo8Z+lK++cFJq9O3relYGs2gfZxX8sU1us=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.168.11]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIwzA-1nYSaP36Py-00KN34; Mon, 14
 Feb 2022 11:14:03 +0100
Message-ID: <886cb762-2532-c170-d615-d7ddf1e1561c@gmx.de>
Date:   Mon, 14 Feb 2022 11:13:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] fat: Use pointer to d_name[0] in put_user() for compat
 case
Content-Language: en-US
To:     Andreas Schwab <schwab@linux-m68k.org>,
        David Laight <David.Laight@ACULAB.COM>
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>
References: <YgmB01p+p45Cihhg@p100>
 <49a26b7a30254d9fb9653c2f815eaa28@AcuMS.aculab.com>
 <8735klx0fv.fsf@igel.home>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <8735klx0fv.fsf@igel.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:18jQ/5rJjEX5ks5twOE2mKlfPxOdq4oPQ1bQlJtKcaHDKLgz0H5
 miXvP8Jp8DpK5m1kKhQvEKkk1iNFWQU1MJx+Gmk1EA5Vk/SPQrB42ziPdXQV1B6q94dVXFa
 guxIdqp6P2/o1mlL3BGTMMZfjYefh0tcgDXwDJy6V/mDPd+CyoP5huAQcgg16RoCgvtEmiQ
 IgBN7u7G5Ql/Gqt8lYwqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fE5wd9SVEes=:eAZblA0EVauqZK7lkJZNB6
 P3UYP6IMHiUCXxgR7Sosn+hO3IhgwZtlggfWpc958E76o2hlQAr2bImpO6GdFz1TJklziD7kG
 swcXdsF/+KRtXXawx9ZP7lDj9IZERiAe0scLnXHWGC+oBxj786gjH9sd5Q59rAixkQSAXV4KV
 3aEW5PNjCXFFrbmbpwkBsnBPLs66iPG03hzy722BakOxyjj76pg+fOy3dLWeNIOj1Y4DqgwDQ
 6oiZZ5N6ACZBxjjSzct13bCsIKA9gaOed3BMQAxjf96KDfsjWi4C1KBrP6qeqHQZyLRPuG+9e
 PcFQmZ5G4aJDQkzd9x08Yo+K7h5yy+HEiN5Blmwk73n2zrI1xqsGzuTwf5hjiHJw9CYSJ5gj4
 FWDe5d5WNa9L/Cq0Cse9zv97ibxKnBvLKrn3q9kSwuWg1nStW6H1BZcUfySEizRizpLI3gqon
 Y/eUkRFVQ3lB2zP6n1ws33O755gmthcfMkNOeaX81EhB70XeRdx4MQ9GFway0cHhh1ayQs6C+
 QXsN7QyijlQnJFy+RNQC9zbOvl2LUHPm5yNCbYKxvYki2MWm4ojjIedQiw8JDu6Leqw7GlMWc
 sCb+ivqJ8spWpsnMSxzznugCQELLvzfkDc1IKDnhBkbrNgjG+m4HTBFNlQGAPZcNU00eJEtOW
 zX1Iiw4umYw0qEm2KYC/RKHoHry92OBXas+l8Q53xsHy3b+1WyGu8HFSfZ17zOxNTy6LZDEX+
 eolPkf14CawsekWGunu0SrExLsd0qS6+2iFzXleJlgX6o8J21q7m5MgOrjt9QNsYcotnpvJOn
 6b+PXHxvGt2p0buzvbR6wo7uzzQ4ZgJx5bPCWweri+EY+XQOSbzJk1VEjdUhuOMBv8NK9/fGG
 nvvwvaFooW+0n8uLuaSwhfzpBxoRo4nW+fLgxol4GgJkUFeHUS7mWGA4GUoTJ2yqJ1WBe71fM
 z2yn5dTXDdanWM4ld6jL9BPhi9v9WcH+pQSzJQAzG+sPkqyfpps1h7mBFzf9TvlMpvnS8r72Q
 kJYak93TP/5ECYK9mFXeNjfFXs4Xw/gbH24jyHth5b9rI99NuOLO0K1P+p1wl8Y6BGrHnPrqz
 jQKh8otGF4BYLM=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/22 10:27, Andreas Schwab wrote:
> On Feb 14 2022, David Laight wrote:
>
>> The 'bug' is caused by put_user() trying to do:
>> 	__typeof__(ptr) __ptr =3D ptr;
>> where __typeof__ is returning char[n] not char *.
>>
>> I've tried a few things but can't get __typeof__ to
>> generate a suitable type for both a simple type and array.
>
> Does it work to use __typeof__(&*(ptr))?

Yes, this works.

Helge

