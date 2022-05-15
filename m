Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EAF527652
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 09:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbiEOHzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 03:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235592AbiEOHzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 03:55:10 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696E71834D
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 00:55:08 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso11547647pjg.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 00:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CHLH0Txge5ROzHCl0GOaJ0/DvPh4wMOxxW9iDM4ZsGw=;
        b=bI0wrWLGdsQprbICQSOojusmHla8KHbq4M+XE2QPsu1jOFAnXbK0+h7Kq63sXv0M8l
         Gu3/HqEYHhEhVMrn0FwYEwyI1mCC0vg0C96SME8vrmgPzRtgqIfaHFaTjcmJCppwJUU4
         psICSGlatAnYEt/b8C/BD0pWYg/8mHHxlpA/kQ93PnIAJQQ+Jj9BMpwABQ7V21v/xECE
         /NFdJSTkM/wVwrpw0omcm+6gk0drM9QPir2O5POaU6LF3UgpFnIkMIPlKjwhSAqTW0Tt
         /D3/QSZPtyBxWvSqFBR1+/BOGXLOe4k1lgHbgTWJUqhsY/1uxj+dXyyabWsbrWM4j/LH
         rwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CHLH0Txge5ROzHCl0GOaJ0/DvPh4wMOxxW9iDM4ZsGw=;
        b=Bkzjl01AxUE9XO9ARcTcNerN2RelUwfY2jlWw1+Ty1stMqydbzBj/ISkamuGN3ahv/
         MHgD+5iHR9Kpa9okXJ8B/66Y6iaEzvjxwcjcHsH7AHSkvCwQNEXCDhn0aDASB9Les7he
         BrrBN2BmP8z8J8YRumfxsIpNZl/l5tkeGnVx/OotilM4KPmNHTUSdask8kM/igt5LsZj
         RsomycdxRo/NR3oZXviKsJtnhVwSIDtY/Hvd1id/aWXc3SQhgC3dc861xotaC5fZCVlf
         mu2Z77SGCZDcF+ltt/pEXXllRObn7UtQP0bvXp78hZJmgWpdSfT2ftotSKlrgwNmGqTS
         ASSg==
X-Gm-Message-State: AOAM5330/bwwmLz77IpZoG+Ll2+mMdca0OMZMEH5R/ECQXmlwoavgeBV
        v1Sj58gEBREHT2gsLluAU8M=
X-Google-Smtp-Source: ABdhPJxOuI8RXr9SyM3jbas7Mn/gz0p/cK1P1dANMVKT9rgaTss/VAglihXA6kAEzS/ZKMJcX4gwyg==
X-Received: by 2002:a17:902:d2c6:b0:161:6e0e:c5e1 with SMTP id n6-20020a170902d2c600b001616e0ec5e1mr1526281plc.139.1652601307819;
        Sun, 15 May 2022 00:55:07 -0700 (PDT)
Received: from f34-buildvm.eng.vmware.com ([66.170.99.2])
        by smtp.googlemail.com with ESMTPSA id k4-20020a628404000000b0050dc76281dcsm4624267pfd.182.2022.05.15.00.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 00:55:07 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, yesshedi@gmail.com,
        Shreenidhi Shedi <sshedi@vmware.com>
Subject: [PATCH 3/3] char: lp: fix most of checkspec.pl warnings & errors
Date:   Sun, 15 May 2022 13:24:55 +0530
Message-Id: <20220515075455.306082-3-sshedi@vmware.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220515075455.306082-1-sshedi@vmware.com>
References: <20220515075455.306082-1-sshedi@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes almost all styling issues reported by checkpatch.pl
script.

Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
---
 drivers/char/lp.c | 338 ++++++++++++++++++++++++----------------------
 1 file changed, 177 insertions(+), 161 deletions(-)

diff --git a/drivers/char/lp.c b/drivers/char/lp.c
index 5e8bd8d6c..2efebdfac 100644
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -16,7 +16,7 @@
  * Support for parport by Philip Blundell <philb@gnu.org>
  * Parport sharing hacking by Andrea Arcangeli
  * Fixed kernel_(to/from)_user memory copy to check for errors
- * 				by Riccardo Facchetti <fizban@tin.it>
+ *				by Riccardo Facchetti <fizban@tin.it>
  * 22-JAN-1998  Added support for devfs  Richard Gooch <rgooch@atnf.csiro.au>
  * Redesigned interrupt handling for handle printers with buggy handshake
  *				by Andrea Arcangeli, 11 May 1998
@@ -30,7 +30,7 @@
  * CAREFUL will block a bit after in lp_check_status().
  *				Andrea Arcangeli, 15 Oct 1998
  * Obsoleted and removed all the lowlevel stuff implemented in the last
- * month to use the IEEE1284 functions (that handle the _new_ compatibilty
+ * month to use the IEEE1284 functions (that handle the _new_ compatibility
  * mode fine).
  */
 
@@ -144,7 +144,7 @@ static DEFINE_MUTEX(lp_mutex);
 static struct lp_struct lp_table[LP_NO];
 static int port_num[LP_NO];
 
-static unsigned int lp_count = 0;
+static unsigned int lp_count;
 static struct class *lp_class;
 
 #ifdef CONFIG_LP_CONSOLE
@@ -161,35 +161,31 @@ static struct parport *console_registered;
 
 #define r_dtr(x)	(parport_read_data(lp_table[(x)].dev->port))
 #define r_str(x)	(parport_read_status(lp_table[(x)].dev->port))
-#define w_ctr(x,y)	do { parport_write_control(lp_table[(x)].dev->port, (y)); } while (0)
-#define w_dtr(x,y)	do { parport_write_data(lp_table[(x)].dev->port, (y)); } while (0)
+#define w_ctr(x, y)	(parport_write_control(lp_table[(x)].dev->port, (y)))
+#define w_dtr(x, y)	(parport_write_data(lp_table[(x)].dev->port, (y)))
 
 /* Claim the parport or block trying unless we've already claimed it */
 static void lp_claim_parport_or_block(struct lp_struct *this_lp)
 {
-	if (!test_and_set_bit(LP_PARPORT_CLAIMED, &this_lp->bits)) {
+	if (!test_and_set_bit(LP_PARPORT_CLAIMED, &this_lp->bits))
 		parport_claim_or_block(this_lp->dev);
-	}
 }
 
 /* Claim the parport or block trying unless we've already claimed it */
 static void lp_release_parport(struct lp_struct *this_lp)
 {
-	if (test_and_clear_bit(LP_PARPORT_CLAIMED, &this_lp->bits)) {
+	if (test_and_clear_bit(LP_PARPORT_CLAIMED, &this_lp->bits))
 		parport_release(this_lp->dev);
-	}
 }
 
-
-
 static int lp_preempt(void *handle)
 {
 	struct lp_struct *this_lp = (struct lp_struct *)handle;
+
 	set_bit(LP_PREEMPT_REQUEST, &this_lp->bits);
 	return 1;
 }
 
-
 /*
  * Try to negotiate to a new mode; if unsuccessful negotiate to
  * compatibility mode.  Return the mode we ended up in.
@@ -207,12 +203,14 @@ static int lp_negotiate(struct parport *port, int mode)
 static int lp_reset(int minor)
 {
 	int retval;
+
 	lp_claim_parport_or_block(&lp_table[minor]);
 	w_ctr(minor, LP_PSELECP);
 	udelay(LP_DELAY);
 	w_ctr(minor, LP_PSELECP | LP_PINITP);
 	retval = r_str(minor);
 	lp_release_parport(&lp_table[minor]);
+
 	return retval;
 }
 
@@ -241,30 +239,34 @@ static int lp_check_status(int minor)
 	int error = 0;
 	unsigned int last = lp_table[minor].last_error;
 	unsigned char status = r_str(minor);
+
 	if ((status & LP_PERRORP) && !(LP_F(minor) & LP_CAREFUL))
 		/* No error. */
 		last = 0;
 	else if ((status & LP_POUTPA)) {
 		if (last != LP_POUTPA) {
 			last = LP_POUTPA;
-			printk(KERN_INFO "lp%d out of paper\n", minor);
+			pr_info("lp%d out of paper\n", minor);
 		}
 		error = -ENOSPC;
 	} else if (!(status & LP_PSELECD)) {
 		if (last != LP_PSELECD) {
 			last = LP_PSELECD;
-			printk(KERN_INFO "lp%d off-line\n", minor);
+			pr_info("lp%d off-line\n", minor);
 		}
 		error = -EIO;
 	} else if (!(status & LP_PERRORP)) {
 		if (last != LP_PERRORP) {
 			last = LP_PERRORP;
-			printk(KERN_INFO "lp%d on fire\n", minor);
+			pr_info("lp%d on fire\n", minor);
 		}
 		error = -EIO;
 	} else {
-		last = 0; /* Come here if LP_CAREFUL is set and no
-			     errors are reported. */
+		/*
+		 * Come here if LP_CAREFUL is set and no
+		 * errors are reported.
+		 */
+		last = 0;
 	}
 
 	lp_table[minor].last_error = last;
@@ -280,9 +282,8 @@ static int lp_wait_ready(int minor, int nonblock)
 	int error = 0;
 
 	/* If we're not in compatibility mode, we're ready now! */
-	if (lp_table[minor].current_mode != IEEE1284_MODE_COMPAT) {
+	if (lp_table[minor].current_mode != IEEE1284_MODE_COMPAT)
 		return 0;
-	}
 
 	do {
 		error = lp_check_status(minor);
@@ -338,68 +339,69 @@ static ssize_t lp_write(struct file *file, const char __user *buf,
 			    (nonblock ? PARPORT_INACTIVITY_O_NONBLOCK
 			     : lp_table[minor].timeout));
 
-	if ((retv = lp_wait_ready(minor, nonblock)) == 0)
-	do {
-		/* Write the data. */
-		written = parport_write(port, kbuf, copy_size);
-		if (written > 0) {
-			copy_size -= written;
-			count -= written;
-			buf  += written;
-			retv += written;
-		}
+	retv = lp_wait_ready(minor, nonblock);
+	if (retv == 0)
+		do {
+			/* Write the data. */
+			written = parport_write(port, kbuf, copy_size);
+			if (written > 0) {
+				copy_size -= written;
+				count -= written;
+				buf  += written;
+				retv += written;
+			}
 
-		if (signal_pending(current)) {
-			if (retv == 0)
-				retv = -EINTR;
+			if (signal_pending(current)) {
+				if (retv == 0)
+					retv = -EINTR;
 
-			break;
-		}
+				break;
+			}
 
-		if (copy_size > 0) {
-			/* incomplete write -> check error ! */
-			int error;
+			if (copy_size > 0) {
+				/* incomplete write -> check error ! */
+				int error;
 
-			parport_negotiate(lp_table[minor].dev->port,
-					  IEEE1284_MODE_COMPAT);
-			lp_table[minor].current_mode = IEEE1284_MODE_COMPAT;
+				parport_negotiate(lp_table[minor].dev->port,
+						  IEEE1284_MODE_COMPAT);
+				lp_table[minor].current_mode = IEEE1284_MODE_COMPAT;
 
-			error = lp_wait_ready(minor, nonblock);
+				error = lp_wait_ready(minor, nonblock);
 
-			if (error) {
-				if (retv == 0)
-					retv = error;
-				break;
-			} else if (nonblock) {
-				if (retv == 0)
-					retv = -EAGAIN;
-				break;
-			}
+				if (error) {
+					if (retv == 0)
+						retv = error;
+					break;
+				} else if (nonblock) {
+					if (retv == 0)
+						retv = -EAGAIN;
+					break;
+				}
 
-			parport_yield_blocking(lp_table[minor].dev);
-			lp_table[minor].current_mode
-			  = lp_negotiate(port,
-					 lp_table[minor].best_mode);
+				parport_yield_blocking(lp_table[minor].dev);
+				lp_table[minor].current_mode
+				  = lp_negotiate(port,
+						 lp_table[minor].best_mode);
 
-		} else if (need_resched())
-			schedule();
+			} else if (need_resched())
+				schedule();
 
-		if (count) {
-			copy_size = count;
-			if (copy_size > LP_BUFFER_SIZE)
-				copy_size = LP_BUFFER_SIZE;
+			if (count) {
+				copy_size = count;
+				if (copy_size > LP_BUFFER_SIZE)
+					copy_size = LP_BUFFER_SIZE;
 
-			if (copy_from_user(kbuf, buf, copy_size)) {
-				if (retv == 0)
-					retv = -EFAULT;
-				break;
+				if (copy_from_user(kbuf, buf, copy_size)) {
+					if (retv == 0)
+						retv = -EFAULT;
+					break;
+				}
 			}
-		}
-	} while (count > 0);
+		} while (count > 0);
 
 	if (test_and_clear_bit(LP_PREEMPT_REQUEST,
 			       &lp_table[minor].bits)) {
-		printk(KERN_INFO "lp%d releasing parport\n", minor);
+		pr_info("lp%d releasing parport\n", minor);
 		parport_negotiate(lp_table[minor].dev->port,
 				  IEEE1284_MODE_COMPAT);
 		lp_table[minor].current_mode = IEEE1284_MODE_COMPAT;
@@ -418,7 +420,8 @@ static ssize_t lp_read(struct file *file, char __user *buf,
 		       size_t count, loff_t *ppos)
 {
 	DEFINE_WAIT(wait);
-	unsigned int minor=iminor(file_inode(file));
+
+	unsigned int minor = iminor(file_inode(file));
 	struct parport *port = lp_table[minor].dev->port;
 	ssize_t retval = 0;
 	char *kbuf = lp_table[minor].lp_buffer;
@@ -511,28 +514,32 @@ static int lp_open(struct inode *inode, struct file *file)
 		ret = -EBUSY;
 		goto out;
 	}
-	/* If ABORTOPEN is set and the printer is offline or out of paper,
-	   we may still want to open it to perform ioctl()s.  Therefore we
-	   have commandeered O_NONBLOCK, even though it is being used in
-	   a non-standard manner.  This is strictly a Linux hack, and
-	   should most likely only ever be used by the tunelp application. */
+	/*
+	 * If ABORTOPEN is set and the printer is offline or out of paper,
+	 * we may still want to open it to perform ioctl()s. Therefore we
+	 * have commandeered O_NONBLOCK, even though it is being used in
+	 * a non-standard manner.  This is strictly a Linux hack, and
+	 * should most likely only ever be used by the tunelp application.
+	 */
 	if ((LP_F(minor) & LP_ABORTOPEN) && !(file->f_flags & O_NONBLOCK)) {
 		int status;
+
 		lp_claim_parport_or_block(&lp_table[minor]);
 		status = r_str(minor);
 		lp_release_parport(&lp_table[minor]);
+
 		if (status & LP_POUTPA) {
-			printk(KERN_INFO "lp%d out of paper\n", minor);
+			pr_info("lp%d out of paper\n", minor);
 			LP_F(minor) &= ~LP_BUSY;
 			ret = -ENOSPC;
 			goto out;
 		} else if (!(status & LP_PSELECD)) {
-			printk(KERN_INFO "lp%d off-line\n", minor);
+			pr_info("lp%d off-line\n", minor);
 			LP_F(minor) &= ~LP_BUSY;
 			ret = -EIO;
 			goto out;
 		} else if (!(status & LP_PERRORP)) {
-			printk(KERN_ERR "lp%d printer error\n", minor);
+			pr_err("lp%d printer error\n", minor);
 			LP_F(minor) &= ~LP_BUSY;
 			ret = -EIO;
 			goto out;
@@ -591,75 +598,74 @@ static int lp_do_ioctl(unsigned int minor, unsigned int cmd,
 	if ((LP_F(minor) & LP_EXIST) == 0)
 		return -ENODEV;
 	switch ( cmd ) {
-		case LPTIME:
-			if (arg > UINT_MAX / HZ)
-				return -EINVAL;
-			LP_TIME(minor) = arg * HZ/100;
-			break;
-		case LPCHAR:
-			LP_CHAR(minor) = arg;
-			break;
-		case LPABORT:
-			if (arg)
-				LP_F(minor) |= LP_ABORT;
-			else
-				LP_F(minor) &= ~LP_ABORT;
-			break;
-		case LPABORTOPEN:
-			if (arg)
-				LP_F(minor) |= LP_ABORTOPEN;
-			else
-				LP_F(minor) &= ~LP_ABORTOPEN;
-			break;
-		case LPCAREFUL:
-			if (arg)
-				LP_F(minor) |= LP_CAREFUL;
-			else
-				LP_F(minor) &= ~LP_CAREFUL;
-			break;
-		case LPWAIT:
-			LP_WAIT(minor) = arg;
-			break;
-		case LPSETIRQ:
+	case LPTIME:
+		if (arg > UINT_MAX / HZ)
 			return -EINVAL;
-			break;
-		case LPGETIRQ:
-			if (copy_to_user(argp, &LP_IRQ(minor),
-					sizeof(int)))
-				return -EFAULT;
-			break;
-		case LPGETSTATUS:
-			if (mutex_lock_interruptible(&lp_table[minor].port_mutex))
-				return -EINTR;
-			lp_claim_parport_or_block(&lp_table[minor]);
-			status = r_str(minor);
-			lp_release_parport(&lp_table[minor]);
-			mutex_unlock(&lp_table[minor].port_mutex);
-
-			if (copy_to_user(argp, &status, sizeof(int)))
-				return -EFAULT;
-			break;
-		case LPRESET:
-			lp_reset(minor);
-			break;
+		LP_TIME(minor) = arg * HZ/100;
+		break;
+	case LPCHAR:
+		LP_CHAR(minor) = arg;
+		break;
+	case LPABORT:
+		if (arg)
+			LP_F(minor) |= LP_ABORT;
+		else
+			LP_F(minor) &= ~LP_ABORT;
+		break;
+	case LPABORTOPEN:
+		if (arg)
+			LP_F(minor) |= LP_ABORTOPEN;
+		else
+			LP_F(minor) &= ~LP_ABORTOPEN;
+		break;
+	case LPCAREFUL:
+		if (arg)
+			LP_F(minor) |= LP_CAREFUL;
+		else
+			LP_F(minor) &= ~LP_CAREFUL;
+		break;
+	case LPWAIT:
+		LP_WAIT(minor) = arg;
+		break;
+	case LPSETIRQ:
+		return -EINVAL;
+	case LPGETIRQ:
+		if (copy_to_user(argp, &LP_IRQ(minor),
+				sizeof(int)))
+			return -EFAULT;
+		break;
+	case LPGETSTATUS:
+		if (mutex_lock_interruptible(&lp_table[minor].port_mutex))
+			return -EINTR;
+		lp_claim_parport_or_block(&lp_table[minor]);
+		status = r_str(minor);
+		lp_release_parport(&lp_table[minor]);
+		mutex_unlock(&lp_table[minor].port_mutex);
+
+		if (copy_to_user(argp, &status, sizeof(int)))
+			return -EFAULT;
+		break;
+	case LPRESET:
+		lp_reset(minor);
+		break;
 #ifdef LP_STATS
-		case LPGETSTATS:
-			if (copy_to_user(argp, &LP_STAT(minor),
-					sizeof(struct lp_stats)))
-				return -EFAULT;
-			if (capable(CAP_SYS_ADMIN))
-				memset(&LP_STAT(minor), 0,
-						sizeof(struct lp_stats));
-			break;
+	case LPGETSTATS:
+		if (copy_to_user(argp, &LP_STAT(minor),
+				sizeof(struct lp_stats)))
+			return -EFAULT;
+		if (capable(CAP_SYS_ADMIN))
+			memset(&LP_STAT(minor), 0,
+					sizeof(struct lp_stats));
+		break;
 #endif
-		case LPGETFLAGS:
-			status = LP_F(minor);
-			if (copy_to_user(argp, &status, sizeof(int)))
-				return -EFAULT;
-			break;
+	case LPGETFLAGS:
+		status = LP_F(minor);
+		if (copy_to_user(argp, &status, sizeof(int)))
+			return -EFAULT;
+		break;
 
-		default:
-			retval = -EINVAL;
+	default:
+		retval = -EINVAL;
 	}
 	return retval;
 }
@@ -689,9 +695,9 @@ static int lp_set_timeout(unsigned int minor, s64 tv_sec, long tv_usec)
 		to_jiffies += tv_sec * (long) HZ;
 	}
 
-	if (to_jiffies <= 0) {
+	if (to_jiffies <= 0)
 		return -EINVAL;
-	}
+
 	lp_table[minor].timeout = to_jiffies;
 	return 0;
 }
@@ -803,15 +809,17 @@ static const struct file_operations lp_fops = {
 
 #define CONSOLE_LP 0
 
-/* If the printer is out of paper, we can either lose the messages or
+/*
+ * If the printer is out of paper, we can either lose the messages or
  * stall until the printer is happy again.  Define CONSOLE_LP_STRICT
- * non-zero to get the latter behaviour. */
+ * non-zero to get the latter behaviour.
+ */
 #define CONSOLE_LP_STRICT 1
 
 /* The console must be locked when we get here. */
 
 static void lp_console_write(struct console *co, const char *s,
-			     unsigned count)
+			     unsigned int count)
 {
 	struct pardevice *dev = lp_table[CONSOLE_LP].dev;
 	struct parport *port = dev->port;
@@ -830,6 +838,7 @@ static void lp_console_write(struct console *co, const char *s,
 		/* Write the data, converting LF->CRLF as we go. */
 		ssize_t canwrite = count;
 		char *lf = memchr(s, '\n', count);
+
 		if (lf)
 			canwrite = lf - s;
 
@@ -890,24 +899,28 @@ static int __init lp_setup(char *str)
 			/* disable driver on "lp=" or "lp=0" */
 			parport_nr[0] = LP_PARPORT_OFF;
 		} else {
-			printk(KERN_WARNING "warning: 'lp=0x%x' is deprecated, ignored\n", x);
+			pr_warn("warning: 'lp=0x%x' is deprecated, ignored\n", x);
 			return 0;
 		}
 	} else if (!strncmp(str, "parport", 7)) {
-		int n = simple_strtoul(str+7, NULL, 10);
+		int err;
+		unsigned long n = 0;
+
+		err = kstrtoul(str+7, 10, &n);
+		if (err)
+			return err;
+
 		if (parport_ptr < LP_NO)
 			parport_nr[parport_ptr++] = n;
 		else
-			printk(KERN_INFO "lp: too many ports, %s ignored.\n",
-			       str);
+			pr_info("lp: too many ports, %s ignored.\n", str);
 	} else if (!strcmp(str, "auto")) {
 		parport_nr[0] = LP_PARPORT_AUTO;
 	} else if (!strcmp(str, "none")) {
 		if (parport_ptr < LP_NO)
 			parport_nr[parport_ptr++] = LP_PARPORT_NONE;
 		else
-			printk(KERN_INFO "lp: too many ports, %s ignored.\n",
-			       str);
+			pr_info("lp: too many ports, %s ignored.\n", str);
 	} else if (!strcmp(str, "reset")) {
 		reset = true;
 	}
@@ -934,7 +947,7 @@ static int lp_register(int nr, struct parport *port)
 	device_create(lp_class, port->dev, MKDEV(LP_MAJOR, nr), NULL,
 		      "lp%d", nr);
 
-	printk(KERN_INFO "lp%d: using %s (%s).\n", nr, port->name,
+	pr_info("lp%d: using %s (%s).\n", nr, port->name,
 	       (port->irq == PARPORT_IRQ_NONE)?"polling":"interrupt-driven");
 
 #ifdef CONFIG_LP_CONSOLE
@@ -942,9 +955,9 @@ static int lp_register(int nr, struct parport *port)
 		if (port->modes & PARPORT_MODE_SAFEININT) {
 			register_console(&lpcons);
 			console_registered = port;
-			printk(KERN_INFO "lp%d: console ready\n", CONSOLE_LP);
+			pr_info("lp%d: console ready\n", CONSOLE_LP);
 		} else
-			printk(KERN_ERR "lp%d: cannot run console on %s\n",
+			pr_err("lp%d: cannot run console on %s\n",
 			       CONSOLE_LP, port->name);
 	}
 #endif
@@ -964,7 +977,7 @@ static void lp_attach(struct parport *port)
 		    port->probe_info[0].class != PARPORT_CLASS_PRINTER)
 			return;
 		if (lp_count == LP_NO) {
-			printk(KERN_INFO "lp: ignoring parallel port (max. %d)\n",LP_NO);
+			pr_info("lp: ignoring parallel port (max. %d)\n", LP_NO);
 			return;
 		}
 		for (i = 0; i < LP_NO; i++)
@@ -1044,7 +1057,7 @@ static int __init lp_init(void)
 	}
 
 	if (register_chrdev(LP_MAJOR, "lp", &lp_fops)) {
-		printk(KERN_ERR "lp: unable to get major %d\n", LP_MAJOR);
+		pr_err("lp: unable to get major %d\n", LP_MAJOR);
 		return -EIO;
 	}
 
@@ -1055,16 +1068,16 @@ static int __init lp_init(void)
 	}
 
 	if (parport_register_driver(&lp_driver)) {
-		printk(KERN_ERR "lp: unable to register with parport\n");
+		pr_err("lp: unable to register with parport\n");
 		err = -EIO;
 		goto out_class;
 	}
 
 	if (!lp_count) {
-		printk(KERN_INFO "lp: driver loaded but no devices found\n");
+		pr_info("lp: driver loaded but no devices found\n");
 #ifndef CONFIG_PARPORT_1284
 		if (parport_nr[0] == LP_PARPORT_AUTO)
-			printk(KERN_INFO "lp: (is IEEE 1284 support enabled?)\n");
+			pr_info("lp: (is IEEE 1284 support enabled?)\n");
 #endif
 	}
 
@@ -1085,16 +1098,19 @@ static int __init lp_init_module(void)
 			parport_nr[0] = LP_PARPORT_AUTO;
 		else {
 			int n;
+
 			for (n = 0; n < LP_NO && parport[n]; n++) {
 				if (!strncmp(parport[n], "none", 4))
 					parport_nr[n] = LP_PARPORT_NONE;
 				else {
 					char *ep;
+					/* Don't update to kstrtoul, ep needs to be updated */
 					unsigned long r = simple_strtoul(parport[n], &ep, 0);
+
 					if (ep != parport[n])
 						parport_nr[n] = r;
 					else {
-						printk(KERN_ERR "lp: bad port specifier `%s'\n", parport[n]);
+						pr_err("lp: bad port specifier `%s'\n", parport[n]);
 						return -ENODEV;
 					}
 				}
-- 
2.36.1

