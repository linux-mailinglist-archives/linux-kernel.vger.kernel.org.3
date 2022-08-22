Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6647159BD05
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 11:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbiHVJkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 05:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbiHVJkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:40:08 -0400
X-Greylist: delayed 580 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 Aug 2022 02:40:05 PDT
Received: from mail.alarsen.net (joe.alarsen.net [IPv6:2a01:4f8:191:10e8:1::fe])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4327C2E9C7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 02:40:05 -0700 (PDT)
Received: from oscar.alarsen.net (unknown [IPv6:fd8b:531:bccf:96:84f:46cb:e483:e703])
        by joe.alarsen.net (Postfix) with ESMTPS id 310EA1801F1;
        Mon, 22 Aug 2022 11:30:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alarsen.net; s=joe;
        t=1661160623; bh=GxrjOxVJn67ABM2eQNRRKpgHZJydh6cD+SPLNRJs9Qs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T/+PyhcMQMOpmOLu7nL17hh0qepBxwEMHiB2Ee2iuk5w6SrC19JqXXMKR15U/HBqz
         ltSl9VPeoa0mk2V0XpAebAa7HNyn1THK0cW7Ak9/f6J5sOara1t7uVe5JLNE4QKEHb
         wdkrTDIh0raHgQBgr2SW6MV6Qv2ZkJbsLcfsLSvU=
Received: from oscar.localnet (localhost [IPv6:::1])
        by oscar.alarsen.net (Postfix) with ESMTP id 25BF727C0304;
        Mon, 22 Aug 2022 11:30:23 +0200 (CEST)
From:   Anders Larsen <al@alarsen.net>
To:     ye xingchen <ye.xingchen@zte.com.cn>
Cc:     linux-kernel@vger.kernel.org, cgel.zte@gmail.com,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] qnx4: delete the unnecessary checks before brelse()
Date:   Mon, 22 Aug 2022 11:30:23 +0200
Message-ID: <5293718.Sb9uPGUboI@alarsen.net>
In-Reply-To: <20220822091152.204858-1-ye.xingchen@zte.com.cn>
References: <20220822091152.204858-1-ye.xingchen@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 2022-08-22 11:11 cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> The brelse() function tests whether its argument is NULL
> and then returns immediately.
> Thus remove the tests which are not needed around the shown calls.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  fs/qnx4/inode.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
> index 391ea402920d..9dab8f65ba75 100644
> --- a/fs/qnx4/inode.c
> +++ b/fs/qnx4/inode.c
> @@ -118,8 +118,7 @@ unsigned long qnx4_block_map( struct inode *inode, long iblock )
>  				bh = NULL;
>  			}
>  		}
> -		if ( bh )
> -			brelse( bh );
> +			brelse(bh);

When you remove the if() you must decrease the indentation of the following line!

>  	}
>  
>  	QNX4DEBUG((KERN_INFO "qnx4: mapping block %ld of inode %ld = %ld\n",iblock,inode->i_ino,block));

Other than that,

Acked-by: Anders Larsen <al@alarsen.net>



