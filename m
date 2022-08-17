Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91F6596F7F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239740AbiHQNJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbiHQNJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:09:13 -0400
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87DA8D3FC
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:07:47 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id 9C1B9200F9;
        Wed, 17 Aug 2022 15:07:45 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 85ZVPcaHbZdr; Wed, 17 Aug 2022 15:07:45 +0200 (CEST)
Received: from begin (218.145.204.77.rev.sfr.net [77.204.145.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 2C368200F4;
        Wed, 17 Aug 2022 15:07:44 +0200 (CEST)
Received: from samy by begin with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1oOIlr-00033Z-2e;
        Wed, 17 Aug 2022 15:07:43 +0200
Date:   Wed, 17 Aug 2022 15:07:43 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        speakup@linux-speakup.org
Subject: Re: [PATCHv4] speakup: Generate speakupmap.h automatically
Message-ID: <20220817130743.6ogxalp6kndjkutc@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Nikita Travkin <nikita@trvn.ru>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, speakup@linux-speakup.org
References: <20220612172244.il3siyq7ueqnvah5@begin>
 <20220816072843.1699317-1-nikita@trvn.ru>
 <20220816183310.uvmcojucjdhcb4vk@begin>
 <05ba7ae1d3065b32b6b206f7939b4433@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05ba7ae1d3065b32b6b206f7939b4433@trvn.ru>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Nikita Travkin, le mer. 17 août 2022 09:10:11 +0500, a ecrit:
> Samuel Thibault писал(а) 16.08.2022 23:33:
> > Nikita Travkin, le mar. 16 août 2022 12:28:43 +0500, a ecrit:
> >> After that I also had some weird issues of the build system trying to
> >> write speakupmap.h into the source dir and not the output dir (the
> >> source is read only due to the tooling I use) but this seems to have
> >> been resolved by cleanly rebuilding the speakup dir.
> > 
> > Mmm, how did you get/update your source dir? The latest version of the
> > patchset does generate it in the build tree.
> 
> It's just a git tree for Linux in which I've checked-out the
> v6.0-rc1 tag and applied few unrelated patches on top.
> 
> The thing confused me a bit as all other artifacts were properly
> placed in the output dir with an exception of the speakupmap.h.
> 
> My guess would be that I had some cache left over in the build dir
> from before this patch, when the file was hardcoded so it tried to
> recreate it as it was.

That was my guess as well.

> This seems reproducible:

Ok. I guess the confusion is coming from the firstly-generated
.main.o.cmd file that would still refer to the in-source origin.  I
don't think we can do much about this case, unfortunately.

Thanks for checking,
Samuel
