Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E08B4D1B82
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347607AbiCHPTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbiCHPTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:19:38 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A4A4A928
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:18:40 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id qx21so39944182ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 07:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NUBCkBiY+0tJ4VuBewl7LfnbzjGwy2PAsOh1R0tzjbw=;
        b=jPjzz/ciSsrFwizk/TxR9U2AEKTDlrk4VSxsOEvDb12jHdPMjrPc2yEreK1cFsug0G
         h/rpxh8zFAgVlb2/BQ0/DNKlYREKNYnUu/4dwnHWp5LikZ7qRLdhI1tHBffV+h5uYro7
         U+ej1V2HN3qetiSftP8bL82DQ2zLyPVFOQ9bEO4rYv/WvQRP8Gd10zJcGYHvqlGTSjhF
         VGezST/w4Ns+p+djH5ClNEUz0Ovju2lu9latTei59XzXa8qyncmCtlwZb9/jC3rdNtrT
         iNEWy1N3zQf2Ok27chvioGRnPrgt7/J4Q78bn/osZ3fiszi0H3XYxlWSZOT7p5UitA04
         G4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=NUBCkBiY+0tJ4VuBewl7LfnbzjGwy2PAsOh1R0tzjbw=;
        b=t3U1vjWTt7lIZNsWsQ3P2gS+ArII/9H0GI5LIlG8JKhb0hZezKNxjOqlIXEsDoJtjU
         mPdFPCmfa12/XNVzO6lY6yH9I8HgeQECvYgSpD5GTQuNKKkTUKftMhsH+4Ze9v/HJyCx
         8UBo//zx7GjzB9vm3yiK52vNS1Pvm8ycxB7IQ/Liy/OoU37wPLuMh5upvyDkUhplQDLd
         EOwkKO6cbhrVAUSCBotNTx54SZXr/w+U+wWxS5usI+FBZI1bzPtwyEzaQeZ67xS11EOQ
         PLSpXhMZc606UV7RzCLTPyx4ZHNp3J2Q4/lljkvQZgjv1afI92k40O+vW7yBYUlo12yO
         VfNg==
X-Gm-Message-State: AOAM532qsB+6nJRkEJh1c2kSh085OOg5CvRNoXy25WmizJpWNFBr6y76
        Tgt42JHvA6UdAksIdGqUUzE=
X-Google-Smtp-Source: ABdhPJxOmkjVqpIBLzxb/V3vv3cbffYfs0OjFH10BOAhZLuZStat001uH9Q7OPIE5ycX224ToDtg+g==
X-Received: by 2002:a17:906:dc10:b0:6da:f383:86ed with SMTP id yy16-20020a170906dc1000b006daf38386edmr13576533ejb.391.1646752719131;
        Tue, 08 Mar 2022 07:18:39 -0800 (PST)
Received: from m4.home (tor-exit-7.zbau.f3netze.de. [2a0b:f4c0:16c:7::1])
        by smtp.gmail.com with ESMTPSA id gz20-20020a170907a05400b006d91b214235sm5998485ejc.185.2022.03.08.07.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 07:18:38 -0800 (PST)
Sender: Domenico Andreoli <domenico.andreoli.it@gmail.com>
Received: from cavok by m4.home with local (Exim 4.94.2)
        (envelope-from <cavok@localhost>)
        id 1nRbbe-00047z-Hc; Tue, 08 Mar 2022 16:18:34 +0100
Date:   Tue, 8 Mar 2022 16:18:34 +0100
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_misc: add two-steps registration (opt-in)
Message-ID: <YidzykfBmAVqVWTC@localhost>
References: <Yh4fdijvNXE7K88c@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh4fdijvNXE7K88c@localhost>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric and Kees,

On Tue, Mar 01, 2022 at 02:28:22PM +0100, Domenico Andreoli wrote:
> From: Domenico Andreoli <domenico.andreoli@linux.com>
> 
> Experimenting with new interpreter configurations can lead to annoying
> failures, when the system is left unable to load ELF binaries power
> cycling is the only way to get it back operational.
> 
> This patch tries to mitigate such conditions by adding an opt-in
> two-steps registration.
> 
> A new optional field is added to the configuration string, it's an
> expiration interval for the newly added interpreter. If the user is
> not able to confirm in time, possibly because the system is broken,
> the new interpreter is automatically disabled.

I was wondering whether, maybe, likely, you missed this patch of mine.

It would be great if you could just ack (or nack) it for later.

Thanks!
Domenico

> 
> Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
> Cc: Kees Cook <keescook@chromium.org>
> 
> ---
>  Documentation/admin-guide/binfmt-misc.rst |   12 +++
>  fs/binfmt_misc.c                          |  112 ++++++++++++++++++++++++++++--
>  2 files changed, 113 insertions(+), 11 deletions(-)
> 
> Index: b/Documentation/admin-guide/binfmt-misc.rst
> ===================================================================
> --- a/Documentation/admin-guide/binfmt-misc.rst
> +++ b/Documentation/admin-guide/binfmt-misc.rst
> @@ -16,8 +16,8 @@ First you must mount binfmt_misc::
>  	mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc
>  
>  To actually register a new binary type, you have to set up a string looking like
> -``:name:type:offset:magic:mask:interpreter:flags`` (where you can choose the
> -``:`` upon your needs) and echo it to ``/proc/sys/fs/binfmt_misc/register``.
> +``:name:type:offset:magic:mask:interpreter:flags:timeout`` (where you can choose
> +the ``:`` upon your needs) and echo it to ``/proc/sys/fs/binfmt_misc/register``.
>  
>  Here is what the fields mean:
>  
> @@ -88,6 +88,14 @@ Here is what the fields mean:
>  	    emulation is installed and uses the opened image to spawn the
>  	    emulator, meaning it is always available once installed,
>  	    regardless of how the environment changes.
> +- ``timeout``
> +  is an optional field; the newly added interpreter is automatically
> +  disabled after the specified number of seconds. To cancel such
> +  count down, cat or echo something to ``/proc/.../the_name``.  This
> +  registration in two steps allows recovering a system left unusable
> +  by some wrong configuration. A timeout of 0 seconds effectively adds
> +  a disabled interpreter.  Values smaller than 0 or bigger than 120
> +  are invalid.
>  
>  
>  There are some restrictions:
> Index: b/fs/binfmt_misc.c
> ===================================================================
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -27,6 +27,8 @@
>  #include <linux/syscalls.h>
>  #include <linux/fs.h>
>  #include <linux/uaccess.h>
> +#include <linux/spinlock.h>
> +#include <linux/timer.h>
>  
>  #include "internal.h"
>  
> @@ -49,6 +51,8 @@ enum {Enabled, Magic};
>  #define MISC_FMT_CREDENTIALS (1 << 29)
>  #define MISC_FMT_OPEN_FILE (1 << 28)
>  
> +struct node_timer;
> +
>  typedef struct {
>  	struct list_head list;
>  	unsigned long flags;		/* type, status, etc. */
> @@ -60,8 +64,15 @@ typedef struct {
>  	char *name;
>  	struct dentry *dentry;
>  	struct file *interp_file;
> +	struct node_timer *auto_disable;
> +	spinlock_t auto_disable_lock;
>  } Node;
>  
> +struct node_timer {
> +	struct timer_list timer;
> +	Node *node;
> +};
> +
>  static DEFINE_RWLOCK(entries_lock);
>  static struct file_system_type bm_fs_type;
>  static struct vfsmount *bm_mnt;
> @@ -69,19 +80,30 @@ static int entry_count;
>  
>  /*
>   * Max length of the register string.  Determined by:
> - *  - 7 delimiters
> - *  - name:   ~50 bytes
> - *  - type:   1 byte
> - *  - offset: 3 bytes (has to be smaller than BINPRM_BUF_SIZE)
> - *  - magic:  128 bytes (512 in escaped form)
> - *  - mask:   128 bytes (512 in escaped form)
> - *  - interp: ~50 bytes
> - *  - flags:  5 bytes
> + *  - 8 delimiters
> + *  - name:    ~50 bytes
> + *  - type:    1 byte
> + *  - offset:  3 bytes (has to be smaller than BINPRM_BUF_SIZE)
> + *  - magic:   128 bytes (512 in escaped form)
> + *  - mask:    128 bytes (512 in escaped form)
> + *  - interp:  ~50 bytes
> + *  - flags:   5 bytes
> + *  - timeout: 3 bytes
>   * Round that up a bit, and then back off to hold the internal data
>   * (like struct Node).
>   */
>  #define MAX_REGISTER_LENGTH 1920
>  
> +#define MAX_AUTO_DISABLE_TIMEOUT 120
> +
> +static void auto_disable_timer_fn(struct timer_list *t)
> +{
> +	struct node_timer *timer = container_of(t, struct node_timer, timer);
> +
> +	clear_bit(Enabled, &timer->node->flags);
> +	pr_info("%s: auto-disabled\n", timer->node->name);
> +}
> +
>  /*
>   * Check if we support the binfmt
>   * if we do, return the node, else NULL
> @@ -266,6 +288,41 @@ static char *check_special_flags(char *s
>  	return p;
>  }
>  
> +static char *setup_auto_disable(char *p, char *endp, Node *e)
> +{
> +	unsigned int timeout;
> +	char buf[4] = {0};
> +
> +	while (endp[-1] == '\n')
> +		endp--;
> +	if (p >= endp || *p != ':' || ++p == endp)
> +		return p;
> +
> +	endp = min(endp, p + sizeof(buf) - 1);
> +	memcpy(buf, p, (size_t) (endp - p));
> +
> +	if (kstrtouint(buf, 10, &timeout) || timeout > MAX_AUTO_DISABLE_TIMEOUT) {
> +		pr_info("%s: invalid timeout: %s\n", e->name, buf);
> +		return p;
> +	}
> +
> +	if (timeout == 0) {
> +		e->flags &= ~(1 << Enabled);
> +		return endp;
> +	}
> +
> +	e->auto_disable = kmalloc(sizeof(struct node_timer), GFP_KERNEL);
> +	if (!e->auto_disable)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pr_info("%s: auto-disable in %u seconds\n", e->name, timeout);
> +
> +	timer_setup(&e->auto_disable->timer, auto_disable_timer_fn, 0);
> +	e->auto_disable->timer.expires = jiffies + timeout * HZ;
> +	e->auto_disable->node = e;
> +	return endp;
> +}
> +
>  /*
>   * This registers a new binary format, it recognises the syntax
>   * ':name:type:offset:magic:mask:interpreter:flags'
> @@ -273,7 +330,7 @@ static char *check_special_flags(char *s
>   */
>  static Node *create_entry(const char __user *buffer, size_t count)
>  {
> -	Node *e;
> +	Node *e = NULL;
>  	int memsize, err;
>  	char *buf, *p;
>  	char del;
> @@ -297,6 +354,8 @@ static Node *create_entry(const char __u
>  	if (copy_from_user(buf, buffer, count))
>  		goto efault;
>  
> +	spin_lock_init(&e->auto_disable_lock);
> +
>  	del = *p++;	/* delimeter */
>  
>  	pr_debug("register: delim: %#x {%c}\n", del, del);
> @@ -454,6 +513,14 @@ static Node *create_entry(const char __u
>  
>  	/* Parse the 'flags' field. */
>  	p = check_special_flags(p, e);
> +
> +	/* Parse the 'timeout' field and init the auto-disable timer. */
> +	p = setup_auto_disable(p, buf + count, e);
> +	if (IS_ERR(p)) {
> +		err = PTR_ERR(p);
> +		goto out;
> +	}
> +
>  	if (*p == '\n')
>  		p++;
>  	if (p != buf + count)
> @@ -462,12 +529,15 @@ static Node *create_entry(const char __u
>  	return e;
>  
>  out:
> +	kfree(e);
>  	return ERR_PTR(err);
>  
>  efault:
>  	kfree(e);
>  	return ERR_PTR(-EFAULT);
>  einval:
> +	if (e)
> +		kfree(e->auto_disable);
>  	kfree(e);
>  	return ERR_PTR(-EINVAL);
>  }
> @@ -499,6 +569,21 @@ static int parse_command(const char __us
>  
>  /* generic stuff */
>  
> +static void cancel_auto_disable(Node *e)
> +{
> +	struct node_timer *auto_disable = NULL;
> +
> +	spin_lock(&e->auto_disable_lock);
> +	swap(e->auto_disable, auto_disable);
> +	spin_unlock(&e->auto_disable_lock);
> +
> +	if (auto_disable) {
> +		if (del_timer_sync(&auto_disable->timer))
> +			pr_info("%s: cancelled auto-disable\n", e->name);
> +		kfree(auto_disable);
> +	}
> +}
> +
>  static void entry_status(Node *e, char *page)
>  {
>  	char *dp = page;
> @@ -559,6 +644,8 @@ static void bm_evict_inode(struct inode
>  
>  	if (e && e->flags & MISC_FMT_OPEN_FILE)
>  		filp_close(e->interp_file, NULL);
> +	if (e)
> +		cancel_auto_disable(e);
>  
>  	clear_inode(inode);
>  	kfree(e);
> @@ -588,6 +675,8 @@ bm_entry_read(struct file *file, char __
>  	ssize_t res;
>  	char *page;
>  
> +	cancel_auto_disable(e);
> +
>  	page = (char *) __get_free_page(GFP_KERNEL);
>  	if (!page)
>  		return -ENOMEM;
> @@ -607,6 +696,8 @@ static ssize_t bm_entry_write(struct fil
>  	Node *e = file_inode(file)->i_private;
>  	int res = parse_command(buffer, count);
>  
> +	cancel_auto_disable(e);
> +
>  	switch (res) {
>  	case 1:
>  		/* Disable this handler. */
> @@ -699,6 +790,9 @@ static ssize_t bm_register_write(struct
>  	list_add(&e->list, &entries);
>  	write_unlock(&entries_lock);
>  
> +	if (e->auto_disable)
> +		add_timer(&e->auto_disable->timer);
> +
>  	err = 0;
>  out2:
>  	dput(dentry);

-- 
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05
