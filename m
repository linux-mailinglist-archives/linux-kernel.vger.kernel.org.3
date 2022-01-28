Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13BFD49FE54
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350251AbiA1Qtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:49:52 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:42118 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349979AbiA1Qtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:49:51 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:41252)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nDURQ-00AOp3-6z; Fri, 28 Jan 2022 09:49:40 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:52112 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nDURO-002fYn-TO; Fri, 28 Jan 2022 09:49:39 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Antti Palosaari <crope@iki.fi>, Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Kees Cook <keescook@chromium.org>,
        Lukas Middendorf <kernel@tuxforce.de>,
        Mark Fasheh <mark@fasheh.com>, Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Qing Wang <wangqing@vivo.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Stephen Kitt <steve@sk2.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jani Nikula <jani.nikula@intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
References: <20220128065310.GF8421@xsang-OptiPlex-9020>
        <CAHk-=wgT6wuBB=pK2bGNQbioNCdJHT8Jnvs+4oT25jX1JFyhgg@mail.gmail.com>
        <20220128120421.kzo5iduigr7k55bs@quack3.lan>
Date:   Fri, 28 Jan 2022 10:49:16 -0600
In-Reply-To: <20220128120421.kzo5iduigr7k55bs@quack3.lan> (Jan Kara's message
        of "Fri, 28 Jan 2022 13:04:21 +0100")
Message-ID: <87a6ffst4j.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nDURO-002fYn-TO;;;mid=<87a6ffst4j.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18k7LLaaFzdLe4COB/a/JUipd1UliL3IMg=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMGappySubj_01
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4974]
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Jan Kara <jack@suse.cz>
X-Spam-Relay-Country: 
X-Spam-Timing: total 682 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (1.6%), b_tie_ro: 9 (1.3%), parse: 1.48 (0.2%),
         extract_message_metadata: 25 (3.7%), get_uri_detail_list: 2.6 (0.4%),
        tests_pri_-1000: 30 (4.4%), tests_pri_-950: 1.42 (0.2%),
        tests_pri_-900: 1.26 (0.2%), tests_pri_-90: 202 (29.6%), check_bayes:
        175 (25.6%), b_tokenize: 18 (2.7%), b_tok_get_all: 10 (1.4%),
        b_comp_prob: 3.4 (0.5%), b_tok_touch_all: 139 (20.4%), b_finish: 1.18
        (0.2%), tests_pri_0: 398 (58.3%), check_dkim_signature: 0.69 (0.1%),
        check_dkim_adsp: 7 (1.1%), poll_dns_idle: 0.48 (0.1%), tests_pri_10:
        2.0 (0.3%), tests_pri_500: 7 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [ocfs2] c42ff46f97: sysctl_table_check_failed
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara <jack@suse.cz> writes:

> On Fri 28-01-22 10:00:29, Linus Torvalds wrote:
>> On Fri, Jan 28, 2022 at 8:53 AM kernel test robot <oliver.sang@intel.com> wrote:
>> >
>> > commit: 46e33fd45a52bf03769906e64d8a8a1ab317777d ("ocfs2: simplify subdirectory
>> > registration with register_sysctl()")
>> 
>> Well, it's apparently commit c42ff46f97c1 ("ocfs2: simplify
>> subdirectory registration with register_sysctl()") in mainline now.
>> 
>> What worries me a bit is that the commit was auto-generated, and when
>> reading the commit message it reads as if it wasn't supposed to cause
>> any semantic changes at all.
>> 
>> Is the cause of this that 'nm' is supposed to be a directory, and
>> register_sysctl() doesn't handle directories?
>> 
>> I don't know this code at all, should it have been simplified even
>> further with something (TOTALLY UNTESTED) like the attached?
>
> Yep, I've tested the patch and it fixes the failure for me. Feel free to
> add:
>
> Tested-by: Jan Kara <jack@suse.cz>
>
> Also the change makes sense to me as far as I'm reading register_sysctl()
> so you can also add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>

Yes.  There is a register_sysctl_paths that can be used if you want/need
the embedded directories.  That probably would have been a better
choice for an automated conversion.

But since this there is only the single file in a single directory
register_sysctl() with the full path is perfectly fine in this case.

Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>

>> diff --git a/fs/ocfs2/stackglue.c b/fs/ocfs2/stackglue.c
>> index 731558a6f27d..dd77b7aaabf5 100644
>> --- a/fs/ocfs2/stackglue.c
>> +++ b/fs/ocfs2/stackglue.c
>> @@ -661,17 +661,6 @@ static struct ctl_table ocfs2_nm_table[] = {
>>  	{ }
>>  };
>>  
>> -static struct ctl_table ocfs2_mod_table[] = {
>> -	{
>> -		.procname	= "nm",
>> -		.data		= NULL,
>> -		.maxlen		= 0,
>> -		.mode		= 0555,
>> -		.child		= ocfs2_nm_table
>> -	},
>> -	{ }
>> -};
>> -
>>  static struct ctl_table_header *ocfs2_table_header;
>>  
>>  /*
>> @@ -682,7 +671,7 @@ static int __init ocfs2_stack_glue_init(void)
>>  {
>>  	strcpy(cluster_stack_name, OCFS2_STACK_PLUGIN_O2CB);
>>  
>> -	ocfs2_table_header = register_sysctl("fs/ocfs2", ocfs2_mod_table);
>> +	ocfs2_table_header = register_sysctl("fs/ocfs2/nm", ocfs2_nm_table);
>>  	if (!ocfs2_table_header) {
>>  		printk(KERN_ERR
>>  		       "ocfs2 stack glue: unable to register sysctl\n");
