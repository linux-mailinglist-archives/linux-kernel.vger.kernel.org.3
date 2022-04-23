Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC96850CCE9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 20:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbiDWSnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 14:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236723AbiDWSnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 14:43:13 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F26CBFF;
        Sat, 23 Apr 2022 11:40:15 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id k29so9976792pgm.12;
        Sat, 23 Apr 2022 11:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oCklF2yoxZCY1XnxHvvymqN9ilVJP2+R7BKxhLkZkTw=;
        b=bzx0PWe4xvlkCobnNAw8fa/476zJ+b36tEhDczfhFr/dKfa9liKOelXyyYcCjCcVa7
         R9tNStyVkIqSrTgo8GaqlCmtrSeV5/3n60Qly4yU8oFM4vRq3UExya+dDF+Cvy1Vw2b8
         KkrxodqZm+qUjpvUFM5HDijhnACQbj7ASYovOu0V2fB+GEzVxOL+AOQ141iDbuvoAn5J
         SXfNQmBPyJzRnK1ipDibkmbWcoB48lkVBcY71aNWsCHaxExJfpeU0ipBYVf8Zx5g09EF
         21F9iI/07llP4phOfrAtV/Jr0qHrXobrH5oojfnxC+OsQGnMFnkli+rM74SquhkVfSt7
         vOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oCklF2yoxZCY1XnxHvvymqN9ilVJP2+R7BKxhLkZkTw=;
        b=gnHNPoD4ChJ7A8jpnoSnY26C+h1gBi4OAw4Co8hAPAVl1zLFOTMOpca8dnWTxceb49
         UEd5QMpdxu4W6UWExFJuGZk58AticF7zuevnoEqTCNeeP11vUI98EVE4JejTjd79uJDo
         YDBey7YqILjDwolojECa/dP6wdexmvMarleEspSKfAajacKG9O5KloIDPiqhGiDoEKnQ
         uZK2vWfZVZCAUTxVFphObW7KV+I894/nH4hvNRTcq2s9FBqVwS2HGFR351uUQmgCRZVr
         JGbSFBXmSLMD8WFWL5fBUnLAhIR4PSo3HhVHRSVOtPOookLXyJNJJ4m2haLlbi/HFmzN
         EH7A==
X-Gm-Message-State: AOAM530NDNZGPrfe0l1WQ1v9nUOPcTIDbr9K7brnb10DxGRvDb5W3rLR
        WICBTZz4dCu6DERoYFzJtbMjZsW7tEUObIeLjI0=
X-Google-Smtp-Source: ABdhPJwaBQfxHFW6qUKlr2aLItzQqy/pmBMTiDqMglHEnNx7MrH+/o9SzVwiHy6Unh7Zx6ANdiRWu3E9TTU/dF+0Otc=
X-Received: by 2002:a05:6a00:1818:b0:50a:dfc5:9ed4 with SMTP id
 y24-20020a056a00181800b0050adfc59ed4mr11123724pfa.70.1650739214868; Sat, 23
 Apr 2022 11:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220422120240epcms2p24bdcb416becf76b417f7c39006aa40f2@epcms2p1>
 <1891546521.01650629881201.JavaMail.epsvc@epcpadp4> <f426fa45-7d72-52ad-8557-0027bca84194@acm.org>
In-Reply-To: <f426fa45-7d72-52ad-8557-0027bca84194@acm.org>
From:   jin young choi <ychoijy@gmail.com>
Date:   Sun, 24 Apr 2022 03:40:03 +0900
Message-ID: <CAM36TBt_2wPjbnXsQPZLgf18FckdC9qbj9ErFgDLZ-0xUQ_Oig@mail.gmail.com>
Subject: Re: [PATCH] scsi: ufs: wb: Add Manual Flush sysfs and cleanup toggle functions
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     j-young.choi@samsung.com, ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> On 4/22/22 05:14, Jinyoung CHOI wrote:
> > There is the following quirk to bypass "WB Manual Flush" in Write
> > Booster.
> >
> >    - UFSHCD_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL
> >
> > If this quirk is not set, there is no knob that can controll "WB Manual Flush".
> >
> >       There are three flags that control Write Booster Feature.
> >               1. WB ON/OFF
> >               2. WB Hibern Flush ON/OFF
> >               3. WB Flush ON/OFF
> >
> >       The sysfs that controls the WB was implemented. (1)
> >
> >       In the case of "Hibern Flush", it is always good to turn on.
> >       Control may not be required. (2)
> >
> >       Finally, "Manual flush" may be determined that it can affect
> >       performance or power consumption.
> >       So the sysfs that controls this may be necessary. (3)
> >
> > In addition, toggle functions for controlling the above flags are cleaned.
>
> Please make all sentences in the patch description start at the left margin.
>

OK. I'll fix it. :)

> > diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
> > index 5c405ff7b6ea..6bbb56152708 100644
> > --- a/drivers/scsi/ufs/ufs-sysfs.c
> > +++ b/drivers/scsi/ufs/ufs-sysfs.c
> > @@ -229,7 +229,7 @@ static ssize_t wb_on_store(struct device *dev, struct device_attribute *attr,
> >                * If the platform supports UFSHCD_CAP_CLK_SCALING, turn WB
> >                * on/off will be done while clock scaling up/down.
> >                */
> > -             dev_warn(dev, "To control WB through wb_on is not allowed!\n");
> > +             dev_warn(dev, "To control Write Booster is not allowed!\n");
> >               return -EOPNOTSUPP;
> >       }
>
> The new error message is grammatically incorrect. Please fix.
>

OK. I'll fix it. :)

> > +     if (!ufshcd_is_wb_flush_allowed(hba)) {
> > +             dev_warn(dev, "To control WB Flush is not allowed!\n");
>
> Same issue for the above error message.
>
> > +static DEVICE_ATTR_RW(wb_flush_on);
>
> "wb_flush_enabled" is probably a better name than "wb_flush_on".
> Additionally, the "wb_flush_en" is closer to the terminology used in the
> UFS specification (fWriteBoosterBufferFlushEn).
>

'wb_on' sysfs already existed. So I named it in the same format. (_on)
I'll change both. (_on -> _enable)

>  > diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
>  > index 4a00c24a3209..6c85f512f82f 100644
>  > --- a/drivers/scsi/ufs/ufs.h
>  > +++ b/drivers/scsi/ufs/ufs.h
>  > @@ -611,7 +611,7 @@ struct ufs_dev_info {
>  >
>  >      /* UFS WB related flags */
>  >      bool    wb_enabled;
>  > -    bool    wb_buf_flush_enabled;
>  > +    bool    wb_flush_enabled;
>  >      u8      wb_dedicated_lu;
>  >      u8      wb_buffer_type;
>
> Adding a variable with the name "wb_flush_enabled" next to a variable with
> the name "wb_buf_flush_enabled" is confusing. Please chose better names and
> add comments.
>

Hmm... it would be better not to modify the variable name.
I'll put it back

> > -static int __ufshcd_wb_toggle(struct ufs_hba *hba, bool set, enum flag_idn idn)
> > +static int __ufshcd_wb_toggle(struct ufs_hba *hba, const char *knob,
> > +                           bool set, enum flag_idn idn)
> >   {
> > +     int ret;
> >       u8 index;
> >       enum query_opcode opcode = set ? UPIU_QUERY_OPCODE_SET_FLAG :
> > -                                UPIU_QUERY_OPCODE_CLEAR_FLAG;
> > +             UPIU_QUERY_OPCODE_CLEAR_FLAG;
> > +
> > +     if (!ufshcd_is_wb_allowed(hba))
> > +             return -EPERM;
> >
> >       index = ufshcd_wb_get_query_index(hba);
> > -     return ufshcd_query_flag_retry(hba, opcode, idn, index, NULL);
> > +
> > +     ret = ufshcd_query_flag_retry(hba, opcode, idn, index, NULL);
> > +     if (ret) {
> > +             dev_err(hba->dev, "%s: %s %s failed %d\n",
> > +                     __func__, knob, set ? "enable" : "disable", ret);
> > +             return ret;
> > +     }
> > +
> > +     dev_dbg(hba->dev, "%s: %s %s\n",
> > +              __func__, knob, set ? "enabled" : "disabled");
> > +
> > +     return ret;
> >   }
>
> Please leave out the dev_dbg() message and move the dev_err() message to
> the callers of __ufshcd_wb_toggle() such that the 'knob' argument does not
> have to be added to __ufshcd_wb_toggle().
>
> Thanks,
>
> Bart.

OK. I got it.
Regarding this review, I wrote a comment on avri's comment.

Thanks,
Jinyoung
