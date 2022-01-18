Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390334923C0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 11:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbiARK36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 05:29:58 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:51115 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236868AbiARK35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 05:29:57 -0500
Received: by mail-wm1-f41.google.com with SMTP id w26so26576653wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 02:29:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sGFjYgWz0PE+h6DNFekrex1rIbKSGPaKbWfn+ZidI4E=;
        b=RV7oPJsa+Wzz7Q6vFEZk2wgjs89DF/DlpIUYb7n2nGdGgC4Ck4/4S2OIvFmeNahdkU
         87v4f4MAx6hAjx7dR8ZLnmnjv4K6Sucg9r21rroBNv02wFwaVHSxfNDL7B3CDTGGz9Ja
         VyLpwyQ2Xd5TII2TeXpZhm9VhZoplY3tOeU0FsVfOUknP0+Wnw38tr7KbR4wbRAnawCB
         0o2KaHoPrUTyNqwoOJDITVS/H2khYyefAFPzkSjJblc5z5JAK3sLA+kh2ZqlY2k7ERev
         jyXceCrTwGToxuxnUVSSg1uf82RO7cvWfwFW7s8ML3T1C23mW84b9LgwYMJ+Z1NNC6yZ
         Q8xg==
X-Gm-Message-State: AOAM532jcnZ54Upx04rYFtb7GSAKVDLEh5xOqI5/J/EXaDqno9irFXKp
        4qAstglFObN1jn/HOrDdPrY=
X-Google-Smtp-Source: ABdhPJwktXVR9xRctCymyMA2N1cdxGTP67GkbPfHplNiZMzZ507frcy/qdJGNhnE1pxo6NyxCcXVUQ==
X-Received: by 2002:a5d:64e7:: with SMTP id g7mr3099079wri.520.1642501795840;
        Tue, 18 Jan 2022 02:29:55 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id k35sm2051870wms.23.2022.01.18.02.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 02:29:55 -0800 (PST)
Message-ID: <72a719a0-cd7c-9516-93c2-bd258930b71e@kernel.org>
Date:   Tue, 18 Jan 2022 11:29:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] status: Display an informational message when the
 VSTATUS character is pressed or TIOCSTAT ioctl is called.
Content-Language: en-US
To:     Walt Drummond <walt@drummond.us>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     ar@cs.msu.ru, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>, mm <linux-mm@kvack.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20220118044323.765038-1-walt@drummond.us>
 <20220118044323.765038-3-walt@drummond.us>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220118044323.765038-3-walt@drummond.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc Oleg, scheduler and mm guys.

Hi,

The processes and their mm handling don't look right to me, but I don't 
know that area that well.

Overall, is this really worth the hassle?

BTW I haven't received 2/3.

On 18. 01. 22, 5:43, Walt Drummond wrote:
> When triggered by pressing the VSTATUS key or calling the TIOCSTAT
> ioctl, the n_tty line discipline will display a message on the user's
> tty that provides basic information about the system and an
> 'interesting' process in the current foreground process group, eg:
> 
>    load: 0.58  cmd: sleep 744474 [sleeping] 0.36r 0.00u 0.00s 0% 772k
> 
> The status message provides:
>   - System load average
>   - Command name and process id (from the perspective of the session)
>   - Scheduler state
>   - Total wall-clock run time
>   - User space run time
>   - System space run time
>   - Percentage of on-cpu time
>   - Resident set size
> 
> The message is only displayed when the tty has the VSTATUS character
> set and the local flag NOKERNINFO disabled; it is always displayed
> when TIOCSTAT is called regardless of tty settings.
> 
> Signed-off-by: Walt Drummond <walt@drummond.us>
> ---
>   drivers/tty/Makefile       |   2 +-
>   drivers/tty/n_tty.c        |  37 +++++++++
>   drivers/tty/n_tty_status.c | 162 +++++++++++++++++++++++++++++++++++++
>   drivers/tty/tty_io.c       |   2 +-
>   include/linux/tty.h        | 123 ++++++++++++++--------------
>   5 files changed, 265 insertions(+), 61 deletions(-)
>   create mode 100644 drivers/tty/n_tty_status.c
> 
> diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
> index 07aca5184a55..84bc99aebcff 100644
> --- a/drivers/tty/Makefile
> +++ b/drivers/tty/Makefile
> @@ -2,7 +2,7 @@
>   obj-$(CONFIG_TTY)		+= tty_io.o n_tty.o tty_ioctl.o tty_ldisc.o \
>   				   tty_buffer.o tty_port.o tty_mutex.o \
>   				   tty_ldsem.o tty_baudrate.o tty_jobctrl.o \
> -				   n_null.o
> +				   n_null.o n_tty_status.o
>   obj-$(CONFIG_LEGACY_PTYS)	+= pty.o
>   obj-$(CONFIG_UNIX98_PTYS)	+= pty.o
>   obj-$(CONFIG_AUDIT)		+= tty_audit.o
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index 6a6e7da80095..2e9b038e84e0 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
> @@ -80,6 +80,7 @@
>   #define ECHO_BLOCK		256
>   #define ECHO_DISCARD_WATERMARK	N_TTY_BUF_SIZE - (ECHO_BLOCK + 32)
>   
> +#define STATUS_LINE_LEN 160	/* tty status line will truncate at this length */
>   
>   #undef N_TTY_TRACE
>   #ifdef N_TTY_TRACE
> @@ -127,6 +128,8 @@ struct n_tty_data {
>   	struct mutex output_lock;
>   };
>   
> +static int n_tty_status(struct tty_struct *tty);
> +
>   #define MASK(x) ((x) & (N_TTY_BUF_SIZE - 1))
>   
>   static inline size_t read_cnt(struct n_tty_data *ldata)
> @@ -1334,6 +1337,11 @@ static void n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
>   			commit_echoes(tty);
>   			return;
>   		}
> +		if (c == STATUS_CHAR(tty)) {
> +			if (!L_NOKERNINFO(tty))
> +				n_tty_status(tty);
> +			return;
> +		}
>   		if (c == '\n') {
>   			if (L_ECHO(tty) || L_ECHONL(tty)) {
>   				echo_char_raw('\n', ldata);
> @@ -1763,6 +1771,7 @@ static void n_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
>   			set_bit(EOF_CHAR(tty), ldata->char_map);
>   			set_bit('\n', ldata->char_map);
>   			set_bit(EOL_CHAR(tty), ldata->char_map);
> +			set_bit(STATUS_CHAR(tty), ldata->char_map);
>   			if (L_IEXTEN(tty)) {
>   				set_bit(WERASE_CHAR(tty), ldata->char_map);
>   				set_bit(LNEXT_CHAR(tty), ldata->char_map);
> @@ -2412,6 +2421,29 @@ static unsigned long inq_canon(struct n_tty_data *ldata)
>   	return nr;
>   }
>   
> +static int n_tty_status(struct tty_struct *tty)
> +{
> +	struct n_tty_data *ldata = tty->disc_data;
> +	char *buf, msg[STATUS_LINE_LEN] = {0};

160 B on stack?

> +	int ret = 0;
> +	size_t len = STATUS_LINE_LEN - 1;
> +
> +	buf = (char *) &msg;
> +	ret = n_tty_get_status(tty, buf + 1, &len);
> +	if (ret)
> +		return ret;
> +
> +	if (ldata->column != 0) {
> +		msg[0] = '\n';
> +		len++;

It's not clear to me why this is after n_tty_get_status and therefore 
you need buf? If you stored \n to msg[0], you could just pass msg (to 
rewrite \n) or (msg + 1) to n_tty_get_status() -- depending on 
ldata->column, right?

> +	} else {
> +		buf++;
> +	}
> +
> +	do_n_tty_write(tty, NULL, buf, len);
> +	return 0;
> +}
> +
>   static int n_tty_ioctl(struct tty_struct *tty, struct file *file,
>   		       unsigned int cmd, unsigned long arg)
>   {
> @@ -2429,6 +2461,11 @@ static int n_tty_ioctl(struct tty_struct *tty, struct file *file,
>   			retval = read_cnt(ldata);
>   		up_write(&tty->termios_rwsem);
>   		return put_user(retval, (unsigned int __user *) arg);
> +	case TIOCSTAT:
> +		down_read(&tty->termios_rwsem);
> +		retval = n_tty_status(tty);
> +		up_read(&tty->termios_rwsem);
> +		return retval;
>   	default:
>   		return n_tty_ioctl_helper(tty, cmd, arg);
>   	}
> diff --git a/drivers/tty/n_tty_status.c b/drivers/tty/n_tty_status.c
> new file mode 100644
> index 000000000000..269776db0640
> --- /dev/null
> +++ b/drivers/tty/n_tty_status.c
> @@ -0,0 +1,162 @@
> +// SPDX-License-Identifier: GPL-1.0+
> +/*
> + * n_tty_status.c --- implements VSTATUS and TIOCSTAT from BSD
> + *
> + * Display a basic status message containing information about the
> + * foreground process and system load on the users tty, triggered by
> + * the VSTATUS character or TIOCSTAT. Ex,
> + *
> + *   load: 14.11  cmd: tcsh 19623 [running] 185756.62r 88.00u 17.50s 0% 4260k
> + *
> + */
> +
> +#include <linux/tty.h>
> +#include <linux/mm.h>
> +#include <linux/sched/loadavg.h>
> +
> +static const char * const task_state_unknown = "unknown";

Why do you need a variable for this, actually? Plus why do you need also 
a pointer (another 4/8B) to the storage?

> +static const char * const task_state_array[] = {
> +	"running",
> +	"sleeping",
> +	"disk sleep",
> +	"stopped",
> +	"tracing stop",
> +	"dead",
> +	"zombie",
> +	"parked",
> +	"idle",
> +};
> +
> +static inline unsigned long getRSSk(struct mm_struct *mm)
> +{
> +	if (mm == NULL)
> +		return 0;
> +	return get_mm_rss(mm) * PAGE_SIZE / 1024;
> +}
> +
> +static inline long frac_sec(long l)

I don't understand what this does. The name should be more descriptive.

> +{
> +	l /= NSEC_PER_MSEC * 10;
> +	if (l < 10)
> +		l *= 10;
> +	return l;
> +}
> +
> +static inline struct task_struct *compare(struct task_struct *new,
> +					  struct task_struct *old)
> +{
> +	unsigned int ostate, nstate;
> +
> +	if (old == NULL)
> +		return new;
> +
> +	ostate = task_state_index(old);
> +	nstate = task_state_index(new);
> +
> +	if (ostate == nstate) {
> +		if (old->start_time > new->start_time)
> +			return old;
> +		return new;
> +	}
> +
> +	if (ostate < nstate)
> +		return old;
> +
> +	return new;
> +}
> +
> +static struct task_struct *pick_process(struct pid *pgrp)
> +{
> +	struct task_struct *new, *winner = NULL;
> +
> +	read_lock(&tasklist_lock);
> +	do_each_pid_task(pgrp, PIDTYPE_PGID, new) {
> +		winner = compare(new, winner);
> +	} while_each_pid_task(pgrp, PIDTYPE_PGID, new);

Whys is get_task_struct() not needed?

> +	read_unlock(&tasklist_lock);

IOW what happens if winner has just died?

> +	return winner;
> +}
> +
> +/* We want the pid from the context of session */
> +static inline pid_t __get_pid(struct task_struct *tsk, struct tty_struct *tty)
> +{
> +	return __task_pid_nr_ns(tsk, PIDTYPE_PID, ns_of_pid(tty->ctrl.session));

You're holding no locks protecting tty->ctrl.session.

> +}
> +
> +static inline const char *get_task_state_name(struct task_struct *tsk)

This definitely doesn't belong here. How do you ensure it matches the 
returned index also in the future. Put it along with 
task_index_to_char()? Or simply use task_state_to_char()?

> +{
> +
> +	int index;
> +
> +	index = task_state_index(tsk);
> +	if (index > ARRAY_SIZE(task_state_array))

Should be >=, or?

> +		return task_state_unknown;
> +	return task_state_array[index];
> +}
> +
> +int n_tty_get_status(struct tty_struct *tty, char *msg, size_t *msglen)
> +{
> +	unsigned long loadavg[3];
> +	uint64_t pcpu, cputime, wallclock;
> +	struct task_struct *p;
> +	struct rusage rusage;
> +	struct timespec64 utime, stime, rtime;
> +	char tname[TASK_COMM_LEN];

How much stack did you consume in sum with its caller n_tty_status()?

> +	size_t len;
> +
> +	if (tty == NULL)
> +		return -ENOTTY;

How can this happen?

> +	get_avenrun(loadavg, FIXED_1/200, 0);
> +	len = scnprintf(msg + len, *msglen - len, "load: %lu.%02lu  ",
> +			LOAD_INT(loadavg[0]), LOAD_FRAC(loadavg[0]));
> +
> +	if (tty->ctrl.session == NULL) {
> +		len += scnprintf(msg + len, *msglen - len,
> +				 "not a controlling terminal\n");
> +		goto out;
> +	}
> +
> +	if (tty->ctrl.pgrp == NULL) {
> +		len += scnprintf(msg + len, *msglen - len,
> +				 "no foreground process group\n");
> +		goto out;
> +	}
> +
> +	p = pick_process(tty->ctrl.pgrp);

Why is no lock needed?

> +	if (p == NULL) {
> +		len += scnprintf(msg + len, *msglen - len,
> +				 "empty foreground process group\n");
> +		goto out;
> +	}
> +
> +	get_task_comm(tname, p);
> +	getrusage(p, RUSAGE_BOTH, &rusage);
> +	wallclock = ktime_get_ns() - p->start_time;
> +
> +	utime.tv_sec = rusage.ru_utime.tv_sec;
> +	utime.tv_nsec = rusage.ru_utime.tv_usec * NSEC_PER_USEC;
> +	stime.tv_sec = rusage.ru_stime.tv_sec;
> +	stime.tv_nsec = rusage.ru_stime.tv_usec * NSEC_PER_USEC;
> +	rtime = ns_to_timespec64(wallclock);
> +
> +	cputime = timespec64_to_ns(&utime) + timespec64_to_ns(&stime);
> +	pcpu = div64_u64(cputime * 100, wallclock);
> +
> +	len += scnprintf(msg + len, *msglen - len,
> +			 /* task, PID, task state */
> +			 "cmd: %s %d [%s] "
> +			 /* rtime,    utime,      stime,      %cpu,  rss */
> +			 "%llu.%02lur %llu.%02luu %llu.%02lus %llu%% %luk\n",
> +			 tname,	__get_pid(p, tty),
> +			 (char *)get_task_state_name(p),
> +			 rtime.tv_sec, frac_sec(rtime.tv_nsec),
> +			 utime.tv_sec, frac_sec(utime.tv_nsec),
> +			 stime.tv_sec, frac_sec(stime.tv_nsec),
> +			 pcpu, getRSSk(p->mm));

Why do you think p->mm is still alive (even after the getRSSk()'s 
check)? So no get_task_mm() needed?

> +out:
> +	*msglen = len;
> +	return 0;
> +}
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 6616d4a0d41d..f2f4f48ea502 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -125,7 +125,7 @@ struct ktermios tty_std_termios = {	/* for the benefit of tty drivers  */
>   	.c_oflag = OPOST | ONLCR,
>   	.c_cflag = B38400 | CS8 | CREAD | HUPCL,
>   	.c_lflag = ISIG | ICANON | ECHO | ECHOE | ECHOK |
> -		   ECHOCTL | ECHOKE | IEXTEN,
> +		   ECHOCTL | ECHOKE | IEXTEN | NOKERNINFO,
>   	.c_cc = INIT_C_CC,
>   	.c_ispeed = 38400,
>   	.c_ospeed = 38400,
> diff --git a/include/linux/tty.h b/include/linux/tty.h
> index 5dbd7c5afac7..e6ba6ce2efcb 100644
> --- a/include/linux/tty.h
> +++ b/include/linux/tty.h
> @@ -49,71 +49,73 @@
>   #define WERASE_CHAR(tty) ((tty)->termios.c_cc[VWERASE])
>   #define LNEXT_CHAR(tty)	((tty)->termios.c_cc[VLNEXT])
>   #define EOL2_CHAR(tty) ((tty)->termios.c_cc[VEOL2])
> +#define STATUS_CHAR(tty) ((tty)->termios.c_cc[VSTATUS])
>   
>   #define _I_FLAG(tty, f)	((tty)->termios.c_iflag & (f))
>   #define _O_FLAG(tty, f)	((tty)->termios.c_oflag & (f))
>   #define _C_FLAG(tty, f)	((tty)->termios.c_cflag & (f))
>   #define _L_FLAG(tty, f)	((tty)->termios.c_lflag & (f))
>   
> -#define I_IGNBRK(tty)	_I_FLAG((tty), IGNBRK)
> -#define I_BRKINT(tty)	_I_FLAG((tty), BRKINT)
> -#define I_IGNPAR(tty)	_I_FLAG((tty), IGNPAR)
> -#define I_PARMRK(tty)	_I_FLAG((tty), PARMRK)
> -#define I_INPCK(tty)	_I_FLAG((tty), INPCK)
> -#define I_ISTRIP(tty)	_I_FLAG((tty), ISTRIP)
> -#define I_INLCR(tty)	_I_FLAG((tty), INLCR)
> -#define I_IGNCR(tty)	_I_FLAG((tty), IGNCR)
> -#define I_ICRNL(tty)	_I_FLAG((tty), ICRNL)
> -#define I_IUCLC(tty)	_I_FLAG((tty), IUCLC)
> -#define I_IXON(tty)	_I_FLAG((tty), IXON)
> -#define I_IXANY(tty)	_I_FLAG((tty), IXANY)
> -#define I_IXOFF(tty)	_I_FLAG((tty), IXOFF)
> -#define I_IMAXBEL(tty)	_I_FLAG((tty), IMAXBEL)
> -#define I_IUTF8(tty)	_I_FLAG((tty), IUTF8)
> -
> -#define O_OPOST(tty)	_O_FLAG((tty), OPOST)
> -#define O_OLCUC(tty)	_O_FLAG((tty), OLCUC)
> -#define O_ONLCR(tty)	_O_FLAG((tty), ONLCR)
> -#define O_OCRNL(tty)	_O_FLAG((tty), OCRNL)
> -#define O_ONOCR(tty)	_O_FLAG((tty), ONOCR)
> -#define O_ONLRET(tty)	_O_FLAG((tty), ONLRET)
> -#define O_OFILL(tty)	_O_FLAG((tty), OFILL)
> -#define O_OFDEL(tty)	_O_FLAG((tty), OFDEL)
> -#define O_NLDLY(tty)	_O_FLAG((tty), NLDLY)
> -#define O_CRDLY(tty)	_O_FLAG((tty), CRDLY)
> -#define O_TABDLY(tty)	_O_FLAG((tty), TABDLY)
> -#define O_BSDLY(tty)	_O_FLAG((tty), BSDLY)
> -#define O_VTDLY(tty)	_O_FLAG((tty), VTDLY)
> -#define O_FFDLY(tty)	_O_FLAG((tty), FFDLY)
> -
> -#define C_BAUD(tty)	_C_FLAG((tty), CBAUD)
> -#define C_CSIZE(tty)	_C_FLAG((tty), CSIZE)
> -#define C_CSTOPB(tty)	_C_FLAG((tty), CSTOPB)
> -#define C_CREAD(tty)	_C_FLAG((tty), CREAD)
> -#define C_PARENB(tty)	_C_FLAG((tty), PARENB)
> -#define C_PARODD(tty)	_C_FLAG((tty), PARODD)
> -#define C_HUPCL(tty)	_C_FLAG((tty), HUPCL)
> -#define C_CLOCAL(tty)	_C_FLAG((tty), CLOCAL)
> -#define C_CIBAUD(tty)	_C_FLAG((tty), CIBAUD)
> -#define C_CRTSCTS(tty)	_C_FLAG((tty), CRTSCTS)
> -#define C_CMSPAR(tty)	_C_FLAG((tty), CMSPAR)
> -
> -#define L_ISIG(tty)	_L_FLAG((tty), ISIG)
> -#define L_ICANON(tty)	_L_FLAG((tty), ICANON)
> -#define L_XCASE(tty)	_L_FLAG((tty), XCASE)
> -#define L_ECHO(tty)	_L_FLAG((tty), ECHO)
> -#define L_ECHOE(tty)	_L_FLAG((tty), ECHOE)
> -#define L_ECHOK(tty)	_L_FLAG((tty), ECHOK)
> -#define L_ECHONL(tty)	_L_FLAG((tty), ECHONL)
> -#define L_NOFLSH(tty)	_L_FLAG((tty), NOFLSH)
> -#define L_TOSTOP(tty)	_L_FLAG((tty), TOSTOP)
> -#define L_ECHOCTL(tty)	_L_FLAG((tty), ECHOCTL)
> -#define L_ECHOPRT(tty)	_L_FLAG((tty), ECHOPRT)
> -#define L_ECHOKE(tty)	_L_FLAG((tty), ECHOKE)
> -#define L_FLUSHO(tty)	_L_FLAG((tty), FLUSHO)
> -#define L_PENDIN(tty)	_L_FLAG((tty), PENDIN)
> -#define L_IEXTEN(tty)	_L_FLAG((tty), IEXTEN)
> -#define L_EXTPROC(tty)	_L_FLAG((tty), EXTPROC)
> +#define I_IGNBRK(tty)	  _I_FLAG((tty), IGNBRK)
> +#define I_BRKINT(tty)	  _I_FLAG((tty), BRKINT)
> +#define I_IGNPAR(tty)	  _I_FLAG((tty), IGNPAR)
> +#define I_PARMRK(tty)	  _I_FLAG((tty), PARMRK)
> +#define I_INPCK(tty)	  _I_FLAG((tty), INPCK)
> +#define I_ISTRIP(tty)	  _I_FLAG((tty), ISTRIP)
> +#define I_INLCR(tty)	  _I_FLAG((tty), INLCR)
> +#define I_IGNCR(tty)	  _I_FLAG((tty), IGNCR)
> +#define I_ICRNL(tty)	  _I_FLAG((tty), ICRNL)
> +#define I_IUCLC(tty)	  _I_FLAG((tty), IUCLC)
> +#define I_IXON(tty)	  _I_FLAG((tty), IXON)
> +#define I_IXANY(tty)	  _I_FLAG((tty), IXANY)
> +#define I_IXOFF(tty)	  _I_FLAG((tty), IXOFF)
> +#define I_IMAXBEL(tty)	  _I_FLAG((tty), IMAXBEL)
> +#define I_IUTF8(tty)	  _I_FLAG((tty), IUTF8)
> +
> +#define O_OPOST(tty)	  _O_FLAG((tty), OPOST)
> +#define O_OLCUC(tty)	  _O_FLAG((tty), OLCUC)
> +#define O_ONLCR(tty)	  _O_FLAG((tty), ONLCR)
> +#define O_OCRNL(tty)	  _O_FLAG((tty), OCRNL)
> +#define O_ONOCR(tty)	  _O_FLAG((tty), ONOCR)
> +#define O_ONLRET(tty)	  _O_FLAG((tty), ONLRET)
> +#define O_OFILL(tty)	  _O_FLAG((tty), OFILL)
> +#define O_OFDEL(tty)	  _O_FLAG((tty), OFDEL)
> +#define O_NLDLY(tty)	  _O_FLAG((tty), NLDLY)
> +#define O_CRDLY(tty)	  _O_FLAG((tty), CRDLY)
> +#define O_TABDLY(tty)	  _O_FLAG((tty), TABDLY)
> +#define O_BSDLY(tty)	  _O_FLAG((tty), BSDLY)
> +#define O_VTDLY(tty)	  _O_FLAG((tty), VTDLY)
> +#define O_FFDLY(tty)	  _O_FLAG((tty), FFDLY)
> +
> +#define C_BAUD(tty)	  _C_FLAG((tty), CBAUD)
> +#define C_CSIZE(tty)	  _C_FLAG((tty), CSIZE)
> +#define C_CSTOPB(tty)	  _C_FLAG((tty), CSTOPB)
> +#define C_CREAD(tty)	  _C_FLAG((tty), CREAD)
> +#define C_PARENB(tty)	  _C_FLAG((tty), PARENB)
> +#define C_PARODD(tty)	  _C_FLAG((tty), PARODD)
> +#define C_HUPCL(tty)	  _C_FLAG((tty), HUPCL)
> +#define C_CLOCAL(tty)	  _C_FLAG((tty), CLOCAL)
> +#define C_CIBAUD(tty)	  _C_FLAG((tty), CIBAUD)
> +#define C_CRTSCTS(tty)	  _C_FLAG((tty), CRTSCTS)
> +#define C_CMSPAR(tty)	  _C_FLAG((tty), CMSPAR)
> +
> +#define L_ISIG(tty)	  _L_FLAG((tty), ISIG)
> +#define L_ICANON(tty)	  _L_FLAG((tty), ICANON)
> +#define L_XCASE(tty)	  _L_FLAG((tty), XCASE)
> +#define L_ECHO(tty)	  _L_FLAG((tty), ECHO)
> +#define L_ECHOE(tty)	  _L_FLAG((tty), ECHOE)
> +#define L_ECHOK(tty)	  _L_FLAG((tty), ECHOK)
> +#define L_ECHONL(tty)	  _L_FLAG((tty), ECHONL)
> +#define L_NOFLSH(tty)	  _L_FLAG((tty), NOFLSH)
> +#define L_TOSTOP(tty)	  _L_FLAG((tty), TOSTOP)
> +#define L_ECHOCTL(tty)	  _L_FLAG((tty), ECHOCTL)
> +#define L_ECHOPRT(tty)	  _L_FLAG((tty), ECHOPRT)
> +#define L_ECHOKE(tty)	  _L_FLAG((tty), ECHOKE)
> +#define L_FLUSHO(tty)	  _L_FLAG((tty), FLUSHO)
> +#define L_PENDIN(tty)	  _L_FLAG((tty), PENDIN)
> +#define L_IEXTEN(tty)	  _L_FLAG((tty), IEXTEN)
> +#define L_EXTPROC(tty)	  _L_FLAG((tty), EXTPROC)
> +#define L_NOKERNINFO(tty) _L_FLAG((tty), NOKERNINFO)

Huh, no. Don't do this in this patch. It's unclear what you are actually 
doing here -- it's lost in all those whitespace or whatnot changes.

>   struct device;
>   struct signal_struct;
> @@ -388,6 +390,9 @@ void __init n_tty_init(void);
>   static inline void n_tty_init(void) { }
>   #endif
>   
> +/* n_tty_status.c */
> +extern int n_tty_get_status(struct tty_struct *tty, char *msg, size_t *msglen);

Don't put any externs here to be consistent with the rest of the file.

>   /* tty_audit.c */
>   #ifdef CONFIG_AUDIT
>   void tty_audit_exit(void);

thanks,
-- 
js
suse labs
