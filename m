Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4A849F707
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238538AbiA1KRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:17:32 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56278 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244839AbiA1KRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:17:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24C5D61E50;
        Fri, 28 Jan 2022 10:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CF8C340E6;
        Fri, 28 Jan 2022 10:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643365025;
        bh=hULxR6bdXjPSimROGWCwHC0PuL4KxtAplmQkFP5Xb/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IEVQWx+82dWXak6hO7ao6/lM8FJBdKFpRkLsuPRCBn95fWSpqPdZea5p1tgRVqoDG
         AvMpMTLBU2wjvkFmWYw6MxBWtxnT9INOCtIo9NOhEcRPv18HiwJaGxkpgMyLnie5gy
         O8AkF5KPyd2qeK2VhYBRE9A5zDKe3L6auhc0Ldzw=
Date:   Fri, 28 Jan 2022 11:17:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: mtk-vcodec: Fix a NULL pointer dereference in
 mtk_vcodec_fw_scp_init()
Message-ID: <YfPCnsZ1Vce3fJ1u@kroah.com>
References: <20220124170731.59240-1-zhou1615@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124170731.59240-1-zhou1615@umn.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 01:07:31AM +0800, Zhou Qingyang wrote:
> In mtk_vcodec_fw_scp_init(), devm_kzalloc() is assigned to fw and there is
> a dereference of it right after that, which could lead to NULL pointer
> dereference on failure of devm_kzalloc().
> 
> Fix this bug by adding a NULL check of fw.
> 
> This bug was found by a static analyzer.
> 
> Builds with 'make allyesconfig' show no new warnings,
> and our static analyzer no longer warns about this code.
> 
> Fixes: 46233e91fa24 ("media: mtk-vcodec: move firmware implementations into their own files")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> ---
> The analysis employs differential checking to identify inconsistent 
> security operations (e.g., checks or kfrees) between two code paths 
> and confirms that the inconsistent operations are not recovered in the
> current function or the callers, so they constitute bugs. 
> 
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.
> 
>  drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c
> index d8e66b645bd8..aa36bee51d01 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c
> @@ -65,6 +65,9 @@ struct mtk_vcodec_fw *mtk_vcodec_fw_scp_init(struct mtk_vcodec_dev *dev)
>  	}
>  
>  	fw = devm_kzalloc(&dev->plat_dev->dev, sizeof(*fw), GFP_KERNEL);
> +	if (!fw)
> +		return ERR_PTR(-ENOMEM);
> +
>  	fw->type = SCP;
>  	fw->ops = &mtk_vcodec_rproc_msg;
>  	fw->scp = scp;
> -- 
> 2.25.1
> 

As stated before, umn.edu is still not allowed to contribute to the
Linux kernel.  Please work with your administration to resolve this
issue.

