Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66EDB473206
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238255AbhLMQlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:41:00 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:50190 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240928AbhLMQk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:40:57 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:52960)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mwoNj-007PXD-Gq; Mon, 13 Dec 2021 09:40:55 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:42090 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mwoNh-00BUaK-Kn; Mon, 13 Dec 2021 09:40:55 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
References: <20211212204043.231568-1-hjl.tools@gmail.com>
Date:   Mon, 13 Dec 2021 10:40:47 -0600
In-Reply-To: <20211212204043.231568-1-hjl.tools@gmail.com> (H. J. Lu's message
        of "Sun, 12 Dec 2021 12:40:43 -0800")
Message-ID: <87wnk8xxtc.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mwoNh-00BUaK-Kn;;;mid=<87wnk8xxtc.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19pbTH4z+6uLN0ot5gSwteXaqMMOjqQ5Pc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4997]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;"H.J. Lu" <hjl.tools@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1297 ms - load_scoreonly_sql: 0.10 (0.0%),
        signal_user_changed: 12 (0.9%), b_tie_ro: 10 (0.7%), parse: 1.12
        (0.1%), extract_message_metadata: 13 (1.0%), get_uri_detail_list: 1.74
        (0.1%), tests_pri_-1000: 16 (1.3%), tests_pri_-950: 1.42 (0.1%),
        tests_pri_-900: 1.07 (0.1%), tests_pri_-90: 54 (4.2%), check_bayes: 53
        (4.1%), b_tokenize: 6 (0.5%), b_tok_get_all: 7 (0.5%), b_comp_prob:
        2.4 (0.2%), b_tok_touch_all: 34 (2.6%), b_finish: 0.92 (0.1%),
        tests_pri_0: 1183 (91.3%), check_dkim_signature: 0.72 (0.1%),
        check_dkim_adsp: 2.7 (0.2%), poll_dns_idle: 0.90 (0.1%), tests_pri_10:
        2.3 (0.2%), tests_pri_500: 9 (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2] fs/binfmt_elf.c: disallow invalid entry point address
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"H.J. Lu" <hjl.tools@gmail.com> writes:

> On Linux, the start of the first PT_LOAD segment is the ELF header and
> the address 0 points to the ELF magic bytes.  Update the ELF loader to
> disallow ELF binaries with entry point address smaller than the ELF
> header size.

I kind of get why that was suggested but there is most definitely no
requirement for the program headers to be loaded let alone be at any
particular virtual address.  We could be talking about a static elf
binary.

> This fixes:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=215303
>
> Tested by booting Fedora 35 and running a shared library with invalid
> entry point address:
>
> $ readelf -h load.so | grep "Entry point address:"
>   Entry point address:               0x4
> $ ./load.so
> bash: ./load.so: cannot execute binary file: Exec format error
> $

Is the point of this keeping shared libraries from executing?
What is gained by this patch?

Eric


> Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
> ---
>  fs/binfmt_elf.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index bd78587194dc..7f035022131b 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -850,6 +850,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  
>  	if (elf_ex->e_type != ET_EXEC && elf_ex->e_type != ET_DYN)
>  		goto out;
> +	if (elf_ex->e_entry < sizeof(*elf_ex))
> +		goto out;
>  	if (!elf_check_arch(elf_ex))
>  		goto out;
>  	if (elf_check_fdpic(elf_ex))
