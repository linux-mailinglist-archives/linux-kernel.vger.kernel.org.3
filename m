Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3A0590CD4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 09:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237557AbiHLHp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 03:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237221AbiHLHp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:45:57 -0400
Received: from out199-18.us.a.mail.aliyun.com (out199-18.us.a.mail.aliyun.com [47.90.199.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B7CA6C0E
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 00:45:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VM0lU6C_1660290349;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VM0lU6C_1660290349)
          by smtp.aliyun-inc.com;
          Fri, 12 Aug 2022 15:45:51 +0800
Date:   Fri, 12 Aug 2022 15:45:48 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, huyue2@coolpad.com,
        zhangwen@coolpad.com
Subject: Re: [PATCH] erofs: avoid the potentially wrong m_plen for big
 pcluster
Message-ID: <YvYFLF2DHDuRoTpT@B-P7TQMD6M-0146.local>
References: <20220812060150.8510-1-huyue2@coolpad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220812060150.8510-1-huyue2@coolpad.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yue,

On Fri, Aug 12, 2022 at 02:01:50PM +0800, Yue Hu wrote:
> Actually, 'compressedlcs' stores compressed block count rather than
> lcluster count. Therefore, the number of bits for shifting the count
> should be 'LOG_BLOCK_SIZE' rather than 'lclusterbits' although current
> lcluster size is 4K. The value of 'm_plen' will be wrong once we enable
> the non 4K-sized lcluster.

I'd like to make the last sentence into a separate paragraph.
I could update it when applying.

> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Otherwise it looks good to me,
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>  fs/erofs/zmap.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index 572f0b8151ba..d58549ca1df9 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -141,7 +141,7 @@ struct z_erofs_maprecorder {
>  	u8  type, headtype;
>  	u16 clusterofs;
>  	u16 delta[2];
> -	erofs_blk_t pblk, compressedlcs;
> +	erofs_blk_t pblk, compressedblks;
>  	erofs_off_t nextpackoff;
>  };
>  
> @@ -192,7 +192,7 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
>  				DBG_BUGON(1);
>  				return -EFSCORRUPTED;
>  			}
> -			m->compressedlcs = m->delta[0] &
> +			m->compressedblks = m->delta[0] &
>  				~Z_EROFS_VLE_DI_D0_CBLKCNT;
>  			m->delta[0] = 1;
>  		}
> @@ -293,7 +293,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
>  				DBG_BUGON(1);
>  				return -EFSCORRUPTED;
>  			}
> -			m->compressedlcs = lo & ~Z_EROFS_VLE_DI_D0_CBLKCNT;
> +			m->compressedblks = lo & ~Z_EROFS_VLE_DI_D0_CBLKCNT;
>  			m->delta[0] = 1;
>  			return 0;
>  		} else if (i + 1 != (int)vcnt) {
> @@ -497,7 +497,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>  		return 0;
>  	}
>  	lcn = m->lcn + 1;
> -	if (m->compressedlcs)
> +	if (m->compressedblks)
>  		goto out;
>  
>  	err = z_erofs_load_cluster_from_disk(m, lcn, false);
> @@ -506,7 +506,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>  
>  	/*
>  	 * If the 1st NONHEAD lcluster has already been handled initially w/o
> -	 * valid compressedlcs, which means at least it mustn't be CBLKCNT, or
> +	 * valid compressedblks, which means at least it mustn't be CBLKCNT, or
>  	 * an internal implemenatation error is detected.
>  	 *
>  	 * The following code can also handle it properly anyway, but let's
> @@ -523,12 +523,12 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>  		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
>  		 * rather than CBLKCNT, it's a 1 lcluster-sized pcluster.
>  		 */
> -		m->compressedlcs = 1;
> +		m->compressedblks = 1 << (lclusterbits - LOG_BLOCK_SIZE);
>  		break;
>  	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
>  		if (m->delta[0] != 1)
>  			goto err_bonus_cblkcnt;
> -		if (m->compressedlcs)
> +		if (m->compressedblks)
>  			break;
>  		fallthrough;
>  	default:
> @@ -539,7 +539,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>  		return -EFSCORRUPTED;
>  	}
>  out:
> -	map->m_plen = (u64)m->compressedlcs << lclusterbits;
> +	map->m_plen = (u64)m->compressedblks << LOG_BLOCK_SIZE;
>  	return 0;
>  err_bonus_cblkcnt:
>  	erofs_err(m->inode->i_sb,
> -- 
> 2.17.1
