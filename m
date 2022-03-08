Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD2C4D1A10
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 15:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347334AbiCHOKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 09:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347265AbiCHOKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:10:42 -0500
Received: from smtpbg501.qq.com (smtpbg501.qq.com [203.205.250.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936524A934
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 06:09:42 -0800 (PST)
X-QQ-mid: bizesmtp74t1646748569t5nb50an
Received: from localhost.localdomain ( [114.222.120.105])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 08 Mar 2022 22:09:21 +0800 (CST)
X-QQ-SSF: 01400000002000C0I000B00A0000000
X-QQ-FEAT: F3yR32iATbg+EdrRUASNaYTjN8Fx5nq9CL4BgiZlUFzbj90vxvzlmo8kQShzO
        UCD3VbiQjkSYg1JlOpFZlhXczC9nsoxOapqdJqf6LBZOTIXxhLDpUGmkmf9CsZE2Mbh8ic9
        qxfLptq277x8HUMF+os3EO9i54VtNf/CEkcmy3Dd4xYmHsLmfXVhIm2kWYRV5wPuuG/Qi9X
        Fxfjm8g80GmCpJ5tXsqB+K2INCRZgtkIcd7uhIgzC4qm2jdbh9x6/enD/EVPH2BwvFi5ymO
        kGiTG3AWObqGoZKE3y0IVduJQBrDVeIIbrhYihceo/ITGQP70smbIFcHyMMtd1NJ8hVIM9e
        sCgbPDuFk4vCXm2SUy83o1ngEC+mjCyRMu4FdnS
X-QQ-GoodBg: 2
From:   Lianjie Zhang <zhanglianjie@uniontech.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        zhanglianjie <zhanglianjie@uniontech.com>
Subject: [PATCH v2 1/2] cpufreq: unify the show() and store() styles of attr
Date:   Tue,  8 Mar 2022 22:09:17 +0800
Message-Id: <20220308140917.56923-1-zhanglianjie@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhanglianjie <zhanglianjie@uniontech.com>

Usually /sys directory under the file, the corresponding Attribute
contains .show and .store, and their naming style is filename_show() and
filename_store(). But all naming style in 'cpufreq' is show_filename()
and store_filename(), resulting in __ATTR_RW() and __ATTR_RO() macros
cannot be used to simplify code, So need to change naming style.

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 08515f7e515f..b6bd0ff35323 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -146,7 +146,7 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)

 /************************** sysfs interface ************************/

-static ssize_t store_sampling_down_factor(struct gov_attr_set *attr_set,
+static ssize_t sampling_down_factor_store(struct gov_attr_set *attr_set,
 					  const char *buf, size_t count)
 {
 	struct dbs_data *dbs_data = to_dbs_data(attr_set);
@@ -161,7 +161,7 @@ static ssize_t store_sampling_down_factor(struct gov_attr_set *attr_set,
 	return count;
 }

-static ssize_t store_up_threshold(struct gov_attr_set *attr_set,
+static ssize_t up_threshold_store(struct gov_attr_set *attr_set,
 				  const char *buf, size_t count)
 {
 	struct dbs_data *dbs_data = to_dbs_data(attr_set);
@@ -177,7 +177,7 @@ static ssize_t store_up_threshold(struct gov_attr_set *attr_set,
 	return count;
 }

-static ssize_t store_down_threshold(struct gov_attr_set *attr_set,
+static ssize_t down_threshold_store(struct gov_attr_set *attr_set,
 				    const char *buf, size_t count)
 {
 	struct dbs_data *dbs_data = to_dbs_data(attr_set);
@@ -195,7 +195,7 @@ static ssize_t store_down_threshold(struct gov_attr_set *attr_set,
 	return count;
 }

-static ssize_t store_ignore_nice_load(struct gov_attr_set *attr_set,
+static ssize_t ignore_nice_load_store(struct gov_attr_set *attr_set,
 				      const char *buf, size_t count)
 {
 	struct dbs_data *dbs_data = to_dbs_data(attr_set);
@@ -220,7 +220,7 @@ static ssize_t store_ignore_nice_load(struct gov_attr_set *attr_set,
 	return count;
 }

-static ssize_t store_freq_step(struct gov_attr_set *attr_set, const char *buf,
+static ssize_t freq_step_store(struct gov_attr_set *attr_set, const char *buf,
 			       size_t count)
 {
 	struct dbs_data *dbs_data = to_dbs_data(attr_set);
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 63f7c219062b..0d42cf8b88d8 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -27,7 +27,7 @@ static DEFINE_MUTEX(gov_dbs_data_mutex);

 /* Common sysfs tunables */
 /*
- * store_sampling_rate - update sampling rate effective immediately if needed.
+ * sampling_rate_store - update sampling rate effective immediately if needed.
  *
  * If new rate is smaller than the old, simply updating
  * dbs.sampling_rate might not be appropriate. For example, if the
@@ -41,7 +41,7 @@ static DEFINE_MUTEX(gov_dbs_data_mutex);
  * This must be called with dbs_data->mutex held, otherwise traversing
  * policy_dbs_list isn't safe.
  */
-ssize_t store_sampling_rate(struct gov_attr_set *attr_set, const char *buf,
+ssize_t sampling_rate_store(struct gov_attr_set *attr_set, const char *buf,
 			    size_t count)
 {
 	struct dbs_data *dbs_data = to_dbs_data(attr_set);
@@ -80,7 +80,7 @@ ssize_t store_sampling_rate(struct gov_attr_set *attr_set, const char *buf,

 	return count;
 }
-EXPORT_SYMBOL_GPL(store_sampling_rate);
+EXPORT_SYMBOL_GPL(sampling_rate_store);

 /**
  * gov_update_cpu_data - Update CPU load data.
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index bab8e6140377..65ecf32ba4f8 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -51,7 +51,7 @@ static inline struct dbs_data *to_dbs_data(struct gov_attr_set *attr_set)
 }

 #define gov_show_one(_gov, file_name)					\
-static ssize_t show_##file_name						\
+static ssize_t file_name##_show						\
 (struct gov_attr_set *attr_set, char *buf)				\
 {									\
 	struct dbs_data *dbs_data = to_dbs_data(attr_set);		\
@@ -60,7 +60,7 @@ static ssize_t show_##file_name						\
 }

 #define gov_show_one_common(file_name)					\
-static ssize_t show_##file_name						\
+static ssize_t file_name##_show						\
 (struct gov_attr_set *attr_set, char *buf)				\
 {									\
 	struct dbs_data *dbs_data = to_dbs_data(attr_set);		\
@@ -69,11 +69,11 @@ static ssize_t show_##file_name						\

 #define gov_attr_ro(_name)						\
 static struct governor_attr _name =					\
-__ATTR(_name, 0444, show_##_name, NULL)
+__ATTR(_name, 0444, _name##_show, NULL)

 #define gov_attr_rw(_name)						\
 static struct governor_attr _name =					\
-__ATTR(_name, 0644, show_##_name, store_##_name)
+__ATTR(_name, 0644, _name##_show, _name##_store)

 /* Common to all CPUs of a policy */
 struct policy_dbs_info {
@@ -176,7 +176,7 @@ void od_register_powersave_bias_handler(unsigned int (*f)
 		(struct cpufreq_policy *, unsigned int, unsigned int),
 		unsigned int powersave_bias);
 void od_unregister_powersave_bias_handler(void);
-ssize_t store_sampling_rate(struct gov_attr_set *attr_set, const char *buf,
+ssize_t sampling_rate_store(struct gov_attr_set *attr_set, const char *buf,
 			    size_t count);
 void gov_update_cpu_data(struct dbs_data *dbs_data);
 #endif /* _CPUFREQ_GOVERNOR_H */
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 6a41ea4729b8..e8fbf970ff07 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -202,7 +202,7 @@ static unsigned int od_dbs_update(struct cpufreq_policy *policy)
 /************************** sysfs interface ************************/
 static struct dbs_governor od_dbs_gov;

-static ssize_t store_io_is_busy(struct gov_attr_set *attr_set, const char *buf,
+static ssize_t io_is_busy_store(struct gov_attr_set *attr_set, const char *buf,
 				size_t count)
 {
 	struct dbs_data *dbs_data = to_dbs_data(attr_set);
@@ -220,7 +220,7 @@ static ssize_t store_io_is_busy(struct gov_attr_set *attr_set, const char *buf,
 	return count;
 }

-static ssize_t store_up_threshold(struct gov_attr_set *attr_set,
+static ssize_t up_threshold_store(struct gov_attr_set *attr_set,
 				  const char *buf, size_t count)
 {
 	struct dbs_data *dbs_data = to_dbs_data(attr_set);
@@ -237,7 +237,7 @@ static ssize_t store_up_threshold(struct gov_attr_set *attr_set,
 	return count;
 }

-static ssize_t store_sampling_down_factor(struct gov_attr_set *attr_set,
+static ssize_t sampling_down_factor_store(struct gov_attr_set *attr_set,
 					  const char *buf, size_t count)
 {
 	struct dbs_data *dbs_data = to_dbs_data(attr_set);
@@ -265,7 +265,7 @@ static ssize_t store_sampling_down_factor(struct gov_attr_set *attr_set,
 	return count;
 }

-static ssize_t store_ignore_nice_load(struct gov_attr_set *attr_set,
+static ssize_t ignore_nice_load_store(struct gov_attr_set *attr_set,
 				      const char *buf, size_t count)
 {
 	struct dbs_data *dbs_data = to_dbs_data(attr_set);
@@ -290,7 +290,7 @@ static ssize_t store_ignore_nice_load(struct gov_attr_set *attr_set,
 	return count;
 }

-static ssize_t store_powersave_bias(struct gov_attr_set *attr_set,
+static ssize_t powersave_bias_store(struct gov_attr_set *attr_set,
 				    const char *buf, size_t count)
 {
 	struct dbs_data *dbs_data = to_dbs_data(attr_set);
--
2.20.1



