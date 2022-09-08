Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68205B18CB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiIHJd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiIHJdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:33:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D800DFF530;
        Thu,  8 Sep 2022 02:33:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 85C861F8A3;
        Thu,  8 Sep 2022 09:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662629611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lAvVxDQ/lA1sEAfdxervtL9a77xO7Fxnw+1WLNfdW2w=;
        b=gMXZYukx79rSkU+x6WY8oiEPw0+wkmEsjpil2SvgSy4x7svKZo3ADEyim0XInUsCt/jQWO
        EtDqCL/Qb8KFU84u9gJmmAmmbXJStiHEvrO92HI44ug7cmuIXxmdqjJ/7ZlR6iFDXStK+j
        WZF+D2KFfOv4QXQkQIjMjt9q9GTBbcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662629611;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lAvVxDQ/lA1sEAfdxervtL9a77xO7Fxnw+1WLNfdW2w=;
        b=5XUsWbNoWnbtDB/D4r1Qby+SfouZIcjraYDxYrU5cDK+0T0jBrUy+jGPSzW0je9StDOcOO
        rqC+Toi9ghj3ZnCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6FC5113A6D;
        Thu,  8 Sep 2022 09:33:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kwY/G+u2GWM5SgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 08 Sep 2022 09:33:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C6FADA067E; Thu,  8 Sep 2022 11:33:30 +0200 (CEST)
Date:   Thu, 8 Sep 2022 11:33:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>,
        axboe@kernel.dk, osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH] sbitmap: fix possible io hung due to lost wakeup
Message-ID: <20220908093330.lzynnuqlnvppj27q@quack3>
References: <20220803121504.212071-1-yukuai1@huaweicloud.com>
 <Yxe7V3yfBcADoYLE@kbusch-mbp.dhcp.thefacebook.com>
 <20220907102318.pdpzpmhah2m3ptbn@quack3>
 <YxinFEYRCU/QuQ5w@kbusch-mbp.dhcp.thefacebook.com>
 <20220907164150.tykjl3jsctjddcnq@quack3>
 <Yxjg2Xsb7WExRv2w@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yxjg2Xsb7WExRv2w@kbusch-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 07-09-22 12:20:09, Keith Busch wrote:
> On Wed, Sep 07, 2022 at 06:41:50PM +0200, Jan Kara wrote:
> > On Wed 07-09-22 08:13:40, Keith Busch wrote:
> > > 
> > > I'm not sure about this part. We've already decremented, so the freed bit is
> > > accounted for against the batch. Returning true here may double-count the freed
> > > bit, right?
> > 
> > Yes, we may wake up waiters unnecessarily frequently. But that's a
> > performance issue at worst and only if it happens frequently. So I don't
> > think it matters in practice (famous last words ;).
> 
> Ok, let's go with that. Do you want to send the patch? I have a follow-up fix
> for batched tagging that depends on this.

I think Kuai will do that. But if not, I can certainly take his patch and
resubmit it with the fixup.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
