Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A72D523654
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236636AbiEKO5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235418AbiEKO5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:57:05 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA02A67D3D;
        Wed, 11 May 2022 07:57:03 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-edf9ddb312so3096601fac.8;
        Wed, 11 May 2022 07:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FXhU4C+XFzjEf7MapqS6QgArPbwtn+GG7z2RycgMf0k=;
        b=UjzzQfUO58qjnFjN+MdwmL5YRrb+nD0gqEAn4zFAYvz21P+a4sGW+98mT7AZMgp/lM
         zpdZi5GWLDTJyJf+QBDM5uvNkT2b3AB5pLRXMPungGgwizNHOpulia2UtmTxOr8goQ8E
         p6/W9KZ1nT4dXdw8vw8Z8NBkn48Jq0khdTQuLLtNwb77aV+OJyDM2N2juzY5H2D7eoZr
         5bVcsux9/kp6V9T4EfqrDvmR1+bb8oVQnMsYy8qXajLYPEp7iV4so5ATp5HxY06f62H/
         TH7baXxeC+WXIJRknSUXU9L4xCAALjHKRufSjmRgIy+eAbKZaNy7vkGxydPO4nkHr7Vg
         lk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=FXhU4C+XFzjEf7MapqS6QgArPbwtn+GG7z2RycgMf0k=;
        b=aPW1ZuKDKX3A2Gjv/HRfqeshbXNUZ05FzYueYd7NpBkdbpPdrceurk6QIfWwegvKOa
         g/XffWceHbwsky3CcV0+HzPjz8BYLedQbxvlhboiFH73CwsShJkfWxJ5O3R3Q3LOVhKf
         OL7db3MO16pLGavvOM7CXswii4movZXF5jiEUOK03+N4gidYsOOZ4oT8ho3AHrGWZWB8
         hEtiZjJRrE4H39VF41PFhmFOF5W0mIGPi+1A6dsKIzw/rxErvsqwGqdVb+hJE5AY1BRC
         T3j9eOdiaqNGYupm6vxdFSYaR7FjFh5+iwK/l76mhDvuZCEzgj94ZJFd+id8h3Xyma2n
         ja0g==
X-Gm-Message-State: AOAM531XwXh9abxUxZ7GNTgnbuPgytvw0eKS2PoVU3eXRi1FbQgZ8mzp
        ZHNpvLoTn15ohFu5PzuAaJhPP/TzOQHC2g==
X-Google-Smtp-Source: ABdhPJzUqipn5lG6D+WbLJ8OGfyF8kehzF1R6MRpEJUeoyqU60+Ufdlk0gA3xjOoQhMmWF0ieGuJ1A==
X-Received: by 2002:a05:6871:80e:b0:ed:895a:ae92 with SMTP id q14-20020a056871080e00b000ed895aae92mr2745692oap.187.1652281022748;
        Wed, 11 May 2022 07:57:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g10-20020a056870d20a00b000e9364288bfsm619083oac.45.2022.05.11.07.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:57:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Zhi Li <lizhi01@loongson.cn>
Subject: [PATCH] MIPS: Loongson: Use hwmon_device_register_with_groups() to register hwmon
Date:   Wed, 11 May 2022 07:56:59 -0700
Message-Id: <20220511145659.2976950-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling hwmon_device_register_with_info() with NULL dev and/or chip
information parameters is an ABI abuse and not a real conversion to
the new API. Also, the code creates sysfs attributes _after_ creating
the hwmon device, which is racy and unsupported to start with. On top
of that, the removal code tries to remove the name attribute which is
owned by the hwmon core.

Use hwmon_device_register_with_groups() to register the hwmon device
instead.

In the future, the hwmon subsystem will reject calls to
hwmon_device_register_with_info with NULL dev or chip/info parameters.
Without this patch, the hwmon device will fail to register.

Fixes: f59dc5119192 ("MIPS: Loongson: Fix boot warning about hwmon_device_register()")
Cc: Zhi Li <lizhi01@loongson.cn>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/platform/mips/cpu_hwmon.c | 127 ++++++++++--------------------
 1 file changed, 41 insertions(+), 86 deletions(-)

diff --git a/drivers/platform/mips/cpu_hwmon.c b/drivers/platform/mips/cpu_hwmon.c
index 386389ffec41..d8c5f9195f85 100644
--- a/drivers/platform/mips/cpu_hwmon.c
+++ b/drivers/platform/mips/cpu_hwmon.c
@@ -55,55 +55,6 @@ int loongson3_cpu_temp(int cpu)
 static int nr_packages;
 static struct device *cpu_hwmon_dev;
 
-static SENSOR_DEVICE_ATTR(name, 0444, NULL, NULL, 0);
-
-static struct attribute *cpu_hwmon_attributes[] = {
-	&sensor_dev_attr_name.dev_attr.attr,
-	NULL
-};
-
-/* Hwmon device attribute group */
-static struct attribute_group cpu_hwmon_attribute_group = {
-	.attrs = cpu_hwmon_attributes,
-};
-
-static ssize_t get_cpu_temp(struct device *dev,
-			struct device_attribute *attr, char *buf);
-static ssize_t cpu_temp_label(struct device *dev,
-			struct device_attribute *attr, char *buf);
-
-static SENSOR_DEVICE_ATTR(temp1_input, 0444, get_cpu_temp, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp1_label, 0444, cpu_temp_label, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp2_input, 0444, get_cpu_temp, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp2_label, 0444, cpu_temp_label, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp3_input, 0444, get_cpu_temp, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp3_label, 0444, cpu_temp_label, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp4_input, 0444, get_cpu_temp, NULL, 4);
-static SENSOR_DEVICE_ATTR(temp4_label, 0444, cpu_temp_label, NULL, 4);
-
-static const struct attribute *hwmon_cputemp[4][3] = {
-	{
-		&sensor_dev_attr_temp1_input.dev_attr.attr,
-		&sensor_dev_attr_temp1_label.dev_attr.attr,
-		NULL
-	},
-	{
-		&sensor_dev_attr_temp2_input.dev_attr.attr,
-		&sensor_dev_attr_temp2_label.dev_attr.attr,
-		NULL
-	},
-	{
-		&sensor_dev_attr_temp3_input.dev_attr.attr,
-		&sensor_dev_attr_temp3_label.dev_attr.attr,
-		NULL
-	},
-	{
-		&sensor_dev_attr_temp4_input.dev_attr.attr,
-		&sensor_dev_attr_temp4_label.dev_attr.attr,
-		NULL
-	}
-};
-
 static ssize_t cpu_temp_label(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
@@ -121,24 +72,47 @@ static ssize_t get_cpu_temp(struct device *dev,
 	return sprintf(buf, "%d\n", value);
 }
 
-static int create_sysfs_cputemp_files(struct kobject *kobj)
-{
-	int i, ret = 0;
-
-	for (i = 0; i < nr_packages; i++)
-		ret = sysfs_create_files(kobj, hwmon_cputemp[i]);
+static SENSOR_DEVICE_ATTR(temp1_input, 0444, get_cpu_temp, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp1_label, 0444, cpu_temp_label, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp2_input, 0444, get_cpu_temp, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp2_label, 0444, cpu_temp_label, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp3_input, 0444, get_cpu_temp, NULL, 3);
+static SENSOR_DEVICE_ATTR(temp3_label, 0444, cpu_temp_label, NULL, 3);
+static SENSOR_DEVICE_ATTR(temp4_input, 0444, get_cpu_temp, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp4_label, 0444, cpu_temp_label, NULL, 4);
 
-	return ret;
-}
+static struct attribute *cpu_hwmon_attributes[] = {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_label.dev_attr.attr,
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_label.dev_attr.attr,
+	&sensor_dev_attr_temp3_input.dev_attr.attr,
+	&sensor_dev_attr_temp3_label.dev_attr.attr,
+	&sensor_dev_attr_temp4_input.dev_attr.attr,
+	&sensor_dev_attr_temp4_label.dev_attr.attr,
+	NULL
+};
 
-static void remove_sysfs_cputemp_files(struct kobject *kobj)
+static umode_t cpu_hwmon_is_visible(struct kobject *kobj,
+				    struct attribute *attr, int i)
 {
-	int i;
+	int id = i / 2;
 
-	for (i = 0; i < nr_packages; i++)
-		sysfs_remove_files(kobj, hwmon_cputemp[i]);
+	if (id < nr_packages)
+		return attr->mode;
+	return 0;
 }
 
+static struct attribute_group cpu_hwmon_group = {
+	.attrs = cpu_hwmon_attributes,
+	.is_visible = cpu_hwmon_is_visible,
+};
+
+static const struct attribute_group *cpu_hwmon_groups[] = {
+	&cpu_hwmon_group,
+	NULL
+};
+
 #define CPU_THERMAL_THRESHOLD 90000
 static struct delayed_work thermal_work;
 
@@ -159,50 +133,31 @@ static void do_thermal_timer(struct work_struct *work)
 
 static int __init loongson_hwmon_init(void)
 {
-	int ret;
-
 	pr_info("Loongson Hwmon Enter...\n");
 
 	if (cpu_has_csr())
 		csr_temp_enable = csr_readl(LOONGSON_CSR_FEATURES) &
 				  LOONGSON_CSRF_TEMP;
 
-	cpu_hwmon_dev = hwmon_device_register_with_info(NULL, "cpu_hwmon", NULL, NULL, NULL);
-	if (IS_ERR(cpu_hwmon_dev)) {
-		ret = PTR_ERR(cpu_hwmon_dev);
-		pr_err("hwmon_device_register fail!\n");
-		goto fail_hwmon_device_register;
-	}
-
 	nr_packages = loongson_sysconf.nr_cpus /
 		loongson_sysconf.cores_per_package;
 
-	ret = create_sysfs_cputemp_files(&cpu_hwmon_dev->kobj);
-	if (ret) {
-		pr_err("fail to create cpu temperature interface!\n");
-		goto fail_create_sysfs_cputemp_files;
+	cpu_hwmon_dev = hwmon_device_register_with_groups(NULL, "cpu_hwmon",
+							  NULL, cpu_hwmon_groups);
+	if (IS_ERR(cpu_hwmon_dev)) {
+		pr_err("hwmon_device_register fail!\n");
+		return PTR_ERR(cpu_hwmon_dev);
 	}
 
 	INIT_DEFERRABLE_WORK(&thermal_work, do_thermal_timer);
 	schedule_delayed_work(&thermal_work, msecs_to_jiffies(20000));
 
-	return ret;
-
-fail_create_sysfs_cputemp_files:
-	sysfs_remove_group(&cpu_hwmon_dev->kobj,
-				&cpu_hwmon_attribute_group);
-	hwmon_device_unregister(cpu_hwmon_dev);
-
-fail_hwmon_device_register:
-	return ret;
+	return 0;
 }
 
 static void __exit loongson_hwmon_exit(void)
 {
 	cancel_delayed_work_sync(&thermal_work);
-	remove_sysfs_cputemp_files(&cpu_hwmon_dev->kobj);
-	sysfs_remove_group(&cpu_hwmon_dev->kobj,
-				&cpu_hwmon_attribute_group);
 	hwmon_device_unregister(cpu_hwmon_dev);
 }
 
-- 
2.35.1

