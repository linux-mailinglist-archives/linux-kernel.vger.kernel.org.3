Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FCD59A9CD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 02:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243139AbiHTAHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 20:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244772AbiHTAHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 20:07:19 -0400
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30F31156F2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 17:07:12 -0700 (PDT)
Received: by mail-pg1-f171.google.com with SMTP id v4so4832572pgi.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 17:07:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=iNc0+qZK4maYA+Nyvb5N9XcmUuPrIeK5kHdMUPdhfyQ=;
        b=VhZPAbeD7ZpWvXppNMo5H2Ei6IQLue+r+UWXc7QPYfENlJoew5V49Y/pf8BIcKeUbT
         x0jznppvDRUqfI/hsnhQIS3Z0yZZ+LJTf39xGmjczqf+l8oZZkEk1MXhRyiwt2V698CC
         mR5hMsnup/kG17YsgG+KKaRtYiW7PD8iWTFCCUhseozIYTpKaPZvW2NR7Ckj4aroXI5l
         KHhIAG2dJkdbFz6o1wBMRmpTVvMVch6HDFUbNxNaG1Gwiu3hjC3tMBdNBkE+sidzSmYH
         r+6MW5yMsBJ4WTENqF4LYYLBGtqhGJhVJcb3KnAF3szfX9h87ZDcDaeI9beBzkpMti9E
         +7lQ==
X-Gm-Message-State: ACgBeo35NAclOUuHe7xmu+CbsOxwJo2VXGFj/PkBW0efFTy7kRssKEBu
        645R+k0FESnUWvSYFE3y2GQ=
X-Google-Smtp-Source: AA6agR5W5yPSqIp9Ihl9JRxboxZBEiQ4B1dGEJ7js6ypI9pKF0QbEgpwOMV8Q0YnFVrN+eA4XmYEbQ==
X-Received: by 2002:aa7:88d1:0:b0:52f:8fb8:5ec6 with SMTP id k17-20020aa788d1000000b0052f8fb85ec6mr10255695pff.34.1660954032019;
        Fri, 19 Aug 2022 17:07:12 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902ead200b0016a6caacaefsm3682708pld.103.2022.08.19.17.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 17:07:11 -0700 (PDT)
Message-ID: <12b231ea-dc7d-bb09-3986-32a07a63acd4@acm.org>
Date:   Fri, 19 Aug 2022 17:07:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2] driver core: Fix bus_type.match() error handling
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Isaac Manjarres <isaacmanjarres@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Saravana Kannan <saravanak@google.com>, stable@kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org
References: <YvsoYzIhOtX9DOi2@google.com>
 <20220816111311.GC1108868@roeck-us.net> <YvvQOBk9T3J1uX8k@google.com>
 <20220817010559.GA1880847@roeck-us.net> <YvxAfiSOrzy7/c1J@google.com>
 <20220818225932.GA3433999@roeck-us.net> <Yv7bd6Yl8+thp2CY@google.com>
 <20220819112832.GA3106213@roeck-us.net> <Yv/MKymRC9O04Nqu@google.com>
 <baa1f65a-d983-0518-3979-7099679995f2@acm.org>
 <20220819220841.GA3230067@roeck-us.net>
Content-Language: en-US
In-Reply-To: <20220819220841.GA3230067@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/22 15:08, Guenter Roeck wrote:
> On Fri, Aug 19, 2022 at 01:01:29PM -0700, Bart Van Assche wrote:
>> Since the issue has been observed in qemu, how about sharing the sysrq-t
>> output? I recommend to collect that output as follows:
>> * Send the serial console output to a file. This involves adding
>> console=ttyS0,115200n8 to the kernel command line and using the proper qemu
>> options to save the serial console output into a file.
>> * Reproduce the hang and send the sysrq-t key sequence to qemu, e.g. as
>> follows: virsh send-key ${vm_name} KEY_LEFTALT KEY_SYSRQ KEY_T
>>
> Unless I am missing something, this requires a virtio keyboard.
> So far I have been unable to get this to work with qemu arm emulations.

That's unfortunate. Is there another way to collect call traces after
the lockup has happened? Is it sufficient to enable the serial console
and to monitor the serial console output? Is CONFIG_SOFTLOCKUP_DETECTOR=y
sufficient? If not, how about converting the new wait calls in the SCSI
code, e.g. as shown in the (totally untested) patch below?

Thanks,

Bart.


diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index 6c63672971f1..edd238384f1d 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -35,6 +35,7 @@
  #include <linux/platform_device.h>
  #include <linux/pm_runtime.h>
  #include <linux/idr.h>
+#include <linux/sched/debug.h>
  #include <scsi/scsi_device.h>
  #include <scsi/scsi_host.h>
  #include <scsi/scsi_transport.h>
@@ -196,7 +197,11 @@ void scsi_remove_host(struct Scsi_Host *shost)
  	 * unloaded and/or the host resources can be released. Hence wait until
  	 * the dependent SCSI targets and devices are gone before returning.
  	 */
-	wait_event(shost->targets_wq, atomic_read(&shost->target_count) == 0);
+	while (wait_event_timeout(shost->targets_wq,
+			atomic_read(&shost->target_count) == 0, 60 * HZ) <= 0) {
+		show_state();
+		show_all_workqueues();
+	}

  	scsi_mq_destroy_tags(shost);
  }
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 213ebc88f76a..1c17b6c53ab0 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -14,6 +14,7 @@
  #include <linux/device.h>
  #include <linux/pm_runtime.h>
  #include <linux/bsg.h>
+#include <linux/sched/debug.h>

  #include <scsi/scsi.h>
  #include <scsi/scsi_device.h>
@@ -1536,7 +1537,11 @@ static void __scsi_remove_target(struct scsi_target *starget)
  	 * devices associated with @starget have been removed to prevent that
  	 * a SCSI error handling callback function triggers a use-after-free.
  	 */
-	wait_event(starget->sdev_wq, atomic_read(&starget->sdev_count) == 0);
+	while (wait_event_timeout(starget->sdev_wq,
+			atomic_read(&starget->sdev_count) == 0, 60 * HZ) <= 0) {
+		show_state();
+		show_all_workqueues();
+	}
  }

  /**
