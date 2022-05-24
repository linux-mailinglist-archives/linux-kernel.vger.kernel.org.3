Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B322D532521
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 10:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbiEXISw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 04:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbiEXISs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 04:18:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5465DBFA
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 01:18:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDC99615C8
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 08:18:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FAFC385AA;
        Tue, 24 May 2022 08:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653380327;
        bh=cH8jgRYJQhvnaohrQS1C7sgqEgqPhJ09GEs0fRN6DKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E+yw2ycoGbzEFm5vELUFVhRA2/mYIhRiuY2r0qfFHcJiABOUwBYRwWGR/2t2vZ67k
         II1FEs9tMwnjaTpJ3CN2wugfgY0cyPNoi2dHApSztV6OLw1/5u6Q+y4uv1Y6/uw4ke
         +yCNwcP2532UpJE9L2J5skbfFxb4HAofoUz4CE1o=
Date:   Tue, 24 May 2022 10:18:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        Martin Kaiser <lists@kaiser.cx>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        dan.carpenter@oracle.com, phil@philpotter.co.uk,
        straube.linux@gmail.com, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: r8188eu: add check for kzalloc
Message-ID: <YoyU4zXf45UpF1Tq@kroah.com>
References: <20220518075957.514603-1-jiasheng@iscas.ac.cn>
 <20220521155017.7jjz7prdnspm2276@viti.kaiser.cx>
 <8fb49b5b-106b-3346-a75d-d54e0a065587@gmail.com>
 <b922eaa2-303a-69da-03ec-e053092c8682@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b922eaa2-303a-69da-03ec-e053092c8682@lwfinger.net>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 04:57:17PM -0500, Larry Finger wrote:
> On 5/21/22 15:26, Pavel Skripkin wrote:
> > Hi Martin,
> > 
> > On 5/21/22 18:50, Martin Kaiser wrote:
> > > 
> > > >      for (i = 0; i < 4; i++)
> > > > @@ -1474,7 +1479,7 @@ s32 rtw_xmit_classifier(struct adapter
> > > > *padapter, struct xmit_frame *pxmitframe)
> > > 
> > > 
> > > res is still 0 here - but the caller of _rtw_init_xmit_priv compares
> > > this return value with _SUCCESS (1) or _FAIL (0) and interprets it as
> > > _FAIL.
> > > 
> > 
> > I think, it's time to make
> > 
> > s/_SUCCESS/0/
> > s/_FAIL/-1
> > 
> > since developers from outside of staging are confused.
> > The main problem will be with functions that return an int (or s32).
> > 
> > Will take a look.
> 
> I agree; however, this change will likely break a lot of pending patches.
> 
> 
> @GregKH: Could you apply all pending patches in preparation for this patch?
> If so, then Pavel could make this transformation while the list is
> relatively idle.

Everything up to last week was already merged, and my tree is now closed
due to the merge window.  So send away.  Merge issues can be addressed
over time, and rebasing is always easier than making the patchset to
start with, so this shouldn't be that big of an issue.

thanks,

greg k-h
