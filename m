Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55A347C8B2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 22:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbhLUVNH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Dec 2021 16:13:07 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:44052 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhLUVNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 16:13:06 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id F113B62DA5F6;
        Tue, 21 Dec 2021 22:13:04 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zP1ltzRIKDzP; Tue, 21 Dec 2021 22:13:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C8D3662DA5F1;
        Tue, 21 Dec 2021 22:13:03 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9ZlfUu-NM3ib; Tue, 21 Dec 2021 22:13:03 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9A16A60A3582;
        Tue, 21 Dec 2021 22:13:03 +0100 (CET)
Date:   Tue, 21 Dec 2021 22:13:03 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jeff Dike <jdike@addtoit.com>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        kernel <kernel@axis.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>
Message-ID: <1446970217.191062.1640121183419.JavaMail.zimbra@nod.at>
In-Reply-To: <c48f86ad5d31f7f0cfa08d895bb03a4d92a3ce26.camel@sipsolutions.net>
References: <20211208151123.29313-1-vincent.whitchurch@axis.com> <342397676.191011.1640120120622.JavaMail.zimbra@nod.at> <c48f86ad5d31f7f0cfa08d895bb03a4d92a3ce26.camel@sipsolutions.net>
Subject: Re: [PATCH 0/2] Devicetree support for UML
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF95 (Linux)/8.8.12_GA_3809)
Thread-Topic: Devicetree support for UML
Thread-Index: xFJr8Y1gUUL3kk9OrWANIXE8xRKDHQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Johannes Berg" <johannes@sipsolutions.net>
> An: "richard" <richard@nod.at>, "Vincent Whitchurch" <vincent.whitchurch@axis.com>
> CC: "Jeff Dike" <jdike@addtoit.com>, "anton ivanov" <anton.ivanov@cambridgegreys.com>, "kernel" <kernel@axis.com>,
> "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-um" <linux-um@lists.infradead.org>, "devicetree"
> <devicetree@vger.kernel.org>
> Gesendet: Dienstag, 21. Dezember 2021 21:56:50
> Betreff: Re: [PATCH 0/2] Devicetree support for UML

> On Tue, 2021-12-21 at 21:55 +0100, Richard Weinberger wrote:
>> Vincent,
>> 
>> ----- Ursprüngliche Mail -----
>> > Von: "Vincent Whitchurch" <vincent.whitchurch@axis.com>
>> > An: "Jeff Dike" <jdike@addtoit.com>, "richard" <richard@nod.at>, "anton ivanov"
>> > <anton.ivanov@cambridgegreys.com>
>> > CC: kernel@axis.com, "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-um"
>> > <linux-um@lists.infradead.org>,
>> > "devicetree" <devicetree@vger.kernel.org>, "Vincent Whitchurch"
>> > <vincent.whitchurch@axis.com>
>> > Gesendet: Mittwoch, 8. Dezember 2021 16:11:21
>> > Betreff: [PATCH 0/2] Devicetree support for UML
>> 
>> > This series add support for passing a devicetree blob to UML.  It can be used
>> > for testing device drivers.
>> 
>> Nice feature.
>> Code looks good so far. But while building I'm facing this warning:
>> 
>> WARNING: unmet direct dependencies detected for OF_EARLY_FLATTREE
>>   Depends on [n]: OF [=n]
>>   Selected by [y]:
>>   - UML [=y]
>> 
>> 
>> Please note that my UML config has CONFIG_OF=n.
>> 
> 
> Hm. So maybe that needs to be
> 
>	select OF_EARLY_FLATTREE if OF

Yeah, IIRC arm and mips use such a pattern too.
Vincent, what do you think?

Thanks,
//richard
