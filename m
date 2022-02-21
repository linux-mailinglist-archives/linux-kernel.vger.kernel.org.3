Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4CE4BE91F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349772AbiBUJ0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 04:26:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348203AbiBUJRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:17:43 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A1133A2A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 01:07:13 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id j78so11172157qke.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 01:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FmpSAZ3hEbOmM+YcJkuE6s+XdxEo4hs8YZ+zU2PSQ7Y=;
        b=fcflqexApJQ2RAjR6lFL13izeadAkDp1hvnRFrmC/oL1FUnkyhRjsqPEAydCKiTSZo
         miMjo+XOzfki5PT+YFHaLkC2T4YCpi2PfuFcnAsz1WEmHAYqyKQcy8YqZO46HkV0Nfxh
         GcPKRHMpmwkIZ0sTXCb+mEo8vQBF4c5iuAKfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FmpSAZ3hEbOmM+YcJkuE6s+XdxEo4hs8YZ+zU2PSQ7Y=;
        b=zDPfid9z/ct6MDiPJSRywrbgkV+ot8FmyxDK4pkDhe+TWYF+C347ZKB4v3FsKExJTS
         rqF9qbYEIepw59sTE5124A9zxKgVls4GJ4RuUczyGKFAv2Xz5A+mgx0t7hgjThtEP2w5
         VpmoS2CwMCLvMEbHoPHSVQzLyzaef+QTfncZ5wLWKT7scwzW/YUpNg9awbM+5LHaP357
         XtSJu4/GWhskHIvIijCSFNSHMgNaavs72eVb0kpzktxlj3yW0S6H+3Io05IiuycB+roD
         wcYKcndTjpwqX2ajuvg225y6sJv8i0lM2hI5ul3sRTAhxU9TjOUboqIZMMc/1jG28v9K
         ZYdw==
X-Gm-Message-State: AOAM533menPTI/yLdjDRyFaCGqJBnqk/NN1m+AXk1btAuDK/RWSJQZY1
        lN830ArDqc1dwAxrKbcx2kmCnhMAPvy/qjdBu5A=
X-Google-Smtp-Source: ABdhPJzROqfyPwLpRY4kLr3wsUUMPSD8zJLC0BprwPfRH5+TxUOlJdbNhqz9Lur7GQSWRk5D3YaINIW0/K5wH4QOWEE=
X-Received: by 2002:ae9:e841:0:b0:508:1f6e:f020 with SMTP id
 a62-20020ae9e841000000b005081f6ef020mr11264614qkg.243.1645434432469; Mon, 21
 Feb 2022 01:07:12 -0800 (PST)
MIME-Version: 1.0
References: <20220208152235.19686-1-eajames@linux.ibm.com>
In-Reply-To: <20220208152235.19686-1-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 21 Feb 2022 09:07:00 +0000
Message-ID: <CACPK8Xe-amsBm=Q7pLgyMvdrxP4oCXB4YgxFuQJLvvmM+4g3NQ@mail.gmail.com>
Subject: Re: [PATCH v2] fsi: occ: Improve response status checking
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Alistair Popple <alistair@popple.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Feb 2022 at 15:22, Eddie James <eajames@linux.ibm.com> wrote:
>
> If the driver sequence number coincidentally equals the previous
> command response sequence number, the driver may proceed with
> fetching the entire buffer before the OCC has processed the current
> command. To be sure the correct response is obtained, check the
> command type and also retry if any of the response parameters have
> changed when the rest of the buffer is fetched. Also initialize the
> driver with a random sequence number in order to reduce the chances
> of this happening.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

I've applied this for v5.18.

> ---
> Changes since v1:
>  - Refactor the retry into one loop
>  - Add a comment about the pseudo-random number
>
>  drivers/fsi/fsi-occ.c | 87 ++++++++++++++++++++++++++++---------------
>  1 file changed, 56 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
> index 7eaab1be0aa4..c9cc75fbdfb9 100644
> --- a/drivers/fsi/fsi-occ.c
> +++ b/drivers/fsi/fsi-occ.c
> @@ -451,6 +451,14 @@ static int occ_trigger_attn(struct occ *occ)
>         return rc;
>  }
>
> +static bool fsi_occ_response_not_ready(struct occ_response *resp, u8 seq_no,
> +                                      u8 cmd_type)
> +{
> +       return resp->return_status == OCC_RESP_CMD_IN_PRG ||
> +               resp->return_status == OCC_RESP_CRIT_INIT ||
> +               resp->seq_no != seq_no || resp->cmd_type != cmd_type;
> +}
> +
>  int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
>                    void *response, size_t *resp_len)
>  {
> @@ -461,10 +469,11 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
>         struct occ_response *resp = response;
>         size_t user_resp_len = *resp_len;
>         u8 seq_no;
> +       u8 cmd_type;
>         u16 checksum = 0;
>         u16 resp_data_length;
>         const u8 *byte_request = (const u8 *)request;
> -       unsigned long start;
> +       unsigned long end;
>         int rc;
>         size_t i;
>
> @@ -478,6 +487,8 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
>                 return -EINVAL;
>         }
>
> +       cmd_type = byte_request[1];
> +
>         /* Checksum the request, ignoring first byte (sequence number). */
>         for (i = 1; i < req_len - 2; ++i)
>                 checksum += byte_request[i];
> @@ -509,51 +520,61 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
>         if (rc)
>                 goto done;
>
> -       /* Read occ response header */
> -       start = jiffies;
> -       do {
> +       end = jiffies + timeout;
> +       while (true) {
> +               /* Read occ response header */
>                 rc = occ_getsram(occ, 0, resp, 8);
>                 if (rc)
>                         goto done;
>
> -               if (resp->return_status == OCC_RESP_CMD_IN_PRG ||
> -                   resp->return_status == OCC_RESP_CRIT_INIT ||
> -                   resp->seq_no != seq_no) {
> -                       rc = -ETIMEDOUT;
> -
> -                       if (time_after(jiffies, start + timeout)) {
> -                               dev_err(occ->dev, "resp timeout status=%02x "
> -                                       "resp seq_no=%d our seq_no=%d\n",
> +               if (fsi_occ_response_not_ready(resp, seq_no, cmd_type)) {
> +                       if (time_after(jiffies, end)) {
> +                               dev_err(occ->dev,
> +                                       "resp timeout status=%02x seq=%d cmd=%d, our seq=%d cmd=%d\n",
>                                         resp->return_status, resp->seq_no,
> -                                       seq_no);
> +                                       resp->cmd_type, seq_no, cmd_type);
> +                               rc = -ETIMEDOUT;
>                                 goto done;
>                         }
>
>                         set_current_state(TASK_UNINTERRUPTIBLE);
>                         schedule_timeout(wait_time);
> -               }
> -       } while (rc);
> -
> -       /* Extract size of response data */
> -       resp_data_length = get_unaligned_be16(&resp->data_length);
> +               } else {
> +                       /* Extract size of response data */
> +                       resp_data_length =
> +                               get_unaligned_be16(&resp->data_length);
> +
> +                       /*
> +                        * Message size is data length + 5 bytes header + 2
> +                        * bytes checksum
> +                        */
> +                       if ((resp_data_length + 7) > user_resp_len) {
> +                               rc = -EMSGSIZE;
> +                               goto done;
> +                       }
>
> -       /* Message size is data length + 5 bytes header + 2 bytes checksum */
> -       if ((resp_data_length + 7) > user_resp_len) {
> -               rc = -EMSGSIZE;
> -               goto done;
> +                       /*
> +                        * Get the entire response including the header again,
> +                        * in case it changed
> +                        */
> +                       if (resp_data_length > 1) {
> +                               rc = occ_getsram(occ, 0, resp,
> +                                                resp_data_length + 7);
> +                               if (rc)
> +                                       goto done;
> +
> +                               if (!fsi_occ_response_not_ready(resp, seq_no,
> +                                                               cmd_type))
> +                                       break;
> +                       } else {
> +                               break;
> +                       }
> +               }
>         }
>
>         dev_dbg(dev, "resp_status=%02x resp_data_len=%d\n",
>                 resp->return_status, resp_data_length);
>
> -       /* Grab the rest */
> -       if (resp_data_length > 1) {
> -               /* already got 3 bytes resp, also need 2 bytes checksum */
> -               rc = occ_getsram(occ, 8, &resp->data[3], resp_data_length - 1);
> -               if (rc)
> -                       goto done;
> -       }
> -
>         occ->client_response_size = resp_data_length + 7;
>         rc = occ_verify_checksum(occ, resp, resp_data_length);
>
> @@ -598,7 +619,11 @@ static int occ_probe(struct platform_device *pdev)
>         occ->version = (uintptr_t)of_device_get_match_data(dev);
>         occ->dev = dev;
>         occ->sbefifo = dev->parent;
> -       occ->sequence_number = 1;
> +       /*
> +        * Quickly derive a pseudo-random number from jiffies so that
> +        * re-probing the driver doesn't accidentally overlap sequence numbers.
> +        */
> +       occ->sequence_number = (u8)((jiffies % 0xff) + 1);
>         mutex_init(&occ->occ_lock);
>
>         if (dev->of_node) {
> --
> 2.27.0
>
