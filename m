Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8081352B1DB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 07:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiERFWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 01:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiERFWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 01:22:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7040EBF40;
        Tue, 17 May 2022 22:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=9zSaPciRCpiv/xQYeO4hUNPBcoEshe/eajOHecf8ojs=; b=dTOE6lgUFAxiXZ8vauK3TGnJbX
        GFVPOB7v7VdupgFP+YQhDD6w7BEgMc8BE8/JAByplMNCBFMlovY+aNvEPYi5LbSZtczykxOWPhNQZ
        Q7t+9/kkHqxzNuadwCnQTFUOVS9ELd2GPOLWBGxQ0sYkfCJEURPBXqQE5bd8RmvOOgM8nErd8mHcJ
        b7L4Njbg5WtKtH9V7cXdsTIMO2VY7ahLftHR4vz/9Qz7eIPPSzEnfwPuQvATQ6egYma/iLO/nrJ2I
        TF+k76uNt6njjuBS65s0OweJX+kFvguwEOifaaf26AcTx65m6vhQxD24e91amwhvfW82UCy2OKo4g
        nRJrzJGw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrC8F-00BSuL-JJ; Wed, 18 May 2022 05:21:59 +0000
Message-ID: <e2f636e1-33ff-3d9f-a793-960f239d0bc2@infradead.org>
Date:   Tue, 17 May 2022 22:21:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: linux-next: Tree for May 17 (drivers/nvme/host/fc.o)
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Smart <james.smart@broadcom.com>,
        linux-nvme@lists.infradead.org
References: <20220517194118.2caa01b8@canb.auug.org.au>
 <5958ccea-d89c-8b1a-15d3-19d8cacd141d@infradead.org>
 <20220518045704.GA30131@lst.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220518045704.GA30131@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/22 21:57, Christoph Hellwig wrote:
> The patch that adds nvme_fc_io_getuuid need something like this
> folded in:
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index a11c69e681180..3c778bb0c2944 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -1911,7 +1911,9 @@ char *nvme_fc_io_getuuid(struct nvmefc_fcp_req *req)
>  	struct nvme_fc_fcp_op *op = fcp_req_to_fcp_op(req);
>  	struct request *rq = op->rq;
>  
> -	return rq->bio ? blkcg_get_fc_appid(rq->bio) : NULL;
> +	if (!IS_ENABLED(CONFIG_BLK_CGROUP_FC_APPID) || !rq->bio)
> +		return NULL;
> +	return blkcg_get_fc_appid(rq->bio);
>  }
>  EXPORT_SYMBOL_GPL(nvme_fc_io_getuuid);
>  

Thanks. You can add

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

to the patch.

-- 
~Randy
