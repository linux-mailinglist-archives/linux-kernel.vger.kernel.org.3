Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A4E4D9D4E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 15:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349125AbiCOOUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 10:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349088AbiCOOU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:20:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05A7506FC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 07:19:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A70B616BA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 14:19:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D40C340EE;
        Tue, 15 Mar 2022 14:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647353955;
        bh=XG3mqAvP/dgv8ZgDBZ/3Z9nNgKycZZez7LoUFfJqTpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AF8hNNxypPS+AW1Eada7SmDukRd+tldbByT4OYCtDObqIMBInADoSmsC+qDXq/rWL
         O6If94P6zqzTcIoqmlzAj7kC9y8uj+2dmBFaz85/bWwJg64VVcs+7eiEJZbyw8giCz
         gML2D+C5D2VqARmcEzNh1tsvo2Zf1oGxfyeMrToo=
Date:   Tue, 15 Mar 2022 15:19:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vihas Makwana <makvihas@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] staging: r8188eu: proper error handling in
 rtw_init_drv_sw
Message-ID: <YjCgXS990UNB/oQG@kroah.com>
References: <20220309205047.45981-1-makvihas@gmail.com>
 <20220309205047.45981-3-makvihas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309205047.45981-3-makvihas@gmail.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 02:20:47AM +0530, Vihas Makwana wrote:
> The code inside rtw_init_drv_sw() calls various init functions to
> populate the padapter structure and checks for their return values
> respectively.
> But if one of the functions in middle fails then it simply returns
> _FAIL instead of proper logging and calling freeing counterparts
> of previous init functions.
> This leads to various memory leaks and can be found in
> /sys/kernel/debug/kmemleak if kernel is compiled with DEBUG_KMEMLEAK=y.
> 
> Fix this and keep the success and error separate.
> 
> Fixes: 2b42bd58b321 ("staging: r8188eu: introduce new os_dep dir for
> RTL8188eu driver")

Nit, that needed to be on one line, and no blank line before the next
ones.

I've fixed it up now.

thanks,

greg k-h
