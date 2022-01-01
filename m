Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC6D482809
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 18:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbiAARZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 12:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbiAARZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 12:25:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AFEC061574;
        Sat,  1 Jan 2022 09:25:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9304F60B0E;
        Sat,  1 Jan 2022 17:25:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB71C36AE9;
        Sat,  1 Jan 2022 17:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641057939;
        bh=wVzs2I90SVS0VgI1GrDKWfQHs32ZhZLROC6lh3nYjh0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=P8aVCJkh8LRChuZM8HhZrGk7ngTezKkANOdCyTm+oPDHwA925SbxC9xCEaxLhDv7w
         fy2dd35xvJ55o9a5+4SS+wRT066L5qXUGFwEmXasSThY/h9vv65hRZVvpEqIfpCLsY
         HV6r+hEJfZVBeux37Dh/5WpwYssVch3t126yq4C0OmnGUKVI+8V19MbRZnDmQ8erfz
         ii8zRA9dnuNZRmlF4wxKlmz25tOkmSlmPPwwXjaTi/z1ZPyIDIYgoJwFHMvegtQcwj
         dP7HjB+v9UIiReA6fZLbZCZ0/btpyGAH1O0GKm87OEPEBGfSgstXgybxOPw9taeYHK
         TRFP0DEgupLtA==
Message-ID: <aef1ecb9-0757-0bbf-74a5-70d88fd52e08@kernel.org>
Date:   Sat, 1 Jan 2022 19:25:34 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] interconnect: imx: Switch from
 imx_icc_node_adj_desc to fsl,icc-id node assignment
Content-Language: en-US
To:     Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220101163956.3344467-1-abel.vesa@nxp.com>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20220101163956.3344467-1-abel.vesa@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

Thanks for working on this!

On 1.01.22 18:39, Abel Vesa wrote:
> In order to be able to have more than one NoCs in the interconnect net
> we need to decouple the NoC from the dram. So instead of using the
> imx_icc_node_adj_desc, we use the fsl,icc-id property that is in
> each NoC (or pl301) to the icc node (based on the id) to it.

I believe that this DT property should be documented somewhere.
Maybe in Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml?

BR,
Georgi

> Along with all the NoC and pl301 nodes in the dts we will have a
> interconnect dedicated node. This node will be the actual device of the
> icc provider.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
> 
> No changes since v1.
> 
>   drivers/interconnect/imx/imx.c | 70 +++++++++++++++-------------------
>   1 file changed, 31 insertions(+), 39 deletions(-)

