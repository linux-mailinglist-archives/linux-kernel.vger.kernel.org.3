Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF035AC635
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 21:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbiIDTjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 15:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiIDTjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 15:39:18 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7362FFD2
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 12:39:17 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 29so3855053edv.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 12:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stonybrook.edu; s=sbu-gmail;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=4ghNav2kIKIBt3QU6iZUN10E/wXCghQzHSR2iVOpt10=;
        b=b/cr4sS+eCMc8AgUN+YAWRss1v0EPAFi00LmwW8UpcY4u3uC1vI3COmD1aZWnhng6h
         s3k6YagsCLtlXZa2tiBqAPshkLr30rHgOAeV5aK++MFBC8BiS0Soa2blQFwUNtt0EY61
         t0TgjfFcwd9+OqT6iQhTGXlpN4m10ndUsdFPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4ghNav2kIKIBt3QU6iZUN10E/wXCghQzHSR2iVOpt10=;
        b=BR+i3axg3ft/4dZmZGhTjirPwrZuHeEGd7NpkxwnKrEzW5FP23gkHmB7LjjZbS1shY
         eq2b2wzaXK+Uru+VnWGq2Q1IXypXEkwrU+pts/2Ui1WeBtte00O7y/tRWmN4GFXQ0vnd
         aBMKXd5py0GmVKxKKBrlstgX/LoyQ6C1Li7aHYK6jyCSN4gsN1nwCvidPxw1wCNOMSJv
         9zqp5vIiTGi2u4DXFMAKCZydBHcEtHIFJlJ7hErTKwM+sx0dHvoDxgUHx2YnLwIFytxG
         19fKxpsNud10BQhjwpLjomwlUeYau9yFz2/kyBLt1WiEt0zqxQRzmf1hA7etDLPucxK8
         ysYg==
X-Gm-Message-State: ACgBeo1OFiuqTEXO+GwAsqllcITC7GCutxPb7N3Pa0WPCwaVm/r2OH52
        4uGQnBc1bWVx46RTUc8CEGSAAmxpMDLyyicab4zBPw==
X-Google-Smtp-Source: AA6agR67sB9aVc+ydN8FHz9obKc1oVcHATjW/BX3+KSidLP4D3TGQCh1gF/h0G36KOp+nM47j4zRzdSEM+VuO7Kdtc8=
X-Received: by 2002:a05:6402:40c3:b0:442:d798:48ad with SMTP id
 z3-20020a05640240c300b00442d79848admr40533402edb.154.1662320356154; Sun, 04
 Sep 2022 12:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220803155315.2073584-1-yifeliu@cs.stonybrook.edu>
 <PH0PR10MB46153A784F27AE96DA69120DF46E9@PH0PR10MB4615.namprd10.prod.outlook.com>
 <513220739.132330.1661149559308.JavaMail.zimbra@nod.at>
In-Reply-To: <513220739.132330.1661149559308.JavaMail.zimbra@nod.at>
From:   Yifei Liu <yifeliu@cs.stonybrook.edu>
Date:   Sun, 4 Sep 2022 15:39:05 -0400
Message-ID: <CABHrer3ho5aAWN4KNSwF3iP=+4uLA1y9-=oF9-GzOwFewzK9Qw@mail.gmail.com>
Subject: Re: [PATCH] jffs2: correct logic when creating a hole in jffs2_write_begin
To:     Richard Weinberger <richard@nod.at>
Cc:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        ezk@cs.stonybrook.edu, madkar@cs.stonybrook.edu,
        David Woodhouse <dwmw2@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kyeong Yoo <kyeong.yoo@alliedtelesis.co.nz>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A gentle reminder.

Best Regards,
Yifei

Best Regards,
Yifei


On Mon, Aug 22, 2022 at 2:26 AM Richard Weinberger <richard@nod.at> wrote:
>
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Joakim Tjernlund" <Joakim.Tjernlund@infinera.com>
> > An: "Yifei Liu" <yifeliu@cs.stonybrook.edu>
> > CC: ezk@cs.stonybrook.edu, madkar@cs.stonybrook.edu, "David Woodhouse" =
<dwmw2@infradead.org>, "richard"
> > <richard@nod.at>, "Matthew Wilcox" <willy@infradead.org>, "Kyeong Yoo" =
<kyeong.yoo@alliedtelesis.co.nz>, "linux-mtd"
> > <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kern=
el.org>
> > Gesendet: Sonntag, 21. August 2022 20:21:04
> > Betreff: Re: [PATCH] jffs2: correct logic when creating a hole in jffs2=
_write_begin
>
> > What happened with this patch? Looks like a important fix but I don't s=
ee it
> > applied ?
>
> It will be part of the next fixes PR after I had a chance to review it.
>
> Thanks,
> //richard
