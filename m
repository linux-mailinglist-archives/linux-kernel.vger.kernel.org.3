Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B581550E467
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242866AbiDYPbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242846AbiDYPbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:31:19 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C984510F383;
        Mon, 25 Apr 2022 08:28:15 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:ad99:4ace:ca31:d49f] (unknown [IPv6:2a01:e0a:120:3210:ad99:4ace:ca31:d49f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 44A8A1F43242;
        Mon, 25 Apr 2022 16:28:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650900494;
        bh=48BaXLY/uNsEmn7xLJgc/GuMlYBzj62kSh+QLbDxIcI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=emQ4pXse6Bh96pAzWV6F0oNzLQR57rq4ITLze0/0n5Dh6rkZBGdTP2h5GhYAvAcPL
         N5GzxvxGBz2mzAhPklCRaI0fuVnjU1uS4m98nXfyD/2Q6tLVvhhiusR1TiHtx9Ckts
         1hhmjBEqrjSwe/JYrEFYjT55PiLVSo0mco5Ic4oLUOVgEsOqN7ZVkLc5ZGGD+i0hb+
         H8C7QFNMbk4LnhbVHDKmUB/1z9eoZRhm8iaV3Ek1zbYkeDNmBshQTwXXkvLOCTWc1c
         OhbTRvt89M83DPlVTpZxccHue3AyIco7oxy6DX9I6Q/eJmkN3WGT3OaGsDEz2WXd3K
         Hh48FCkis4JkQ==
Message-ID: <d2e699a9-6c2d-ab87-f23f-4b42096d64be@collabora.com>
Date:   Mon, 25 Apr 2022 17:28:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] media: hantro: HEVC: unconditionnaly set
 pps_{cb/cr}_qp_offset values
Content-Language: en-US
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jon@nanocrew.net, Adam Ford <aford173@gmail.com>,
        Collabora Kernel ML <kernel@collabora.com>
References: <20220425105346.324864-1-benjamin.gaignard@collabora.com>
 <CAAEAJfA2K2-YOruDMUjHixaPa1wfTSwpb3K5A-y_i3H6BF7oKQ@mail.gmail.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <CAAEAJfA2K2-YOruDMUjHixaPa1wfTSwpb3K5A-y_i3H6BF7oKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 25/04/2022 à 14:12, Ezequiel Garcia a écrit :
> On Mon, Apr 25, 2022 at 7:53 AM Benjamin Gaignard
> <benjamin.gaignard@collabora.com> wrote:
>> Always set pps_cb_qp_offset and pps_cr_qp_offset values in Hantro/G2
>> register whatever is V4L2_HEVC_PPS_FLAG_PPS_SLICE_CHROMA_QP_OFFSETS_PRESENT
>> flag value.
>> This fix a couple of tests in fluster.
>>
> Which tests?

CAINIT_G_SHARP_3 test.
Hantro proprietary stack (g2dec tool) does the same.

Regards,
Benjamin

>
> Thanks,
> Ezequiel
>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>>   drivers/staging/media/hantro/hantro_g2_hevc_dec.c | 9 ++-------
>>   1 file changed, 2 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
>> index 2c8eb0720db8..bb512389c1a5 100644
>> --- a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
>> +++ b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
>> @@ -194,13 +194,8 @@ static void set_params(struct hantro_ctx *ctx)
>>                  hantro_reg_write(vpu, &g2_max_cu_qpd_depth, 0);
>>          }
>>
>> -       if (pps->flags & V4L2_HEVC_PPS_FLAG_PPS_SLICE_CHROMA_QP_OFFSETS_PRESENT) {
>> -               hantro_reg_write(vpu, &g2_cb_qp_offset, pps->pps_cb_qp_offset);
>> -               hantro_reg_write(vpu, &g2_cr_qp_offset, pps->pps_cr_qp_offset);
>> -       } else {
>> -               hantro_reg_write(vpu, &g2_cb_qp_offset, 0);
>> -               hantro_reg_write(vpu, &g2_cr_qp_offset, 0);
>> -       }
>> +       hantro_reg_write(vpu, &g2_cb_qp_offset, pps->pps_cb_qp_offset);
>> +       hantro_reg_write(vpu, &g2_cr_qp_offset, pps->pps_cr_qp_offset);
>>
>>          hantro_reg_write(vpu, &g2_filt_offset_beta, pps->pps_beta_offset_div2);
>>          hantro_reg_write(vpu, &g2_filt_offset_tc, pps->pps_tc_offset_div2);
>> --
>> 2.32.0
>>
