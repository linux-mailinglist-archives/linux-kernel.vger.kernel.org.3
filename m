Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C294E90D3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 11:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238012AbiC1JOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 05:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbiC1JOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 05:14:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5194326FC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 02:12:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A40760E2C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 09:12:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C84C340F0;
        Mon, 28 Mar 2022 09:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648458741;
        bh=WzFWWu1R9aaNE4hxIXvh1cfPuKjD+vdZInuaqPs0CVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GpRTXzzBhe9JSoNRuOzIY6yUV8k73z/K8qMWuuB7nrQXUsAmknwPo5yUnlUGV4v7Q
         aA12cX2izmteE9/JqroXn/ah1hDCN8Zxq+kyNKia76QhgTb3akxMKhTZFzehAXW0ZU
         ZBzS4LApnHKBJWbfPJ0WHv8CAlbK6uICvbaatQOQ=
Date:   Mon, 28 Mar 2022 11:12:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?55m95rWp5paH?= <baihaowen@meizu.com>
Cc:     "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "phil@philpotter.co.uk" <phil@philpotter.co.uk>,
        "straube.linux@gmail.com" <straube.linux@gmail.com>,
        "martin@kaiser.cx" <martin@kaiser.cx>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0ggVjJdIHN0?=
 =?utf-8?Q?aging=3A_r8188eu=3A_Directl?= =?utf-8?Q?y?= return _SUCCESS
 instead of using local ret variable
Message-ID: <YkF78wyXCaQIwkB2@kroah.com>
References: <1648457028-4226-1-git-send-email-baihaowen@meizu.com>
 <YkF2MRdxlUWow0UC@kroah.com>
 <be09d628f09041ac8f2c7bf2e9d5a13d@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be09d628f09041ac8f2c7bf2e9d5a13d@meizu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Mon, Mar 28, 2022 at 09:07:44AM +0000, 白浩文 wrote:
> Hi, Greg KH
> 
> Yes, I think sync rtl8723bs and r8188eu will be better as they have same problem.
> 
> commit 067756acdac8e0dd91edf4800e844fcb6e0cc72a
> Author: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> Date:   Mon Jul 15 23:16:18 2019 +0530
> 
>     staging: rtl8723bs: core: Change return type of init_mlme_ext_priv
> 
>     As init_mlme_ext_priv function always returns SUCCESS , We can change
>     return type from int to void.
> 
>     Fixes below issue identified by coccicheck
>     drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:464:5-8: Unneeded
>     variable: "res". Return "_SUCCESS" on line 492

Yes, that would be good.

