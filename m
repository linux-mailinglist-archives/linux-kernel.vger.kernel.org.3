Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA0A5A9AC9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbiIAOqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbiIAOqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:46:36 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669107B2A0;
        Thu,  1 Sep 2022 07:46:35 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id z3-20020a17090abd8300b001fd803e34f1so2660369pjr.1;
        Thu, 01 Sep 2022 07:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date;
        bh=Aj4r5E6rkm0XNz95hikZXTW9i8eRGWs/XyBJ9bH2gRE=;
        b=fXWZWsKC852E/3aiFapF8mjBc5SqOCZ8CmgT6DhOxlVE+CcWavYkfVy/z+IqpZOZ84
         O5ZGA1F4Lyo9lwPTltndZHjr4b7HCm0xeCZvUWDsA+3xJgQf+WyttX+ODIf96ItpGRa4
         231L3faWieAFU5sfNrrm2mhDwfCEYKr37nyd+9wIgMmEU7XyqsgXpEFHyuNR8vZAaUfZ
         lcekvGmOLfQhRKBJc+2Beu+Nwkh+OYauTQxI4CkAaY0lMNVW88M4hwXS2nDD/Za36FCr
         dz3+vgDeDOkqPVHy2TeMh7jGdJPWhSrjhCWp4dSIFg/Zf8rqkNlKhnTIJtKIdKnyP3Rk
         B/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Aj4r5E6rkm0XNz95hikZXTW9i8eRGWs/XyBJ9bH2gRE=;
        b=fkKPSWbaZczxOw1HewlcA8w/PgZeqBdQehlroNbvdOsTa61Te5kiouIEt22UYQqKq6
         IEGUAeqGlCcDJzeJRVzDb4X4VjGdLp8MupQGmGx4C/UT0oBmuuL/9zuQlawdbuFTeSmm
         AbblvRiTFziUePoruuzWnQv6e9F9ulbm16Zej40jpMjt38JDwqq2w95xrqn6yJpxdMEh
         PmL/EuvpODGCB25n54BM7NG/TrvGsZSbzsrw3sCjEdz88PNEhtLlGcecXfLhdy73/RHN
         ksHNdpVLbAY0pEg6+CM21IG7XX2YML+FrK2kCGNy4v9qV9E/Jpch+0z2pDyvHxmXb4IE
         9N4Q==
X-Gm-Message-State: ACgBeo3XJ4QReEQ1jmIThMD+zmnI8vtsLR/MDsvK8fPmO9r28SJZ7lcU
        dSbdhWo2s6sLaR8dTA8A7HM=
X-Google-Smtp-Source: AA6agR5WP8KTJjNBu/m+BXw9amb36hWxEejlt5C+y0bEvXRgn1+Wqz7BqmwKKE2N2h4TrbLmOPz64w==
X-Received: by 2002:a17:90a:6783:b0:1fd:ab56:5af7 with SMTP id o3-20020a17090a678300b001fdab565af7mr9268903pjj.39.1662043594779;
        Thu, 01 Sep 2022 07:46:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jf9-20020a170903268900b00174f43129fbsm7565777plb.47.2022.09.01.07.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 07:46:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 1 Sep 2022 07:46:33 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Farber, Eliav" <farbere@amazon.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>, jdelvare@suse.com,
        robh+dt@kernel.org, p.zabel@pengutronix.de, rtanwar@maxlinear.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, ronenk@amazon.com,
        itamark@amazon.com, shellykz@amazon.com, shorer@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com, dkl@amazon.com
Subject: Re: [PATCH v3 19/19] hwmon: (mr75203) fix coding style space errors
Message-ID: <20220901144633.GC3477025@roeck-us.net>
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-20-farbere@amazon.com>
 <Yw9Q5krebHnb73vC@smile.fi.intel.com>
 <0074475d-04bc-153a-2df8-dd5f7d014c97@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0074475d-04bc-153a-2df8-dd5f7d014c97@amazon.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 05:21:43PM +0300, Farber, Eliav wrote:
> On 8/31/2022 3:15 PM, Andy Shevchenko wrote:
> > On Tue, Aug 30, 2022 at 07:22:12PM +0000, Eliav Farber wrote:
> > > Fix: "ERROR: space required before the open parenthesis '('"
> > 
> > This patch may have other fixes like adding new blank lines (noted in one
> > of the patches in the series), etc.
> This patch fixed a specific space error which existed before my changes
> and repeated many time.
> I fixed the blank line I added a previous patch (but is it isn’t an error
> reported by checkpatch).

That should really be fixed where it was introduced, not be introduced
and fixed here.

Guenter
