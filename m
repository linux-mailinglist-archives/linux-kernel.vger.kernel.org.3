Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242784EAEEB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 15:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237657AbiC2OAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbiC2OAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:00:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A69DE9E;
        Tue, 29 Mar 2022 06:59:00 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:a:f397:f6bc:b726:2678:839f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id D8FB31F43F90;
        Tue, 29 Mar 2022 14:58:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648562339;
        bh=iytszQRL5K7YW4DDJkdUOyAYpv9yCWffgsGBzqTU7cU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=apm6Y2FyQBmfMOrcXEAeBHYrgxGYQgUJyc3bMqNL2hOluyR3hQ7DXGRzfs8kQKx41
         Lax1BRXIA5QQ2nrpuJD7EJJWGyXXgktx1JxkjQRMu9u2FwPlaPz1nPtalSLt+7L92Y
         TBNwrBQ5N9VJ/I/vlBj8gccrkUXL4s7uq0BWnbkPMl/8FPV/LiOdtR11l/NBHTcEA8
         2VEFo5LatzR+fqUO6NKgMglr2q7nnRseECThnV519JtZ576m4mZkMOPiEP4eNhT8BA
         twrg3kNtPKhf0bfJVpjONNVeT1/pgyxe+IyB1F108sEHwNYLckckj2Zvz5C1aB2XB7
         VHE4HeWckdKsw==
Date:   Tue, 29 Mar 2022 15:58:55 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>, kernel@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 10/24] media: v4l2-mem2mem: Trace on implicit un-hold
Message-ID: <20220329135855.rgc7qyzhia3qhavb@basti-XPS-13-9310>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
 <20220328195936.82552-11-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20220328195936.82552-11-nicolas.dufresne@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Nicolas,

On 28.03.2022 15:59, Nicolas Dufresne wrote:
>If the timestamp of the src buffer differs from the timestamp of a held
>dst buffer, the held buffer is implicitly removed and marked as done.
>Add a trace to help debugging if someone hits that case.
>
>Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>

Greetings,
Sebastian

>---
> drivers/media/v4l2-core/v4l2-mem2mem.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
>index 53c2332d5cbd..d3e739ef16ef 100644
>--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
>+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
>@@ -336,6 +336,7 @@ static void __v4l2_m2m_try_queue(struct v4l2_m2m_dev *m2m_dev,
> 	if (src && dst && dst->is_held &&
> 	    dst->vb2_buf.copied_timestamp &&
> 	    dst->vb2_buf.timestamp != src->vb2_buf.timestamp) {
>+		dprintk("src and dst timestamp mismatch, removing held capture buffer.\n");
> 		dst->is_held = false;
> 		v4l2_m2m_dst_buf_remove(m2m_ctx);
> 		v4l2_m2m_buf_done(dst, VB2_BUF_STATE_DONE);
>-- 
>2.34.1
>
