Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15885584D64
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbiG2I37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234515AbiG2I35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:29:57 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A4659279
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 01:29:56 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-31f56c42ab5so43752807b3.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 01:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a3yGNw5Pw6Un/Uy9wnY0+CD/KjLBxNn7T2gy4eWMRDQ=;
        b=Y365AcNCH/EjT++/AOeD7Uflr2DeWivY8WxyHS2Bgc48yTSVS5EtFvhF3geZSAT+KO
         r4zvCwh2zxZhnZEKsVYvFPs2Dn22uDzwXph/GpiVOlf3f6jXtkyNFGB8+OewDjf/uacQ
         6EKjpqLeu4QUxoT705CthQqPgoKp1A3N5RtyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a3yGNw5Pw6Un/Uy9wnY0+CD/KjLBxNn7T2gy4eWMRDQ=;
        b=SPyZK8a65pHWjUckBSHKuxuTfkplWESMRDSFcTQMh7Or6sLow483p/l/qZB2634XZU
         ND0hfObIrSlCsCXU+58eVog1KwsQP/JNBnEnJZAxLGPb++nWFHGzcnEy4oXKhJ8R2pM2
         GxbKCwqHK/6ax/eMvgbmlv6BsIb7LW+xtC4COWm45HzEx6eBbQCD9oAedVmMSLZA/fnl
         yQpkzsbvmvpmcQ2iMia30YRlthNiDvlWgnnSqfBtsTBYGNvAEl1WcAL4oCTUuHwB84Q+
         CtSDJcV+RVNMcWDVM6+T6AQQhCjDTbNw09BMubLZGpmiMFAPINetP8Pl6MriXr2AJRI1
         lGcw==
X-Gm-Message-State: ACgBeo01vBfVqzog1OKSryifyIIaG8XemUAFrrbd5F8lIVGdzWeauxll
        FqZ2DeeQlohOyt5wHmjWaE/gCdRqNqQ70xpmwomIWQ==
X-Google-Smtp-Source: AA6agR59qG5dD7t/w6jafCVMWrGkaI/L0XhPq5RnedoW5TLTXfaIWVgD+iMkQzGf33GT9VEeWsWnbKSNwbxhs3QBOF8=
X-Received: by 2002:a81:342:0:b0:323:51dd:8277 with SMTP id
 63-20020a810342000000b0032351dd8277mr2170952ywd.420.1659083396148; Fri, 29
 Jul 2022 01:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220729020508.4147751-1-dlunev@chromium.org> <20220729120216.v3.2.Ibf9efc9be50783eeee55befa2270b7d38552354c@changeid>
 <YuOWV5uLVV2JYP1c@kroah.com>
In-Reply-To: <YuOWV5uLVV2JYP1c@kroah.com>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Fri, 29 Jul 2022 18:29:45 +1000
Message-ID: <CAONX=-cy_abLBw1uAEYk6pxmyuQQ4qeQRftZVi7byNuYnEsA+w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ufs: core: print UFSHCD capabilities in
 controller's sysfs node
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>, Can Guo <cang@codeaurora.org>,
        Daejun Park <daejun7.park@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > +What:                /sys/bus/platform/drivers/ufshcd/*/capabilities/clock_scaling
>
> This shouldn't be linked to as a driver file, it's a device file.  So no
> need for this line.
>
> > +What:                /sys/bus/platform/devices/*.ufs/capabilities/clock_scaling
>
> Since when are all ufs devices platform devices?  Do we not have UFS
> controllers on other types of busses?

I have pretty much copped the structure of the entries across this file. Nearly
all of the entries link both device and driver paths and nearly all of
the entries
mention the platform-based path (which you correctly mentioned is not
factually correct, since we do have controllers on the pci bus). Please advise
if it is ok to keep it like this for consistency or what would be the
appropriate
way to adjust the documentation?
--Daniil
