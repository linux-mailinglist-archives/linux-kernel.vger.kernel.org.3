Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2015ABC62
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 04:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiICChw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 22:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiICChp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 22:37:45 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7879CE97C6;
        Fri,  2 Sep 2022 19:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662172664; x=1693708664;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/6eakTPRvWZAQXwuGaXJrrTN0PFthLIXfd54tedauR0=;
  b=f/odPRf0ZHN2Q0Wcc4BPPaTbNIuMFPKbup5FygxibDPTkMxQwaX6edci
   mJzBPIQB7abBDcdnJubCcSogRXCssk84rS7lMSNOFcKFzF0WzKcD4nwrx
   dCAXw8LAeeaMFCL/9lWZHgnUtD8uF8si9bIrqI//DGgMizb90NvTLYchy
   WoeOXXcOxl8qFwQLq08dRC3F80xyzEzPqwySakoQdeZONX+8GMCU4fXl5
   Jqo5MWutf8wFpkqNS+qn3zrnfFTlyOaS9wAAN2E+tG9oaki0QX/OMvfDD
   1IPai+kbVEB/GNTlMo2JF1xHH6UZrbWUJ9RauosQrKexRUYZ+wkfMnmGw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="322286592"
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="322286592"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 19:37:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="739061215"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 02 Sep 2022 19:37:40 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUJ2R-0000uO-0v;
        Sat, 03 Sep 2022 02:37:39 +0000
Date:   Sat, 3 Sep 2022 10:36:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Abel Vesa <abel.vesa@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ekansh Gupta <quic_ekagupt@quicinc.com>
Cc:     kbuild-all@lists.01.org, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 07/10] misc: fastrpc: Add support for audiopd
Message-ID: <202209031027.5XvVp3U8-lkp@intel.com>
References: <20220902154900.3404524-8-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902154900.3404524-8-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on robh/for-next linus/master v6.0-rc3 next-20220901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Abel-Vesa/misc-fastrpc-Add-audiopd-support/20220902-235842
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 4ec7ac90ff399b7d9af81cc8afd430a22786c61b
config: mips-randconfig-r035-20220902 (https://download.01.org/0day-ci/archive/20220903/202209031027.5XvVp3U8-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7036272dbe486564afd86e31ca0abf48aa1535ed
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Abel-Vesa/misc-fastrpc-Add-audiopd-support/20220902-235842
        git checkout 7036272dbe486564afd86e31ca0abf48aa1535ed
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:573,
                    from include/asm-generic/bug.h:22,
                    from arch/mips/include/asm/bug.h:42,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/mips/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/swait.h:7,
                    from include/linux/completion.h:12,
                    from drivers/misc/fastrpc.c:5:
   drivers/misc/fastrpc.c: In function 'fastrpc_init_create_static_process':
>> drivers/misc/fastrpc.c:1249:48: warning: format '%x' expects argument of type 'unsigned int', but argument 7 has type 'struct qcom_scm_vmperm *' [-Wformat=]
    1249 |                         dev_dbg(fl->sctx->dev, "Assinging memory with phys 0x%llx size 0x%llx perms 0x%x, vmperms %x, vmcount %x\n",
         |                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:30: note: in expansion of macro 'dev_fmt'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/misc/fastrpc.c:1249:25: note: in expansion of macro 'dev_dbg'
    1249 |                         dev_dbg(fl->sctx->dev, "Assinging memory with phys 0x%llx size 0x%llx perms 0x%x, vmperms %x, vmcount %x\n",
         |                         ^~~~~~~
   drivers/misc/fastrpc.c:1249:116: note: format string is defined here
    1249 |                         dev_dbg(fl->sctx->dev, "Assinging memory with phys 0x%llx size 0x%llx perms 0x%x, vmperms %x, vmcount %x\n",
         |                                                                                                                   ~^
         |                                                                                                                    |
         |                                                                                                                    unsigned int


vim +1249 drivers/misc/fastrpc.c

  1198	
  1199	static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
  1200						      char __user *argp)
  1201	{
  1202		struct fastrpc_init_create_static init;
  1203		struct fastrpc_invoke_args *args;
  1204		struct fastrpc_phy_page pages[1];
  1205		char *name;
  1206		int err;
  1207		struct {
  1208			int pgid;
  1209			u32 namelen;
  1210			u32 pageslen;
  1211		} inbuf;
  1212		u32 sc;
  1213	
  1214		args = kcalloc(FASTRPC_CREATE_STATIC_PROCESS_NARGS, sizeof(*args), GFP_KERNEL);
  1215		if (!args)
  1216			return -ENOMEM;
  1217	
  1218		if (copy_from_user(&init, argp, sizeof(init))) {
  1219			err = -EFAULT;
  1220			goto err;
  1221		}
  1222	
  1223		if (init.namelen > INIT_FILE_NAMELEN_MAX) {
  1224			err = -EINVAL;
  1225			goto err;
  1226		}
  1227	
  1228		name = kzalloc(init.namelen, GFP_KERNEL);
  1229		if (!name) {
  1230			err = -ENOMEM;
  1231			goto err;
  1232		}
  1233	
  1234		if (copy_from_user(name, (void __user *)(uintptr_t)init.name, init.namelen)) {
  1235			err = -EFAULT;
  1236			goto err_name;
  1237		}
  1238	
  1239		if (!fl->cctx->remote_heap) {
  1240			err = fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen,
  1241							&fl->cctx->remote_heap);
  1242			if (err)
  1243				goto err_name;
  1244	
  1245			/* Map if we have any heap VMIDs associated with this ADSP Static Process. */
  1246			if (fl->cctx->vmcount) {
  1247				unsigned int perms = BIT(QCOM_SCM_VMID_HLOS);
  1248	
> 1249				dev_dbg(fl->sctx->dev, "Assinging memory with phys 0x%llx size 0x%llx perms 0x%x, vmperms %x, vmcount %x\n",
  1250					fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size,
  1251					perms, fl->cctx->vmperms, fl->cctx->vmcount);
  1252				err = qcom_scm_assign_mem(fl->cctx->remote_heap->phys,
  1253								(u64)fl->cctx->remote_heap->size, &perms,
  1254								fl->cctx->vmperms, fl->cctx->vmcount);
  1255				if (err) {
  1256					dev_err(fl->sctx->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d",
  1257						fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);
  1258					goto err_map;
  1259				}
  1260			}
  1261		}
  1262	
  1263		inbuf.pgid = fl->tgid;
  1264		inbuf.namelen = init.namelen;
  1265		inbuf.pageslen = 0;
  1266		fl->pd = USER_PD;
  1267	
  1268		args[0].ptr = (u64)(uintptr_t)&inbuf;
  1269		args[0].length = sizeof(inbuf);
  1270		args[0].fd = -1;
  1271	
  1272		args[1].ptr = (u64)(uintptr_t)name;
  1273		args[1].length = inbuf.namelen;
  1274		args[1].fd = -1;
  1275	
  1276		pages[0].addr = fl->cctx->remote_heap->phys;
  1277		pages[0].size = fl->cctx->remote_heap->size;
  1278	
  1279		args[2].ptr = (u64)(uintptr_t) pages;
  1280		args[2].length = sizeof(*pages);
  1281		args[2].fd = -1;
  1282	
  1283		sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE_STATIC, 3, 0);
  1284	
  1285		err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE,
  1286					      sc, args);
  1287		if (err)
  1288			goto err_invoke;
  1289	
  1290		kfree(args);
  1291	
  1292		return 0;
  1293	err_invoke:
  1294	err_map:
  1295		fastrpc_buf_free(fl->cctx->remote_heap);
  1296	err_name:
  1297		kfree(name);
  1298	err:
  1299		kfree(args);
  1300	
  1301		return err;
  1302	}
  1303	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
