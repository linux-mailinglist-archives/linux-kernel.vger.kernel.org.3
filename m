Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EF8589CC0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239874AbiHDNdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239916AbiHDNc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:32:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB55422CB
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:32:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 880F56183B
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 13:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40F2C433C1;
        Thu,  4 Aug 2022 13:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659619977;
        bh=g/dIz72q+86Kq19mtA0p0jyDcY2NYbdmwK4p46ft55g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WnvIBQRNNNYBHQ4S+rWuZS332pK2Rbxm3uhxnuRphpQRf+K14csh+TIHOHw+Wu5lQ
         SygCoe4hz0OTa2E58rIcqxYKj6sQoJMwvXdZOdwenuwpTiXl/pU4V+R4SLeZjLSodc
         4/rYEDTg4GeRKwZbUnG5q+EDYd4Ca16BV5b8WqSf6DscdWf7V2ogvUCoQxUqEVar5+
         x+XcGh0R/Njdq/hSyAiCwneMNdPzNqHtEG1Egyogby8w1xSV0m6Kjfgwsk05frPDlG
         TxBcRqyfxkjxaEgMrgT87J9C4cxak6bsjbzCf9V8YdwQ2QKgPj8dVpyFxoaK73YY+e
         47cu1vOozCi+w==
Message-ID: <7d430cc7-5f6c-536b-0e10-687c2804afa8@kernel.org>
Date:   Thu, 4 Aug 2022 21:32:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] f2fs: do not allow to decompress files have
 FI_COMPRESS_RELEASED
Content-Language: en-US
To:     Jaewook Kim <jw5454.kim@samsung.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
        junbeom.yeom@samsung.com, youngjin.gil@samsung.com
References: <25e501d8a6eb$84cf4090$8e6dc1b0$@samsung.com>
 <CGME20220803085402epcas1p2a1a70630592fa73f3404ba120c6c1ac8@epcas1p2.samsung.com>
 <20220803085358.3963-1-jw5454.kim@samsung.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220803085358.3963-1-jw5454.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/3 16:53, Jaewook Kim wrote:
> If a file has FI_COMPRESS_RELEASED, all writes for it should not be
> allowed. However, as of now, in case of compress_mode=user, writes
> triggered by IOCTLs like F2FS_IOC_DE/COMPRESS_FILE are allowed unexpectly,
> which could crash that file.
> To fix it, let's do not allow F2FS_IOC_DE/COMPRESS_IOCTL if a file already
> has FI_COMPRESS_RELEASED flag.
> 
> This is the reproduction process:
> 1.  $ touch ./file
> 2.  $ chattr +c ./file
> 3.  $ dd if=/dev/random of=./file bs=4096 count=30 conv=notrunc
> 4.  $ dd if=/dev/zero of=./file bs=4096 count=34 seek=30 conv=notrunc
> 5.  $ sync
> 6.  $ do_compress ./file      ; call F2FS_IOC_COMPRESS_FILE
> 7.  $ get_compr_blocks ./file ; call F2FS_IOC_GET_COMPRESS_BLOCKS
> 8.  $ release ./file          ; call F2FS_IOC_RELEASE_COMPRESS_BLOCKS
> 9.  $ do_compress ./file      ; call F2FS_IOC_COMPRESS_FILE again
> 10. $ get_compr_blocks ./file ; call F2FS_IOC_GET_COMPRESS_BLOCKS again
> 
> This reproduction process is tested in 128kb cluster size.
> You can find compr_blocks has a negative value.
> 
> Fixes: 5fdb322ff2c2b ("f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE")
> 
> Signed-off-by: Junbeom Yeom <junbeom.yeom@samsung.com>
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> Signed-off-by: Youngjin Gil <youngjin.gil@samsung.com>
> Signed-off-by: Jaewook Kim <jw5454.kim@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
