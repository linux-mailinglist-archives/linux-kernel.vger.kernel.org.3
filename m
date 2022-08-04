Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D536E589E8A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 17:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239913AbiHDPUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 11:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239801AbiHDPT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 11:19:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADE914014;
        Thu,  4 Aug 2022 08:19:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 345C4B8253A;
        Thu,  4 Aug 2022 15:19:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2BBC433D6;
        Thu,  4 Aug 2022 15:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659626390;
        bh=Cu6FHB7K1kKiwVXKsKCOzpDMnAIi4ddydINp3RF8EHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=phEQR9x4rkn1g3XBENrcFKCOqrxbb9OzkzxI2o/0O69xV7QGiEm0G249ztU01rj6C
         7LpiVUKbVkWrqtZz4cznEzDDtj7T8MgaI85EkzU1VIP0STVe7rDjMG9h2dFBXIqjtr
         wNc2iIf6dvL8gwzMHDmYGqGFpH8e1l9uG7981nqjZNdbhm4hg9dTTWk7Vx+f/BXAjb
         QdIf4ZrrSZkdAcmpSvrhfdGTpE+/TAr/DN/MHlHucivK2QZvKdRmihOiBS+DFaRf8q
         yI2CAbDdZ5+LknTc6S287c6fHIhQJ2giqUwHaiQGWpzbP+LjlRcOxlgptMYt+9v6ss
         FA3NxwjiO8U/A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oJcdw-0006KI-SM; Thu, 04 Aug 2022 17:20:12 +0200
Date:   Thu, 4 Aug 2022 17:20:12 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: dwc3: qcom: Provide stubs for
 dwc3_qcom_read_usb2_speed function
Message-ID: <YuvjrAUorQdC7U2k@hovoldconsulting.com>
References: <1659337215-20421-1-git-send-email-quic_kriskura@quicinc.com>
 <YulR31pEq9wjCBg8@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YulR31pEq9wjCBg8@hovoldconsulting.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 06:33:36PM +0200, Johan Hovold wrote:
> On Mon, Aug 01, 2022 at 12:30:15PM +0530, Krishna Kurapati wrote:
> > Dwc3 Qcom driver makes use of usb_hub_find_child API in its efforts
> > to get speed of connected devices (HS/LS/FS) and enable interrupts
> > accordingly.
> 
> > usb_hub_find_child API is a part of usb core compiled
> > either into the kernel or as a module (CONFIG_USB= Y or M). In some
> > builds (make randconfig for i386) CONFIG_USB is not enabled and the
> > usb core is not compiled resulting in linking errors.
> 
> Please replace the above with something more succinct. Whether USB core
> is built as a module or not is completely irrelevant. The problem is
> that the qcom dwc3 driver can be built and used without host support. 
> 
> > Provide stubs for dwc3_qcom_read_usb2_speed function to use
> > usb_hub_find_child API only if CONFIG_USB is enabled. Else return
> > USB_SPEED_UNKNOWN.
> 
> The fact that you need to do this is an indication that something is
> wrong with the current implementation. The glue driver shouldn't be
> touching the host driver internal state directly like this.
> 
> As pointed out here:
> 
> 	https://lore.kernel.org/all/20220802151404.1797-4-johan+linaro@kernel.org/
> 
> dwc3_qcom_read_usb2_speed() is indeed broken and currently triggers a
> NULL-pointer dereference when the controller is used in peripheral mode.
> 
> But for now I guess something like this is needed even if we try to
> avoid stubs in implementation files.

This is how I think this should be fixed instead:

	https://lore.kernel.org/all/20220804151001.23612-4-johan+linaro@kernel.org/

and which keeps the ifdeffery minimal. I included the patch in v2 of the
series that addresses the other problems with this code.

Johan
