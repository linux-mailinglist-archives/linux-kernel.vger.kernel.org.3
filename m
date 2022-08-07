Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E325B58BA15
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 09:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbiHGHou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 03:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiHGHot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 03:44:49 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10A0E014;
        Sun,  7 Aug 2022 00:44:46 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 2F0B1320085B;
        Sun,  7 Aug 2022 03:44:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 07 Aug 2022 03:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1659858283; x=1659944683; bh=5d9/rwqUZt
        stDiMvsqxBvpWGetYpjyeQUzf6O3mGQvI=; b=QpQ/pOjhGyLqqI+V01oXceubTQ
        IvjteC/Y/sxlD0LR3XUOpXAiENoOyTHc0VQgxytR549bs9L3UwPlYOxiVbZ8TbVe
        6eGDCDCiG5vnkydhwIAY3JDg/MVLPH2xc+YzzGmC+SFJfcmQVSgWJXI3MYMHDWaM
        1ogEeWa91H+ccQifpMbJA7nPPgGwwhFyHKiWBlIHAcmJrQdtRZxElcWGJJX2sz3d
        kXs8Yt703NeofpSc/KatwpRCyIF5MNVRC92CusKoXZS3v2WyXZLkwbw5xNqvjVqC
        NG80bC0QzzC+hBjNJuEzVyZ03mZFpw5K11pqgPq2YCVIMWPhNeTiMbccWRlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1659858283; x=1659944683; bh=5d9/rwqUZtstDiMvsqxBvpWGetYp
        jyeQUzf6O3mGQvI=; b=O+8Qs3CFiQbPfKSsDlsrCn8DJH5ZHxW3JB2NrwfSz8iy
        kqjcK1TDyvlafIVzjQ0FfEpab/W2Y9B0mkSLDy7sx2JeKlrFBFE8+jbOPXOhPlHb
        gpjNaFdyIzDiOH3LpiYXw/th/84yZVNuumCU5O/QVEe5IIIJc9ehnMfPN1XPlkM8
        8ustDYXP5i0g5GuU/kPYwv5LhzB0oicvLq9TungwyacNMVQkn1DKV8M6GtLp82qs
        5yZiX89DqNOAkNoLXoAlyKBMiYWSO5q9Bi985QAye984nOXUEZuFEZRg5OaqLdi0
        t3fU+qx9DTrTZfGEUpVS5VOYrKtwZboGSWnH66sHWg==
X-ME-Sender: <xms:a23vYimw6aM1IghfKRc4bmwBKpY6PxT8IedpVU6ugdRwJwJOGZ_5rQ>
    <xme:a23vYp3zhvpMNn8gg8cRGmW0tzaYOpj9HsKK4w4nfCJxYVmoX58BAbfHfOUfTqZBJ
    urzu1nwCPXXmsr1SXw>
X-ME-Received: <xmr:a23vYgogcZxnmODGeHsmx0udX7XmxrdsvpTBxSEn-0TwDpWLijXDJL-ml1zf4yvE1C_s4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefhedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvvefkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfhukhgv
    ucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnh
    epvddvgeeltdehfeeijefgveegfeeihfdtveetfeetudfhvedtfeeltefhteegledunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvse
    hljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:a23vYmkMD7lmD4g0paIOItMNe7Qb14Llzj2_RPSUWDjNp2xX9_mkTg>
    <xmx:a23vYg1jngsVkWfk2wiUptJ_WrQmgwF5PNHrXJX8wo8LaPlue6pjGg>
    <xmx:a23vYtt2UFbg5k7lXB_HcH8Pf_eec53EljRAhw7w_WR6hW8fELsx6A>
    <xmx:a23vYuDkm_85-m_9JZFSwy5MFbqcyLfx6JyCPKW8kZ44a4P87av4Dg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Aug 2022 03:44:38 -0400 (EDT)
Date:   Sun, 07 Aug 2022 19:44:23 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH 3/5] asus-wmi: Add support for TUF laptop keyboard states
To:     Pavel Machek <pavel@ucw.cz>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <ZTI8GR.GMVLPPJWYEO53@ljones.dev>
In-Reply-To: <20220805120859.GB20036@duo.ucw.cz>
References: <20220805081909.10962-1-luke@ljones.dev>
        <20220805081909.10962-4-luke@ljones.dev> <20220805120859.GB20036@duo.ucw.cz>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

I'm sorry but can you direct me to a source file or other that shows 
use of "pattern trigger". I don't know what this means or what to look 
for. From your response it seems I should certainly be using it.

I've finished with all the feedback I've received so far, and this is 
the last piece.

Kind regards,
Luke.

On Fri, Aug 5 2022 at 14:08:59 +0200, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>> 
>>  Adds two paths:
>>  - /sys/devices/platform/asus-nb-wmi/keyboard_rgb_state
>>  - /sys/devices/platform/asus-nb-wmi/keyboard_rgb_state_index
> 
> Patches 2-3 -- we already have pattern trigger. This should use it...
> 
> Best regards,
> 									Pavel
> --
> People of Russia, stop Putin before his war on Ukraine escalates.


