Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896E952744A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 23:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbiENVxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 17:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbiENVxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 17:53:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47142B259
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:53:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EABD6B80AC1
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 21:53:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3D9C340EE;
        Sat, 14 May 2022 21:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652565219;
        bh=OxDaw0g6FUtkOJeIhYxqDrwzb/JU+qkk4Ip614iHHVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FlMHL3X/AtJ0quhA5EFKLkuKt/5c3Ye9pvqXFMjS+3XtijZPzWKPEQcZtqfZiW3fW
         IFxaY7iZYxH42rZ7BhiFG1yDSd0BXDsipTIKkTta7ndDdwV3N8ts0F1r4rDBrdszN4
         pqCh6cK+1YIRMqE3HYLH4Z+CXCSQBjgE+Z0vtaTU=
Date:   Sat, 14 May 2022 23:53:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     arnd@arndb.de, paul@paul-moore.com, eparis@redhat.com,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        Shreenidhi Shedi <sshedi@vmware.com>
Subject: Re: [PATCH 3/5] char: lp: fix most of checkspec.pl warnings & errors
Message-ID: <YoAk4dCAFE567NOp@kroah.com>
References: <20220514211455.284782-1-sshedi@vmware.com>
 <20220514211455.284782-3-sshedi@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514211455.284782-3-sshedi@vmware.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2022 at 02:44:53AM +0530, Shreenidhi Shedi wrote:
> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
> ---
>  drivers/char/lp.c | 339 ++++++++++++++++++++++++----------------------
>  1 file changed, 178 insertions(+), 161 deletions(-)
> 
> diff --git a/drivers/char/lp.c b/drivers/char/lp.c
> index 536ceb11176e..a860d22df3d4 100644
> --- a/drivers/char/lp.c
> +++ b/drivers/char/lp.c
> @@ -16,7 +16,7 @@
>   * Support for parport by Philip Blundell <philb@gnu.org>
>   * Parport sharing hacking by Andrea Arcangeli
>   * Fixed kernel_(to/from)_user memory copy to check for errors
> - * 				by Riccardo Facchetti <fizban@tin.it>
> + *				by Riccardo Facchetti <fizban@tin.it>
>   * 22-JAN-1998  Added support for devfs  Richard Gooch <rgooch@atnf.csiro.au>
>   * Redesigned interrupt handling for handle printers with buggy handshake
>   *				by Andrea Arcangeli, 11 May 1998
> @@ -144,7 +144,7 @@ static DEFINE_MUTEX(lp_mutex);
>  static struct lp_struct lp_table[LP_NO];
>  static int port_num[LP_NO];
>  
> -static unsigned int lp_count = 0;
> +static unsigned int lp_count;
>  static struct class *lp_class;
>  
>  #ifdef CONFIG_LP_CONSOLE
> @@ -161,35 +161,31 @@ static struct parport *console_registered;
>  
>  #define r_dtr(x)	(parport_read_data(lp_table[(x)].dev->port))
>  #define r_str(x)	(parport_read_status(lp_table[(x)].dev->port))
> -#define w_ctr(x,y)	do { parport_write_control(lp_table[(x)].dev->port, (y)); } while (0)
> -#define w_dtr(x,y)	do { parport_write_data(lp_table[(x)].dev->port, (y)); } while (0)
> +#define w_ctr(x, y)	(parport_write_control(lp_table[(x)].dev->port, (y)))
> +#define w_dtr(x, y)	(parport_write_data(lp_table[(x)].dev->port, (y)))
>  
>  /* Claim the parport or block trying unless we've already claimed it */
>  static void lp_claim_parport_or_block(struct lp_struct *this_lp)
>  {
> -	if (!test_and_set_bit(LP_PARPORT_CLAIMED, &this_lp->bits)) {
> +	if (!test_and_set_bit(LP_PARPORT_CLAIMED, &this_lp->bits))
>  		parport_claim_or_block(this_lp->dev);
> -	}
>  }
>  
>  /* Claim the parport or block trying unless we've already claimed it */
>  static void lp_release_parport(struct lp_struct *this_lp)
>  {
> -	if (test_and_clear_bit(LP_PARPORT_CLAIMED, &this_lp->bits)) {
> +	if (test_and_clear_bit(LP_PARPORT_CLAIMED, &this_lp->bits))
>  		parport_release(this_lp->dev);
> -	}
>  }
>  
> -
> -
>  static int lp_preempt(void *handle)
>  {
>  	struct lp_struct *this_lp = (struct lp_struct *)handle;
> +
>  	set_bit(LP_PREEMPT_REQUEST, &this_lp->bits);
>  	return 1;
>  }
>  
> -
>  /*
>   * Try to negotiate to a new mode; if unsuccessful negotiate to
>   * compatibility mode.  Return the mode we ended up in.
> @@ -207,12 +203,14 @@ static int lp_negotiate(struct parport *port, int mode)
>  static int lp_reset(int minor)
>  {
>  	int retval;
> +
>  	lp_claim_parport_or_block(&lp_table[minor]);
>  	w_ctr(minor, LP_PSELECP);
>  	udelay(LP_DELAY);
>  	w_ctr(minor, LP_PSELECP | LP_PINITP);
>  	retval = r_str(minor);
>  	lp_release_parport(&lp_table[minor]);
> +
>  	return retval;
>  }
>  
> @@ -241,30 +239,34 @@ static int lp_check_status(int minor)
>  	int error = 0;
>  	unsigned int last = lp_table[minor].last_error;
>  	unsigned char status = r_str(minor);
> +
>  	if ((status & LP_PERRORP) && !(LP_F(minor) & LP_CAREFUL))
>  		/* No error. */
>  		last = 0;
>  	else if ((status & LP_POUTPA)) {
>  		if (last != LP_POUTPA) {
>  			last = LP_POUTPA;
> -			printk(KERN_INFO "lp%d out of paper\n", minor);
> +			pr_info("lp%d out of paper\n", minor);
>  		}
>  		error = -ENOSPC;
>  	} else if (!(status & LP_PSELECD)) {
>  		if (last != LP_PSELECD) {
>  			last = LP_PSELECD;
> -			printk(KERN_INFO "lp%d off-line\n", minor);
> +			pr_info("lp%d off-line\n", minor);
>  		}
>  		error = -EIO;
>  	} else if (!(status & LP_PERRORP)) {
>  		if (last != LP_PERRORP) {
>  			last = LP_PERRORP;
> -			printk(KERN_INFO "lp%d on fire\n", minor);
> +			pr_info("lp%d on fire\n", minor);
>  		}
>  		error = -EIO;
>  	} else {
> -		last = 0; /* Come here if LP_CAREFUL is set and no
> -			     errors are reported. */
> +		/*
> +		 * Come here if LP_CAREFUL is set and no
> +		 * errors are reported.
> +		 */
> +		last = 0;
>  	}
>  
>  	lp_table[minor].last_error = last;
> @@ -280,9 +282,8 @@ static int lp_wait_ready(int minor, int nonblock)
>  	int error = 0;
>  
>  	/* If we're not in compatibility mode, we're ready now! */
> -	if (lp_table[minor].current_mode != IEEE1284_MODE_COMPAT) {
> +	if (lp_table[minor].current_mode != IEEE1284_MODE_COMPAT)
>  		return 0;
> -	}
>  
>  	do {
>  		error = lp_check_status(minor);
> @@ -338,68 +339,69 @@ static ssize_t lp_write(struct file *file, const char __user *buf,
>  			    (nonblock ? PARPORT_INACTIVITY_O_NONBLOCK
>  			     : lp_table[minor].timeout));
>  
> -	if ((retv = lp_wait_ready(minor, nonblock)) == 0)
> -	do {
> -		/* Write the data. */
> -		written = parport_write(port, kbuf, copy_size);
> -		if (written > 0) {
> -			copy_size -= written;
> -			count -= written;
> -			buf  += written;
> -			retv += written;
> -		}
> +	retv = lp_wait_ready(minor, nonblock);
> +	if (retv == 0)
> +		do {
> +			/* Write the data. */
> +			written = parport_write(port, kbuf, copy_size);
> +			if (written > 0) {
> +				copy_size -= written;
> +				count -= written;
> +				buf  += written;
> +				retv += written;
> +			}
>  
> -		if (signal_pending(current)) {
> -			if (retv == 0)
> -				retv = -EINTR;
> +			if (signal_pending(current)) {
> +				if (retv == 0)
> +					retv = -EINTR;
>  
> -			break;
> -		}
> +				break;
> +			}
>  
> -		if (copy_size > 0) {
> -			/* incomplete write -> check error ! */
> -			int error;
> +			if (copy_size > 0) {
> +				/* incomplete write -> check error ! */
> +				int error;
>  
> -			parport_negotiate(lp_table[minor].dev->port,
> -					  IEEE1284_MODE_COMPAT);
> -			lp_table[minor].current_mode = IEEE1284_MODE_COMPAT;
> +				parport_negotiate(lp_table[minor].dev->port,
> +						  IEEE1284_MODE_COMPAT);
> +				lp_table[minor].current_mode = IEEE1284_MODE_COMPAT;
>  
> -			error = lp_wait_ready(minor, nonblock);
> +				error = lp_wait_ready(minor, nonblock);
>  
> -			if (error) {
> -				if (retv == 0)
> -					retv = error;
> -				break;
> -			} else if (nonblock) {
> -				if (retv == 0)
> -					retv = -EAGAIN;
> -				break;
> -			}
> +				if (error) {
> +					if (retv == 0)
> +						retv = error;
> +					break;
> +				} else if (nonblock) {
> +					if (retv == 0)
> +						retv = -EAGAIN;
> +					break;
> +				}
>  
> -			parport_yield_blocking(lp_table[minor].dev);
> -			lp_table[minor].current_mode
> -			  = lp_negotiate(port,
> -					 lp_table[minor].best_mode);
> +				parport_yield_blocking(lp_table[minor].dev);
> +				lp_table[minor].current_mode
> +				  = lp_negotiate(port,
> +						 lp_table[minor].best_mode);
>  
> -		} else if (need_resched())
> -			schedule();
> +			} else if (need_resched())
> +				schedule();
>  
> -		if (count) {
> -			copy_size = count;
> -			if (copy_size > LP_BUFFER_SIZE)
> -				copy_size = LP_BUFFER_SIZE;
> +			if (count) {
> +				copy_size = count;
> +				if (copy_size > LP_BUFFER_SIZE)
> +					copy_size = LP_BUFFER_SIZE;
>  
> -			if (copy_from_user(kbuf, buf, copy_size)) {
> -				if (retv == 0)
> -					retv = -EFAULT;
> -				break;
> +				if (copy_from_user(kbuf, buf, copy_size)) {
> +					if (retv == 0)
> +						retv = -EFAULT;
> +					break;
> +				}
>  			}
> -		}
> -	} while (count > 0);
> +		} while (count > 0);
>  
>  	if (test_and_clear_bit(LP_PREEMPT_REQUEST,
>  			       &lp_table[minor].bits)) {
> -		printk(KERN_INFO "lp%d releasing parport\n", minor);
> +		pr_info("lp%d releasing parport\n", minor);
>  		parport_negotiate(lp_table[minor].dev->port,
>  				  IEEE1284_MODE_COMPAT);
>  		lp_table[minor].current_mode = IEEE1284_MODE_COMPAT;
> @@ -418,7 +420,8 @@ static ssize_t lp_read(struct file *file, char __user *buf,
>  		       size_t count, loff_t *ppos)
>  {
>  	DEFINE_WAIT(wait);
> -	unsigned int minor=iminor(file_inode(file));
> +
> +	unsigned int minor = iminor(file_inode(file));
>  	struct parport *port = lp_table[minor].dev->port;
>  	ssize_t retval = 0;
>  	char *kbuf = lp_table[minor].lp_buffer;
> @@ -511,28 +514,32 @@ static int lp_open(struct inode *inode, struct file *file)
>  		ret = -EBUSY;
>  		goto out;
>  	}
> -	/* If ABORTOPEN is set and the printer is offline or out of paper,
> -	   we may still want to open it to perform ioctl()s.  Therefore we
> -	   have commandeered O_NONBLOCK, even though it is being used in
> -	   a non-standard manner.  This is strictly a Linux hack, and
> -	   should most likely only ever be used by the tunelp application. */
> +	/*
> +	 * If ABORTOPEN is set and the printer is offline or out of paper,
> +	 * we may still want to open it to perform ioctl()s. Therefore we
> +	 * have commandeered O_NONBLOCK, even though it is being used in
> +	 * a non-standard manner.  This is strictly a Linux hack, and
> +	 * should most likely only ever be used by the tunelp application.
> +	 */
>  	if ((LP_F(minor) & LP_ABORTOPEN) && !(file->f_flags & O_NONBLOCK)) {
>  		int status;
> +
>  		lp_claim_parport_or_block(&lp_table[minor]);
>  		status = r_str(minor);
>  		lp_release_parport(&lp_table[minor]);
> +
>  		if (status & LP_POUTPA) {
> -			printk(KERN_INFO "lp%d out of paper\n", minor);
> +			pr_info("lp%d out of paper\n", minor);
>  			LP_F(minor) &= ~LP_BUSY;
>  			ret = -ENOSPC;
>  			goto out;
>  		} else if (!(status & LP_PSELECD)) {
> -			printk(KERN_INFO "lp%d off-line\n", minor);
> +			pr_info("lp%d off-line\n", minor);
>  			LP_F(minor) &= ~LP_BUSY;
>  			ret = -EIO;
>  			goto out;
>  		} else if (!(status & LP_PERRORP)) {
> -			printk(KERN_ERR "lp%d printer error\n", minor);
> +			pr_err("lp%d printer error\n", minor);
>  			LP_F(minor) &= ~LP_BUSY;
>  			ret = -EIO;
>  			goto out;
> @@ -549,7 +556,7 @@ static int lp_open(struct inode *inode, struct file *file)
>  	if ((lp_table[minor].dev->port->modes & PARPORT_MODE_ECP) &&
>  	     !parport_negotiate(lp_table[minor].dev->port,
>  				 IEEE1284_MODE_ECP)) {
> -		printk(KERN_INFO "lp%d: ECP mode\n", minor);
> +		pr_info("lp%d: ECP mode\n", minor);
>  		lp_table[minor].best_mode = IEEE1284_MODE_ECP;
>  	} else {
>  		lp_table[minor].best_mode = IEEE1284_MODE_COMPAT;
> @@ -584,81 +591,81 @@ static int lp_do_ioctl(unsigned int minor, unsigned int cmd,
>  	int retval = 0;
>  
>  #ifdef LP_DEBUG
> -	printk(KERN_DEBUG "lp%d ioctl, cmd: 0x%x, arg: 0x%lx\n", minor, cmd, arg);
> +	pr_debug("lp%d ioctl, cmd: 0x%x, arg: 0x%lx\n", minor, cmd, arg);
>  #endif
>  	if (minor >= LP_NO)
>  		return -ENODEV;
>  	if ((LP_F(minor) & LP_EXIST) == 0)
>  		return -ENODEV;
>  	switch (cmd) {
> -		case LPTIME:
> -			if (arg > UINT_MAX / HZ)
> -				return -EINVAL;
> -			LP_TIME(minor) = arg * HZ/100;
> -			break;
> -		case LPCHAR:
> -			LP_CHAR(minor) = arg;
> -			break;
> -		case LPABORT:
> -			if (arg)
> -				LP_F(minor) |= LP_ABORT;
> -			else
> -				LP_F(minor) &= ~LP_ABORT;
> -			break;
> -		case LPABORTOPEN:
> -			if (arg)
> -				LP_F(minor) |= LP_ABORTOPEN;
> -			else
> -				LP_F(minor) &= ~LP_ABORTOPEN;
> -			break;
> -		case LPCAREFUL:
> -			if (arg)
> -				LP_F(minor) |= LP_CAREFUL;
> -			else
> -				LP_F(minor) &= ~LP_CAREFUL;
> -			break;
> -		case LPWAIT:
> -			LP_WAIT(minor) = arg;
> -			break;
> -		case LPSETIRQ:
> +	case LPTIME:
> +		if (arg > UINT_MAX / HZ)
>  			return -EINVAL;
> -		case LPGETIRQ:
> -			if (copy_to_user(argp, &LP_IRQ(minor),
> -					sizeof(int)))
> -				return -EFAULT;
> -			break;
> -		case LPGETSTATUS:
> -			if (mutex_lock_interruptible(&lp_table[minor].port_mutex))
> -				return -EINTR;
> -			lp_claim_parport_or_block(&lp_table[minor]);
> -			status = r_str(minor);
> -			lp_release_parport(&lp_table[minor]);
> -			mutex_unlock(&lp_table[minor].port_mutex);
> -
> -			if (copy_to_user(argp, &status, sizeof(int)))
> -				return -EFAULT;
> -			break;
> -		case LPRESET:
> -			lp_reset(minor);
> -			break;
> +		LP_TIME(minor) = arg * HZ/100;
> +		break;
> +	case LPCHAR:
> +		LP_CHAR(minor) = arg;
> +		break;
> +	case LPABORT:
> +		if (arg)
> +			LP_F(minor) |= LP_ABORT;
> +		else
> +			LP_F(minor) &= ~LP_ABORT;
> +		break;
> +	case LPABORTOPEN:
> +		if (arg)
> +			LP_F(minor) |= LP_ABORTOPEN;
> +		else
> +			LP_F(minor) &= ~LP_ABORTOPEN;
> +		break;
> +	case LPCAREFUL:
> +		if (arg)
> +			LP_F(minor) |= LP_CAREFUL;
> +		else
> +			LP_F(minor) &= ~LP_CAREFUL;
> +		break;
> +	case LPWAIT:
> +		LP_WAIT(minor) = arg;
> +		break;
> +	case LPSETIRQ:
> +		return -EINVAL;
> +	case LPGETIRQ:
> +		if (copy_to_user(argp, &LP_IRQ(minor),
> +				sizeof(int)))
> +			return -EFAULT;
> +		break;
> +	case LPGETSTATUS:
> +		if (mutex_lock_interruptible(&lp_table[minor].port_mutex))
> +			return -EINTR;
> +		lp_claim_parport_or_block(&lp_table[minor]);
> +		status = r_str(minor);
> +		lp_release_parport(&lp_table[minor]);
> +		mutex_unlock(&lp_table[minor].port_mutex);
> +
> +		if (copy_to_user(argp, &status, sizeof(int)))
> +			return -EFAULT;
> +		break;
> +	case LPRESET:
> +		lp_reset(minor);
> +		break;
>  #ifdef LP_STATS
> -		case LPGETSTATS:
> -			if (copy_to_user(argp, &LP_STAT(minor),
> -					sizeof(struct lp_stats)))
> -				return -EFAULT;
> -			if (capable(CAP_SYS_ADMIN))
> -				memset(&LP_STAT(minor), 0,
> -						sizeof(struct lp_stats));
> -			break;
> +	case LPGETSTATS:
> +		if (copy_to_user(argp, &LP_STAT(minor),
> +				sizeof(struct lp_stats)))
> +			return -EFAULT;
> +		if (capable(CAP_SYS_ADMIN))
> +			memset(&LP_STAT(minor), 0,
> +					sizeof(struct lp_stats));
> +		break;
>  #endif
> -		case LPGETFLAGS:
> -			status = LP_F(minor);
> -			if (copy_to_user(argp, &status, sizeof(int)))
> -				return -EFAULT;
> -			break;
> +	case LPGETFLAGS:
> +		status = LP_F(minor);
> +		if (copy_to_user(argp, &status, sizeof(int)))
> +			return -EFAULT;
> +		break;
>  
> -		default:
> -			retval = -EINVAL;
> +	default:
> +		retval = -EINVAL;
>  	}
>  	return retval;
>  }
> @@ -688,9 +695,9 @@ static int lp_set_timeout(unsigned int minor, s64 tv_sec, long tv_usec)
>  		to_jiffies += tv_sec * (long) HZ;
>  	}
>  
> -	if (to_jiffies <= 0) {
> +	if (to_jiffies <= 0)
>  		return -EINVAL;
> -	}
> +
>  	lp_table[minor].timeout = to_jiffies;
>  	return 0;
>  }
> @@ -802,15 +809,17 @@ static const struct file_operations lp_fops = {
>  
>  #define CONSOLE_LP 0
>  
> -/* If the printer is out of paper, we can either lose the messages or
> +/*
> + * If the printer is out of paper, we can either lose the messages or
>   * stall until the printer is happy again.  Define CONSOLE_LP_STRICT
> - * non-zero to get the latter behaviour. */
> + * non-zero to get the latter behaviour.
> + */
>  #define CONSOLE_LP_STRICT 1
>  
>  /* The console must be locked when we get here. */
>  
>  static void lp_console_write(struct console *co, const char *s,
> -			     unsigned count)
> +			     unsigned int count)
>  {
>  	struct pardevice *dev = lp_table[CONSOLE_LP].dev;
>  	struct parport *port = dev->port;
> @@ -829,6 +838,7 @@ static void lp_console_write(struct console *co, const char *s,
>  		/* Write the data, converting LF->CRLF as we go. */
>  		ssize_t canwrite = count;
>  		char *lf = memchr(s, '\n', count);
> +
>  		if (lf)
>  			canwrite = lf - s;
>  
> @@ -891,24 +901,28 @@ static int __init lp_setup(char *str)
>  			/* disable driver on "lp=" or "lp=0" */
>  			parport_nr[0] = LP_PARPORT_OFF;
>  		} else {
> -			printk(KERN_WARNING "warning: 'lp=0x%x' is deprecated, ignored\n", x);
> +			pr_warn("warning: 'lp=0x%x' is deprecated, ignored\n", x);
>  			return 0;
>  		}
>  	} else if (!strncmp(str, "parport", 7)) {
> -		int n = simple_strtoul(str+7, NULL, 10);
> +		int err;
> +		unsigned long n = 0;
> +
> +		err = kstrtoul(str+7, 10, &n);
> +		if (err)
> +			return err;
> +
>  		if (parport_ptr < LP_NO)
>  			parport_nr[parport_ptr++] = n;
>  		else
> -			printk(KERN_INFO "lp: too many ports, %s ignored.\n",
> -			       str);
> +			pr_info("lp: too many ports, %s ignored.\n", str);
>  	} else if (!strcmp(str, "auto")) {
>  		parport_nr[0] = LP_PARPORT_AUTO;
>  	} else if (!strcmp(str, "none")) {
>  		if (parport_ptr < LP_NO)
>  			parport_nr[parport_ptr++] = LP_PARPORT_NONE;
>  		else
> -			printk(KERN_INFO "lp: too many ports, %s ignored.\n",
> -			       str);
> +			pr_info("lp: too many ports, %s ignored.\n", str);
>  	} else if (!strcmp(str, "reset")) {
>  		reset = true;
>  	}
> @@ -935,7 +949,7 @@ static int lp_register(int nr, struct parport *port)
>  	device_create(lp_class, port->dev, MKDEV(LP_MAJOR, nr), NULL,
>  		      "lp%d", nr);
>  
> -	printk(KERN_INFO "lp%d: using %s (%s).\n", nr, port->name,
> +	pr_info("lp%d: using %s (%s).\n", nr, port->name,
>  	       (port->irq == PARPORT_IRQ_NONE)?"polling":"interrupt-driven");
>  
>  #ifdef CONFIG_LP_CONSOLE
> @@ -943,9 +957,9 @@ static int lp_register(int nr, struct parport *port)
>  		if (port->modes & PARPORT_MODE_SAFEININT) {
>  			register_console(&lpcons);
>  			console_registered = port;
> -			printk(KERN_INFO "lp%d: console ready\n", CONSOLE_LP);
> +			pr_info("lp%d: console ready\n", CONSOLE_LP);
>  		} else
> -			printk(KERN_ERR "lp%d: cannot run console on %s\n",
> +			pr_err("lp%d: cannot run console on %s\n",
>  			       CONSOLE_LP, port->name);
>  	}
>  #endif
> @@ -965,7 +979,7 @@ static void lp_attach(struct parport *port)
>  		    port->probe_info[0].class != PARPORT_CLASS_PRINTER)
>  			return;
>  		if (lp_count == LP_NO) {
> -			printk(KERN_INFO "lp: ignoring parallel port (max. %d)\n",LP_NO);
> +			pr_info("lp: ignoring parallel port (max. %d)\n", LP_NO);
>  			return;
>  		}
>  		for (i = 0; i < LP_NO; i++)
> @@ -1045,7 +1059,7 @@ static int __init lp_init(void)
>  	}
>  
>  	if (register_chrdev(LP_MAJOR, "lp", &lp_fops)) {
> -		printk(KERN_ERR "lp: unable to get major %d\n", LP_MAJOR);
> +		pr_err("lp: unable to get major %d\n", LP_MAJOR);
>  		return -EIO;
>  	}
>  
> @@ -1056,16 +1070,16 @@ static int __init lp_init(void)
>  	}
>  
>  	if (parport_register_driver(&lp_driver)) {
> -		printk(KERN_ERR "lp: unable to register with parport\n");
> +		pr_err("lp: unable to register with parport\n");
>  		err = -EIO;
>  		goto out_class;
>  	}
>  
>  	if (!lp_count) {
> -		printk(KERN_INFO "lp: driver loaded but no devices found\n");
> +		pr_info("lp: driver loaded but no devices found\n");
>  #ifndef CONFIG_PARPORT_1284
>  		if (parport_nr[0] == LP_PARPORT_AUTO)
> -			printk(KERN_INFO "lp: (is IEEE 1284 support enabled?)\n");
> +			pr_info("lp: (is IEEE 1284 support enabled?)\n");
>  #endif
>  	}
>  
> @@ -1086,16 +1100,19 @@ static int __init lp_init_module(void)
>  			parport_nr[0] = LP_PARPORT_AUTO;
>  		else {
>  			int n;
> +
>  			for (n = 0; n < LP_NO && parport[n]; n++) {
>  				if (!strncmp(parport[n], "none", 4))
>  					parport_nr[n] = LP_PARPORT_NONE;
>  				else {
>  					char *ep;
> +					/* Don't update to kstrtoul, ep needs to be updated */
>  					unsigned long r = simple_strtoul(parport[n], &ep, 0);
> +
>  					if (ep != parport[n])
>  						parport_nr[n] = r;
>  					else {
> -						printk(KERN_ERR "lp: bad port specifier `%s'\n", parport[n]);
> +						pr_err("lp: bad port specifier `%s'\n", parport[n]);
>  						return -ENODEV;
>  					}
>  				}
> -- 
> 2.36.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
