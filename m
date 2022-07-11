Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FEC570831
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 18:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiGKQU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 12:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGKQUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:20:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744F723BEB;
        Mon, 11 Jul 2022 09:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=+AKYIlBgnPuUdFvvHHgA+1qVITkc7eo/eR5PksQjENw=; b=nGma/0ENUcYygDvmW2iaxMuiV/
        ghwltMP4QCWjGbeAuKXmLlL6MwY3jU45/X9sOEw4a8AV3PYkysy2AvjD6+T2OYWCgrxOeT9bKcn4S
        dUVvOI1mWKvVOw5UIiay+eQEgUL5XHOdJaN0L2yn/BiAMTBZU4TYF03GFs60PJBxmEC+kvJ/8rhnr
        B8JrIx4X08bC56A+GC/d9wK6Yl0RjVRbRrfSR+R9t16ulm/QfSMt17xgY0KBM2CkgStlBY8FFnKNz
        OWYIegO8zuhIgWAuewjAq7aK/HtFLIC2L3/JwFg4maYVpklWWMQCobeVTaezia+4QR+R/EprbnDnV
        irv0WIUA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oAw9U-003C4o-VK; Mon, 11 Jul 2022 16:20:53 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     atomlin@redhat.com, christophe.leroy@csgroup.eu,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] modules: move module symbols from init/Kconfig
Date:   Mon, 11 Jul 2022 09:20:49 -0700
Message-Id: <20220711162049.761342-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves all the module symbols from init/Kconfig to its
own dedicated file now that we have all of the module code in
its own directory.

This does not introduce any functional changes.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 init/Kconfig          | 298 +-----------------------------------------
 kernel/module/Kconfig | 296 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 297 insertions(+), 297 deletions(-)
 create mode 100644 kernel/module/Kconfig

diff --git a/init/Kconfig b/init/Kconfig
index c7900e8975f1..afb45347b775 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1918,303 +1918,6 @@ config BASE_SMALL
 	default 0 if BASE_FULL
 	default 1 if !BASE_FULL
 
-config MODULE_SIG_FORMAT
-	def_bool n
-	select SYSTEM_DATA_VERIFICATION
-
-menuconfig MODULES
-	bool "Enable loadable module support"
-	modules
-	help
-	  Kernel modules are small pieces of compiled code which can
-	  be inserted in the running kernel, rather than being
-	  permanently built into the kernel.  You use the "modprobe"
-	  tool to add (and sometimes remove) them.  If you say Y here,
-	  many parts of the kernel can be built as modules (by
-	  answering M instead of Y where indicated): this is most
-	  useful for infrequently used options which are not required
-	  for booting.  For more information, see the man pages for
-	  modprobe, lsmod, modinfo, insmod and rmmod.
-
-	  If you say Y here, you will need to run "make
-	  modules_install" to put the modules under /lib/modules/
-	  where modprobe can find them (you may need to be root to do
-	  this).
-
-	  If unsure, say Y.
-
-if MODULES
-
-config MODULE_FORCE_LOAD
-	bool "Forced module loading"
-	default n
-	help
-	  Allow loading of modules without version information (ie. modprobe
-	  --force).  Forced module loading sets the 'F' (forced) taint flag and
-	  is usually a really bad idea.
-
-config MODULE_UNLOAD
-	bool "Module unloading"
-	help
-	  Without this option you will not be able to unload any
-	  modules (note that some modules may not be unloadable
-	  anyway), which makes your kernel smaller, faster
-	  and simpler.  If unsure, say Y.
-
-config MODULE_FORCE_UNLOAD
-	bool "Forced module unloading"
-	depends on MODULE_UNLOAD
-	help
-	  This option allows you to force a module to unload, even if the
-	  kernel believes it is unsafe: the kernel will remove the module
-	  without waiting for anyone to stop using it (using the -f option to
-	  rmmod).  This is mainly for kernel developers and desperate users.
-	  If unsure, say N.
-
-config MODULE_UNLOAD_TAINT_TRACKING
-	bool "Tainted module unload tracking"
-	depends on MODULE_UNLOAD
-	default n
-	help
-	  This option allows you to maintain a record of each unloaded
-	  module that tainted the kernel. In addition to displaying a
-	  list of linked (or loaded) modules e.g. on detection of a bad
-	  page (see bad_page()), the aforementioned details are also
-	  shown. If unsure, say N.
-
-config MODVERSIONS
-	bool "Module versioning support"
-	help
-	  Usually, you have to use modules compiled with your kernel.
-	  Saying Y here makes it sometimes possible to use modules
-	  compiled for different kernels, by adding enough information
-	  to the modules to (hopefully) spot any changes which would
-	  make them incompatible with the kernel you are running.  If
-	  unsure, say N.
-
-config ASM_MODVERSIONS
-	bool
-	default HAVE_ASM_MODVERSIONS && MODVERSIONS
-	help
-	  This enables module versioning for exported symbols also from
-	  assembly. This can be enabled only when the target architecture
-	  supports it.
-
-config MODULE_SRCVERSION_ALL
-	bool "Source checksum for all modules"
-	help
-	  Modules which contain a MODULE_VERSION get an extra "srcversion"
-	  field inserted into their modinfo section, which contains a
-    	  sum of the source files which made it.  This helps maintainers
-	  see exactly which source was used to build a module (since
-	  others sometimes change the module source without updating
-	  the version).  With this option, such a "srcversion" field
-	  will be created for all modules.  If unsure, say N.
-
-config MODULE_SIG
-	bool "Module signature verification"
-	select MODULE_SIG_FORMAT
-	help
-	  Check modules for valid signatures upon load: the signature
-	  is simply appended to the module. For more information see
-	  <file:Documentation/admin-guide/module-signing.rst>.
-
-	  Note that this option adds the OpenSSL development packages as a
-	  kernel build dependency so that the signing tool can use its crypto
-	  library.
-
-	  You should enable this option if you wish to use either
-	  CONFIG_SECURITY_LOCKDOWN_LSM or lockdown functionality imposed via
-	  another LSM - otherwise unsigned modules will be loadable regardless
-	  of the lockdown policy.
-
-	  !!!WARNING!!!  If you enable this option, you MUST make sure that the
-	  module DOES NOT get stripped after being signed.  This includes the
-	  debuginfo strip done by some packagers (such as rpmbuild) and
-	  inclusion into an initramfs that wants the module size reduced.
-
-config MODULE_SIG_FORCE
-	bool "Require modules to be validly signed"
-	depends on MODULE_SIG
-	help
-	  Reject unsigned modules or signed modules for which we don't have a
-	  key.  Without this, such modules will simply taint the kernel.
-
-config MODULE_SIG_ALL
-	bool "Automatically sign all modules"
-	default y
-	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
-	help
-	  Sign all modules during make modules_install. Without this option,
-	  modules must be signed manually, using the scripts/sign-file tool.
-
-comment "Do not forget to sign required modules with scripts/sign-file"
-	depends on MODULE_SIG_FORCE && !MODULE_SIG_ALL
-
-choice
-	prompt "Which hash algorithm should modules be signed with?"
-	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
-	help
-	  This determines which sort of hashing algorithm will be used during
-	  signature generation.  This algorithm _must_ be built into the kernel
-	  directly so that signature verification can take place.  It is not
-	  possible to load a signed module containing the algorithm to check
-	  the signature on that module.
-
-config MODULE_SIG_SHA1
-	bool "Sign modules with SHA-1"
-	select CRYPTO_SHA1
-
-config MODULE_SIG_SHA224
-	bool "Sign modules with SHA-224"
-	select CRYPTO_SHA256
-
-config MODULE_SIG_SHA256
-	bool "Sign modules with SHA-256"
-	select CRYPTO_SHA256
-
-config MODULE_SIG_SHA384
-	bool "Sign modules with SHA-384"
-	select CRYPTO_SHA512
-
-config MODULE_SIG_SHA512
-	bool "Sign modules with SHA-512"
-	select CRYPTO_SHA512
-
-endchoice
-
-config MODULE_SIG_HASH
-	string
-	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
-	default "sha1" if MODULE_SIG_SHA1
-	default "sha224" if MODULE_SIG_SHA224
-	default "sha256" if MODULE_SIG_SHA256
-	default "sha384" if MODULE_SIG_SHA384
-	default "sha512" if MODULE_SIG_SHA512
-
-choice
-	prompt "Module compression mode"
-	help
-	  This option allows you to choose the algorithm which will be used to
-	  compress modules when 'make modules_install' is run. (or, you can
-	  choose to not compress modules at all.)
-
-	  External modules will also be compressed in the same way during the
-	  installation.
-
-	  For modules inside an initrd or initramfs, it's more efficient to
-	  compress the whole initrd or initramfs instead.
-
-	  This is fully compatible with signed modules.
-
-	  Please note that the tool used to load modules needs to support the
-	  corresponding algorithm. module-init-tools MAY support gzip, and kmod
-	  MAY support gzip, xz and zstd.
-
-	  Your build system needs to provide the appropriate compression tool
-	  to compress the modules.
-
-	  If in doubt, select 'None'.
-
-config MODULE_COMPRESS_NONE
-	bool "None"
-	help
-	  Do not compress modules. The installed modules are suffixed
-	  with .ko.
-
-config MODULE_COMPRESS_GZIP
-	bool "GZIP"
-	help
-	  Compress modules with GZIP. The installed modules are suffixed
-	  with .ko.gz.
-
-config MODULE_COMPRESS_XZ
-	bool "XZ"
-	help
-	  Compress modules with XZ. The installed modules are suffixed
-	  with .ko.xz.
-
-config MODULE_COMPRESS_ZSTD
-	bool "ZSTD"
-	help
-	  Compress modules with ZSTD. The installed modules are suffixed
-	  with .ko.zst.
-
-endchoice
-
-config MODULE_DECOMPRESS
-	bool "Support in-kernel module decompression"
-	depends on MODULE_COMPRESS_GZIP || MODULE_COMPRESS_XZ
-	select ZLIB_INFLATE if MODULE_COMPRESS_GZIP
-	select XZ_DEC if MODULE_COMPRESS_XZ
-	help
-
-	  Support for decompressing kernel modules by the kernel itself
-	  instead of relying on userspace to perform this task. Useful when
-	  load pinning security policy is enabled.
-
-	  If unsure, say N.
-
-config MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
-	bool "Allow loading of modules with missing namespace imports"
-	help
-	  Symbols exported with EXPORT_SYMBOL_NS*() are considered exported in
-	  a namespace. A module that makes use of a symbol exported with such a
-	  namespace is required to import the namespace via MODULE_IMPORT_NS().
-	  There is no technical reason to enforce correct namespace imports,
-	  but it creates consistency between symbols defining namespaces and
-	  users importing namespaces they make use of. This option relaxes this
-	  requirement and lifts the enforcement when loading a module.
-
-	  If unsure, say N.
-
-config MODPROBE_PATH
-	string "Path to modprobe binary"
-	default "/sbin/modprobe"
-	help
-	  When kernel code requests a module, it does so by calling
-	  the "modprobe" userspace utility. This option allows you to
-	  set the path where that binary is found. This can be changed
-	  at runtime via the sysctl file
-	  /proc/sys/kernel/modprobe. Setting this to the empty string
-	  removes the kernel's ability to request modules (but
-	  userspace can still load modules explicitly).
-
-config TRIM_UNUSED_KSYMS
-	bool "Trim unused exported kernel symbols" if EXPERT
-	depends on !COMPILE_TEST
-	help
-	  The kernel and some modules make many symbols available for
-	  other modules to use via EXPORT_SYMBOL() and variants. Depending
-	  on the set of modules being selected in your kernel configuration,
-	  many of those exported symbols might never be used.
-
-	  This option allows for unused exported symbols to be dropped from
-	  the build. In turn, this provides the compiler more opportunities
-	  (especially when using LTO) for optimizing the code and reducing
-	  binary size.  This might have some security advantages as well.
-
-	  If unsure, or if you need to build out-of-tree modules, say N.
-
-config UNUSED_KSYMS_WHITELIST
-	string "Whitelist of symbols to keep in ksymtab"
-	depends on TRIM_UNUSED_KSYMS
-	help
-	  By default, all unused exported symbols will be un-exported from the
-	  build when TRIM_UNUSED_KSYMS is selected.
-
-	  UNUSED_KSYMS_WHITELIST allows to whitelist symbols that must be kept
-	  exported at all times, even in absence of in-tree users. The value to
-	  set here is the path to a text file containing the list of symbols,
-	  one per line. The path can be absolute, or relative to the kernel
-	  source tree.
-
-endif # MODULES
-
-config MODULES_TREE_LOOKUP
-	def_bool y
-	depends on PERF_EVENTS || TRACING || CFI_CLANG
-
 config INIT_ALL_POSSIBLE
 	bool
 	help
@@ -2224,6 +1927,7 @@ config INIT_ALL_POSSIBLE
 	  it was better to provide this option than to break all the archs
 	  and have several arch maintainers pursuing me down dark alleys.
 
+source "kernel/module/Kconfig"
 source "block/Kconfig"
 
 config PREEMPT_NOTIFIERS
diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
new file mode 100644
index 000000000000..5aff8a40c58e
--- /dev/null
+++ b/kernel/module/Kconfig
@@ -0,0 +1,296 @@
+config MODULE_SIG_FORMAT
+	def_bool n
+	select SYSTEM_DATA_VERIFICATION
+
+menuconfig MODULES
+	bool "Enable loadable module support"
+	modules
+	help
+	  Kernel modules are small pieces of compiled code which can
+	  be inserted in the running kernel, rather than being
+	  permanently built into the kernel.  You use the "modprobe"
+	  tool to add (and sometimes remove) them.  If you say Y here,
+	  many parts of the kernel can be built as modules (by
+	  answering M instead of Y where indicated): this is most
+	  useful for infrequently used options which are not required
+	  for booting.  For more information, see the man pages for
+	  modprobe, lsmod, modinfo, insmod and rmmod.
+
+	  If you say Y here, you will need to run "make
+	  modules_install" to put the modules under /lib/modules/
+	  where modprobe can find them (you may need to be root to do
+	  this).
+
+	  If unsure, say Y.
+
+if MODULES
+
+config MODULE_FORCE_LOAD
+	bool "Forced module loading"
+	default n
+	help
+	  Allow loading of modules without version information (ie. modprobe
+	  --force).  Forced module loading sets the 'F' (forced) taint flag and
+	  is usually a really bad idea.
+
+config MODULE_UNLOAD
+	bool "Module unloading"
+	help
+	  Without this option you will not be able to unload any
+	  modules (note that some modules may not be unloadable
+	  anyway), which makes your kernel smaller, faster
+	  and simpler.  If unsure, say Y.
+
+config MODULE_FORCE_UNLOAD
+	bool "Forced module unloading"
+	depends on MODULE_UNLOAD
+	help
+	  This option allows you to force a module to unload, even if the
+	  kernel believes it is unsafe: the kernel will remove the module
+	  without waiting for anyone to stop using it (using the -f option to
+	  rmmod).  This is mainly for kernel developers and desperate users.
+	  If unsure, say N.
+
+config MODULE_UNLOAD_TAINT_TRACKING
+	bool "Tainted module unload tracking"
+	depends on MODULE_UNLOAD
+	default n
+	help
+	  This option allows you to maintain a record of each unloaded
+	  module that tainted the kernel. In addition to displaying a
+	  list of linked (or loaded) modules e.g. on detection of a bad
+	  page (see bad_page()), the aforementioned details are also
+	  shown. If unsure, say N.
+
+config MODVERSIONS
+	bool "Module versioning support"
+	help
+	  Usually, you have to use modules compiled with your kernel.
+	  Saying Y here makes it sometimes possible to use modules
+	  compiled for different kernels, by adding enough information
+	  to the modules to (hopefully) spot any changes which would
+	  make them incompatible with the kernel you are running.  If
+	  unsure, say N.
+
+config ASM_MODVERSIONS
+	bool
+	default HAVE_ASM_MODVERSIONS && MODVERSIONS
+	help
+	  This enables module versioning for exported symbols also from
+	  assembly. This can be enabled only when the target architecture
+	  supports it.
+
+config MODULE_SRCVERSION_ALL
+	bool "Source checksum for all modules"
+	help
+	  Modules which contain a MODULE_VERSION get an extra "srcversion"
+	  field inserted into their modinfo section, which contains a
+    	  sum of the source files which made it.  This helps maintainers
+	  see exactly which source was used to build a module (since
+	  others sometimes change the module source without updating
+	  the version).  With this option, such a "srcversion" field
+	  will be created for all modules.  If unsure, say N.
+
+config MODULE_SIG
+	bool "Module signature verification"
+	select MODULE_SIG_FORMAT
+	help
+	  Check modules for valid signatures upon load: the signature
+	  is simply appended to the module. For more information see
+	  <file:Documentation/admin-guide/module-signing.rst>.
+
+	  Note that this option adds the OpenSSL development packages as a
+	  kernel build dependency so that the signing tool can use its crypto
+	  library.
+
+	  You should enable this option if you wish to use either
+	  CONFIG_SECURITY_LOCKDOWN_LSM or lockdown functionality imposed via
+	  another LSM - otherwise unsigned modules will be loadable regardless
+	  of the lockdown policy.
+
+	  !!!WARNING!!!  If you enable this option, you MUST make sure that the
+	  module DOES NOT get stripped after being signed.  This includes the
+	  debuginfo strip done by some packagers (such as rpmbuild) and
+	  inclusion into an initramfs that wants the module size reduced.
+
+config MODULE_SIG_FORCE
+	bool "Require modules to be validly signed"
+	depends on MODULE_SIG
+	help
+	  Reject unsigned modules or signed modules for which we don't have a
+	  key.  Without this, such modules will simply taint the kernel.
+
+config MODULE_SIG_ALL
+	bool "Automatically sign all modules"
+	default y
+	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
+	help
+	  Sign all modules during make modules_install. Without this option,
+	  modules must be signed manually, using the scripts/sign-file tool.
+
+comment "Do not forget to sign required modules with scripts/sign-file"
+	depends on MODULE_SIG_FORCE && !MODULE_SIG_ALL
+
+choice
+	prompt "Which hash algorithm should modules be signed with?"
+	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
+	help
+	  This determines which sort of hashing algorithm will be used during
+	  signature generation.  This algorithm _must_ be built into the kernel
+	  directly so that signature verification can take place.  It is not
+	  possible to load a signed module containing the algorithm to check
+	  the signature on that module.
+
+config MODULE_SIG_SHA1
+	bool "Sign modules with SHA-1"
+	select CRYPTO_SHA1
+
+config MODULE_SIG_SHA224
+	bool "Sign modules with SHA-224"
+	select CRYPTO_SHA256
+
+config MODULE_SIG_SHA256
+	bool "Sign modules with SHA-256"
+	select CRYPTO_SHA256
+
+config MODULE_SIG_SHA384
+	bool "Sign modules with SHA-384"
+	select CRYPTO_SHA512
+
+config MODULE_SIG_SHA512
+	bool "Sign modules with SHA-512"
+	select CRYPTO_SHA512
+
+endchoice
+
+config MODULE_SIG_HASH
+	string
+	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
+	default "sha1" if MODULE_SIG_SHA1
+	default "sha224" if MODULE_SIG_SHA224
+	default "sha256" if MODULE_SIG_SHA256
+	default "sha384" if MODULE_SIG_SHA384
+	default "sha512" if MODULE_SIG_SHA512
+
+choice
+	prompt "Module compression mode"
+	help
+	  This option allows you to choose the algorithm which will be used to
+	  compress modules when 'make modules_install' is run. (or, you can
+	  choose to not compress modules at all.)
+
+	  External modules will also be compressed in the same way during the
+	  installation.
+
+	  For modules inside an initrd or initramfs, it's more efficient to
+	  compress the whole initrd or initramfs instead.
+
+	  This is fully compatible with signed modules.
+
+	  Please note that the tool used to load modules needs to support the
+	  corresponding algorithm. module-init-tools MAY support gzip, and kmod
+	  MAY support gzip, xz and zstd.
+
+	  Your build system needs to provide the appropriate compression tool
+	  to compress the modules.
+
+	  If in doubt, select 'None'.
+
+config MODULE_COMPRESS_NONE
+	bool "None"
+	help
+	  Do not compress modules. The installed modules are suffixed
+	  with .ko.
+
+config MODULE_COMPRESS_GZIP
+	bool "GZIP"
+	help
+	  Compress modules with GZIP. The installed modules are suffixed
+	  with .ko.gz.
+
+config MODULE_COMPRESS_XZ
+	bool "XZ"
+	help
+	  Compress modules with XZ. The installed modules are suffixed
+	  with .ko.xz.
+
+config MODULE_COMPRESS_ZSTD
+	bool "ZSTD"
+	help
+	  Compress modules with ZSTD. The installed modules are suffixed
+	  with .ko.zst.
+
+endchoice
+
+config MODULE_DECOMPRESS
+	bool "Support in-kernel module decompression"
+	depends on MODULE_COMPRESS_GZIP || MODULE_COMPRESS_XZ
+	select ZLIB_INFLATE if MODULE_COMPRESS_GZIP
+	select XZ_DEC if MODULE_COMPRESS_XZ
+	help
+
+	  Support for decompressing kernel modules by the kernel itself
+	  instead of relying on userspace to perform this task. Useful when
+	  load pinning security policy is enabled.
+
+	  If unsure, say N.
+
+config MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
+	bool "Allow loading of modules with missing namespace imports"
+	help
+	  Symbols exported with EXPORT_SYMBOL_NS*() are considered exported in
+	  a namespace. A module that makes use of a symbol exported with such a
+	  namespace is required to import the namespace via MODULE_IMPORT_NS().
+	  There is no technical reason to enforce correct namespace imports,
+	  but it creates consistency between symbols defining namespaces and
+	  users importing namespaces they make use of. This option relaxes this
+	  requirement and lifts the enforcement when loading a module.
+
+	  If unsure, say N.
+
+config MODPROBE_PATH
+	string "Path to modprobe binary"
+	default "/sbin/modprobe"
+	help
+	  When kernel code requests a module, it does so by calling
+	  the "modprobe" userspace utility. This option allows you to
+	  set the path where that binary is found. This can be changed
+	  at runtime via the sysctl file
+	  /proc/sys/kernel/modprobe. Setting this to the empty string
+	  removes the kernel's ability to request modules (but
+	  userspace can still load modules explicitly).
+
+config TRIM_UNUSED_KSYMS
+	bool "Trim unused exported kernel symbols" if EXPERT
+	depends on !COMPILE_TEST
+	help
+	  The kernel and some modules make many symbols available for
+	  other modules to use via EXPORT_SYMBOL() and variants. Depending
+	  on the set of modules being selected in your kernel configuration,
+	  many of those exported symbols might never be used.
+
+	  This option allows for unused exported symbols to be dropped from
+	  the build. In turn, this provides the compiler more opportunities
+	  (especially when using LTO) for optimizing the code and reducing
+	  binary size.  This might have some security advantages as well.
+
+	  If unsure, or if you need to build out-of-tree modules, say N.
+
+config UNUSED_KSYMS_WHITELIST
+	string "Whitelist of symbols to keep in ksymtab"
+	depends on TRIM_UNUSED_KSYMS
+	help
+	  By default, all unused exported symbols will be un-exported from the
+	  build when TRIM_UNUSED_KSYMS is selected.
+
+	  UNUSED_KSYMS_WHITELIST allows to whitelist symbols that must be kept
+	  exported at all times, even in absence of in-tree users. The value to
+	  set here is the path to a text file containing the list of symbols,
+	  one per line. The path can be absolute, or relative to the kernel
+	  source tree.
+
+endif # MODULES
+
+config MODULES_TREE_LOOKUP
+	def_bool y
+	depends on PERF_EVENTS || TRACING || CFI_CLANG
-- 
2.35.1

