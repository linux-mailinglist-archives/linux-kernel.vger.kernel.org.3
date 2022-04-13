Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1B04FFD3A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 19:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbiDMSAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237537AbiDMR7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:59:54 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DFA6D960
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 10:57:29 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id k23so5555406ejd.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 10:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D5aVysMwRQ6dl6CPnKtkSr6T5SueY5Ook3lK/Eo4N5Y=;
        b=Ck9JeEmOmmdRAFSdhcMrQT6nfHEymkxpG9HE4gbPmcpCDO326D9b+/0vCjOdXVaOkJ
         CLK1XYe0LTK2/inje5GQj8IWxcWX8rdMc2zHhInPPI6zJTmJRpngg5AZV5v/CCfwIo28
         9BaVPK6pN9bDqGvune8yAoVxuH1SuGfvepCbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D5aVysMwRQ6dl6CPnKtkSr6T5SueY5Ook3lK/Eo4N5Y=;
        b=cGC51e5eB+miSeQx7SZw+uhskz/yHCSEc8RTG+jHqNuuklHiLMcOVc275+eYLbVuUR
         US2fKAI0J58HbEUvmcCeeb0EGMyH8m16n/RoVmbtC2M8T67p4UiiI304Ef7TZuF75XOf
         CAj8prw6znD4t1msFyBREoGaJUN3wUilocHYpfItbjwsEEinPXNMHwUX7UpQCkDdjgLN
         ykG15u88iP19zpJvFpefMdVSUMPxw9CZACoqaHD1ge+clAtNYovSLy/PqEw6yX+Dq7gY
         NrmJTgPpN4VImXDB01gEjsEbN1OOE52sbzz2piMZalNQgz3lEeJZZrNyXFT9s+DUdbEe
         cc/Q==
X-Gm-Message-State: AOAM532+rUFYvyZYbyOicrVC5/xvfbqp5nPkLGaS4e97Sh2O7eqBd1nP
        r1kOU2UD708wCEAacAdy5Ktdbj17qDKnuA==
X-Google-Smtp-Source: ABdhPJw5CYSDEpjEfN/QgCao/xaeO24ykQ+mw/G/g4A8wBiKDq3YFQgeD3JYIy8KSU09geyHmLr2tg==
X-Received: by 2002:a17:906:2f97:b0:6ce:3ef6:94be with SMTP id w23-20020a1709062f9700b006ce3ef694bemr40753299eji.136.1649872647503;
        Wed, 13 Apr 2022 10:57:27 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id qf21-20020a1709077f1500b006e84ee40742sm207704ejc.218.2022.04.13.10.57.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 10:57:26 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id q3so3102110wrj.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 10:57:26 -0700 (PDT)
X-Received: by 2002:adf:e194:0:b0:207:b4c9:31c6 with SMTP id
 az20-20020adfe194000000b00207b4c931c6mr81569wrb.102.1649872646107; Wed, 13
 Apr 2022 10:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <1649769311-22622-1-git-send-email-quic_vgarodia@quicinc.com> <1649769311-22622-2-git-send-email-quic_vgarodia@quicinc.com>
In-Reply-To: <1649769311-22622-2-git-send-email-quic_vgarodia@quicinc.com>
From:   Fritz Koenig <frkoenig@chromium.org>
Date:   Wed, 13 Apr 2022 10:57:14 -0700
X-Gmail-Original-Message-ID: <CAMfZQbzm-YCK-Skz0BcOmq4rDX1HjeEapECNNaUNkj7pjm5uCw@mail.gmail.com>
Message-ID: <CAMfZQbzm-YCK-Skz0BcOmq4rDX1HjeEapECNNaUNkj7pjm5uCw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] media: venus: do not queue internal buffers from
 previous sequence
To:     Vikash Garodia <quic_vgarodia@quicinc.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Fritz Koenig <frkoenig@chromium.org>


On Tue, Apr 12, 2022 at 6:23 AM Vikash Garodia
<quic_vgarodia@quicinc.com> wrote:
>
> During reconfig (DRC) event from firmware, it is not guaranteed that
> all the DPB(internal) buffers would be released by the firmware. Some
> buffers might be released gradually while processing frames from the
> new sequence. These buffers now stay idle in the dpblist.
> In subsequent call to queue the DPBs to firmware, these idle buffers
> should not be queued. The fix identifies those buffers and free them.
>
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/helpers.c | 34 +++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index 0bca95d..fa01edd 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -90,12 +90,28 @@ bool venus_helper_check_codec(struct venus_inst *inst, u32 v4l2_pixfmt)
>  }
>  EXPORT_SYMBOL_GPL(venus_helper_check_codec);
>
> +static void free_dpb_buf(struct venus_inst *inst, struct intbuf *buf)
> +{
> +       ida_free(&inst->dpb_ids, buf->dpb_out_tag);
> +
> +       list_del_init(&buf->list);
> +       dma_free_attrs(inst->core->dev, buf->size, buf->va, buf->da,
> +                      buf->attrs);
> +       kfree(buf);
> +}
> +
>  int venus_helper_queue_dpb_bufs(struct venus_inst *inst)
>  {
> -       struct intbuf *buf;
> +       struct intbuf *buf, *next;
> +       unsigned int dpb_size = 0;
>         int ret = 0;
>
> -       list_for_each_entry(buf, &inst->dpbbufs, list) {
> +       if (inst->dpb_buftype == HFI_BUFFER_OUTPUT)
> +               dpb_size = inst->output_buf_size;
> +       else if (inst->dpb_buftype == HFI_BUFFER_OUTPUT2)
> +               dpb_size = inst->output2_buf_size;
> +
> +       list_for_each_entry_safe(buf, next, &inst->dpbbufs, list) {
>                 struct hfi_frame_data fdata;
>
>                 memset(&fdata, 0, sizeof(fdata));
> @@ -106,6 +122,12 @@ int venus_helper_queue_dpb_bufs(struct venus_inst *inst)
>                 if (buf->owned_by == FIRMWARE)
>                         continue;
>
> +               /* free buffer from previous sequence which was released later */
> +               if (dpb_size > buf->size) {
> +                       free_dpb_buf(inst, buf);
> +                       continue;
> +               }
> +
>                 fdata.clnt_data = buf->dpb_out_tag;
>
>                 ret = hfi_session_process_buf(inst, &fdata);
> @@ -127,13 +149,7 @@ int venus_helper_free_dpb_bufs(struct venus_inst *inst)
>         list_for_each_entry_safe(buf, n, &inst->dpbbufs, list) {
>                 if (buf->owned_by == FIRMWARE)
>                         continue;
> -
> -               ida_free(&inst->dpb_ids, buf->dpb_out_tag);
> -
> -               list_del_init(&buf->list);
> -               dma_free_attrs(inst->core->dev, buf->size, buf->va, buf->da,
> -                              buf->attrs);
> -               kfree(buf);
> +               free_dpb_buf(inst, buf);
>         }
>
>         if (list_empty(&inst->dpbbufs))
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
