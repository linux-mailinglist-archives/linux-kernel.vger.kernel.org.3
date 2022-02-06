Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D46F4AB2E0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 01:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242980AbiBGADe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 19:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242994AbiBGADc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 19:03:32 -0500
X-Greylist: delayed 571 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 16:03:30 PST
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E912C06173B;
        Sun,  6 Feb 2022 16:03:29 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E5B52360FCC;
        Sun,  6 Feb 2022 18:53:56 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qCDmv1sssdj6; Sun,  6 Feb 2022 18:53:56 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 423253611AC;
        Sun,  6 Feb 2022 18:53:56 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 423253611AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1644191636;
        bh=7H047Zo1N1+uZqBGqXhve5zp5Ovo3/WcmoeG+ihz6CE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=T3VDDiv0Touz7GFuXOYpoI9oCLZQcc5rkph0H/dhTifNqJqTLNPVFaW6qipYb0vXp
         G2j7k1+gosinc5vBCItDhTo64jERJCxAdOGy15QjRitw58Y4Pj5F5pQhhUe53RLxnJ
         sje8HmE7S3mk6FjnH1r15l+b8tjZScBY0hZaInsgYrpFIpwSNPj9JPGUQXDghX968g
         oTvbpapOGpSQKLuwrkDoaWmC2d6sGf89N1zlwvoMf1+kET/IElELdzWkmo1Ppo4Dxd
         AcSsc3OqGD/jQmdYVTAMeKiOH2B1xplTqOy+5W0jXH2QL+WF01Mb7Nbugh4y7AI7CS
         5oxp4+u3Bkhgg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QUeyeigDF4Rh; Sun,  6 Feb 2022 18:53:56 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 2E1F5360D6D;
        Sun,  6 Feb 2022 18:53:56 -0500 (EST)
Date:   Sun, 6 Feb 2022 18:53:56 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        David Laight <David.Laight@aculab.com>,
        carlos <carlos@redhat.com>, Peter Oskolkov <posk@posk.io>,
        libc-coord@lists.openwall.com
Message-ID: <1576236784.46087.1644191636055.JavaMail.zimbra@efficios.com>
In-Reply-To: <YgBCdExhei7VmfHd@hirez.programming.kicks-ass.net>
References: <20220203193853.21511-1-mathieu.desnoyers@efficios.com> <YgBCdExhei7VmfHd@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH 1/3] rseq: Introduce feature size and alignment ELF
 auxiliary vector entries
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4203)
Thread-Topic: rseq: Introduce feature size and alignment ELF auxiliary vector entries
Thread-Index: H40c2UEJQsV5nzI4UFsy4Q8I+aXV2A==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 6, 2022, at 4:49 PM, Peter Zijlstra peterz@infradead.org wrote:

> On Thu, Feb 03, 2022 at 02:38:51PM -0500, Mathieu Desnoyers wrote:
> 
>> @@ -286,6 +287,10 @@ create_elf_tables(struct linux_binprm *bprm, const struct
>> elfhdr *exec,
>>  	if (bprm->have_execfd) {
>>  		NEW_AUX_ENT(AT_EXECFD, bprm->execfd);
>>  	}
>> +#ifdef CONFIG_RSEQ
>> +	NEW_AUX_ENT(AT_RSEQ_FEATURE_SIZE, offsetof(struct rseq, end));
> 
> I've gotta ask, what's up with offsetof(, end) vs sizeof() ?

sizeof() includes the 12 bytes of padding at the end of struct rseq, for a
total of 32 bytes (currently). offsetof(, end) is currently 20 bytes, which
is the offset exactly after the last field.

For the "feature size" (meaning the populated fields), we really want a size
that excludes padding.

Thanks,

Mathieu

> 
>> +	NEW_AUX_ENT(AT_RSEQ_ALIGN, __alignof__(struct rseq));
> > +#endif

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
