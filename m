Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8200258A6C3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 09:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240342AbiHEHLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 03:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240199AbiHEHKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 03:10:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1038474E22;
        Fri,  5 Aug 2022 00:09:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8989FB80DE4;
        Fri,  5 Aug 2022 07:09:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10733C433D6;
        Fri,  5 Aug 2022 07:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659683377;
        bh=QY/xj/dmLrpvXEfYnnD6E0lu77VY+niG/pRPN+FTJRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Swju3PYz3cB3wLhsGTed8uo46PsMXQ6CUeuXyHwbAK/hPulOHWHst5X18xBc+A23i
         Jqn+enSqJ8QCdi+bmdRk4vcgGvzdzrblA6AesOvDCAV8XspD7P6Qk4hyoMWnODFTFS
         A+DrwSD+UjYtyy2r8vne0fr8FMf3NkHFqrbpGqfNygtiQN3Tf7hwQrFYuO0rr4IsXz
         0yC+LzJ79cuJ4ZoRP+ad71FcdjWi1vy9go+q25DQT60J4ZNU3WZW6VcS/3D0vFfJir
         hDAb2LQ4wWZZZSJ+FAa+xcwRhpR3MOOKNokZSnodck4A7K0dNL6oHtSGO60bOoZ8qd
         gy+Zubvlu3BmQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oJrT6-0007hp-1M; Fri, 05 Aug 2022 09:10:00 +0200
Date:   Fri, 5 Aug 2022 09:10:00 +0200
From:   Johan Hovold <johan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, kbuild-all@lists.01.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] usb: dwc3: qcom: fix peripheral and OTG suspend
Message-ID: <YuzCSCr2fkTLxvAs@hovoldconsulting.com>
References: <20220804151001.23612-7-johan+linaro@kernel.org>
 <202208050544.ijUhoUyB-lkp@intel.com>
 <Yuy/eM1Wo+gDAJPQ@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yuy/eM1Wo+gDAJPQ@hovoldconsulting.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 08:58:00AM +0200, Johan Hovold wrote:
> On Fri, Aug 05, 2022 at 05:38:30AM +0800, kernel test robot wrote:
> > Hi Johan,
> > 
> > I love your patch! Perhaps something to improve:
> > 
> > [auto build test WARNING on usb/usb-testing]
> > [also build test WARNING on linus/master next-20220804]
> > [cannot apply to robh/for-next v5.19]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Johan-Hovold/usb-dwc3-qcom-fix-wakeup-implementation/20220804-231122
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> > config: arc-randconfig-r002-20220804 (https://download.01.org/0day-ci/archive/20220805/202208050544.ijUhoUyB-lkp@intel.com/config)
> > compiler: arc-elf-gcc (GCC) 12.1.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://github.com/intel-lab-lkp/linux/commit/f3778ca026b16474e49c5e0188a0eb91d73eef2f
> >         git remote add linux-review https://github.com/intel-lab-lkp/linux
> >         git fetch --no-tags linux-review Johan-Hovold/usb-dwc3-qcom-fix-wakeup-implementation/20220804-231122
> >         git checkout f3778ca026b16474e49c5e0188a0eb91d73eef2f
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/usb/dwc3/
> > 
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >    drivers/usb/dwc3/dwc3-qcom.c: In function 'dwc3_qcom_read_usb2_speed':
> > >> drivers/usb/dwc3/dwc3-qcom.c:313:25: warning: variable 'hcd' set but not used [-Wunused-but-set-variable]
> >      313 |         struct usb_hcd *hcd;
> >          |                         ^~~> 
> 
> I'm not seeing this one with gcc-10.3.0, but I'll slap a __maybe_unused
> in there to keep your robot's W=1 builds quiet.

Correction: of course I'm seeing it in the affected build configuration...

Johan
