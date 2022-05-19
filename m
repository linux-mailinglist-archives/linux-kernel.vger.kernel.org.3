Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C19252D03F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 12:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbiESKQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 06:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiESKQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 06:16:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC3836E31;
        Thu, 19 May 2022 03:16:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A1C1121B50;
        Thu, 19 May 2022 10:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652955412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j926KAd1XQUpVbfgLiXlqXy2N+GLKRI2dNl67MjgX6Y=;
        b=ZZLa9R601zbvkxMvyDN8R3SO0lkwR2UtTLQj/pimOFDeyDEAAnopaNXt2/MgLOBW1qtuqm
        uvaGDDoK/0lo/gpBJIy+O07oT2C9uFWeABQ3Vq8zoaliLPk3ER9N3/MoZyklXeF7/i17zV
        JEeK3kS5BbgeMDMQQllQrFdcAY/Io5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652955412;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j926KAd1XQUpVbfgLiXlqXy2N+GLKRI2dNl67MjgX6Y=;
        b=z9mhqTs1b1aur1iLk1QWTtJop90nTnL7xO5yo+lbsn7EnscSmsyTSr95P/RVeQUDHGWXKJ
        MEchdeRQgMvhWSAg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 909D22C141;
        Thu, 19 May 2022 10:16:52 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3A8EDA062F; Thu, 19 May 2022 12:16:52 +0200 (CEST)
Date:   Thu, 19 May 2022 12:16:52 +0200
From:   Jan Kara <jack@suse.cz>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?Q?Micha=C5=82?= Dec <moog621@gmail.com>,
        reiserfs-devel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: Alternatives after removal of ReiserFS
Message-ID: <20220519101652.iu5jbol2cjwr4y5c@quack3.lan>
References: <54db8933-f2f3-d31a-c71f-860285e25abf@gmail.com>
 <2631780.mvXUDI8C0e@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2631780.mvXUDI8C0e@natalenko.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19-05-22 11:20:24, Oleksandr Natalenko wrote:
> Hello.
> 
> On středa 18. května 2022 14:10:25 CEST Michał Dec wrote:
> > Does the Linux kernel actually offer any alternatives to users whose use 
> > cases are satisfied by ReiserFS? These users will probably be stuck with 
> > a much older kernel once ReiserFS is completely removed. I'm one of 
> > those users and I use ReiserFS to keep around large quantities of small 
> > files and quite ironically these are copies of the Linux kernel. I keep 
> > around 2, maybe 3 separate kernel trees to make sure the kernels I have 
> > on my devices can be rebuilt at any time.
> 
> I think the advantage of using reiserfs for small files faded away over
> time and became an old tale that is being passed from one generation to
> another without any modern adequate testing.
> 
> XFS should serve you well.

Yes, so the space savings of tail packing e.g. for the kernel tree are
likely still noticeable (my tree here has around half of the files with
size below 4k). But given how cheap the storage is these days, people don't
care as much. If space efficiency is important, it could be improved by using
1k blocksize for xfs or ext4. Also btrfs does packing of small files so
for lots of small files it may be more space-efficient. And btrfs also
supports transparent compression so that can reduce space usage for larger
files even further.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
