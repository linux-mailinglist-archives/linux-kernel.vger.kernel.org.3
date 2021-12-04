Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286A846828E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 07:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhLDFhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 00:37:01 -0500
Received: from mga03.intel.com ([134.134.136.65]:28052 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230083AbhLDFhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 00:37:00 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="237037652"
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="237037652"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 21:33:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="478550788"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 03 Dec 2021 21:33:33 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtNfw-000IWM-LO; Sat, 04 Dec 2021 05:33:32 +0000
Date:   Sat, 4 Dec 2021 13:32:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marco Elver <elver@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [paulmck-rcu:dev.2021.12.02a 31/43]
 include/asm-generic/barrier.h:70:30: warning: 'kcsan_rmb' is static but used
 in inline function 'pte_offset_kernel' which is not static
Message-ID: <202112041334.X44uWZXf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.12.02a
head:   d157b802f05bd12cf40bef7a73ca6914b85c865e
commit: 31a060491205cae6f710fa65d118580ee680619f [31/43] locking/barriers, kcsan: Add instrumentation for barriers
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20211204/202112041334.X44uWZXf-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=31a060491205cae6f710fa65d118580ee680619f
        git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
        git fetch --no-tags paulmck-rcu dev.2021.12.02a
        git checkout 31a060491205cae6f710fa65d118580ee680619f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/alpha/kernel/asm-offsets.c:15:6: warning: no previous prototype for 'foo' [-Wmissing-prototypes]
      15 | void foo(void)
         |      ^~~
   In file included from arch/alpha/include/asm/barrier.h:21,
                    from arch/alpha/include/asm/rwonce.h:10,
                    from include/linux/compiler.h:266,
                    from include/asm-generic/bug.h:5,
                    from arch/alpha/include/asm/bug.h:23,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/current.h:5,
                    from ./arch/alpha/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from arch/alpha/kernel/asm-offsets.c:10:
>> include/asm-generic/barrier.h:70:30: warning: 'kcsan_rmb' is static but used in inline function 'pte_offset_kernel' which is not static
      70 | #define smp_rmb()       do { kcsan_rmb(); __smp_rmb(); } while (0)
         |                              ^~~~~~~~~
   arch/alpha/include/asm/pgtable.h:303:9: note: in expansion of macro 'smp_rmb'
     303 |         smp_rmb(); /* see above */
         |         ^~~~~~~
>> include/asm-generic/barrier.h:70:30: warning: 'kcsan_rmb' is static but used in inline function 'pmd_offset' which is not static
      70 | #define smp_rmb()       do { kcsan_rmb(); __smp_rmb(); } while (0)
         |                              ^~~~~~~~~
   arch/alpha/include/asm/pgtable.h:293:9: note: in expansion of macro 'smp_rmb'
     293 |         smp_rmb(); /* see above */
         |         ^~~~~~~
--
   In file included from arch/alpha/include/asm/barrier.h:21,
                    from arch/alpha/include/asm/rwonce.h:10,
                    from include/linux/compiler.h:266,
                    from include/linux/init.h:5,
                    from drivers/gpu/drm/drm_dp_aux_bus.c:15:
>> include/asm-generic/barrier.h:70:30: warning: 'kcsan_rmb' is static but used in inline function 'pte_offset_kernel' which is not static
      70 | #define smp_rmb()       do { kcsan_rmb(); __smp_rmb(); } while (0)
         |                              ^~~~~~~~~
   arch/alpha/include/asm/pgtable.h:303:9: note: in expansion of macro 'smp_rmb'
     303 |         smp_rmb(); /* see above */
         |         ^~~~~~~
>> include/asm-generic/barrier.h:70:30: warning: 'kcsan_rmb' is static but used in inline function 'pmd_offset' which is not static
      70 | #define smp_rmb()       do { kcsan_rmb(); __smp_rmb(); } while (0)
         |                              ^~~~~~~~~
   arch/alpha/include/asm/pgtable.h:293:9: note: in expansion of macro 'smp_rmb'
     293 |         smp_rmb(); /* see above */
         |         ^~~~~~~
--
   In file included from arch/alpha/include/asm/barrier.h:21,
                    from arch/alpha/include/asm/rwonce.h:10,
                    from include/linux/compiler.h:266,
                    from include/asm-generic/bug.h:5,
                    from arch/alpha/include/asm/bug.h:23,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from drivers/gpu/drm/nouveau/include/nvif/os.h:6,
                    from drivers/gpu/drm/nouveau/include/nvif/object.h:4,
                    from drivers/gpu/drm/nouveau/include/nvif/client.h:5,
                    from drivers/gpu/drm/nouveau/nvif/client.c:25:
>> include/asm-generic/barrier.h:70:30: warning: 'kcsan_rmb' is static but used in inline function 'pte_offset_kernel' which is not static
      70 | #define smp_rmb()       do { kcsan_rmb(); __smp_rmb(); } while (0)
         |                              ^~~~~~~~~
   arch/alpha/include/asm/pgtable.h:303:9: note: in expansion of macro 'smp_rmb'
     303 |         smp_rmb(); /* see above */
         |         ^~~~~~~
>> include/asm-generic/barrier.h:70:30: warning: 'kcsan_rmb' is static but used in inline function 'pmd_offset' which is not static
      70 | #define smp_rmb()       do { kcsan_rmb(); __smp_rmb(); } while (0)
         |                              ^~~~~~~~~
   arch/alpha/include/asm/pgtable.h:293:9: note: in expansion of macro 'smp_rmb'
     293 |         smp_rmb(); /* see above */
         |         ^~~~~~~
   drivers/gpu/drm/nouveau/nvif/client.c: In function 'nvif_client_ctor':
   drivers/gpu/drm/nouveau/nvif/client.c:72:9: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
      72 |         strncpy(args.name, name, sizeof(args.name));
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from arch/alpha/include/asm/barrier.h:21,
                    from arch/alpha/include/asm/rwonce.h:10,
                    from include/linux/compiler.h:266,
                    from include/asm-generic/bug.h:5,
                    from arch/alpha/include/asm/bug.h:23,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from drivers/gpu/drm/nouveau/include/nvif/os.h:6,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/os.h:4,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/oclass.h:3,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/device.h:4,
                    from drivers/gpu/drm/nouveau/nvkm/engine/device/priv.h:4,
                    from drivers/gpu/drm/nouveau/nvkm/engine/device/user.c:25:
>> include/asm-generic/barrier.h:70:30: warning: 'kcsan_rmb' is static but used in inline function 'pte_offset_kernel' which is not static
      70 | #define smp_rmb()       do { kcsan_rmb(); __smp_rmb(); } while (0)
         |                              ^~~~~~~~~
   arch/alpha/include/asm/pgtable.h:303:9: note: in expansion of macro 'smp_rmb'
     303 |         smp_rmb(); /* see above */
         |         ^~~~~~~
>> include/asm-generic/barrier.h:70:30: warning: 'kcsan_rmb' is static but used in inline function 'pmd_offset' which is not static
      70 | #define smp_rmb()       do { kcsan_rmb(); __smp_rmb(); } while (0)
         |                              ^~~~~~~~~
   arch/alpha/include/asm/pgtable.h:293:9: note: in expansion of macro 'smp_rmb'
     293 |         smp_rmb(); /* see above */
         |         ^~~~~~~
   drivers/gpu/drm/nouveau/nvkm/engine/device/user.c: In function 'nvkm_udevice_info':
   drivers/gpu/drm/nouveau/nvkm/engine/device/user.c:164:9: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]
     164 |         strncpy(args->v0.chip, device->chip->name, sizeof(args->v0.chip));
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/nouveau/nvkm/engine/device/user.c:165:9: warning: 'strncpy' specified bound 64 equals destination size [-Wstringop-truncation]
     165 |         strncpy(args->v0.name, device->name, sizeof(args->v0.name));
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   drivers/gpu/drm/nouveau/nouveau_display.c: In function 'nouveau_framebuffer_new':
   drivers/gpu/drm/nouveau/nouveau_display.c:309:22: warning: variable 'width' set but not used [-Wunused-but-set-variable]
     309 |         unsigned int width, height, i;
         |                      ^~~~~
   In file included from arch/alpha/include/asm/barrier.h:21,
                    from arch/alpha/include/asm/rwonce.h:10,
                    from include/linux/compiler.h:266,
                    from include/linux/build_bug.h:5,
                    from include/linux/bits.h:22,
                    from include/linux/ioport.h:13,
                    from include/linux/acpi.h:12,
                    from include/linux/i2c.h:13,
                    from include/drm/drm_crtc.h:28,
                    from include/drm/drm_atomic.h:31,
                    from drivers/gpu/drm/nouveau/nouveau_display.c:29:
   drivers/gpu/drm/nouveau/nouveau_display.c: At top level:
>> include/asm-generic/barrier.h:70:30: warning: 'kcsan_rmb' is static but used in inline function 'pte_offset_kernel' which is not static
      70 | #define smp_rmb()       do { kcsan_rmb(); __smp_rmb(); } while (0)
         |                              ^~~~~~~~~
   arch/alpha/include/asm/pgtable.h:303:9: note: in expansion of macro 'smp_rmb'
     303 |         smp_rmb(); /* see above */
         |         ^~~~~~~
>> include/asm-generic/barrier.h:70:30: warning: 'kcsan_rmb' is static but used in inline function 'pmd_offset' which is not static
      70 | #define smp_rmb()       do { kcsan_rmb(); __smp_rmb(); } while (0)
         |                              ^~~~~~~~~
   arch/alpha/include/asm/pgtable.h:293:9: note: in expansion of macro 'smp_rmb'
     293 |         smp_rmb(); /* see above */
         |         ^~~~~~~
--
   drivers/gpu/drm/nouveau/dispnv50/disp.c: In function 'nv50_mstm_cleanup':
   drivers/gpu/drm/nouveau/dispnv50/disp.c:1390:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
    1390 |         int ret;
         |             ^~~
   drivers/gpu/drm/nouveau/dispnv50/disp.c: In function 'nv50_mstm_prepare':
   drivers/gpu/drm/nouveau/dispnv50/disp.c:1414:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
    1414 |         int ret;
         |             ^~~
   drivers/gpu/drm/nouveau/dispnv50/disp.c: At top level:
   drivers/gpu/drm/nouveau/dispnv50/disp.c:2692:1: warning: no previous prototype for 'nv50_display_create' [-Wmissing-prototypes]
    2692 | nv50_display_create(struct drm_device *dev)
         | ^~~~~~~~~~~~~~~~~~~
   In file included from arch/alpha/include/asm/barrier.h:21,
                    from arch/alpha/include/asm/rwonce.h:10,
                    from include/linux/compiler.h:266,
                    from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/timer.h:5,
                    from include/linux/workqueue.h:9,
                    from drivers/gpu/drm/nouveau/dispnv50/disp.h:3,
                    from drivers/gpu/drm/nouveau/dispnv50/disp.c:24:
>> include/asm-generic/barrier.h:70:30: warning: 'kcsan_rmb' is static but used in inline function 'pte_offset_kernel' which is not static
      70 | #define smp_rmb()       do { kcsan_rmb(); __smp_rmb(); } while (0)
         |                              ^~~~~~~~~
   arch/alpha/include/asm/pgtable.h:303:9: note: in expansion of macro 'smp_rmb'
     303 |         smp_rmb(); /* see above */
         |         ^~~~~~~
>> include/asm-generic/barrier.h:70:30: warning: 'kcsan_rmb' is static but used in inline function 'pmd_offset' which is not static
      70 | #define smp_rmb()       do { kcsan_rmb(); __smp_rmb(); } while (0)
         |                              ^~~~~~~~~
   arch/alpha/include/asm/pgtable.h:293:9: note: in expansion of macro 'smp_rmb'
     293 |         smp_rmb(); /* see above */
         |         ^~~~~~~
--
   drivers/gpu/drm/nouveau/dispnv50/headc57d.c:173:1: warning: no previous prototype for 'headc57d_olut' [-Wmissing-prototypes]
     173 | headc57d_olut(struct nv50_head *head, struct nv50_head_atom *asyh, int size)
         | ^~~~~~~~~~~~~
   In file included from arch/alpha/include/asm/barrier.h:21,
                    from arch/alpha/include/asm/rwonce.h:10,
                    from include/linux/compiler.h:266,
                    from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/timer.h:5,
                    from include/linux/workqueue.h:9,
                    from drivers/gpu/drm/nouveau/dispnv50/head.h:4,
                    from drivers/gpu/drm/nouveau/dispnv50/headc57d.c:22:
>> include/asm-generic/barrier.h:70:30: warning: 'kcsan_rmb' is static but used in inline function 'pte_offset_kernel' which is not static
      70 | #define smp_rmb()       do { kcsan_rmb(); __smp_rmb(); } while (0)
         |                              ^~~~~~~~~
   arch/alpha/include/asm/pgtable.h:303:9: note: in expansion of macro 'smp_rmb'
     303 |         smp_rmb(); /* see above */
         |         ^~~~~~~
>> include/asm-generic/barrier.h:70:30: warning: 'kcsan_rmb' is static but used in inline function 'pmd_offset' which is not static
      70 | #define smp_rmb()       do { kcsan_rmb(); __smp_rmb(); } while (0)
         |                              ^~~~~~~~~
   arch/alpha/include/asm/pgtable.h:293:9: note: in expansion of macro 'smp_rmb'
     293 |         smp_rmb(); /* see above */
         |         ^~~~~~~
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:870:6: warning: no previous prototype for 'amdgpu_ras_mca_query_error_status' [-Wmissing-prototypes]
     870 | void amdgpu_ras_mca_query_error_status(struct amdgpu_device *adev,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/alpha/include/asm/barrier.h:21,
                    from arch/alpha/include/asm/rwonce.h:10,
                    from include/linux/compiler.h:266,
                    from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/debugfs.h:15,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:24:
>> include/asm-generic/barrier.h:70:30: warning: 'kcsan_rmb' is static but used in inline function 'pte_offset_kernel' which is not static
      70 | #define smp_rmb()       do { kcsan_rmb(); __smp_rmb(); } while (0)
         |                              ^~~~~~~~~
   arch/alpha/include/asm/pgtable.h:303:9: note: in expansion of macro 'smp_rmb'
     303 |         smp_rmb(); /* see above */
         |         ^~~~~~~
>> include/asm-generic/barrier.h:70:30: warning: 'kcsan_rmb' is static but used in inline function 'pmd_offset' which is not static
      70 | #define smp_rmb()       do { kcsan_rmb(); __smp_rmb(); } while (0)
         |                              ^~~~~~~~~
   arch/alpha/include/asm/pgtable.h:293:9: note: in expansion of macro 'smp_rmb'
     293 |         smp_rmb(); /* see above */
         |         ^~~~~~~
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:521:6: warning: no previous prototype for 'release_psp_cmd_buf' [-Wmissing-prototypes]
     521 | void release_psp_cmd_buf(struct psp_context *psp)
         |      ^~~~~~~~~~~~~~~~~~~
   In file included from arch/alpha/include/asm/barrier.h:21,
                    from arch/alpha/include/asm/rwonce.h:10,
                    from include/linux/compiler.h:266,
                    from include/linux/firmware.h:6,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:26:
>> include/asm-generic/barrier.h:70:30: warning: 'kcsan_rmb' is static but used in inline function 'pte_offset_kernel' which is not static
      70 | #define smp_rmb()       do { kcsan_rmb(); __smp_rmb(); } while (0)
         |                              ^~~~~~~~~
   arch/alpha/include/asm/pgtable.h:303:9: note: in expansion of macro 'smp_rmb'
     303 |         smp_rmb(); /* see above */
         |         ^~~~~~~
>> include/asm-generic/barrier.h:70:30: warning: 'kcsan_rmb' is static but used in inline function 'pmd_offset' which is not static
      70 | #define smp_rmb()       do { kcsan_rmb(); __smp_rmb(); } while (0)
         |                              ^~~~~~~~~
   arch/alpha/include/asm/pgtable.h:293:9: note: in expansion of macro 'smp_rmb'
     293 |         smp_rmb(); /* see above */
         |         ^~~~~~~
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c:399:5: warning: no previous prototype for 'amdgpu_vkms_output_init' [-Wmissing-prototypes]
     399 | int amdgpu_vkms_output_init(struct drm_device *dev,
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/alpha/include/asm/barrier.h:21,
                    from arch/alpha/include/asm/rwonce.h:10,
                    from include/linux/compiler.h:266,
                    from include/linux/build_bug.h:5,
                    from include/linux/bits.h:22,
                    from include/linux/ioport.h:13,
                    from include/linux/acpi.h:12,
                    from include/linux/i2c.h:13,
                    from include/drm/drm_crtc.h:28,
                    from include/drm/drm_atomic_helper.h:31,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c:3:
>> include/asm-generic/barrier.h:70:30: warning: 'kcsan_rmb' is static but used in inline function 'pte_offset_kernel' which is not static
      70 | #define smp_rmb()       do { kcsan_rmb(); __smp_rmb(); } while (0)
         |                              ^~~~~~~~~
   arch/alpha/include/asm/pgtable.h:303:9: note: in expansion of macro 'smp_rmb'
     303 |         smp_rmb(); /* see above */
         |         ^~~~~~~
>> include/asm-generic/barrier.h:70:30: warning: 'kcsan_rmb' is static but used in inline function 'pmd_offset' which is not static
      70 | #define smp_rmb()       do { kcsan_rmb(); __smp_rmb(); } while (0)
         |                              ^~~~~~~~~
   arch/alpha/include/asm/pgtable.h:293:9: note: in expansion of macro 'smp_rmb'
     293 |         smp_rmb(); /* see above */
         |         ^~~~~~~
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dmub/dmub_srv.h:67,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:35:
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h: In function 'dmub_rb_flush_pending':
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:2893:26: warning: variable 'temp' set but not used [-Wunused-but-set-variable]
    2893 |                 uint64_t temp;
         |                          ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: At top level:
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:11459:5: warning: no previous prototype for 'amdgpu_dm_set_dmub_async_sync_status' [-Wmissing-prototypes]
   11459 | int amdgpu_dm_set_dmub_async_sync_status(bool is_cmd_aux, struct dc_context *ctx,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/alpha/include/asm/barrier.h:21,
                    from arch/alpha/include/asm/rwonce.h:10,
                    from include/linux/compiler.h:266,
                    from include/linux/init.h:5,
                    from include/linux/kgdb.h:17,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:29:
>> include/asm-generic/barrier.h:70:30: warning: 'kcsan_rmb' is static but used in inline function 'pte_offset_kernel' which is not static
      70 | #define smp_rmb()       do { kcsan_rmb(); __smp_rmb(); } while (0)
         |                              ^~~~~~~~~
   arch/alpha/include/asm/pgtable.h:303:9: note: in expansion of macro 'smp_rmb'
     303 |         smp_rmb(); /* see above */
         |         ^~~~~~~
>> include/asm-generic/barrier.h:70:30: warning: 'kcsan_rmb' is static but used in inline function 'pmd_offset' which is not static
      70 | #define smp_rmb()       do { kcsan_rmb(); __smp_rmb(); } while (0)
         |                              ^~~~~~~~~
   arch/alpha/include/asm/pgtable.h:293:9: note: in expansion of macro 'smp_rmb'
     293 |         smp_rmb(); /* see above */
         |         ^~~~~~~
..


vim +70 include/asm-generic/barrier.h

    68	
    69	#ifndef smp_rmb
  > 70	#define smp_rmb()	do { kcsan_rmb(); __smp_rmb(); } while (0)
    71	#endif
    72	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
