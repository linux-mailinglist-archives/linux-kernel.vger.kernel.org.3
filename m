Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5057049F44C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346666AbiA1HYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:24:37 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54302 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235851AbiA1HYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:24:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EF81B823B5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 07:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFDCC340E0;
        Fri, 28 Jan 2022 07:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643354674;
        bh=Pyz/0cK9sHlVyb9040g7CTXTIxSeN8ehl1ubzZKkac0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=lI+hanDa7k8o3cE9VKmljM70xYH2eS28YONmjBXXG4zxxFHdTiUt9Jp+dyjj9aNsw
         +FFAdisSNQAhM2a1Nu7R3NVnfMMd2UUBpvK3zy84KTovIJAKQrmzszvlfsSxsN6p89
         4ueJH9CtPjQMcVcDA6Su6VQdzzWCApPngpg2UINoexTp97JzlbGYIPHK23sEZAxmkM
         sTcIwybpS6ZCA5IMwluTItg1qCw7pKiYKPKfIV9p6Y4ICaMyEUmyLCdZgozHPOgyyj
         1kPeMIZePux5R8p77qtfB+H4TMwMm2XY7ygHEQuFdc5zqur3U9RSLtuy5K3rVj0hw2
         1jyiOI3MHV7Rw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Anilkumar Kolli <akolli@codeaurora.org>,
        lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: drivers/net/wireless/ath/ath11k/qmi.c:1891 ath11k_qmi_assign_target_mem_chunk() error: uninitialized symbol 'ret'.
References: <202201272025.7AWXB5T7-lkp@intel.com>
Date:   Fri, 28 Jan 2022 09:24:28 +0200
In-Reply-To: <202201272025.7AWXB5T7-lkp@intel.com> (Dan Carpenter's message of
        "Fri, 28 Jan 2022 10:07:04 +0300")
Message-ID: <87sft8cogj.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(adding ath11k list)

Dan Carpenter <dan.carpenter@oracle.com> writes:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   0280e3c58f92b2fe0e8fbbdf8d386449168de4a8
> commit: 6ac04bdc5edb418787ab2040b1f922c23464c750 ath11k: Use reserved host DDR addresses from DT for PCI devices
> config: microblaze-randconfig-m031-20220127 (https://download.01.org/0day-ci/archive/20220127/202201272025.7AWXB5T7-lkp@intel.com/config)
> compiler: microblaze-linux-gcc (GCC) 11.2.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> New smatch warnings:
> drivers/net/wireless/ath/ath11k/qmi.c:1891 ath11k_qmi_assign_target_mem_chunk() error: uninitialized symbol 'ret'.
>
> Old smatch warnings:
> drivers/net/wireless/ath/ath11k/qmi.c:2161 ath11k_qmi_load_file_target_mem() error: uninitialized symbol 'ret'.
>
> vim +/ret +1891 drivers/net/wireless/ath/ath11k/qmi.c
>
> 6eb6ea51382873 Govind Singh          2020-08-14  1876  static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
> d5c65159f28953 Kalle Valo            2019-11-23  1877  {
> 6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1878  	struct device *dev = ab->dev;
> 6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1879  	struct device_node *hremote_node = NULL;
> 6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1880  	struct resource res;
> 6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1881  	u32 host_ddr_sz;
> 6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1882  	int i, idx, ret;
> d5c65159f28953 Kalle Valo            2019-11-23  1883  
> d5c65159f28953 Kalle Valo            2019-11-23  1884  	for (i = 0, idx = 0; i < ab->qmi.mem_seg_count; i++) {
> d5c65159f28953 Kalle Valo            2019-11-23  1885  		switch (ab->qmi.target_mem[i].type) {
> 6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1886  		case HOST_DDR_REGION_TYPE:
> 6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1887  			hremote_node = of_parse_phandle(dev->of_node, "memory-region", 0);
> 6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1888  			if (!hremote_node) {
> 6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1889  				ath11k_dbg(ab, ATH11K_DBG_QMI,
> 6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1890  					   "qmi fail to get hremote_node\n");
> 6ac04bdc5edb41 Anilkumar Kolli       2021-12-14 @1891  				return ret;
>
> "ret" not set.

Anil, can you send a patch to fix this?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
