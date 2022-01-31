Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9034A3D85
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 06:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbiAaF4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 00:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiAaF4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 00:56:41 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75996C061714
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 21:56:40 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id a7so11936266qvl.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 21:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c4RcLnij2Gc2mO9NDMLPeqJGpX7x9puJhAk+zOLg87U=;
        b=ZmShtDTChKkK8HPg3hOqDGPhaNAC3aWAuUTtF+zHHCb46fRZQaGsSjdUC7X7cZqm9b
         uwY3/RSRk1U6yW1KMkcyuPNCTWOSWxQ/MgXQQXbvpHrq9zoBvvN9RPDB6yWL6m/ng4K3
         DBjd+0FZfYllfs2BErPBaE0cJzjB+jzWhJ1sE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c4RcLnij2Gc2mO9NDMLPeqJGpX7x9puJhAk+zOLg87U=;
        b=KHdDrTcodcd4LmRruIiLRhyrJurZcYW9WgBzaY8RxEZkWwcPQ1dqJ6jHJdhq1pwt3q
         xNcjgjX4yAjdfI65byPkIYtG/Xvf4xIRq8W+DhruzhdeMuh8RWILDTOSQ6j6XJjn0YiD
         hgDW8z/Q2XZLPwU44VHp+nVe5k9lOTSqTSCiVYuecBLc4+GbdJHRcwYsc0qDEKoopuII
         xeXKPANdh1TjhVyLWmZcdmaYSwRup+QVIP4M+eiqNT05XxNSTq6zJIb5kCgeEnFKe0wp
         PU60cGD3FKQqbmzCQZKmr0uS1BRvooPsElPDF1opJSKJTkiogPOHE0B8cIQGK1kd4Lti
         UCPQ==
X-Gm-Message-State: AOAM531BGWmxpLfIUs655hZCZT0NxFBLC2xpqAe8rGpa2aJ9rZxUCNkO
        H9CQpCU3VWaEVDQ2uNjsSM1g3XD4LngBVkq9jsI=
X-Google-Smtp-Source: ABdhPJzlAJKd/R8qWDU3a0Ds/mtSrdwjVsFem/X3czsKz5h02BsfLFkHo5AfK4PAI97BLbdwKMzXXEb6djd5uOh2Frg=
X-Received: by 2002:a05:6214:301e:: with SMTP id ke30mr16693614qvb.49.1643608599287;
 Sun, 30 Jan 2022 21:56:39 -0800 (PST)
MIME-Version: 1.0
References: <20220110155827.13976-1-eajames@linux.ibm.com>
In-Reply-To: <20220110155827.13976-1-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 31 Jan 2022 05:56:27 +0000
Message-ID: <CACPK8XdgOYTwy5aOQgSuSJaQUjxnobN2c3ph=dkAcWYJDVbN+w@mail.gmail.com>
Subject: Re: [PATCH] fsi: occ: Improve response status checking
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Popple <alistair@popple.id.au>,
        Jeremy Kerr <jk@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2022 at 15:58, Eddie James <eajames@linux.ibm.com> wrote:
>
> If the driver sequence number coincidentally equals the previous
> command response sequence number, the driver may proceed with
> fetching the entire buffer before the OCC has processed the current
> command. To be sure the correct response is obtained, check the
> command type and also retry if any of the response parameters have
> changed when the rest of the buffer is fetched.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/fsi/fsi-occ.c | 63 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 44 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
> index 7eaab1be0aa4..67569282dd69 100644
> --- a/drivers/fsi/fsi-occ.c
> +++ b/drivers/fsi/fsi-occ.c
> @@ -451,6 +451,15 @@ static int occ_trigger_attn(struct occ *occ)
>         return rc;
>  }
>
> +static void fsi_occ_print_timeout(struct occ *occ, struct occ_response *resp,
> +                                 u8 seq_no, u8 cmd_type)
> +{
> +       dev_err(occ->dev,
> +               "resp timeout status=%02x seq=%d cmd=%d, our seq=%d cmd=%d\n",
> +               resp->return_status, resp->seq_no, resp->cmd_type, seq_no,
> +               cmd_type);
> +}
> +
>  int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
>                    void *response, size_t *resp_len)
>  {
> @@ -461,12 +470,14 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
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
> +       bool retried = false;
>
>         *resp_len = 0;
>
> @@ -478,6 +489,8 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
>                 return -EINVAL;
>         }
>
> +       cmd_type = byte_request[1];
> +
>         /* Checksum the request, ignoring first byte (sequence number). */
>         for (i = 1; i < req_len - 2; ++i)
>                 checksum += byte_request[i];
> @@ -509,30 +522,30 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
>         if (rc)
>                 goto done;
>
> -       /* Read occ response header */
> -       start = jiffies;
> +retry:
> +       end = jiffies + timeout;
>         do {
> +               /* Read occ response header */
>                 rc = occ_getsram(occ, 0, resp, 8);
>                 if (rc)
>                         goto done;
>
>                 if (resp->return_status == OCC_RESP_CMD_IN_PRG ||
>                     resp->return_status == OCC_RESP_CRIT_INIT ||
> -                   resp->seq_no != seq_no) {
> -                       rc = -ETIMEDOUT;
> -
> -                       if (time_after(jiffies, start + timeout)) {
> -                               dev_err(occ->dev, "resp timeout status=%02x "
> -                                       "resp seq_no=%d our seq_no=%d\n",
> -                                       resp->return_status, resp->seq_no,
> -                                       seq_no);
> +                   resp->seq_no != seq_no || resp->cmd_type != cmd_type) {

You're testing for two different types of conditions. The first is
when the SBE is busy doing something else:

                if (resp->return_status == OCC_RESP_CMD_IN_PRG ||
                     resp->return_status == OCC_RESP_CRIT_INIT ||

And the others are when the message is not for the current user:

                      resp->seq_no != seq_no || resp->cmd_type != cmd_type) {

Should we be separating them out? It makes sense that the first means
we should keep trying. For the second case should we bail straight
away, instead of waiting for the timeout?

How often do we see one vs the other?

> +                       if (time_after(jiffies, end)) {
> +                               fsi_occ_print_timeout(occ, resp, seq_no,
> +                                                     cmd_type);
> +                               rc = -ETIMEDOUT;
>                                 goto done;
>                         }
>
>                         set_current_state(TASK_UNINTERRUPTIBLE);
>                         schedule_timeout(wait_time);
> +               } else {
> +                       break;
>                 }
> -       } while (rc);
> +       } while (true);

Use while (true) instead of do { } while (true) to make it clearer
what's going on. Or refactor it to put the time_after in the while(),
as this is what the loop is waiting on.

>
>         /* Extract size of response data */
>         resp_data_length = get_unaligned_be16(&resp->data_length);
> @@ -543,17 +556,29 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
>                 goto done;
>         }
>
> -       dev_dbg(dev, "resp_status=%02x resp_data_len=%d\n",
> -               resp->return_status, resp_data_length);
> -
> -       /* Grab the rest */
> +       /* Now get the entire response; get header again in case it changed */
>         if (resp_data_length > 1) {
> -               /* already got 3 bytes resp, also need 2 bytes checksum */
> -               rc = occ_getsram(occ, 8, &resp->data[3], resp_data_length - 1);
> +               rc = occ_getsram(occ, 0, resp, resp_data_length + 7);
>                 if (rc)
>                         goto done;
> +
> +               if (resp->return_status == OCC_RESP_CMD_IN_PRG ||
> +                   resp->return_status == OCC_RESP_CRIT_INIT ||
> +                   resp->seq_no != seq_no || resp->cmd_type != cmd_type) {
> +                       if (!retried) {
> +                               retried = true;
> +                               goto retry;

Not sure about this.

How often did this situation come up?

Did you consider instead returning an error here?

> +                       }
> +
> +                       fsi_occ_print_timeout(occ, resp, seq_no, cmd_type);
> +                       rc = -ETIMEDOUT;
> +                       goto done;
> +               }
>         }
>
> +       dev_dbg(dev, "resp_status=%02x resp_data_len=%d\n",
> +               resp->return_status, resp_data_length);
> +
>         occ->client_response_size = resp_data_length + 7;
>         rc = occ_verify_checksum(occ, resp, resp_data_length);
>
> @@ -598,7 +623,7 @@ static int occ_probe(struct platform_device *pdev)
>         occ->version = (uintptr_t)of_device_get_match_data(dev);
>         occ->dev = dev;
>         occ->sbefifo = dev->parent;
> -       occ->sequence_number = 1;
> +       occ->sequence_number = (u8)((jiffies % 0xff) + 1);

This is interesting. You didn't mention this in the commit message;
you're trying to get a random number for the sequence number?

>         mutex_init(&occ->occ_lock);
>
>         if (dev->of_node) {
> --
> 2.27.0
>
