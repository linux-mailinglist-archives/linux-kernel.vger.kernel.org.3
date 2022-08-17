Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35E85975C6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 20:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238083AbiHQSdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 14:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238497AbiHQSdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 14:33:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AC7753B5;
        Wed, 17 Aug 2022 11:33:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EE0D2382FC;
        Wed, 17 Aug 2022 18:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660761216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xCmrD3/yiFypiLuh4pQOWKPUE9hNFGZ5QazT35uSFjg=;
        b=yIKNDOJUZPKa8vP3/+bRK2QylzHK16xgqBb4pJqdDuPV9LM92D2cbkJRiijDo7k2La+rpK
        rBptaUJRhalud8iHi2+M+ljtpw4jwCBvNteDF3FCXFxhBH/2Rl1KsrgQCFM3mzoCX0r+Do
        bse/8/LbLyVvVX4xNinT4/t201eGYzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660761216;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xCmrD3/yiFypiLuh4pQOWKPUE9hNFGZ5QazT35uSFjg=;
        b=oUociQbIlOSoobQoQ9AUzboMOWloX+lDnG0xaoJrsP4KyIhTAwWy3oVByzHV8UppNs4J9p
        CTcPa5wC0mANThBw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B79F42C177;
        Wed, 17 Aug 2022 18:33:36 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id AC4A9A066B; Wed, 17 Aug 2022 20:33:35 +0200 (CEST)
Date:   Wed, 17 Aug 2022 20:33:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Jan Kara <jack@suse.cz>,
        Holger =?utf-8?Q?Hoffst=C3=A4tte?= 
        <holger@applied-asynchrony.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: stalling IO regression since linux 5.12, through 5.18
Message-ID: <20220817183335.47a4ao26wjopavo2@quack3>
References: <dcd8beea-d2d9-e692-6e5d-c96b2d29dfd1@suse.com>
 <2b8a38fa-f15f-45e8-8caa-61c5f8cd52de@www.fastmail.com>
 <7c830487-95a6-b008-920b-8bc4a318f10a@applied-asynchrony.com>
 <20220817114933.66c4g4xjsi4df2tg@quack3>
 <85a141ae-56a7-4dcd-b75a-04be4b276b3a@www.fastmail.com>
 <20220817163059.kigrvdfmxfswmhls@quack3>
 <f6f899a5-97e2-460f-ad73-73d4b5e38eb6@www.fastmail.com>
 <51cd43f9-ab6b-4dd6-814f-e0c1ace3143c@www.fastmail.com>
 <20220817181554.znqljc6mmci45ukd@quack3>
 <e4c260da-2df7-49a3-a8dc-1d3fc7ca12a0@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4c260da-2df7-49a3-a8dc-1d3fc7ca12a0@www.fastmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-08-22 14:18:01, Chris Murphy wrote:
> 
> 
> On Wed, Aug 17, 2022, at 2:15 PM, Jan Kara wrote:
> 
> > OK, if this indeed passes then b6e68ee82585 ("blk-mq: Improve performance
> > of non-mq IO schedulers with multiple HW queues") might be what's causing
> > issues (although I don't know how yet...).
> 
> I can revert it from 5.12.0 and try. Let me know which next test is preferred :)

Let's try to revert this first so that we have it narrowed down what
started causing the issues. 

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
