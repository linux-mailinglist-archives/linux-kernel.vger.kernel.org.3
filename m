Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5062A5101AB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352238AbiDZPPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352231AbiDZPLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:11:33 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22ED915AE3B;
        Tue, 26 Apr 2022 08:08:02 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:3:7d2:2277:ba57:a2c0:3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 2EF7F1F43AF8;
        Tue, 26 Apr 2022 16:08:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650985680;
        bh=/9X+6WyLqs1GN7OeFO40lgmlj/Imhhsr/HAhx6cMuHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tc3VgAmsk+pe98NajtEuMllc5Pcw0UM1wLnGZ1T8PjqjkbE7ZfbPQwO6mEmGUS5Hi
         Ncshj9lg+j+fFJ0A44gEapJq9As4255mgQl+3d+hb7PTdsdFKhpkc4bnODLtss15is
         zwk55+lo8K4c4rXWIocsYlhaCb95EzdMxCsPtYwgcYasa6Dl7LxqvmlCl2a7ZbvGRC
         VxgwXyKAEqj+MclS9dBu7Vr/8EoTdzPH6ygL5EniVWaOeGzx3L9YyoOLmNvrrdokvT
         SFxSX2OkzbLwRk41JN71XewFNkWxSDuhvjiEh4ihoh34xa1XhjVRAUBjfTDufzosXQ
         cZE+Nu3JDBzbQ==
Date:   Tue, 26 Apr 2022 17:07:56 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, gregkh@linuxfoundation.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        jon@nanocrew.net, aford173@gmail.com, kernel@collabora.com
Subject: Re: [PATCH v2] media: hantro: HEVC: unconditionnaly set
 pps_{cb/cr}_qp_offset values
Message-ID: <20220426150756.ecjc4q5ncxzy3lva@basti-XPS-13-9310>
References: <20220426135034.694655-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20220426135034.694655-1-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Benjamin,

On 26.04.2022 15:50, Benjamin Gaignard wrote:
>Always set pps_cb_qp_offset and pps_cr_qp_offset values in Hantro/G2
>register whatever is V4L2_HEVC_PPS_FLAG_PPS_SLICE_CHROMA_QP_OFFSETS_PRESENT
>flag value.
>This fix CAINIT_G_SHARP_3 test in fluster.

just a small typo:
s/fix/fixes the/

Greetings,
Sebastian
>
>Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>---
> drivers/staging/media/hantro/hantro_g2_hevc_dec.c | 9 ++-------
> 1 file changed, 2 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
>index 6deb31b7b993..503f4b028bc5 100644
>--- a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
>+++ b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
>@@ -194,13 +194,8 @@ static void set_params(struct hantro_ctx *ctx)
> 		hantro_reg_write(vpu, &g2_max_cu_qpd_depth, 0);
> 	}
>
>-	if (pps->flags & V4L2_HEVC_PPS_FLAG_PPS_SLICE_CHROMA_QP_OFFSETS_PRESENT) {
>-		hantro_reg_write(vpu, &g2_cb_qp_offset, pps->pps_cb_qp_offset);
>-		hantro_reg_write(vpu, &g2_cr_qp_offset, pps->pps_cr_qp_offset);
>-	} else {
>-		hantro_reg_write(vpu, &g2_cb_qp_offset, 0);
>-		hantro_reg_write(vpu, &g2_cr_qp_offset, 0);
>-	}
>+	hantro_reg_write(vpu, &g2_cb_qp_offset, pps->pps_cb_qp_offset);
>+	hantro_reg_write(vpu, &g2_cr_qp_offset, pps->pps_cr_qp_offset);
>
> 	hantro_reg_write(vpu, &g2_filt_offset_beta, pps->pps_beta_offset_div2);
> 	hantro_reg_write(vpu, &g2_filt_offset_tc, pps->pps_tc_offset_div2);
>-- 
>2.32.0
>
