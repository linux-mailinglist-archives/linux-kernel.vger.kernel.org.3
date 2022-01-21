Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D718B4961A0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381436AbiAUO4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:56:23 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4439 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbiAUO4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:56:15 -0500
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JgMrX6rGQz67JXs;
        Fri, 21 Jan 2022 22:55:56 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 21 Jan 2022 15:56:13 +0100
Received: from localhost (10.47.75.29) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Fri, 21 Jan
 2022 14:56:12 +0000
Date:   Fri, 21 Jan 2022 14:56:09 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Cristian Pop <cristian.pop@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/2] one-bit-adc-dac: Add initial version of one bit
 ADC-DAC
Message-ID: <20220121145609.00005fa7@Huawei.com>
In-Reply-To: <CAHp75VeakSDtDfGO1tcZKgoJ0KTAHgYMKG1v=cYDSHoc-zLUbw@mail.gmail.com>
References: <20220111115919.14645-1-cristian.pop@analog.com>
        <20220111115919.14645-2-cristian.pop@analog.com>
        <20220116115228.1f7b4728@jic23-huawei>
        <CAHp75VeakSDtDfGO1tcZKgoJ0KTAHgYMKG1v=cYDSHoc-zLUbw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.75.29]
X-ClientProxiedBy: lhreml702-chm.china.huawei.com (10.201.108.51) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jan 2022 19:06:20 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Jan 17, 2022 at 8:41 AM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Tue, 11 Jan 2022 13:59:19 +0200
> > Cristian Pop <cristian.pop@analog.com> wrote:  
> 
> > > +     st->labels = devm_kzalloc(device, sizeof(*st->labels) * child_num, GFP_KERNEL);
> > > +     if (!st->labels)
> > > +             return -ENOMEM;
> > > +
> > > +     i = child_num;
> > > +     fwnode_for_each_child_node(fwnode, child) {
> > > +             if (fwnode_property_read_u32(child, "reg", &crt_ch))
> > > +                     continue;
> > > +
> > > +             if (crt_ch >= num_channels)
> > > +                     continue;
> > > +
> > > +             if (fwnode_property_read_string(child, "label", &label))
> > > +                     continue;
> > > +
> > > +             chan = &channels[crt_ch];  
> > ? Not used.
> >  
> > > +             st->labels[--i] = label;  
> 
> > I've no idea how this works...  Should be looking for the chan->channel
> > value as that's what your read uses to index.  
> 
> It's an implicit memcpy().

Not that.  What I don't follow is how it ends up in the right element of
st->labels[] seeing as i has nothing to do with reg which should
be the channel number.  Far as I can see it's setting the labels
in a random order.

Jonathan

> 
> > > +     }
> > > +
> > > +     return 0;
> > > +}  
> 
> 
> 

