Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D06A595BDC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbiHPMjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbiHPMiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:38:55 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB77398A78;
        Tue, 16 Aug 2022 05:38:51 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id AD9973200915;
        Tue, 16 Aug 2022 08:38:49 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute4.internal (MEProxy); Tue, 16 Aug 2022 08:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1660653529; x=
        1660739929; bh=qiN45Q11NPTk5Rs4MYK+8OHu5fZC4SzQoWKWpX8YGFI=; b=N
        6scrB6ZgHrXL/GExIbxkM+ie6PzR2UuqslRNTofrAMbfv/YT11hkQHfuzi8/cRur
        BN8er9ChPU00KBX9XAVvPR1FO2kf7Qyf+78Gz48/Wra7NYE1oNx4y3R01xzR642M
        x1Z2IByMJFBoOz2SHX6Uo7QM2cUvDa5s4kfA41K8VefZcrgmWOqEKhSLyOI6GjPF
        VjCv5nqRihS/6cXVhUJCLlL+Y4iQq+Yf7WqN2+2XN7k89hbcBSIiIFpHgwVakJLO
        ZJ1Ip9UErNJb2martFDlz2DngXjmj9K5WcbUOmuXfOohXUaiQu1ioNlIZ0OcxymD
        hKhnRNeeuLhEbTJ2v12sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660653529; x=
        1660739929; bh=qiN45Q11NPTk5Rs4MYK+8OHu5fZC4SzQoWKWpX8YGFI=; b=J
        tadQTc1nh0QXPgN16GFqF8Yq2QW8v7tO6aZdmEy7X3DDyljXtxgrSoOriUmU9yo9
        RcOWOBTgssIGI5v2R0XyvmlsOrKCOVbVn55xpJmewra91R/5UM4Yl9arSw1aNpv+
        TBtcizI8dDZJ3dqrcMKaQ7oodTvPyc+EIAI9vQfkXa0mVaG6l+ClYyeD0268+xWM
        +wLIOE7s9WNzKkb2DRJKJZ7mSKyLYcYu3bQY/amNuwJg5foaiFnEIXQjQaxZPPz5
        XomsqDm1PkRPM2bcC75ZovZXYGn9UfdxMeapq5xcD8Q0YXeLbaIFFqBjiFLteDV3
        34ZcBppAb69KMWIYLtg6w==
X-ME-Sender: <xms:2Y_7Yp21s31GoP_OMNp4dVeeVboXQc_4PIt0t-cnosLJP3PqF70i-g>
    <xme:2Y_7YgF-YdURcLrqfogzVZS4WL-txH6an5da6dPB76vqGvMZlKaVFWr0SqsVg8neq
    CfbF_t-lIohRrA3S7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehgedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
    ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:2Y_7Yp7kA3C__J467ms2fuyZ0XLuZG0FxIkV4xcsPpWj66WdrhKn8w>
    <xmx:2Y_7Ym23mTtiPF5W7jlqFIPlDQ-JLi02KTw8S_WHgmqpOWKYyYH4uw>
    <xmx:2Y_7YsHL_lX8Rii9eY2lsGzQC6ou8qJxwsUldqzlKbZcge0GjU6IxQ>
    <xmx:2Y_7YgB6psx0VQVHbJ6yfsphEHzDNVzMWiZUe9MLLAV7nrAVXv3P0g>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 060B836A0071; Tue, 16 Aug 2022 08:38:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <c17cdcf9-14bd-4287-9525-287dfc908fa2@www.fastmail.com>
In-Reply-To: <YvthfQUfv0TiO/bK@kroah.com>
References: <20220816091258.9571-1-jiaxun.yang@flygoat.com>
 <YvthfQUfv0TiO/bK@kroah.com>
Date:   Tue, 16 Aug 2022 13:38:27 +0100
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Greg KH" <greg@kroah.com>
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        linux-api@vger.kernel.org, f.fainelli@gmail.com
Subject: Re: [PATCH v4] MIPS: Expose prid and globalnumber to sysfs
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A82022=E5=B9=B48=E6=9C=8816=E6=97=A5=E5=85=AB=E6=9C=88 =E4=B8=8A=E5=
=8D=8810:21=EF=BC=8CGreg KH=E5=86=99=E9=81=93=EF=BC=9A
> On Tue, Aug 16, 2022 at 09:12:58AM +0000, Jiaxun Yang wrote:
>> Some application would like to know precise model and rev of processor
>> to do errata workaround or optimization.
>>=20
>> Expose them in sysfs as:
>> /sys/devices/system/cpu/cpuX/regs/identification/prid
>> /sys/devices/system/cpu/cpuX/regs/identification/globalnumber
>>=20
>> Reusing AArch64 CPU registers directory.
>>=20
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>> v2: Drop static qualifier for kobj (gregkh)
>> v3: Use kzalloc to allocate struct cpuregs.
>>     note: When Greg mentioned about static I was thinking about
>>     static qualifier of percpu variable. After reading documents
>>     again it turns out kobjs should be allocated at runtime. Arm64's
>>     cpuinfo kobj is also on a percpu variable... I guess that was a
>>     intentional use?
>> v4: Properly handle err of kobj creation. (gregkh)
>
> Nothing was fixed :(

[Resending due to previous mail contains HTML. I just got a Macbook
and was trying to use it's built-in mail client. Turns out that it's
sending HTML even with "Plain Text" selected...
Now turning back to mutt. Apologise for inconvinence.]

Hi Greg,

Sorry for misinterpret your comments again :(

Hmm I just use kobject_put to replace kobject_del.
I thought that was what you were trying to say?

>
> Again, please read the documentation for the kobject calls you are
> making as it explains how to properly handle errors being returned from
> them, and what you need to call if that happens.

Quoting the document the only sentence mentioning error handling is:

It is good practice to always use kobject_put() after kobject_init() to =
avoid
errors creeping in.

In our case is it safe to call kobject_put if() the error happens at kob=
ject_init()
stage of kobject_init_and_add()? Do you mean that I should use kobject_p=
ut to
clean up kobject_init_and_add() error?

Thanks
- Jiaxun

>
> thanks,
>
> greg k-h
