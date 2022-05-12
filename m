Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9870524472
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 06:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347974AbiELEoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 00:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347712AbiELEoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 00:44:32 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265B1219C2D;
        Wed, 11 May 2022 21:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652330669; x=1683866669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5hO/sgLiDSgWkzc95Ve2g7mRF1d6f4jPBEBN5QariTM=;
  b=Lrp3mpezifn5dQHVV4yuqelfJlMRDF8bzTsoHHxSkYjWvqjrvl+MAdIt
   sDltFoac2a6QzJP1wuHdpFwmt6O5kdSB+cHABwsq7AG/1ryQeSPZU+9SY
   UysTfGclW2qHljcgUEJVJrz02jvmiSP9li2KbapIedc6q0L15zCVl8R3L
   f8ml2AUAo9fmeV8N3ZXwSAuMKh0I6YMBtncZKoPHFFAusMl9Xm/REFsHh
   r/umyLJnDUVVA008O7YjbPykbpaBpWi660uNGXNhFS0dGMoOyCXHLVDMR
   /K9HLSGULeWLlfDl43xs0+wy0cDAYAgYE2LP+sIOZNVunY4IR/3zM2m7D
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="257436638"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="257436638"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 21:44:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="697869943"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 11 May 2022 21:44:21 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1np0gW-000Jx1-Fn;
        Thu, 12 May 2022 04:44:20 +0000
Date:   Thu, 12 May 2022 12:43:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gireesh.Hiremath@in.bosch.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, bcousson@baylibre.com,
        tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmitry.torokhov@gmail.com,
        mkorpershoek@baylibre.com, davidgow@google.com,
        m.felsch@pengutronix.de, swboyd@chromium.org,
        fengping.yu@mediatek.com, y.oudjana@protonmail.com,
        rdunlap@infradead.org, colin.king@intel.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        sjoerd.simons@collabora.co.uk, VinayKumar.Shettar@in.bosch.com,
        Govindaraji.Sivanantham@in.bosch.com, anaclaudia.dias@de.bosch.com
Subject: Re: [PATCH v2 2/4] Input: mt-matrix-keypad: Add Bosch mt matrix
 keypad driver
Message-ID: <202205121241.RQJCa61u-lkp@intel.com>
References: <20220506072737.1590-2-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506072737.1590-2-Gireesh.Hiremath@in.bosch.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tmlind-omap/for-next]
[also build test WARNING on next-20220511]
[cannot apply to dtor-input/next robh/for-next balbi-usb/testing/next v5.18-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Gireesh-Hiremath-in-bosch-com/ARM-dts-am335x-Guardian-switch-to-AM33XX_PADCONF-pinmux-macro/20220506-153118
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git for-next
config: riscv-randconfig-c006-20220508 (https://download.01.org/0day-ci/archive/20220512/202205121241.RQJCa61u-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project af4cf1c6b8ed0d8102fc5e69acdc2fcbbcdaa9a7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/eb3dca58cf317366877720c44e785ab0ce151ef8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Gireesh-Hiremath-in-bosch-com/ARM-dts-am335x-Guardian-switch-to-AM33XX_PADCONF-pinmux-macro/20220506-153118
        git checkout eb3dca58cf317366877720c44e785ab0ce151ef8
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=riscv clang-analyzer 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/input/keyboard/mt_matrix_keypad.c:200:7: warning: variable 'any_btn_served' set but not used [-Wunused-but-set-variable]
           bool any_btn_served = false;
                ^
   1 warning generated.


clang-analyzer warnings: (new ones prefixed by >>)
                  ^~~~~~~
   drivers/hwmon/w83627ehf.c:991:1: warning: Call to function 'sprintf' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'sprintf_s' in case of C11 [clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling]
   fan_functions(fan_step_output, data->REG_FAN_STEP_OUTPUT)
   ^
   drivers/hwmon/w83627ehf.c:965:9: note: expanded from macro 'fan_functions'
           return sprintf(buf, "%d\n", data->reg[nr]); \
                  ^~~~~~~
   drivers/hwmon/w83627ehf.c:991:1: note: Call to function 'sprintf' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'sprintf_s' in case of C11
   fan_functions(fan_step_output, data->REG_FAN_STEP_OUTPUT)
   ^
   drivers/hwmon/w83627ehf.c:965:9: note: expanded from macro 'fan_functions'
           return sprintf(buf, "%d\n", data->reg[nr]); \
                  ^~~~~~~
   drivers/hwmon/w83627ehf.c:1027:1: warning: Call to function 'sprintf' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'sprintf_s' in case of C11 [clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling]
   fan_time_functions(fan_stop_time, W83627EHF_REG_FAN_STOP_TIME)
   ^
   drivers/hwmon/w83627ehf.c:1001:9: note: expanded from macro 'fan_time_functions'
           return sprintf(buf, "%d\n", \
                  ^~~~~~~
   drivers/hwmon/w83627ehf.c:1027:1: note: Call to function 'sprintf' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'sprintf_s' in case of C11
   fan_time_functions(fan_stop_time, W83627EHF_REG_FAN_STOP_TIME)
   ^
   drivers/hwmon/w83627ehf.c:1001:9: note: expanded from macro 'fan_time_functions'
           return sprintf(buf, "%d\n", \
                  ^~~~~~~
   drivers/hwmon/w83627ehf.c:1082:9: warning: Call to function 'sprintf' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'sprintf_s' in case of C11 [clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling]
           return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
                  ^~~~~~~
   drivers/hwmon/w83627ehf.c:1082:9: note: Call to function 'sprintf' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'sprintf_s' in case of C11
           return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
                  ^~~~~~~
   Suppressed 29 warnings (29 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   40 warnings generated.
   Suppressed 40 warnings (40 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   53 warnings generated.
   drivers/leds/leds-lp3952.c:104:2: warning: Call to function 'strncpy' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'strncpy_s' in case of C11 [clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling]
           strncpy(dest, str, LP3952_LABEL_MAX_LEN);
           ^~~~~~~
   drivers/leds/leds-lp3952.c:104:2: note: Call to function 'strncpy' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'strncpy_s' in case of C11
           strncpy(dest, str, LP3952_LABEL_MAX_LEN);
           ^~~~~~~
   Suppressed 52 warnings (52 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   59 warnings generated.
   drivers/leds/leds-lp5521.c:230:9: warning: Call to function 'sscanf' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'sscanf_s' in case of C11 [clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling]
                   ret = sscanf(data + offset, "%2s%n ", c, &nrchars);
                         ^~~~~~
   drivers/leds/leds-lp5521.c:230:9: note: Call to function 'sscanf' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'sscanf_s' in case of C11
                   ret = sscanf(data + offset, "%2s%n ", c, &nrchars);
                         ^~~~~~
   drivers/leds/leds-lp5521.c:234:9: warning: Call to function 'sscanf' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'sscanf_s' in case of C11 [clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling]
                   ret = sscanf(c, "%2x", &cmd);
                         ^~~~~~
   drivers/leds/leds-lp5521.c:234:9: note: Call to function 'sscanf' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'sscanf_s' in case of C11
                   ret = sscanf(c, "%2x", &cmd);
                         ^~~~~~
   drivers/leds/leds-lp5521.c:306:2: warning: Value stored to 'ret' is never read [clang-analyzer-deadcode.DeadStores]
           ret = lp55xx_write(chip, LP5521_REG_OP_MODE, LP5521_CMD_DIRECT);
           ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/leds/leds-lp5521.c:306:2: note: Value stored to 'ret' is never read
           ret = lp55xx_write(chip, LP5521_REG_OP_MODE, LP5521_CMD_DIRECT);
           ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/leds/leds-lp5521.c:368:2: warning: Undefined or garbage value returned to caller [clang-analyzer-core.uninitialized.UndefReturn]
           return ret;
           ^      ~~~
   drivers/leds/leds-lp5521.c:355:2: note: 'ret' declared without an initial value
           int ret;
           ^~~~~~~
   drivers/leds/leds-lp5521.c:359:14: note: Assuming 'i' is >= field 'num_colors'
           for (i = 0; i < led->mc_cdev.num_colors; i++) {
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/leds/leds-lp5521.c:359:2: note: Loop condition is false. Execution continues on line 367
           for (i = 0; i < led->mc_cdev.num_colors; i++) {
           ^
   drivers/leds/leds-lp5521.c:368:2: note: Undefined or garbage value returned to caller
           return ret;
           ^      ~~~
   drivers/leds/leds-lp5521.c:394:10: warning: Call to function 'sprintf' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'sprintf_s' in case of C11 [clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling]
                   return sprintf(buf, "run\n");
                          ^~~~~~~
   drivers/leds/leds-lp5521.c:394:10: note: Call to function 'sprintf' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'sprintf_s' in case of C11
                   return sprintf(buf, "run\n");
                          ^~~~~~~
   drivers/leds/leds-lp5521.c:396:10: warning: Call to function 'sprintf' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'sprintf_s' in case of C11 [clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling]
                   return sprintf(buf, "load\n");
                          ^~~~~~~
   drivers/leds/leds-lp5521.c:396:10: note: Call to function 'sprintf' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'sprintf_s' in case of C11
                   return sprintf(buf, "load\n");
                          ^~~~~~~
   drivers/leds/leds-lp5521.c:399:10: warning: Call to function 'sprintf' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'sprintf_s' in case of C11 [clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling]
                   return sprintf(buf, "disabled\n");
                          ^~~~~~~
   drivers/leds/leds-lp5521.c:399:10: note: Call to function 'sprintf' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'sprintf_s' in case of C11
                   return sprintf(buf, "disabled\n");
                          ^~~~~~~
   Suppressed 52 warnings (52 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   43 warnings generated.
>> drivers/input/keyboard/mt_matrix_keypad.c:297:35: warning: Division by zero [clang-analyzer-core.DivideZero]
                           pdata, (int)(pdata->scan_phase % pdata->num_line_gpios),
                                                          ^
   drivers/input/keyboard/mt_matrix_keypad.c:346:6: note: Assuming field 'stopped' is equal to false
           if (keypad->stopped == false) {
               ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/input/keyboard/mt_matrix_keypad.c:346:2: note: Taking true branch
           if (keypad->stopped == false) {
           ^
   drivers/input/keyboard/mt_matrix_keypad.c:347:3: note: Calling 'update_buttons'
                   update_buttons(pdata, input_dev);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/input/keyboard/mt_matrix_keypad.c:222:6: note: Assuming field 'scan_phase' is not equal to field 'phase_prepare'
           if (pdata->scan_phase == pdata->phase_state.phase_prepare) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/input/keyboard/mt_matrix_keypad.c:222:2: note: Taking false branch
           if (pdata->scan_phase == pdata->phase_state.phase_prepare) {
           ^
   drivers/input/keyboard/mt_matrix_keypad.c:225:13: note: Assuming field 'scan_phase' is not equal to field 'phase_update_button'
           } else if (pdata->scan_phase ==
                      ^~~~~~~~~~~~~~~~~~~~
   drivers/input/keyboard/mt_matrix_keypad.c:225:9: note: Taking false branch
           } else if (pdata->scan_phase ==
                  ^
   drivers/input/keyboard/mt_matrix_keypad.c:266:15: note: Assuming 'i' is >= field 'num_line_gpios'
                   for (i = 0; i < pdata->num_line_gpios; i++) {
                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/input/keyboard/mt_matrix_keypad.c:266:3: note: Loop condition is false. Execution continues on line 277
                   for (i = 0; i < pdata->num_line_gpios; i++) {
                   ^
   drivers/input/keyboard/mt_matrix_keypad.c:277:7: note: 'number_of_buttons_pressed' is < 2
                   if (number_of_buttons_pressed < 2) {
                       ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/input/keyboard/mt_matrix_keypad.c:277:3: note: Taking true branch
                   if (number_of_buttons_pressed < 2) {
                   ^
   drivers/input/keyboard/mt_matrix_keypad.c:278:4: note: Loop condition is false. Execution continues on line 293
                           for (i = 0; i < pdata->num_line_gpios; i++) {
                           ^
   drivers/input/keyboard/mt_matrix_keypad.c:297:35: note: Division by zero
                           pdata, (int)(pdata->scan_phase % pdata->num_line_gpios),
                                        ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/input/keyboard/mt_matrix_keypad.c:488:2: warning: Value stored to 'i' is never read [clang-analyzer-deadcode.DeadStores]
           i = pdata->num_line_gpios;
           ^   ~~~~~~~~~~~~~~~~~~~~~
   drivers/input/keyboard/mt_matrix_keypad.c:488:2: note: Value stored to 'i' is never read
           i = pdata->num_line_gpios;
           ^   ~~~~~~~~~~~~~~~~~~~~~
   Suppressed 41 warnings (40 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   40 warnings generated.
   Suppressed 40 warnings (40 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   52 warnings generated.
   Suppressed 52 warnings (52 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   64 warnings generated.
   drivers/media/dvb-frontends/cxd2841er.c:236:2: warning: Call to function 'memcpy' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'memcpy_s' in case of C11 [clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling]
           memcpy(&buf[1], data, len);
           ^
   include/linux/fortify-string.h:369:26: note: expanded from macro 'memcpy'
   #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:362:2: note: expanded from macro '__fortify_memcpy_chk'
           __underlying_##op(p, q, __fortify_size);                        \
           ^~~~~~~~~~~~~~~~~
   note: expanded from here
   include/linux/fortify-string.h:45:29: note: expanded from macro '__underlying_memcpy'
   #define __underlying_memcpy     __builtin_memcpy
                                   ^~~~~~~~~~~~~~~~
   drivers/media/dvb-frontends/cxd2841er.c:236:2: note: Call to function 'memcpy' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'memcpy_s' in case of C11
           memcpy(&buf[1], data, len);
           ^
   include/linux/fortify-string.h:369:26: note: expanded from macro 'memcpy'
   #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:362:2: note: expanded from macro '__fortify_memcpy_chk'
           __underlying_##op(p, q, __fortify_size);                        \
           ^~~~~~~~~~~~~~~~~
   note: expanded from here
   include/linux/fortify-string.h:45:29: note: expanded from macro '__underlying_memcpy'
   #define __underlying_memcpy     __builtin_memcpy
                                   ^~~~~~~~~~~~~~~~
   drivers/media/dvb-frontends/cxd2841er.c:3600:25: warning: Value stored to 'priv' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
           struct cxd2841er_priv *priv = fe->demodulator_priv;
                                  ^~~~   ~~~~~~~~~~~~~~~~~~~~
   drivers/media/dvb-frontends/cxd2841er.c:3600:25: note: Value stored to 'priv' during its initialization is never read
           struct cxd2841er_priv *priv = fe->demodulator_priv;
                                  ^~~~   ~~~~~~~~~~~~~~~~~~~~
   drivers/media/dvb-frontends/cxd2841er.c:3714:2: warning: Call to function 'memset' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'memset_s' in case of C11 [clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling]
           memset(data, 0, sizeof(data));
           ^
   include/linux/fortify-string.h:272:25: note: expanded from macro 'memset'
   #define memset(p, c, s) __fortify_memset_chk(p, c, s,                   \
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:265:2: note: expanded from macro '__fortify_memset_chk'
           __underlying_memset(p, c, __fortify_size);                      \
           ^~~~~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:47:29: note: expanded from macro '__underlying_memset'
   #define __underlying_memset     __builtin_memset
                                   ^~~~~~~~~~~~~~~~
   drivers/media/dvb-frontends/cxd2841er.c:3714:2: note: Call to function 'memset' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'memset_s' in case of C11
           memset(data, 0, sizeof(data));
           ^
   include/linux/fortify-string.h:272:25: note: expanded from macro 'memset'
   #define memset(p, c, s) __fortify_memset_chk(p, c, s,                   \
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:265:2: note: expanded from macro '__fortify_memset_chk'
           __underlying_memset(p, c, __fortify_size);                      \
           ^~~~~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:47:29: note: expanded from macro '__underlying_memset'
   #define __underlying_memset     __builtin_memset
                                   ^~~~~~~~~~~~~~~~
   drivers/media/dvb-frontends/cxd2841er.c:3759:25: warning: Value stored to 'priv' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
           struct cxd2841er_priv *priv = fe->demodulator_priv;
                                  ^~~~   ~~~~~~~~~~~~~~~~~~~~
   drivers/media/dvb-frontends/cxd2841er.c:3759:25: note: Value stored to 'priv' during its initialization is never read
           struct cxd2841er_priv *priv = fe->demodulator_priv;
                                  ^~~~   ~~~~~~~~~~~~~~~~~~~~
   drivers/media/dvb-frontends/cxd2841er.c:3812:34: warning: Value stored to 'p' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
           struct dtv_frontend_properties *p = &fe->dtv_property_cache;
                                           ^   ~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/dvb-frontends/cxd2841er.c:3812:34: note: Value stored to 'p' during its initialization is never read
           struct dtv_frontend_properties *p = &fe->dtv_property_cache;
                                           ^   ~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/dvb-frontends/cxd2841er.c:3867:3: warning: Call to function 'snprintf' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'snprintf_s' in case of C11 [clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling]
                   snprintf(cxd2841er_t_c_ops.info.name, 128,
                   ^~~~~~~~
   drivers/media/dvb-frontends/cxd2841er.c:3867:3: note: Call to function 'snprintf' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'snprintf_s' in case of C11
                   snprintf(cxd2841er_t_c_ops.info.name, 128,
                   ^~~~~~~~
   drivers/media/dvb-frontends/cxd2841er.c:3873:3: warning: Call to function 'snprintf' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'snprintf_s' in case of C11 [clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling]
                   snprintf(cxd2841er_t_c_ops.info.name, 128,
                   ^~~~~~~~
   drivers/media/dvb-frontends/cxd2841er.c:3873:3: note: Call to function 'snprintf' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'snprintf_s' in case of C11
                   snprintf(cxd2841er_t_c_ops.info.name, 128,
                   ^~~~~~~~
   drivers/media/dvb-frontends/cxd2841er.c:3882:3: warning: Call to function 'snprintf' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'snprintf_s' in case of C11 [clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling]
                   snprintf(cxd2841er_t_c_ops.info.name, 128,
                   ^~~~~~~~
   drivers/media/dvb-frontends/cxd2841er.c:3882:3: note: Call to function 'snprintf' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'snprintf_s' in case of C11
                   snprintf(cxd2841er_t_c_ops.info.name, 128,
                   ^~~~~~~~
--
           ^
   drivers/media/i2c/ov5693.c:1404:6: note: Assuming 'ret' is 0
           if (ret)
               ^~~
   drivers/media/i2c/ov5693.c:1404:2: note: Taking false branch
           if (ret)
           ^
   drivers/media/i2c/ov5693.c:1407:2: note: Loop condition is false.  Exiting loop
           mutex_init(&ov5693->lock);
           ^
   include/linux/mutex.h:101:32: note: expanded from macro 'mutex_init'
   #define mutex_init(mutex)                                               \
                                                                           ^
   drivers/media/i2c/ov5693.c:1412:2: note: Taking false branch
           if (IS_ERR(ov5693->clk)) {
           ^
   drivers/media/i2c/ov5693.c:1418:6: note: Assuming 'clk_rate' is equal to OV5693_XVCLK_FREQ
           if (clk_rate != OV5693_XVCLK_FREQ)
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/i2c/ov5693.c:1418:2: note: Taking false branch
           if (clk_rate != OV5693_XVCLK_FREQ)
           ^
   drivers/media/i2c/ov5693.c:1423:6: note: 'ret' is 0
           if (ret)
               ^~~
   drivers/media/i2c/ov5693.c:1423:2: note: Taking false branch
           if (ret)
           ^
   drivers/media/i2c/ov5693.c:1427:6: note: Assuming 'ret' is 0
           if (ret)
               ^~~
   drivers/media/i2c/ov5693.c:1427:2: note: Taking false branch
           if (ret)
           ^
   drivers/media/i2c/ov5693.c:1440:6: note: 'ret' is 0
           if (ret)
               ^~~
   drivers/media/i2c/ov5693.c:1440:2: note: Taking false branch
           if (ret)
           ^
   drivers/media/i2c/ov5693.c:1444:6: note: Assuming 'ret' is 0
           if (ret)
               ^~~
   drivers/media/i2c/ov5693.c:1444:2: note: Taking false branch
           if (ret)
           ^
   drivers/media/i2c/ov5693.c:1455:6: note: 'ret' is 0
           if (ret)
               ^~~
   drivers/media/i2c/ov5693.c:1455:2: note: Taking false branch
           if (ret)
           ^
   drivers/media/i2c/ov5693.c:1458:8: note: Calling 'ov5693_detect'
           ret = ov5693_detect(ov5693);
                 ^~~~~~~~~~~~~~~~~~~~~
   drivers/media/i2c/ov5693.c:871:2: note: 'id' declared without an initial value
           u32 id;
           ^~~~~~
   drivers/media/i2c/ov5693.c:873:8: note: Calling 'ov5693_read_reg'
           ret = ov5693_read_reg(ov5693, OV5693_REG_CHIP_ID, &id);
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/i2c/ov5693.c:399:8: note: '?' condition is false
           reg = cpu_to_be16(addr & OV5693_REG_ADDR_MASK);
                 ^
   include/linux/byteorder/generic.h:96:21: note: expanded from macro 'cpu_to_be16'
   #define cpu_to_be16 __cpu_to_be16
                       ^
   include/uapi/linux/byteorder/little_endian.h:42:43: note: expanded from macro '__cpu_to_be16'
   #define __cpu_to_be16(x) ((__force __be16)__swab16((x)))
                                             ^
   include/uapi/linux/swab.h:105:3: note: expanded from macro '__swab16'
           (__builtin_constant_p((__u16)(x)) ?     \
            ^
   drivers/media/i2c/ov5693.c:404:6: note: Assuming 'ret' is < 0
           if (ret < 0)
               ^~~~~~~
   drivers/media/i2c/ov5693.c:404:2: note: Taking true branch
           if (ret < 0)
           ^
   drivers/media/i2c/ov5693.c:405:3: note: Returning without writing to '*value'
                   return dev_err_probe(&client->dev, ret,
                   ^
   drivers/media/i2c/ov5693.c:405:3: note: Returning value, which participates in a condition later
                   return dev_err_probe(&client->dev, ret,
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/i2c/ov5693.c:873:8: note: Returning from 'ov5693_read_reg'
           ret = ov5693_read_reg(ov5693, OV5693_REG_CHIP_ID, &id);
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/i2c/ov5693.c:874:6: note: Assuming 'ret' is 0
           if (ret)
               ^~~
   drivers/media/i2c/ov5693.c:874:2: note: Taking false branch
           if (ret)
           ^
   drivers/media/i2c/ov5693.c:877:9: note: The left operand of '!=' is a garbage value
           if (id != OV5693_CHIP_ID)
               ~~ ^
   Suppressed 53 warnings (53 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   43 warnings generated.
>> drivers/input/keyboard/mt_matrix_keypad.c:297:35: warning: Division by zero [clang-analyzer-core.DivideZero]
                           pdata, (int)(pdata->scan_phase % pdata->num_line_gpios),
                                                          ^
   drivers/input/keyboard/mt_matrix_keypad.c:346:6: note: Assuming field 'stopped' is equal to false
           if (keypad->stopped == false) {
               ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/input/keyboard/mt_matrix_keypad.c:346:2: note: Taking true branch
           if (keypad->stopped == false) {
           ^
   drivers/input/keyboard/mt_matrix_keypad.c:347:3: note: Calling 'update_buttons'
                   update_buttons(pdata, input_dev);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/input/keyboard/mt_matrix_keypad.c:222:6: note: Assuming field 'scan_phase' is not equal to field 'phase_prepare'
           if (pdata->scan_phase == pdata->phase_state.phase_prepare) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/input/keyboard/mt_matrix_keypad.c:222:2: note: Taking false branch
           if (pdata->scan_phase == pdata->phase_state.phase_prepare) {
           ^
   drivers/input/keyboard/mt_matrix_keypad.c:225:13: note: Assuming field 'scan_phase' is not equal to field 'phase_update_button'
           } else if (pdata->scan_phase ==
                      ^~~~~~~~~~~~~~~~~~~~
   drivers/input/keyboard/mt_matrix_keypad.c:225:9: note: Taking false branch
           } else if (pdata->scan_phase ==
                  ^
   drivers/input/keyboard/mt_matrix_keypad.c:266:15: note: Assuming 'i' is >= field 'num_line_gpios'
                   for (i = 0; i < pdata->num_line_gpios; i++) {
                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/input/keyboard/mt_matrix_keypad.c:266:3: note: Loop condition is false. Execution continues on line 277
                   for (i = 0; i < pdata->num_line_gpios; i++) {
                   ^
   drivers/input/keyboard/mt_matrix_keypad.c:277:7: note: 'number_of_buttons_pressed' is < 2
                   if (number_of_buttons_pressed < 2) {
                       ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/input/keyboard/mt_matrix_keypad.c:277:3: note: Taking true branch
                   if (number_of_buttons_pressed < 2) {
                   ^
   drivers/input/keyboard/mt_matrix_keypad.c:278:4: note: Loop condition is false. Execution continues on line 293
                           for (i = 0; i < pdata->num_line_gpios; i++) {
                           ^
   drivers/input/keyboard/mt_matrix_keypad.c:297:35: note: Division by zero
                           pdata, (int)(pdata->scan_phase % pdata->num_line_gpios),
                                        ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/input/keyboard/mt_matrix_keypad.c:488:2: warning: Value stored to 'i' is never read [clang-analyzer-deadcode.DeadStores]
           i = pdata->num_line_gpios;
           ^   ~~~~~~~~~~~~~~~~~~~~~
   drivers/input/keyboard/mt_matrix_keypad.c:488:2: note: Value stored to 'i' is never read
           i = pdata->num_line_gpios;
           ^   ~~~~~~~~~~~~~~~~~~~~~
   Suppressed 41 warnings (40 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   40 warnings generated.
   Suppressed 40 warnings (40 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   52 warnings generated.
   Suppressed 52 warnings (52 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   37 warnings generated.
   drivers/leds/uleds.c:150:4: warning: Value stored to 'retval' is never read [clang-analyzer-deadcode.DeadStores]
                           retval = copy_to_user(buffer, &udev->brightness,
                           ^        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/leds/uleds.c:150:4: note: Value stored to 'retval' is never read
                           retval = copy_to_user(buffer, &udev->brightness,
                           ^        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   Suppressed 36 warnings (36 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   53 warnings generated.
   drivers/firmware/google/framebuffer-coreboot.c:54:2: warning: Call to function 'memset' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'memset_s' in case of C11 [clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling]
           memset(&res, 0, sizeof(res));
           ^
   include/linux/fortify-string.h:272:25: note: expanded from macro 'memset'
   #define memset(p, c, s) __fortify_memset_chk(p, c, s,                   \
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:265:2: note: expanded from macro '__fortify_memset_chk'
           __underlying_memset(p, c, __fortify_size);                      \
           ^~~~~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:47:29: note: expanded from macro '__underlying_memset'
   #define __underlying_memset     __builtin_memset
                                   ^~~~~~~~~~~~~~~~
   drivers/firmware/google/framebuffer-coreboot.c:54:2: note: Call to function 'memset' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'memset_s' in case of C11
           memset(&res, 0, sizeof(res));
           ^
   include/linux/fortify-string.h:272:25: note: expanded from macro 'memset'
   #define memset(p, c, s) __fortify_memset_chk(p, c, s,                   \
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:265:2: note: expanded from macro '__fortify_memset_chk'
           __underlying_memset(p, c, __fortify_size);                      \
           ^~~~~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:47:29: note: expanded from macro '__underlying_memset'
   #define __underlying_memset     __builtin_memset
                                   ^~~~~~~~~~~~~~~~
   Suppressed 52 warnings (52 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   86 warnings generated.
   Suppressed 86 warnings (86 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   80 warnings generated.
   Suppressed 80 warnings (80 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   95 warnings generated.
   include/linux/etherdevice.h:128:2: warning: Assigned value is garbage or undefined [clang-analyzer-core.uninitialized.Assign]
           u16 a = *(const u16 *)addr;
           ^
   net/llc/llc_sap.c:425:2: note: Calling 'llc_pdu_decode_da'
           llc_pdu_decode_da(skb, laddr.mac);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/net/llc_pdu.h:278:23: note: '?' condition is true
           if (skb->protocol == htons(ETH_P_802_2))
                                ^
   include/linux/byteorder/generic.h:141:18: note: expanded from macro 'htons'
   #define htons(x) ___htons(x)
                    ^
   include/linux/byteorder/generic.h:135:21: note: expanded from macro '___htons'
   #define ___htons(x) __cpu_to_be16(x)
                       ^
   include/uapi/linux/byteorder/little_endian.h:42:43: note: expanded from macro '__cpu_to_be16'
   #define __cpu_to_be16(x) ((__force __be16)__swab16((x)))
                                             ^
   include/uapi/linux/swab.h:105:3: note: expanded from macro '__swab16'
           (__builtin_constant_p((__u16)(x)) ?     \
            ^
   include/net/llc_pdu.h:278:6: note: Assuming the condition is false
           if (skb->protocol == htons(ETH_P_802_2))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/net/llc_pdu.h:278:2: note: Taking false branch
           if (skb->protocol == htons(ETH_P_802_2))
           ^
   net/llc/llc_sap.c:425:2: note: Returning from 'llc_pdu_decode_da'
           llc_pdu_decode_da(skb, laddr.mac);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/llc/llc_sap.c:428:6: note: Calling 'is_multicast_ether_addr'
           if (is_multicast_ether_addr(laddr.mac)) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/etherdevice.h:128:2: note: Assigned value is garbage or undefined
           u16 a = *(const u16 *)addr;
           ^       ~~~~~~~~~~~~~~~~~~
   net/llc/llc_sap.c:77:2: warning: Call to function 'memset' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'memset_s' in case of C11 [clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling]
           memset(addr, 0, sizeof(*addr));
           ^
   include/linux/fortify-string.h:272:25: note: expanded from macro 'memset'
   #define memset(p, c, s) __fortify_memset_chk(p, c, s,                   \
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:265:2: note: expanded from macro '__fortify_memset_chk'
           __underlying_memset(p, c, __fortify_size);                      \

vim +/any_btn_served +200 drivers/input/keyboard/mt_matrix_keypad.c

   195	
   196	void process_button_events(const struct mt_matrix_keypad_platform_data *pdata,
   197				   struct input_dev *input_dev)
   198	{
   199		int btn_index;
 > 200		bool any_btn_served = false;
   201	
   202		for (btn_index = 0; btn_index < pdata->num_of_buttons; btn_index++) {
   203			const union typeEvent beEvent =
   204				get_and_clear_btn_events(pdata, (int)btn_index);
   205	
   206			if (beEvent.status.boGlobalChanged) {
   207				const struct button_states bsState =
   208					get_btn_id_state(pdata, (int)btn_index);
   209	
   210				if (bsState.boEnabled) {
   211					any_btn_served |=
   212						on_button_event(pdata, (int)btn_index,
   213								beEvent, input_dev);
   214				}
   215			}
   216		}
   217	}
   218	
   219	void update_buttons(struct mt_matrix_keypad_platform_data *pdata,
   220			    struct input_dev *input_dev)
   221	{
   222		if (pdata->scan_phase == pdata->phase_state.phase_prepare) {
   223			pdata->scan_phase = pdata->phase_state.phase_start;
   224			activate_line_driving(pdata, (int)pdata->scan_phase, true);
   225		} else if (pdata->scan_phase ==
   226			   pdata->phase_state.phase_update_button) {
   227			bool btn_changes_occured = false;
   228			int btn_index;
   229	
   230			if (pdata->intialize_buttons) {
   231				int i;
   232	
   233				pdata->intialize_buttons = false;
   234	
   235				for (i = 0; i < pdata->num_of_buttons; i++) {
   236					const bool btn_curr_hw_state =
   237						get_button_state(
   238							&pdata->button_array[i])
   239							.boCurrentStateOfHw;
   240					button_init(&pdata->button_array[i],
   241						    btn_curr_hw_state,
   242						    pdata->button_array[i].key);
   243				}
   244			}
   245	
   246			for (btn_index = 0; btn_index < pdata->num_of_buttons;
   247			     btn_index++) {
   248				btn_changes_occured |= check_button_changes(
   249					&pdata->button_array[btn_index]);
   250			}
   251	
   252			if (btn_changes_occured)
   253				process_button_events(pdata, input_dev);
   254	
   255			pdata->scan_phase = pdata->phase_state.phase_start;
   256		} else {
   257			uint8_t *btn_keylines;
   258			uint8_t number_of_buttons_pressed = 0;
   259			uint8_t btn_index;
   260			uint8_t btn_key;
   261			uint16_t index;
   262			int i;
   263	
   264			btn_keylines = kcalloc(pdata->num_line_gpios, sizeof(uint8_t),
   265					       GFP_KERNEL);
   266			for (i = 0; i < pdata->num_line_gpios; i++) {
   267				index = (pdata->scan_phase * pdata->num_line_gpios) + i;
   268				btn_key = pdata->button_matrix[index];
   269				btn_keylines[i] = false;
   270	
   271				if ((btn_key != pdata->button_matrix[0]) &&
   272				    (get_gpio_line_value(pdata, (int)i) != false)) {
   273					btn_keylines[i] = true;
   274					number_of_buttons_pressed++;
   275				}
   276			}
   277			if (number_of_buttons_pressed < 2) {
   278				for (i = 0; i < pdata->num_line_gpios; i++) {
   279					index = (pdata->scan_phase *
   280						 pdata->num_line_gpios) +
   281						i;
   282					btn_key = pdata->button_matrix[index];
   283					if (btn_key != pdata->button_matrix[0]) {
   284						btn_index =
   285							get_btn_index(pdata, btn_key);
   286						set_btn_state_by_hw(
   287							&pdata->button_array[btn_index],
   288							btn_keylines[i]);
   289					}
   290				}
   291			}
   292	
   293			kfree(btn_keylines);
   294			activate_line_driving(pdata, (int)pdata->scan_phase, false);
   295			pdata->scan_phase++;
   296			activate_line_driving(
 > 297				pdata, (int)(pdata->scan_phase % pdata->num_line_gpios),
   298				true);
   299		}
   300	}
   301	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
