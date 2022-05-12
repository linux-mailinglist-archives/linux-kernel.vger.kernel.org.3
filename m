Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEB45254D8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 20:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357674AbiELS3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 14:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245317AbiELS3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 14:29:15 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EDD246D88;
        Thu, 12 May 2022 11:29:14 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:44196)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1npDYm-008rCX-Sm; Thu, 12 May 2022 12:29:12 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37958 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1npDYl-006a2d-Ri; Thu, 12 May 2022 12:29:12 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
References: <20220502140602.130373-1-Jason@zx2c4.com>
        <Ym/5EEYHbk56hV1H@zx2c4.com> <Ym/8GTW2RfhnbqiF@gardel-login>
        <YnERsPIsiOCa8cty@zx2c4.com> <Yn1GmlWKIvuoJJby@bombadil.infradead.org>
Date:   Thu, 12 May 2022 13:29:04 -0500
In-Reply-To: <Yn1GmlWKIvuoJJby@bombadil.infradead.org> (Luis Chamberlain's
        message of "Thu, 12 May 2022 10:40:42 -0700")
Message-ID: <87bkw2hafj.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1npDYl-006a2d-Ri;;;mid=<87bkw2hafj.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19z8d4cn9BlzeY/RlkWUjeYBV1bt7jFUbE=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Luis Chamberlain <mcgrof@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 456 ms - load_scoreonly_sql: 0.15 (0.0%),
        signal_user_changed: 12 (2.6%), b_tie_ro: 10 (2.2%), parse: 1.08
        (0.2%), extract_message_metadata: 14 (3.0%), get_uri_detail_list: 2.1
        (0.5%), tests_pri_-1000: 12 (2.5%), tests_pri_-950: 1.34 (0.3%),
        tests_pri_-900: 1.08 (0.2%), tests_pri_-90: 98 (21.5%), check_bayes:
        96 (21.0%), b_tokenize: 7 (1.6%), b_tok_get_all: 9 (1.9%),
        b_comp_prob: 2.9 (0.6%), b_tok_touch_all: 71 (15.6%), b_finish: 1.72
        (0.4%), tests_pri_0: 302 (66.2%), check_dkim_signature: 0.96 (0.2%),
        check_dkim_adsp: 4.6 (1.0%), poll_dns_idle: 1.04 (0.2%), tests_pri_10:
        2.1 (0.5%), tests_pri_500: 9 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/2] sysctl: read() must consume poll events, not poll()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luis Chamberlain <mcgrof@kernel.org> writes:

> On Tue, May 03, 2022 at 01:27:44PM +0200, Jason A. Donenfeld wrote:
>> On Mon, May 02, 2022 at 05:43:21PM +0200, Lennart Poettering wrote:
>> > On Mo, 02.05.22 17:30, Jason A. Donenfeld (Jason@zx2c4.com) wrote:
>> > 
>> > > Just wanted to double check with you that this change wouldn't break how
>> > > you're using it in systemd for /proc/sys/kernel/hostname:
>> > >
>> > > https://github.com/systemd/systemd/blob/39cd62c30c2e6bb5ec13ebc1ecf0d37ed015b1b8/src/journal/journald-server.c#L1832
>> > > https://github.com/systemd/systemd/blob/39cd62c30c2e6bb5ec13ebc1ecf0d37ed015b1b8/src/resolve/resolved-manager.c#L465
>> > >
>> > > I couldn't find anybody else actually polling on it. Interestingly, it
>> > > looks like sd_event_add_io uses epoll() inside, but you're not hitting
>> > > the bug that Jann pointed out (because I suppose you're not poll()ing on
>> > > an epoll fd).
>> > 
>> > Well, if you made sure this still works, I am fine either way ;-)
>> 
>> Actually... ugh. It doesn't work. systemd uses uname() to read the host
>> name, and doesn't actually read() the file descriptor after receiving
>> the poll event on it. So I guess I'll forget this, and maybe we'll have
>> to live with sysctl's poll() being broken. :(

We should be able to modify calling uname() to act the same as reading
the file descriptor. 

> A kconfig option may let you do what you want, and allow older kernels
> to not break, however I am more curious how sysctl's approach to poll
> went unnnoticed for so long. But also, I'm curious if it was based on
> another poll implementation which may have been busted.
>
> But more importantly, how do we avoid this in the future?

Poll on files is weird and generally doesn't work (because files are
always read to read or write).  What did we do to make it work on these
sysctl files?

Eric
