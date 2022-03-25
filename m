Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013DF4E7D7D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbiCYTlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbiCYTit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:38:49 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D8F201685;
        Fri, 25 Mar 2022 12:19:30 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:35::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 87BCD2C3;
        Fri, 25 Mar 2022 19:19:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 87BCD2C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1648235969; bh=rLID/xNAEJ7ec3akw3YJ2DoeesZts3MivbTechASTOI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=BykFmEVv2MW90pAu9Yhi7BCRMlYGxp8zxUabPv0KmxuJUSLErsWzhSGinMgR9rSgp
         CtqBtvbCI6Wrs4QKyZwrXNCZ2t6Y/2VKMsXCeLS1KmNhKdHEEWQClGmh+UXNb2Tl19
         DMUTygQWJgAjS2TUBg+Cv0GeE4E0b3tK8PdbANsE+hJ0YYygOOuaNyUSgFEur2X3UT
         jpd52D6MIJvpQJ2aTbwHE4YeaApLNzEBsw8zvShw9GI5aH3lHPkCfiaVbu3Oag9+qi
         zEPV453ybpe9Jue6Qt+kToWS2FkXeuv/H93pILKOnX7xl4V7zs+UmtTO6PygzoVNJG
         jTGn2sQ/NYejg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] scripts/get_feat.pl: allow output the parsed
 file names
In-Reply-To: <a924b46a80d750d808c28a27adffaa5d5a983e5c.1648216561.git.mchehab@kernel.org>
References: <cover.1648216561.git.mchehab@kernel.org>
 <a924b46a80d750d808c28a27adffaa5d5a983e5c.1648216561.git.mchehab@kernel.org>
Date:   Fri, 25 Mar 2022 13:19:28 -0600
Message-ID: <874k3lg7r3.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab <mchehab@kernel.org> writes:

> Such output could be helpful while debugging it, but its main
> goal is to tell kernel_feat.py about what files were used
> by the script. Thie way, kernel_feat.py can add those as
> documentation dependencies.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

So I think these are worth getting into 5.18, but I do have one question:

> @@ -95,6 +97,10 @@ sub parse_feat {
>  	return if ($file =~ m,($prefix)/arch-support.txt,);
>  	return if (!($file =~ m,arch-support.txt$,));
>  
> +	if ($enable_fname) {
> +		printf "#define FILE %s\n", abs_path($file);
> +	}
> +

Why do you output the file names in this format?  This isn't input to
the C preprocessor, so the #define just seems strange.  What am I
missing here?

Thanks,

jon
