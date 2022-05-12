Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340D852508B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355562AbiELOsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237704AbiELOsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:48:35 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA81246D98;
        Thu, 12 May 2022 07:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652366914; x=1683902914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SaAXxDNTM4/wVBs778uhP/NgRzJzld+NgeawXjr4R9I=;
  b=GdDwgW8ruiiOawiF3IfShgY4+kAXiCc0V4YrAaZApmqi7Z01xRljB8a1
   G354D+9WxGpCfRwMdMDol1qu8WSp9EPlMCFTaJTkecJiMfhKCXkRB+/nu
   zIUa/HyqQcv9HMp7LxpZskYS0gAoM8qtLGNyCtAs4zy1bf+C3/m9FY7JJ
   3IUXI9wgcqtQo9AIR4h6r1Toq5tzm1kfowHyd6xCcHL6X4Zdphbt96Fpn
   5qhaiSSB9jYKHfPUgKq1AoFQDxLCZ/jR+sUEebup1brG9Jh3Ugo7Pc67U
   BP7/vbYSLD3SOwKR2FzlukBAgiaF8ny9KZ4pSaCwIMpcSrhciEboBCXes
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="269959621"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="269959621"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 07:48:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="572548826"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 12 May 2022 07:48:30 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npA7B-000KaZ-9o;
        Thu, 12 May 2022 14:48:29 +0000
Date:   Thu, 12 May 2022 22:47:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     3090101217@zju.edu.cn, gregkh@linuxfoundation.org, corbet@lwn.net,
        laurent.pinchart@ideasonboard.com, balbi@kernel.org,
        rdunlap@infradead.org, mchehab+huawei@kernel.org, bilbao@vt.edu
Cc:     kbuild-all@lists.01.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Jing Leng <jleng@ambarella.com>
Subject: Re: [PATCH v2] usb: gadget: uvc: add bulk transfer support
Message-ID: <202205122203.E1HlX3x5-lkp@intel.com>
References: <20220512094236.10937-1-3090101217@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512094236.10937-1-3090101217@zju.edu.cn>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v5.18-rc6]
[cannot apply to usb/usb-testing balbi-usb/testing/next next-20220512]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/3090101217-zju-edu-cn/usb-gadget-uvc-add-bulk-transfer-support/20220512-174815
base:    c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220512/202205122203.E1HlX3x5-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/39a05ac7e24c36ed8f2aa2f65e4225d75a96a894
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review 3090101217-zju-edu-cn/usb-gadget-uvc-add-bulk-transfer-support/20220512-174815
        git checkout 39a05ac7e24c36ed8f2aa2f65e4225d75a96a894
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/usb/gadget/function/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/usb/gadget/function/f_uvc.c: In function 'uvc_function_bind':
>> drivers/usb/gadget/function/f_uvc.c:767:9: error: 'i' undeclared (first use in this function)
     767 |         i = 0;
         |         ^
   drivers/usb/gadget/function/f_uvc.c:767:9: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/usb/gadget/function/f_uvc.c:773:39: error: implicit declaration of function 'USBDHDR' [-Werror=implicit-function-declaration]
     773 |                 uvc_fs_streaming[i] = USBDHDR(&uvc_streaming_intf_alt1);
         |                                       ^~~~~~~
   cc1: some warnings being treated as errors


vim +/i +767 drivers/usb/gadget/function/f_uvc.c

   612	
   613	static int
   614	uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
   615	{
   616		struct usb_composite_dev *cdev = c->cdev;
   617		struct uvc_device *uvc = to_uvc(f);
   618		struct usb_string *us;
   619		unsigned int max_packet_mult;
   620		unsigned int max_packet_size;
   621		struct usb_ep *ep;
   622		struct f_uvc_opts *opts;
   623		int ret = -EINVAL;
   624	
   625		uvcg_info(f, "%s()\n", __func__);
   626	
   627		opts = fi_to_f_uvc_opts(f->fi);
   628	
   629		/* Handle different transfer mode for stream endpoints */
   630		if (opts->streaming_bulk_mult) {
   631			uvc_fs_streaming_ep.bmAttributes = USB_ENDPOINT_XFER_BULK;
   632			uvc_hs_streaming_ep.bmAttributes = uvc_fs_streaming_ep.bmAttributes;
   633			uvc_ss_streaming_ep.bmAttributes = uvc_fs_streaming_ep.bmAttributes;
   634	
   635			opts->streaming_maxburst = min(opts->streaming_maxburst, 15U);
   636	
   637			uvc_fs_streaming_ep.wMaxPacketSize = cpu_to_le16(64);
   638			uvc_fs_streaming_ep.bInterval = 0;
   639	
   640			uvc_hs_streaming_ep.wMaxPacketSize = cpu_to_le16(512);
   641			uvc_hs_streaming_ep.bInterval = 0;
   642	
   643			uvc_ss_streaming_ep.wMaxPacketSize = cpu_to_le16(1024);
   644			uvc_ss_streaming_ep.bInterval = 0;
   645	
   646			uvc_ss_streaming_comp.bmAttributes = 0;
   647			uvc_ss_streaming_comp.bMaxBurst = opts->streaming_maxburst;
   648			uvc_ss_streaming_comp.wBytesPerInterval = 0;
   649	
   650			uvc->video.max_payload_size = opts->streaming_bulk_mult * 1024;
   651		} else {
   652			uvc_fs_streaming_ep.bmAttributes = USB_ENDPOINT_SYNC_ASYNC
   653							| USB_ENDPOINT_XFER_ISOC;
   654			uvc_hs_streaming_ep.bmAttributes = uvc_fs_streaming_ep.bmAttributes;
   655			uvc_ss_streaming_ep.bmAttributes = uvc_fs_streaming_ep.bmAttributes;
   656	
   657			/* Sanity check the streaming endpoint module parameters.
   658			 */
   659			opts->streaming_interval = clamp(opts->streaming_interval, 1U, 16U);
   660			opts->streaming_maxpacket = clamp(opts->streaming_maxpacket, 1U, 3072U);
   661			opts->streaming_maxburst = min(opts->streaming_maxburst, 15U);
   662	
   663			/* For SS, wMaxPacketSize has to be 1024 if bMaxBurst is not 0 */
   664			if (opts->streaming_maxburst &&
   665				(opts->streaming_maxpacket % 1024) != 0) {
   666				opts->streaming_maxpacket = roundup(opts->streaming_maxpacket, 1024);
   667				uvcg_info(f, "overriding streaming_maxpacket to %d\n",
   668					opts->streaming_maxpacket);
   669			}
   670	
   671			/* Fill in the FS/HS/SS Video Streaming specific descriptors from the
   672			 * module parameters.
   673			 *
   674			 * NOTE: We assume that the user knows what they are doing and won't
   675			 * give parameters that their UDC doesn't support.
   676			 */
   677	
   678			if (opts->streaming_maxpacket <= 1024) {
   679				max_packet_mult = 0;
   680				max_packet_size = opts->streaming_maxpacket;
   681			} else if (opts->streaming_maxpacket <= 2048) {
   682				max_packet_mult = 1;
   683				max_packet_size = opts->streaming_maxpacket / 2;
   684			} else {
   685				max_packet_mult = 2;
   686				max_packet_size = opts->streaming_maxpacket / 3;
   687			}
   688	
   689			uvc_fs_streaming_ep.wMaxPacketSize =
   690				cpu_to_le16(min(opts->streaming_maxpacket, 1023U));
   691			uvc_fs_streaming_ep.bInterval = opts->streaming_interval;
   692	
   693			uvc_hs_streaming_ep.wMaxPacketSize =
   694				cpu_to_le16(max_packet_size | (max_packet_mult << 11));
   695			/* A high-bandwidth endpoint must specify a bInterval value of 1 */
   696			if (max_packet_mult > 0)
   697				uvc_hs_streaming_ep.bInterval = 1;
   698			else
   699				uvc_hs_streaming_ep.bInterval = opts->streaming_interval;
   700	
   701			uvc_ss_streaming_ep.wMaxPacketSize = cpu_to_le16(max_packet_size);
   702			uvc_ss_streaming_ep.bInterval = opts->streaming_interval;
   703	
   704			uvc_ss_streaming_comp.bmAttributes = max_packet_mult;
   705			uvc_ss_streaming_comp.bMaxBurst = opts->streaming_maxburst;
   706			uvc_ss_streaming_comp.wBytesPerInterval =
   707				cpu_to_le16(max_packet_size * (max_packet_mult + 1) *
   708					(opts->streaming_maxburst + 1));
   709	
   710			uvc->video.max_payload_size = 0;
   711		}
   712	
   713		/* Allocate endpoints. */
   714		ep = usb_ep_autoconfig(cdev->gadget, &uvc_control_ep);
   715		if (!ep) {
   716			uvcg_info(f, "Unable to allocate control EP\n");
   717			goto error;
   718		}
   719		uvc->control_ep = ep;
   720	
   721		if (gadget_is_superspeed(c->cdev->gadget))
   722			ep = usb_ep_autoconfig_ss(cdev->gadget, &uvc_ss_streaming_ep,
   723						  &uvc_ss_streaming_comp);
   724		else if (gadget_is_dualspeed(cdev->gadget))
   725			ep = usb_ep_autoconfig_ss(cdev->gadget, &uvc_hs_streaming_ep, NULL);
   726		else
   727			ep = usb_ep_autoconfig(cdev->gadget, &uvc_fs_streaming_ep);
   728	
   729		if (!ep) {
   730			uvcg_info(f, "Unable to allocate streaming EP\n");
   731			goto error;
   732		}
   733		uvc->video.ep = ep;
   734	
   735		uvc_fs_streaming_ep.bEndpointAddress = uvc->video.ep->address;
   736		uvc_hs_streaming_ep.bEndpointAddress = uvc->video.ep->address;
   737		uvc_ss_streaming_ep.bEndpointAddress = uvc->video.ep->address;
   738	
   739		us = usb_gstrings_attach(cdev, uvc_function_strings,
   740					 ARRAY_SIZE(uvc_en_us_strings));
   741		if (IS_ERR(us)) {
   742			ret = PTR_ERR(us);
   743			goto error;
   744		}
   745		uvc_iad.iFunction = us[UVC_STRING_CONTROL_IDX].id;
   746		uvc_control_intf.iInterface = us[UVC_STRING_CONTROL_IDX].id;
   747		ret = us[UVC_STRING_STREAMING_IDX].id;
   748		uvc_streaming_intf_alt0.iInterface = ret;
   749		uvc_streaming_intf_alt1.iInterface = ret;
   750	
   751		/* Allocate interface IDs. */
   752		if ((ret = usb_interface_id(c, f)) < 0)
   753			goto error;
   754		uvc_iad.bFirstInterface = ret;
   755		uvc_control_intf.bInterfaceNumber = ret;
   756		uvc->control_intf = ret;
   757		opts->control_interface = ret;
   758	
   759		if ((ret = usb_interface_id(c, f)) < 0)
   760			goto error;
   761		uvc_streaming_intf_alt0.bInterfaceNumber = ret;
   762		uvc_streaming_intf_alt1.bInterfaceNumber = ret;
   763		uvc->streaming_intf = ret;
   764		opts->streaming_interface = ret;
   765	
   766		/* Handle different transfer mode for descriptors */
 > 767		i = 0;
   768		if (opts->streaming_bulk_mult) {
   769			uvc_streaming_intf_alt0.bNumEndpoints = 1;
   770		} else {
   771			uvc_streaming_intf_alt0.bNumEndpoints = 0;
   772	
 > 773			uvc_fs_streaming[i] = USBDHDR(&uvc_streaming_intf_alt1);
   774			uvc_hs_streaming[i] = USBDHDR(&uvc_streaming_intf_alt1);
   775			uvc_ss_streaming[i] = USBDHDR(&uvc_streaming_intf_alt1);
   776			++i;
   777		}
   778		uvc_fs_streaming[i] = USBDHDR(&uvc_fs_streaming_ep);
   779		uvc_hs_streaming[i] = USBDHDR(&uvc_hs_streaming_ep);
   780		uvc_ss_streaming[i] = USBDHDR(&uvc_ss_streaming_ep);
   781		++i;
   782		uvc_fs_streaming[i] = NULL;
   783		uvc_hs_streaming[i] = NULL;
   784		uvc_ss_streaming[i] = USBDHDR(&uvc_ss_streaming_comp);
   785		++i;
   786		uvc_ss_streaming[i] = NULL;
   787	
   788		/* Copy descriptors */
   789		f->fs_descriptors = uvc_copy_descriptors(uvc, USB_SPEED_FULL);
   790		if (IS_ERR(f->fs_descriptors)) {
   791			ret = PTR_ERR(f->fs_descriptors);
   792			f->fs_descriptors = NULL;
   793			goto error;
   794		}
   795		if (gadget_is_dualspeed(cdev->gadget)) {
   796			f->hs_descriptors = uvc_copy_descriptors(uvc, USB_SPEED_HIGH);
   797			if (IS_ERR(f->hs_descriptors)) {
   798				ret = PTR_ERR(f->hs_descriptors);
   799				f->hs_descriptors = NULL;
   800				goto error;
   801			}
   802		}
   803		if (gadget_is_superspeed(c->cdev->gadget)) {
   804			f->ss_descriptors = uvc_copy_descriptors(uvc, USB_SPEED_SUPER);
   805			if (IS_ERR(f->ss_descriptors)) {
   806				ret = PTR_ERR(f->ss_descriptors);
   807				f->ss_descriptors = NULL;
   808				goto error;
   809			}
   810		}
   811	
   812		/* Preallocate control endpoint request. */
   813		uvc->control_req = usb_ep_alloc_request(cdev->gadget->ep0, GFP_KERNEL);
   814		uvc->control_buf = kmalloc(UVC_MAX_REQUEST_SIZE, GFP_KERNEL);
   815		if (uvc->control_req == NULL || uvc->control_buf == NULL) {
   816			ret = -ENOMEM;
   817			goto error;
   818		}
   819	
   820		uvc->control_req->buf = uvc->control_buf;
   821		uvc->control_req->complete = uvc_function_ep0_complete;
   822		uvc->control_req->context = uvc;
   823	
   824		if (v4l2_device_register(&cdev->gadget->dev, &uvc->v4l2_dev)) {
   825			uvcg_err(f, "failed to register V4L2 device\n");
   826			goto error;
   827		}
   828	
   829		/* Initialise video. */
   830		ret = uvcg_video_init(&uvc->video, uvc);
   831		if (ret < 0)
   832			goto v4l2_error;
   833	
   834		/* Register a V4L2 device. */
   835		ret = uvc_register_video(uvc);
   836		if (ret < 0) {
   837			uvcg_err(f, "failed to register video device\n");
   838			goto v4l2_error;
   839		}
   840	
   841		return 0;
   842	
   843	v4l2_error:
   844		v4l2_device_unregister(&uvc->v4l2_dev);
   845	error:
   846		if (uvc->control_req)
   847			usb_ep_free_request(cdev->gadget->ep0, uvc->control_req);
   848		kfree(uvc->control_buf);
   849	
   850		usb_free_all_descriptors(f);
   851		return ret;
   852	}
   853	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
