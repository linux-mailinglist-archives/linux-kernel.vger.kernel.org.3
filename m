Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4AE4A9C2F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359817AbiBDPqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiBDPqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:46:11 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62238C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 07:46:11 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id e79so7763742iof.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 07:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:mime-version:message-id:in-reply-to:references:date:from
         :to:cc:subject;
        bh=4aCq0mzw9NmAK/zJPt93oXn7Z3rIAq9YXf3GiE58uMI=;
        b=iGjgMfQC3LPcxFpFUdo8wwxbqZRhr+vxcxZiZZ7Y49anzqxwv0iZVZi1yMV32CZ5SU
         NCh5mKLiTqOqtHRkIupA2KKT4fXDKG2fK/Xzu4F6f0uO41F5MSOS60NkdxruOgsPOrn3
         Rvr8OuHOzoGbQhr5n4aMzLrPLHaS349nS7UEASpb7xivNmDJAjnDg6cigfQq/sNqp5tD
         mzGon2zE8aMpifLt9ITOFHitCaT0Y2Qp4WYRKgYhrSO0hj1LnLFseoGoCUzJp//w0+ES
         EVBAUjBv3/7cewm/sKiUn3S2FuTRGzYSqoBGQt5M+BAF/WwcTRVo/s0SXnrCCpw+Y3Og
         pO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:user-agent:mime-version:message-id:in-reply-to
         :references:date:from:to:cc:subject;
        bh=4aCq0mzw9NmAK/zJPt93oXn7Z3rIAq9YXf3GiE58uMI=;
        b=pERI5sPmo6bRoz4JZdKuLAcqN67kHlihR+3Ms/EbueCZLzv751I4YW/xTIe+BBfAdQ
         vyEeNaDkAGgDRX2M9QtXsCBmtf2cZ9di1bGL9otn6P5jDAL0VdQ/lcfkh04PvLEzLZom
         ofWSvqNKRAtCb3+hDtCgMJtqrgHaW6Q6OS+J2Yvl/p3ceuz6k0e92FPlJdfG5B3i3dfD
         ML9FCbrptYJk3R6C/ShxWUETN9j8fW8CCeFAeKOizFZDO+tFtnCaV3AFL6CPIcoojHBv
         Vc6nP6y1gphUjR/wGbZe2EX2kW3NoVbQd/v56X+vMfut127CatBimpeCDJbK888Nq7da
         awrw==
X-Gm-Message-State: AOAM532XP6ANyflw6o/yfbElf46L4YsGoYetZOhwHdjdrseB1olGR4qc
        LXKnQnR25CD0c06T+k9gcSk=
X-Google-Smtp-Source: ABdhPJypdWCNloZLhq4O0nsyPQJ2kbQvU4V81FvqXlPCja6RetbqJe2cll6PslVQCHW43zDJ6HwpfA==
X-Received: by 2002:a05:6602:492:: with SMTP id y18mr1423331iov.95.1643989570768;
        Fri, 04 Feb 2022 07:46:10 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id d7sm1097873ila.72.2022.02.04.07.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 07:46:09 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id DA86627C005B;
        Fri,  4 Feb 2022 10:46:08 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Fri, 04 Feb 2022 10:46:08 -0500
X-ME-Sender: <xms:P0r9YQDgIPVzB9qL1yEbo7jRBQmd_Sk0oOhvWcT8Yu2na29y3rHFvA>
    <xme:P0r9YSh8NbBxk0ZyGOO_8DrS-e2DAhaTTzJ-loyp2-vshezArzK0FcieV3YbEw1Zx
    sisImAPRXeAsXr2OQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeelgdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfuehoqhhu
    nhcuhfgvnhhgfdcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepudekgedtfefggeeiueeiteduieehgfegheeigfffgfeggfekieeiffel
    vdehudefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:P0r9YTklkjCtewPs7BBP7-apvmqid2BYcg7wpOrBKTJ9pYuT1z052Q>
    <xmx:P0r9YWx7Gv-fvnTm5E7ss-xuIP39ob6RH-ObXFdf6IEmSoTwbMKEXA>
    <xmx:P0r9YVRZ_RRoZFSNH3a7jfR3ywKIfjwAKeCco5N8hRtupYPRLakgQg>
    <xmx:QEr9YXfPQQ5y4I0cN_z7z-0AWndfa95IcuMxUW6kPW-Nkz88fA5LvQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CEB57FA0AA8; Fri,  4 Feb 2022 10:46:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4586-g104bd556f9-fm-20220203.002-g104bd556
Mime-Version: 1.0
Message-Id: <b79c521a-f857-41fa-8bba-ee013f5e4fa8@www.fastmail.com>
In-Reply-To: <Yf0K8oxan1NvjKmE@FVFF77S0Q05N>
References: <20220203161243.3955547-1-mark.rutland@arm.com>
 <YfxxSX3v6nSJ0tKo@tardis> <Yf0K8oxan1NvjKmE@FVFF77S0Q05N>
Date:   Fri, 04 Feb 2022 23:45:47 +0800
From:   "Boqun Feng" <boqun.feng@gmail.com>
To:     "Mark Rutland" <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, ardb@kernel.org, arnd@arndb.de,
        "Peter Zijlstra" <peterz@infradead.org>, will@kernel.org
Subject: Re: [PATCH v2] atomics: fix atomic64_{read_acquire,set_release} fallbacks
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Feb 4, 2022, at 7:16 PM, Mark Rutland wrote:
> On Fri, Feb 04, 2022 at 08:20:25AM +0800, Boqun Feng wrote:
>> On Thu, Feb 03, 2022 at 04:12:43PM +0000, Mark Rutland wrote:
>> > diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
>> > index a3dba31df01e..6db58d180866 100644
>> > --- a/include/linux/atomic/atomic-arch-fallback.h
>> > +++ b/include/linux/atomic/atomic-arch-fallback.h
>> > @@ -151,7 +151,16 @@
>> >  static __always_inline int
>> >  arch_atomic_read_acquire(const atomic_t *v)
>> >  {
>> > -	return smp_load_acquire(&(v)->counter);
>> > +	int ret;
>> > +
>> > +	if (__native_word(atomic_t)) {
>> > +		ret = smp_load_acquire(&(v)->counter);
>> > +	} else {
>> > +		ret = arch_atomic_read(v);
>> > +		__atomic_acquire_fence();
>> > +	}
>> > +
>> > +	return ret;
>> >  }
>> >  #define arch_atomic_read_acquire arch_atomic_read_acquire
>> >  #endif
>> > @@ -160,7 +169,12 @@ arch_atomic_read_acquire(const atomic_t *v)
>> >  static __always_inline void
>> >  arch_atomic_set_release(atomic_t *v, int i)
>> >  {
>> > -	smp_store_release(&(v)->counter, i);
>> > +	if (__native_word(atomic_t)) {
>> > +		smp_store_release(&(v)->counter, i);
>> > +	} else {
>> > +		__atomic_release_fence();
>> > +		arch_atomic_set(v, i);
>> > +	}
>> >  }
>> 
>> The changes for atomic_t are not necessary, right? They are correct but
>> "side effects" because of the change in scripts.
>
> Correct -- those aren't necessary, but aren't harmful, and it's simpler to have
> than than it is to special-case the scripts.
>
>> If so, it's better to mention this somewhere.
>
> Sure; how about I add the following to the commit message:
>
> | Since the fallback templates are used to generate the atomic64_*() and
> | atomic_*() operations, the __native_word() check is added to both. For
> | the atomic_*() operations, which are always 32-bit, the __native_word()
> | check is redundant but not harmful, as it is always true.
>
> ... ?
>

Looks good to me!

Regards,
Boqun

> Thanks,
> Mark.
