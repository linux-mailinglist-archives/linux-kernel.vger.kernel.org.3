Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AA452D5AD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 16:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239499AbiESOM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 10:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237653AbiESOMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 10:12:24 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F090068F87
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 07:12:22 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k26so2964999wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 07:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ROPpcqzZ+wbpikH+zQrJE2dZafVpNpo05XWzrl/dvkM=;
        b=TzMFsqs8ALxvTz0lEA0hrcojwpxFcHiLmJp7NdF0cfr0gu+GG38bm3hvBfqxX08/09
         IAkpGB4mLS0FlQgiLwHEMlgVyfeUpYBNZ6DjaZzNR7oE1AqX84oBA0Mvy8chSVUIyNR2
         bQw5tPHWnBaGAL5mQETWVpdfyEXpbAGdMa/vk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ROPpcqzZ+wbpikH+zQrJE2dZafVpNpo05XWzrl/dvkM=;
        b=1kq2jzOUzvJxNiJQ+OesSZHCKajAQSi4LXnNIqxkE+VRqAePPbCm+zs78jVWf0OlpB
         y1lg7fmAX8tK745PSrt+6DOQ2Vx2h39nMGuVUuvzPbjJ7PScMF1+mjp6VtMsm6zVa2y4
         CpQ9oFOpaNjx+FS8B212P/ga8dzvB29igIJtdi/KADMg6FFdnxVpTmKJOU0Alm7/nisX
         ljCWXa6R/YYAZdbVrg+4dKFjIg8S3qOjX3I709GCfXuzrqINU15ccauASUZXwGzUVZ3W
         7ZDaiYzRks4sk0KkxJMNv+9FHm2axxAVNF1Y+eJLBheDQD7i+HSbp07qW0msUXZbkYBh
         kbbA==
X-Gm-Message-State: AOAM532Rn6NvXMzfAZOs1R6Boje0C01iKsj+GO620UETuqBLFC56vAaU
        XfyBK3Sb/25641w9WnheOVrDSQ==
X-Google-Smtp-Source: ABdhPJzbcvpd+ia98WCbaZKkOKlxD4WRDf5oVGloh6sLjpXgH6gueshLSbgPkN0BctWeqIAjY3VYbQ==
X-Received: by 2002:a05:600c:4e48:b0:397:5e5:6c25 with SMTP id e8-20020a05600c4e4800b0039705e56c25mr4481090wmq.24.1652969541436;
        Thu, 19 May 2022 07:12:21 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::4:c1eb])
        by smtp.gmail.com with ESMTPSA id v18-20020a05600c215200b00394586f696dsm6876795wml.11.2022.05.19.07.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 07:12:20 -0700 (PDT)
Date:   Thu, 19 May 2022 15:12:19 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        kernel-team@fb.com
Subject: Re: [RFC PATCH] printk: console: Allow each console to have its own
 loglevel
Message-ID: <YoZQQwtG12Ypr2IC@chrisdown.name>
References: <YoUBh5BSsURDO71Z@chrisdown.name>
 <YoUR6RlzkCNG7BU0@kroah.com>
 <YoVM+KbdyJm8RSSr@chrisdown.name>
 <YoVO23+fvsNPnpKh@kroah.com>
 <YoVWpZKHD7aec0CJ@chrisdown.name>
 <YoXsAkUgzIjJR90W@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YoXsAkUgzIjJR90W@kroah.com>
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
>The two stanzas in my reply do NOT refer to the same thing.
>
>The first one is for the device that is assigned to the class.  That
>must be freed and properly reference counted and handled as that is a
>dynamic object that can come and go as people add and remove consoles.

Ah, I see. So to be clear, this change would fix what you're concerned about, 
right? :-)

If so I'll do this in v2. Thanks!

---

diff --git include/linux/console.h include/linux/console.h
index ce5ba405285a..408dd86be8eb 100644
--- include/linux/console.h
+++ include/linux/console.h
@@ -156,12 +156,6 @@ static inline int con_debug_leave(void)
   */
  #define CON_LOGLEVEL	(128) /* Level set locally for this console */
  
-/*
- * Console has active class device, so may have active readers/writers from
- * /sys/class hierarchy.
- */
-#define CON_CLASSDEV_ACTIVE	(256)
-
  struct console {
  	char	name[16];
  	void	(*write)(struct console *, const char *, unsigned);
@@ -179,9 +173,11 @@ struct console {
  	void	*data;
  	struct	 console *next;
  	int	level;
-	struct	device classdev;
+	struct	device *classdev;
  };
  
+#define classdev_to_console(dev) dev_get_drvdata(dev)
+
  /*
   * for_each_console() allows you to iterate on each console
   */
diff --git kernel/printk/printk.c kernel/printk/printk.c
index ee3328f7b6fb..a60bcf296c25 100644
--- kernel/printk/printk.c
+++ kernel/printk/printk.c
@@ -3076,7 +3076,7 @@ early_param("keep_bootcon", keep_bootcon_setup);
  static ssize_t loglevel_show(struct device *dev, struct device_attribute *attr,
  			     char *buf)
  {
-	struct console *con = container_of(dev, struct console, classdev);
+	struct console *con = classdev_to_console(dev);
  
  	if (con->flags & CON_LOGLEVEL)
  		return sprintf(buf, "%d\n", con->level);
@@ -3087,7 +3087,7 @@ static ssize_t loglevel_show(struct device *dev, struct device_attribute *attr,
  static ssize_t loglevel_store(struct device *dev, struct device_attribute *attr,
  			      const char *buf, size_t size)
  {
-	struct console *con = container_of(dev, struct console, classdev);
+	struct console *con = classdev_to_console(dev);
  	ssize_t ret;
  	int tmp;
  
@@ -3115,7 +3115,7 @@ static ssize_t effective_loglevel_source_show(struct device *dev,
  					      struct device_attribute *attr,
  					      char *buf)
  {
-	struct console *con = container_of(dev, struct console, classdev);
+	struct console *con = classdev_to_console(dev);
  	enum loglevel_source source;
  
  	console_effective_loglevel(con, &source);
@@ -3128,7 +3128,7 @@ static ssize_t effective_loglevel_show(struct device *dev,
  				       struct device_attribute *attr,
  				       char *buf)
  {
-	struct console *con = container_of(dev, struct console, classdev);
+	struct console *con = classdev_to_console(dev);
  	enum loglevel_source source;
  
  	return sprintf(buf, "%d\n", console_effective_loglevel(con, &source));
@@ -3139,7 +3139,7 @@ static DEVICE_ATTR_RO(effective_loglevel);
  static ssize_t enabled_show(struct device *dev, struct device_attribute *attr,
  			    char *buf)
  {
-	struct console *con = container_of(dev, struct console, classdev);
+	struct console *con = classdev_to_console(dev);
  
  	return sprintf(buf, "%d\n", !!(con->flags & CON_ENABLED));
  }
@@ -3158,15 +3158,7 @@ ATTRIBUTE_GROUPS(console_sysfs);
  
  static void console_classdev_release(struct device *dev)
  {
-	struct console *con = container_of(dev, struct console, classdev);
-
-	/*
-	 * `struct console' objects are statically allocated (or at the very
-	 * least managed outside of our lifecycle), nothing to do. Just set a
-	 * flag so that we know we are no longer waiting for anyone and can
-	 * return control in unregister_console().
-	 */
-	con->flags &= ~CON_CLASSDEV_ACTIVE;
+	kfree(dev);
  }
  
  static void console_register_device(struct console *new)
@@ -3179,13 +3171,17 @@ static void console_register_device(struct console *new)
  	if (IS_ERR_OR_NULL(console_class))
  		return;
  
-	new->flags |= CON_CLASSDEV_ACTIVE;
-	device_initialize(&new->classdev);
-	dev_set_name(&new->classdev, "%s", new->name);
-	new->classdev.release = console_classdev_release;
-	new->classdev.class = console_class;
-	if (WARN_ON(device_add(&new->classdev)))
-		put_device(&new->classdev);
+	new->classdev = kzalloc(sizeof(struct device), GFP_KERNEL);
+	if (!new->classdev)
+		return;
+
+	device_initialize(new->classdev);
+	dev_set_name(new->classdev, "%s", new->name);
+	dev_set_drvdata(new->classdev, new);
+	new->classdev->release = console_classdev_release;
+	new->classdev->class = console_class;
+	if (WARN_ON(device_add(new->classdev)))
+		put_device(new->classdev);
  }
  
  /*
@@ -3462,7 +3458,7 @@ int unregister_console(struct console *console)
  		console_drivers->flags |= CON_CONSDEV;
  
  	console->flags &= ~CON_ENABLED;
-	device_unregister(&console->classdev);
+	device_unregister(console->classdev);
  	console_unlock();
  	console_sysfs_notify();
  
@@ -3475,14 +3471,6 @@ int unregister_console(struct console *console)
  	console->flags &= ~CON_ENABLED;
  	console_unlock();
  
-	/*
-	 * Wait for anyone holding the classdev open to close it so that we
-	 * don't remove the module prematurely. Once classdev refcnt is 0,
-	 * CON_CLASSDEV_ACTIVE will be unset in console_classdev_release.
-	 */
-	while (console->flags & CON_CLASSDEV_ACTIVE)
-		schedule_timeout_uninterruptible(msecs_to_jiffies(1));
-
  	return res;
  }
  EXPORT_SYMBOL(unregister_console);
