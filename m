Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371ED4D9678
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240322AbiCOIlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbiCOIlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:41:50 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8DA4CD5A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:40:39 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A08A568AA6; Tue, 15 Mar 2022 09:40:35 +0100 (CET)
Date:   Tue, 15 Mar 2022 09:40:35 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     "hch@lst.de" <hch@lst.de>, Sungup Moon <sungup.moon@samsung.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] driver/nvme/host: Support duplicated nsid for the
 private ns
Message-ID: <20220315084035.GA3834@lst.de>
References: <CGME20220314110545epcms2p4a227eac7c4652445050e70ee2350635d@epcms2p4> <20220314110545epcms2p4a227eac7c4652445050e70ee2350635d@epcms2p4> <20220315071230.GA2069@lst.de> <20220315071926.GA2137@lst.de> <a3051d85-c08e-a273-c7cc-2eb3e21df717@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3051d85-c08e-a273-c7cc-2eb3e21df717@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 10:18:30AM +0200, Sagi Grimberg wrote:
>> +static struct nvme_ns_head *nvme_find_ns_head(struct nvme_ctrl *ctrl,
>>   		unsigned nsid)
>>   {
>> +	struct nvme_subsystem *subsys = ctrl->subsys;
>>   	struct nvme_ns_head *h;
>>     	lockdep_assert_held(&subsys->lock);
>
> IMO it is a bit strange that we now don't pass in the subsystem but
> require that the subsys->lock is taken...

We do things like that in various places, mostly because information
needed that is subsystem-wide hangs of the nvme_ctrl structure, in
this case the various feature bitmaps.  We could move them to the
subsystem structure, which would be the right thing to do but a fair
amout of churn for little savings.

>> +++ b/drivers/nvme/host/multipath.c
>> @@ -504,10 +504,11 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>>     	/*
>>   	 * Add a multipath node if the subsystems supports multiple controllers.
>> -	 * We also do this for private namespaces as the namespace sharing data could
>> -	 * change after a rescan.
>> +	 * We also do this for private namespaces as the namespace sharing flag
>> +	 * could change after a rescan.
>
> What happens in this case? we now have non-unique shared namespaces?

The non-uniqueue NSIDs can only happen for private namespaces.
