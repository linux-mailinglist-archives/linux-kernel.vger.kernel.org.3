Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979F8592AA6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 10:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241056AbiHOHrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbiHOHrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:47:00 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEB9140BC
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:46:59 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id CA1835C00C3;
        Mon, 15 Aug 2022 03:46:56 -0400 (EDT)
Received: from imap45 ([10.202.2.95])
  by compute5.internal (MEProxy); Mon, 15 Aug 2022 03:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1660549616; x=1660636016; bh=HPaUuybkXf
        MEjb4+BMkBGr2yefPKTeLDrO42AwBiG3c=; b=BIid5y0EyUNakWL53V4Qq517Lt
        i4rdrTkDqX8E+c2qczZyHmxqN/b3i/9GqE9fnA8EkwnzBMyTfqOruiNA1iBdw48L
        lx5fv5xj+k7bUiPrk8dKQoS1UCaunImNigGgOd8/Vn0VHEO9DVhAkk+UveV1+q8O
        t749Fv0DRis432dw6XrYXPhWXAIeREfKm0aI9NqKsLnGbr5BZMDKyU03YZ44wVf1
        5w0R07sTSDjdilKFHNmn7BeCb/NZ2O0XXEVCOrdJCLG8EAsTx5fZBZkzdEH/JOsw
        cFyH4RQ9Kl1QniF2CqHjErzBCSWisW0nI9DSeC6+cdB3tForZ+sqUipu7Vcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660549616; x=1660636016; bh=HPaUuybkXfMEjb4+BMkBGr2yefPK
        TeLDrO42AwBiG3c=; b=NSOIwm1jyZGOyuTvVLhHeKkA9FZl7dP7Tha39lOk/jRX
        SlKQi/Sz3r/HE+636dIDpPkjezn6O/qcdH1AzqjmrnmTkTV5r9JTFAv24QB2Q3dS
        BBqHW5SZpKC+6TJcO6mJPxn/1THXg5Y/qPOb8FTDR67U7r4as78hfejR6fbqMaKC
        YnYuDJIF07VhwmVmmD2OJwnrZx8TcY1Bf8OwxJ7vsoIw5Y3+0iBd8iGY7EZOtkTH
        RSZvwShCf+tpE6NTFaCNzDBljg36cCbjZUGhyChCMPbDHPCRHPBKe9nh3mCoQi0s
        Mt8Deu736lUmRINVVTFlfDZEptfvP70pRmkHiwCpGA==
X-ME-Sender: <xms:8Pn5Yr7l8UNUOvDxndI5xX21i81uTYFX1yiQNPfsVuiKkEp50ellaw>
    <xme:8Pn5Yg6ihRnvQfQ3Id4c2kNASQ9nNrxzPrXAvlqe75SP1nbSV_HAVo-hsiuuRYRll
    pt42IxPjTuIZqE3_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    nhgurhgvshcuhfhrvghunhgufdcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqne
    cuggftrfgrthhtvghrnhepkeffiefflefhhfelteeggeevjedvteegieffhedujeduleej
    geekgfejgeetgeffnecuffhomhgrihhnpehpohhsthhgrhdrvghsnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvghssegrnhgrrhgr
    iigvlhdruggv
X-ME-Proxy: <xmx:8Pn5Yifsxm3rIFkM9AelPbf9pQwn9oN3jXQ3hDhzo6O1D7uPNrB9ew>
    <xmx:8Pn5YsICtUDgIFNEyGgaTymIFEyB2zVzEjsyZiUiBO6nNLPxDYdYdw>
    <xmx:8Pn5YvI8qDAawxR45EbmgF86cXmogpTMItChWKdqb5aKkNA6mYg0tg>
    <xmx:8Pn5YliY6ngLdBnaHtaiTbxqJw0FkgyHXeMLkAHu7nssz43NtTSbTw>
Feedback-ID: id4a34324:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7488F2720078; Mon, 15 Aug 2022 03:46:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <3df6bb82-1951-455d-a768-e9e1513eb667@www.fastmail.com>
In-Reply-To: <20220815031549-mutt-send-email-mst@kernel.org>
References: <20220814212610.GA3690074@roeck-us.net>
 <CAHk-=wgf2EfLHui6A5NbWoaVBB2f8t-XBUiOMkyjN2NU41t6eA@mail.gmail.com>
 <20220814223743.26ebsbnrvrjien4f@awork3.anarazel.de>
 <CAHk-=wi6raoJE-1cyRU0YxJ+9ReO1eXmOAq0FwKAyZS7nhvk9w@mail.gmail.com>
 <1c057afa-92df-ee3c-5978-3731d3db9345@kernel.dk>
 <20220815013651.mrm7qgklk6sgpkbb@awork3.anarazel.de>
 <CAHk-=wikzU4402P-FpJRK_QwfVOS+t-3p1Wx5awGHTvr-s_0Ew@mail.gmail.com>
 <20220815071143.n2t5xsmifnigttq2@awork3.anarazel.de>
 <20220815031549-mutt-send-email-mst@kernel.org>
Date:   Mon, 15 Aug 2022 00:46:36 -0700
From:   "Andres Freund" <andres@anarazel.de>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Jens Axboe" <axboe@kernel.dk>,
        "James Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Guenter Roeck" <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: Re: upstream kernel crashes
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 15, 2022, at 00:29, Michael S. Tsirkin wrote:
> On Mon, Aug 15, 2022 at 12:11:43AM -0700, Andres Freund wrote:
>> Hi,
>> 
>> On 2022-08-14 20:18:44 -0700, Linus Torvalds wrote:
>> > On Sun, Aug 14, 2022 at 6:36 PM Andres Freund <andres@anarazel.de> wrote:
>> > >
>> > > Some of the symptoms could be related to the issue in this thread, hence
>> > > listing them here
>> > 
>> > Smells like slab corruption to me, and the problems may end up being
>> > then largely random just depending on who ends up using the allocation
>> > that gets trampled on.
>> > 
>> > I wouldn't be surprised if it's all the same thing - including your
>> > network issue.
>> 
>> Yea. As I just wrote in
>> https://postgr.es/m/20220815070203.plwjx7b3cyugpdt7%40awork3.anarazel.de I
>> bisected it down to one commit (762faee5a267). With that commit I only see the
>> networking issue across a few reboots, but with ebcce4926365 some boots oops
>> badly and other times it' "just" network not working.
>> 
>> 
>> [oopses]

>> If somebody knowledgeable staring at 762faee5a267 doesn't surface somebody I
>> can create a kernel with some more debugging stuff enabled, if somebody tells
>> me what'd work best here.
>> 
>> 
>> Greetings,
>> 
>> Andres Freund
>
> Thanks a lot for the work!
> Just a small clarification:
>
> So IIUC you see several issues, right?

Yes, although they might be related, as theorized by Linus upthread.

> With 762faee5a2678559d3dc09d95f8f2c54cd0466a7 you see networking issues.

Yes.


> With ebcce492636506443e4361db6587e6acd1a624f9 you see crashes.

Changed between rebooting. Sometimes the network issue, sometimes the crashes in the email you're replying to.


> MST
