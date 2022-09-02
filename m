Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FF25AB230
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 15:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238134AbiIBNwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 09:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238259AbiIBNwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 09:52:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CC0139D53;
        Fri,  2 Sep 2022 06:26:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 113E9B82B52;
        Fri,  2 Sep 2022 13:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CFE6C433C1;
        Fri,  2 Sep 2022 13:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662125113;
        bh=P47PCuy0b6sjxqQyA4e/eNhGPyUNXr9Ohfa1FHwdEbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GXgRa4X58KPDpke2OHKTTsw9CmD0ohAmE9l2+HfbtkI6/SxOs4Y3MdzOGcN8t7SjM
         r20K8eFqEIt0FdeiHQ/WnRF+/B5KZsRCXyN0sE+K6hYt+LsVNixjZr2MaTvTj9CJr2
         9jo/Dxrh4Ibtkk3Mc3YbaTuRLsBn8t+P6jdT7YlY=
Date:   Fri, 2 Sep 2022 15:25:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorande@qti.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ekansh Gupta <ekangupt@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ola Jeppsson <ola@snap.com>
Subject: Re: [PATCH 01/14] misc: fastrpc: Fix use-after-free and race in
 fastrpc_map_find
Message-ID: <YxIENg1AalM46bpi@kroah.com>
References: <20220902131344.3029826-1-abel.vesa@linaro.org>
 <20220902131344.3029826-2-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902131344.3029826-2-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 04:13:31PM +0300, Abel Vesa wrote:
> Currently, there is a race window between the point when the mutex is
> unlocked in fastrpc_map_lookup and the reference count increasing
> (fastrpc_map_get) in fastrpc_map_find, which can also lead to
> use-after-free.
> 
> So lets merge fastrpc_map_find into fastrpc_map_lookup which allows us
> to both protect the maps list by also taking the &fl->lock spinlock and
> the reference count, since the spinlock will be released only after.
> Add take_ref argument to make this suitable for all callers.
> 
> Co-developed-by: Ola Jeppsson <ola@snap.com>
> Signed-off-by: Ola Jeppsson <ola@snap.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/misc/fastrpc.c | 41 +++++++++++++++++++++--------------------
>  1 file changed, 21 insertions(+), 20 deletions(-)

What commit does this fix?  Should it go to stable trees?

Try splitting this series up into 2, one for 6.0-final with bugfixes to
resolve issues found, and the next one on top of that for new features.

thanks,

greg k-h
