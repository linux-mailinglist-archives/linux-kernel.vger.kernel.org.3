Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B27F59BF48
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 14:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbiHVMJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 08:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbiHVMJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:09:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EECF39BBF
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 05:09:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5985C1FE82;
        Mon, 22 Aug 2022 12:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661170154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BQf11C2SztSHaAc1fCCEYoFCW50NZH5mzh9dLltQPVs=;
        b=p4lTmBdyCOljd88Lou0ApPiNTcrg55ISrXyy2Z2lgw6d95MbM2hP18vHea0UGA5CSG1Fju
        7wgNx7ZgREOAm0apcWAR9/w46u0ucAGD/W+pMXpik/faroXcSl+gpHFdH+Ac/ev+kpgFsw
        IdmcniYJyPob4UtDLTruYq88xgtW5xk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36B9F13523;
        Mon, 22 Aug 2022 12:09:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gm7eC+pxA2MlQQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 22 Aug 2022 12:09:14 +0000
Date:   Mon, 22 Aug 2022 14:09:13 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dma-pool: limit DMA and DMA32 zone size pools
Message-ID: <YwNx6Q+FSwpKUOQ2@dhcp22.suse.cz>
References: <20220817060647.1032426-1-hch@lst.de>
 <20220817060647.1032426-4-hch@lst.de>
 <Yvzk2wE7ta+zSZOQ@dhcp22.suse.cz>
 <20220821104416.GC30530@lst.de>
 <YwNBHbYXpatJHD0K@dhcp22.suse.cz>
 <20220822111447.GA8935@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822111447.GA8935@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22-08-22 13:14:47, Christoph Hellwig wrote:
> On Mon, Aug 22, 2022 at 10:41:01AM +0200, Michal Hocko wrote:
> > ZONE_DMA existance is not runtime controlable (at least on x86).
> 
> This is more about ZONE_DMA32 that can disappear if all memory is
> inside ZONE_DMA.  That is highly unusual (but still possible) with a
> tiny x86-style ZONE_DMA, but can happen with a larger one other
> architectures.

OK, so you are worried about configurations that lack ZONE_DMA32 because
that memory range is covered by ZONE_DMA? I thought though simply do not
have CONFIG_ZONE_DMA32. Or am I wrong here?

-- 
Michal Hocko
SUSE Labs
