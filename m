Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A0C5534EA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 16:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352007AbiFUOtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 10:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351928AbiFUOsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:48:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB95025EB9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 07:48:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88025616F1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 14:48:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6F7C341C0;
        Tue, 21 Jun 2022 14:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655822916;
        bh=Gwr+QyPB83NBVvE/p+NStVDucuI4XhibcTOhatHYCMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=acuemdwiDFqqe9DwJANs1HBjVp9507bqKE0b6z1jOvk5N/RsystoicJlpZgu+S4Se
         RsKidwCiZ9K0ixmveG3eS7t15WBuY3AN6WA+sZM5AxObD7Eaw4sdLbJujJ7fQkRMfb
         wp7jXfiy4cQZOvJcQd5awP1YS39Ug17eBfV4mgrM=
Date:   Tue, 21 Jun 2022 16:48:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     vireshk@kernel.org, Johan Hovold <johan@kernel.org>,
        elder@kernel.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Unitialized Variable and Null Pointer Dereference bug in
 gb_bootrom_get_firmware
Message-ID: <YrHaQHGhdV0w0ot+@kroah.com>
References: <CAD-N9QVVKUDFKMSxUc-smcz0B_7PrjN3DPku+cDM3ZKDn0XLBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD-N9QVVKUDFKMSxUc-smcz0B_7PrjN3DPku+cDM3ZKDn0XLBA@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 10:36:04PM +0800, Dongliang Mu wrote:
> Hi maintainers,
> 
> I would like to send one bug report.
> 
> In gb_bootrom_get_firmware, if the first branch is satisfied, it will
> go to queue_work, leading to the dereference of uninitialized const
> variable "fw". If the second branch is satisfied, it will go to unlock
> with fw as NULL pointer, leading to a NULL Pointer Dereference.
> 
> The Fixes commit should be [1], introducing the dereference of "fw" in
> the error handling code.
> 
> I am not sure how to fix this bug. Any comment on removing the
> dereference of fw?

As Johan said, please fix up your tool that found this, it is not
working properly.

thanks,

greg k-h
