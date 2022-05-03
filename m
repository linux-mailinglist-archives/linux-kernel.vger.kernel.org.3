Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D32518581
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 15:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbiECNfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 09:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiECNfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 09:35:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91AE19009;
        Tue,  3 May 2022 06:32:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: benjamin.gaignard)
        with ESMTPSA id 35C8E1F443C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651584734;
        bh=Yi4Uy3F9RG9QTJLxf0BYd+sKJm9SOsJsPZxDl2eQp+c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YAhIWzoJSCAXq5It7jKfdawVuvvInO28kuCcMsjmB6x+77mzHXZnyHilP2X+kVkxI
         IG9gajNggO4Y3/UONQQHveTQUWtDnJhYB8QO8n+/AYqw2IShuvKGAChfEE2P/jwF8t
         3JXnCyn9gdOp9d6Al9wIMsZxvDyjLx5oCRrHIjs49MkoAZFpJ9USC2wMGHoHgRoQ5F
         ffNYdTmmk3rTfsEZkalCVTIB80UOySDdGfQ9MO0652hUW4fdm0lThUOn2FdBqTL3PS
         9r5lXAxgJA82p2kER/89vTPTsz2fvGSksqKjzg5G4f5HdRSFzNNvU+X7H/tcuS4WjL
         /qqESlYcvrGPg==
Message-ID: <010be970-2463-f65b-dbef-0a2784530981@collabora.com>
Date:   Tue, 3 May 2022 15:32:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] media: hantro: HEVC: unconditionnaly set
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
References: <20220426135034.694655-1-benjamin.gaignard@collabora.com>
 <CAAEAJfAvUjtR4w0uaZ5yFueXu8jNbH-gmWUOEZxoJH78771RSA@mail.gmail.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <CAAEAJfAvUjtR4w0uaZ5yFueXu8jNbH-gmWUOEZxoJH78771RSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 03/05/2022 à 15:12, Ezequiel Garcia a écrit :
> Hi Benjamin,
>
> On Tue, Apr 26, 2022 at 10:50 AM Benjamin Gaignard
> <benjamin.gaignard@collabora.com> wrote:
>> Always set pps_cb_qp_offset and pps_cr_qp_offset values in Hantro/G2
>> register whatever is V4L2_HEVC_PPS_FLAG_PPS_SLICE_CHROMA_QP_OFFSETS_PRESENT
>> flag value.
> I would say we need more justification why this is correct, or at least
> checking what the reference vendor implementation is doing (and mentioning
> in the commit description so we can track it in the future).

Yes that is what the vendor implementation is doing.

>
>> This fix CAINIT_G_SHARP_3 test in fluster.
>>
> This could sound like a tad a pedantic detail, but I'd say it's
> important we stop refering to tests
> as "fluster tests", and instead say something more correct as "HEVC
> conformance test CAINIT_G_SHARP_3".

As you want.

>
> Also, when we are fixing conformance tests, let's please add the
> Fluster score (in this case, I think it's
> OK to refer to Fluster).

We are fixing bugs in parallel in the driver, the uAPI and GStreamer
so fluster score evolution reflect that progression and maybe not only
what this patch is fixing.
The best I could says here is that patch fix HEVC conformance test
CAINIT_G_SHARP_3 so fluster score increase by one.

Regards,
Benjamin

>
> PS: Same comments apply to patch "media: hantro: HEVC: Fix reference
> frames management".
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
>> index 6deb31b7b993..503f4b028bc5 100644
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
