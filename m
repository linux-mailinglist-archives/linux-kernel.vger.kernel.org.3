Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A985A6231
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiH3Ljg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiH3Lij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:38:39 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548D51AD87
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 04:37:30 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id E17505801D8;
        Tue, 30 Aug 2022 07:37:26 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Tue, 30 Aug 2022 07:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1661859446; x=1661860046; bh=Oupn4eihBs
        i0MiLn85P4dhLgR7rqSv7zUgSdpKnmCGk=; b=k6PVLwqikiKnbm9KWzOSLRNMuO
        ipubifHhHOySC975owsKGRAvLAJ8UIDt8zBiP0ipjOePPcitcsWiUXqFwe697nTV
        /ybV4l7AtnADfW4mDMt4vPZuM/w6V5poMXqFYQgPWWQ6YiVChVKLtAbzNntCwKP0
        4rsipZ4rRLX6HVYbFGl7lUDkmTItHrAf6MiUrPy/bhDYvq76vo4DEllCHyiBR+a4
        kqSIK8pfN9y7aSZWDa4Jpspq9cFkSHBS9uGLXxBgCyUINMnApo1E0qvepfKwR+9W
        8/TObG4yD0UHKuwvKQtQ7yemnuRP1uJG4KiqEx2vLgJcR890l7xEJry9lrGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        i56a14606.fm1; t=1661859446; x=1661860046; bh=Oupn4eihBsi0MiLn85
        P4dhLgR7rqSv7zUgSdpKnmCGk=; b=LF4CCGJe/E9AAzS3vhlzL3gPRaFjg0od9b
        QCu2/es7f4b0wxDSGar9ChqSa1o6s6j+5hzvt53D+ejZO2NxcWI3fk4sUzs6d7ye
        dM15mQMIO+4J6vqczxGrjgSH4ZFbzlqNjrMySYysqc2T2aztEp8gXjgL8tL9tpey
        //vy05ZhUBO8+5o+/grrfaDMeo4wcF5lF5/+Rew4VVoRKVGh6po7oHKh262uiLpR
        zILRqhRirH6cGEt8Krb6Op+/GuE003fKQyqGCjnzaDe8gCnM1/Wcw7bFBML/PEUt
        bZ15Q7QLSJWJrFWrhtuT9zM3ByolA6e5U98F4H9SfPb45MBDQdjA==
X-ME-Sender: <xms:dfYNY4ftYDUwhy1k6OjYWVhivaQSvhKknnX1kKYtHqsxQlJASsEAPw>
    <xme:dfYNY6OIFiJYyLNwmwBFs7BeAGTzKEm3mDXqe60IVTVXMNE3GX4b_oTYrkoPZ8Hqm
    5MDVijlpCDD_WRWhY8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekfedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:dfYNY5j3_glt5-JETShyH_6WgIV1Rvyuxo97PliiyuSpORA7152kXA>
    <xmx:dfYNY99nBaln0tKxJohbZPmXWQBBrFhwfoiT-96n4NgTtj7-Oto0Hg>
    <xmx:dfYNY0tYdzKKt_ezne9MXT0Xz19sFm7jdLLVdlTaKHdDo3TWbUETwQ>
    <xmx:dvYNY94D27W0abX1AuoxDehA_WxBzsPjs0nPZWA5bIIx5cbzhZhbtPwMONQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id ABADBB60083; Tue, 30 Aug 2022 07:37:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <78451bb1-e4d2-457a-adf7-8fb61be0fb3e@www.fastmail.com>
In-Reply-To: <4ff2a310-c8ba-ccf2-8d51-5181b83685c7@loongson.cn>
References: <1661766931-7277-1-git-send-email-yangtiezhu@loongson.cn>
 <d1a52fa2-380a-421b-8c46-5150a39be484@www.fastmail.com>
 <4ff2a310-c8ba-ccf2-8d51-5181b83685c7@loongson.cn>
Date:   Tue, 30 Aug 2022 13:37:05 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Tiezhu Yang" <yangtiezhu@loongson.cn>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "WANG Xuerui" <kernel@xen0n.name>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] LoongArch: Fix warning: #warning syscall fstat not implemented
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

On Mon, Aug 29, 2022, at 4:34 PM, Tiezhu Yang wrote:
>
> I read the commit message in the commit 82b355d161c9 ("y2038: Remove
> newstat family from default syscall set"), I am not quite sure whether
> we should check __ARCH_WANT_NEW_STAT first, like this:
>
>    #ifndef __ARCH_WANT_NEW_STAT
>    #define __IGNORE_fstat
>    #endif

No, the #ifdef is not needed here, the entry just means we
no longer warn about the missing syscall because it has
been replaced by statx and this is true regardless of
__ARCH_WANT_NEW_STAT.

       Arnd
