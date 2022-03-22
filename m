Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658BD4E47A6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 21:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbiCVUkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 16:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbiCVUkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:40:17 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6DA69293;
        Tue, 22 Mar 2022 13:38:49 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KNNYv3qvVz687Yd;
        Wed, 23 Mar 2022 04:36:35 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Tue, 22 Mar 2022 21:38:47 +0100
Received: from localhost (10.47.75.191) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 22 Mar
 2022 20:38:46 +0000
Date:   Tue, 22 Mar 2022 20:38:44 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Stephen Boyd <swboyd@chromium.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH] iio:proximity:sx9324: Fix hardware gain read/write
Message-ID: <20220322203844.0000466f@Huawei.com>
In-Reply-To: <CAE-0n52jDZz0qKhfg8OWVDmDg5+xXo-qSL3jNka82QHwA2-xsw@mail.gmail.com>
References: <20220318204808.3404542-1-swboyd@chromium.org>
        <20220319152641.49d8b3e1@jic23-huawei>
        <CAE-0n52jDZz0qKhfg8OWVDmDg5+xXo-qSL3jNka82QHwA2-xsw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.75.191]
X-ClientProxiedBy: lhreml742-chm.china.huawei.com (10.201.108.192) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2022 19:36:33 +0100
Stephen Boyd <swboyd@chromium.org> wrote:

> Quoting Jonathan Cameron (2022-03-19 08:26:41)
> > On Fri, 18 Mar 2022 13:48:08 -0700
> > Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Hi Stephen,
> >
> >  
> > > There are four possible gain values according to sx9324_gain_vals[]: 1,
> > > 2, 4, and 8. When writing and reading the register the values are off by
> > > one.
> > > The bits should be set according to this equation:
> > >
> > >       ilog2(<gain>) + 1
> > >
> > > so that a gain of 8 is 0x3 in the register field and a gain of 4 is 0x2
> > > in the register field, etc. Fix up the functions.  
> >
> > So is the 0 value reserved?  I can't find an sx9324 datasheet but he
> > 9320 is online and that seems to be the case there.  If so please state
> > that in this description as well.  
> 
> Yes 0 is reserved. The top of this driver's C file has the datasheet
> link[1]
Ah. Thanks ;)

> 
> >  
> > >
> > > Fixes: 4c18a890dff8 ("iio:proximity:sx9324: Add SX9324 support")
> > > Cc: Gwendal Grignou <gwendal@chromium.org>
> > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > > ---
> > >  drivers/iio/proximity/sx9324.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> > > index 0d9bbbb50cb4..a3c8e02f5a56 100644
> > > --- a/drivers/iio/proximity/sx9324.c
> > > +++ b/drivers/iio/proximity/sx9324.c
> > > @@ -379,7 +379,10 @@ static int sx9324_read_gain(struct sx_common_data *data,
> > >       if (ret)
> > >               return ret;
> > >
> > > -     *val = 1 << FIELD_GET(SX9324_REG_PROX_CTRL0_GAIN_MASK, regval);
> > > +     regval = FIELD_GET(SX9324_REG_PROX_CTRL0_GAIN_MASK, regval);
> > > +     if (regval)  
> >
> > If 0 is reserved then I'd return and error code here to indicate
> > we don't know what the gain is rather than carrying on regardless.
> > Or is this going to cause problems as it will be an ABI change (error
> > return possible when it wasn't really before)?
> >  
> 
> That sounds OK to me. The driver is only being introduced now so we can
> still fix it to reject a gain of 0. Unless 0 should mean "off", i.e.
> hardware gain of 1?
No.  I don't think we want to add that sort of fiddly definition.
So error is the way to go - I'd forgotten we only just introduced this
so no ABI breakage risk.


Jonathan

> 
> [1] https://edit.wpgdadawant.com/uploads/news_file/program/2019/30184/tech_files/program_30184_suggest_other_file.pdf

