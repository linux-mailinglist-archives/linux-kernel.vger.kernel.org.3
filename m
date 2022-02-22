Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E924C0088
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbiBVRzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbiBVRzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:55:20 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BE3117980;
        Tue, 22 Feb 2022 09:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645552493; x=1677088493;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=izEU+wg5cwJi+Q8PlVhh5ydABwpxPQDdPZCk3XG544I=;
  b=JGt8v+bbTFBW98AuKOoeSH8iGWAVSQMAT3lh95DQPDgdKZB31D8F0SVG
   wfI/uHdUjNLXefZV5jzXmSYQMmXUPbjMUPIlJoFu/1AZOn/ejEclaztwy
   uf+nvksDyD9SL1RWmK6U6+VUx4wSG3ONvoPkqkPz4lHPPEUp11optaWfQ
   GwZjpTH2MEPPtndSpdqvzCbsMw07jmxPRJ2Q8nItcJC5c3GYQ87ooe5X0
   xbIkYqbtNXHFmtE2bHrJ1jeR+5Mel2wHK2uDwcWiJpsTgJJQSO7hyHiiw
   2Qw5DulAzAn1gtTZKSfc7OBPS/DP3EndF0Yc6FDv8jwHhrVUfHx9WMqvU
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="232392628"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="232392628"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 09:54:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="683601779"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Feb 2022 09:54:48 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMZN9-0000TM-TV; Tue, 22 Feb 2022 17:54:47 +0000
Date:   Wed, 23 Feb 2022 01:54:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v8 5/7] pinctrl: qcom: Extract chip specific LPASS LPI
 code
Message-ID: <202202230101.Hp9mOcMc-lkp@intel.com>
References: <1645455554-22370-6-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645455554-22370-6-git-send-email-quic_srivasam@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivasa,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linusw-pinctrl/devel]
[also build test ERROR on v5.17-rc5 next-20220217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Srinivasa-Rao-Mandadapu/Add-pin-control-support-for-lpass-sc7280/20220221-230159
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20220223/202202230101.Hp9mOcMc-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/c6ece609364ddb2a9488aa461bfb3d082171241a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Srinivasa-Rao-Mandadapu/Add-pin-control-support-for-lpass-sc7280/20220221-230159
        git checkout c6ece609364ddb2a9488aa461bfb3d082171241a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:12:
>> drivers/pinctrl/qcom/../core.h:42:8: error: redefinition of 'struct pinctrl_dev'
      42 | struct pinctrl_dev {
         |        ^~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-lpass-lpi.h:11,
                    from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:11:
   drivers/pinctrl/qcom/../core.h:42:8: note: originally defined here
      42 | struct pinctrl_dev {
         |        ^~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:12:
>> drivers/pinctrl/qcom/../core.h:77:8: error: redefinition of 'struct pinctrl'
      77 | struct pinctrl {
         |        ^~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-lpass-lpi.h:11,
                    from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:11:
   drivers/pinctrl/qcom/../core.h:77:8: note: originally defined here
      77 | struct pinctrl {
         |        ^~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:12:
>> drivers/pinctrl/qcom/../core.h:92:8: error: redefinition of 'struct pinctrl_state'
      92 | struct pinctrl_state {
         |        ^~~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-lpass-lpi.h:11,
                    from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:11:
   drivers/pinctrl/qcom/../core.h:92:8: note: originally defined here
      92 | struct pinctrl_state {
         |        ^~~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:12:
>> drivers/pinctrl/qcom/../core.h:103:8: error: redefinition of 'struct pinctrl_setting_mux'
     103 | struct pinctrl_setting_mux {
         |        ^~~~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-lpass-lpi.h:11,
                    from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:11:
   drivers/pinctrl/qcom/../core.h:103:8: note: originally defined here
     103 | struct pinctrl_setting_mux {
         |        ^~~~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:12:
>> drivers/pinctrl/qcom/../core.h:116:8: error: redefinition of 'struct pinctrl_setting_configs'
     116 | struct pinctrl_setting_configs {
         |        ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-lpass-lpi.h:11,
                    from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:11:
   drivers/pinctrl/qcom/../core.h:116:8: note: originally defined here
     116 | struct pinctrl_setting_configs {
         |        ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:12:
>> drivers/pinctrl/qcom/../core.h:131:8: error: redefinition of 'struct pinctrl_setting'
     131 | struct pinctrl_setting {
         |        ^~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-lpass-lpi.h:11,
                    from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:11:
   drivers/pinctrl/qcom/../core.h:131:8: note: originally defined here
     131 | struct pinctrl_setting {
         |        ^~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:12:
>> drivers/pinctrl/qcom/../core.h:159:8: error: redefinition of 'struct pin_desc'
     159 | struct pin_desc {
         |        ^~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-lpass-lpi.h:11,
                    from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:11:
   drivers/pinctrl/qcom/../core.h:159:8: note: originally defined here
     159 | struct pin_desc {
         |        ^~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:12:
>> drivers/pinctrl/qcom/../core.h:179:8: error: redefinition of 'struct pinctrl_maps'
     179 | struct pinctrl_maps {
         |        ^~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-lpass-lpi.h:11,
                    from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:11:
   drivers/pinctrl/qcom/../core.h:179:8: note: originally defined here
     179 | struct pinctrl_maps {
         |        ^~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:12:
>> drivers/pinctrl/qcom/../core.h:194:8: error: redefinition of 'struct group_desc'
     194 | struct group_desc {
         |        ^~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-lpass-lpi.h:11,
                    from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:11:
   drivers/pinctrl/qcom/../core.h:194:8: note: originally defined here
     194 | struct group_desc {
         |        ^~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:12:
>> drivers/pinctrl/qcom/../core.h:201:5: error: conflicting types for 'pinctrl_generic_get_group_count'; have 'int(struct pinctrl_dev *)'
     201 | int pinctrl_generic_get_group_count(struct pinctrl_dev *pctldev);
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-lpass-lpi.h:11,
                    from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:11:
   drivers/pinctrl/qcom/../core.h:201:5: note: previous declaration of 'pinctrl_generic_get_group_count' with type 'int(struct pinctrl_dev *)'
     201 | int pinctrl_generic_get_group_count(struct pinctrl_dev *pctldev);
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:12:
>> drivers/pinctrl/qcom/../core.h:203:13: error: conflicting types for 'pinctrl_generic_get_group_name'; have 'const char *(struct pinctrl_dev *, unsigned int)'
     203 | const char *pinctrl_generic_get_group_name(struct pinctrl_dev *pctldev,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-lpass-lpi.h:11,
                    from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:11:
   drivers/pinctrl/qcom/../core.h:203:13: note: previous declaration of 'pinctrl_generic_get_group_name' with type 'const char *(struct pinctrl_dev *, unsigned int)'
     203 | const char *pinctrl_generic_get_group_name(struct pinctrl_dev *pctldev,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:12:
>> drivers/pinctrl/qcom/../core.h:206:5: error: conflicting types for 'pinctrl_generic_get_group_pins'; have 'int(struct pinctrl_dev *, unsigned int,  const unsigned int **, unsigned int *)'
     206 | int pinctrl_generic_get_group_pins(struct pinctrl_dev *pctldev,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-lpass-lpi.h:11,
                    from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:11:
   drivers/pinctrl/qcom/../core.h:206:5: note: previous declaration of 'pinctrl_generic_get_group_pins' with type 'int(struct pinctrl_dev *, unsigned int,  const unsigned int **, unsigned int *)'
     206 | int pinctrl_generic_get_group_pins(struct pinctrl_dev *pctldev,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:12:
>> drivers/pinctrl/qcom/../core.h:211:20: error: conflicting types for 'pinctrl_generic_get_group'; have 'struct group_desc *(struct pinctrl_dev *, unsigned int)'
     211 | struct group_desc *pinctrl_generic_get_group(struct pinctrl_dev *pctldev,
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-lpass-lpi.h:11,
                    from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:11:
   drivers/pinctrl/qcom/../core.h:211:20: note: previous declaration of 'pinctrl_generic_get_group' with type 'struct group_desc *(struct pinctrl_dev *, unsigned int)'
     211 | struct group_desc *pinctrl_generic_get_group(struct pinctrl_dev *pctldev,
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:12:
>> drivers/pinctrl/qcom/../core.h:214:5: error: conflicting types for 'pinctrl_generic_add_group'; have 'int(struct pinctrl_dev *, const char *, int *, int,  void *)'
     214 | int pinctrl_generic_add_group(struct pinctrl_dev *pctldev, const char *name,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-lpass-lpi.h:11,
                    from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:11:
   drivers/pinctrl/qcom/../core.h:214:5: note: previous declaration of 'pinctrl_generic_add_group' with type 'int(struct pinctrl_dev *, const char *, int *, int,  void *)'
     214 | int pinctrl_generic_add_group(struct pinctrl_dev *pctldev, const char *name,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:12:
>> drivers/pinctrl/qcom/../core.h:217:5: error: conflicting types for 'pinctrl_generic_remove_group'; have 'int(struct pinctrl_dev *, unsigned int)'
     217 | int pinctrl_generic_remove_group(struct pinctrl_dev *pctldev,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-lpass-lpi.h:11,
                    from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:11:
   drivers/pinctrl/qcom/../core.h:217:5: note: previous declaration of 'pinctrl_generic_remove_group' with type 'int(struct pinctrl_dev *, unsigned int)'
     217 | int pinctrl_generic_remove_group(struct pinctrl_dev *pctldev,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:12:
>> drivers/pinctrl/qcom/../core.h:222:21: error: conflicting types for 'get_pinctrl_dev_from_devname'; have 'struct pinctrl_dev *(const char *)'
     222 | struct pinctrl_dev *get_pinctrl_dev_from_devname(const char *dev_name);
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-lpass-lpi.h:11,
                    from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:11:
   drivers/pinctrl/qcom/../core.h:222:21: note: previous declaration of 'get_pinctrl_dev_from_devname' with type 'struct pinctrl_dev *(const char *)'
     222 | struct pinctrl_dev *get_pinctrl_dev_from_devname(const char *dev_name);
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:12:
>> drivers/pinctrl/qcom/../core.h:223:21: error: conflicting types for 'get_pinctrl_dev_from_of_node'; have 'struct pinctrl_dev *(struct device_node *)'
     223 | struct pinctrl_dev *get_pinctrl_dev_from_of_node(struct device_node *np);
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-lpass-lpi.h:11,
                    from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:11:
   drivers/pinctrl/qcom/../core.h:223:21: note: previous declaration of 'get_pinctrl_dev_from_of_node' with type 'struct pinctrl_dev *(struct device_node *)'
     223 | struct pinctrl_dev *get_pinctrl_dev_from_of_node(struct device_node *np);
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:12:
>> drivers/pinctrl/qcom/../core.h:224:5: error: conflicting types for 'pin_get_from_name'; have 'int(struct pinctrl_dev *, const char *)'
     224 | int pin_get_from_name(struct pinctrl_dev *pctldev, const char *name);
         |     ^~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-lpass-lpi.h:11,
                    from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:11:
   drivers/pinctrl/qcom/../core.h:224:5: note: previous declaration of 'pin_get_from_name' with type 'int(struct pinctrl_dev *, const char *)'
     224 | int pin_get_from_name(struct pinctrl_dev *pctldev, const char *name);
         |     ^~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:12:
>> drivers/pinctrl/qcom/../core.h:225:13: error: conflicting types for 'pin_get_name'; have 'const char *(struct pinctrl_dev *, const unsigned int)'
     225 | const char *pin_get_name(struct pinctrl_dev *pctldev, const unsigned pin);
         |             ^~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-lpass-lpi.h:11,
                    from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:11:
   drivers/pinctrl/qcom/../core.h:225:13: note: previous declaration of 'pin_get_name' with type 'const char *(struct pinctrl_dev *, const unsigned int)'
     225 | const char *pin_get_name(struct pinctrl_dev *pctldev, const unsigned pin);
         |             ^~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:12:
>> drivers/pinctrl/qcom/../core.h:226:5: error: conflicting types for 'pinctrl_get_group_selector'; have 'int(struct pinctrl_dev *, const char *)'
     226 | int pinctrl_get_group_selector(struct pinctrl_dev *pctldev,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-lpass-lpi.h:11,
                    from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:11:
   drivers/pinctrl/qcom/../core.h:226:5: note: previous declaration of 'pinctrl_get_group_selector' with type 'int(struct pinctrl_dev *, const char *)'
     226 | int pinctrl_get_group_selector(struct pinctrl_dev *pctldev,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:12:
   drivers/pinctrl/qcom/../core.h:229:32: error: conflicting types for 'pin_desc_get'; have 'struct pin_desc *(struct pinctrl_dev *, unsigned int)'
     229 | static inline struct pin_desc *pin_desc_get(struct pinctrl_dev *pctldev,
         |                                ^~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-lpass-lpi.h:11,
                    from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:11:
   drivers/pinctrl/qcom/../core.h:229:32: note: previous definition of 'pin_desc_get' with type 'struct pin_desc *(struct pinctrl_dev *, unsigned int)'
     229 | static inline struct pin_desc *pin_desc_get(struct pinctrl_dev *pctldev,
         |                                ^~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:12:
   drivers/pinctrl/qcom/../core.h:236:1: error: conflicting types for 'pinctrl_find_gpio_range_from_pin_nolock'; have 'struct pinctrl_gpio_range *(struct pinctrl_dev *, unsigned int)'
     236 | pinctrl_find_gpio_range_from_pin_nolock(struct pinctrl_dev *pctldev,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-lpass-lpi.h:11,
                    from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:11:
   drivers/pinctrl/qcom/../core.h:236:1: note: previous declaration of 'pinctrl_find_gpio_range_from_pin_nolock' with type 'struct pinctrl_gpio_range *(struct pinctrl_dev *, unsigned int)'
     236 | pinctrl_find_gpio_range_from_pin_nolock(struct pinctrl_dev *pctldev,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:12:
   drivers/pinctrl/qcom/../core.h:239:12: error: conflicting types for 'pinctrl_force_sleep'; have 'int(struct pinctrl_dev *)'
     239 | extern int pinctrl_force_sleep(struct pinctrl_dev *pctldev);
         |            ^~~~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-lpass-lpi.h:11,
                    from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:11:
   drivers/pinctrl/qcom/../core.h:239:12: note: previous declaration of 'pinctrl_force_sleep' with type 'int(struct pinctrl_dev *)'
     239 | extern int pinctrl_force_sleep(struct pinctrl_dev *pctldev);
         |            ^~~~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:12:
   drivers/pinctrl/qcom/../core.h:240:12: error: conflicting types for 'pinctrl_force_default'; have 'int(struct pinctrl_dev *)'
     240 | extern int pinctrl_force_default(struct pinctrl_dev *pctldev);
         |            ^~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/qcom/pinctrl-lpass-lpi.h:11,
                    from drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c:11:
   drivers/pinctrl/qcom/../core.h:240:12: note: previous declaration of 'pinctrl_force_default' with type 'int(struct pinctrl_dev *)'
     240 | extern int pinctrl_force_default(struct pinctrl_dev *pctldev);
         |            ^~~~~~~~~~~~~~~~~~~~~


vim +42 drivers/pinctrl/qcom/../core.h

ae6b4d8588f4fc Linus Walleij    2011-10-19   18  
2744e8afb3b763 Linus Walleij    2011-05-02   19  /**
2744e8afb3b763 Linus Walleij    2011-05-02   20   * struct pinctrl_dev - pin control class device
2744e8afb3b763 Linus Walleij    2011-05-02   21   * @node: node to include this pin controller in the global pin controller list
2744e8afb3b763 Linus Walleij    2011-05-02   22   * @desc: the pin controller descriptor supplied when initializing this pin
2744e8afb3b763 Linus Walleij    2011-05-02   23   *	controller
2744e8afb3b763 Linus Walleij    2011-05-02   24   * @pin_desc_tree: each pin descriptor for this pin controller is stored in
2744e8afb3b763 Linus Walleij    2011-05-02   25   *	this radix tree
c7059c5ac70aea Tony Lindgren    2016-12-27   26   * @pin_group_tree: optionally each pin group can be stored in this radix tree
c7059c5ac70aea Tony Lindgren    2016-12-27   27   * @num_groups: optionally number of groups can be kept here
a76edc89b100e4 Tony Lindgren    2016-12-27   28   * @pin_function_tree: optionally each function can be stored in this radix tree
a76edc89b100e4 Tony Lindgren    2016-12-27   29   * @num_functions: optionally number of functions can be kept here
2744e8afb3b763 Linus Walleij    2011-05-02   30   * @gpio_ranges: a list of GPIO ranges that is handled by this pin controller,
2744e8afb3b763 Linus Walleij    2011-05-02   31   *	ranges are added to this list at runtime
2744e8afb3b763 Linus Walleij    2011-05-02   32   * @dev: the device entry for this pin controller
2744e8afb3b763 Linus Walleij    2011-05-02   33   * @owner: module providing the pin controller, used for refcounting
2744e8afb3b763 Linus Walleij    2011-05-02   34   * @driver_data: driver data for drivers registering to the pin controller
2744e8afb3b763 Linus Walleij    2011-05-02   35   *	subsystem
46919ae63d4820 Stephen Warren   2012-03-01   36   * @p: result of pinctrl_get() for this device
840a47ba43a2ae Julien Delacou   2012-12-10   37   * @hog_default: default state for pins hogged by this device
840a47ba43a2ae Julien Delacou   2012-12-10   38   * @hog_sleep: sleep state for pins hogged by this device
42fed7ba44e4e8 Patrice Chotard  2013-04-11   39   * @mutex: mutex taken on each pin controller specific action
befe5bdfbb698b Linus Walleij    2012-02-09   40   * @device_root: debugfs root for this device
2744e8afb3b763 Linus Walleij    2011-05-02   41   */
2744e8afb3b763 Linus Walleij    2011-05-02  @42  struct pinctrl_dev {
2744e8afb3b763 Linus Walleij    2011-05-02   43  	struct list_head node;
2744e8afb3b763 Linus Walleij    2011-05-02   44  	struct pinctrl_desc *desc;
2744e8afb3b763 Linus Walleij    2011-05-02   45  	struct radix_tree_root pin_desc_tree;
c033a718f615b6 Linus Walleij    2016-12-30   46  #ifdef CONFIG_GENERIC_PINCTRL_GROUPS
c7059c5ac70aea Tony Lindgren    2016-12-27   47  	struct radix_tree_root pin_group_tree;
c7059c5ac70aea Tony Lindgren    2016-12-27   48  	unsigned int num_groups;
a76edc89b100e4 Tony Lindgren    2016-12-27   49  #endif
a76edc89b100e4 Tony Lindgren    2016-12-27   50  #ifdef CONFIG_GENERIC_PINMUX_FUNCTIONS
a76edc89b100e4 Tony Lindgren    2016-12-27   51  	struct radix_tree_root pin_function_tree;
a76edc89b100e4 Tony Lindgren    2016-12-27   52  	unsigned int num_functions;
c033a718f615b6 Linus Walleij    2016-12-30   53  #endif
2744e8afb3b763 Linus Walleij    2011-05-02   54  	struct list_head gpio_ranges;
51cd24ee625c34 Stephen Warren   2011-12-09   55  	struct device *dev;
2744e8afb3b763 Linus Walleij    2011-05-02   56  	struct module *owner;
2744e8afb3b763 Linus Walleij    2011-05-02   57  	void *driver_data;
46919ae63d4820 Stephen Warren   2012-03-01   58  	struct pinctrl *p;
840a47ba43a2ae Julien Delacou   2012-12-10   59  	struct pinctrl_state *hog_default;
840a47ba43a2ae Julien Delacou   2012-12-10   60  	struct pinctrl_state *hog_sleep;
42fed7ba44e4e8 Patrice Chotard  2013-04-11   61  	struct mutex mutex;
0215716083cac6 Tony Lindgren    2012-01-20   62  #ifdef CONFIG_DEBUG_FS
0215716083cac6 Tony Lindgren    2012-01-20   63  	struct dentry *device_root;
0215716083cac6 Tony Lindgren    2012-01-20   64  #endif
befe5bdfbb698b Linus Walleij    2012-02-09   65  };
befe5bdfbb698b Linus Walleij    2012-02-09   66  
befe5bdfbb698b Linus Walleij    2012-02-09   67  /**
befe5bdfbb698b Linus Walleij    2012-02-09   68   * struct pinctrl - per-device pin control state holder
befe5bdfbb698b Linus Walleij    2012-02-09   69   * @node: global list node
befe5bdfbb698b Linus Walleij    2012-02-09   70   * @dev: the device using this pin control handle
6e5e959dde0d92 Stephen Warren   2012-03-02   71   * @states: a list of states for this device
6e5e959dde0d92 Stephen Warren   2012-03-02   72   * @state: the current state
57291ce295c0ac Stephen Warren   2012-03-23   73   * @dt_maps: the mapping table chunks dynamically parsed from device tree for
57291ce295c0ac Stephen Warren   2012-03-23   74   *	this device, if any
ab78029ecc347d Linus Walleij    2013-01-22   75   * @users: reference count
befe5bdfbb698b Linus Walleij    2012-02-09   76   */
befe5bdfbb698b Linus Walleij    2012-02-09  @77  struct pinctrl {
befe5bdfbb698b Linus Walleij    2012-02-09   78  	struct list_head node;
befe5bdfbb698b Linus Walleij    2012-02-09   79  	struct device *dev;
6e5e959dde0d92 Stephen Warren   2012-03-02   80  	struct list_head states;
6e5e959dde0d92 Stephen Warren   2012-03-02   81  	struct pinctrl_state *state;
57291ce295c0ac Stephen Warren   2012-03-23   82  	struct list_head dt_maps;
ab78029ecc347d Linus Walleij    2013-01-22   83  	struct kref users;
6e5e959dde0d92 Stephen Warren   2012-03-02   84  };
6e5e959dde0d92 Stephen Warren   2012-03-02   85  
6e5e959dde0d92 Stephen Warren   2012-03-02   86  /**
6e5e959dde0d92 Stephen Warren   2012-03-02   87   * struct pinctrl_state - a pinctrl state for a device
2c9abf808a81e2 Richard Genoud   2013-03-25   88   * @node: list node for struct pinctrl's @states field
6e5e959dde0d92 Stephen Warren   2012-03-02   89   * @name: the name of this state
6e5e959dde0d92 Stephen Warren   2012-03-02   90   * @settings: a list of settings for this state
6e5e959dde0d92 Stephen Warren   2012-03-02   91   */
6e5e959dde0d92 Stephen Warren   2012-03-02  @92  struct pinctrl_state {
6e5e959dde0d92 Stephen Warren   2012-03-02   93  	struct list_head node;
6e5e959dde0d92 Stephen Warren   2012-03-02   94  	const char *name;
7ecdb16fe63e5b Stephen Warren   2012-03-02   95  	struct list_head settings;
7ecdb16fe63e5b Stephen Warren   2012-03-02   96  };
7ecdb16fe63e5b Stephen Warren   2012-03-02   97  
1e2082b5207217 Stephen Warren   2012-03-02   98  /**
1e2082b5207217 Stephen Warren   2012-03-02   99   * struct pinctrl_setting_mux - setting data for MAP_TYPE_MUX_GROUP
1e2082b5207217 Stephen Warren   2012-03-02  100   * @group: the group selector to program
1e2082b5207217 Stephen Warren   2012-03-02  101   * @func: the function selector to program
1e2082b5207217 Stephen Warren   2012-03-02  102   */
1e2082b5207217 Stephen Warren   2012-03-02 @103  struct pinctrl_setting_mux {
1e2082b5207217 Stephen Warren   2012-03-02  104  	unsigned group;
1e2082b5207217 Stephen Warren   2012-03-02  105  	unsigned func;
1e2082b5207217 Stephen Warren   2012-03-02  106  };
1e2082b5207217 Stephen Warren   2012-03-02  107  
1e2082b5207217 Stephen Warren   2012-03-02  108  /**
1e2082b5207217 Stephen Warren   2012-03-02  109   * struct pinctrl_setting_configs - setting data for MAP_TYPE_CONFIGS_*
1e2082b5207217 Stephen Warren   2012-03-02  110   * @group_or_pin: the group selector or pin ID to program
1e2082b5207217 Stephen Warren   2012-03-02  111   * @configs: a pointer to an array of config parameters/values to program into
1e2082b5207217 Stephen Warren   2012-03-02  112   *	hardware. Each individual pin controller defines the format and meaning
1e2082b5207217 Stephen Warren   2012-03-02  113   *	of config parameters.
1e2082b5207217 Stephen Warren   2012-03-02  114   * @num_configs: the number of entries in array @configs
1e2082b5207217 Stephen Warren   2012-03-02  115   */
1e2082b5207217 Stephen Warren   2012-03-02 @116  struct pinctrl_setting_configs {
1e2082b5207217 Stephen Warren   2012-03-02  117  	unsigned group_or_pin;
1e2082b5207217 Stephen Warren   2012-03-02  118  	unsigned long *configs;
1e2082b5207217 Stephen Warren   2012-03-02  119  	unsigned num_configs;
1e2082b5207217 Stephen Warren   2012-03-02  120  };
1e2082b5207217 Stephen Warren   2012-03-02  121  
7ecdb16fe63e5b Stephen Warren   2012-03-02  122  /**
872acc322c74bb Linus Walleij    2012-03-06  123   * struct pinctrl_setting - an individual mux or config setting
6e5e959dde0d92 Stephen Warren   2012-03-02  124   * @node: list node for struct pinctrl_settings's @settings field
1e2082b5207217 Stephen Warren   2012-03-02  125   * @type: the type of setting
57291ce295c0ac Stephen Warren   2012-03-23  126   * @pctldev: pin control device handling to be programmed. Not used for
57291ce295c0ac Stephen Warren   2012-03-23  127   *   PIN_MAP_TYPE_DUMMY_STATE.
1a78958dc212f3 Linus Walleij    2012-10-17  128   * @dev_name: the name of the device using this state
1e2082b5207217 Stephen Warren   2012-03-02  129   * @data: Data specific to the setting type
7ecdb16fe63e5b Stephen Warren   2012-03-02  130   */
7ecdb16fe63e5b Stephen Warren   2012-03-02 @131  struct pinctrl_setting {
7ecdb16fe63e5b Stephen Warren   2012-03-02  132  	struct list_head node;
1e2082b5207217 Stephen Warren   2012-03-02  133  	enum pinctrl_map_type type;
befe5bdfbb698b Linus Walleij    2012-02-09  134  	struct pinctrl_dev *pctldev;
1a78958dc212f3 Linus Walleij    2012-10-17  135  	const char *dev_name;
1e2082b5207217 Stephen Warren   2012-03-02  136  	union {
1e2082b5207217 Stephen Warren   2012-03-02  137  		struct pinctrl_setting_mux mux;
1e2082b5207217 Stephen Warren   2012-03-02  138  		struct pinctrl_setting_configs configs;
1e2082b5207217 Stephen Warren   2012-03-02  139  	} data;
2744e8afb3b763 Linus Walleij    2011-05-02  140  };
2744e8afb3b763 Linus Walleij    2011-05-02  141  
2744e8afb3b763 Linus Walleij    2011-05-02  142  /**
2744e8afb3b763 Linus Walleij    2011-05-02  143   * struct pin_desc - pin descriptor for each physical pin in the arch
2744e8afb3b763 Linus Walleij    2011-05-02  144   * @pctldev: corresponding pin control device
2744e8afb3b763 Linus Walleij    2011-05-02  145   * @name: a name for the pin, e.g. the name of the pin/pad/finger on a
2744e8afb3b763 Linus Walleij    2011-05-02  146   *	datasheet or such
ca53c5f1ca5c93 Linus Walleij    2011-12-14  147   * @dynamic_name: if the name of this pin was dynamically allocated
cd8f61f1e52b33 Masahiro Yamada  2016-05-25  148   * @drv_data: driver-defined per-pin data. pinctrl core does not touch this
652162d469a734 Stephen Warren   2012-03-05  149   * @mux_usecount: If zero, the pin is not claimed, and @owner should be NULL.
0e3db173e2b9fd Stephen Warren   2012-03-02  150   *	If non-zero, this pin is claimed by @owner. This field is an integer
0e3db173e2b9fd Stephen Warren   2012-03-02  151   *	rather than a boolean, since pinctrl_get() might process multiple
0e3db173e2b9fd Stephen Warren   2012-03-02  152   *	mapping table entries that refer to, and hence claim, the same group
0e3db173e2b9fd Stephen Warren   2012-03-02  153   *	or pin, and each of these will increment the @usecount.
652162d469a734 Stephen Warren   2012-03-05  154   * @mux_owner: The name of device that called pinctrl_get().
ba110d90c08d96 Stephen Warren   2012-03-02  155   * @mux_setting: The most recent selected mux setting for this pin, if any.
a9a1d2a7827c9c Linus Walleij    2017-09-22  156   * @gpio_owner: If pinctrl_gpio_request() was called for this pin, this is
652162d469a734 Stephen Warren   2012-03-05  157   *	the name of the GPIO that "owns" this pin.
2744e8afb3b763 Linus Walleij    2011-05-02  158   */
2744e8afb3b763 Linus Walleij    2011-05-02 @159  struct pin_desc {
2744e8afb3b763 Linus Walleij    2011-05-02  160  	struct pinctrl_dev *pctldev;
9af1e44fb4a4c6 Stephen Warren   2011-10-19  161  	const char *name;
ca53c5f1ca5c93 Linus Walleij    2011-12-14  162  	bool dynamic_name;
cd8f61f1e52b33 Masahiro Yamada  2016-05-25  163  	void *drv_data;
2744e8afb3b763 Linus Walleij    2011-05-02  164  	/* These fields only added when supporting pinmux drivers */
2744e8afb3b763 Linus Walleij    2011-05-02  165  #ifdef CONFIG_PINMUX
652162d469a734 Stephen Warren   2012-03-05  166  	unsigned mux_usecount;
652162d469a734 Stephen Warren   2012-03-05  167  	const char *mux_owner;
ba110d90c08d96 Stephen Warren   2012-03-02  168  	const struct pinctrl_setting_mux *mux_setting;
652162d469a734 Stephen Warren   2012-03-05  169  	const char *gpio_owner;
2744e8afb3b763 Linus Walleij    2011-05-02  170  #endif
2744e8afb3b763 Linus Walleij    2011-05-02  171  };
2744e8afb3b763 Linus Walleij    2011-05-02  172  
c033a718f615b6 Linus Walleij    2016-12-30  173  /**
c033a718f615b6 Linus Walleij    2016-12-30  174   * struct pinctrl_maps - a list item containing part of the mapping table
c033a718f615b6 Linus Walleij    2016-12-30  175   * @node: mapping table list node
c033a718f615b6 Linus Walleij    2016-12-30  176   * @maps: array of mapping table entries
c033a718f615b6 Linus Walleij    2016-12-30  177   * @num_maps: the number of entries in @maps
c033a718f615b6 Linus Walleij    2016-12-30  178   */
c033a718f615b6 Linus Walleij    2016-12-30 @179  struct pinctrl_maps {
c033a718f615b6 Linus Walleij    2016-12-30  180  	struct list_head node;
3f713b7c223ebe Masahiro Yamada  2017-08-04  181  	const struct pinctrl_map *maps;
c033a718f615b6 Linus Walleij    2016-12-30  182  	unsigned num_maps;
c033a718f615b6 Linus Walleij    2016-12-30  183  };
c033a718f615b6 Linus Walleij    2016-12-30  184  
c033a718f615b6 Linus Walleij    2016-12-30  185  #ifdef CONFIG_GENERIC_PINCTRL_GROUPS
c033a718f615b6 Linus Walleij    2016-12-30  186  
c7059c5ac70aea Tony Lindgren    2016-12-27  187  /**
c7059c5ac70aea Tony Lindgren    2016-12-27  188   * struct group_desc - generic pin group descriptor
c7059c5ac70aea Tony Lindgren    2016-12-27  189   * @name: name of the pin group
c7059c5ac70aea Tony Lindgren    2016-12-27  190   * @pins: array of pins that belong to the group
c7059c5ac70aea Tony Lindgren    2016-12-27  191   * @num_pins: number of pins in the group
c7059c5ac70aea Tony Lindgren    2016-12-27  192   * @data: pin controller driver specific data
c7059c5ac70aea Tony Lindgren    2016-12-27  193   */
c7059c5ac70aea Tony Lindgren    2016-12-27 @194  struct group_desc {
c7059c5ac70aea Tony Lindgren    2016-12-27  195  	const char *name;
c7059c5ac70aea Tony Lindgren    2016-12-27  196  	int *pins;
c7059c5ac70aea Tony Lindgren    2016-12-27  197  	int num_pins;
c7059c5ac70aea Tony Lindgren    2016-12-27  198  	void *data;
c7059c5ac70aea Tony Lindgren    2016-12-27  199  };
c7059c5ac70aea Tony Lindgren    2016-12-27  200  
c7059c5ac70aea Tony Lindgren    2016-12-27 @201  int pinctrl_generic_get_group_count(struct pinctrl_dev *pctldev);
c7059c5ac70aea Tony Lindgren    2016-12-27  202  
c7059c5ac70aea Tony Lindgren    2016-12-27 @203  const char *pinctrl_generic_get_group_name(struct pinctrl_dev *pctldev,
c7059c5ac70aea Tony Lindgren    2016-12-27  204  					   unsigned int group_selector);
c7059c5ac70aea Tony Lindgren    2016-12-27  205  
c7059c5ac70aea Tony Lindgren    2016-12-27 @206  int pinctrl_generic_get_group_pins(struct pinctrl_dev *pctldev,
c7059c5ac70aea Tony Lindgren    2016-12-27  207  				   unsigned int group_selector,
c7059c5ac70aea Tony Lindgren    2016-12-27  208  				   const unsigned int **pins,
c7059c5ac70aea Tony Lindgren    2016-12-27  209  				   unsigned int *npins);
c7059c5ac70aea Tony Lindgren    2016-12-27  210  
c7059c5ac70aea Tony Lindgren    2016-12-27 @211  struct group_desc *pinctrl_generic_get_group(struct pinctrl_dev *pctldev,
c7059c5ac70aea Tony Lindgren    2016-12-27  212  					     unsigned int group_selector);
c7059c5ac70aea Tony Lindgren    2016-12-27  213  
c7059c5ac70aea Tony Lindgren    2016-12-27 @214  int pinctrl_generic_add_group(struct pinctrl_dev *pctldev, const char *name,
c7059c5ac70aea Tony Lindgren    2016-12-27  215  			      int *gpins, int ngpins, void *data);
c7059c5ac70aea Tony Lindgren    2016-12-27  216  
c7059c5ac70aea Tony Lindgren    2016-12-27 @217  int pinctrl_generic_remove_group(struct pinctrl_dev *pctldev,
c7059c5ac70aea Tony Lindgren    2016-12-27  218  				 unsigned int group_selector);
c7059c5ac70aea Tony Lindgren    2016-12-27  219  
c033a718f615b6 Linus Walleij    2016-12-30  220  #endif	/* CONFIG_GENERIC_PINCTRL_GROUPS */
c7059c5ac70aea Tony Lindgren    2016-12-27  221  
9dfac4fd7f8cdc Linus Walleij    2012-02-01 @222  struct pinctrl_dev *get_pinctrl_dev_from_devname(const char *dev_name);
42fed7ba44e4e8 Patrice Chotard  2013-04-11 @223  struct pinctrl_dev *get_pinctrl_dev_from_of_node(struct device_node *np);
ae6b4d8588f4fc Linus Walleij    2011-10-19 @224  int pin_get_from_name(struct pinctrl_dev *pctldev, const char *name);
dcb5dbc305b975 Dong Aisheng     2012-04-17 @225  const char *pin_get_name(struct pinctrl_dev *pctldev, const unsigned pin);
7afde8baa83b9a Linus Walleij    2011-10-19 @226  int pinctrl_get_group_selector(struct pinctrl_dev *pctldev,
7afde8baa83b9a Linus Walleij    2011-10-19  227  			       const char *pin_group);
2304b4737f492b Stephen Warren   2012-02-22  228  
2304b4737f492b Stephen Warren   2012-02-22 @229  static inline struct pin_desc *pin_desc_get(struct pinctrl_dev *pctldev,
2304b4737f492b Stephen Warren   2012-02-22  230  					    unsigned int pin)
2304b4737f492b Stephen Warren   2012-02-22  231  {
2304b4737f492b Stephen Warren   2012-02-22  232  	return radix_tree_lookup(&pctldev->pin_desc_tree, pin);
2304b4737f492b Stephen Warren   2012-02-22  233  }
57b676f9c1b7cd Stephen Warren   2012-03-02  234  
b18537cd8ec2e5 Joachim Eastwood 2016-02-25  235  extern struct pinctrl_gpio_range *
b18537cd8ec2e5 Joachim Eastwood 2016-02-25 @236  pinctrl_find_gpio_range_from_pin_nolock(struct pinctrl_dev *pctldev,
b18537cd8ec2e5 Joachim Eastwood 2016-02-25  237  					unsigned int pin);
b18537cd8ec2e5 Joachim Eastwood 2016-02-25  238  
840a47ba43a2ae Julien Delacou   2012-12-10 @239  extern int pinctrl_force_sleep(struct pinctrl_dev *pctldev);
840a47ba43a2ae Julien Delacou   2012-12-10 @240  extern int pinctrl_force_default(struct pinctrl_dev *pctldev);
840a47ba43a2ae Julien Delacou   2012-12-10  241  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
