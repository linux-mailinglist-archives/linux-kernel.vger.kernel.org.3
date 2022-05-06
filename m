Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144F651D211
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389458AbiEFHTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389459AbiEFHT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:19:27 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4521766FA7;
        Fri,  6 May 2022 00:15:44 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id k27so7681014edk.4;
        Fri, 06 May 2022 00:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9vfKT2gRpQrTnojtbWwF7o6GshWWZF1NVl5U/40Uavc=;
        b=mkEw8YjwhNvtqs5VvDHLTJGpez34XPxQO69ieDvgDVT6P7/QiWIDJVyAFBwUBsXlmW
         1SOTQ5LS1zqelJLmmiW35UAuSYeza3MWQ0+GkQ+78uQn/2Gl6U5RLeq5qhNgWvnQc6f0
         t6/JuIoXhNTVpEBtLQ2Kpw7E6wkkozp1N8JHFpVReczkXKZBsua4j2Oob5dC84I6cxIM
         LH9nPRTSB+OE+cT/AlIyo6+G3IxwTzVDBon6gqLij6B4cD7TRuV6ub/Bx/m6q/UydaQn
         2dl+dxZBB3LNFDTP/V6PqVubn99jDHvFZ7QrNCXF5jhkyZxOZHj+QqNb/eeuT2FylJ2d
         8Cpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9vfKT2gRpQrTnojtbWwF7o6GshWWZF1NVl5U/40Uavc=;
        b=lMVbGwwqcJ1TOB4nEzQnTqyuPMP0/zQPbdMdX+qa6DMT0vxkkPZ3XEgjGGkMrhF4x9
         bofpFka01QzcBDGbY59PVfpSVEFSg23dnJ2P266/SYqWBV3grZ/JBxo0592CgweP6XUR
         OgEHm3nc6uvUVCs/iAKEkX0305+eUpyE6jJ0uDIpFRy/DHZvIVxSNCDpE/owtpmWp5Cr
         wJj7tyefxiY1ahLBm3mbkf4godKU1j+1h/meiTXY1AHy3uSYuZdqpI8Ky/0wRVVVKugo
         cioJLNhljCsY/3/jlzb1EIF9SshhfY2NgDJuI0SglE/yB6n5oF2qoidfy5VZeeKB8YKd
         rnwA==
X-Gm-Message-State: AOAM5332IPTWg5Am4GMG1NpeolR5Vuwc0VphfydexVlLeYS/7urnMzc0
        AnyBqfqwTgyxnjt6Aa6LSZ99ic138pxZVPcVHrE=
X-Google-Smtp-Source: ABdhPJylSkLdQdoWiVVFyww5ZJD4XVdJTOAe46BXrtH6fWMpGGhMgYyzgMsMEQzhXkDWKzyNNzA/WKOQ8O/0NclKMbQ=
X-Received: by 2002:a05:6402:2945:b0:41d:aad:c824 with SMTP id
 ed5-20020a056402294500b0041d0aadc824mr2083099edb.364.1651821342697; Fri, 06
 May 2022 00:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220506053740.1113415-1-dzm91@hust.edu.cn> <nycvar.YFH.7.76.2205060852300.28985@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2205060852300.28985@cbobk.fhfr.pm>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Fri, 6 May 2022 15:15:16 +0800
Message-ID: <CAD-N9QUW_FHFAkDq8AYAEXdOL_6wvo0sNGt0Db4dfDRiKaaNCg@mail.gmail.com>
Subject: Re: [PATCH] HID: bigben: fix slab-out-of-bounds Write in bigben_probe
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        syzkaller <syzkaller@googlegroups.com>,
        linux-input@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 6, 2022 at 2:53 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Fri, 6 May 2022, Dongliang Mu wrote:
>
> > From: Dongliang Mu <mudongliangabcd@gmail.com>
> >
> > There is a slab-out-of-bounds Write bug in hid-bigbenff driver.
> > The problem is the driver assumes the device must have an input but
> > some malicious devices violate this assumption.
> >
> > Fix this by checking hid_device's input is non-empty before its usage.
> >
> > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> >  drivers/hid/hid-bigbenff.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/hid/hid-bigbenff.c b/drivers/hid/hid-bigbenff.c
> > index 74ad8bf98bfd..c14d1774101d 100644
> > --- a/drivers/hid/hid-bigbenff.c
> > +++ b/drivers/hid/hid-bigbenff.c
> > @@ -347,6 +347,11 @@ static int bigben_probe(struct hid_device *hid,
> >       bigben->report = list_entry(report_list->next,
> >               struct hid_report, list);
> >
> > +     if (list_empty(&hid->inputs)) {
> > +             hid_err(hid, "no inputs found\n");
> > +             return -ENODEV;
> > +     }
> > +
>
> Thanks for the fix. It doesn't seemt o be fully correct though -- as you'd
> be returning -ENODEV here in the situation when hid_hw_start() has already
> happened. So I believe better thing to do here is to do error = -ENODEV;
> goto error_hw_stop;
>
> Could you please fix that up and resend? Thanks,

Oh, yes. I will send a v2 version ASAP.
>
> --
> Jiri Kosina
> SUSE Labs
>
