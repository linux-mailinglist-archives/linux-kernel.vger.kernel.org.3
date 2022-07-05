Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64082566373
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 08:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiGEGyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 02:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiGEGyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 02:54:12 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D1265A8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 23:54:11 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2ef5380669cso99182387b3.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 23:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Queo7cdMLBRpaTu5Sc/SmhVPDMVL0zH+Ng8A8pwNRLQ=;
        b=VsGity2DdqDD8LwLxtEJyw86QtfSDZXELPdE4X6pHWq42zwWUJmxrFw5N2IfMG26xd
         qIqzK98T3R4rYXJ7HcesTzkxmTKnXyhrcL1S2oh59kxFIrQhEfGQVfPLsGFUTFlWd1un
         ss/tKq0JP1YQLSzqLN/1agR5bLV+navkqOOwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Queo7cdMLBRpaTu5Sc/SmhVPDMVL0zH+Ng8A8pwNRLQ=;
        b=BhyQaUjUxYUpG8219e2Bp1zaLyNn7O8geKALWioIMf25GYGZz2S8WCd7K8LYi4xxj1
         7X837KmAHcIJmanS+cOoFupKdeivj6dhpzbKQ34Tw7qkwzQjXHhFwX81WDW8J1nqZy27
         /X5m8FotrbZWiN7nRfeFtVKbE36HhGBp9uFyHBvjWnfBDKmFNvzl1kU4Ybm1PN217whb
         M7FDj86Yz+m6YF716WkPLjBuJ1hyMtLBNDeWp2KpYYGMNY3C53Gqu0JnNbP9isbH8sw+
         Kjbq4GT1pXyKcxanJi3Epftvdr7oW1/R84hDr6SNoPpTZWUEBfwG21GzAgADjgbcPxZd
         Sr0A==
X-Gm-Message-State: AJIora9mJ0GBImJhdlmu+uXTVZ2lgyLc6fpudWGLVX4CGUdvKBnFALbQ
        SM4CeVQvveiKq2j6wuYWhVr8kOBedDnxOGb0I1rSNA==
X-Google-Smtp-Source: AGRyM1uYahqfKP3lgPn/sQ8wD9kpteYhZ+/WekxkCP8fq6Mfa5wNY9A0kgr97SUsb0jkUqgAtR/7KRXQXxlbxysGCJM=
X-Received: by 2002:a81:c8b:0:b0:31c:7d90:ff0d with SMTP id
 133-20020a810c8b000000b0031c7d90ff0dmr19629109ywm.266.1657004050457; Mon, 04
 Jul 2022 23:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220704092721.1.Ib5ebec952d9a59f5c69c89b694777f517d22466d@changeid>
 <fd3bb4b5-0a19-2dc0-c4b5-60f32abce508@acm.org>
In-Reply-To: <fd3bb4b5-0a19-2dc0-c4b5-60f32abce508@acm.org>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Tue, 5 Jul 2022 16:53:59 +1000
Message-ID: <CAONX=-e+4+92aY=g-_Y-8PZmk1ALkrj7BDADKaSDE9fNJfR96A@mail.gmail.com>
Subject: Re: [PATCH] scsi: ufs: ufs-pci: Enable WriteBooster capability on ADL
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Bart.
Sent v2 patch with the commit message fixed.
--Daniil

On Mon, Jul 4, 2022 at 1:00 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 7/3/22 16:28, Daniil Lunev wrote:
> > Sets the WrtieBooster capability flag when ADL's UFS controller is used.
>             ^^^^^^^^^^^^
> WriteBooster?
>
> Otherwise this patch looks fine to me.
>
> Thanks,
>
> Bart.
