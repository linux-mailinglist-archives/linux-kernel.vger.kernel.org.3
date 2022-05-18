Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7499152C3AC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 21:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242116AbiERTqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 15:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242102AbiERTqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 15:46:07 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D743DDE7
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 12:46:02 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h14so4101511wrc.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 12:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8ODKmCKf5lDkdRcNfgffFFETbXdXKUL8UVzkV2BGiaA=;
        b=FQDAH9eD/4pa95U6VnV/VCQ93dQa52p5soSL5J+4rv1xFZYDYmngjuni56TupbZyfk
         bbB0B/5BhtHkx+XIEYyTh2QyuHAJTxgHOcJ829oAJsirUfC7vsLtV/RsL0ddu+MRQSo8
         Afm/V2Hh4wMLcX8DJDIp3hfG2o1zzQgIl/MKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8ODKmCKf5lDkdRcNfgffFFETbXdXKUL8UVzkV2BGiaA=;
        b=TTf+k1y+8MxKwoNK/3+fD4QCLvEoubde3Wx3TqTTmSGLwhiaBvy3XEhTMMmkqLVBfX
         Zp48Gz6reG9bmvzCZylL5bSU6P4FM9JSn5Z24jRwfbqYQbIe/5ARYKsmz00WxcEh6Nzw
         JlJicabeg4qBidz31JjdU99ufmNXehLdKT2kpQAtooK/MMiYi495vhQNTQRZ2FmAX/xv
         lF7ttmJUBaqI5auoIaXJOm2RkrhTplXqmZUWCsT+ALoMHrxD2TXncCTWbs42+GzdyTU/
         fjnezEH9NCHiheE+tsZ94dMS8i7TDiDoyitsH6C/WUemo+L0IMv5UeOsHXsU5CChwlzV
         080Q==
X-Gm-Message-State: AOAM531pNxAe32Vpq5xOEjJkw2yNIpShcesHxJyJugpwJljf4alyIGMK
        0PbwnS9oUfevZku1PknrUpfWfw==
X-Google-Smtp-Source: ABdhPJw6C9f+JVUT9pvieU1zCIbaDc1e/tYZ2AEXNX1M37TEU1WLUf3CZgmbNFfcklNjl5dusV3SOw==
X-Received: by 2002:adf:ed8a:0:b0:20c:fe1d:d9e3 with SMTP id c10-20020adfed8a000000b0020cfe1dd9e3mr1069976wro.546.1652903161391;
        Wed, 18 May 2022 12:46:01 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::4:c43c])
        by smtp.gmail.com with ESMTPSA id a12-20020a056000188c00b0020c5253d8ddsm3180843wri.41.2022.05.18.12.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 12:46:00 -0700 (PDT)
Date:   Wed, 18 May 2022 20:46:00 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        kernel-team@fb.com
Subject: Re: [RFC PATCH] printk: console: Allow each console to have its own
 loglevel
Message-ID: <YoVM+KbdyJm8RSSr@chrisdown.name>
References: <YoUBh5BSsURDO71Z@chrisdown.name>
 <YoUR6RlzkCNG7BU0@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YoUR6RlzkCNG7BU0@kroah.com>
User-Agent: Mutt/2.2.4 (c3baa83e) (2022-04-30)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman writes:
>>  .../admin-guide/kernel-parameters.txt         |  18 +-
>>  .../admin-guide/per-console-loglevel.rst      | 116 ++++++
>
>All sysfs attributes need to be documented in Documentation/ABI/ so that
>the automated tools can properly pick them up and check them.  Please
>don't bury them in some other random Documentation file.

Ack.

>> +static ssize_t loglevel_show(struct device *dev, struct device_attribute *attr,
>> +			     char *buf)
>> +{
>> +	struct console *con = container_of(dev, struct console, classdev);
>> +
>> +	if (con->flags & CON_LOGLEVEL)
>> +		return sprintf(buf, "%d\n", con->level);
>> +	else
>> +		return sprintf(buf, "unset\n");
>
>sysfs_emit() is your friend, always use it please.  For all of the sysfs
>attributes.

Ack.

>> +static struct attribute *console_sysfs_attrs[] = {
>> +	&dev_attr_loglevel.attr,
>> +	&dev_attr_effective_loglevel_source.attr,
>> +	&dev_attr_effective_loglevel.attr,
>> +	&dev_attr_enabled.attr,
>> +	NULL,
>> +};
>> +
>> +ATTRIBUTE_GROUPS(console_sysfs);
>
>Thanks for using an attribute group properly, that's nice to see.

Hah, I have no idea what I'm doing with the device model in general, but at 
least I vaguely know how to keep the code tidy ;-)

>> +static void console_classdev_release(struct device *dev)
>> +{
>> +	struct console *con = container_of(dev, struct console, classdev);
>> +
>> +	/*
>> +	 * `struct console' objects are statically allocated (or at the very
>> +	 * least managed outside of our lifecycle), nothing to do. Just set a
>> +	 * flag so that we know we are no longer waiting for anyone and can
>> +	 * return control in unregister_console().
>> +	 */
>> +	con->flags &= ~CON_CLASSDEV_ACTIVE;
>> +}
>
>The old documentation rules said I could complain about this a lot, so
>I'll be nice here just say "this is not ok at all."  You have a dynamic
>object, properly free the memory here please.  class objects can NOT be
>static, sorry.  If you are doing that here, it is really wrong and
>broken and will cause problems when you try to remove the device from
>the system.

Let me check I understand you correctly. The class is:

     static struct class *console_class;
     [...]
     console_class = class_create(THIS_MODULE, "console");

Which exists within printk.c. This class exists to contain all consoles which 
present themselves over the lifetime of the kernel.

console_classdev_release is the release for a single console's "classdev" 
object, rather than the release of the class itself.

If you're talking about properly freeing the memory, I suppose it should happen 
by doing something like the following in unregister_console():

     if (!console_drivers)
         /* free the class object under console lock */

...right? Let me know if I'm misunderstanding you.

Any suggestions you have here are more than welcome, I'm definitely not that 
familiar with the device/class API.

>> +static void console_register_device(struct console *new)
>> +{
>> +	/*
>> +	 * We might be called from register_console() before the class is
>> +	 * registered. If that happens, we'll take care of it in
>> +	 * printk_late_init.
>
>If so, is the device properly registered there as well?  I missed that
>logic...

We call console_register_device() on all previously known consoles at 
late_initcall() time. Or were you thinking of something else?

>> +	 */
>> +	if (IS_ERR_OR_NULL(console_class))
>> +		return;
>> +
>> +	new->flags |= CON_CLASSDEV_ACTIVE;
>> +	device_initialize(&new->classdev);
>> +	dev_set_name(&new->classdev, "%s", new->name);
>> +	new->classdev.release = console_classdev_release;
>> +	new->classdev.class = console_class;
>> +	if (WARN_ON(device_add(&new->classdev)))
>
>What is with these random WARN_ON() stuff?  Don't do that, just handle
>the error and move on properly.  Systems with panic_on_warn() should not
>fail from stuff like this, that's rude to cause them to reboot.

Oh, that's fair enough, I hadn't thought of that. Ack.

>> +	console_class = class_create(THIS_MODULE, "console");
>> +	if (!WARN_ON(IS_ERR(console_class)))
>> +		console_class->dev_groups = console_sysfs_groups;
>
>Do you ever free the class?

Currently no. What do you think about the above proposal to do it once the 
console driver list is exhausted?

>> +static int printk_sysctl_deprecated(struct ctl_table *table, int write,
>> +				    void __user *buffer, size_t *lenp,
>> +				    loff_t *ppos)
>> +{
>> +	int res = proc_dointvec(table, write, buffer, lenp, ppos);
>> +
>> +	if (write)
>> +		pr_warn_ratelimited(
>> +			"printk: The kernel.printk sysctl is deprecated and will be removed soon. Use kernel.force_console_loglevel, kernel.default_message_loglevel, kernel.minimum_console_loglevel, or kernel.default_console_loglevel instead.\n"
>
>Please define "soon".

Petr, what do you think about the timebounds here? :-)

Thanks for the feedback!

Chris
