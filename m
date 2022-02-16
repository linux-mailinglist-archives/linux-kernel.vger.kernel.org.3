Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2054B8774
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 13:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbiBPMVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 07:21:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiBPMU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 07:20:59 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF29295FFA;
        Wed, 16 Feb 2022 04:20:46 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id E6CFB1F4506E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645014045;
        bh=KGv3qi0/1qhw2Wkx1ythbjE2BIDW/ZTM/yt/IuCEiIo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=S2sr4BwbEoGrcCanT1eM0wxBbJB/89NHdwvA88lnjl9b+qfB9vro0oqb2ClhwaPh5
         RoToC07bCpg7xRypO6+Z8TIcIs6nCGCzS9Cua4/XeJEPwF76tOYPJvGnOttMZlxrtZ
         NRslSH1jbU5BnX7BeNImN6y3EY3Z80fREo08IzDysc2DpPFNAKl0GnzC7HiLz9wQ26
         b8RKw86y2vqkdc0nwPe/D5s+SasjCcKsp98A+CO5EC+Yb3hQ3pM8Qhv60E63Jw4gGw
         M56vTL1TiUdfaJC6EoKyEcvQHNovW+2xyQ4IH3UbFO6iVKMJ3KrhSypkabfZ+2JC+V
         0fLm3RNOVAu2Q==
Message-ID: <c041df98-fbea-bc76-75c0-42d549248dfd@collabora.com>
Date:   Wed, 16 Feb 2022 09:20:38 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: linux-next: build failure after merge of the spi tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220216161718.2c094b08@canb.auug.org.au>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
In-Reply-To: <20220216161718.2c094b08@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Às 02:17 de 16/02/22, Stephen Rothwell escreveu:
> Hi all,
> 
> After merging the spi tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
> 
> drivers/spi/spi-amd.c:333:37: error: 'spi_acpi_match' undeclared here (not in a function)
>   333 |                 .acpi_match_table = spi_acpi_match,
>       |                                     ^~~~~~~~~~~~~~
> 
> Caused by commit
> 
>   209043554915 ("spi: amd: Add support for version AMDI0062")
> 
> CONFIG_ACPI is not set for this build.
> 
> I have reverted that commit for today.
> 

Thanks for input. I'll send a new series with a patch to make this
driver depends on ACPI then. My patch touched this line, but this
variable was there before, so I think this build breakage is happening
for some time.
