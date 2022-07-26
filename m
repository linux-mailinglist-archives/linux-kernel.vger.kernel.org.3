Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C8D5816C2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239298AbiGZPsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239215AbiGZPse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:48:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5162ED4E;
        Tue, 26 Jul 2022 08:48:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEAF060D17;
        Tue, 26 Jul 2022 15:48:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B83FC433D6;
        Tue, 26 Jul 2022 15:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658850512;
        bh=Uzd9kHOcKO6VXOdUzTw8gjKqg7nPcNlibSG7TmjBK0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iJvH1vyglyS5Nxfd4oCmumxkKCRuc0c16/Pr0qckmnosMASH0zaPTvZoOreZ67sgq
         WwEXbYN0pHqve71NL6F6mEVhmpFnWMJP06jl5krEA0DFiFlVloDW/AElw/giq05Tpx
         iR+XpsVbslG19Dz+tpkTcK8wRTWyI0CTe4NpiNXXneONWHRwtFYmyovHedPwA02FyW
         CGfUNv5XGwrA1nZaohcUNY3W9M8fCcW1lVLjtvh5gDilj0FEDJbaYupSgAp+cSWAMu
         +pjQ5A7zWNtN5F/NNO/sD20Ox5l4A/RQroGjtiYjI2u9wQRugk1hZ2znV7vxaX6fug
         HfjTumJFSe/qw==
Date:   Tue, 26 Jul 2022 08:48:29 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        jikos@kernel.org, llvm@lists.linux.dev, kbuild-all@lists.01.org,
        benjamin.tissoires@redhat.com, spbnick@gmail.com,
        j.witteveen@gmail.com, stefanberzl@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH v2 6/7] HID: uclogic: Add support for UGEE v2 mouse frames
Message-ID: <YuAMzSBcfsyGMjNy@dev-arch.thelio-3990X>
References: <20220717144333.251190-7-jose.exposito89@gmail.com>
 <202207261047.hUEFf74G-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202207261047.hUEFf74G-lkp@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 10:33:25AM +0800, kernel test robot wrote:
> Hi "José,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on 0cb1fc0988e32bda84c2b7218e0c761af1430baf]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Jos-Exp-sito/XP-PEN-Deco-Pro-S-support-for-5-20-uclogic/20220717-224559
> base:   0cb1fc0988e32bda84c2b7218e0c761af1430baf
> config: x86_64-buildonly-randconfig-r002-20220718 (https://download.01.org/0day-ci/archive/20220726/202207261047.hUEFf74G-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project fa0c7639e91fa1cd0cf2ff0445a1634a90fe850a)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/10fcf5d5cca4657c53477c392b1fb675d72cfda3
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Jos-Exp-sito/XP-PEN-Deco-Pro-S-support-for-5-20-uclogic/20220717-224559
>         git checkout 10fcf5d5cca4657c53477c392b1fb675d72cfda3
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> ld.lld: error: call to __read_overflow marked "dontcall-error": detected read beyond size of object (1st parameter)

Unfortunately, LTO makes this warning kind of cryptic but it seems like
the wrong template size is being used? This appears to resolve the
warning for me.

Cheers,
Nathan

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 2407e927d1bf..dd4b1ed6fd1e 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -1205,7 +1205,7 @@ static int uclogic_params_ugee_v2_init_frame_mouse(struct uclogic_params *p)
 
 	rc = uclogic_params_frame_init_with_desc(&p->frame_list[1],
 						 uclogic_rdesc_ugee_v2_frame_mouse_template_arr,
-						 uclogic_rdesc_ugee_v2_frame_dial_template_size,
+						 uclogic_rdesc_ugee_v2_frame_mouse_template_size,
 						 UCLOGIC_RDESC_V1_FRAME_ID);
 	if (rc)
 		return rc;
