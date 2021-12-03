Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2DD44679B9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 15:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243873AbhLCOwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 09:52:18 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:41185 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232854AbhLCOwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 09:52:17 -0500
Received: from [192.168.0.2] (ip5f5aed2c.dynamic.kabel-deutschland.de [95.90.237.44])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id BB84E61EA1927;
        Fri,  3 Dec 2021 15:48:51 +0100 (CET)
Message-ID: <8fdeecc3-bcce-1f5c-9aac-656fb3464c27@molgen.mpg.de>
Date:   Fri, 3 Dec 2021 15:48:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     "James E. J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Part of Spinning up disk... ....ready logged on separate line and as
 warning (default level)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


Plugging in an external HDD over USB, Linux logs a warning:

     $ dmesg --level=warn
     [  244.677769] ....ready

With the messages around it:

     [  243.663382] sd 10:0:0:0: [sdb] Spinning up disk...
     [  244.677769] ....ready

The code in `drivers/scsi/sd.c` suggests that now line break should 
happen, as no `\n` is used and `printk(KERN_CONT ".")`. If that would 
work, the message would also be logged with level `KERN_NOTICE`.

Is the macro somehow getting in the way?

     sd_printk(KERN_NOTICE, sdkp, "Spinning up disk...");

 From `drivers/scsi/sd.h`:

```
#define sd_printk(prefix, sdsk, fmt, a...)                              \
         (sdsk)->disk ?                                                  \
               sdev_prefix_printk(prefix, (sdsk)->device,                \
                                  (sdsk)->disk->disk_name, fmt, ##a) :   \
               sdev_printk(prefix, (sdsk)->device, fmt, ##a)
```

 From `drivers/scsi/scsi_logging.c`:

```
void sdev_prefix_printk(const char *level, const struct scsi_device *sdev,
                         const char *name, const char *fmt, ...)
{
         va_list args;
         char *logbuf;
         size_t off = 0, logbuf_len;

         if (!sdev)
                 return;

         logbuf = scsi_log_reserve_buffer(&logbuf_len);
         if (!logbuf)
                 return;

         if (name)
                 off += scnprintf(logbuf + off, logbuf_len - off,
                                  "[%s] ", name);
         if (!WARN_ON(off >= logbuf_len)) {
                 va_start(args, fmt);
                 off += vscnprintf(logbuf + off, logbuf_len - off, fmt, 
args);
                 va_end(args);
         }
         dev_printk(level, &sdev->sdev_gendev, "%s", logbuf);
         scsi_log_release_buffer(logbuf);
}
EXPORT_SYMBOL(sdev_prefix_printk);
```

Also, there are four dots in `....ready`, but the log timestamps only 
differ by one seconds.

     /* Wait 1 second for next try */
     msleep(1000);
     printk(KERN_CONT ".");

Any idea, how that can be?


Kind regards,

Paul
