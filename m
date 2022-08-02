Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0F4588052
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 18:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbiHBQd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 12:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiHBQdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 12:33:24 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BD817E16;
        Tue,  2 Aug 2022 09:33:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0D411CE2017;
        Tue,  2 Aug 2022 16:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63BCC433D6;
        Tue,  2 Aug 2022 16:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659458000;
        bh=wvCuCNOjRSMOixoJFZ19V50Uqrz6WXVshhwx5kuDuAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rhx22xzDRr5SQtI8UcUj+PkAqia5W0S+aT0Muk+9TNLMSlppNcAsqxFQZoF9mtyCu
         PUOe5GGmGgwl5clH5K+V9dBko2+MbHK9F6tyC/w6rVNSIsqR+cbRMG9HDecruvhX8z
         gNNPKtvoU7S1hGzSY75g4QaDtio0M0am3W8UZzPqkemR266Y2fHc08GvD/JypyHSc1
         6p0sA+X3cKgKCsbs3Rmifv0o/SC+4ZzKHnmtivKWBZKI66uFzh8cWUZb3HS5hNrcyS
         4BKb0jUszU167LsvXnuZbFCrY9A3wZz+e8ssZ7IuzwxkIhQx2xdo4QViroRPa/OvVX
         rwPQgq1ApTuGw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oIupr-0002Vn-Cf; Tue, 02 Aug 2022 18:33:36 +0200
Date:   Tue, 2 Aug 2022 18:33:35 +0200
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
Message-ID: <YulR31pEq9wjCBg8@hovoldconsulting.com>
References: <1659337215-20421-1-git-send-email-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1659337215-20421-1-git-send-email-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 12:30:15PM +0530, Krishna Kurapati wrote:
> Dwc3 Qcom driver makes use of usb_hub_find_child API in its efforts
> to get speed of connected devices (HS/LS/FS) and enable interrupts
> accordingly.

> usb_hub_find_child API is a part of usb core compiled
> either into the kernel or as a module (CONFIG_USB= Y or M). In some
> builds (make randconfig for i386) CONFIG_USB is not enabled and the
> usb core is not compiled resulting in linking errors.

Please replace the above with something more succinct. Whether USB core
is built as a module or not is completely irrelevant. The problem is
that the qcom dwc3 driver can be built and used without host support. 

> Provide stubs for dwc3_qcom_read_usb2_speed function to use
> usb_hub_find_child API only if CONFIG_USB is enabled. Else return
> USB_SPEED_UNKNOWN.

The fact that you need to do this is an indication that something is
wrong with the current implementation. The glue driver shouldn't be
touching the host driver internal state directly like this.

As pointed out here:

	https://lore.kernel.org/all/20220802151404.1797-4-johan+linaro@kernel.org/

dwc3_qcom_read_usb2_speed() is indeed broken and currently triggers a
NULL-pointer dereference when the controller is used in peripheral mode.

But for now I guess something like this is needed even if we try to
avoid stubs in implementation files.

Johan
