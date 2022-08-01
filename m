Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF2B587365
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 23:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbiHAVbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 17:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235381AbiHAVae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 17:30:34 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B5922BE0
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 14:29:30 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-31f56c42ab5so122245687b3.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 14:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BJhneIs24eJv4ukierhtqacrrE32PmvIZRJVAVZL+KU=;
        b=i7PDO41unYnFJQoVscy3Nu89f90rGxroCFDcTvi/H7u+L9k1OuxQYEpW8vJALQy9sb
         DWLoIfoVnuCby8ibe6ZxfCqBNW7NE84+9VadRx+x8hOA2ZjDaEJZocgRkX1SNVS/i/IQ
         /bp7FrkWXo7dKxoBcEPFJuCjYG8G+Dse+pQjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BJhneIs24eJv4ukierhtqacrrE32PmvIZRJVAVZL+KU=;
        b=rZaIlmGCEVFwAdnoNPuVQ/hbiF6p5oymcf0QtWcElMAFBrVnf8XfU+W2lKzwBecISS
         mRH2MVqippSIipK9pU05vz57nm3/IfngjL++0OhN1nDkhvFr+Eqmdk8SmbnSpvoaqo/c
         CE4FS4QcHyQVZCzdZD7Sn4brqIkFnwlRxsiKlVA4YsjLY8R/6RtB9liobYzOAVrHqntg
         JdeoyQbiPWiIf4K7qN+Sm6PrMZRsJZzdTWNFwxIUgCI9/Qhu9IuntCSR1UjAtotymazv
         WLGDm7mbbsD5OG7GhaJ91jfUSaKLZ9Hn1iYbFzvO/Cbo5g1OPtEs1bFFJMyYgfQIRMFv
         nbwg==
X-Gm-Message-State: ACgBeo1H+Q3xTp2O7+MzitZPzHVBEnm4pAbsqvxzzTaIUt07c+rncUiH
        2wdAUS6bLpRd3uZK5ziyLQ7PGNirngjlxgrze4HLIA==
X-Google-Smtp-Source: AA6agR6WmFz3ErZkaFdpehjCddleiWEdMhQ6+XEtTrZxM9pG0247rhhM7LZWBLuBSKnW1ZHSCYb+K6Up5wrjjCV/7ew=
X-Received: by 2002:a0d:cb0b:0:b0:322:6f04:9262 with SMTP id
 n11-20020a0dcb0b000000b003226f049262mr14681907ywd.224.1659389369472; Mon, 01
 Aug 2022 14:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220729151301.v4.1.Ibf9efc9be50783eeee55befa2270b7d38552354c@changeid>
 <1ca16b27-21e5-3537-400a-25cdae52396e@acm.org>
In-Reply-To: <1ca16b27-21e5-3537-400a-25cdae52396e@acm.org>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Tue, 2 Aug 2022 07:29:18 +1000
Message-ID: <CAONX=-eknyxTsM21gW6ruaCoov3oJB12g871Wmiq+ibDm4QZCA@mail.gmail.com>
Subject: Re: [PATCH v4] ufs: core: print UFSHCD capabilities in controller's
 sysfs node
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>, Can Guo <cang@codeaurora.org>,
        Daejun Park <daejun7.park@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
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

HI Bart
> The above sentence is not complete. Did you perhaps want to write "are
> supported by the host controller" instead of "status"?
Will fix it in the next version.

> I don't think the above documentation is correct. My understanding is
> that the UFSHCD_CAP_CLK_SCALING flag indicates whether or not the host
> controller supports clock scaling. It does not indicate whether or not
> clock scaling is enabled.
Ah, right, there is a control for it in sysfs, it is just hidden in
ufshcd.c I was under
a wrong impression that it is like the writebooster capability that
has quite a bit of
conditions for staying present. WIll fix it in the next version.

> Please change "can not / can be enabled" into "is not supported by the
> host controller / is supported by the host controller".
That would be incorrect. The "caps" variable semantics is a bit weird
in the sense
that it is used at times to convey "active" capabilities, not just
supported one. For
example, for the writebooster capability to be present in caps, first
controller driver
should indicate it is ready to support it, then the part that is
attached to the host
controller has to indicate support in the device descriptor, then WB has to be
configured and its lifetime should not be exhausted. If any of those parameters
are not satisfied, the capability will be removed from the set despite generally
being supported. I am not sure how to properly word it, but just
saying "controller
supports it" would becounter-factual (especially since the controller
doesn't really
knows anything about writebooster per-ce, it is part's functionality).
What would
be suggested wording in that case?

--Daniil
