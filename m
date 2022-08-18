Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE572597F6E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 09:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243876AbiHRHoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 03:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243851AbiHRHo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 03:44:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7C03FA23;
        Thu, 18 Aug 2022 00:44:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 424D2B82000;
        Thu, 18 Aug 2022 07:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E95CC433C1;
        Thu, 18 Aug 2022 07:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660808664;
        bh=rZJCPHnb+2HsbxREnzF2lobCub/SFK5teShfdO609Do=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eANVzcjfvEGkQ1M6v0JZSaxj4aAmlTQIbKUaSFbuboIkPY/gakbqOyE2Se0eekpJ+
         A1W9vY8NoT6DZOvjabNWsggRGcdaOzads/L7z6LhXa5xuSRaWBqfqO7oojTfJmT90+
         9A3/SKocy451RB55T/EmmZ+IjiCJC427DCz+jwhUBqz2C9BnDB/BGxW95lKkaVkyp5
         sjxchJgTMfKb1X6nfS3bExk8KIXQrLTp7CAqF/MmvNM0p1oP+/vPt6BDABShvxImxt
         XuefMPJpHZtJfeQrrl3lBAOAyM4jhZAofJAVb82QWjnG5rQEk1Nj/BLYf8KeHy5rZ6
         A3NkGmpXgK+cw==
Message-ID: <fa213bd3-6f59-2ada-8aa7-0909b5fc9e37@kernel.org>
Date:   Thu, 18 Aug 2022 10:44:20 +0300
MIME-Version: 1.0
Subject: Re: linux-next: build failure after merge of the icc tree
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220818115326.407aa3e0@canb.auug.org.au>
 <47aa5e68-a41c-bb22-bce6-ab11a33b3d9c@kernel.org>
 <20220818064922.fejqbxpvc6epuqfr@pengutronix.de>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20220818064922.fejqbxpvc6epuqfr@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

On 18.08.22 9:49, Uwe Kleine-König wrote:
> Hello,
> 
> On Thu, Aug 18, 2022 at 08:00:51AM +0300, Georgi Djakov wrote:
>> On 18.08.22 4:53, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> After merging the icc tree, today's linux-next build (x86_64 allmodconfig)
>>> failed like this:
>>>
>>> drivers/interconnect/imx/imx8mp.c: In function 'imx8mp_icc_remove':
>>> drivers/interconnect/imx/imx8mp.c:245:16: error: void value not ignored as it ought to be
>>>     245 |         return imx_icc_unregister(pdev);
>>>         |                ^~~~~~~~~~~~~~~~~~~~~~~~
>>> drivers/interconnect/imx/imx8mp.c:246:1: error: control reaches end of non-void function [-Werror=return-type]
>>>     246 | }
>>>         | ^
>>>
>>> Caused by commit
>>>
>>>     d761e0e9c8f2 ("interconnect: imx: Make imx_icc_unregister() return void")
>>>
>>> I have used the icc tree from next-20220817 for today.
> 
> I tried to understand what went wrong here. The problem is that the
> patch "interconnect: imx: Make imx_icc_unregister() return void" was
> developed on top of v5.19-rc1, which doesn't contain
> drivers/interconnect/imx/imx8mp.c. This was only introduced in
> 
> 	c14ec5c93dc8 ("interconnect: imx: Add platform driver for imx8mp")
> 
> for v6.0-rc1.

Yes, exactly.

> 
>> Thanks Stephen! Fixed.
> 
> The history in the icc tree now looks as follows:
> 
> $ git lgg linus/master..FETCH_HEAD
> *   8c9b6a59edb7 Merge branch 'icc-ignore-return-val' into icc-next
> |\
> | * f62e3f595c5f interconnect: imx: Make imx_icc_unregister() return void
> * |   c86cfdbaf8e3 Merge branch 'icc-ignore-return-val' into icc-next
> |\ \
> | * | d761e0e9c8f2 interconnect: imx: Make imx_icc_unregister() return void
> | |/
> | * 680f8666baf6 interconnect: Make icc_provider_del() return void
> | * fa80a2994d35 interconnect: sm8450: Ignore return value of icc_provider_del() in .remove()
> | * f221bd781f25 interconnect: osm-l3: Ignore return value of icc_provider_del() in .remove()
> | * 919d4e1a207e interconnect: msm8974: Ignore return value of icc_provider_del() in .remove()
> | * 4681086c9bec interconnect: icc-rpmh: Ignore return value of icc_provider_del() in .remove()
> | * 8ef2ca20754d interconnect: icc-rpm: Ignore return value of icc_provider_del() in .remove()
> | * 7ec26b8dcc5c interconnect: imx: Ignore return value of icc_provider_del() in .remove()
> |/
> o 568035b01cfb (tag: v6.0-rc1) Linux 6.0-rc1
> 
> So the commit that doesn't build is still included and might annoy
> bisection. Also in my eyes it's kind of ugly to have two commits with
> identical commit log and nearly identical content in the same tree.
> 
> I don't know your preferences about not rewriting your tree once it was
> exposed to the public, but if you are willing to rewrite your tree to
> improve, the possibilities (in order of my preference) are:
> 
>   - Drop the broken commit and only include the fixed
>     icc-ignore-return-val branch.

Yes, that was actually my intention, but looks like i merged the fixed branch on top (without
un-merging the previous one). Sorry about that. It should be fine now.

Thanks!
Georgi

> 
>   - On top of the broken branch add a commit that only fixes the problem
>     but doesn't duplicate most of d761e0e9c8f2, yielding something like:
> 
> 	*   bcdefghijlkm Merge branch 'icc-ignore-return-val' into icc-next
> 	|\
> 	| * abcdefghijkl interconnect: imx: Fix imx8mp build
> 	| * d761e0e9c8f2 interconnect: imx: Make imx_icc_unregister() return void
> 	| * 680f8666baf6 interconnect: Make icc_provider_del() return void
> 	| * fa80a2994d35 interconnect: sm8450: Ignore return value of icc_provider_del() in .remove()
> 	| * f221bd781f25 interconnect: osm-l3: Ignore return value of icc_provider_del() in .remove()
> 	| * 919d4e1a207e interconnect: msm8974: Ignore return value of icc_provider_del() in .remove()
> 	| * 4681086c9bec interconnect: icc-rpmh: Ignore return value of icc_provider_del() in .remove()
> 	| * 8ef2ca20754d interconnect: icc-rpm: Ignore return value of icc_provider_del() in .remove()
> 	| * 7ec26b8dcc5c interconnect: imx: Ignore return value of icc_provider_del() in .remove()
> 	|/
> 	o 568035b01cfb (tag: v6.0-rc1) Linux 6.0-rc1
> 
>     or
> 
> 	* abcdefghijkm interconnect: imx: Fix imx8mp build
> 	*   c86cfdbaf8e3 Merge branch 'icc-ignore-return-val' into icc-next
> 	|\
> 	| * d761e0e9c8f2 interconnect: imx: Make imx_icc_unregister() return void
> 	| * 680f8666baf6 interconnect: Make icc_provider_del() return void
> 	| * fa80a2994d35 interconnect: sm8450: Ignore return value of icc_provider_del() in .remove()
> 	| * f221bd781f25 interconnect: osm-l3: Ignore return value of icc_provider_del() in .remove()
> 	| * 919d4e1a207e interconnect: msm8974: Ignore return value of icc_provider_del() in .remove()
> 	| * 4681086c9bec interconnect: icc-rpmh: Ignore return value of icc_provider_del() in .remove()
> 	| * 8ef2ca20754d interconnect: icc-rpm: Ignore return value of icc_provider_del() in .remove()
> 	| * 7ec26b8dcc5c interconnect: imx: Ignore return value of icc_provider_del() in .remove()
> 	|/
> 	o 568035b01cfb (tag: v6.0-rc1) Linux 6.0-rc1
> 
>   - At least point out in the fixed variant, what and why it was
>     necessary to redo the commit.
> 
> Thanks
> Uwe
> 

