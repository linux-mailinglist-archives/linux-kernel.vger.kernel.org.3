Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9B655D3E7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241885AbiF1ANR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 20:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242937AbiF1ANN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 20:13:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95D562C6;
        Mon, 27 Jun 2022 17:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656375192; x=1687911192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/m//RVJUk7ReNFOJ96tIb+azW6S2LNzlgtWV99yKPtc=;
  b=E0/D8cjxBud6WME5SDNWmlDbqC/VH5Q+Vr+4npY1zgtywRlsNZ3z4eTg
   lzOMv4+CtTMGbrLhVbjnay+tMfjCUH/i49ksyuyHGejRulClntluUGM+D
   +1j/4YNanlckjxVJaNrlxuaSP8s0PCnHKNcOIOmFkRPM5c1sPjQ1I/9Ov
   o4J4D6Uc+9csi3Tzpy+Gnp4V1ZAxjeNYmtCYclo64tsX3sTfvvwwu2qV6
   oo3QzowOcneyYHc80FeooFgzvB6lNBoVu8t25sZo4HuoMNVDZdsFMxVD4
   LTIfB9KUgdPwf3WFeOwsuWL4vRqh7MPvZNt9UoXmZojeCyAJlYjPYmY7E
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="367905684"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="367905684"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 17:13:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="590103893"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 27 Jun 2022 17:13:09 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5yqr-0009G8-6s;
        Tue, 28 Jun 2022 00:13:09 +0000
Date:   Tue, 28 Jun 2022 08:12:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-acpi@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v3 1/2] ACPI: utils: Add api to read _SUB from ACPI
Message-ID: <202206280813.F9ukvWAK-lkp@intel.com>
References: <20220627155138.807420-2-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627155138.807420-2-sbinding@opensource.cirrus.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on broonie-sound/for-next linus/master v5.19-rc4 next-20220627]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Stefan-Binding/Read-_SUB-from-ACPI-to-be-able-to-identify-firmware/20220627-235448
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: x86_64-rhel-8.3-syz (https://download.01.org/0day-ci/archive/20220628/202206280813.F9ukvWAK-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/7dd124b65442fd6622e7df2949795f735d8356be
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Stefan-Binding/Read-_SUB-from-ACPI-to-be-able-to-identify-firmware/20220627-235448
        git checkout 7dd124b65442fd6622e7df2949795f735d8356be
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/acpi/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/acpi/utils.c:17:
   drivers/acpi/utils.c: In function 'acpi_get_subsystem_id':
>> drivers/acpi/utils.c:317:49: warning: format '%d' expects argument of type 'int', but argument 4 has type '__kernel_size_t' {aka 'long unsigned int'} [-Wformat=]
     317 |                         acpi_handle_err(handle, "ACPI _SUB Length %d is Invalid\n",
         |                                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/acpi.h:1172:46: note: in definition of macro 'acpi_handle_err'
    1172 |         acpi_handle_printk(KERN_ERR, handle, fmt, ##__VA_ARGS__)
         |                                              ^~~
   drivers/acpi/utils.c:317:68: note: format string is defined here
     317 |                         acpi_handle_err(handle, "ACPI _SUB Length %d is Invalid\n",
         |                                                                   ~^
         |                                                                    |
         |                                                                    int
         |                                                                   %ld


vim +317 drivers/acpi/utils.c

   295	
   296	const char *acpi_get_subsystem_id(acpi_handle handle)
   297	{
   298		struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
   299		union acpi_object *obj;
   300		acpi_status status;
   301		const char *sub;
   302	
   303		status = acpi_evaluate_object(handle, METHOD_NAME__SUB, NULL, &buffer);
   304		if (ACPI_FAILURE(status)) {
   305			acpi_handle_debug(handle, "Reading ACPI _SUB failed: %#x\n", status);
   306			return ERR_PTR(-ENODATA);
   307		}
   308	
   309		obj = buffer.pointer;
   310		if (obj->type == ACPI_TYPE_STRING) {
   311			if (strlen(obj->string.pointer) < ACPI_MAX_SUB_BUF_SIZE &&
   312			    strlen(obj->string.pointer) > 0) {
   313				sub = kstrdup(obj->string.pointer, GFP_KERNEL);
   314				if (!sub)
   315					sub = ERR_PTR(-ENOMEM);
   316			} else {
 > 317				acpi_handle_err(handle, "ACPI _SUB Length %d is Invalid\n",
   318						strlen(obj->string.pointer));
   319				sub = ERR_PTR(-EINVAL);
   320			}
   321		} else {
   322			acpi_handle_warn(handle, "Warning ACPI _SUB did not return a string\n");
   323			sub = ERR_PTR(-EINVAL);
   324		}
   325	
   326		acpi_os_free(buffer.pointer);
   327	
   328		return sub;
   329	}
   330	EXPORT_SYMBOL_GPL(acpi_get_subsystem_id);
   331	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
