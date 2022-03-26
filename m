Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A066C4E8063
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 11:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbiCZK0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 06:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiCZK0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 06:26:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CC0F4626;
        Sat, 26 Mar 2022 03:24:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3032FB80187;
        Sat, 26 Mar 2022 10:24:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EA6C2BBE4;
        Sat, 26 Mar 2022 10:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648290267;
        bh=yuP6OtrchILflyEbpSFyWsmgNTaxV8wstHK0jUT5Mcw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Lk32wYMtPk0xZw1iDLBc82OA8WTIxikobnjWKEjCP/iXvB883d8Fhti/T+Nx8yVaa
         My1CQ69rDq+GzQSUzDc/MDPjPSvSUbysyIIGNaBw1U+BLnWOW5P7yuDDNT1iLb1Tcc
         nEpDWEhwGj+PDNe9FGMNTbE9buUB8u58Cf9c0BcsVVanBJEsUWmGfJHZDouSTTkP0f
         7Q2vTupEAvEuzovwKUQ6qjjoi0H6O2qzPOyLNyx68AvnlexU48MURUxv9iZAB4H/nH
         iwuVqE4LTMtO3e6U8PXkE4aA0Bs/8d71yeX+seslKEoo9baVSdzE6joe+Izp/AMDRd
         Eo0LCW9vEJDrw==
Date:   Sat, 26 Mar 2022 11:24:15 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] scripts/get_feat.pl: allow output the parsed
 file names
Message-ID: <20220326112415.444f34af@coco.lan>
In-Reply-To: <874k3ld1j2.fsf@meer.lwn.net>
References: <cover.1648216561.git.mchehab@kernel.org>
        <a924b46a80d750d808c28a27adffaa5d5a983e5c.1648216561.git.mchehab@kernel.org>
        <874k3lg7r3.fsf@meer.lwn.net>
        <20220326002109.2cda0402@coco.lan>
        <20220326003050.50750c75@coco.lan>
        <874k3ld1j2.fsf@meer.lwn.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 25 Mar 2022 18:02:09 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab@kernel.org> writes:
> 
> > Btw, maybe we could replace them tree with a Sphinx comment, like:
> >
> > get_feat.pl:
> > 	.. FILE <file_name>
> > kernel-doc:
> > 	.. LINE <line_number>
> > get_abi.pl:
> > 	.. FILE_LINE <file_name>:<line_number>
> >
> > (or something similar)
> >
> > Just let me know what you prefer and I can take care of the needed
> > changes on this patch and, if it is the case, writing the extra patches
> > in order to use the same model on kernel-doc and get_abi.pl.  
> 
> If it were just me, I'd just put "FILE <name>" or something simple.

This won't be a problem here, but I would prefer to use something that
would have zero chances of causing issues at kernel-doc and on other
similar scripts that we might end needing. Using a valid ReST tag like
starting it with ".." should fulfill such goal. 

A side effect is that the output of the script would be a valid ReST file,
either with or without file/line information, which sounds a good idea
on my eyes.

> I don't really have a strong opinion on the matter though; it's not like
> people have to actually look at these things. 

Yes. That's why I ended using #define, the actual meta-tag won't matter
for people.

> I was mostly curious as
> to why you'd done it that way.  I can take the original patches or any
> of the variants above; just let me know which you like best and we'll
> get this done.

Ok. I'll resubmit the patch changing to the comments tag. I'll add
patches also for kernel-doc and get_abi.pl for all of them to use
the same meta-tag.

Thanks,
Mauro
