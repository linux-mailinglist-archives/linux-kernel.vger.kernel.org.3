Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D9E532250
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 06:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbiEXExl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 00:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiEXExg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 00:53:36 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728BE62A1D
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 21:53:35 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:54206)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ntMY1-00Bvid-66; Mon, 23 May 2022 22:53:33 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:39174 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ntMY0-0071W8-5W; Mon, 23 May 2022 22:53:32 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220520094459.116240-1-Jason@zx2c4.com>
        <Yoey+FOYO69lS5qP@zx2c4.com>
        <bbdeeca7-9c99-e661-6596-f04ea783a30b@kernel.dk>
        <Yoe4HP9iTA6l/For@zeniv-ca.linux.org.uk>
        <7e78d6a7-1cc3-2408-fe91-0329f5020e77@kernel.dk>
        <Yoe+lK8RIRbK6lDZ@zeniv-ca.linux.org.uk>
        <69bd18e6-d216-dfb3-201b-f6a285deb0e7@kernel.dk>
        <YofEU1ticqujwJdj@zx2c4.com>
        <247ac77e-15e0-8612-2507-7bbac80af824@kernel.dk>
Date:   Mon, 23 May 2022 23:52:57 -0500
In-Reply-To: <247ac77e-15e0-8612-2507-7bbac80af824@kernel.dk> (Jens Axboe's
        message of "Fri, 20 May 2022 10:41:12 -0600")
Message-ID: <87h75fwmza.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ntMY0-0071W8-5W;;;mid=<87h75fwmza.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18cLxvV7JryUCAMk8wwYfAC4T/wbsCw3uA=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *****;Jens Axboe <axboe@kernel.dk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 441 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.5%), b_tie_ro: 10 (2.2%), parse: 0.90
        (0.2%), extract_message_metadata: 12 (2.6%), get_uri_detail_list: 1.64
        (0.4%), tests_pri_-1000: 5 (1.2%), tests_pri_-950: 1.20 (0.3%),
        tests_pri_-900: 0.94 (0.2%), tests_pri_-90: 84 (19.2%), check_bayes:
        83 (18.7%), b_tokenize: 7 (1.5%), b_tok_get_all: 9 (2.0%),
        b_comp_prob: 2.8 (0.6%), b_tok_touch_all: 60 (13.6%), b_finish: 1.23
        (0.3%), tests_pri_0: 297 (67.3%), check_dkim_signature: 1.09 (0.2%),
        check_dkim_adsp: 2.9 (0.7%), poll_dns_idle: 0.53 (0.1%), tests_pri_10:
        4.1 (0.9%), tests_pri_500: 21 (4.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v4 0/3] random: convert to using iters, for Al Viro
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 5/20/22 10:39 AM, Jason A. Donenfeld wrote:
>> Hi Jens,
>> 
>> On Fri, May 20, 2022 at 10:24:36AM -0600, Jens Axboe wrote:
>>> On 5/20/22 10:15 AM, Al Viro wrote:
>>>> IIRC, Linus' position at the time had been along the lines of
>>>> "splice is not so good ABI anyway, so let's do it and fix up
>>>> the places that do get real-world complaints once such appear".
>>>> So /dev/urandom is one such place...
>>>
>>> That's what Christoph said too. Honestly that's a very odd way to
>>> attempt to justify breakage like this, even if it is tempting to
>>> facilitate the set_fs() removal. But then be honest about it and say
>>> it like it is, rather than some hand wavy explanation that frankly
>>> doesn't make any sense.
>>>
>>> The referenced change doesn't change the splice ABI at all, hence the
>>> justification seems very random to me. It kept what we already have,
>>> except we randomly break some use cases.
>>  
>> It looks like Al is right in the sense that Linus must certainly be
>> aware of the breakage. He fixed tty in 9bb48c82aced ("tty: implement
>> write_iter").
>
> I don't think anyone is disputing that, but I also know that Linus wants
> these fixed up as they are discovered. And I agree with him on that,
> even if I disagree on the process to get there as it introduced
> frivolous breakage...

I believe the hypothesis at the time was that on many of these
interfaces splice is not used on them so it did matter.

With everything being fixed in the places the hypothesis turned out to
be wrong.

The rule is no regressions, not bug comparability forever.  This allows
things like removing a.out binary support, and many other things that
are just dead code these days.

Sometimes the only way to discover what has users is to remove support
and wait a while and see if anyone complains.  Sometimes doing that
is worth it, other times it is not.

My general sense is that there have been few enough reports that users
who care about splice support have been few and far between.  Which
suggests the hypothesis was not an unreasonable one when Linus made it.

The truly unfortunate part is that no one knew enough about these users
to be able to step up and say that they care about splice on those
interfaces at the start of this process.

Eric
