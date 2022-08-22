Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24A359CC66
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 01:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237662AbiHVXpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 19:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238888AbiHVXpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 19:45:32 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893483ECFA;
        Mon, 22 Aug 2022 16:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661211931; x=1692747931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JEtffjsv/UU5sWGCyM3iXEbl5ZR5P6LGzBjiHq53Suo=;
  b=hSL5iawT1IxYkN7mKGnmhagaDSae5m5rYlCVC08/XmRZdOFMJ9Gb5EX3
   Jg2hZyIAfNuB7yv0Yal3VkFT9d6tRfEzxgUTqVs5qj8XAuc1EM5AWxVY8
   BuDMP/3jT4iFcIBAxy4otQWrviwsFVRodRL1AifDjbZwPW0FOXVTKNTNB
   icUFBxpSaKXJuS/IYTPjWL6/wAzXvZtobFbwNDNwOCd8VCdVovWLNR+Yi
   kCTiU8VGS10nsXIuaxLkl6esvxUpiJaZX+9PXQwowBA6VMpuHyX0TSZQB
   PbLmw8LJqjNDDkcUzLZUl8eGEiZjQ/ljz8P6St0vza82Qyoqm4yj+lMnj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="319585897"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="319585897"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 16:45:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="642225949"
Received: from lkp-server01.sh.intel.com (HELO dd9b29378baa) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 22 Aug 2022 16:45:15 -0700
Received: from kbuild by dd9b29378baa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQH6Y-0000rl-1P;
        Mon, 22 Aug 2022 23:45:14 +0000
Date:   Tue, 23 Aug 2022 07:44:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fabien Parent <parent.f@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     kbuild-all@lists.01.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: Re: [PATCH v4 2/4] clk: mediatek: Provide mtk_devm_alloc_clk_data
Message-ID: <202208230714.8DNW6JjZ-lkp@intel.com>
References: <20220822152652.3499972-3-msp@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822152652.3499972-3-msp@baylibre.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on robh/for-next linus/master v6.0-rc2 next-20220822]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Markus-Schneider-Pargmann/clk-mediatek-Add-mt8365-support/20220822-233030
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: loongarch-randconfig-c004-20220821 (https://download.01.org/0day-ci/archive/20220823/202208230714.8DNW6JjZ-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

cocci warnings: (new ones prefixed by >>)
>> drivers/clk/mediatek/clk-mtk.c:64:1-6: WARNING: invalid free of devm_ allocated data

vim +64 drivers/clk/mediatek/clk-mtk.c

9741b1a68035b54 James Liao    2015-04-23  61  
609cc5e1a82394e Chen-Yu Tsai  2022-05-19  62  void mtk_free_clk_data(struct clk_hw_onecell_data *clk_data)
300796cad22153f Chun-Jie Chen 2021-09-14  63  {
300796cad22153f Chun-Jie Chen 2021-09-14 @64  	kfree(clk_data);
300796cad22153f Chun-Jie Chen 2021-09-14  65  }
609cc5e1a82394e Chen-Yu Tsai  2022-05-19  66  EXPORT_SYMBOL_GPL(mtk_free_clk_data);
300796cad22153f Chun-Jie Chen 2021-09-14  67  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
