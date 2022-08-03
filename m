Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54568588611
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 05:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbiHCDqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 23:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbiHCDqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 23:46:00 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034D318395
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 20:45:55 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220803034550epoutp0145067d6df49f7c15c8430614cb339ff7~HuPUV4VKI2939829398epoutp01p
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 03:45:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220803034550epoutp0145067d6df49f7c15c8430614cb339ff7~HuPUV4VKI2939829398epoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659498350;
        bh=PUUwWz7qYnjhog9hyEmOfU8Csx6pYpGDAJULPZxjVe0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=pWaIBD8uJ31gMozOwlPsvBFwCRwxZAC2nd076NORlpfVNviQ6P0E/xIGh/TG4Yz6e
         dTgEB/BFvkJ/Cr4IvIilR6oP0zkQe4eXFH9Anm0Pnn7DDfdCWZR5os4B1e1OueV/sP
         Tq8zOzWOdEb0V7invYXZWssOduVk3JjGezrAUR9g=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220803034549epcas1p36bc120a5873be65994c27a9356f5c89e~HuPTu72Rs2509525095epcas1p3P;
        Wed,  3 Aug 2022 03:45:49 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.242]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LyHnn3Pknz4x9Q0; Wed,  3 Aug
        2022 03:45:49 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.46.09678.D6FE9E26; Wed,  3 Aug 2022 12:45:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220803034548epcas1p4473bebafd065a21923f3031f02fc4243~HuPS1SV062861328613epcas1p4Q;
        Wed,  3 Aug 2022 03:45:48 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220803034548epsmtrp1416fc08776567dc5597514a678a70d96~HuPS0EpF10447104471epsmtrp1B;
        Wed,  3 Aug 2022 03:45:48 +0000 (GMT)
X-AuditID: b6c32a39-e51ff700000025ce-3c-62e9ef6da8e1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.DD.08905.C6FE9E26; Wed,  3 Aug 2022 12:45:48 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220803034548epsmtip21782747ddfc5184c2bf577e5cfd27e30~HuPSf_Ygt2281722817epsmtip2h;
        Wed,  3 Aug 2022 03:45:48 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Jaewook Kim'" <jw5454.kim@samsung.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>
Cc:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <junbeom.yeom@samsung.com>,
        <youngjin.gil@samsung.com>, <sj1557.seo@samsung.com>
In-Reply-To: <20220803023431.30214-1-jw5454.kim@samsung.com>
Subject: RE: [PATCH] f2fs: do not allow to decompress files have
 FI_COMPRESS_RELEASED
Date:   Wed, 3 Aug 2022 12:45:48 +0900
Message-ID: <25e501d8a6eb$84cf4090$8e6dc1b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQET2ImLkCT1gyMsL1LuCjdD7mUqEQItVpSrrxS4FXA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBJsWRmVeSWpSXmKPExsWy7bCmgW7u+5dJBv87JC1OTz3LZPFk/Sxm
        i4NXjjBarLzym8Xi0iJ3i8u75rBZbPl3hNVixv6n7A4cHptWdbJ57F7wmcmjb8sqRo/Pm+QC
        WKIaGG0Si5IzMstSFVLzkvNTMvPSbZVCQ9x0LZQUMvKLS2yVog0NjfQMDcz1jIyM9IwtY62M
        TJUU8hJzU22VKnShepUUipILgGpzK4uBBuSk6kHF9YpT81IcsvJLQU7XK07MLS7NS9dLzs9V
        UihLzCkFGqGkn/CNMeN+xzKmgr2CFa8uLGdvYOzh62Lk5JAQMJG4seIgC4gtJLCDUeJve1wX
        IxeQ/YlR4t2v6cwQzjdGiXVXt7LCdKy78Z4JIrGXUeLnoulsEM5LRolZ7X1sIFVsAroST278
        ZAaxRQTCJd5MnsUKUsQssIhR4uHRdYxdjBwcnAI2Epv+G4GYwkA1B/8YgpgsAioSh29ogXTy
        ClhKXF18nR3CFpQ4OfMJ2KXMAvIS29/OYYa4R0Fi96ejrBCbrCTmvrvNDlEjIjG7sw3sAQmB
        mRwSV3bsgWpwkXj26Q/UM8ISr45vYYewpSRe9rdB2c2MEs2NRhB2B6PE042yILdJCNhLvL9k
        AWIyC2hKrN+lD1GhKLHz91xGCFtQ4vS1bmaIE/gk3n3tYYXo5JXoaBOCKFGR+P5hJ8sERuVZ
        SB6bheSxWUgemIWwbAEjyypGsdSC4tz01GLDAlPkyN7ECE60WpY7GKe//aB3iJGJg/EQowQH
        s5II7x2X50lCvCmJlVWpRfnxRaU5qcWHGJOBIT2RWUo0OR+Y6vNK4g1NjA0MjIBp0NzS3JgI
        YUsDEzMjEwtjS2MzJXHeVdNOJwoJpCeWpGanphakFsFsYeLglGpgmrLt3Gulm8qG6wwZU3pP
        aunYrxHwz+uba9VYvXyemsTTG/+Pe9w7sfOS+L4i/4VzhGVWpqxPlH7UfU/30e1/Z55Pjde3
        CIuxv+TY7WLy+sLbY98quoyfcp1aVucxPeuMWOAaR0YNjgv1qtKh2QsnfZslP2dKkbHGilk/
        eDy0FbZul3B/mPP6/jW93tsLNBa9Ovol74vfLTW9Ns7fKdpGy3zeNEZc+7gs0v6/3Br+D+sk
        ns5eq/lCYdMfQTWrfS8mlW2qufzQUan3uvscAYEumVlnXV+X2dgVCPHd/nKu2HdFxv4PbG1y
        d+aaPD4WmD19wm23gypl6/yuVic0/L4758odl4zpDvMMP9zXyvrxylmJpTgj0VCLuag4EQDb
        bfQgawQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42LZdlhJXjfn/cskgxkfdSxOTz3LZPFk/Sxm
        i4NXjjBarLzym8Xi0iJ3i8u75rBZbPl3hNVixv6n7A4cHptWdbJ57F7wmcmjb8sqRo/Pm+QC
        WKK4bFJSczLLUov07RK4Mu53LGMq2CtY8erCcvYGxh6+LkZODgkBE4l1N94zdTFycQgJ7GaU
        WLJnJksXIwdQQkri4D5NCFNY4vDhYoiS54wSxxdfYwbpZRPQlXhy4yeYLSIQKdH5YjkjSBGz
        wDJGiauTdjNCdPQySszd/4AVZBKngI3Epv9GIA3CAqESyyfuYQcJswioSBy+oQUS5hWwlLi6
        +Do7hC0ocXLmExYQm1lAW6L3YSsjhC0vsf3tHGaI+xUkdn86ygpxg5XE3He32SFqRCRmd7Yx
        T2AUnoVk1Cwko2YhGTULScsCRpZVjJKpBcW56bnFhgWGeanlesWJucWleel6yfm5mxjBkaSl
        uYNx+6oPeocYmTgYDzFKcDArifDecXmeJMSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJeCGB
        9MSS1OzU1ILUIpgsEwenVAMT1xnT40sPrZewXfRhmuA2Y5cdXPF3H1iwWV61/v759SGVoLsh
        GvcVvDa2cO+J0UxblZyuxLhbxTRqlZPU9ztvqjIvnSuKi/c9cbD70IKAaSr8wSJXlW+x/u4N
        15mr/73l0dyK/7JK/sV/Qprnp7m9ydbcurovrjyJb0Jf1PoD88ouzjcM6o4JfaK/TmCRjKax
        1lI9zg39f1UfvMrdI2/rdOTx9BdP9p91lnryc9qrQ2dbXTvbr0W7zVm2Rn19aL9w0fSjgtdT
        2HKSl275cfGPlYKUR8dPBfHgBZJ1Loyb5txeKV+1+OdhVinPS42qW/43GIdfXr9TomD3x/NL
        sjodJDaXlJvlzPypI2Vo9tNXiaU4I9FQi7moOBEAt2VwZxMDAAA=
X-CMS-MailID: 20220803034548epcas1p4473bebafd065a21923f3031f02fc4243
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-ArchiveUser: EV
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220803023449epcas1p4a9b09cdc73878c8ee40ae10523279dc3
References: <CGME20220803023449epcas1p4a9b09cdc73878c8ee40ae10523279dc3@epcas1p4.samsung.com>
        <20220803023431.30214-1-jw5454.kim@samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If a file has FI_COMPRESS_RELEASED, all writes for it should not be
> allowed. However, as of now, in case of compress_mode=user, writes
> triggered by IOCTLs like F2FS_IOC_DE/COMPRESS_FILE are allowed unexpectly,
> which could crash that file.
> To fix it, let's do not allow F2FS_IOC_DE/COMPRESS_IOCTL if a file already
> has FI_COMPRESS_RELEASED flag.
> 
> This is the reproduction process:
> 1. $ chattr +c ./file
> 2. $ dd if=/dev/zero of=./file bs=4096 count=2000 oflag=append
> conv=notrunc 3. $ sync
> 4. $ do_compress ./file      ; call F2FS_IOC_COMPRESS_FILE
> 5. $ get_compr_blocks ./file ; call F2FS_IOC_GET_COMPRESS_BLOCKS

Oops! Do we need to call F2FS_IOC_RELEASE_COMPRESS_BLOCKS here?
Maybe, you need to revise reproduction process and to make v2 patch.

> 6. $ do_compress ./file      ; call F2FS_IOC_COMPRESS_FILE again
> 7. $ get_compr_blocks ./file ; call F2FS_IOC_GET_COMPRESS_BLOCKS again
> 
> You can find compr_blocks has a negative value.
> 
> Fixes: 5fdb322ff2c2b ("f2fs: add F2FS_IOC_DECOMPRESS_FILE and
> F2FS_IOC_COMPRESS_FILE")
> 
> Signed-off-by: Junbeom Yeom <junbeom.yeom@samsung.com>
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> Signed-off-by: Youngjin Gil <youngjin.gil@samsung.com>
> Signed-off-by: Jaewook Kim <jw5454.kim@samsung.com>
> ---
>  fs/f2fs/file.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c index
> 6b1b030830ca..a4713b7e12cb 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3945,6 +3945,11 @@ static int f2fs_ioc_decompress_file(struct file
> *filp, unsigned long arg)
>  		goto out;
>  	}
> 
> +	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
>  	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
>  	if (ret)
>  		goto out;
> @@ -4012,6 +4017,11 @@ static int f2fs_ioc_compress_file(struct file *filp,
> unsigned long arg)
>  		goto out;
>  	}
> 
> +	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
>  	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
>  	if (ret)
>  		goto out;
> --
> 2.17.1


