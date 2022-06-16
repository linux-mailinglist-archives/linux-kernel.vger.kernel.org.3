Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6970854DDBD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 11:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbiFPJBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 05:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiFPJA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 05:00:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46C6192B5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 02:00:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 72545210E4;
        Thu, 16 Jun 2022 09:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655370056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w0BHHsJPE8qgzh048aqdSMb/zWa2mtlhdMk8ow+kQSw=;
        b=JfzZQsy+X5n7J6iAAUyP6jooN90j7njJxN/Obtwg2jNsr3jNCpoRyOF93Z5Vsng4TJo5oB
        Mh0HUkf2I6WqSPBAafwZVZE4YOMNN/3ttAFtqtc8Hr8TsYFJf6VJNtuedsyehfyLBXVNwN
        emTTr4zg7Qd3nZuUmMCpQ8zWIWGcZGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655370056;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w0BHHsJPE8qgzh048aqdSMb/zWa2mtlhdMk8ow+kQSw=;
        b=aIvvRzucvxzVgOoa6kS+Z2qx0UD0mDzAlpLoRBod03NWoX7CHfBBPP3LV1Oc9IEY0CZuzI
        CCub8yJBqTEte2Aw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3E3622C141;
        Thu, 16 Jun 2022 09:00:56 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C0CC9A062E; Thu, 16 Jun 2022 11:00:52 +0200 (CEST)
Date:   Thu, 16 Jun 2022 11:00:52 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH] init: Initialize noop_backing_dev_info early
Message-ID: <20220616090052.6xhfljxcis7ymqlb@quack3.lan>
References: <20220615214815.6901-1-jack@suse.cz>
 <YqrI1kS/BxEQ+39V@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqrI1kS/BxEQ+39V@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15-06-22 23:08:22, Christoph Hellwig wrote:
> On Wed, Jun 15, 2022 at 11:48:15PM +0200, Jan Kara wrote:
> > +extern int bdi_init(struct backing_dev_info *bdi);
> 
> No need for the extern.

Yes, fixed up.

> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks for review!

> And this remind me that I really want to kill noop_backing_dev_info
> and just use a NULL bdi for this case eventually..

Yes, I'm just not sure whether the checks for bdi / wb being NULL in lots
of places will not be too annoying... But maybe you'll be able to come up
with some wrappers that will make things bearable.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
