Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652A05625C2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 23:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237590AbiF3V5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 17:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237271AbiF3V5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 17:57:20 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840E057202
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 14:57:19 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id p69so499508iod.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 14:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uzqzvWO6xI/qzQaupX8bR5RZnWn3d58v4IG2QCKmwHU=;
        b=cp8cJwDcdlIbomiWQnFrZ0zwWFTVLazFVXI9gdwCIChyn9hDeQcQuW3vUFX9EAWT7k
         2TW+xOpgM3F6JLXd8gFEF3LngmCK9kVVELiF/EIxzxrTe+J79hoEpjvda8fH4zpMMADe
         Qvnp9rK6AUyKhgRRM5RG2QgH2ibAgpc3/0lLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uzqzvWO6xI/qzQaupX8bR5RZnWn3d58v4IG2QCKmwHU=;
        b=3xFOLdYaHS+J8yKA/eZVdWvmJuqDGyy1Hcwjebs9iVi8Kw3MMCPx4ZZfbAg7/B1Og4
         QiDHdZ//NdVDGQK9EIUbtziWKl+6Tqt59CCw+Mx47YD++ZAe8TRu4hctBWY5FaGdJbw/
         LCBBAoAKGZeqy7b8hKv+owjLyWgoawDZP6D79q2APCeiRcO11uIpEjqFpgrUQY+4KBpa
         t/dVEbKwwVSiwUr0ufzSX6joEf7HA1AXo5XsI4G90aX+B5K8uUKJ0lo3uRjV2tIMZ7mg
         ooVUURT5Bi+53mveWwIE8Cr3Jr6A3Rw4wHhEMLmGqq7ekX7ONW7ymwTEcFRLPSGHnKlV
         g/5Q==
X-Gm-Message-State: AJIora/Rs4wzQBnBU/bCVtlu7aigW+ZYHG4oLuVfFKDM5S44VrPvkkTJ
        Kf6WA0HRW8wsQrUJZR8ru5zSQY82skwqpwiNTTY=
X-Google-Smtp-Source: AGRyM1tUL8zN21bd4oxAY1oy51yAqVw2lXpHYl0QZ4Lo+bdx7fb5BZTyIusGqenYAJKN+5FLP67ALA==
X-Received: by 2002:a05:6638:2386:b0:33c:ba9c:73cb with SMTP id q6-20020a056638238600b0033cba9c73cbmr6634840jat.208.1656626238889;
        Thu, 30 Jun 2022 14:57:18 -0700 (PDT)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com. [209.85.166.46])
        by smtp.gmail.com with ESMTPSA id s19-20020a02cf33000000b00332044db2aasm9186062jar.95.2022.06.30.14.57.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 14:57:18 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id l24so482651ion.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 14:57:17 -0700 (PDT)
X-Received: by 2002:a6b:b74e:0:b0:675:594e:140d with SMTP id
 h75-20020a6bb74e000000b00675594e140dmr5851331iof.154.1656626237471; Thu, 30
 Jun 2022 14:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <1656496841-5853-1-git-send-email-quic_vnivarth@quicinc.com>
 <Yr26oSKOhIBMaKsS@kroah.com> <BL0PR02MB45646DE7D61E648321E9FBB5FABA9@BL0PR02MB4564.namprd02.prod.outlook.com>
In-Reply-To: <BL0PR02MB45646DE7D61E648321E9FBB5FABA9@BL0PR02MB4564.namprd02.prod.outlook.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 30 Jun 2022 14:57:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UAqNMbsed2QX0iK6hpZzh-k3VJ4PvzXxXSTD-uTtURJA@mail.gmail.com>
Message-ID: <CAD=FV=UAqNMbsed2QX0iK6hpZzh-k3VJ4PvzXxXSTD-uTtURJA@mail.gmail.com>
Subject: Re: [V2] tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which
 otherwise could return a sub-optimal clock rate.
To:     "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "konrad.dybcio@somainline.org" <konrad.dybcio@somainline.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mukesh Savaliya (QUIC)" <quic_msavaliy@quicinc.com>,
        "mka@chromium.org" <mka@chromium.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 30, 2022 at 10:19 AM Vijaya Krishna Nivarthi (Temp) (QUIC)
<quic_vnivarth@quicinc.com> wrote:
>
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Thursday, June 30, 2022 8:31 PM
> > To: Vijaya Krishna Nivarthi (Temp) (QUIC) <quic_vnivarth@quicinc.com>
> > Cc: agross@kernel.org; bjorn.andersson@linaro.org;
> > konrad.dybcio@somainline.org; jirislaby@kernel.org; linux-arm-
> > msm@vger.kernel.org; linux-serial@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Mukesh Savaliya (QUIC)
> > <quic_msavaliy@quicinc.com>; dianders@chromium.org;
> > mka@chromium.org; swboyd@chromium.org
> > Subject: Re: [V2] tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which
> > otherwise could return a sub-optimal clock rate.
> >
> > WARNING: This email originated from outside of Qualcomm. Please be wary
> > of any links or attachments, and do not enable macros.
> >
> > On Wed, Jun 29, 2022 at 03:30:41PM +0530, Vijaya Krishna Nivarthi wrote:
> > > In the logic around call to clk_round_rate(), for some corner
> > > conditions,
> > > get_clk_div_rate() could return an sub-optimal clock rate. Also, if an
> > > exact clock rate was not found lowest clock was being returned.
> > >
> > > Search for suitable clock rate in 2 steps
> > > a) exact match or within 2% tolerance
> > > b) within 5% tolerance
> > > This also takes care of corner conditions.
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> >
> > Did the test robot really report the original issue, or just the v2 change?
> >
> > thanks,
> >
> > greg k-h
>
> Test robot raised error for v1 patch and (I think) it got addressed in v2 with call to div_u64.
> V2 doesn't have this error but other warnings which I am addressing along with other feedback.
> Below is the error raised for v1.

I think the adding of the "Reported-by" only really makes sense if the
commit landed and then you fixed the robot-reported bug in a separate
commit. If it reported problems in v1 and you fix them in v2 you
shouldn't add the tag.

-Doug
