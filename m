Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF02589E7E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 17:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239339AbiHDPRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 11:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237976AbiHDPPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 11:15:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F896442;
        Thu,  4 Aug 2022 08:15:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66DF0B82521;
        Thu,  4 Aug 2022 15:15:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA4AC433D6;
        Thu,  4 Aug 2022 15:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659626129;
        bh=0WM06FlWTMrhJfmtTNAejPGE0UPGqF0VPbPowF/tSjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e7MA+BYE9DqiDJuH46z2MUaQvbHjG00/xCIcMqPMvBX9QkjXPWItaCq3TsLjd3iXT
         meNp1kCnU5MnFm+rf2Ogd3TOvy9Ih1ID67A94X96iiofZe/nThFZyIoZ4s/ecxOAr9
         iMQDn9lXJqjkxll0qAy2o88YyVLRxClQ+xkeIlPfoz7T7lCnKUYTWGkBoAkfYl2mLv
         MycgxgDefsMRoTlJF9SQtLjJ9ZRzndyWvKbCs2Pf7zOhkEiCUQxzVcG/nqpvyHvQYy
         yCtVcsaaDZLmvpsVf5oZaLsrqtibOK3ySLs3j0xY6MfefJIa05STib1jwtxNKqrQRj
         SV9LjbQ+29WiQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oJcZj-0006IB-1G; Thu, 04 Aug 2022 17:15:51 +0200
Date:   Thu, 4 Aug 2022 17:15:51 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/9] usb: dwc3: qcom: fix wakeup implementation
Message-ID: <Yuvip8irUb9DsZ8M@hovoldconsulting.com>
References: <20220804151001.23612-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804151001.23612-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 05:09:52PM +0200, Johan Hovold wrote:

> Changes in v2
>  - add review and ack tags
>  - fix a gadget-only build breakage (new patch)
>  - fix a use-after-free on wakeup from runtime suspend (new patch)
>  - disable wakeup completely instead of falling back to the
>    "disconnected" host configuration when not acting as host
>  - disallow 'wakeup-source' in child node in the binding

Forgot to mention that I also dropped the revert of the dt-binding
commit adding 'wakeup-source' to the core node as Rob suggested.

Johan
