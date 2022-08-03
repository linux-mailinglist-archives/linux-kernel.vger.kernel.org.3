Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3DC588507
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 02:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbiHCAHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 20:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbiHCAHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 20:07:17 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB251C127
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 17:07:16 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id r3so26030026ybr.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 17:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LID6PppF1z9gU+tE6VsSkmWpd5HwGrNeV2dSIOGuA9k=;
        b=Lf18+jbV2UHRV/jigCpNlahlOqXbOsj+3twVjafJ32gIl4GTS+DO55MDRDfIp5+iK9
         jTZvrs/e74OjWNegBJbAS53Ax2qq4oVZ2fZHSp48wqyEJp9zEg6Hr4CnyjK5p95zA6iT
         5VqBLOt+Sw1muSECHxqOVTp/7AmpbucV2yPrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LID6PppF1z9gU+tE6VsSkmWpd5HwGrNeV2dSIOGuA9k=;
        b=zNbbXJaqR9uWSTNCMeIA+jhFFHYPPuNUtw5RsROqs1Ke9Id97GDl/glORnBnjAhemU
         9SjPNgvRrX9hOevVYC9aQKfN5/WrNUPZB5c/V5PEw/xMA48iQfTPdobv8NP3JqDL2BQR
         SaNfqFN2Eg0hDQq3k85vO9ghlpnucFqf1hBQtRcPwZVvlOt8Rx0Dv4AUAGpkdxg/fRUD
         uy9Mup+avirU900HGOF9utksa3LMqCsD74Vp0FWLfJdXYlobDvDi2/o6I9kBuvWwbV51
         MtZqEgiUixtSFsTo9J1GrM1tMCCtO4tUqw3K9U3l5uUJk0/hIRO717+YMVmeE78RFZR7
         XPPg==
X-Gm-Message-State: ACgBeo2Wz6TNnyY+7Calw6Sci1PR+SConu5mRvvDRJnJl/quwx1Da0dp
        Wg3Ntc5/QGAzUVP1FT4yi4R+pxp8x+8/Au57RWHUIg==
X-Google-Smtp-Source: AA6agR6XURFQzTpCJvJlNfHGiJqZ1o8ve0q4LDXLowmGVtIyFzCNGuJhimroNdxvpjpPUyPBIsrvp6/APYPAuEIJ1qY=
X-Received: by 2002:a25:cf91:0:b0:671:83db:c8f9 with SMTP id
 f139-20020a25cf91000000b0067183dbc8f9mr18188088ybg.535.1659485235638; Tue, 02
 Aug 2022 17:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220803074349.v4.1.I699244ea7efbd326a34a6dfd9b5a31e78400cf68@changeid>
 <CAGaU9a8H7QmkhBvNfZhH+CyFaup1oGX1j7a36ph9t+Me3MjCQw@mail.gmail.com>
In-Reply-To: <CAGaU9a8H7QmkhBvNfZhH+CyFaup1oGX1j7a36ph9t+Me3MjCQw@mail.gmail.com>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Wed, 3 Aug 2022 10:07:04 +1000
Message-ID: <CAONX=-cSKdWGAqadzvrdJyZfL+PGOM7V0E1HcHuUny4V00JiUA@mail.gmail.com>
Subject: Re: [PATCH v4] ufs: core: ufshcd: use local_clock() for debugging timestamps
To:     Stanley Chu <chu.stanley@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Please kindly add all Reviewed or Acked tags received in previous
> versions to any newer patches.
Oh, thanks for this suggestion, I didn't know if I should do that. Should
I create a new patch with those brought over?
--Daniil
