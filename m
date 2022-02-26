Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356D74C56D5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 17:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbiBZQgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 11:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiBZQgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 11:36:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6090B26295B;
        Sat, 26 Feb 2022 08:36:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01F19B80814;
        Sat, 26 Feb 2022 16:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F649C340E8;
        Sat, 26 Feb 2022 16:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645893360;
        bh=xX8VmDztp3N0GoPaZtIyUGbJBpyw5EhUWfj6kUcQHCc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HR9lfhyI+fHAOfKgfe05UMA/jXHbf9+uZhq595RCkVcX2s0qFxVwi1STNsa5T6+7s
         oZURCoGXOraYw3UPCridA37xCmIWnbIjMxIHx7OIx/Asb11+gS9mR+i9459ey1S2lI
         4glj1gPAul4lWU6WYSqpPPaLit3AhAFDb5HrP0+R0SH1oPRqoa2hkOJBPmZE+PSX6r
         mfiEtaQotW3aHoj90xMnxT96lX3f6cLtJ3NKhmMYCWUrln5UMYI9/MlHgl5rvmG/Lj
         ur7/lhQlbd2Z/9pIE/A0PJ1PLDK0rP0SYvtxlhIdU5tHUqWMNFJnu+W3iVL4ZoqtcS
         othBeSDGXJzKQ==
Date:   Sat, 26 Feb 2022 16:43:00 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Michal Simek <monstr@monstr.eu>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iio: adc: xilinx-ams: Use
 devm_delayed_work_autocancel() to simplify code
Message-ID: <20220226164300.63b31841@jic23-huawei>
In-Reply-To: <f874a9c7-8d8d-fecc-8fc9-51dcf37cf60b@monstr.eu>
References: <2626e6a057e40cd2271ef0e5f81d12e607bad5b4.1644776929.git.christophe.jaillet@wanadoo.fr>
        <20220220114552.53fedd33@jic23-huawei>
        <f874a9c7-8d8d-fecc-8fc9-51dcf37cf60b@monstr.eu>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Feb 2022 11:02:00 +0100
Michal Simek <monstr@monstr.eu> wrote:

> Hi,
> 
> On 2/20/22 12:45, Jonathan Cameron wrote:
> > On Sun, 13 Feb 2022 19:29:05 +0100
> > Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
> >   
> >> Use devm_delayed_work_autocancel() instead of hand writing it. This is
> >> less verbose and saves a few lines of code.
> >>
> >> devm_delayed_work_autocancel() uses devm_add_action() instead of
> >> devm_add_action_or_reset(). This is fine, because if the underlying memory
> >> allocation fails, no work has been scheduled yet. So there is nothing to
> >> undo.
> >>
> >> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>  
> > Looks good to me, but I'd ideally like some input from someone familiar with
> > the driver.  
> 
> Anand told me that the change is fine that's why here is my
> Acked-by: Michal Simek <michal.simek@xilinx.com>
> 
> Jonathan: Anand decided to do change in his carrier that's why that emails won't 
> go through. But I am still around if you need something xilinx/amd to test.
> 
> Thanks,
> Michal

Thanks Michal and best wishes to Anand for whatever comes next!

Applied to the togreg branch of iio.git and pushed out as testing for
0-day to take a quick look before I expose this to linux-next.

Thanks,

Jonathan


