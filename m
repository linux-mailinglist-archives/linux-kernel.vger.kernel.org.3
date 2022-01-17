Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE31349009D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 04:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbiAQDl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 22:41:27 -0500
Received: from mga05.intel.com ([192.55.52.43]:29710 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234224AbiAQDlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 22:41:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642390885; x=1673926885;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eLPSw9A7W8s/YeMYhZOeQZgJFVCOW6jFPhRW9d9/Ed4=;
  b=j6gmnirirZzGcLvHobCowzsmTGZBcUexfuhvA5yRH8mA2aKyU47AAe4U
   5MvpwN+dBBzyxgkhZYmr16tz9zEzazdBAd7BwgXcA8m1S3gwixK1CCO8j
   M9m5VBD6b4J36enQrzKQ93CvhnzL52hfqOCE1lYH5jK1n6NqrMJbuUQdL
   /gjxrrlNKEBFdcck3DlOLeIfASOSPX1hmCSUFOuybmLeZUR3eAMBoVZCV
   I5nXHlUJnDNcSwgRNJHjEC04raiash+S2+Ew4zRS5E0A2twIj2KRDABsa
   1/mldQbQ2S5FwPygNeJqdOxImLvN7avq6VAeu35wXnIju8UekcGT8z1PC
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="330895936"
X-IronPort-AV: E=Sophos;i="5.88,294,1635231600"; 
   d="scan'208";a="330895936"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 19:41:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,294,1635231600"; 
   d="scan'208";a="476496333"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 16 Jan 2022 19:41:23 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9ItW-000BE3-UQ; Mon, 17 Jan 2022 03:41:22 +0000
Date:   Mon, 17 Jan 2022 11:40:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: drivers/media/v4l2-core/v4l2-ioctl.c:303:28: warning: taking address
 of packed member 'pixelformat' of class or structure
 'v4l2_pix_format_mplane' may result in an unaligned pointer value
Message-ID: <202201171150.wl8T3ge0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   79e06c4c4950be2abd8ca5d2428a8c915aa62c24
commit: e927e1e0f0dd3e353d5556503a71484008692c82 v4l: ioctl: Use %p4cc printk modifier to print FourCC codes
date:   11 months ago
config: mips-randconfig-r002-20220116 (https://download.01.org/0day-ci/archive/20220117/202201171150.wl8T3ge0-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c63a3175c2947e8c1a2d3bbe16a8586600705c54)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e927e1e0f0dd3e353d5556503a71484008692c82
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e927e1e0f0dd3e353d5556503a71484008692c82
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/hid/ drivers/iio/adc/ drivers/media/v4l2-core/ drivers/usb/gadget/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/v4l2-core/v4l2-ioctl.c:303:28: warning: taking address of packed member 'pixelformat' of class or structure 'v4l2_pix_format_mplane' may result in an unaligned pointer value [-Waddress-of-packed-member]
                           mp->width, mp->height, &mp->pixelformat,
                                                   ^~~~~~~~~~~~~~~
   include/linux/printk.h:385:26: note: expanded from macro 'pr_cont'
           printk(KERN_CONT fmt, ##__VA_ARGS__)
                                   ^~~~~~~~~~~
>> drivers/media/v4l2-core/v4l2-ioctl.c:347:37: warning: taking address of packed member 'pixelformat' of class or structure 'v4l2_sdr_format' may result in an unaligned pointer value [-Waddress-of-packed-member]
                   pr_cont(", pixelformat=%p4cc\n", &sdr->pixelformat);
                                                     ^~~~~~~~~~~~~~~~
   include/linux/printk.h:385:26: note: expanded from macro 'pr_cont'
           printk(KERN_CONT fmt, ##__VA_ARGS__)
                                   ^~~~~~~~~~~
>> drivers/media/v4l2-core/v4l2-ioctl.c:353:5: warning: taking address of packed member 'dataformat' of class or structure 'v4l2_meta_format' may result in an unaligned pointer value [-Waddress-of-packed-member]
                           &meta->dataformat, meta->buffersize);
                            ^~~~~~~~~~~~~~~~
   include/linux/printk.h:385:26: note: expanded from macro 'pr_cont'
           printk(KERN_CONT fmt, ##__VA_ARGS__)
                                   ^~~~~~~~~~~
   3 warnings generated.


vim +303 drivers/media/v4l2-core/v4l2-ioctl.c

   273	
   274	static void v4l_print_format(const void *arg, bool write_only)
   275	{
   276		const struct v4l2_format *p = arg;
   277		const struct v4l2_pix_format *pix;
   278		const struct v4l2_pix_format_mplane *mp;
   279		const struct v4l2_vbi_format *vbi;
   280		const struct v4l2_sliced_vbi_format *sliced;
   281		const struct v4l2_window *win;
   282		const struct v4l2_sdr_format *sdr;
   283		const struct v4l2_meta_format *meta;
   284		u32 planes;
   285		unsigned i;
   286	
   287		pr_cont("type=%s", prt_names(p->type, v4l2_type_names));
   288		switch (p->type) {
   289		case V4L2_BUF_TYPE_VIDEO_CAPTURE:
   290		case V4L2_BUF_TYPE_VIDEO_OUTPUT:
   291			pix = &p->fmt.pix;
   292			pr_cont(", width=%u, height=%u, pixelformat=%p4cc, field=%s, bytesperline=%u, sizeimage=%u, colorspace=%d, flags=0x%x, ycbcr_enc=%u, quantization=%u, xfer_func=%u\n",
   293				pix->width, pix->height, &pix->pixelformat,
   294				prt_names(pix->field, v4l2_field_names),
   295				pix->bytesperline, pix->sizeimage,
   296				pix->colorspace, pix->flags, pix->ycbcr_enc,
   297				pix->quantization, pix->xfer_func);
   298			break;
   299		case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
   300		case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
   301			mp = &p->fmt.pix_mp;
   302			pr_cont(", width=%u, height=%u, format=%p4cc, field=%s, colorspace=%d, num_planes=%u, flags=0x%x, ycbcr_enc=%u, quantization=%u, xfer_func=%u\n",
 > 303				mp->width, mp->height, &mp->pixelformat,
   304				prt_names(mp->field, v4l2_field_names),
   305				mp->colorspace, mp->num_planes, mp->flags,
   306				mp->ycbcr_enc, mp->quantization, mp->xfer_func);
   307			planes = min_t(u32, mp->num_planes, VIDEO_MAX_PLANES);
   308			for (i = 0; i < planes; i++)
   309				printk(KERN_DEBUG "plane %u: bytesperline=%u sizeimage=%u\n", i,
   310						mp->plane_fmt[i].bytesperline,
   311						mp->plane_fmt[i].sizeimage);
   312			break;
   313		case V4L2_BUF_TYPE_VIDEO_OVERLAY:
   314		case V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY:
   315			win = &p->fmt.win;
   316			/* Note: we can't print the clip list here since the clips
   317			 * pointer is a userspace pointer, not a kernelspace
   318			 * pointer. */
   319			pr_cont(", wxh=%dx%d, x,y=%d,%d, field=%s, chromakey=0x%08x, clipcount=%u, clips=%p, bitmap=%p, global_alpha=0x%02x\n",
   320				win->w.width, win->w.height, win->w.left, win->w.top,
   321				prt_names(win->field, v4l2_field_names),
   322				win->chromakey, win->clipcount, win->clips,
   323				win->bitmap, win->global_alpha);
   324			break;
   325		case V4L2_BUF_TYPE_VBI_CAPTURE:
   326		case V4L2_BUF_TYPE_VBI_OUTPUT:
   327			vbi = &p->fmt.vbi;
   328			pr_cont(", sampling_rate=%u, offset=%u, samples_per_line=%u, sample_format=%p4cc, start=%u,%u, count=%u,%u\n",
   329				vbi->sampling_rate, vbi->offset,
   330				vbi->samples_per_line, &vbi->sample_format,
   331				vbi->start[0], vbi->start[1],
   332				vbi->count[0], vbi->count[1]);
   333			break;
   334		case V4L2_BUF_TYPE_SLICED_VBI_CAPTURE:
   335		case V4L2_BUF_TYPE_SLICED_VBI_OUTPUT:
   336			sliced = &p->fmt.sliced;
   337			pr_cont(", service_set=0x%08x, io_size=%d\n",
   338					sliced->service_set, sliced->io_size);
   339			for (i = 0; i < 24; i++)
   340				printk(KERN_DEBUG "line[%02u]=0x%04x, 0x%04x\n", i,
   341					sliced->service_lines[0][i],
   342					sliced->service_lines[1][i]);
   343			break;
   344		case V4L2_BUF_TYPE_SDR_CAPTURE:
   345		case V4L2_BUF_TYPE_SDR_OUTPUT:
   346			sdr = &p->fmt.sdr;
 > 347			pr_cont(", pixelformat=%p4cc\n", &sdr->pixelformat);
   348			break;
   349		case V4L2_BUF_TYPE_META_CAPTURE:
   350		case V4L2_BUF_TYPE_META_OUTPUT:
   351			meta = &p->fmt.meta;
   352			pr_cont(", dataformat=%p4cc, buffersize=%u\n",
 > 353				&meta->dataformat, meta->buffersize);
   354			break;
   355		}
   356	}
   357	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
