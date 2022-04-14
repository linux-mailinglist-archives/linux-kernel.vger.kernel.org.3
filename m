Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DD4500D8A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243329AbiDNMdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236509AbiDNMdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:33:11 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11F0286FF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 05:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649939445; x=1681475445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xJ4+CeE8oXm5IbY+WmFWKrb4H4NnB56KjSz1Z/Y/oc4=;
  b=SXbOaqHcsPXcPm7JCKuzdPPzjnynguClvp9LjETwzRJ+K3mCGBC87+fw
   XUmC6+hbN0wUc2ZcvwinL1TINuS1ZRTIpZzX3jDQgNxXnhrKmkt9v66ju
   iWBQq0DSYVlHGgtufgYYgZhYHInPVVWFrL3W4nTDiiKS7yZsSRR6Ni1C7
   tRYyOOfltmC7BD3QnmHYqBO9woBrkVZxVypJvFUs/ELpUyBEvde+ybKFs
   Hikmdhiyu6qOkVVousnVnjnmUBom4R0DPECNYR9kkaYedBAEaBRgxP4OE
   tYRUyZ9hMYc4NQC1+DtXFxu4DfYnsPa++BnUI4aT77hG1WsEa3xssjNZs
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="325823635"
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="325823635"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 05:30:45 -0700
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="527379111"
Received: from nplaweck-mobl.ger.corp.intel.com (HELO localhost) ([10.249.149.236])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 05:30:42 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        jani.nikula@intel.com, Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 1/1] module: add enum module parameter type to map names to values
Date:   Thu, 14 Apr 2022 15:30:33 +0300
Message-Id: <20220414123033.654198-2-jani.nikula@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220414123033.654198-1-jani.nikula@intel.com>
References: <20220414123033.654198-1-jani.nikula@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add enum module parameter type that's internally an int and externally
maps names to values. This makes the userspace interface more intuitive
to use and somewhat easier to document, while also limiting the allowed
values set by userspace to the defined set.

For example, given this code to define a "mode" in a fictional module
"foobar":

	struct module_param_enumeration modes[] = {
		{ "foo", 0 },
		{ "bar", 1 },
		{ "baz", -1 },
	};

	int mode;

	module_param_enum(mode, modes, 0600);

You can probe foobar with "foobar.mode=bar" in the kernel or modprobe
command line to set the mode to 1.

Similarly, you can use the sysfs with the names:

	# echo baz > /sys/module/foobar/parameters/mode
	# cat /sys/module/foobar/parameters/mode
	baz

With checks:

	# echo nope > /sys/module/foobar/parameters/mode
	echo: write error: Invalid argument

Of course, the kernel can still internally set the mode variable
directly to a value that is not defined in the enumerations (obviously
to be avoided), which will result in unknown key:

	# cat /sys/module/foobar/parameters/mode
	(unknown)

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 include/linux/moduleparam.h | 64 +++++++++++++++++++++++++++++++++++++
 kernel/params.c             | 41 ++++++++++++++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 962cd41a2cb5..a11fb8f214e5 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -77,6 +77,7 @@ struct kernel_param {
 		void *arg;
 		const struct kparam_string *str;
 		const struct kparam_array *arr;
+		const struct kparam_enum *enumeration;
 	};
 };
 
@@ -98,6 +99,19 @@ struct kparam_array
 	void *elem;
 };
 
+/* Special ones for enums */
+struct module_param_enumeration {
+	const char *key;
+	int val;
+};
+
+struct kparam_enum
+{
+	const struct module_param_enumeration *enums;
+	unsigned int num_enums;
+	int *val;
+};
+
 /**
  * module_param - typesafe helper for a module/cmdline parameter
  * @name: the variable to alter, and exposed parameter name.
@@ -484,6 +498,11 @@ extern int param_set_bint(const char *val, const struct kernel_param *kp);
 #define param_get_bint param_get_int
 #define param_check_bint param_check_int
 
+/* An enumeration */
+extern const struct kernel_param_ops param_ops_enum;
+extern int param_set_enum(const char *key, const struct kernel_param *kp);
+extern int param_get_enum(char *buffer, const struct kernel_param *kp);
+
 /**
  * module_param_array - a parameter which is an array of some type
  * @name: the name of the array variable
@@ -523,6 +542,51 @@ extern int param_set_bint(const char *val, const struct kernel_param *kp);
 			    perm, -1, 0);				\
 	__MODULE_PARM_TYPE(name, "array of " #type)
 
+/**
+ * module_param_enum - a parameter which is an enumeration
+ * @name: the variable to alter, and exposed parameter name
+ * @enumerations: array of struct module_param_enumeration defining the enums
+ * @perm: visibility in sysfs
+ *
+ * The userspace input and output are based on the names defined in the
+ * @enumerations array, which maps the names to values stored in the int
+ * variable defined by @name.
+ *
+ * When initializing or changing the variable @name, ensure the value is defined
+ * in @enumerations. Otherwise, reading the parameter value via sysfs will
+ * output "(unknown)".
+ *
+ * ARRAY_SIZE(@enumerations) is used to determine the number of elements in the
+ * enumerations array, so the definition must be visible.
+ */
+
+#define module_param_enum(name, enumerations, perm)			\
+	module_param_enum_named(name, name, enumerations, perm)
+
+/**
+ * module_param_enum_named - a renamed parameter which is an enumeration
+ * @name: a valid C identifier which is the parameter name
+ * @value: the actual lvalue int variable to alter
+ * @enumerations: array of struct module_param_enumeration defining the enums
+ * @perm: visibility in sysfs
+ *
+ * This exposes a different name than the actual variable name.  See
+ * module_param_named() for why this might be necessary.
+ */
+#define module_param_enum_named(name, value, enumerations, perm)	\
+	param_check_int(name, &(value));				\
+	static const struct kparam_enum __param_arr_##name =		\
+	{								\
+		.enums = enumerations,					\
+		.num_enums = ARRAY_SIZE(enumerations),			\
+		.val = &value						\
+	};								\
+	__module_param_call(MODULE_PARAM_PREFIX, name,			\
+			    &param_ops_enum,				\
+			    .enumeration = &__param_arr_##name,		\
+			    perm, -1, 0);				\
+	__MODULE_PARM_TYPE(name, "enumeration")
+
 enum hwparam_type {
 	hwparam_ioport,		/* Module parameter configures an I/O port */
 	hwparam_iomem,		/* Module parameter configures an I/O mem address */
diff --git a/kernel/params.c b/kernel/params.c
index 5b92310425c5..749fe42b1a44 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -534,6 +534,47 @@ const struct kernel_param_ops param_ops_string = {
 };
 EXPORT_SYMBOL(param_ops_string);
 
+int param_set_enum(const char *key, const struct kernel_param *kp)
+{
+	const struct kparam_enum *e = kp->enumeration;
+	unsigned int i;
+
+	for (i = 0; i < e->num_enums; i++) {
+		if (sysfs_streq(key, e->enums[i].key)) {
+			*(e->val) = e->enums[i].val;
+			return 0;
+		}
+	}
+
+	pr_err("%s: unknown key %s to enum parameter\n", kp->name, key);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(param_set_enum);
+
+int param_get_enum(char *buffer, const struct kernel_param *kp)
+{
+	const struct kparam_enum *e = kp->enumeration;
+	unsigned int i;
+
+	for (i = 0; i < e->num_enums; i++) {
+		if (*(e->val) == e->enums[i].val)
+			return sysfs_emit(buffer, "%s\n", e->enums[i].key);
+	}
+
+	pr_err("%s: enum parameter set to unknown value %d\n",
+	       kp->name, *(e->val));
+
+	return sysfs_emit(buffer, "(unknown)\n");
+}
+EXPORT_SYMBOL(param_get_enum);
+
+const struct kernel_param_ops param_ops_enum = {
+	.set = param_set_enum,
+	.get = param_get_enum,
+};
+EXPORT_SYMBOL(param_ops_enum);
+
 /* sysfs output in /sys/modules/XYZ/parameters/ */
 #define to_module_attr(n) container_of(n, struct module_attribute, attr)
 #define to_module_kobject(n) container_of(n, struct module_kobject, kobj)
-- 
2.30.2

