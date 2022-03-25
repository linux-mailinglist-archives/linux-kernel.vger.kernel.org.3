Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A284E7CCD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbiCYXW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 19:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbiCYXWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 19:22:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE256255142;
        Fri, 25 Mar 2022 16:21:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80989B82A30;
        Fri, 25 Mar 2022 23:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4193C2BBE4;
        Fri, 25 Mar 2022 23:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648250476;
        bh=T97WJXCnYEDDn5hncIAUzSD8BkDfJNMw5R6hXkYf4i4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iM/jTENA/Y751A9VQQDdN7tRMZZ4y2TUpPeNnt3cFNjysTJv+9DB4hh8UJ2bhjTOM
         2gkn6uTTMv4hfNjGcGR8+uGORXQv72gYMxqIzl1iMgh3NchDCp7aWOxhM2YJZ/SiN9
         LxAr04nH9S9PWBZc6ygXelsDxnZ31sb37epXjH9rah+gui0Nhb1NWTMJmcDCZowYpI
         02+V1dTk7tmi5cUOLfyfPnDMovhIwZupltRFTXqv7CEWw22mGlxDsHZgHqTzzD8N2z
         lVSCWBODHFzgqmSdGCHtc9wGnA25/5NdNCxW0NOVn0blGbPC8LtYuyubWSN7HKq+bV
         YtcmNzLmZ4j0A==
Date:   Sat, 26 Mar 2022 00:21:09 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] scripts/get_feat.pl: allow output the parsed
 file names
Message-ID: <20220326002109.2cda0402@coco.lan>
In-Reply-To: <874k3lg7r3.fsf@meer.lwn.net>
References: <cover.1648216561.git.mchehab@kernel.org>
        <a924b46a80d750d808c28a27adffaa5d5a983e5c.1648216561.git.mchehab@kernel.org>
        <874k3lg7r3.fsf@meer.lwn.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 25 Mar 2022 13:19:28 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab@kernel.org> writes:
> 
> > Such output could be helpful while debugging it, but its main
> > goal is to tell kernel_feat.py about what files were used
> > by the script. Thie way, kernel_feat.py can add those as
> > documentation dependencies.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>  
> 
> So I think these are worth getting into 5.18, 

Yeah, agreed.

> but I do have one question:
> 
> > @@ -95,6 +97,10 @@ sub parse_feat {
> >  	return if ($file =~ m,($prefix)/arch-support.txt,);
> >  	return if (!($file =~ m,arch-support.txt$,));
> >  
> > +	if ($enable_fname) {
> > +		printf "#define FILE %s\n", abs_path($file);
> > +	}
> > +  
> 
> Why do you output the file names in this format?  This isn't input to
> the C preprocessor, so the #define just seems strange.  What am I
> missing here?

Well, I didn't think much about that... I just ended using a way that is
already used on get_abi.pl, and was originally imported from kernel-doc :-)

It could be using whatever other tag, but I would keep those three scripts 
using a similar markup string for file names and line numbers:

scripts/get_abi.pl:
    printf "#define LINENO %s%s#%s\n\n", $prefix, $file[0], $data{$what}->{line_no};

scripts/kernel-doc:
    print "#define LINENO " . $lineno . "\n";

Thanks,
Mauro
