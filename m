Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBB058E1A9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 23:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiHIVRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 17:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiHIVQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 17:16:46 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68194C619
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 14:16:45 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-31f443e276fso124597997b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 14:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=oLnzvgiiApV3VWlzq6jRPE1yUvY8BFpXJK7uuRxPViY=;
        b=fayvEf5WdJjEIxnfSI2fgWunYKmTvDIRKtCzVSQkNKwFu8iJI+08U9BhoICiNt7cl4
         COv9Dx86ZsTmY1ghlFRFjOitQNyuyzZdaorSLwfGmQz1IYyEPHSPFNzosVnoGsXxujcG
         uB4Brcz2j+CfN+vXjtrM/9QS7wD7nd3789kOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=oLnzvgiiApV3VWlzq6jRPE1yUvY8BFpXJK7uuRxPViY=;
        b=EN17ccXQNU2uUXHu8XH/FFeJDrIIIl+O6io0KNWtNt/sX+x9hiTlFIB6UD5U/SAgxM
         A226q4S5gZrklYoAm8JsTA4FY0VPIbdwZL7eNwuXhFFoIZwWPIIv0yC83fZoOenVmS7T
         9luh6N+DO8to8+NK99SAYeRxrWWvOCNCXJhnBA2I5WxAkh5HF6NZvMkh6wLUKuyiXx8O
         s6RXRTvimcQ1mO7341MEpk46EOKr4aRva/W1vBQLbu1xfvKaB98srQwv04pmOMJxl+AS
         qA2nGHLGqlTvbuYegLLjMhUvX/MBUZ3+g2vIp+umPeeh+tKbfo7ZNdZ4o2v9PWEbBrj0
         HIow==
X-Gm-Message-State: ACgBeo3HVN0yi3xTO5oDTBqgubQzQwfaaENLdwgVY+8I/DlQJrvxiaxn
        7o8OUW+8dAUDObwnf+HyM8QG0Wx/18AqiCqxm+sPxA==
X-Google-Smtp-Source: AA6agR6qo0VuTK0himSt+FUyEOvT/ZelIHR1bqwnVqgzBc/13WFe04zeW+Up8BNE3369loXSWZ3IzSFjH9Qmynp4wuk=
X-Received: by 2002:a81:5d07:0:b0:329:8fb8:779 with SMTP id
 r7-20020a815d07000000b003298fb80779mr15696137ywb.77.1660079805095; Tue, 09
 Aug 2022 14:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220803074955.v6.1.Ibf9efc9be50783eeee55befa2270b7d38552354c@changeid>
 <YuoRuP2pxgSQ6c9E@kroah.com> <CAONX=-f8kHWCEEyqUdpn5wsyMZKa4eJSSCLvPDn3R5mQF9FSMA@mail.gmail.com>
In-Reply-To: <CAONX=-f8kHWCEEyqUdpn5wsyMZKa4eJSSCLvPDn3R5mQF9FSMA@mail.gmail.com>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Wed, 10 Aug 2022 07:16:34 +1000
Message-ID: <CAONX=-eL02see4m6wK74cX2D6rUXJXtZYSRiNhPQVDsS8kU27g@mail.gmail.com>
Subject: Re: [PATCH v6] ufs: core: print UFSHCD capabilities in controller's
 sysfs node
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Are there any more amendments you would want me to make or is it good to go?

Thanks,
Daniil


On Wed, Aug 3, 2022 at 4:34 PM Daniil Lunev <dlunev@chromium.org> wrote:
>
> > Why is this information not also in the Documentation/ABI/ entries as
> > well?
> How would you want me to word it in there? For each entry? There
> will be more in the future, would we need to just copy it as a
> boilerplate? Bart suggested it be added in the code, do you see
> a good way to mention the same in the doc?
> Thanks,
> --Daniil
