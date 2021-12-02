Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2AE466206
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357148AbhLBLJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:09:29 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:34621 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237400AbhLBLJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:09:27 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E811B320152C;
        Thu,  2 Dec 2021 06:06:03 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute3.internal (MEProxy); Thu, 02 Dec 2021 06:06:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm3; bh=FDOzHcF5ovrdFj5eVBCoCkU4ZS0u
        zh4hDCHusrpsRdI=; b=HKfTwARhi7SRFaZDHdsWPa6vG6Z8HPzdS8uMemnKuvdX
        nmwAlK6N0XLZmRULvHtPXUfhaTkMtjaSzSS1yJtWqS/TYiZF+GUXSUhKyPc2Ldrp
        SF92R+MlVZKz84Z0tQpcRX2zowV+LpSQZ1Z4AtdjkyfXFIvdCvDd5Wwu95e6p2z+
        zmpKxyNi3gFZ4cZd6hFymr4o/bDiKG3yPavRLQF6vrrkwpykRmOC5tCDMYWUxIAF
        a96sohyXRTvSwDqRyKFV50/Y6S2Yz4uvZnn7zNzkJDfehiC7wh5k4CbO0NYk/2y9
        duEd4KAAj25aBRzpK2kA3PRFoMfimajhbC1WJYEemQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=FDOzHc
        F5ovrdFj5eVBCoCkU4ZS0uzh4hDCHusrpsRdI=; b=SAhUzluUDtNaYXEcYiVgQ8
        SX9xFJHbgauGGywfb3mhyqUgQzXGRJRjjYb09f/rICYfoyTRuHTeZJJoAHeSHW9j
        XM3fbCAvdnw9IQ+/OvCW3qQ+znAuYcxiaNMgKjadI6XODhhWl8Um1Kz9e5zsDo4U
        11ggWWqiMY+EjVgNm0qBbgTMfPWsi5vsC1n2HS/9Q0T2e55IhV6KucbsEMKs++rJ
        dVAA68C9XDgcroXJrqtGKP+4RDmASXgXVqJJkNFgq5qrwl+lKqAZ7RqFIZI+YVVB
        5hdIuPz4Fb06NRy2BSggNr2aqTgrmfbR5mGnf7Dv6Vke9SziBNhEopC/CzXSF27w
        ==
X-ME-Sender: <xms:maioYd2_3sJ4ZGVwNV8MQ-D3Iau2EDRcCJvbcOCazeNnwpKGChI1Cw>
    <xme:maioYUFb6ubxGit2Ihmp6ARGc1uCgjqDWreFPX87NxqbgBZJaycHzRn2LNkb59IFT
    Ehqvk94a8HUKKXHrhI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieehgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhvvghn
    ucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrth
    htvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudehvdef
    keffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    hvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:maioYd6YEVUDYmW2pVAwaUaSHzNEh1GozTs5ok42XTiICYQAgxjKHQ>
    <xmx:maioYa32YL0jkX3yfmv8dADi6rvJBKx_F89r_55aUwI0zFPaeHdgeA>
    <xmx:maioYQE6qGmYW988nAm41oHpz78AxlOgibbIJeYM2X-SL1hLdGieSQ>
    <xmx:m6ioYb03FSKIIy_EQH-ai6iiKag_Gr9hB5nhh0zzJKo8KzLZWks6wQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BF55C27407A2; Thu,  2 Dec 2021 06:06:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4458-g51a91c06b2-fm-20211130.004-g51a91c06
Mime-Version: 1.0
Message-Id: <0abd0537-3485-4b6c-9299-158d26224466@www.fastmail.com>
In-Reply-To: <ca52e4ee-b5f3-b892-1ba5-7c5656e45fdd@marcan.st>
References: <20211113094732.73889-1-sven@svenpeter.dev>
 <20211113094732.73889-2-sven@svenpeter.dev> <YY/YnlCxLqdw/zAo@sunset>
 <95dea968-f452-4ba0-9b66-c9bc4269a52c@www.fastmail.com>
 <YZEMmH49D+GZEewi@sunset> <ca52e4ee-b5f3-b892-1ba5-7c5656e45fdd@marcan.st>
Date:   Thu, 02 Dec 2021 12:05:41 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>
Cc:     "Wim Van Sebroeck" <wim@linux-watchdog.org>,
        "Guenter Roeck" <linux@roeck-us.net>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Mark Kettenis" <mark.kettenis@xs4all.nl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] watchdog: Add Apple SoC watchdog driver
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, Dec 2, 2021, at 06:14, Hector Martin wrote:
> On 14/11/2021 22.18, Alyssa Rosenzweig wrote:
>>>>> + * This HW block has three separate watchdogs. WD0 resets the machine
>>>>> + * to recovery mode and is not very useful for us. WD1 and WD2 trigger a normal
>>>>> + * machine reset. WD0 additionally supports a configurable interrupt.
>>>>
>>>> Do we have any idea what the difference between WD1 and WD2 is?
>>>
>>> I've never seen macOS write to WD2 when running in our hypervisor and only
>>> found that one when I was looking at the rest of the MMIO region.
>>> >From what I can tell it works exactly like WD1.
>> 
>> Makes sense, thanks.
>> 
>
> Are any of these watchdogs active when we boot, and are we leaving them 
> like that? I'm pretty sure at least some of the coprocessors have their 
> own watchdog (SMC...), which might be one of these. We should make sure 
> we don't clobber that.

That's what I thought at first as well but they are all disabled except for
WD1 which we disable in m1n1.
I don't touch WD0 or WD2 in this driver anyway and v2 also checks if WD1 is
running (because it might've been started by u-boot) and makes sure the
watchdog core is aware and keeps pinging it.


Sven
