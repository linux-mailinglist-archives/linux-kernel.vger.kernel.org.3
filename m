Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0FC52B928
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 13:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbiERLqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235849AbiERLqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:46:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0C429CB7;
        Wed, 18 May 2022 04:46:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E0A8B81F02;
        Wed, 18 May 2022 11:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6E9C385AA;
        Wed, 18 May 2022 11:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652874399;
        bh=++nifCX4OwZdI6hDHnzOn+jSgJ415rwWdFwmWJJ95RQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L4HxbNU9sdP033LrajcXnHhbjJ8Z5anyJkcLz7GXTRMI4YLG9Z3QE5RXRwydn0vfp
         iUNdE1pZ4sfAECa7yWY7Nvghbw+6lg+GYzGTu4b/4Z5/lj6lYyufOPGJMY7Mv6zTgP
         cf5F0bDmHYowOBuByHaGWWBC2BPviSOEAjLM/VnJvA2GcFyyF7NdYYF9ejo8m27jLz
         eo6FwA6ikO1M899KBsw8iPgLoiVoXj8gl7TnPbdqsxiG59JBU2ePnFZv7hjyPH/Zrx
         vxT2G6HkUgFKYvhjXmSfJmpRmF+t0vibrKzjMIZRGiL6hyJZygfW8lNhHTHokvLMbT
         Pw7om22H0hKFw==
Date:   Wed, 18 May 2022 17:16:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the dmaengine tree with Linus' tree
Message-ID: <YoTcmqygoMm/gmsZ@matsya>
References: <20220517153435.645a9313@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517153435.645a9313@canb.auug.org.au>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-05-22, 15:34, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the dmaengine tree got a conflict in:
> 
>   drivers/dma/idxd/device.c
> 
> between commit:
> 
>   1cd8e751d96c ("dmaengine: idxd: skip clearing device context when device is read-only")
> 
> from Linus' tree and commit:
> 
>   cf4ac3fef338 ("dmaengine: idxd: fix lockdep warning on device driver removal")

Thank you Stephen, the merge looks right to me. Dave pls verify and test
-next

> 
> from the dmaengine tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/dma/idxd/device.c
> index f652da6ab47d,1143886f4a80..000000000000
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@@ -699,21 -716,23 +716,26 @@@ static void idxd_device_wqs_clear_state
>   		struct idxd_wq *wq = idxd->wqs[i];
>   
>   		if (wq->state == IDXD_WQ_ENABLED) {
> + 			mutex_lock(&wq->wq_lock);
>   			idxd_wq_disable_cleanup(wq);
>  -			idxd_wq_device_reset_cleanup(wq);
>   			wq->state = IDXD_WQ_DISABLED;
> + 			mutex_unlock(&wq->wq_lock);
>   		}
>  +		idxd_wq_device_reset_cleanup(wq);
>   	}
>   }
>   
>   void idxd_device_clear_state(struct idxd_device *idxd)
>   {
>  +	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
>  +		return;
>  +
> + 	idxd_device_wqs_clear_state(idxd);
> + 	spin_lock(&idxd->dev_lock);
>   	idxd_groups_clear_state(idxd);
>   	idxd_engines_clear_state(idxd);
> - 	idxd_device_wqs_clear_state(idxd);
> + 	idxd->state = IDXD_DEV_DISABLED;
> + 	spin_unlock(&idxd->dev_lock);
>   }
>   
>   static void idxd_group_config_write(struct idxd_group *group)



-- 
~Vinod
