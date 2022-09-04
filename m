Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBC65AC236
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 06:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiIDECi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 00:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiIDECf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 00:02:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8790357C9;
        Sat,  3 Sep 2022 21:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662264153; x=1693800153;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BSzW8fnfWx0Sr4kYsFe9fl53do3nykMdsh64QZJsHsI=;
  b=Ml1FidrxZyz6HZhWYvKVmILY3PaicWtPVzUj59aQKOASbLdUyvRkXwMX
   b1fvz+aPF+Y++qNNc0LigapNkQOy8u5v3bX/bzSZVw4jL7IUPkL7vRs/X
   KiGVVgJ+xNhD/b5WsXwMs+29wREm3IJ1SAjh7AATKU9vCZb+9A3Qa3nbW
   g3OvJs+CU/U5/LNLAPwiiaX3CnaMmrADIxTc2jukf5e5JzFd7bSsIixGL
   kD5pYf5hmGQ3TLz07YLFljHUwDZfW9Fvf1EvHuqQpDkzFUfjFP0pHeQhg
   hZ1zdH515gRQzoeBmFD0XMXk0A5udKT1jTN3qZl8Fr4jp9NL4yd2OXGy2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="283199030"
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="283199030"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 21:02:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="739254083"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 03 Sep 2022 21:02:29 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUgq5-0002WP-0p;
        Sun, 04 Sep 2022 04:02:29 +0000
Date:   Sun, 4 Sep 2022 12:02:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorande@qti.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ekansh Gupta <ekangupt@qti.qualcomm.com>
Cc:     kbuild-all@lists.01.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/14] misc: fastrpc: Add support for audiopd
Message-ID: <202209041138.pdoIATKj-lkp@intel.com>
References: <20220902131344.3029826-11-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902131344.3029826-11-abel.vesa@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

url:    https://github.com/intel-lab-lkp/linux/commits/Abel-Vesa/misc-fastrpc-Add-audiopd-support-and-some-fixes/20220902-215548
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 4ec7ac90ff399b7d9af81cc8afd430a22786c61b
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20220904/202209041138.pdoIATKj-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/40e5982368fa8e5eeb1a3ff7b955d0c0b54656d1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Abel-Vesa/misc-fastrpc-Add-audiopd-support-and-some-fixes/20220902-215548
        git checkout 40e5982368fa8e5eeb1a3ff7b955d0c0b54656d1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:573,
                    from include/asm-generic/bug.h:22,
                    from arch/ia64/include/asm/bug.h:17,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/ia64/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/swait.h:7,
                    from include/linux/completion.h:12,
                    from drivers/misc/fastrpc.c:5:
   drivers/misc/fastrpc.c: In function 'fastrpc_init_create_static_process':
>> drivers/misc/fastrpc.c:1259:48: warning: format '%x' expects argument of type 'unsigned int', but argument 7 has type 'struct qcom_scm_vmperm *' [-Wformat=]
    1259 |                         dev_dbg(fl->sctx->dev, "Assinging memory with phys 0x%llx size 0x%llx perms 0x%x, vmperms %x, vmcount %x\n",
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
   drivers/misc/fastrpc.c:1259:25: note: in expansion of macro 'dev_dbg'
    1259 |                         dev_dbg(fl->sctx->dev, "Assinging memory with phys 0x%llx size 0x%llx perms 0x%x, vmperms %x, vmcount %x\n",
         |                         ^~~~~~~
   drivers/misc/fastrpc.c:1259:116: note: format string is defined here
    1259 |                         dev_dbg(fl->sctx->dev, "Assinging memory with phys 0x%llx size 0x%llx perms 0x%x, vmperms %x, vmcount %x\n",
         |                                                                                                                   ~^
         |                                                                                                                    |
         |                                                                                                                    unsigned int
   {standard input}: Assembler messages:
   {standard input}:1031: Error: Register number out of range 0..4
   {standard input}:1032: Error: Register number out of range 0..4
   {standard input}:1032: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 44
   {standard input}:1032: Warning: Only the first path encountering the conflict is reported
   {standard input}:1031: Warning: This is the location of the conflicting usage
   {standard input}:1036: Error: Register number out of range 0..4
   {standard input}:1193: Error: Register number out of range 0..2
   {standard input}:1193: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 38
   {standard input}:1193: Warning: Only the first path encountering the conflict is reported
   {standard input}:1189: Warning: This is the location of the conflicting usage
   {standard input}:1194: Error: Register number out of range 0..2
   {standard input}:1194: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 38
   {standard input}:1194: Warning: Only the first path encountering the conflict is reported
   {standard input}:1189: Warning: This is the location of the conflicting usage
   {standard input}:1194: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 38
   {standard input}:1194: Warning: Only the first path encountering the conflict is reported
   {standard input}:1193: Warning: This is the location of the conflicting usage
   {standard input}:1195: Error: Register number out of range 0..2
   {standard input}:1195: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 38
   {standard input}:1195: Warning: Only the first path encountering the conflict is reported
   {standard input}:1189: Warning: This is the location of the conflicting usage
   {standard input}:1195: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 38
   {standard input}:1195: Warning: Only the first path encountering the conflict is reported
   {standard input}:1193: Warning: This is the location of the conflicting usage
   {standard input}:1195: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 38
   {standard input}:1195: Warning: Only the first path encountering the conflict is reported
   {standard input}:1194: Warning: This is the location of the conflicting usage
   {standard input}:1198: Error: Register number out of range 0..2
   {standard input}:1199: Error: Register number out of range 0..2
   {standard input}:1199: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 38
   {standard input}:1199: Warning: Only the first path encountering the conflict is reported
   {standard input}:1198: Warning: This is the location of the conflicting usage
   {standard input}:2810: Error: Register number out of range 0..3
   {standard input}:2811: Error: Register number out of range 0..3
   {standard input}:2811: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 46
   {standard input}:2811: Warning: Only the first path encountering the conflict is reported
   {standard input}:2810: Warning: This is the location of the conflicting usage
   {standard input}:2812: Error: Register number out of range 0..3
   {standard input}:2812: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 46
   {standard input}:2812: Warning: Only the first path encountering the conflict is reported
   {standard input}:2810: Warning: This is the location of the conflicting usage
   {standard input}:2812: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 46
   {standard input}:2812: Warning: Only the first path encountering the conflict is reported
   {standard input}:2811: Warning: This is the location of the conflicting usage
   {standard input}:2816: Error: Register number out of range 0..3
   {standard input}:3634: Error: Register number out of range 0..3
   {standard input}:3635: Error: Register number out of range 0..3
   {standard input}:3635: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 51
   {standard input}:3635: Warning: Only the first path encountering the conflict is reported
   {standard input}:3634: Warning: This is the location of the conflicting usage
   {standard input}:3636: Error: Register number out of range 0..3
   {standard input}:3636: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 51
   {standard input}:3636: Warning: Only the first path encountering the conflict is reported
   {standard input}:3634: Warning: This is the location of the conflicting usage
   {standard input}:3636: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 51
   {standard input}:3636: Warning: Only the first path encountering the conflict is reported
   {standard input}:3635: Warning: This is the location of the conflicting usage
   {standard input}:3640: Error: Register number out of range 0..3
   {standard input}:3955: Error: Register number out of range 0..4
   {standard input}:3955: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 44
   {standard input}:3955: Warning: Only the first path encountering the conflict is reported
   {standard input}:3949: Warning: This is the location of the conflicting usage
   {standard input}:3958: Error: Register number out of range 0..4
   {standard input}:3959: Error: Register number out of range 0..4
   {standard input}:3959: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 44
   {standard input}:3959: Warning: Only the first path encountering the conflict is reported
   {standard input}:3958: Warning: This is the location of the conflicting usage
   {standard input}:4343: Error: Register number out of range 0..4
   {standard input}:4343: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 43
   {standard input}:4343: Warning: Only the first path encountering the conflict is reported
   {standard input}:4337: Warning: This is the location of the conflicting usage
   {standard input}:4346: Error: Register number out of range 0..4
   {standard input}:4347: Error: Register number out of range 0..4
   {standard input}:4347: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 43
   {standard input}:4347: Warning: Only the first path encountering the conflict is reported
   {standard input}:4346: Warning: This is the location of the conflicting usage
   {standard input}:4497: Error: Register number out of range 0..2


vim +1259 drivers/misc/fastrpc.c

  1208	
  1209	static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
  1210						      char __user *argp)
  1211	{
  1212		struct fastrpc_init_create_static init;
  1213		struct fastrpc_invoke_args *args;
  1214		struct fastrpc_phy_page pages[1];
  1215		char *name;
  1216		int err;
  1217		struct {
  1218			int pgid;
  1219			u32 namelen;
  1220			u32 pageslen;
  1221		} inbuf;
  1222		u32 sc;
  1223	
  1224		args = kcalloc(FASTRPC_CREATE_STATIC_PROCESS_NARGS, sizeof(*args), GFP_KERNEL);
  1225		if (!args)
  1226			return -ENOMEM;
  1227	
  1228		if (copy_from_user(&init, argp, sizeof(init))) {
  1229			err = -EFAULT;
  1230			goto err;
  1231		}
  1232	
  1233		if (init.namelen > INIT_FILE_NAMELEN_MAX) {
  1234			err = -EINVAL;
  1235			goto err;
  1236		}
  1237	
  1238		name = kzalloc(init.namelen, GFP_KERNEL);
  1239		if (!name) {
  1240			err = -ENOMEM;
  1241			goto err;
  1242		}
  1243	
  1244		if (copy_from_user(name, (void __user *)(uintptr_t)init.name, init.namelen)) {
  1245			err = -EFAULT;
  1246			goto err_name;
  1247		}
  1248	
  1249		if (!fl->cctx->remote_heap) {
  1250			err = fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen,
  1251							&fl->cctx->remote_heap);
  1252			if (err)
  1253				goto err_name;
  1254	
  1255			/* Map if we have any heap VMIDs associated with this ADSP Static Process. */
  1256			if (fl->cctx->vmcount) {
  1257				unsigned int perms = BIT(QCOM_SCM_VMID_HLOS);
  1258	
> 1259				dev_dbg(fl->sctx->dev, "Assinging memory with phys 0x%llx size 0x%llx perms 0x%x, vmperms %x, vmcount %x\n",
  1260					fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size,
  1261					perms, fl->cctx->vmperms, fl->cctx->vmcount);
  1262				err = qcom_scm_assign_mem(fl->cctx->remote_heap->phys,
  1263								(u64)fl->cctx->remote_heap->size, &perms,
  1264								fl->cctx->vmperms, fl->cctx->vmcount);
  1265				if (err) {
  1266					dev_err(fl->sctx->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d",
  1267						fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);
  1268					goto err_map;
  1269				}
  1270			}
  1271		}
  1272	
  1273		inbuf.pgid = fl->tgid;
  1274		inbuf.namelen = init.namelen;
  1275		inbuf.pageslen = 0;
  1276		fl->pd = USER_PD;
  1277	
  1278		args[0].ptr = (u64)(uintptr_t)&inbuf;
  1279		args[0].length = sizeof(inbuf);
  1280		args[0].fd = -1;
  1281	
  1282		args[1].ptr = (u64)(uintptr_t)name;
  1283		args[1].length = inbuf.namelen;
  1284		args[1].fd = -1;
  1285	
  1286		pages[0].addr = fl->cctx->remote_heap->phys;
  1287		pages[0].size = fl->cctx->remote_heap->size;
  1288	
  1289		args[2].ptr = (u64)(uintptr_t) pages;
  1290		args[2].length = sizeof(*pages);
  1291		args[2].fd = -1;
  1292	
  1293		sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE_STATIC, 3, 0);
  1294	
  1295		err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE,
  1296					      sc, args);
  1297		if (err)
  1298			goto err_invoke;
  1299	
  1300		kfree(args);
  1301	
  1302		return 0;
  1303	err_invoke:
  1304	err_map:
  1305		fastrpc_buf_free(fl->cctx->remote_heap);
  1306	err_name:
  1307		kfree(name);
  1308	err:
  1309		kfree(args);
  1310	
  1311		return err;
  1312	}
  1313	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
