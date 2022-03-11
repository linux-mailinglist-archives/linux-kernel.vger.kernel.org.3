Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE6D4D5D3C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 09:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbiCKIZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 03:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbiCKIZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:25:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0F01B8FDE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 00:24:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C57FB82976
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:24:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7BCC340F3;
        Fri, 11 Mar 2022 08:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646987042;
        bh=vj6CfSHOXQ9Mtuetdyb8VmglTURJ+IW9CGO2ktkkhl8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=d1AofjplgR64OwNX0sGVbCWDiqMvUSM7NJ89M69UEG2NLGVRUV9X9TZ2C/IRfGAfB
         tcHFZwaD+OTW0B3/H3Av2jnM4eGYfJkfmul6AUiHRZUv7mmrmYMIZLwalBrq6wnpJJ
         x2PS1ktqRz4QWhD8e6r2j+acNGPq3vVnkyM0zdsUATMxijTImmWRB1nOPuWVhXOzUE
         LlUkXShM65Y7zJmZt9MaDb84sjlg3UG/onVKkn//ho/8iwvPHC53qiMRZKbxoI/xw6
         BIMOjpHtnUQsljmX57pIc0wz0TY4EG2UdfWDKMuEDbHp+FRFImiU21gmXG+LPp3PW/
         p2RqHm8iQ8rYA==
Message-ID: <2c4ed430-efc9-1328-b630-9b951f87a5b1@kernel.org>
Date:   Fri, 11 Mar 2022 16:23:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] erofs: silence warnings related to impossible m_plen
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220310173448.19962-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220310173448.19962-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/11 1:34, Gao Xiang wrote:
> Dan reported two smatch warnings [1],
> .. warn: should '1 << lclusterbits' be a 64 bit type?
> .. warn: should 'm->compressedlcs << lclusterbits' be a 64 bit type?
> 
> In practice, m_plen cannot be more than 1MiB due to on-disk constraint
> for the compression mode, so we're always safe here.
> 
> In order to make static analyzers happy and don't report again,
> let's silence them instead.
> 
> [1] https://lore.kernel.org/r/202203091002.lJVzsX6e-lkp@intel.com
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
