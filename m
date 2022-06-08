Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807265423AD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbiFHEmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 00:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbiFHEjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 00:39:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27B93FE0F2;
        Tue,  7 Jun 2022 19:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654655440; x=1686191440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sG0AzbZENUyQtpHzBixIeP6cHtFJAq/4tpTQw7wbmn0=;
  b=FkrCxB2a8hi0DK391FdjWv3tE3CIl4NoQK0s7ANDxw/5XG0gfz4/8uMg
   8rR/9iZuRINcEMmYuuWOPCOi8l87gpVmZSav6+WYaKBrS+EkTmWIPfr0U
   hd45a4GYbgZ3+fLfAhlP+RfL+9+6O295+eUKa9CkMuHlJA1xoMzehPwOc
   pue5esBllMxOxsFxtGVUgxwqBYKjUxThSilPe70Yy++0OLV/t2QicDTGj
   ireUrGQqriS+wyq0ovVc9EVr149ha8exVD9C8Jkl18ArAegq1T1yWHeXY
   o0xZ9o6twIX4Oql9LJn0wB98GA90w2ROdY5JQoO8BYSzeQ4KSSW5C43Ax
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="340812529"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="340812529"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 19:30:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="826684008"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 07 Jun 2022 19:30:14 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nylSY-000EB2-2P;
        Wed, 08 Jun 2022 02:30:14 +0000
Date:   Wed, 8 Jun 2022 10:29:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@quicinc.com, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, quic_rohkumar@quicinc.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org, vkoul@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: Re: [PATCH 2/2] ASoC: qcom: soundwire: Add software clock gating
 requirement check
Message-ID: <202206081054.vVkYPkJt-lkp@intel.com>
References: <1654605334-32030-3-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654605334-32030-3-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

[auto build test ERROR on broonie-sound/for-next]
[cannot apply to linus/master v5.19-rc1 next-20220607]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Srinivasa-Rao-Mandadapu/Add-software-clock-gating-requirement-check/20220607-203739
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: i386-randconfig-a006 (https://download.01.org/0day-ci/archive/20220608/202206081054.vVkYPkJt-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b92436efcb7813fc481b30f2593a4907568d917a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/86aa15d36b06f7b73938f00f9ad99eff75a94a94
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Srinivasa-Rao-Mandadapu/Add-software-clock-gating-requirement-check/20220607-203739
        git checkout 86aa15d36b06f7b73938f00f9ad99eff75a94a94
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/soundwire/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/soundwire/qcom.c:668:6: error: use of undeclared identifier 'data'
           if (data->sw_clk_gate_required)
               ^
   drivers/soundwire/qcom.c:1509:7: error: use of undeclared identifier 'data'
                   if (data->sw_clk_gate_required)
                       ^
   2 errors generated.


vim +/data +668 drivers/soundwire/qcom.c

   659	
   660	static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
   661	{
   662		u32 val;
   663	
   664		/* Clear Rows and Cols */
   665		val = FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK, ctrl->rows_index);
   666		val |= FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK, ctrl->cols_index);
   667	
 > 668		if (data->sw_clk_gate_required)
   669			reset_control_reset(ctrl->audio_cgcr);
   670	
   671		ctrl->reg_write(ctrl, SWRM_MCP_FRAME_CTRL_BANK_ADDR(0), val);
   672	
   673		/* Enable Auto enumeration */
   674		ctrl->reg_write(ctrl, SWRM_ENUMERATOR_CFG_ADDR, 1);
   675	
   676		ctrl->intr_mask = SWRM_INTERRUPT_STATUS_RMSK;
   677		/* Mask soundwire interrupts */
   678		ctrl->reg_write(ctrl, SWRM_INTERRUPT_MASK_ADDR,
   679				SWRM_INTERRUPT_STATUS_RMSK);
   680	
   681		/* Configure No pings */
   682		ctrl->reg_read(ctrl, SWRM_MCP_CFG_ADDR, &val);
   683		u32p_replace_bits(&val, SWRM_DEF_CMD_NO_PINGS, SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_BMSK);
   684		ctrl->reg_write(ctrl, SWRM_MCP_CFG_ADDR, val);
   685	
   686		ctrl->reg_write(ctrl, SWRM_MCP_BUS_CTRL, SWRM_MCP_BUS_CLK_START);
   687		/* Configure number of retries of a read/write cmd */
   688		if (ctrl->version > 0x01050001) {
   689			/* Only for versions >= 1.5.1 */
   690			ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CFG_ADDR,
   691					SWRM_RD_WR_CMD_RETRIES |
   692					SWRM_CONTINUE_EXEC_ON_CMD_IGNORE);
   693		} else {
   694			ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CFG_ADDR,
   695					SWRM_RD_WR_CMD_RETRIES);
   696		}
   697	
   698		/* Set IRQ to PULSE */
   699		ctrl->reg_write(ctrl, SWRM_COMP_CFG_ADDR,
   700				SWRM_COMP_CFG_IRQ_LEVEL_OR_PULSE_MSK |
   701				SWRM_COMP_CFG_ENABLE_MSK);
   702	
   703		/* enable CPU IRQs */
   704		if (ctrl->mmio) {
   705			ctrl->reg_write(ctrl, SWRM_INTERRUPT_CPU_EN,
   706					SWRM_INTERRUPT_STATUS_RMSK);
   707		}
   708		ctrl->slave_status = 0;
   709		ctrl->reg_read(ctrl, SWRM_COMP_PARAMS, &val);
   710		ctrl->rd_fifo_depth = FIELD_GET(SWRM_COMP_PARAMS_RD_FIFO_DEPTH, val);
   711		ctrl->wr_fifo_depth = FIELD_GET(SWRM_COMP_PARAMS_WR_FIFO_DEPTH, val);
   712	
   713		return 0;
   714	}
   715	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
