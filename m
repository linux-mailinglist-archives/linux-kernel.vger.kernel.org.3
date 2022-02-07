Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB404AB84B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348765AbiBGKJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbiBGJ5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:57:04 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D719C043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 01:57:02 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id s1so11387368qtw.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 01:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SUfOHJUcOIZKAiTlghKK/cym8CHoG90ZFze34gnYWYM=;
        b=KzF7z2iKdp6Lo38PIjQ0l8r7o4uPEP+5U80HlLx6ZIXmOYjEn3tGfm0oJk7mOZTRge
         HBnlAZtTE77JrB897+++EXVo80lZay0+7qhNY+NxWb1vHlsqLVxUOKqpgDL4eFS+Tpn0
         F8acPz/KfuEBd3TD3MzzvdHHeWrZGJNffoVWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SUfOHJUcOIZKAiTlghKK/cym8CHoG90ZFze34gnYWYM=;
        b=fdHNMTmTVeE5UCSFagnY3wk7gVONzBM+IyJGKjCJSc+UuRorSmY6vfYm8/KkScDHZX
         aFFcdfAoeHzPe5VjXG7huA7sXi7DDCtx4qUfL58ppM7UyjVLxSQGqI1YYYfwSQQOacde
         hIvMgDjnYQ4aXwO8JkyUawi/4Z8930x1EVVLkIUAsl4606DGTSp8InY40G740C0nROZI
         GjeBnDKHvb0yF9GKGoGrkvc2toveam4sSoryAumKwtk0BJkdF9QxCkOja6y6c2d0NKz2
         7BI+ZpnoqAcI/e7OkkPS6el7wwkns4t3ZIUB+E6z/UQ/iWgk4VT8HzjvG/pH/doQoO1S
         r0GA==
X-Gm-Message-State: AOAM533RJy1OeZiWUO50qc3oNw+srEhYCzZ5f0LCWXR4N6hG6+PU9Vm2
        ZYrjNd3B6M87Wnt8yQGjumLM1zBc/1kYwos4NUEAa3ua
X-Google-Smtp-Source: ABdhPJzwpOKOH2YwxHOx2FAuGdJk32Iv/IUH+id0tJZirhy2zZC22HwR7udnpN/HAyzSewWDLuGTmqOf9UH/qffOs4I=
X-Received: by 2002:ac8:5a93:: with SMTP id c19mr7277316qtc.58.1644227821379;
 Mon, 07 Feb 2022 01:57:01 -0800 (PST)
MIME-Version: 1.0
References: <20220110155827.13976-1-eajames@linux.ibm.com> <CACPK8XdgOYTwy5aOQgSuSJaQUjxnobN2c3ph=dkAcWYJDVbN+w@mail.gmail.com>
 <3897c432-4365-7c54-b336-7331bb328350@linux.ibm.com>
In-Reply-To: <3897c432-4365-7c54-b336-7331bb328350@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 7 Feb 2022 09:56:49 +0000
Message-ID: <CACPK8XcoJ2O=0RYZy0R=9xHCRne4F4f_3Q1hQYCAmiypepz7yw@mail.gmail.com>
Subject: Re: [PATCH] fsi: occ: Improve response status checking
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Popple <alistair@popple.id.au>,
        Jeremy Kerr <jk@ozlabs.org>
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

On Mon, 31 Jan 2022 at 15:29, Eddie James <eajames@linux.ibm.com> wrote:
>
>
> On 1/30/22 23:56, Joel Stanley wrote:
> > On Mon, 10 Jan 2022 at 15:58, Eddie James <eajames@linux.ibm.com> wrote:
> >> If the driver sequence number coincidentally equals the previous
> >> command response sequence number, the driver may proceed with
> >> fetching the entire buffer before the OCC has processed the current
> >> command. To be sure the correct response is obtained, check the
> >> command type and also retry if any of the response parameters have
> >> changed when the rest of the buffer is fetched.
> >>
> >> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> >> ---
> >>   drivers/fsi/fsi-occ.c | 63 ++++++++++++++++++++++++++++++-------------
> >>   1 file changed, 44 insertions(+), 19 deletions(-)
> >>
> >> diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
> >> index 7eaab1be0aa4..67569282dd69 100644
> >> --- a/drivers/fsi/fsi-occ.c
> >> +++ b/drivers/fsi/fsi-occ.c
> >> @@ -451,6 +451,15 @@ static int occ_trigger_attn(struct occ *occ)
> >>          return rc;
> >>   }
> >>
> >> +static void fsi_occ_print_timeout(struct occ *occ, struct occ_response *resp,
> >> +                                 u8 seq_no, u8 cmd_type)
> >> +{
> >> +       dev_err(occ->dev,
> >> +               "resp timeout status=%02x seq=%d cmd=%d, our seq=%d cmd=%d\n",
> >> +               resp->return_status, resp->seq_no, resp->cmd_type, seq_no,
> >> +               cmd_type);
> >> +}
> >> +
> >>   int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
> >>                     void *response, size_t *resp_len)
> >>   {
> >> @@ -461,12 +470,14 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
> >>          struct occ_response *resp = response;
> >>          size_t user_resp_len = *resp_len;
> >>          u8 seq_no;
> >> +       u8 cmd_type;
> >>          u16 checksum = 0;
> >>          u16 resp_data_length;
> >>          const u8 *byte_request = (const u8 *)request;
> >> -       unsigned long start;
> >> +       unsigned long end;
> >>          int rc;
> >>          size_t i;
> >> +       bool retried = false;
> >>
> >>          *resp_len = 0;
> >>
> >> @@ -478,6 +489,8 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
> >>                  return -EINVAL;
> >>          }
> >>
> >> +       cmd_type = byte_request[1];
> >> +
> >>          /* Checksum the request, ignoring first byte (sequence number). */
> >>          for (i = 1; i < req_len - 2; ++i)
> >>                  checksum += byte_request[i];
> >> @@ -509,30 +522,30 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
> >>          if (rc)
> >>                  goto done;
> >>
> >> -       /* Read occ response header */
> >> -       start = jiffies;
> >> +retry:
> >> +       end = jiffies + timeout;
> >>          do {
> >> +               /* Read occ response header */
> >>                  rc = occ_getsram(occ, 0, resp, 8);
> >>                  if (rc)
> >>                          goto done;
> >>
> >>                  if (resp->return_status == OCC_RESP_CMD_IN_PRG ||
> >>                      resp->return_status == OCC_RESP_CRIT_INIT ||
> >> -                   resp->seq_no != seq_no) {
> >> -                       rc = -ETIMEDOUT;
> >> -
> >> -                       if (time_after(jiffies, start + timeout)) {
> >> -                               dev_err(occ->dev, "resp timeout status=%02x "
> >> -                                       "resp seq_no=%d our seq_no=%d\n",
> >> -                                       resp->return_status, resp->seq_no,
> >> -                                       seq_no);
> >> +                   resp->seq_no != seq_no || resp->cmd_type != cmd_type) {
> > You're testing for two different types of conditions. The first is
> > when the SBE is busy doing something else:
> >
> >                  if (resp->return_status == OCC_RESP_CMD_IN_PRG ||
> >                       resp->return_status == OCC_RESP_CRIT_INIT ||
> >
> > And the others are when the message is not for the current user:
> >
> >                        resp->seq_no != seq_no || resp->cmd_type != cmd_type) {
> >
> > Should we be separating them out? It makes sense that the first means
> > we should keep trying. For the second case should we bail straight
> > away, instead of waiting for the timeout?
>
>
> They're really the same thing actually. If the sequence number or
> command type is incorrect, it means the OCC is processing a different
> command, and we need to wait for it to get to our command.

And we sometimes see one but not the other (ie, the return_status
doesn't cover all cases)?

>
>
> >
> > How often do we see one vs the other?
> >
> >> +                       if (time_after(jiffies, end)) {
> >> +                               fsi_occ_print_timeout(occ, resp, seq_no,
> >> +                                                     cmd_type);
> >> +                               rc = -ETIMEDOUT;
> >>                                  goto done;
> >>                          }
> >>
> >>                          set_current_state(TASK_UNINTERRUPTIBLE);
> >>                          schedule_timeout(wait_time);
> >> +               } else {
> >> +                       break;
> >>                  }
> >> -       } while (rc);
> >> +       } while (true);
> > Use while (true) instead of do { } while (true) to make it clearer
> > what's going on. Or refactor it to put the time_after in the while(),
> > as this is what the loop is waiting on.
>
>
> OK, I went in circles (pun intended) working on this loop, but I'll try
> and make it look better.
>
>
> >
> >>          /* Extract size of response data */
> >>          resp_data_length = get_unaligned_be16(&resp->data_length);
> >> @@ -543,17 +556,29 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
> >>                  goto done;
> >>          }
> >>
> >> -       dev_dbg(dev, "resp_status=%02x resp_data_len=%d\n",
> >> -               resp->return_status, resp_data_length);
> >> -
> >> -       /* Grab the rest */
> >> +       /* Now get the entire response; get header again in case it changed */
> >>          if (resp_data_length > 1) {
> >> -               /* already got 3 bytes resp, also need 2 bytes checksum */
> >> -               rc = occ_getsram(occ, 8, &resp->data[3], resp_data_length - 1);
> >> +               rc = occ_getsram(occ, 0, resp, resp_data_length + 7);
> >>                  if (rc)
> >>                          goto done;
> >> +
> >> +               if (resp->return_status == OCC_RESP_CMD_IN_PRG ||
> >> +                   resp->return_status == OCC_RESP_CRIT_INIT ||
> >> +                   resp->seq_no != seq_no || resp->cmd_type != cmd_type) {
> >> +                       if (!retried) {
> >> +                               retried = true;
> >> +                               goto retry;
> > Not sure about this.
> >
> > How often did this situation come up?
> >
> > Did you consider instead returning an error here?
>
>
> Well I can't say it's frequent, but hitting this condition was what
> drove making this change in the first place. It needs to be handled.

I was concerned about the pattern of using goto back up the function.

Would it make more sense the have the caller retry, instead of adding
retries in the sbefifo driver?

>
> Previously if this occurrred, we got a checksum error, so it effectively
> already returned an error.
>
>
> >
> >> +                       }
> >> +
> >> +                       fsi_occ_print_timeout(occ, resp, seq_no, cmd_type);
> >> +                       rc = -ETIMEDOUT;
> >> +                       goto done;
> >> +               }
> >>          }
> >>
> >> +       dev_dbg(dev, "resp_status=%02x resp_data_len=%d\n",
> >> +               resp->return_status, resp_data_length);
> >> +
> >>          occ->client_response_size = resp_data_length + 7;
> >>          rc = occ_verify_checksum(occ, resp, resp_data_length);
> >>
> >> @@ -598,7 +623,7 @@ static int occ_probe(struct platform_device *pdev)
> >>          occ->version = (uintptr_t)of_device_get_match_data(dev);
> >>          occ->dev = dev;
> >>          occ->sbefifo = dev->parent;
> >> -       occ->sequence_number = 1;
> >> +       occ->sequence_number = (u8)((jiffies % 0xff) + 1);
> > This is interesting. You didn't mention this in the commit message;
> > you're trying to get a random number for the sequence number?
>
>
> Yea, this reduces the chances of hitting that retry above. If it's
> always 1, then every time the driver is bound it tries the first command
> with the same sequence number. This is a problem when FSI scanning with
> the host already running, as the driver gets unbound/rebound several
> times in a row, and we easily hit the checksum problem, since we proceed
> to get the full response even though it's not for the latest command,
> and then the buffer is updated at the same time. So using a non-zero
> random number is very helpful.

Makes sense. Perhaps do something like this instead of hand rolling it?

get_random_bytes(occ->sequence_number, 1);

If you could add some of your explanations to the commit message, I'd
like to get this fix merged soon.

Cheers,

Joel



>
>
> Thanks,
>
> Eddie
>
>
> >
> >>          mutex_init(&occ->occ_lock);
> >>
> >>          if (dev->of_node) {
> >> --
> >> 2.27.0
> >>
