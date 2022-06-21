Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AE85534B7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 16:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351400AbiFUOkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 10:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349156AbiFUOko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:40:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC58F237D4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 07:40:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59EE4616BF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 14:40:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CE7C341C0;
        Tue, 21 Jun 2022 14:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655822442;
        bh=w320+wuqbFHvuGQ3W4guubYrnJKxDF19Xrl56Eu3yHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RutlupmvxTM2WBwYvITX5xNCm/wKJpI1hJPG0OmWn1IjpLSP9S5Iipo8ivtuNZa4N
         SREWd6vu3fuliQ3quyD4ngv9hfRsSPJwe7og85nudLkf5uosLDZU/FDofT/Ih0DpdQ
         qO5Nm12xtVGTxffcoEdNz/BVAmwvl5ZbrD9R/2ZgXQtrqO+4IrCESYxy3aPR0922bF
         LfunBWPeels2/RJolz24Xc2RHqsK8Ep/RJqsuV3XNyah0Imp31NC/FUBAdAml2QYfd
         JSMEvt3F77KtVcXwjB+pj6MS8gprWfJjbUBfGB6O63rqbtTPYfCctPYcJ3LBB6Z6Nb
         Xf9pQZO9CTIwg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o3f3V-00078B-8q; Tue, 21 Jun 2022 16:40:37 +0200
Date:   Tue, 21 Jun 2022 16:40:37 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     vireshk@kernel.org, elder@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Unitialized Variable and Null Pointer Dereference bug in
 gb_bootrom_get_firmware
Message-ID: <YrHYZb2BT8fQMcaR@hovoldconsulting.com>
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

This sounds like the false positive that checkers keep tripping over.

Please double check your analysis and search the archives first.

Johan
