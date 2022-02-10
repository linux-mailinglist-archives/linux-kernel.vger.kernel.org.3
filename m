Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59EA4B151A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 19:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245630AbiBJSSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 13:18:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245650AbiBJSR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 13:17:58 -0500
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B244EC4B;
        Thu, 10 Feb 2022 10:17:59 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:41096)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nIE10-00AGdg-LX; Thu, 10 Feb 2022 11:17:58 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:41388 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nIE0z-00Dbz8-QO; Thu, 10 Feb 2022 11:17:58 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Robert =?utf-8?B?xZp3acSZY2tp?= <robert@swiecki.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20220210025321.787113-1-keescook@chromium.org>
Date:   Thu, 10 Feb 2022 12:17:50 -0600
In-Reply-To: <20220210025321.787113-1-keescook@chromium.org> (Kees Cook's
        message of "Wed, 9 Feb 2022 18:53:18 -0800")
Message-ID: <871r0a8u29.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nIE0z-00Dbz8-QO;;;mid=<871r0a8u29.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/0ElVN4jF3VxNbNbK8Cp+alPjWl5IMXlo=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 265 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 14 (5.2%), b_tie_ro: 12 (4.4%), parse: 0.97
        (0.4%), extract_message_metadata: 13 (4.9%), get_uri_detail_list: 0.85
        (0.3%), tests_pri_-1000: 12 (4.6%), tests_pri_-950: 1.45 (0.5%),
        tests_pri_-900: 1.22 (0.5%), tests_pri_-90: 64 (24.1%), check_bayes:
        62 (23.4%), b_tokenize: 4.4 (1.7%), b_tok_get_all: 6 (2.4%),
        b_comp_prob: 2.0 (0.8%), b_tok_touch_all: 44 (16.8%), b_finish: 1.16
        (0.4%), tests_pri_0: 143 (54.1%), check_dkim_signature: 0.52 (0.2%),
        check_dkim_adsp: 2.7 (1.0%), poll_dns_idle: 0.78 (0.3%), tests_pri_10:
        2.4 (0.9%), tests_pri_500: 9 (3.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/3] signal: HANDLER_EXIT should clear SIGNAL_UNKILLABLE
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> Hi,
>
> This fixes the signal refactoring to actually kill unkillable processes
> when receiving a fatal SIGSYS from seccomp. Thanks to Robert for the
> report and Eric for the fix! I've also tweaked seccomp internal a bit to
> fail more safely. This was a partial seccomp bypass, in the sense that
> SECCOMP_RET_KILL_* didn't kill the process, but it didn't bypass other
> aspects of the filters. (i.e. the syscall was still blocked, etc.)

Any luck on figuring out how to suppress the extra event?
>
> I'll be sending this to Linus after a bit more testing...
>
> Thanks,
>
> -Kees
>
> Kees Cook (3):
>   signal: HANDLER_EXIT should clear SIGNAL_UNKILLABLE
>   seccomp: Invalidate seccomp mode to catch death failures
>   samples/seccomp: Adjust sample to also provide kill option
>
>  kernel/seccomp.c          | 10 ++++++++++
>  kernel/signal.c           |  5 +++--
>  samples/seccomp/dropper.c |  9 +++++++--
>  3 files changed, 20 insertions(+), 4 deletions(-)

Eric
