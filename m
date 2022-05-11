Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35DE523CFF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346559AbiEKTDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241347AbiEKTDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:03:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B11861296
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:03:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8FEDB8260A
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 19:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C577C340EE
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 19:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652295816;
        bh=sgS8I586wmxDsWEfk8EYenY4Nf+IiynsiclSqvw9c1I=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=APM+OUuxz0Q71LKdL40gVite+fbwNKwg6+VMNJLoq/G6tlH1XJbvRYImhu+2++Umi
         JsOeeZFuukrZVpnHB7HXoe1NrSLDWxH/RLqopHOMjeeVHSZpLUiMgjWNb7LW75o6BX
         QRTx7oIxDHvPsEVw7sugtR6TtZC83Y2u/KzGScwYZBYIsXxmKIXZfPazja0bRPMhAi
         3qbwb3bvfTnibHOz/Z1/VTrQnIxJRM3Yxp/zmyeqCNnwHxLjoR299kQpjQNAGf+bnB
         lZ9NfJuKXaAKp4FIomshX2MjRHBnx8ZulNzODN2Kc6jrm2882UyovgNnlC0iGZYCi7
         gCph4X0krdV0A==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1D84A27C0054;
        Wed, 11 May 2022 15:03:35 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Wed, 11 May 2022 15:03:35 -0400
X-ME-Sender: <xms:hgh8Yu-dz_mlCRNjfcHn9MpXJJV3pxMqwGNHu0olOOtuPbqGIDkAYA>
    <xme:hgh8YusUlQfohxBXD6x1B10kJZ82VE59cjGeDiMm0IH9mHvL-KL8LCK7yTac8JPWu
    fmnyHBIqU6Pdu54NCM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgeehgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdfhuedvtdfhudffhfekkefftefghfeltdelgeffteehueegjeff
    udehgfetiefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:hgh8YkBiSTUpSJDR9W0K_D3Zni7UPGuXHNwVuPtlVuFluNanzWfynw>
    <xmx:hgh8YmfBZ_YXPenT3oE94DDVrH6lERAtxmE4KjRjgyswkU4wEXADUA>
    <xmx:hgh8YjOnJ_vEy9VgIikDXF1o_SSSjBleedcopheJOUpv5ugKYz_iEg>
    <xmx:hwh8Yp3yuDyBI5CFW6tKvuSTODiqwZhhasMLOaDnJGFgU6XVauuJsw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B961331A005D; Wed, 11 May 2022 15:03:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-591-gfe6c3a2700-fm-20220427.001-gfe6c3a27
Mime-Version: 1.0
Message-Id: <7c87b9f7-0a26-41cf-ba34-3dbd37caa2b8@www.fastmail.com>
In-Reply-To: <87o803dijt.fsf@oldenburg.str.redhat.com>
References: <898932fe61db6a9d61bc2458fa2f6049f1ca9f5c.1652290558.git.luto@kernel.org>
 <87o803dijt.fsf@oldenburg.str.redhat.com>
Date:   Wed, 11 May 2022 12:03:14 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Florian Weimer" <fweimer@redhat.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Kees Cook" <keescook@chromium.org>
Subject: Re: [PATCH] x86/vsyscall: Remove CONFIG_LEGACY_VSYSCALL_EMULATE
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, May 11, 2022, at 11:35 AM, Florian Weimer wrote:
> * Andy Lutomirski:
>
>> CONFIG_LEGACY_VSYSCALL_EMULATE is, as far as I know, only needed for the
>> combined use of exotic and outdated debugging mechanisms with outdated
>> binaries.  At this point, no one should be using it.  We would like to
>> implement dynamic switching of vsyscalls, but this is much more
>> complicated to support in EMULATE mode than XONLY mode.
>>
>> So let's force all the distros off of EMULATE mode.  If anyone actually
>> needs it, they can set vsyscall=emulate, and we can then get away with
>> refusing to support newer security models if that option is set.
>>
>> Cc: x86@kernel.org
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Florian Weimer <fweimer@redhat.com>
>> Signed-off-by: Andy Lutomirski <luto@kernel.org>
>
> Sounds a good idea to me.
>
> Acked-by: Florian Weimer <fweimer@redhat.com>
>
> Regarding the mechanics, is it customary to remove the actual code (the
> EMULATE enum constant) in later commits?
>

Might be several versions later. This patch intentionally still supports booting with vsyscall=emulate.
