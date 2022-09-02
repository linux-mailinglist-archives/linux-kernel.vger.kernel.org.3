Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2225AAFA7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 14:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237164AbiIBMla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 08:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237283AbiIBMi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 08:38:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDFBAE85C;
        Fri,  2 Sep 2022 05:30:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E51C0B82A97;
        Fri,  2 Sep 2022 12:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1C0C433D6;
        Fri,  2 Sep 2022 12:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662121715;
        bh=Yu+f+2LN0ZRMKFZsIVKOyv2KT+zvpzeRGg5lZYJ5WEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KemuukuZDHgNt9irlYTJ4T3sQClvzWxrNfGRASQFYHQCIiaRhCOws3hQdK2NUbau5
         E5bVI0bHRNe1Vz5h6S0Paqqsh7D1VoAzhlOPI+xk0QXCT4+AW43wsP6C5abUb6cZIQ
         rAso8jaLHFU7SwJA+N8i1lCBPRVHLrlzQ2p6F+SOIH4swWCWQKZZOiOkZVXTqGbMDu
         Xnrdn0rjFAkzQD/sv8B9BiYgZFOEdUeXX8C9DqJQmcCGuOwnLEzoUsLpSiFOUEgd0h
         upWvrlI4e5bXtPfUqX/3ZLXH5TuRt3hiRaD5CZbuWFz2RY7aElhwXQzLxhoS6YTSFS
         z8fpbLNx9Xp2g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oU5mo-0005CJ-QZ; Fri, 02 Sep 2022 14:28:39 +0200
Date:   Fri, 2 Sep 2022 14:28:38 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] misc: fastrpc: fix memory corruption
Message-ID: <YxH29vz2s62gGMnJ@hovoldconsulting.com>
References: <20220829080531.29681-1-johan+linaro@kernel.org>
 <01bdf6e2-f72a-e114-f3d2-deccf55403b1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01bdf6e2-f72a-e114-f3d2-deccf55403b1@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 11:02:35AM +0100, Srinivas Kandagatla wrote:
> Hi Johan,
> 
> On 29/08/2022 09:05, Johan Hovold wrote:
> > The fastrpc driver uses a fixed-sized array to store its sessions but
> > missing and broken sanity checks could lead to memory beyond the array
> > being corrupted.
> > 
> > This specifically happens on SC8280XP platforms that use 14 sessions for
> > the compute DSP.
> > 
> Thanks for doing this.
> 
> I see that we hit this issue once again, and the way we are fixing it is 
> not really scalable. We should really get rid of FASTRPC_MAX_SESSIONS.

Yeah, I was a bit surprised to find that the underlying bugs (i.e. the
incomplete sanity checks) weren't fixed the last time this memory
corruption was reported:

	https://lore.kernel.org/all/1632123274-32054-1-git-send-email-jeyr@codeaurora.org/

> We should allocate the sessions dynamically based in the child node 
> count and qcom,nsessions.

That sounds like it would be an improvement.

But at least now you'll get an error message during probe rather than
silent memory corruption when bringing up a new SoC that needs more than
the current maximum number of sessions.

Johan
