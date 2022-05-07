Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6842351E95E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 21:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387041AbiEGTSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 15:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiEGTSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 15:18:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30AF28980;
        Sat,  7 May 2022 12:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/znyXJRLDsok/YXirIxLkxYec6QFvnOe+R9jljS85JE=; b=V5byyGjS+aQTtTXriJ+35IDUKR
        v3q+TWlwj4c97wcCcmG8DlQY+MLorVgC38EJB7oc1omiLMr2+FTBkkNT4GK2gGUFTKhw71ormve2g
        jQ+VriF3FmMYXJH5iKuw6xPC2FmfoHlPfaGz/SlL/EANgoW+fsRQ4Zsg0rKqQnLsKE0P3JqP/9YQZ
        TaGz6w1h9ZZrYf0zs9Z3e/rtASJOB7tPUOKXX0ZVHJqa1aaxyv4ebPkedCgnz/d1FNDoXO57GrBmo
        1ivFTOe7e/CW+pCiPC4L2awJ8+JiW93SfrwgPIBj4WwwFVbeoisk1oVBiEC1/IgehgiBIJH2PdtBN
        kiMQWe+w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnPt9-0085Um-Iu; Sat, 07 May 2022 19:14:47 +0000
Date:   Sat, 7 May 2022 12:14:47 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        "fnovak@us.ibm.com" <fnovak@us.ibm.com>
Subject: Re: request_module DoS
Message-ID: <YnbFJ0fn5gLTRLX7@bombadil.infradead.org>
References: <YnXiuhdZ49pKL/dK@gondor.apana.org.au>
 <77ecde32-e868-5804-d9a5-3bb22d314777@csgroup.eu>
 <YnYnjLXm6atlznPT@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnYnjLXm6atlznPT@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2022 at 01:02:20AM -0700, Luis Chamberlain wrote:
> You can try to reproduce by using adding a new test type for crypto-aegis256
> on lib/test_kmod.c. These tests however can try something similar but other
> modules.
> 
> /tools/testing/selftests/kmod/kmod.sh -t 0008
> /tools/testing/selftests/kmod/kmod.sh -t 0009
> 
> I can't decipher this yet.

Without testing it... but something like this might be an easier
reproducer:

diff --git a/tools/testing/selftests/kmod/kmod.sh b/tools/testing/selftests/kmod/kmod.sh
index afd42387e8b2..48b6b5ec6c1e 100755
--- a/tools/testing/selftests/kmod/kmod.sh
+++ b/tools/testing/selftests/kmod/kmod.sh
@@ -41,6 +41,7 @@ set -e
 TEST_NAME="kmod"
 TEST_DRIVER="test_${TEST_NAME}"
 TEST_DIR=$(dirname $0)
+PROC_CONFIG="/proc/config.gz"
 
 # This represents
 #
@@ -65,6 +66,7 @@ ALL_TESTS="$ALL_TESTS 0010:1:1"
 ALL_TESTS="$ALL_TESTS 0011:1:1"
 ALL_TESTS="$ALL_TESTS 0012:1:1"
 ALL_TESTS="$ALL_TESTS 0013:1:1"
+ALL_TESTS="$ALL_TESTS 0014:150:1"
 
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
@@ -79,6 +81,19 @@ test_modprobe()
        fi
 }
 
+kconfig_has()
+{
+	if [ -f $PROC_CONFIG ]; then
+		if zgrep -q $1 $PROC_CONFIG 2>/dev/null; then
+			echo "yes"
+		else
+			echo "no"
+		fi
+	else
+			echo "no"
+	fi
+}
+
 function allow_user_defaults()
 {
 	if [ -z $DEFAULT_KMOD_DRIVER ]; then
@@ -106,6 +121,8 @@ function allow_user_defaults()
 	fi
 
 	MODPROBE_LIMIT_FILE="${PROC_DIR}/kmod-limit"
+	HAS_CRYPTO_AEGIS256_MOD="$(kconfig_has CONFIG_CRYPTO_AEGIS256=m)"
+	HAS_CRYPTO_AEGIS256_BUILTIN="$(kconfig_has CONFIG_CRYPTO_AEGIS256=y)"
 }
 
 test_reqs()
@@ -504,6 +521,21 @@ kmod_test_0013()
 		"cat /sys/module/${DEFAULT_KMOD_DRIVER}/sections/.*text | head -n1"
 }
 
+kmod_test_0014()
+{
+	kmod_defaults_driver
+	MODPROBE_LIMIT=$(config_get_modprobe_limit)
+	let EXTRA=$MODPROBE_LIMIT/6
+	config_set_driver crypto-aegis256
+	config_num_thread_limit_extra $EXTRA
+	config_trigger ${FUNCNAME[0]}
+	if [[ "$HAS_CRYPTO_AEGIS256_MOD" == "yes" || "$HAS_CRYPTO_AEGIS256_BUILTIN" == "yes" ]]; then
+		config_expect_result ${FUNCNAME[0]} SUCCESS
+	else
+		config_expect_result ${FUNCNAME[0]} MODULE_NOT_FOUND
+	fi
+}
+
 list_tests()
 {
 	echo "Test ID list:"
@@ -525,6 +557,7 @@ list_tests()
 	echo "0011 x $(get_test_count 0011) - test completely disabling module autoloading"
 	echo "0012 x $(get_test_count 0012) - test /proc/modules address visibility under CAP_SYSLOG"
 	echo "0013 x $(get_test_count 0013) - test /sys/module/*/sections/* visibility under CAP_SYSLOG"
+	echo "0014 x $(get_test_count 0014) - multithreaded - push kmod_concurrent over max_modprobes for request_module() for crypto-aegis256"
 }
 
 usage()
