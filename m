Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B864DDBD6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbiCROnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237374AbiCROmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:42:45 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278D772E1B;
        Fri, 18 Mar 2022 07:41:27 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:50150)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nVDnB-00CHeb-JB; Fri, 18 Mar 2022 08:41:25 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38502 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nVDnA-006EQS-3D; Fri, 18 Mar 2022 08:41:24 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>, linux-api@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
        <87bl1kunjj.fsf@email.froward.int.ebiederm.org>
        <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
        <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
        <87tubyx0rg.fsf_-_@email.froward.int.ebiederm.org>
        <875yoe7qdp.fsf_-_@email.froward.int.ebiederm.org>
        <20220317180856.GB13318@redhat.com>
Date:   Fri, 18 Mar 2022 09:40:48 -0500
In-Reply-To: <20220317180856.GB13318@redhat.com> (Oleg Nesterov's message of
        "Thu, 17 Mar 2022 19:08:57 +0100")
Message-ID: <87r16z2uj3.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nVDnA-006EQS-3D;;;mid=<87r16z2uj3.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18ZjnnYjbyuB5jXx+RBFTyIAWv+eFlbsBQ=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 538 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 9 (1.7%), b_tie_ro: 8 (1.4%), parse: 1.37 (0.3%),
        extract_message_metadata: 4.2 (0.8%), get_uri_detail_list: 1.25 (0.2%),
         tests_pri_-1000: 4.7 (0.9%), tests_pri_-950: 1.83 (0.3%),
        tests_pri_-900: 1.13 (0.2%), tests_pri_-90: 209 (38.8%), check_bayes:
        207 (38.4%), b_tokenize: 5.0 (0.9%), b_tok_get_all: 6 (1.0%),
        b_comp_prob: 2.7 (0.5%), b_tok_touch_all: 189 (35.2%), b_finish: 1.11
        (0.2%), tests_pri_0: 280 (52.0%), check_dkim_signature: 0.76 (0.1%),
        check_dkim_adsp: 3.7 (0.7%), poll_dns_idle: 1.07 (0.2%), tests_pri_10:
        3.5 (0.7%), tests_pri_500: 12 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/2] ptrace: Return the signal to continue with from
 ptrace_stop
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> Not sure I understand this patch, I can't apply it. I guess I need to
> clone your tree first, will do later.

Yes this series is on top of:
  https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git kill-tracehook-for-v5.18

Nothing particularly interesting happens in my kill tracehook series
but I do get rid of tracehook.h and so everything gets moved and
renamed.

Eric
