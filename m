Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2A94C780A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 19:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240682AbiB1SkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 13:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240688AbiB1Sjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 13:39:54 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D3F45AD0;
        Mon, 28 Feb 2022 10:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646072959; x=1677608959;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DG0iph9aIuoUSLMv9ZA0QMn6ZepGeNmJgoaLALZu/EQ=;
  b=TUsxG9Ai4tjF58L1Kxt+tAtAHOsmfehUMnMLA1JrLKopUh9uK2SMRWH4
   YqrbeGdGTPPUj6sXZNMGcjeX+7hBL/PxX2VYB3PRw6njFfmvRqTR0/NSY
   Sh5eiVn8ErTyajo6loYvTVaQ+ywLTHDVtkL3b17sw2ISapyp7zyorGUpy
   RReJxrToaR03AVQcRKonNfrD2WJavlx6K9TEaETSjLMjRn2z72oFEmBKP
   VkVU7BnQaOE5/aVUEo3b2z6Nojc9gY+umZDuJuqsW08dVfRQHaJlTmciW
   JM3eztzskSZ/SM1Cio6VDx+MeDPql73hv4klnupMWmqQPNcoKbElbVFqQ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="253145646"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="253145646"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 10:29:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="640978446"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 28 Feb 2022 10:29:16 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOklo-0007gW-0K; Mon, 28 Feb 2022 18:29:16 +0000
Date:   Tue, 1 Mar 2022 02:28:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] spi: fsl-spi: Implement trailing bits
Message-ID: <202203010254.tIHIltE2-lkp@intel.com>
References: <fe4a3946a66ede73f6d6871700f2aaf0171372a1.1646060734.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe4a3946a66ede73f6d6871700f2aaf0171372a1.1646060734.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

I love your patch! Perhaps something to improve:

[auto build test WARNING on v5.17-rc6]
[cannot apply to broonie-spi/for-next next-20220228]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Christophe-Leroy/Add-support-for-components-requiring-trailing-clock-after-transfer/20220228-231740
base:    7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3
config: hexagon-buildonly-randconfig-r004-20220228 (https://download.01.org/0day-ci/archive/20220301/202203010254.tIHIltE2-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/7eb07c4d26401389204fcc6cf685c18c89b64ef8
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Christophe-Leroy/Add-support-for-components-requiring-trailing-clock-after-transfer/20220228-231740
        git checkout 7eb07c4d26401389204fcc6cf685c18c89b64ef8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/spi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/spi/spi-fsl-spi.c:435:14: warning: incompatible integer to pointer conversion initializing 'const void *' with an expression of type 'unsigned long' [-Wint-conversion]
                           .tx_buf = empty_zero_page,
                                     ^~~~~~~~~~~~~~~
   1 warning generated.


vim +435 drivers/spi/spi-fsl-spi.c

   356	
   357	static int fsl_spi_do_one_msg(struct spi_master *master,
   358				      struct spi_message *m)
   359	{
   360		struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(master);
   361		struct spi_device *spi = m->spi;
   362		struct spi_transfer *t, *first;
   363		unsigned int cs_change;
   364		const int nsecs = 50;
   365		int status, last_bpw;
   366	
   367		/*
   368		 * In CPU mode, optimize large byte transfers to use larger
   369		 * bits_per_word values to reduce number of interrupts taken.
   370		 */
   371		if (!(mpc8xxx_spi->flags & SPI_CPM_MODE)) {
   372			list_for_each_entry(t, &m->transfers, transfer_list) {
   373				if (t->len < 256 || t->bits_per_word != 8)
   374					continue;
   375				if ((t->len & 3) == 0)
   376					t->bits_per_word = 32;
   377				else if ((t->len & 1) == 0)
   378					t->bits_per_word = 16;
   379			}
   380		}
   381	
   382		/* Don't allow changes if CS is active */
   383		cs_change = 1;
   384		list_for_each_entry(t, &m->transfers, transfer_list) {
   385			if (cs_change)
   386				first = t;
   387			cs_change = t->cs_change;
   388			if (first->speed_hz != t->speed_hz) {
   389				dev_err(&spi->dev,
   390					"speed_hz cannot change while CS is active\n");
   391				return -EINVAL;
   392			}
   393		}
   394	
   395		last_bpw = -1;
   396		cs_change = 1;
   397		status = -EINVAL;
   398		list_for_each_entry(t, &m->transfers, transfer_list) {
   399			if (cs_change || last_bpw != t->bits_per_word)
   400				status = fsl_spi_setup_transfer(spi, t);
   401			if (status < 0)
   402				break;
   403			last_bpw = t->bits_per_word;
   404	
   405			if (cs_change) {
   406				fsl_spi_chipselect(spi, BITBANG_CS_ACTIVE);
   407				ndelay(nsecs);
   408			}
   409			cs_change = t->cs_change;
   410			if (t->len)
   411				status = fsl_spi_bufs(spi, t, m->is_dma_mapped);
   412			if (status) {
   413				status = -EMSGSIZE;
   414				break;
   415			}
   416			m->actual_length += t->len;
   417	
   418			spi_transfer_delay_exec(t);
   419	
   420			if (cs_change) {
   421				ndelay(nsecs);
   422				fsl_spi_chipselect(spi, BITBANG_CS_INACTIVE);
   423				ndelay(nsecs);
   424			}
   425		}
   426	
   427		if (status || !cs_change) {
   428			ndelay(nsecs);
   429			fsl_spi_chipselect(spi, BITBANG_CS_INACTIVE);
   430		}
   431	
   432		if (!status && spi->trailing_bits) {
   433			struct spi_transfer t = {
   434				.len = 1,
 > 435				.tx_buf = empty_zero_page,
   436			};
   437	
   438			if (spi->trailing_bits < 4)
   439				t.bits_per_word = 4;
   440			else if (spi->trailing_bits > 8)
   441				t.bits_per_word = 16;
   442			else
   443				t.bits_per_word = spi->trailing_bits;
   444	
   445			status = fsl_spi_setup_transfer(spi, &t);
   446			if (!status)
   447				status = fsl_spi_bufs(spi, &t, 0);
   448		}
   449		m->status = status;
   450	
   451		fsl_spi_setup_transfer(spi, NULL);
   452		spi_finalize_current_message(master);
   453		return 0;
   454	}
   455	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
