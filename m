Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982AC4E6482
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 14:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350562AbiCXN6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 09:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350718AbiCXN6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 09:58:00 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EF24C427;
        Thu, 24 Mar 2022 06:56:28 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id x8-20020a9d6288000000b005b22c373759so3333349otk.8;
        Thu, 24 Mar 2022 06:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3hu2/w4zk2LRja1m6kxbb1AV3tlPT/cRATwQnTQCk3g=;
        b=gHnJR37/4miZFfBAQ2uQcuryPumOTXNoLULL4lqvQ/9O4aeDa7ABKWco3EPxs0x3hi
         McBGxEFlI5l+jG5L2O1XjjcDV+hILQ+tBAAt+6+NWKa1SGwLwlzBzkhF7RbsxOPO+I0w
         5d0SmDUqpCIJaY9Gmuu0st8SCKXrIpBOfPuUBKeR493KNWRVJQx0dRZlksM708ts1q65
         5VZCWMSBC5XfCn9zw3nzI7psyIPqDwMC6YKbIae8uKorjPMC2Yr/87GgXvHgBt/2+lBD
         IbLEbBQ0BiS7vKaqNORNXcx55TBbI77lCth4HXHPXbAoqUI6QJpw9ASqlT5JEAje8IqV
         bzfA==
X-Gm-Message-State: AOAM530Qe5wrnmbhutW/wZxUPzFDoAH85FLYs/guQljFr6Qm9KPhbOjw
        BzpezIz+hJ87AGtgq8yxMw==
X-Google-Smtp-Source: ABdhPJzA6saZCLeJ/O7iPhpz9VqLML3Yhcc/Zlf/qqvBPu2YEFRUzp5i2fzD5+VZxAbgM6rJADtQoA==
X-Received: by 2002:a9d:5a07:0:b0:5cd:afdb:b0da with SMTP id v7-20020a9d5a07000000b005cdafdbb0damr2127434oth.188.1648130187606;
        Thu, 24 Mar 2022 06:56:27 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j145-20020acaeb97000000b002d9f37166c1sm1409446oih.17.2022.03.24.06.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 06:56:26 -0700 (PDT)
Received: (nullmailer pid 1960215 invoked by uid 1000);
        Thu, 24 Mar 2022 13:56:25 -0000
Date:   Thu, 24 Mar 2022 08:56:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sui Jingfeng <15330273260@189.cn>
Cc:     Qing Zhang <zhangqing@loongson.cn>,
        David Airlie <airlied@linux.ie>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        kernel test robot <lkp@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devicetree@vger.kernel.org, suijingfeng <suijingfeng@loongson.cn>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Roland Scheidegger <sroland@vmware.com>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        dri-devel@lists.freedesktop.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v11 7/7] drm/lsdc: add drm driver for loongson display
 controller
Message-ID: <Yjx4iSkddTNo7q7K@robh.at.kernel.org>
References: <20220321162916.1116541-1-15330273260@189.cn>
 <20220321162916.1116541-8-15330273260@189.cn>
 <Yjo2R5LQrRICr7dC@robh.at.kernel.org>
 <2aa26f44-38aa-4b3c-ccc3-0956a2ab5d77@189.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2aa26f44-38aa-4b3c-ccc3-0956a2ab5d77@189.cn>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 03:32:01PM +0800, Sui Jingfeng wrote:
> 
> On 2022/3/23 04:49, Rob Herring wrote:
> > > +	}
> > > +
> > > +	spin_lock_init(&li2c->reglock);
> > > +
> > > +	snprintf(compat, sizeof(compat), "lsdc,i2c-gpio-%d", index);
> > compatible values shouldn't have an index and you shouldn't need a
> > index in DT. You need to iterate over child nodes with matching
> > compatible.
> 
> Why compatible values shouldn't have an index, does devicetree
> specification prohibit this? [1]

Probably not explicitly, but that's fundamentally not how compatible 
works. 'compatible' defines WHAT the device is, not WHICH device and 
that is used for matching devices to drivers. Drivers work on multiple 
instances.

> The recommended format is "manufacturer,model", where manufacturer is a string describing the name
> of the manufacturer (such as a stock ticker symbol), and model specifies the model number. [1]

I don't see anything saying to put the instance in there, do you?

> 
> [1] https://www.devicetree.org/specifications/
> 
