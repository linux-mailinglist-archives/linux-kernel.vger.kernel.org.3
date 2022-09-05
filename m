Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29915AD5E6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238557AbiIEPNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236405AbiIEPNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:13:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5394838B7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:13:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E50E16131F
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 15:13:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011AAC433C1;
        Mon,  5 Sep 2022 15:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662390816;
        bh=i3QTbdMoweBqG6ifb88wDs67D5ImR67NR/mA5Nf1DUc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Sk2YEw3ptxgITGaaQsmqB9Yi0q7EhFfJvrGJgy75VonToOTi0hcz68F0YBcOzrVeI
         DCwl0HsDH6fXkXb18p1pJJ+YFukFnBkxDKyMB6XMPysw5n6X1A+gvmaKV1j9VN/uKt
         VyKMY4BO4j+pGHVBxSPv9+ss/tRbueCWNz8rTbEF1vhDYfsHkiksT6UbhokgamrkVy
         +6ZUYvyIE2ygAN5Rl1c8gn5pZ+Qe14K1ZG+73dp7jWZp0dTsrK2pWZlf/pJ5NGCqsf
         ImCBDdeXDedHzQkEMtZ9pP7EyzIzhrtMK4AV6TFTkjnRKZDBBIw1c1jiPa2/TsycPn
         TuePZeAYdvaoQ==
Message-ID: <14ed6455-9678-fa32-aaf1-cc34f492d4ce@kernel.org>
Date:   Mon, 5 Sep 2022 23:13:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] erofs: avoid the potentially wrong m_plen for big
 pcluster
Content-Language: en-US
To:     Yue Hu <zbestahu@gmail.com>, xiang@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        huyue2@coolpad.com, zhangwen@coolpad.com
References: <20220812060150.8510-1-huyue2@coolpad.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220812060150.8510-1-huyue2@coolpad.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/12 14:01, Yue Hu wrote:
> Actually, 'compressedlcs' stores compressed block count rather than
> lcluster count. Therefore, the number of bits for shifting the count
> should be 'LOG_BLOCK_SIZE' rather than 'lclusterbits' although current
> lcluster size is 4K. The value of 'm_plen' will be wrong once we enable
> the non 4K-sized lcluster.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
