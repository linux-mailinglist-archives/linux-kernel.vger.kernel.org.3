Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8915B2E47
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 07:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiIIFsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 01:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiIIFr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 01:47:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FDA7F12D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 22:47:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E4ADB8206F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700B8C433D6;
        Fri,  9 Sep 2022 05:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662702474;
        bh=0vVGtD3bKh45RiCjRwMej10XDq4aP2ygUfgxljQEXXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0a77IeEQp1gjZsZC7UYBds9koxGkx+nhssvrM7AKhM6rYp27+K3SbfaFeiM3CfbPh
         a7JeqkjVE1ULnxgCfirYeR527dCBL4wt3R8+ANWluA8wl7x4iwx3781AZHHZ0uH4SN
         P0d7pInr3BFo0Nq3lGH8QX4sNkvZBQsVpphYVHfE=
Date:   Fri, 9 Sep 2022 07:47:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nam Cao <namcaov@gmail.com>
Cc:     forest@alittletooquiet.net, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vt6655: fix potential memory conruption bug
Message-ID: <YxrTiN1OuJ2cbtrn@kroah.com>
References: <20220909053038.33188-1-namcaov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909053038.33188-1-namcaov@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 07:30:39AM +0200, Nam Cao wrote:
> A line of code is attempting to set the entire struct vnt_rdes0 to
> zero by treating it as unsigned int. However, this only works if
> sizeof(unsigned int) is equal to sizeof(struct vnt_rdes0) (4 bytes),
> which is not guaranteed. This may cause memory conruption if
> sizeof(unsigned int) is 8 bytes for example. Fix the problem by using
> memset instead.

sizeof(unsigned int) is not going to be 8 bytes, so there's no memory
issue here.  But your fix is good, so can you please just rewrite this
to be "make it more obvious what is happening" type of patch?

thanks,

greg k-h
