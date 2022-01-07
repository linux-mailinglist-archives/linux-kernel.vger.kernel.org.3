Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECAC948732B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 07:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbiAGGry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 01:47:54 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:60106 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiAGGrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 01:47:53 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:46758)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n5j2S-00G7H9-E7; Thu, 06 Jan 2022 23:47:48 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:34768 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n5j2Q-001kgS-V6; Thu, 06 Jan 2022 23:47:48 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Hongchen Zhang <zhanghongchen@loongson.cn>
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ye Guojin <ye.guojin@zte.com.cn>, linux-kernel@vger.kernel.org
References: <1641530757-3835-1-git-send-email-zhanghongchen@loongson.cn>
Date:   Fri, 07 Jan 2022 00:47:18 -0600
In-Reply-To: <1641530757-3835-1-git-send-email-zhanghongchen@loongson.cn>
        (Hongchen Zhang's message of "Fri, 7 Jan 2022 12:45:57 +0800")
Message-ID: <878rvsyrd5.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n5j2Q-001kgS-V6;;;mid=<878rvsyrd5.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/mKt1SOkelGD15NWOL4cj4PerHwQOKNrQ=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3441]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Hongchen Zhang <zhanghongchen@loongson.cn>
X-Spam-Relay-Country: 
X-Spam-Timing: total 871 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.7 (0.5%), b_tie_ro: 3.2 (0.4%), parse: 1.09
        (0.1%), extract_message_metadata: 11 (1.3%), get_uri_detail_list: 1.59
        (0.2%), tests_pri_-1000: 4.1 (0.5%), tests_pri_-950: 1.10 (0.1%),
        tests_pri_-900: 0.88 (0.1%), tests_pri_-90: 55 (6.3%), check_bayes: 54
        (6.2%), b_tokenize: 4.7 (0.5%), b_tok_get_all: 7 (0.8%), b_comp_prob:
        1.71 (0.2%), b_tok_touch_all: 38 (4.3%), b_finish: 0.73 (0.1%),
        tests_pri_0: 243 (27.9%), check_dkim_signature: 0.37 (0.0%),
        check_dkim_adsp: 2.8 (0.3%), poll_dns_idle: 516 (59.3%), tests_pri_10:
        2.6 (0.3%), tests_pri_500: 544 (62.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] signal: strict valid signal check
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hongchen Zhang <zhanghongchen@loongson.cn> writes:

> The max usable signal number is limited by both _NSIG and task's
> exit_code, and the max valid signal number encoded in task's
> exit_code is 127. On the other hand _NSIG is normally power of 2,
> so limit the rule in valid_signal to check a valid signal number.

A quick look reveals this only affects mips.

If you have copied that silliness from mips for your new architecture
I would advise against it.  That just seems to make sigset_t twice
as big as it needs to be for no good reason.

What seems reasonable is to fix mips to only support 127 signals (with
the same sigset_t size) and to add "BUILD_BUG_ON(_NSIG <= 127);" along
with your comment somewhere in kernel/signal.c

Eric


> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> ---
>  include/linux/signal.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/signal.h b/include/linux/signal.h
> index a6db6f2..9f1972e 100644
> --- a/include/linux/signal.h
> +++ b/include/linux/signal.h
> @@ -270,7 +270,11 @@ static inline void init_sigpending(struct sigpending *sig)
>  /* Test if 'sig' is valid signal. Use this instead of testing _NSIG directly */
>  static inline int valid_signal(unsigned long sig)
>  {
> -	return sig <= _NSIG ? 1 : 0;
> +	/* max usable signal number is limited by both _NSIG and task's
> +	 * exit_code, and the max available signal number encoded in
> +	 * task's exit_code is 127.
> +	 */
> +	return sig <= min(_NSIG, 127) ? 1 : 0;
>  }
>  
>  struct timespec;
