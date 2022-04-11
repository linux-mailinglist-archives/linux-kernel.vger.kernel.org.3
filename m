Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363774FBC02
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343690AbiDKM2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239096AbiDKM2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:28:35 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED912228D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649679981; x=1681215981;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nxDlmRhRAD3e4b50YnwI05OwnqM0Kx3WSfBLQtZ4B+4=;
  b=CjSJdnTE/L62lCCPObATJv3SMU3NeYq8Tr/hPnyP4Cgr48CQyzWdTI3E
   djS1YFSV/DHIVGukUm1E9qyroDpRSsffIBd8K1Bdmli5Lx8924GX/ASq2
   kK4FzZCCqqMMrpWHsm+MoheiJtRwaDDQ1QCS4yNyMBz7KUGqsJ1kMWKyK
   ZyGlrxJmbVt4zgSMZtzsaUBtosPIiYqtDaBF9jXZHecc/gtGNRTZOVvGW
   OAmFKwA92pIgQjMsCQhggDYZ2/DtZ1xcuDYR+pFLwyl3gKtDfKzDgi+gh
   MIkPeZ1czBHjxrQVeS7PeYgXyO4h3If70NxPyF60ZMrJYC9P64v71kXjy
   g==;
X-IronPort-AV: E=Sophos;i="5.90,251,1643644800"; 
   d="scan'208";a="309587277"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2022 20:26:20 +0800
IronPort-SDR: eCB+57LlV2F1zSToMPkTVU5Sokwf8CqMUosAWmg/uVsoIglfunOCy+9vjOn3E4Q0o/LkDFikIT
 vtQNuTyV6hJsv+298ekentwETaZQlk6WBtFTX6UypeLXJ6Um3sxJJSvJUi8t9KyDihzN5BS98y
 nBa8ZT0Yj7Kag36DH1j2b7lO1iF8aavKj36oUhc2eC0hKlPJRiBNtim0EkPHnTzTARvuc8xX14
 cJhiHRAG5FpHAAivriKv1eW2xofM0DpDIptxhK/uy53opUaWEh1Wenb4O4TanTb6035i/PXGml
 yi/O7wg7az2jynSgkP0FCBun
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2022 04:56:50 -0700
IronPort-SDR: +Ce5avOs1UQeWc852eOj9M93dDE5rfhylO6C6MtjclC90RAvpXjLQleJ/DPDuYA4HsR0lqka48
 cDFynTKiI+UiaoFlIip9iMEjuOQbARpl2NzHj/9NNBgvxV3ddq9tuE90rZ9N676A5Q2VvZCCC8
 YcbOag7zUEyfX9jV6nB81VuZZJir1M9IzruDOX3ByIkHZxe39jPeJAlZH6ydUt6xmUMELXpRC9
 yiqD+Qhl0BtN7+VNg/Z1rRJWH2B5UBN0NJqUMITNwFhoEQasiNHFHYxr/Ns+8qEk1YzKuxNhSH
 mak=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2022 05:26:21 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KcSl03C4tz1Rwrw
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:26:20 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649679980; x=1652271981; bh=nxDlmRhRAD3e4b50YnwI05OwnqM0Kx3WSfB
        LQtZ4B+4=; b=Y6YMMzkjp56dtzgUYupp0o+cOKzOyT6mbiOz+Ndy76IucRqegtu
        HK4kCrTTVPEvmwa9n5NJjVqrhQUEyp26gMpwhPZuYNaFeqaEUNpEazyMxofJQQ8C
        T8AerkJHVH1/1DZ9oNDjOAJxcqEllGfeT3JHvxLrN6CNgg58glAKMxCbiT3GdRes
        GA1DBZDXb9KXC9fg9RQRYIaOLX8Z/93N26KdRnXJ32aD+EilFP1kZAOaxEROiuNf
        RBjHkB6Gc/X7si7yguvQmn/WHGW0r6BGUZkz8pNVF01xk8ZWR62VhcDClnmK7tKk
        FDBjxyfwcwdBTy8jyK/MFmn2XUlTx0wKJYg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1JEKaAVkSTyf for <linux-kernel@vger.kernel.org>;
        Mon, 11 Apr 2022 05:26:20 -0700 (PDT)
Received: from [10.225.163.9] (unknown [10.225.163.9])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KcSkz1flXz1Rvlx;
        Mon, 11 Apr 2022 05:26:18 -0700 (PDT)
Message-ID: <58553b08-3c58-a4c8-a402-26d036ef0640@opensource.wdc.com>
Date:   Mon, 11 Apr 2022 21:26:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4] libata: Improve ATA queued command allocation
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, hch@lst.de
Cc:     linux-doc@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1649408652-217372-1-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1649408652-217372-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/22 18:04, John Garry wrote:
> Improve ATA queued command allocation as follows:
> 
> - For attaining a qc tag for a SAS host we need to allocate a bit in
>   ata_port.sas_tag_allocated bitmap.
> 
>   However we already have a unique tag per device in range
>   [0, ATA_MAX_QUEUE -1] in the scsi cmnd budget token, so just use that
>   instead.
> 
> - It is a bit pointless to have ata_qc_new_init() in libata-core.c since it
>   pokes scsi internals, so inline it in ata_scsi_qc_new() (in
>   libata-scsi.c). Also update Doc accordingly.
> 
> - Use standard SCSI helpers set_host_byte() and set_status_byte() in
>   ata_scsi_qc_new().
> 
> Christoph Hellwig originally contributed the change to inline
> ata_qc_new_init().
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Applied to for-5.19. Thanks !

-- 
Damien Le Moal
Western Digital Research
